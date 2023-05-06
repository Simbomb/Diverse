<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<f:view>
    <html>
    <title>DBLogin</title>
    <head> <h1 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Login</h1></head>
    <body style="background-color: #3f3f3f;">
    <form action='/loginCheck' method='POST' target='_self'>
        <label for='username' style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Username / Email</label><br>
        <input type='text' id='username' name='username'><br>
        <label for='password' style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Password</label><br>
        <input type='text' id='password' name='password'><br>

        <input type='submit' value='Submit' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">


    </form>
    <br>
    <h2 style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Create Account</h2>
    <form action='/saveUser' method='POST' target='_self'>
        <label for='cusername' style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Username / Email</label><br>
        <input type='text' id='cusername' name='username'><br>
        <label for='cpassword' style="color: #8BB5E5; font-weight: bold; text-shadow: 2px 2px #000000;">Password</label><br>
        <input type='text' id='cpassword' name='password'><br>
        <input type='submit' value='Submit' style="background-color: #3f3f3f; color: #8BB5E5; font-weight: bolder; border: 2px solid #8BB5E5; border-radius: 5px; cursor: pointer; transition: 0.3s; box-shadow: 2px 2px #000000;" onmouseover="this.style.backgroundColor='#8BB5E5'; this.style.color='#3f3f3f';" onmouseout="this.style.backgroundColor='#3f3f3f'; this.style.color='#8BB5E5';">
    </form>


    </body></html>
</f:view>