/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import db.matic_fs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ELMARK
 */
@WebServlet("/fs_general_ledger")
public class fs_general_ledger extends HttpServlet {

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

            // ----------------- PER ACCOUNT -----------------
            if ("per_account".equals(ledger)) {

                String per_account_date_from = request.getParameter("per_account_date_from");
                String per_account_date_to = request.getParameter("per_account_date_to");
                String per_account_filter = request.getParameter("per_account_filter");
                String per_account_zone = request.getParameter("per_account_zone");
                String per_account_region = request.getParameter("per_account_region");
                String per_account_criteria_search = request.getParameter("per_account_criteria_search");
                String per_account_gl = request.getParameter("per_account_gl");
                String action = request.getParameter("action");

                String startDateTime = per_account_date_from + " 00:00:00";
                String endDateTime = per_account_date_to + " 23:59:59";

                String sql = "";
                String ledgerData = "";

                if ("filter_asset".equals(action) && per_account_filter != null) {

                    switch (per_account_filter) {
                        case "1": // ZONE
                            sql = "SELECT f.date, v.RegionName AS Region, gl.name AS GLCode, gl.description AS Description, " +
                                  "SUM(f.total_amount) AS Amount " +
                                  "FROM fs.fs f " +
                                  "INNER JOIN vw_new_branch_record v ON f.branch_id = v.BranchID " +
                                  "INNER JOIN fs.codes gl ON f.code_id = gl.code_id " +
                                  "WHERE f.zone_id = ? AND f.date BETWEEN ? AND ? AND gl.description = ? " +
                                  "GROUP BY v.RegionName, gl.name, gl.description " +
                                  "ORDER BY v.RegionName ASC";
                            break;

                        case "2": // REGION
                            sql = "SELECT f.date, v.Branch AS Branch, gl.name AS GLCode, gl.description AS Description, " +
                                  "SUM(f.total_amount) AS Amount " +
                                  "FROM fs.fs f " +
                                  "INNER JOIN vw_new_branch_record v ON f.branch_id = v.BranchID " +
                                  "INNER JOIN fs.codes gl ON f.code_id = gl.code_id " +
                                  "WHERE v.Region = ? AND f.date BETWEEN ? AND ? AND gl.description = ? " +
                                  "GROUP BY f.date, v.Branch, gl.name, gl.description " +
                                  "ORDER BY f.date ASC";
                            break;

                        case "3": // BRANCH
                            sql = "SELECT f.date, v.Branch AS Branch, gl.name AS GLCode, gl.description AS Description, " +
                                  "SUM(f.total_amount) AS Amount " +
                                  "FROM fs.fs f " +
                                  "INNER JOIN vw_new_branch_record v ON f.branch_id = v.BranchID " +
                                  "INNER JOIN fs.codes gl ON f.code_id = gl.code_id " +
                                  "WHERE v.Region = ? AND f.date BETWEEN ? AND ? AND gl.description = ? AND v.Branch = ? " +
                                  "GROUP BY f.date, v.Branch, gl.name, gl.description " +
                                  "ORDER BY f.date ASC";
                            break;

                        default:
                            out.print("<tr><td colspan='5' style='text-align:center;'>Invalid filter selected</td></tr>");
                            return;
                    }

                    pst = conn.prepareStatement(sql);

                    // Safe parameter binding
                    switch (per_account_filter) {
                        case "1":
                            pst.setString(1, per_account_zone);
                            pst.setString(2, startDateTime);
                            pst.setString(3, endDateTime);
                            pst.setString(4, per_account_gl);
                            break;
                        case "2":
                            pst.setString(1, per_account_region);
                            pst.setString(2, startDateTime);
                            pst.setString(3, endDateTime);
                            pst.setString(4, per_account_gl);
                            break;
                        case "3":
                            pst.setString(1, per_account_region);
                            pst.setString(2, startDateTime);
                            pst.setString(3, endDateTime);
                            pst.setString(4, per_account_gl);
                            pst.setString(5, per_account_criteria_search);
                            break;
                    }

                    rs = pst.executeQuery();

                    // Table header
                    String tableHeader;
                    if ("1".equals(per_account_filter)) {
                        tableHeader = "<tr><th>Date</th><th>Region</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
                    } else {
                        tableHeader = "<tr><th>Date</th><th>Branch</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
                    }

                    while (rs.next()) {
                        double amount = rs.getDouble("Amount");
                        ledgerData += "<tr>"
                                + "<td>" + rs.getString("date") + "</td>"
                                + "<td>" + ("1".equals(per_account_filter) ? rs.getString("Region") : rs.getString("Branch")) + "</td>"
                                + "<td>" + rs.getString("GLCode") + "</td>"
                                + "<td>" + rs.getString("Description") + "</td>"
                                + "<td style='text-align:right;'>" + String.format("%,.2f", amount) + "</td>"
                                + "</tr>";
                    }

                    if (ledgerData.isEmpty()) {
                        ledgerData = "<tr><td colspan='5' style='text-align:center;'>No data found</td></tr>";
                    }

                    out.print(tableHeader);
                    out.print(ledgerData);
                    return;
                }
            }

            // ----------------- INVALID LEDGER -----------------
            else {
                out.print("<tr><td colspan='5' style='text-align:center;'>No data for this ledger</td></tr>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<tr><td colspan='5' style='text-align:center;'>Error occurred: " + e.getMessage() + "</td></tr>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (pst != null) pst.close(); } catch (Exception ex) {}
            try { if (conn != null) conn.close(); } catch (Exception ex) {}
            out.close();
        }
    }
}

