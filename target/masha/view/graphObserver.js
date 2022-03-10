
document.addEventListener("DOMContentLoaded", function(){

    let graph = document.getElementById("graph");
    let boundingClientRect = graph.getBoundingClientRect();

    let xLeft = boundingClientRect.left;
    let yTop = boundingClientRect.top

    let width = graph.offsetWidth;
    let height = graph.offsetHeight;
    let R;
    const GRAPH_SIZE = 500;

    graph.addEventListener("click", calculateHit);

    function calculateHit(event){

        event.preventDefault();

            let x = event.pageX - width/2 - xLeft;
            let y = -1 * (event.pageY - width/2 - yTop);
            sendForm(x,y,getRadius());


    }
    function sendForm(x,y,R){
        x = x/(GRAPH_SIZE/2) * R;
        y = y/(GRAPH_SIZE/2) * R;
        let content = "x=" + x + "&y=" + y + "&R=" + R + "&async=true";
        let request = new XMLHttpRequest();

        request.open('GET','controller?' + content);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.send();
        request.onreadystatechange=function(){
            if (request.readyState === XMLHttpRequest.DONE && request.status == 200){
                let response = JSON.parse(request.response);
                let dots = response.dots;
                let workingTime = response.workingTime;
                let currentTime = response.currentTime;
                for (let i = 0; i<dots.length; i++){
                    drawDot(
                        calculatePercentage(dots[i].x, dots[i].R),
                        calculatePercentage(-dots[i].y, dots[i].R),
                        dots[i].hit
                    );
                }
                document.querySelector("#results").append(createResultRow(
                    dots[dots.length-1].x,
                    dots[dots.length-1].y,
                    dots[dots.length-1].R,
                    dots[dots.length-1].hit
                ));
                setWorkingTime(workingTime);
                setCurrentTime(currentTime);
            }
        }
    }

    function getRadius(){
         let result = Number(document.getElementById("R").value);
         return result;
    }


    function calculatePercentage(n, R){

        let percentage = 50 + n/R * 100 * 0.5;

        if(percentage > 90) {
            percentage = 90
        } else if (percentage < 6){
            percentage = 6
        }
        return percentage;
    }

    function setWorkingTime(workingTime){
        let workingTimeTag = document.querySelector('#working_time');
        workingTimeTag.innerHTML = workingTime;
    }

    function setCurrentTime(currentTime){
        let currentTimeTag = document.querySelector('#current_time');
        currentTimeTag.innerHTML = currentTime;
    }


    function createResultRow(x,y,R,hit){
        let resultRow = document.createElement("tr");
        let xTag = document.createElement("td");
        xTag.classList.add("left");
        xTag.classList.add("x_result");
        xTag.innerHTML = x.toString();

        let yTag = document.createElement("td");
        yTag.classList.add("y_result");
        yTag.innerHTML = y.toString();

        let RTag = document.createElement("td");
        RTag.classList.add("R_result");
        RTag.innerHTML = R.toString();

        let hitTag = document.createElement("td");
        hitTag.classList.add("hit_result");
        hitTag.classList.add("right")
        hitTag.innerHTML = hit;

        resultRow.append(xTag);
        resultRow.append(yTag);
        resultRow.append(RTag);
        resultRow.append(hitTag);

        return resultRow;
    }

})