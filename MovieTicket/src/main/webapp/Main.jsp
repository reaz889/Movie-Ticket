<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Movie Booking</title>
    <link rel="stylesheet" href="main.css">
</head>
<body>
    <header>
        <a href="HomePage.html">Home</a>
        <a href="tickets.html">Search Ticket</a>
        <a href="profile.html">Profile</a>
    </header>
    <div class="container">
        <h1>Book Your Movie Ticket</h1>
        <form action="Book.jsp" method="post">
        
			<label> Mobile Number:</label><br><br>
			<input type="text" name="id" value=""><br><br>
        
            <label for="date">Select Date:</label>
            <input type="date" id="date" name="date" required><br>

            <label for="movie">Movie Name:</label>
            <select id="movie" name="movie">
                <option value="Movie1">Movie1</option>
                <option value="Movie2">Movie2</option>
                <!-- Add other movies as options -->
            </select><br>

            <label for="showtime">Show Time:</label>
            <select id="showtime" name="showtime">
                <option value="10:00 AM">10:00 AM</option>
                <option value="01:00 PM">01:00 PM</option>
                <option value="04:00 PM">04:00 PM</option>
                <option value="07:00 PM">07:00 PM</option>
            </select><br>

            <label for="seat">Select Seat:</label>
            <select id="seat" name="seat">
                <% for (int i = 1; i <= 30; i++) { %>
                    <option value="<%= i %>">Seat <%= i %></option>
                <% } %>
            </select><br>

            <label for="category">Select Ticket Category:</label>
            <select id="category" name="category">
                <option value="VIP">VIP</option>
                <option value="Regular">Regular</option>
            </select><br>

            <button type="submit">Book Ticket</button>
        </form>
    </div>
</body>
</html>

