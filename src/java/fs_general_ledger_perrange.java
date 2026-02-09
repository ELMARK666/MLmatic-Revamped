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

@WebServlet("/fs_general_ledger_perrange")
public class fs_general_ledger_perrange extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            conn = matic_fs.getConnection();
            Statement stmt = conn.createStatement();
            stmt.execute("SET sql_mode = ''");

            String ledger = request.getParameter("ledger");
            if (!"per_range".equals(ledger)) {
                out.print("<tr><td colspan='5' style='text-align:center;'>No data for this ledger</td></tr>");
                return;
            }

            String action = request.getParameter("action");
            if (!"filter_perrange".equals(action)) {
                out.print("<tr><td colspan='5' style='text-align:center;'>Invalid action</td></tr>");
                return;
            }

            // --- Get parameters ---
            String per_cat_date_gl_from = request.getParameter("per_cat_date_gl_from");
            String per_cat_date_gl_to   = request.getParameter("per_cat_date_gl_to");
            String startDateTime = (per_cat_date_gl_from != null ? per_cat_date_gl_from : "") + " 00:00:00";
            String endDateTime   = (per_cat_date_gl_to != null ? per_cat_date_gl_to : "") + " 23:59:59";

            String per_cat_zones = request.getParameter("per_cat_zones");
            String per_cat_region = request.getParameter("per_cat_region");
            String per_range_gl_from_new = request.getParameter("per_range_gl_from_new");
            String per_cat_gl_to = request.getParameter("per_cat_gl_to");
            String per_cat_criteria = request.getParameter("per_cat_criteria");
            String per_cat_search = request.getParameter("per_cat_search");

            // --- Set safe defaults if empty ---
            if (per_range_gl_from_new == null || per_range_gl_from_new.trim().isEmpty()) per_range_gl_from_new = "0";
            if (per_cat_gl_to == null || per_cat_gl_to.trim().isEmpty()) per_cat_gl_to = "999999999";

            String ledgerData = "";
            String sql = "";

            // --- Build SQL & Bind Parameters ---
            switch (per_cat_criteria) {
                case "1": // Zone
                    sql = "SELECT f.date, v.RegionName AS Region, gl.name AS GLCode, gl.description AS Description, "
                        + "SUM(f.total_amount) AS Amount "
                        + "FROM fs.fs f "
                        + "INNER JOIN vw_new_branch_record v ON f.branch_id = v.BranchID "
                        + "INNER JOIN fs.codes gl ON f.code_id = gl.code_id "
                        + "WHERE f.date BETWEEN ? AND ? AND v.Zone = ? AND gl.name BETWEEN ? AND ? "
                        + "GROUP BY v.RegionName, gl.name, gl.description "
                        + "ORDER BY v.RegionName ASC";
                    pst = conn.prepareStatement(sql);
                    pst.setString(1, startDateTime);
                    pst.setString(2, endDateTime);
                    pst.setString(3, per_cat_zones);
                    pst.setString(4, per_range_gl_from_new);
                    pst.setString(5, per_cat_gl_to);
                    break;

                case "2": // Region
                    sql = "SELECT f.date, v.Branch AS Branch, v.RegionName AS Region, gl.name AS GLCode, gl.description AS Description, "
                        + "SUM(f.total_amount) AS Amount "
                        + "FROM fs.fs f "
                        + "INNER JOIN vw_new_branch_record v ON f.branch_id = v.BranchID "
                        + "INNER JOIN fs.codes gl ON f.code_id = gl.code_id "
                        + "WHERE f.date BETWEEN ? AND ? AND v.Zone = ? AND v.RegionName = ? AND gl.name BETWEEN ? AND ? "
                        + "GROUP BY v.RegionName, gl.name, gl.description "
                        + "ORDER BY v.RegionName ASC";
                    pst = conn.prepareStatement(sql);
                    pst.setString(1, startDateTime);
                    pst.setString(2, endDateTime);
                    pst.setString(3, per_cat_zones);
                    pst.setString(4, per_cat_region);
                    pst.setString(5, per_range_gl_from_new);
                    pst.setString(6, per_cat_gl_to);
                    break;

                case "3": // Branch
                    sql = "SELECT f.date, v.Branch AS Branch, gl.name AS GLCode, gl.description AS Description, "
                        + "SUM(f.total_amount) AS Amount "
                        + "FROM fs.fs f "
                        + "INNER JOIN vw_new_branch_record v ON f.branch_id = v.BranchID "
                        + "INNER JOIN fs.codes gl ON f.code_id = gl.code_id "
                        + "WHERE f.date BETWEEN ? AND ? AND v.RegionName = ? AND gl.name BETWEEN ? AND ? AND v.Branch = ? "
                        + "GROUP BY v.RegionName, gl.name, gl.description "
                        + "ORDER BY f.date ASC";
                    pst = conn.prepareStatement(sql);
                    pst.setString(1, startDateTime);
                    pst.setString(2, endDateTime);
                    pst.setString(3, per_cat_region);
                    pst.setString(4, per_range_gl_from_new);
                    pst.setString(5, per_cat_gl_to);
                    pst.setString(6, per_cat_search);
                    break;

                default:
                    out.print("<tr><td colspan='5' style='text-align:center;'>Invalid criteria selected</td></tr>");
                    return;
            }

            rs = pst.executeQuery();

            // --- Table header ---
            String tableHeader;
            if ("1".equals(per_cat_criteria)) {
                tableHeader = "<tr><th>Date</th><th>Region</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
            } else {
                tableHeader = "<tr><th>Date</th><th>Branch</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
            }

            // --- Table rows ---
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                double amount = rs.getDouble("Amount");
                ledgerData += "<tr>"
                        + "<td>" + rs.getString("date") + "</td>"
                        + "<td>" + ("1".equals(per_cat_criteria) ? rs.getString("Region") : rs.getString("Branch")) + "</td>"
                        + "<td>" + rs.getString("GLCode") + "</td>"
                        + "<td>" + rs.getString("Description") + "</td>"
                        + "<td style='text-align:right;'>" + String.format("%,.2f", amount) + "</td>"
                        + "</tr>";
            }

            out.print(tableHeader);
            out.print(ledgerData);

            if (!hasData) {
                out.print("<tr><td colspan='5' style='text-align:center;'>No data found</td></tr>");
            }

        } catch (SQLException e) {
            out.print("<tr><td colspan='5' style='text-align:center;'>Error occurred: " + e.getMessage() + "</td></tr>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ex) {}
            try { if (pst != null) pst.close(); } catch (SQLException ex) {}
            try { if (conn != null) conn.close(); } catch (SQLException ex) {}
            out.close();
        }
    }
}

