<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login Result</title>
    <link rel="stylesheet" href="AdminHandler.css">
</head>
<body>
    <div class="container">
        
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Database connection settings
            String url = "jdbc:oracle:thin:@localhost:1521:orcl";
            String dbUsername = "movie";
            String dbPassword = "1111";

            // SQL query to retrieve admin details
            String query = "SELECT * FROM admins WHERE username = ? AND password = ?";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    out.println("<h2>Login Successful!</h2>");
                    out.println("<a href='adminmain.jsp'>Go to Admin Dashboard</a>");
                } else {
                    out.println("<h2>Invalid Username or Password. Please try again.</h2>");
                    out.println("<a href='adminLogin.jsp'>Try Again</a>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (conn != null) try { conn.close(); } catch (SQLException e) { }
            }
        %>
    </div>
</body>
</html>
