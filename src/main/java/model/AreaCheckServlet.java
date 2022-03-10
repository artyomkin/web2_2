package model;

import com.google.gson.Gson;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/areaCheck")
public class AreaCheckServlet extends HttpServlet {

    ServletContext servletContext;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        long startTime = System.currentTimeMillis();

        String xValues = req.getParameter("x");
        String yValues = req.getParameter("y");
        String RValues = req.getParameter("R");
        String asyncParam = req.getParameter("async");
        if (asyncParam == null){
            req.getRequestDispatcher("view/error.jsp").forward(req,resp);
            return;
        }
        Boolean async = asyncParam.equals("true");
        double x = Double.parseDouble(xValues);
        double y = Double.parseDouble(yValues);
        double R = Double.parseDouble(RValues);
        boolean xError = x < -2 || x > 5;
        boolean yError = y < -3 || y > 5;
        boolean RError = R < 1 || R > 5;

        if(xError || yError || RError || async == null){
            req.getRequestDispatcher("view/error.jsp").forward(req,resp);
            return;
        }
        servletContext = getServletContext();
        ArrayList<Dot> dots = (ArrayList<Dot>) servletContext.getAttribute("dots");

        if(dots==null){
            dots = new ArrayList<>();
        }

                        //first quarter      //hit
                boolean hit =
                        (x >= 0 && y >= 0 && y <= R/2 && x <= R) ||
                        //third quarter    //hit
                        (x < 0 && y <= 0 && -2 * x + -R < y) ||
                        (x > 0 && y < 0 && x * x + y * y <= R * R/4);

                Dot dot = new Dot(x,y,R,hit);
                dots.add(dot);


        long workingTime = System.currentTimeMillis() - startTime;

        Calendar calendar = Calendar.getInstance();
        int hours = calendar.get(Calendar.HOUR_OF_DAY);
        int minutes = calendar.get(Calendar.MINUTE);
        int seconds = calendar.get(Calendar.SECOND);

        String currentTime = hours + ":" + minutes + ":" + seconds;

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        ServletContext servletContext = getServletContext();
        servletContext.setAttribute("dots", dots);
        if(async){
            Response response = new Response(dots, workingTime, currentTime);
            Gson gson = new Gson();
            String JSONResponse = gson.toJson(response);
            resp.getWriter().print(JSONResponse);
        } else {
            req.getRequestDispatcher("view/tableResults.jsp").forward(req,resp);
        }
    }

}
