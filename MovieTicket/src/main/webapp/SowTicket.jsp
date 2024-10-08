<%@ page import="java.sql.*, java.util.*, java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Movie Booking</title>
    <link rel="stylesheet" href="showticket.css">
</head>
<body>
    <div class="container">
        <h1>Ticket Details</h1>
        </div>
<%
    String mobileNumber = request.getParameter("mobileNumber");

    // Database connection settings
    String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    String username = "movie";
    String password = "1111";

    // SQL query to retrieve user details
    String query = "SELECT * FROM BOOKINGS WHERE id = ?";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Random random = new Random();

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, mobileNumber);
        rs = pstmt.executeQuery();
        
        int ticketNumber = 1;

        if (rs.next()) {
            String date = rs.getString("booking_date");
            String movieName = rs.getString("movie_name");
            String time = rs.getString("show_time");
            String seat = rs.getString("seat_number");
            String category = rs.getString("ticket_category");
            String pnr = String.format("%08d", random.nextInt(100000000));
%>
            <div class="container">
                <div class="ticket-header">Ticket #<%= ticketNumber %></div>
                <div class="user-info"><strong>Date:</strong> <%= date %></div>
                <div class="user-info"><strong>Movie Name:</strong> <%= movieName %></div>
                <div class="user-info"><strong>Time:</strong> <%= time %></div>
                <div class="user-info"><strong>Seat No:</strong> <%= seat %></div>
                <div class="user-info"><strong>Category:</strong> <%= category %></div>
                <div class="ticket-info"><strong>PNR:</strong> <%= pnr %></div>
            </div>
<%
        } else {
%>
            <div class="container">
                <div class="header">No Results Found</div>
            </div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>


