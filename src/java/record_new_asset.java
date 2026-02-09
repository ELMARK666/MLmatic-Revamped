/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import db.matic_fs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
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

 */
@WebServlet("/record_new_asset")
public class record_new_asset extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter write = response.getWriter();

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        // ✔ FIXED PARAMETER NAMES TO MATCH HTML
        String criteria = request.getParameter("management_asset_criteria");
        String search   = request.getParameter("management_search_asset");
        String datef    = request.getParameter("management_date_from");
        String datet    = request.getParameter("management_date_to");
        String zone     = request.getParameter("manage_zones");
        String action   = request.getParameter("action");
        String asset    = request.getParameter("asset");

        try {
            conn = matic_fs.getConnection();
            Statement stmt = conn.createStatement();
            stmt.execute("SET sql_mode = ''");

            if ("search".equals(asset)) {

                if ("load_table".equals(action)) {
                    write.print("<tr><td colspan='11'><center>- No Query Execute -</center></td></tr>");
                    return;
                }

                if (!"filter_manage_asset".equals(action)) {
                    write.print("<tr><td colspan='11'><center>- No Action -</center></td></tr>");
                    return;
                }
                    CallableStatement cs = conn.prepareCall("{CALL fs.search_manage_asset(?,?,?,?,?)}");
                    cs.setString(1, criteria);   // e.g. "Branch_ID"
                    cs.setString(2, zone);       // e.g. "1"
                    cs.setString(3, search);     // e.g. "80"
                    cs.setString(4, datef);      // e.g. "2025-11-01"
                    cs.setString(5, datet);      // e.g. "2025-11-30"
                    rs = cs.executeQuery();
                    boolean hasRows = false;
                while (rs.next()) {
                    hasRows = true;

                    write.print("<tr>"
                        + "<td>" + rs.getString("Code") + "</td>"
                        + "<td>" + rs.getString("Branch") + "</td>"
                        + "<td>" + rs.getString("Asset") + "</td>"
                        + "<td>" + rs.getString("Description") + "</td>"
                        + "<td style='text-align:right;'>" + rs.getString("Cost") + "</td>"
                        + "<td style='text-align:right;'>" + rs.getString("DE") + "</td>"
                        + "<td style='text-align:right;'>" + rs.getString("AD") + "</td>"
                        + "<td style='text-align:center;'>" + rs.getString("Remain") + "</td>"
                        + "<td style='text-align:right;'>" + rs.getString("BV") + "</td>"
                        + "<td style='text-align:right;'>" + rs.getString("dateko") + "</td>"

                        + "<td>"
                        + "<button type='button' class='btn btn-default btn-sm open-dispose' "
                        + "data-codess='" + rs.getString("Code") + "' "
                        + "data-code='" + rs.getString("Code") + "' "
                        + "data-branch='" + rs.getString("Branch") + "' "
                        + "data-asset='" + rs.getString("Asset") + "' "
                        + "data-desc='" + rs.getString("Description") + "' "
                        + "data-cost='" + rs.getString("Cost") + "' "
                        + "data-de='" + rs.getString("DE") + "' "
                        + "data-ad='" + rs.getString("AD") + "' "
                        + "data-remain='" + rs.getString("Remain") + "' "
                        + "data-bv='" + rs.getString("BV") + "' "
                        + "data-ref='" + rs.getString("ref") + "' "
                        + "data-date='" + rs.getString("dateko") + "' "
                        + "data-scrap='" + rs.getString("scrap") + "' "
                        + "data-depdate='" + rs.getString("depdate") + "' "
                        + "data-retiredate='" + rs.getString("retiredate") + "' "
                        + "data-recID='" + rs.getString("recID") + "' "
                                


                        + "style='margin-right:6px;'>"
                        + "<span class='fa fa-edit'></span> Dispose/Transfer</button>"

                        + "<button type='button' class='btn btn-danger btn-sm delete-asset' "
                        + "data-code='" + rs.getString("Code") + "'>"
                        + "<span class='fa fa-trash'></span></button>"
                        + "</td>"

                        + "</tr>");
                }
                if (!hasRows) {
                    write.print("<tr><td colspan='11' style='text-align:center;'>-- No Records Found --</td></tr>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            write.print("<tr><td colspan='11' style='color:red;'>" + e.getMessage() + "</td></tr>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
