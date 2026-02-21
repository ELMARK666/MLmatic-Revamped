import db.matic_fs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/GetBranchData")
public class GetBranchData extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        JSONArray dataArray = new JSONArray();

        int draw = Integer.parseInt(request.getParameter("draw"));
        int start = Integer.parseInt(request.getParameter("start"));
        int length = Integer.parseInt(request.getParameter("length"));
        String searchValue = request.getParameter("search[value]");
        String orderColumnIndex = request.getParameter("order[0][column]");
        String orderDir = request.getParameter("order[0][dir]");

        String[] columns = {
            "Zone", "ZoneName", "Region", "RegionName",
            "Area", "AreaName", "BranchID", "BranchCode",
            "Branch", "Status"
        };

        int recordsTotal = 0;
        int recordsFiltered = 0;

        try {
            conn = matic_fs.getConnection();

            // 1️⃣ Get total record count
            String totalQuery = "SELECT COUNT(*) FROM vw_new_branch_record";
            pstmt = conn.prepareStatement(totalQuery);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                recordsTotal = rs.getInt(1);
            }
            rs.close();
            pstmt.close();

            // 2️⃣ Build search condition
            String searchSql = "";
            if (searchValue != null && !searchValue.trim().isEmpty()) {
                searchSql = " WHERE Zone LIKE ? OR ZoneName LIKE ? OR RegionName LIKE ? OR Branch LIKE ? ";
            }

            // 3️⃣ Get filtered count
            String countFilteredQuery = "SELECT COUNT(*) FROM vw_new_branch_record" + searchSql;
            pstmt = conn.prepareStatement(countFilteredQuery);

            if (!searchSql.isEmpty()) {
                String searchPattern = "%" + searchValue + "%";
                for (int i = 1; i <= 4; i++) {
                    pstmt.setString(i, searchPattern);
                }
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                recordsFiltered = rs.getInt(1);
            }
            rs.close();
            pstmt.close();

            // 4️⃣ Main data query with order + limit
            String orderBy = " ORDER BY " + columns[Integer.parseInt(orderColumnIndex)] + " " + orderDir;
            String limit = " LIMIT ?, ?";

            String dataQuery = "SELECT Zone, ZoneName, Region, RegionName, Area, AreaName, BranchID, BranchCode, Branch, Status "
                    + "FROM vw_new_branch_record"
                    + searchSql
                    + orderBy
                    + limit;

            pstmt = conn.prepareStatement(dataQuery);

            int paramIndex = 1;

            if (!searchSql.isEmpty()) {
                String searchPattern = "%" + searchValue + "%";
                for (int i = 0; i < 4; i++) {
                    pstmt.setString(paramIndex++, searchPattern);
                }
            }

            pstmt.setInt(paramIndex++, start);
            pstmt.setInt(paramIndex, length);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                JSONObject row = new JSONObject();
                row.put("Zone", rs.getString("Zone"));
                row.put("ZoneName", rs.getString("ZoneName"));
                row.put("Region", rs.getString("Region"));
                row.put("RegionName", rs.getString("RegionName"));
                row.put("Area", rs.getString("Area"));
                row.put("AreaName", rs.getString("AreaName"));
                row.put("BranchID", rs.getString("BranchID"));
                row.put("BranchCode", rs.getString("BranchCode"));
                row.put("Branch", rs.getString("Branch"));
                row.put("Status", rs.getString("Status"));

                dataArray.put(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        // 5️⃣ Final JSON response
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("draw", draw);
        jsonResponse.put("recordsTotal", recordsTotal);
        jsonResponse.put("recordsFiltered", recordsFiltered);
        jsonResponse.put("data", dataArray);

        out.print(jsonResponse.toString());
        out.flush();
    }
}