<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
</head>
<body>
<%
    String date = request.getParameter("date");
    String movie = request.getParameter("movie");
    String showtime = request.getParameter("showtime");
    String seat = request.getParameter("seat");
    String category = request.getParameter("category");
    String id = request.getParameter("id");

    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");

        String sql = "INSERT INTO bookings (booking_date, movie_name, show_time, seat_number, ticket_category, id) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        pstmt.setDate(1, new java.sql.Date(sdf.parse(date).getTime()));
        pstmt.setString(2, movie);
        pstmt.setString(3, showtime);
        pstmt.setInt(4, Integer.parseInt(seat));
        pstmt.setString(5, category);
        pstmt.setString(6,id);

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            out.println("<h2>Booking Confirmed!</h2>");
            
        } else {
            out.println("<h2>Booking Failed. Please try again.</h2>");
        }
    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="Main.jsp">Go Back</a>
</body>
</html>

