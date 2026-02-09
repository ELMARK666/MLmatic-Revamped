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
import java.sql.SQLException;
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
@WebServlet("/fs_gl_check")
public class fs_gl_check extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement pst =null;
        ResultSet rs =null;
        String ledger = request.getParameter("ledger");

        try {
            conn = matic_fs.getConnection();
            Statement stmt = conn.createStatement();
            stmt.execute("SET sql_mode = ''");

            String action = request.getParameter("action");
            String per_check_date_gl_from = request.getParameter("per_check_date_gl_from");
            String per_check_zones        = request.getParameter("per_check_zones");
            String per_check_region       = request.getParameter("per_check_region");
            String per_check_gl_from_new  = request.getParameter("per_check_gl_from_new");
            String per_check_gl_to        = request.getParameter("per_check_gl_to");
            
            String yyyy = per_check_date_gl_from.substring(0, 4);
            String mm   = per_check_date_gl_from.substring(5, 7);
            String d    = per_check_date_gl_from.substring(8, 10);
            String output="";

            /* DEBUG */
//            System.out.println("ACTION: " + action);
//            System.out.println("DATE  : " + per_check_date_gl_from);
//            System.out.println("ZONE  : " + per_check_zones);
//            System.out.println("REGION: " + per_check_region);
//            System.out.println("GL F  : " + per_check_gl_from_new);
//            System.out.println("GL T  : " + per_check_gl_to);
            
            if(ledger.equals("display")){
                
                String check_gl = "SELECT fs.`Date` as Date,gl.code as GLCode,gl.Description AS descr,br.Branch as Branch,br.BranchID as Branchid,br.RegionName as Region,\n" +
                "FORMAT(SUM(CASE WHEN fs.Category = 'Balance' AND YEAR(fs.`Date`) = '"+yyyy+"' THEN fs.total_amount ELSE 0 END), 2) AS runBal,\n" +
                "FORMAT(SUM(CASE WHEN fs.Category != 'Balance'AND MONTH(fs.`Date`) < '"+mm+"' AND YEAR(fs.`Date`) = '"+yyyy+"' THEN fs.total_amount ELSE 0 END), 2) AS previous,\n" +
                "FORMAT(SUM(CASE WHEN fs.Category != 'Balance'AND fs.`Date` BETWEEN '"+yyyy+"-"+mm+"-01' AND '"+per_check_region+"' THEN fs.total_amount ELSE 0 END), 2) AS runBal2,\n" +
                "br.BranchID\n" +
                "FROM fs.fs fs\n" +
                "INNER JOIN fs.codes gl ON gl.code_id = fs.code_id \n" +
                "INNER JOIN fs.vw_new_branch_record br ON br.Region = fs.region_id AND br.BranchID = fs.branch_id\n" +
                "WHERE gl.code BETWEEN '"+per_check_gl_from_new+"' AND '"+per_check_gl_to+"' AND fs.region_id = '"+per_check_region+"' AND fs.total_amount <> 0\n" +
                "GROUP BY br.Branch";
            
                pst = conn.prepareStatement(check_gl);
                rs = pst.executeQuery();
                pst.setFetchSize(5000);
                while(rs.next())
                {
                    String rbal = rs.getString("runBal");
                    String amt = rs.getString("runBal2");
                    String previous = rs.getString("previous");
                    
                    Double famount = Double.parseDouble(rbal.replace(",", "").trim());
                    Double samount = Double.parseDouble(amt.replace(",", "").trim());
                    Double prev = Double.parseDouble(previous.replace(",", "").trim());
                    Double net = famount+prev;
                    
                    String rbalance;
                    String trxn;
                    Double total_net = (famount+prev) + samount;
                    
                    if(net<0.0)
                    {
                        rbalance = "<samp style='color:red;'>("+String.format("%,.2f",net).replace("-", "").trim()+")</samp>";
                    }
                    else
                    {
                        rbalance = "<samp>"+String.format("%,.2f",net)+"</samp>";
                    }
                    if(amt.contains("-"))
                    {
                        trxn = "<samp style='color:red;'>("+amt.replace("-", "").trim()+")</samp>";
                    }
                    else
                    {
                        trxn = "<samp>"+amt+"</samp>";
                    }
                    if(total_net<0.00)
                    {
                        output +="<tr>"
                            + "<td style = 'display:none;'>"+rs.getString("Date")+"</td>"
                            + "<td style = 'display:none;'>"+rs.getString("GLCode")+"</td>"
                            + "<td style = 'display:none;'>"+rs.getString("descr")+"</td>"
                            + "<td>"+rs.getString("Branchid")+"</td>"
                            + "<td>"+rs.getString("Branch")+"</td>"
                            
                            + "<td style='text-align:right;color:red;'>("+String.format("%,.2f",total_net).replace("-", "").trim()+")</td>"
                            + "</tr>";
                    }
                    else
                    {
                        output +="<tr>"
                                + "<td>"+rs.getString("Branchid")+"</td>"
                            + "<td>"+rs.getString("Branch")+"</td>"
                            + "<td style='text-align:right;'>"+String.format("%,.2f",total_net)+"</td>"
                            + "</tr>";
                    }
                }
            }
            else if(ledger.equals("total"))
            {
                
            String check_gl_total = "SELECT fs.`Date` as Date,gl.code as GLCode,gl.Description AS descr,br.Branch as Branch,br.BranchID as Branchid,br.RegionName as Region,\n" +
                "FORMAT(SUM(CASE WHEN fs.Category = 'Balance' AND YEAR(fs.`Date`) = '"+yyyy+"' THEN fs.total_amount ELSE 0 END), 2) AS runBal,\n" +
                "FORMAT(SUM(CASE WHEN fs.Category != 'Balance'AND MONTH(fs.`Date`) < '"+mm+"' AND YEAR(fs.`Date`) = '"+yyyy+"' THEN fs.total_amount ELSE 0 END), 2) AS previous,\n" +
                "FORMAT(SUM(CASE WHEN fs.Category != 'Balance'AND fs.`Date` BETWEEN '"+yyyy+"-"+mm+"-01' AND '"+per_check_region+"' THEN fs.total_amount ELSE 0 END), 2) AS runBal2,\n" +
                "br.BranchID\n" +
                "FROM fs.fs fs\n" +
                "INNER JOIN fs.codes gl ON gl.code_id = fs.code_id \n" +
                "INNER JOIN fs.vw_new_branch_record br ON br.Region = fs.region_id AND br.BranchID = fs.branch_id\n" +
                "WHERE gl.code BETWEEN '"+per_check_gl_from_new+"' AND '"+per_check_gl_to+"' AND fs.region_id = '"+per_check_region+"' AND fs.total_amount <> 0 ";
                
                pst = conn.prepareStatement(check_gl_total);
                rs = pst.executeQuery();
                pst.setFetchSize(5000);
                if(rs.next())
                {
                    String rbal = rs.getString("runBal");
                    String amt = rs.getString("runBal2");
                    String previous = rs.getString("previous");
                    //convert to Double and remove comma sign
                    Double prev = Double.parseDouble(previous.replace(",", "").trim());
                    Double famount = Double.parseDouble(rbal.replace(",", "").trim());
                    Double samount = Double.parseDouble(amt.replace(",", "").trim());
                    Double net = famount+prev;
                    //revert to String
                    
                    String rbalance;
                    String trxn;
                    Double total_net = (famount+prev) + samount;
                    if(net<0.0)
                    {
                        rbalance = "<samp style='color:red;'>("+String.format("%,.2f",net).replace("-", "").trim()+")</samp>";
                    }
                    else
                    {
                        rbalance = "<samp>"+String.format("%,.2f",net)+"</samp>";
                    }
                    if(amt.contains("-"))
                    {
                        trxn = "<samp style='color:red;'>("+amt.replace("-", "").trim()+")</samp>";
                    }
                    else
                    {
                        trxn = "<samp>"+amt+"</samp>";
                    }
                    if(total_net<0.00)
                    {
                        output += "<tr>"
                                + "<td></td><td></td>"
                                + "<td style='color:red;text-align:right;'> TOTAL : <samp>("+String.format("%,.2f",total_net).replace("-", "").trim()+")</samp></td>"
                                + "</tr>";
                    }
                    else
                    {
                        output += "<tr>"
                                + "<td></td><td></td>"
                                + "<td style='text-align:right;'> TOTAL : <b>"+String.format("%,.2f",total_net)+"</b></td>"
                                + "</tr>";
                    }
                }
            }
            /* TEMP OUTPUT TEST */
            out.print(output);

        } catch (NumberFormatException | SQLException e) {
            out.print("<tr><td colspan='8' style='text-align:center;'>Error: "
                    + e.getMessage() + "</td></tr>");
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ex) {}
            out.close();
        }
    }
}

