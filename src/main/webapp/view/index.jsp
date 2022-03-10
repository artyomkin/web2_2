<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored = "false" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
</head>
<header>
    <div class="content">
        <div class="header_wrapper">

            <div class="left">

                <span class="name">Колосков Алексей и Андронова Мария</span>
                <span class="group">P33212</span>
                <span class="variant">Вариант 31060</span>

            </div>

            <div class="right">

                <span class="hidden">Текущее время -<span id="current_time"></span></span>
                <br>
                <span class="hidden"> Время работы скрипта -<span id="working_time"></span>мкс</span>

            </div>

        </div>
    </div>
</header>

<body>

<div class="content">
    <div class="content_wrapper">
        <div class="left">
            <div class="coordinates">
                <form method="GET" action="controller" id="coordinates_form">

                    <div class="field">
                        <span>Выберите X</span>
                        <div class="option">
                            <input type="radio" name="x" id="x-4" class="x required number" value="-4"> <label for="x-4">-4</label>
                            <input type="radio" name="x" id="x-3" class="x required number" value="-3"> <label for="x-3">-3</label>
                            <input type="radio" name="x" id="x-2" class="x required number" value="-2"> <label for="x-2">-2</label>
                            <input type="radio" name="x" id="x-1" class="x required number" value="-1"> <label for="x-1">-1</label>
                            <input type="radio" name="x" id="x0" class="x required number" value="0"> <label for="x0">0</label>
                            <input type="radio" name="x" id="x1" class="x required number" value="1"> <label for="x1">1</label>
                            <input type="radio" name="x" id="x2" class="x required number" value="2"> <label for="x2">2</label>
                            <input type="radio" name="x" id="x3" class="x required number" value="3"> <label for="x3">3</label>
                            <input type="radio" name="x" id="x4" class="x required number" value="4"> <label for="x4">4</label>
                        </div>
                        <span class="error_message"></span>

                    </div>

                    <div class="field">

                        <br>
                        <label for="y">Введите Y</label>
                        <input name="y" type="text" id="y" class="required number" maxlength="10">
                        <span class="error_message"></span>

                    </div>

                    <div class="field">

                        <br>
                        <label for="R">Введите R</label>
                        <select name="R" id="R">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                        </select>
                        <span class="error_message"></span>

                    </div>
                    <input name="async" type="hidden" id="hidden_async" value="false">
                    <br>
                    <input type="submit" value="Нажать" id="submit_request">

                </form>
            </div>
        </div>

        <div class="right">
                <canvas id="graph" width="500px" height="500px">
                </canvas>
        </div>
    </div>

    <div class="table">
        <table>
            <thead>
            <td class="top left">x</td>
            <td class="top">y</td>
            <td class="top">R</td>
            <td class="top right">Попадание</td>
            </thead>

            <tfoot>
            <td class="left bot"></td>
            <td class="bot"></td>
            <td class="bot"></td>
            <td class="right bot"></td>
            </tfoot>

            <tbody id="results">
            <c:forEach var="result" items="${applicationScope.get('dots')}">
                <tr class="result_row">
                    <td class="left x_result"><fmt:formatNumber type="number" value="${result.getX()}" maxFractionDigits="2"></fmt:formatNumber></td>
                    <td class="y_result"><fmt:formatNumber type="number" value="${result.getY()}" maxFractionDigits="2"></fmt:formatNumber></td>
                    <td class="R_result"><c:out value="${result.getR()}"></c:out></td>
                    <td class="right hit_result"><c:out value="${result.isHit()}"></c:out></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</div>
</body>

<script src="Result.js"></script>
<script src="script.js"></script>

<style>

    * {
        padding: 0;
        margin: 0;
        font-family: "fantasy";
    }

    .content {
        max-width: 1000px;
        margin: auto;
    }

    header {
        background-color: #335e89;
        padding: 20px 50px 20px 50px;
        font-weight: 600;
    }

    .header_wrapper {
        display: flex;
        justify-content: space-between;
    }

    .header_wrapper span {
        margin: 0 30px 0 30px;
        color: #8aa3bd;
    }

    body {
        background-color: rgba(231, 235, 255, 0.63);
        padding-bottom: 100px;
    }

    body .content_wrapper {
        display: flex;
        justify-content: center;
        padding-top: 100px;
    }

    body .content_wrapper .left,
    body .content_wrapper .right {
        width: 50%;
        display: flex;
        justify-content: center;
    }

    .chart {
        width: 350px;
        height: 350px;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
    }

    .chart .axises {
        width: 350px;
        height: 350px;
        display: flex;
        justify-content: center;
        position: relative;
    }

    .chart .axis {
        position: relative;
    }

    .chart .line {
        width: 2px;
        height: 100%;
        background-color: #8aa3bd;
        position: absolute;
    }

    .chart .arrow {
        width: 10px;
        height: 10px;
        border-top: 2px solid #8aa3bd;
        border-left: 2px solid #8aa3bd;
        transform: rotate(45deg);
        position: absolute;
        margin-left: -5px;
    }

    .chart .x_axis {
        transform: rotate(90deg);
    }

    .chart .marks_wrapper {
        position: absolute;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .chart .outer_marks {
        height: 80%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .chart .inner_marks {
        height: 50%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .chart .coordinate {
        width: 30px;
        font-size: 12px;
        margin-left: 5px;
    }

    .chart .x_axis .coordinate {
        transform: rotate(-90deg);
    }

    .chart .serif {
        width: 10px;
        height: 2px;
        background-color: #335e89;
        margin-left: -4px;
    }

    .chart .mark {
        display: flex;
    }

    .chart .top_mark {
        align-items: flex-start;
    }

    .chart .bot_mark {
        align-items: flex-end;
    }

    .chart .circle {
        width: 20%;
        height: 20%;
        background-color: #335e89;
        position: absolute;
        z-index: -1;
        transform: translate(49.5%, 50%);
        border-radius: 0 0 100% 0;
        opacity: 0.12;
    }

    .chart .triangle {
        width: 20%;
        height: 40%;
        background-color: #335e89;
        position: absolute;
        z-index: -1;
        transform: translate(-50%, 50%);
        opacity: 0.12;
    }

    .chart .triangle::after {
        content: "";
        position: absolute;
        border: 100px solid #e7ebff;
        border-top: 200px solid transparent;
        border-right: 0 solid transparent;
    }

    .chart .rectangle {
        width: 40%;
        height: 20%;
        background-color: #335e89;
        position: absolute;
        z-index: -1;
        transform: translate(50%, -50%);
        opacity: 0.12;
    }

    .content_wrapper .left {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
    }

    .content_wrapper .left form {
        display: flex;
        flex-direction: column;
    }

    .content_wrapper .coordinates {
        width: 80%;
        margin: auto;
    }

    .content_wrapper .left input[type="text"] {
        max-width: 300px;
        border: none;
        border-radius: 5px;
        margin-top: 20px;
        height: 40px;
        padding-left: 10px;
    }

    .content_wrapper .left input[type="text"]:focus {
        border: none;
        outline: none;
        background-color: #d9e1f1;
    }

    .content_wrapper .left input[type="submit"] {
        border: none;
        border-radius: 5px;
        height: 50px;
        width: 150px;
        margin-top: 20px;
        margin-left: 80px;
        background-color: #335e89;
        color: #8aa3bd;
        font-weight: bold;
        transition: .2s;
    }

    .content_wrapper .left input[type="submit"]:hover {
        background-color: white;
        cursor: pointer;
        transition: .2s;
    }

    .content_wrapper .left input[type="submit"]:active {
        background-color: #e3f9f5;
        cursor: pointer;
        color: #335e89;
        transition: .2s;
    }

    .content_wrapper .field {
        display: flex;
        flex-direction: column;
    }

    .table {
        max-width: 400px;
        min-width: 250px;
        margin-left: 570px;
        margin-top: 50px;
    }

    table {
        border-collapse: collapse;
        border: 2px solid #335e89;
        width: 100%;
    }

    table td {
        padding: 15px;
        text-align: center;
        border: 1px solid #335e89;
    }

    table .top {
        border-top: none;
    }

    table .bot {
        border-bottom: none;
    }

    table .left {
        border-left: none;
    }

    table .right {
        border-right: none;
    }

    .error {
        box-shadow: 0 0 30px #335e89;
    }

    .error_message {
        margin-top: 10px;
        margin-left: 10px;
        font-size: 13px;
        height: 10px;
    }

    .table .pagination {
        width: 80%;
        margin: 20px auto auto auto;
        display: flex;
        justify-content: space-between;
        font-size: 13px;
    }

    .table .pagination span {
        transition: .2s;
    }

    .hidden {
        display: none;
    }

    .table .pagination span:hover {
        cursor: pointer;
        color: #335e89;
        transition: .2s;
    }

    #dots {
        position: absolute;
        width: 80%;
        height: 80%;
    }

    #dots .dot {
        width: 6px;
        height: 6px;
        border-radius: 100%;
        position: absolute;
        transform: translate(-50%, -50%);
    }

    #dots .green_dot {
        background-color: green;
    }

    #dots .red_dot {
        background-color: red;
    }


</style>
<script type="text/javascript" charset="UTF-8">
    <%@ include file="Result.js"%>
    <%@ include file="graph.js" %>
    <%@ include file="graphObserver.js"%>
    <%@ include file="script.js" %>

    <c:forEach var="result" items="${applicationScope.get('dots')}">

    drawDot(
        calculatePercentage(<c:out value="${result.getX()}"></c:out>, <c:out value="${result.getR()}"></c:out>),
        calculatePercentage(-1 * <c:out value="${result.getY()}"></c:out>, <c:out value="${result.getR()}"></c:out>),
        <c:out value="${result.isHit()}"></c:out>
    );
    </c:forEach>

</script>

</html>