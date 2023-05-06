<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>


<f:view>
    <html>
    <title>DBLogin</title>
    <head> Login</head>
    <body>
    <form action='/loginCheck' method='POST' target='_self'>
        <label for='username'>Username / Email</label><br>
        <input type='text' id='username' name='username'><br>
        <label for='password'>Password</label><br>
        <input type='text' id='password' name='password'><br>

        <input type='submit' value='Submit'>


    </form>
    </body></html>
</f:view>
