<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <html>
    <p style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Logged in as: ${username}</p>
    <head><h1 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Speedruns by ${player}!</h1></head>
    <body style="background-color: #3f3f3f;; font-family: Arial; color: #333;">
    <br>
    <table style="min-width:auto; border:2px solid #000; background-color: #fff;">
        <thead>
        <tr>
            <th style="border: 1px solid #000; background-color: #ccc;">Name</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Link</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Time</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Date</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Verified</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Catagory</th>
            <th style="border: 1px solid #000; background-color: #ccc;">Delete?</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="column" items="${posts}">
            <tr>
                <td style="border: 1px solid #000;">${column.name}</td>
                <td style="border: 1px solid #000;"><a style="text-decoration: none; color: #333;" href="${column.link}">${column.link}</a></td>
                <td style="border: 1px solid #000;">${column.time}</td>
                <td style="border: 1px solid #000;">${column.date}</td>
                <td style="border: 1px solid #000;">${column.verified}</td>
                <td style="border: 1px solid #000;">${column.catagory}</td>
            <c:choose>
                <c:when test="${username.equals(column.name) || isAdmin}">
                    <td style="border: 1px solid #000;">
                        <form action='/deletePost' method='POST' target='_self'>
                            <button type="submit" style="background-color: #ccc; border: 1px solid #000; color: #333;" name="id" value="${column.id}">Delete Post</button>
                        </form>
                    </td>>
                </c:when>
            </c:choose>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <h3 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Go back to main menu!</h3>
    <form action='/main' method='POST' target='_self'>
        <input type='submit' value='Back' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>


    </body></html>
</f:view>