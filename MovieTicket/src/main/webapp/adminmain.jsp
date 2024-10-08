<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Main Page</title>
    <link rel="stylesheet" href="adminMain.css">
</head>
<body>
    <header>
        <a href="HomePage.html">Home</a>
    </header>
    
    <div class="container">
        <h1>Admin Dashboard</h1>
        
        <!-- Search User Form -->
        <div class="section">
            <h2>Search User</h2>
            <form action="adminmain.jsp" method="post">
                <label for="searchUser">Mobile Number:</label>
                <input type="text" id="searchUser" name="searchUser" required>
                <button type="submit">Search</button>
            </form>
        </div>

        <!-- Delete User Form -->
        <div class="section">
            <h2>Delete User</h2>
            <form action="adminmain.jsp" method="post">
                <label for="deleteUser">Mobile Number:</label>
                <input type="text" id="deleteUser" name="deleteUser" required>
                <button type="submit">Delete</button>
            </form>
        </div>

        <!-- Search Ticket Form -->
        <div class="section">
            <h2>Search Ticket</h2>
            <form action="adminmain.jsp" method="post">
                <label for="searchTicket">Mobile Number:</label>
                <input type="text" id="searchTicket" name="searchTicket" required>
                <button type="submit">Search</button>
            </form>
        </div>

        <!-- Delete Ticket Form -->
        <div class="section">
            <h2>Delete Ticket</h2>
            <form action="adminmain.jsp" method="post">
                <label for="deleteTicket">Mobile Number:</label>
                <input type="text" id="deleteTicket" name="deleteTicket" required>
                <button type="submit">Delete</button>
            </form>
        </div>

        <!-- Show All Bookings -->
        <div class="section">
            <h2>All Bookings</h2>
            <form action="adminmain.jsp" method="post">
                <button type="submit" name="showBookings">Show All Bookings</button>
            </form>
            <div class="results">
                <%
                    if (request.getParameter("showBookings") != null) {
                        String url = "jdbc:oracle:thin:@localhost:1521:orcl";
                        String dbUsername = "movie";
                        String dbPassword = "1111";
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
                            stmt = conn.createStatement();
                            String query = "SELECT * FROM BOOKINGS";
                            rs = stmt.executeQuery(query);

                            while (rs.next()) {
                                String date = rs.getString("booking_date");
                                String movieName = rs.getString("movie_name");
                                String time = rs.getString("show_time");
                                String seat = rs.getString("seat_number");
                                String category = rs.getString("ticket_category");
                                out.println("<div class='ticket-box'>");
                                out.println("<div class='ticket-info'><strong>Date:</strong> " + date + "</div>");
                                out.println("<div class='ticket-info'><strong>Movie Name:</strong> " + movieName + "</div>");
                                out.println("<div class='ticket-info'><strong>Time:</strong> " + time + "</div>");
                                out.println("<div class='ticket-info'><strong>Seat No:</strong> " + seat + "</div>");
                                out.println("<div class='ticket-info'><strong>Category:</strong> " + category + "</div>");
                                out.println("</div>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { }
                        }
                    }
                %>
            </div>
        </div>

        <!-- Show All Users -->
        <div class="section">
            <h2>All Users</h2>
            <form action="adminmain.jsp" method="post">
                <button type="submit" name="showUsers">Show All Users</button>
            </form>
            <div class="results">
                <%
                    if (request.getParameter("showUsers") != null) {
                        String url = "jdbc:oracle:thin:@localhost:1521:orcl";
                        String dbUsername = "movie";
                        String dbPassword = "1111";
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
                            stmt = conn.createStatement();
                            String query = "SELECT * FROM USERS";
                            rs = stmt.executeQuery(query);

                            while (rs.next()) {
                                String username = rs.getString("username");
                                String phone_number = rs.getString("phone_number");
                                String full_name = rs.getString("full_name");
                                out.println("<div class='user-box'>");
                                out.println("<div class='user-info'><strong>User Name:</strong> " + username + "</div>");
                                out.println("<div class='user-info'><strong>Phone Number:</strong> " + phone_number + "</div>");
                                out.println("<div class='user-info'><strong>Full Name:</strong> " + full_name + "</div>");
                                out.println("</div>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { }
                        }
                    }
                %>
            </div>
        </div>

        <%
            // Handle search user by mobile number
            if (request.getParameter("searchUser") != null) {
                String mobileNumber = request.getParameter("searchUser");
                String url = "jdbc:oracle:thin:@localhost:1521:orcl";
                String dbUsername = "movie";
                String dbPassword = "1111";
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
                    String query = "SELECT * FROM USERS WHERE phone_number = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, mobileNumber);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String fullName = rs.getString("full_name");
                        String username = rs.getString("username");
                        out.println("<div class='user-box'>");
                        out.println("<div class='user-info'><strong>Mobile Number:</strong> " + mobileNumber + "</div>");
                        out.println("<div class='user-info'><strong>Full Name:</strong> " + fullName + "</div>");
                        out.println("<div class='user-info'><strong>Username:</strong> " + username + "</div>");
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>No user found with mobile number: " + mobileNumber + "</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            }

            // Handle delete user by mobile number
            if (request.getParameter("deleteUser") != null) {
                String mobileNumber = request.getParameter("deleteUser");
                String url = "jdbc:oracle:thin:@localhost:1521:orcl";
                String dbUsername = "movie";
                String dbPassword = "1111";
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
                    String query = "DELETE FROM USERS WHERE phone_number = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, mobileNumber);
                    int rows = pstmt.executeUpdate();

                    if (rows > 0) {
                        out.println("<div class='success'>User with mobile number: " + mobileNumber + " has been deleted.</div>");
                    } else {
                        out.println("<div class='error'>No user found with mobile number: " + mobileNumber + "</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            }

            // Handle search ticket by mobile number
            if (request.getParameter("searchTicket") != null) {
                String mobileNumber = request.getParameter("searchTicket");
                String url = "jdbc:oracle:thin:@localhost:1521:orcl";
                String dbUsername = "movie";
                String dbPassword = "1111";
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
                    String query = "SELECT * FROM BOOKINGS WHERE id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, mobileNumber);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String date = rs.getString("booking_date");
                        String movieName = rs.getString("movie_name");
                        String time = rs.getString("show_time");
                        String seat = rs.getString("seat_number");
                        String category = rs.getString("ticket_category");
                        out.println("<div class='ticket-box'>");
                        out.println("<div class='ticket-info'><strong>Date:</strong> " + date + "</div>");
                        out.println("<div class='ticket-info'><strong>Movie Name:</strong> " + movieName + "</div>");
                        out.println("<div class='ticket-info'><strong>Time:</strong> " + time + "</div>");
                        out.println("<div class='ticket-info'><strong>Seat No:</strong> " + seat + "</div>");
                        out.println("<div class='ticket-info'><strong>Category:</strong> " + category + "</div>");
                        out.println("</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            }

            // Handle delete ticket by mobile number
            if (request.getParameter("deleteTicket") != null) {
                String mobileNumber = request.getParameter("deleteTicket");
                String url = "jdbc:oracle:thin:@localhost:1521:orcl";
                String dbUsername = "movie";
                String dbPassword = "1111";
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "movie", "1111");
                    String query = "DELETE FROM BOOKINGS WHERE id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, mobileNumber);
                    int rows = pstmt.executeUpdate();

                    if (rows > 0) {
                        out.println("<div class='success'>Ticket for mobile number: " + mobileNumber + " has been deleted.</div>");
                    } else {
                        out.println("<div class='error'>No ticket found with mobile number: " + mobileNumber + "</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            }
        %>
    </div>
</body>
</html>
