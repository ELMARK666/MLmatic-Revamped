import db.matic_fs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.YearMonth;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Bsgeneralbalancesheet")
public class Bsgeneralbalancesheet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter write = response.getWriter();

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        
        try {
            conn = matic_fs.getConnection();
            conn.createStatement().execute("SET sql_mode = ''");

            String tuig = request.getParameter("yearStart");
            String from = request.getParameter("monthStart");
            String zone = request.getParameter("zone");
            String region = request.getParameter("region");
            String branch = request.getParameter("branch");
            String group = request.getParameter("group");
           
            DecimalFormat df = new DecimalFormat("#,##0.00");
            
            int month = Integer.parseInt(from);
            int year = Integer.parseInt(tuig);
            YearMonth ym = YearMonth.of(year, month);
            String startDate = String.format("%04d-01-01", year);
            String endDate = String.format("%04d-%02d-%02d", year, month, ym.lengthOfMonth());
            
            String sqlasset = "SELECT tg.code, f.code_id, tg.Description, SUM(f.total_amount) AS total_amount "
                    + "FROM fs f "
                    + "INNER JOIN codes tg ON tg.code_id = f.code_id "
                    + "INNER JOIN vw_new_branch_record v ON v.BranchID = f.branch_id "
                    + "WHERE tg.code LIKE '1%' AND f.date BETWEEN ? AND ? ";

                if (group.equalsIgnoreCase("Branch")) {
                    sqlasset += " AND v.Zone = ? AND v.Region = ? AND v.BranchID = ? ";
                } 
                else if (group.equalsIgnoreCase("Region")) {
                    sqlasset += " AND v.Zone = ? AND v.Region = ? ";
                } 
                else if (group.equalsIgnoreCase("Consolidated")) {
                    if (!zone.equalsIgnoreCase("ALL")) {
                        sqlasset += " AND v.Zone = ? ";
                    }
                }

                sqlasset += " GROUP BY tg.code, f.code_id, tg.Description HAVING SUM(f.total_amount) <> 0 ORDER BY tg.code";
                
                pst = conn.prepareStatement(sqlasset);

                int idxasset = 1;

                pst.setString(idxasset++, startDate);
                pst.setString(idxasset++, endDate);
            
                if (group.equalsIgnoreCase("Branch")) {
                    pst.setString(idxasset++, zone);
                    pst.setString(idxasset++, region);
                    pst.setString(idxasset++, branch);
                } else if (group.equalsIgnoreCase("Region")) {
                    pst.setString(idxasset++, zone);
                    pst.setString(idxasset++, region);
                } else if (group.equalsIgnoreCase("Consolidated")) {
                    if (!zone.equalsIgnoreCase("ALL")) {
                        pst.setString(idxasset++, zone);
                    }
                }
                
            rs = pst.executeQuery();
            boolean hasasset = false;
            double assetamount = 0.00;
            
            while (rs.next()) {
                hasasset = true;
                String code = rs.getString("code");
                String desc = rs.getString("Description");
                double amount = rs.getDouble("total_amount");
                assetamount+=amount;
                
                write.print("<tr>"
                            + "<td></td>"
                            + "<td>" + code + "</td>"
                            + "<td>" + desc + "</td>");
                    write.print("<td style='text-align:right;'>" + df.format(amount) + "</td>");
                
                write.println("</tr>");
            }
            rs.close();
            pst.close();

            if (hasasset) {
                write.print("<tr><td colspan='3'><strong>Asset</strong></td>");
                write.print("<td style='text-align:right;'><strong>" + df.format(assetamount) + "</strong></td>");
                write.println("</tr>");
            }else{
                write.print("<tr><td colspan='3'><strong>Asset</strong></td>");
                write.print("<td style='text-align:right;'><strong>0.00</strong></td>");
                write.println("</tr>");
            }

            String sqllia = "SELECT tg.code, f.code_id, tg.Description, SUM(f.total_amount) AS total_amount "
                    + "FROM fs f "
                    + "INNER JOIN codes tg ON tg.code_id = f.code_id "
                    + "INNER JOIN vw_new_branch_record v ON v.BranchID = f.branch_id "
                    + "WHERE tg.code LIKE '2%' AND f.date BETWEEN ? AND ? ";

                if (group.equalsIgnoreCase("Branch")) {
                    sqllia += " AND v.Zone = ? AND v.Region = ? AND v.BranchID = ? ";
                } 
                else if (group.equalsIgnoreCase("Region")) {
                    sqllia += " AND v.Zone = ? AND v.Region = ? ";
                } 
                else if (group.equalsIgnoreCase("Consolidated")) {
                    if (!zone.equalsIgnoreCase("ALL")) {
                        sqllia += " AND v.Zone = ? ";
                    }
                }

                sqllia += " GROUP BY tg.code, f.code_id, tg.Description HAVING SUM(f.total_amount) <> 0 ORDER BY tg.code";

                pst = conn.prepareStatement(sqllia);

                int idxlia = 1;

                pst.setString(idxlia++, startDate);
                pst.setString(idxlia++, endDate);

                if (group.equalsIgnoreCase("Branch")) {
                    pst.setString(idxlia++, zone);
                    pst.setString(idxlia++, region);
                    pst.setString(idxlia++, branch);
                }
                else if (group.equalsIgnoreCase("Region")) {
                    pst.setString(idxlia++, zone);
                    pst.setString(idxlia++, region);
                }
                else if (group.equalsIgnoreCase("Consolidated")) {
                    if (!zone.equalsIgnoreCase("ALL")) {
                        pst.setString(idxlia++, zone);
                    }
                }

            rs = pst.executeQuery();
            boolean haslia = false;
            double totallia = 0.00;
            
            while (rs.next()) {
                haslia = true;
                String code = rs.getString("code");
                String desc = rs.getString("Description");
                double amount = rs.getDouble("total_amount");
                totallia+=amount;
                
                write.print("<tr>"
                            + "<td></td>"
                            + "<td>" + code + "</td>"
                            + "<td>" + desc + "</td>");
                    write.print("<td style='text-align:right;'>" + df.format(amount) + "</td>");
                
                write.println("</tr>");
            }
            rs.close();
            pst.close();

            if (haslia) {
                write.print("<tr><td colspan='3'><strong>Liabilities</strong></td>");
                write.print("<td style='text-align:right;'><strong>" + df.format(totallia) + "</strong></td>");
                write.println("</tr>");
            }else{
                write.print("<tr><td colspan='3'><strong>Liabilities</strong></td>");
                write.print("<td style='text-align:right;'><strong>0.00</strong></td>");
                write.println("</tr>");
            }
            
            String sqlequity = "SELECT tg.code, f.code_id, tg.Description, SUM(f.total_amount) AS total_amount "
                    + "FROM fs f "
                    + "INNER JOIN codes tg ON tg.code_id = f.code_id "
                    + "INNER JOIN vw_new_branch_record v ON v.BranchID = f.branch_id "
                    + "WHERE tg.code LIKE '3%' AND f.date BETWEEN ? AND ? ";

                if (group.equalsIgnoreCase("Branch")) {
                    sqlequity += " AND v.Zone = ? AND v.Region = ? AND v.BranchID = ? ";
                } 
                else if (group.equalsIgnoreCase("Region")) {
                    sqlequity += " AND v.Zone = ? AND v.Region = ? ";
                } 
                else if (group.equalsIgnoreCase("Consolidated")) {
                    if (!zone.equalsIgnoreCase("ALL")) {
                        sqlequity += " AND v.Zone = ? ";
                    }
                }

                sqlequity += " GROUP BY tg.code, f.code_id, tg.Description HAVING SUM(f.total_amount) <> 0 ORDER BY tg.code";

                pst = conn.prepareStatement(sqlequity);

                int inxequity = 1;

                pst.setString(inxequity++, startDate);
                pst.setString(inxequity++, endDate);

                if (group.equalsIgnoreCase("Branch")) {
                    pst.setString(inxequity++, zone);
                    pst.setString(inxequity++, region);
                    pst.setString(inxequity++, branch);
                }
                else if (group.equalsIgnoreCase("Region")) {
                    pst.setString(inxequity++, zone);
                    pst.setString(inxequity++, region);
                }
                else if (group.equalsIgnoreCase("Consolidated")) {
                    if (!zone.equalsIgnoreCase("ALL")) {
                        pst.setString(inxequity++, zone);
                    }
                }
            rs = pst.executeQuery();
            boolean hasEquity = false;
            double totalequity = 0.00;
            
            while (rs.next()) {
                hasEquity = true;
                String code = rs.getString("code");
                String desc = rs.getString("Description");
                double amount = rs.getDouble("total_amount");
                totalequity+=amount;
            
                write.print("<tr>"
                            + "<td></td>"
                            + "<td>" + code + "</td>"
                            + "<td>" + desc + "</td>");
                    write.print("<td style='text-align:right;'>" + df.format(amount) + "</td>");
                
                write.println("</tr>");
            }
            rs.close();
            pst.close();

            if (hasEquity) {
                write.print("<tr><td colspan='3'><strong>Equity</strong></td>");
                write.print("<td style='text-align:right;'><strong>" + df.format(totalequity) + "</strong></td>");
                write.println("</tr>");
            }else{
                write.print("<tr><td colspan='3'><strong>Equity</strong></td>");
                write.print("<td style='text-align:right;'><strong>0.00</strong></td>");
                write.println("</tr>");
            }

            double net = totallia + totalequity;
            boolean anyData = hasasset || haslia || hasEquity;
            if (!anyData) {
                write.println("<tr><td colspan='100%' style='text-align:center; font-weight:bold;'>NO DATA FOUND</td></tr>");
            } else {
                write.print("<tr><td><strong>Total Liabilities and Equity</strong></td>");
                write.print("<td style='text-align:right;' colspan='3'><strong>" + df.format(net) + "</strong></td>");
                write.println("</tr>");
            }

        } catch (NumberFormatException | SQLException ex) {
            write.println("<tr><td colspan='100%' class='alert alert-danger'>");
            write.println("Error: " + ex.getMessage() + "<br/>");
            for (StackTraceElement st : ex.getStackTrace()) {
                write.println(st.toString() + "<br/>");
            }
            write.println("</td></tr>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ex) {}
            try { if (pst != null) pst.close(); } catch (SQLException ex) {}
            try { if (conn != null) conn.close(); } catch (SQLException ex) {}
        }
    }
}
