import db.matic_fs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/fs_general_ledger_percategorys")
public class fs_general_ledger_percategorys extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection parameters
    Connection conn = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get parameters from AJAX
        String dateFrom = request.getParameter("per_categorys_date_gl_from");
        String dateTo = request.getParameter("per_categorys_date_gl_to");
        String filter = request.getParameter("per_categorys_filter");
        String zone = request.getParameter("per_categorys_zones");
        String region = request.getParameter("per_categorys_region");
        String glFrom = request.getParameter("per_categorys_gl_from");
        String category = request.getParameter("per_categorys_category");
        String branch = request.getParameter("per_categorys_branch");
        String action = request.getParameter("action");

        // Debugging: Print all parameters
        System.out.println("===== AJAX PARAMETERS =====");
        System.out.println("dateFrom: " + dateFrom);
        System.out.println("dateTo: " + dateTo);
        System.out.println("filter: " + filter);
        System.out.println("zone: " + zone);
        System.out.println("region: " + region);
        System.out.println("glFrom: " + glFrom);
        System.out.println("category: " + category);
        System.out.println("branch: " + branch);
        System.out.println("action: " + action);
        System.out.println("===========================");

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = matic_fs.getConnection();
            Statement stmt = conn.createStatement();
            stmt.execute("SET sql_mode = ''");

            // Build dynamic SQL
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT f.date, v.RegionName AS Region, gl.name AS GLCode, gl.description AS Description, ")
               .append("SUM(f.total_amount) AS Amount ")
               .append("FROM fs.fs f ")
               .append("INNER JOIN vw_new_branch_record v ON f.branch_id = v.BranchID ")
               .append("INNER JOIN fs.codes gl ON f.code_id = gl.code_id ")
               .append("WHERE f.date BETWEEN ? AND ? ")
               .append("AND gl.description = ? ")
               .append("AND f.category = ? ");

            // Apply dynamic filter
            if ("3".equals(filter)) {
                sql.append("AND f.branch_id = ? ");
            } else if ("2".equals(filter)) {
                sql.append("AND v.RegionName = ? ");
            } else if (zone != null && !zone.isEmpty()) {
                sql.append("AND f.zone_id = ? ");
            }

            sql.append("GROUP BY v.RegionName, gl.name, gl.description ")
               .append("ORDER BY v.RegionName ASC");

            ps = conn.prepareStatement(sql.toString());

            // Bind parameters
            int paramIndex = 1;
            ps.setString(paramIndex++, dateFrom);
            ps.setString(paramIndex++, dateTo);
            ps.setString(paramIndex++, glFrom);
            ps.setString(paramIndex++, category);

            if ("3".equals(filter)) {
                ps.setString(paramIndex++, branch);
            } else if ("2".equals(filter)) {
                ps.setString(paramIndex++, region);
            } else if (zone != null && !zone.isEmpty()) {
                ps.setString(paramIndex++, zone);
            }

            // Debugging: Print final SQL
            System.out.println("Executing SQL: " + ps.toString());

            rs = ps.executeQuery();
            boolean hasData = false;

            while (rs.next()) {
                hasData = true;
                String date = rs.getString("date");
                String regionName = rs.getString("Region");
                String glCode = rs.getString("GLCode");
                String description = rs.getString("Description");
                String amount = rs.getString("Amount");

                // Debugging: Print each row
                System.out.println("Row: " + date + ", " + regionName + ", " + glCode + ", " + description + ", " + amount);

                out.println("<tr>");
                out.println("<td>" + glCode + "</td>");
                out.println("<td>" + description + "</td>");
                out.println("<td>" + date + "</td>");
                out.println("<td>" + regionName + "</td>");
                out.println("<td>-</td>"); // Cost Center placeholder
                out.println("<td>-</td>"); // Branches placeholder
                out.println("<td>" + amount + "</td>");
                out.println("</tr>");
            }

            if (!hasData) {
                out.println(""); // Empty response handled by JS
            }

        } catch (SQLException e) {
            out.println("<tr><td colspan='7' style='text-align:center;'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }
    }
}
