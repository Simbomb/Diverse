<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<f:view>

    <html>

    <title>Speedrunning.net!</title>
    <p style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Logged in as: ${username}</p>
    <head><h1 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">SpeedRunning Menu!</h1></head>
    <body style="background-color: #3f3f3f;; font-family: Arial; color: #333;" onload="table()">
    <br>
    <h2 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">${catagory}</h2>
    <br>
    <h2 id="demo"></h2>
    <div id="post">
    <table style="min-width:auto; border:2px solid #000; background-color: #fff;">
        <thead>
        <tr>
            <th style="border: 1px solid #000; background-color: #ccc;">Name</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Link</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Time</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Date</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Verified</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="column" items="${posts}">
            <c:choose>
            <c:when test="${column.verified==true ||isAdmin}">
            <tr>
                <td style="border: 1px solid #000;">${column.name}</td>
                <td style="border: 1px solid #000;"><a style="text-decoration: none; color: #333;" href="${column.link}">${column.link}</a></td>
                <td style="border: 1px solid #000;">${column.time}</td>
                <td style="border: 1px solid #000;">${column.date}</td>
                <c:choose>
                    <c:when test="${isAdmin}">
                        <c:choose>
                            <c:when test="${column.verified==false}">
                                <td style="border: 1px solid #000;">${column.verified}
                                    <form action='/catagoryVerified' method='POST' target='_self'>
                                        <button type="submit" style="background-color: #ccc; border: 1px solid #000; color: #333;" name="verified" value="${column.id}">Verify</button>
                                    </form>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td style="border: 1px solid #000;">${column.verified}</td>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <td style="border: 1px solid #000;">${column.verified}</td>
                    </c:otherwise>
                </c:choose>
            </tr>
            </c:when>
            </c:choose>
        </c:forEach>


        </tbody>
    </table>
    </div>
    <form action='/upload' method='POST' target='_self'>
        <label for="link" style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;"> Link to your speedrun</label><br>
        <input type="text" name="link" id="link" style="border: 1px solid #000;"><br>
        <label for="time" style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">  Speedrun Time[Format: HH:MM:SS]</label><br>
        <input type="text" name="time" id="time" style="border: 1px solid #000;"><br>
        <input type='submit' value='Submit' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>

    <h3 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Go back to main menu!</h3>
    <form action='/main' method='POST' target='_self'>
        <input type='submit' value='Back' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>

    </body></html>
</f:view>