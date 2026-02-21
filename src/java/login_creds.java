


import db.matic_fs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login_creds")
public class login_creds extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean valid = false;
        String role = "";
        String name = "";

        System.out.println("LOGIN ATTEMPT");
        System.out.println("USERNAME = [" + username + "]");
        System.out.println("PASSWORD = [" + password + "]");

        String sql =
            "SELECT r.role_name, a.emp_name " +
            "FROM accounts a " +
            "JOIN account_roles r ON a.role_id = r.role_id " +
            "WHERE a.username = ? AND a.password = ?";

        try (Connection conn = matic_fs.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, username);
            pst.setString(2, password);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    valid = true;
                    role = rs.getString("role_name");
                    name = rs.getString("emp_name");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (valid) {
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("name", name);

            response.sendRedirect(request.getContextPath() + "/pages/homepage.jsp");
        } else {
            out.println("<script>");
            out.println("alert('Invalid username or password');");
            out.println("window.history.back();");
            out.println("</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
