import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class FormServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://mysql_db:3306/appdb", "appuser", "apppass"
            );
            PreparedStatement ps = con.prepareStatement("INSERT INTO users(name, email) VALUES(?,?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.executeUpdate();
            out.println("<h2>Data saved successfully!</h2>");
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
