<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<f:view>
    <html>
    <title>Speedrunning.net!</title>
    <p style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Logged in as: ${username}</p>
    <h2 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;"> SpeedRunning Menu!</h2>
    <body style="background-color: #3f3f3f;">
    <h2 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Select your actions below!</h2>
    <br>
    <c:forEach var="column" items="${differentCategories}">

        <form action='/catagory' method='POST' target='_self'>
            <input type="submit" name="catagory" value="${column.categoryName}" style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
        </form>
    </c:forEach>
    <br>
    <form action='/playerlist' method='POST' target='_self'>
        <p style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Search for a player</p><br>
        <input type="text" name="player">
        <input type="submit" value="Submit" style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>
    <c:choose>
        <c:when test="${isAdmin}">
            <form action='/addCatagory' method='POST' target='_self'>
                <p style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Create a new catagory:</p><br>
                <input type='text' id='catagory' name='catagory'><br>
                <input type="submit" value="Submit" style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
            </form>
        </c:when>
    </c:choose>

    <form action='/forum' method='POST' target='_self'>
        <input type='submit' value='Forum' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>

    <h3 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Go back to login page!</h3>
    <form action='/login' method='POST' target='_self'>
        <input type='submit' value='Back' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>




    </body></html>
</f:view>