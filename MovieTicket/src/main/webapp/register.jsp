<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Signup Process</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String phoneNumber = request.getParameter("phonenumber");
    String fullName = request.getParameter("fullname");
    String password = request.getParameter("password");
    String retypePassword = request.getParameter("retypepassword");

    if (!password.equals(retypePassword)) {
        out.println("<h2>Passwords do not match!</h2>");
        out.println("<a href='register.html'>Password Does Not Match Go back to Signup</a>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");

        String sql = "INSERT INTO users (username, phone_number, full_name, password) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, phoneNumber);
        pstmt.setString(3, fullName);
        pstmt.setString(4, password);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            out.println("<h2>Registration Successful!</h2>");
            out.println("<a href='Login.html'>Go to Login</a>");
        } else {
            out.println("<h2>Registration Failed. Please try again.</h2>");
        }
    } catch (SQLException e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
    
    
%>
</body>
</html>
