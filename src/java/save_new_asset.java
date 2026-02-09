/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import db.DataSource;
import db.matic_fs;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig()
@WebServlet("/save_new_asset")
public class save_new_asset extends HttpServlet {
private static final long serialVersionUID = 1L;
    Connection conn;
    Connection conn2;
    PreparedStatement pst;
    ResultSet rs;
    int getValue = 0;
   
 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        
        request.setCharacterEncoding("UTF-8");
        String zone_asset = request.getParameter("zone");
        String region_asset = request.getParameter("region");
        String asset_branch = request.getParameter("branch_name_insert");
        String asset_branch_code = String.format("%04d", Integer.valueOf(request.getParameter("asset_branch_id_insert").trim()));
        String cc = request.getParameter("asset_branch_id_insert");
        String branch_asset = request.getParameter("branch");
        String ref_id = request.getParameter("ref_id");
        String asset_cat = request.getParameter("asset_cat");
        String asset_code = request.getParameter("asset_code");
        String asset_code_insert = request.getParameter("asset_code_insert");
        String desc = request.getParameter("desc");
        String date_rec = request.getParameter("date_rec");
        String aqui_cost = request.getParameter("aqui_cost");
        String scrap_value = request.getParameter("scrap_value");
        String dep_date = request.getParameter("dep_date");
        String life_asset = request.getParameter("life");
        String retire_date = request.getParameter("retire_date");

        Double ac_asset = Double.valueOf(aqui_cost);
        Double lif_asset = Double.valueOf(life_asset);
        Double sv_asset = Double.valueOf(scrap_value);
        Double de_asset = (ac_asset-sv_asset)/lif_asset;

        final PrintWriter writer = response.getWriter();
        generatecode("SELECT COUNT(Code)+1 from branch_asset_record");
        String code = String.format("%06d", getValue);
        String asset_codes = asset_code_insert+"-"+asset_branch_code+"-"+code; 
        
        String root = getServletContext().getRealPath("/");
        File f = new File(root+"./files/template.pdf");
        FileInputStream fs = new FileInputStream(f); 

        try
        {  
            conn2 = matic_fs.getConnection();
            conn2.setAutoCommit(false);
            
            if(request.getParameter("submit_asset")!=null)
            {
                
                    String i = "INSERT INTO fs.branch_asset_record (Code,Zone,Region,Branch,CostCenter,AssetGroup,AssetDescription,\n" +
                               "Reference,Aquisition_Cost,ScrapValue,DatePurchased,Life,DepreciationDate,DE,RetireDate,File,Status)\n" +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
                    pst = conn2.prepareStatement(i);
                    pst.setString(1 ,asset_codes);
                    pst.setString(2, zone_asset);
                    pst.setString(3, region_asset);
                    pst.setString(4, asset_branch);
                    pst.setString(5, cc);
                    pst.setString(6, asset_cat);
                    pst.setString(7, desc);
                    pst.setString(8, ref_id); 
                    pst.setString(9, aqui_cost);
                    pst.setString(10, scrap_value);
                    pst.setString(11, date_rec);
                    pst.setString(12, life_asset);
                    pst.setString(13, dep_date);
                    pst.setDouble(14, de_asset);
                    pst.setString(15, retire_date);
                    pst.setBlob(16, fs);
                    pst.setString(17, "Active");
                    pst.executeUpdate();
                    
//                    //get the id 
                    String query="SELECT recordID from branch_asset_record WHERE Code='"+asset_codes+"'";
                    pst = conn2.prepareStatement(query);
                    rs = pst.executeQuery();
                    if(rs.next())
                    {
                        String isa="INSERT INTO branch_asset_cost(Code,Zone,Branch,AssetGroup,AC,DepExpense,AccuDep,LifeRemains,BookValue,Date,recordID)"
                                + "values('"+asset_codes+"','"+zone_asset+"','"+asset_branch+"','"+asset_cat+"','"+aqui_cost+"',ROUND('"+de_asset+"',2),0.00,'"+life_asset+"','"+aqui_cost+"','"+date_rec+"',"
                                + "'"+rs.getInt("recordID")+"')";
                        pst = conn2.prepareStatement(isa);
                        pst.executeUpdate();
                    }
//                    
//                    //save to FS
                    String glcodeneto = "0000000";
                    if(asset_cat.equals("Computer Equipment and Peripherals")){
                        glcodeneto = "125102";  
                    }
                    else if(asset_cat.equals("Appraisal Tools")){
                        glcodeneto = "125102";  
                    }
                    else if(asset_cat.equals("Dealer Incentives")){
                        glcodeneto = "116109";  
                    }
                    else if(asset_cat.equals("Furnitures and Fixtures")){
                        glcodeneto = "125101";  
                    }
                    else if(asset_cat.equals("Goodwill")){
                        glcodeneto = "129104";  
                    }
                    else if(asset_cat.equals("Leasehold Improvement")){
                        glcodeneto = "123102"; 
                    }
                    else if(asset_cat.equals("Office Equipment")){
                        glcodeneto = "125102";  
                    }
                    else if(asset_cat.equals("Mobile Van / Kiosk")){
                        glcodeneto = "122101";  
                    }
                    else if(asset_cat.equals("Prepaid ADS")){
                        glcodeneto = "116104";
                    }
                    else if(asset_cat.equals("Pre-Operating Expense")){
                        glcodeneto = "116102";  
                    }
                    else if(asset_cat.equals("Prepaid Rentals")){
                        glcodeneto = "116101";  
                    }
                    else if(asset_cat.equals("Repair and Maintenance")){
                        glcodeneto = "116106";  
                    }
                    else if(asset_cat.equals("Service Vehicle")){
                        glcodeneto = "124101"; 
                    }
                    else if(asset_cat.equals("Softwares")){
                        glcodeneto = "116104";  
                    }
                    else if(asset_cat.equals("T-Shirts/Flyers/Calendar")){
                        glcodeneto = "1040002";  
                    }
                    
                    String select_area = "SELECT Area from fs.vw_new_branch_record WHERE Zone = ? and Region = ? and BranchCode = ? ";
                    pst = conn.prepareStatement(select_area);
                    pst.setString(1, zone_asset);
                    pst.setString(2, region_asset);
                    pst.setString(3, cc);
                    rs = pst.executeQuery();
                    if(rs.next()){
                        
                        String area = rs.getString("Area");
                        Double asset_amount = Double.valueOf(aqui_cost);
                        
                        String sql = "INSERT INTO fs.fs_book (date,zone_id,region_id,area_id,branch_id,code_id,total_amount,category,status)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        pst = conn.prepareStatement(sql);
                        pst.setString(1, date_rec);
                        pst.setString(2, zone_asset);
                        pst.setString(3, region_asset);
                        pst.setString(4, area);
                        pst.setString(5, cc);
                        pst.setString(6, glcodeneto);
                        pst.setDouble(7, asset_amount);
                        pst.setString(8, "Acquisition");
                        pst.setInt(9, 0);
                        pst.executeUpdate();

                        String sqls = "INSERT INTO fs.fs_book (date,zone_id,region_id,area_id,branch_id,code_id,total_amount,category,status)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        pst = conn.prepareStatement(sqls);
                        pst.setString(1, date_rec);
                        pst.setString(2, zone_asset);
                        pst.setString(3, region_asset);
                        pst.setString(4, area);
                        pst.setString(5, cc);
                        pst.setString(6, "311401");
                        pst.setDouble(7, asset_amount);
                        pst.setString(8, "Acquisition");
                        pst.setInt(9, 0);
                        pst.executeUpdate();
                    
                   }
                    
            }
            response.sendRedirect("fs_bookkeeping/homepage.jsp?message=success");
            conn2.commit();
        }
       catch(NumberFormatException | SQLException e) {
            writer.print("Issues: " + e.fillInStackTrace());
        }
        finally
        {
            if (rs != null) try { rs.close(); } catch (SQLException e) {e.printStackTrace();}
            if (pst != null) try { pst.close(); } catch (SQLException e) {e.printStackTrace();}
            if (conn != null) try { conn.close(); } catch (SQLException e) {e.printStackTrace();}
        }
        
    }

    public void generatecode(String passQuery)
{
    try
    {
        conn = DataSource.getConnection();
        pst = conn.prepareStatement(passQuery);
        rs = pst.executeQuery();
        if(rs.next())
        {
            getValue = Integer.parseInt(rs.getString(1));
        }
    }
    catch(Exception e)
    {
        
    }
    
}
    private static String getFilename(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
       
    }
}
