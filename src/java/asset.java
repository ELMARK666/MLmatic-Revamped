/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import db.matic_fs;
import db.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
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
 * @author CAD Tools
 */
@WebServlet("/asset")
public class asset extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        Connection conn = null;
        Connection conn2 = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        
        
        PrintWriter out = response.getWriter(); //writer
        String sql = "";
        String date = request.getParameter("date");
        String zone = request.getParameter("zone");
        String region = request.getParameter("region"); 
        int count = 0;
        String code[];
        String zones[];
        String reg[];
        String branch[];
        Double life[];
        Double depreciation[];
        
        code = new String[300];
        zones = new String[300];
        reg = new String[300];
        branch = new String[300];
        life = new Double[300];
        depreciation = new Double[300];
        try
        {     
            conn2 = matic_fs.getConnection();
            conn2.setAutoCommit(false);
            conn = DataSource.getConnection();
            conn.setAutoCommit(false);
            
            Statement stmt = conn.createStatement();
            stmt.execute("Set sql_mode = ''");
            
            
            //new_asset_search_before_generate
            if (request.getParameter("action").equals("filter_asset")) {

                String zone_asset = request.getParameter("zone");
                String region_asset = request.getParameter("region");
                String date_asset = request.getParameter("date");  // e.g. "2025-11-30"

                try {
                    // Prepare callable statement for stored procedure
                    CallableStatement cstmt = conn2.prepareCall("{CALL search_branch_asset_to_generate(?, ?, ?)}");
                    cstmt.setString(1, zone_asset);
                    cstmt.setString(2, region_asset);
                    cstmt.setString(3, date_asset);

                    // Execute stored procedure
                    rs = cstmt.executeQuery();

                    while (rs.next()) {
                        out.print("<tr>"
                            + "<td>" + rs.getString("Code") + "</td>"
                            + "<td>" + rs.getString("Zone") + "</td>"
                            + "<td>" + rs.getString("Region") + "</td>"
                            + "<td>" + rs.getString("Branch") + "</td>"
                            + "<td style='text-align: center;'>" + rs.getString("Remaining_Life") + "</td>"
                            + "<td style='text-align: right;'>" + rs.getDouble("Depreciation_Expense") + "</td>"
                            + "</tr>");
                    }

                    rs.close();
                    cstmt.close();

                } catch (SQLException e) {
                    e.printStackTrace(out);
                }
            }
            
            else if (request.getParameter("action").equals("generate_asset")) {

                try {
                    // 1️⃣ Call the stored procedure instead of raw SQL
                    CallableStatement cstmt = conn2.prepareCall("{CALL branch_asset_generate(?, ?, ?)}");
                    cstmt.setString(1, zone);
                    cstmt.setString(2, region);
                    cstmt.setString(3, date);

                    rs = cstmt.executeQuery();

                    int count_asset = 0;
                    String[] code_asset = new String[10000];
                    String[] zones_asset = new String[10000];
                    String[] reg_asset = new String[10000];
                    String[] branch_asset = new String[10000];
                    Double[] depreciation_asset = new Double[10000];

                    // 2️⃣ Store result from stored procedure into arrays
                    while (rs.next()) {
                        code_asset[count_asset] = rs.getString("Code");
                        zones_asset[count_asset] = rs.getString("Zone");
                        reg_asset[count_asset] = rs.getString("Region");
                        branch_asset[count_asset] = rs.getString("Branch");
                        depreciation_asset[count_asset] = rs.getDouble("Depreciation_Expense");
                        count_asset++;
                    }

                    rs.close();
                    cstmt.close();

                    // 3️⃣ Loop through each record to compute depreciation and insert into cost table
                    for (int i = 0; i < count_asset; i++) {

                        String selects = "SELECT * FROM branch_asset_cost WHERE Code = ? ORDER BY costID DESC LIMIT 1";
                        pst = conn2.prepareStatement(selects);
                        pst.setString(1, code_asset[i]);
                        ResultSet rs2 = pst.executeQuery();

                        if (rs2.next()) {
                            // Variable declaration
                            double subt_asset = 1.00;
                            String Codein_asset = rs2.getString("Code");
                            String Zone_asset = rs2.getString("Zone");
                            String Branch_asset = rs2.getString("Branch");
                            String AssetGroup_asset = rs2.getString("AssetGroup");

                            double AC_asset = rs2.getDouble("AC");
                            double DepExpense_asset = depreciation_asset[i]; // Use depreciation from stored proc
                            double AccuDep_asset = rs2.getDouble("AccuDep");
                            double LifeRemains_asset = rs2.getDouble("LifeRemains");
                            double BookValue_asset = rs2.getDouble("BookValue");

                            // Computation
                            double totAccDep_asset = DepExpense_asset + AccuDep_asset;
                            double totBookV_asset = BookValue_asset - DepExpense_asset;
                            double totLife_asset = LifeRemains_asset - subt_asset;

                            // Insert new depreciation entry
                            String insert = "INSERT INTO branch_asset_cost (Code, Zone, Branch, AssetGroup, AC, DepExpense, AccuDep, LifeRemains, BookValue, Date, recordID) "
                                          + "VALUES (?, ?, ?, ?, ROUND(?,2), ?, ?, ?, ROUND(?,2), ?, "
                                          + "(SELECT recordID FROM branch_asset_record WHERE Code = ? LIMIT 1))";

                            PreparedStatement pstInsert = conn2.prepareStatement(insert);
                            pstInsert.setString(1, Codein_asset);
                            pstInsert.setString(2, Zone_asset);
                            pstInsert.setString(3, Branch_asset);
                            pstInsert.setString(4, AssetGroup_asset);
                            pstInsert.setDouble(5, AC_asset);
                            pstInsert.setDouble(6, DepExpense_asset);
                            pstInsert.setDouble(7, totAccDep_asset);
                            pstInsert.setDouble(8, totLife_asset);
                            pstInsert.setDouble(9, totBookV_asset);
                            pstInsert.setString(10, date);
                            pstInsert.setString(11, code_asset[i]);

                            pstInsert.executeUpdate();
                            pstInsert.close();
                        }

                        rs2.close();
                        pst.close();
                    }

                    out.print(count_asset + " row(s) Depreciated");

                } catch (SQLException e) {
                    e.printStackTrace(out);
                }
            }
            
            // OLD ASSET IN MLMATIC 
            //==================================================
            else if(request.getParameter("action").equals("filter"))
            {
                sql = "Select record.Code,record.Zone,record.Region,record.Branch,MIN(cost.lifeRemains) as Remaining_Life, " +
                    "ROUND(record.DE,2) as Depreciation_Expense  from record " +
                    "LEFT JOIN " +
                    "(Select Code,LifeRemains from cost)cost ON record.Code=cost.Code " +
                    "LEFT JOIN " +
                    "(Select Code from assetstats) a ON a.Code=record.Code " +
                    "WHERE record.Zone = '"+zone+"' AND record.Region = '"+region+"' AND record.DepreciationDate <= '"+date+"' and record.Status = 'Active' "+
                    "AND record.RetireDate > '"+date+"' " +
                    "AND NOT EXISTS(SELECT cost.Code from cost where cost.Date IS NOT NULL AND cost.Date='"+date+"' AND cost.Code=record.Code) " +
                    "AND NOT EXISTS(Select a.Code from assetstats a where a.Code=record.Code) GROUP BY record.Code, record.Zone, record.Region, record.Branch"; 
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
                while(rs.next())
                {        
                    
                    out.print("<tr>"
                    + "<td>"+rs.getString("Code")+"</td>"
                    + "<td>"+rs.getString("Zone")+"</td>"
                    + "<td>"+rs.getString("Region")+"</td>"
                    + "<td>"+rs.getString("Branch")+"</td>"
                    + "<td style='text-align: center;'>"+rs.getString("Remaining_Life")+"</td>"
                    + "<td style='text-align: right;'>"+rs.getDouble("Depreciation_Expense")+"</td>"
                    + "</tr>");
                      
                }
            }
            if(request.getParameter("action").equals("generate"))
            {
                String sql2 = "Select record.Code,record.Zone,record.Region,record.Branch,"
                        + "MIN(cost.LifeRemains) as Remaining_Life, ROUND(record.DE,2) as Depreciation_Expense  "
                        + "from record LEFT JOIN "
                        + "(Select Code,LifeRemains from cost)cost ON record.Code=cost.Code "
                        + "LEFT JOIN "
                        + "(Select Code from assetstats) a ON a.Code=record.Code WHERE record.Zone = '"+zone+"'"
                        + "AND record.Region = '"+region+"' AND record.DepreciationDate <= '"+date+"' "
                        + "AND record.RetireDate>'"+date+"' AND "
                        + "NOT EXISTS(SELECT cost.Code from cost where cost.Date IS NOT NULL AND cost.Date='"+date+"' AND cost.Code=record.Code) "
                        + "AND NOT EXISTS(Select a.Code from assetstats a where a.Code=record.Code) GROUP BY record.Code";
                pst = conn.prepareStatement(sql2);
                rs = pst.executeQuery();
                while(rs.next())
                {
                    code[count] = rs.getString("Code");
                    zones[count] = rs.getString("Zone");
                    reg[count] = rs.getString("Region");
                    branch[count] = rs.getString("Branch");
                    depreciation[count] = rs.getDouble("Depreciation_Expense");
                    count++;
                }
                for(int i = 0; i < count; i++)
                {
                  
                    //COMMENT SQL BOTTOM STARTS HERE...
                    
                    String selects = "Select * from cost WHERE Code = '"+code[i]+"' order by costID desc limit 1";
                    pst = conn.prepareStatement(selects);
                    rs = pst.executeQuery();
                    if(rs.next())
                    {
                        //variable declaration
                       Double subt = 1.00;
                       String Codein = rs.getString("Code");
                       String Zone = rs.getString("Zone");
                       String Branch = rs.getString("Branch");
                       String AssetGroup = rs.getString("AssetGroup");
                       
                       
                       Double AC = rs.getDouble("AC"); 
                       Double DepExpense = rs.getDouble("DepExpense"); 
                       Double AccuDep = rs.getDouble("AccuDep"); 
                       Double LifeRemains = rs.getDouble("LifeRemains");
                       Double BookValue = rs.getDouble("BookValue");
                       
                       //Computation
                       Double totAccDep = DepExpense + AccuDep;
                       Double totBookV = BookValue - DepExpense;
                       Double totLife = LifeRemains - subt;
                        
                        
                        //start of the query
                       String insert = "INSERT INTO cost (Code, Zone, Branch, AssetGroup, AC, DepExpense, AccuDep, LifeRemains, BookValue, Date, recordID)"
                                + "VALUES('"+Codein+"','"+Zone+"','"+Branch+"','"+AssetGroup+"',ROUND('"+AC+"',2),'"+DepExpense+"','"+totAccDep+"','"+totLife+"',"
                                + "ROUND('"+totBookV+"',2),'"+date+"',(SELECT recordID from record WHERE Code ='"+code[i]+"' LIMIT 1))";
                        pst = conn.prepareStatement(insert);
                        pst.executeUpdate();
                        
//                    OLD FORMULA FOR DEPRECIATION ASSET

//                    String selects = "Select LifeRemains, MIN(AC)as AC, Count(AccuDep) as AD, Date, AssetGroup from cost WHERE Code = '"+code[i]+"'";
//                    pst = conn.prepareStatement(selects);
//                    rs = pst.executeQuery();
//                    if(rs.next())
//                    {
//                        Double x = rs.getDouble("AC"); //cost per object
//                        Double ad  = depreciation[i]; //accumulated Depreciation
//                        Double bv = x-ad; //Book Value
//                        Double l = rs.getDouble("LifeRemains");
//                        Double acd = rs.getDouble("AD");
//                        Double lr = l-acd;
//                        String ag = rs.getString("AssetGroup");
//                        
//                        String insert = "INSERT INTO cost (Code, Zone, Branch, AssetGroup, AC, DepExpense, AccuDep, LifeRemains, BookValue, Date, recordID) "
//                                + "VALUES('"+code[i]+"','"+zones[i]+"','"+branch[i]+"','"+ag+"',ROUND('"+bv+"',2),'"+depreciation[i]+"','"+ad+"','"+lr+"',ROUND('"+bv+"',2),'"+date+"',(SELECT recordID from record WHERE Code ='"+code[i]+"'))";
//                        pst = conn.prepareStatement(insert);
//                        pst.executeUpdate();
//                    }
//    
                    }
                }
                out.print(count + " row(s) Depreciated");
            }
   
            conn.commit();
            conn2.commit();
        }
        catch(SQLException e)
        {
            out.print(e.fillInStackTrace());
        }
        finally
        {
            if (rs != null) try { rs.close(); } catch (SQLException e) {e.printStackTrace();}
            if (pst != null) try { pst.close(); } catch (SQLException e) {e.printStackTrace();}
            if (conn != null) try { conn.close(); } catch (SQLException e) {e.printStackTrace();}
        }
        
    }
}

