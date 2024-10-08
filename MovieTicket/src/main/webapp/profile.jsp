<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Movie Booking</title>
    <link rel="stylesheet" href="profile.css">
</head>
<body>
    <div class="container">
        <h1>Ticket Details</h1>
        </div>
<%
    String phone_number = request.getParameter("phone_number");

    // Database connection settings
    String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    String username = "movie";
    String password = "1111";

    // SQL query to retrieve user details
    String query = "SELECT * FROM USERS WHERE phone_number = ?";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, phone_number);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String date = rs.getString("username");
            String movieName = rs.getString("phone_number");
            String time = rs.getString("full_name");
%>
            <div class="container">
                <div class="header">User Details</div>
                <div class="user-info"><strong>User Name:</strong> <%= date %></div>
                <div class="user-info"><strong>Phone Number:</strong> <%= movieName %></div>
                <div class="user-info"><strong>Full Name:</strong> <%= time %></div>
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


