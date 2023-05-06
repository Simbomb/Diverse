<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<f:view>

    <html>

    <title>Speedrunning.net!</title>
    <p style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Logged in as: ${username}</p>
    <head><h1 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">SpeedRunning Forum!</h1></head>
    <body style="background-color: #3f3f3f;; font-family: Arial; color: #333;" onload="table()">
    <br>
    <h2 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Forum</h2>
    <br>
    <h2 id="demo"></h2>
    <script>

       var time = setInterval( function()
        {
            reloadPage();
        }, 15000);


        function reloadPage() {
            window.location.reload();
        }
    </script>


    <div id="post">
        <table style="min-width:auto; border:2px solid #000; background-color: #fff;">
            <thead>
            <tr>
                <th style="border: 1px solid #000; background-color: #ccc;">Head</th>
                <th style="border: 1px solid #000; background-color: #ccc;">Comment</th>
                <th style="border: 1px solid #000; background-color: #ccc;">Name</th>
                <th style="border: 1px solid #000; background-color: #ccc;">Add comment</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="column" items="${forum}">
                        <tr>
                            <td style="border: 1px solid #000;">${column.head}</td>
                            <td style="border: 1px solid #000;">${column.comment}</td>
                            <td style="border: 1px solid #000;">${column.name}</td>
                            <td style="border: 1px solid #000;">
                                <form action='/comment' method='POST' target='_self'>
                                    <input type="text" name="comment" onclick="clearInterval(time)" onfocusout="reloadPage()" id="comment" style="border: 1px solid #000;"><br>
                                    <input type="hidden" onclick="clearInterval(time)" onfocusout="reloadPage()" name="head" value="${column.head}">
                                    <input type='submit' value='Submit' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
                                </form>


                            </td>
                        </tr>

            </c:forEach>


            </tbody>
        </table>
    </div>




    <h3 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Go back to main menu!</h3>
    <form action='/main' method='POST' target='_self'>
        <input type='submit' value='Back' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>

    </body></html>
</f:view>