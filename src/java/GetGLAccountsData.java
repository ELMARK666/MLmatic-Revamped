import db.matic_fs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/GetGLAccountsData")
public class GetGLAccountsData extends HttpServlet {

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
            "Code_ID", "GL_Account", "Code_Description",
            "Level_1", "Level_2", "Level_3", "Level_4",
            "FS_Account_Type", "Normal_Balance"
        };

        int recordsTotal = 0;
        int recordsFiltered = 0;

        try {
            conn = matic_fs.getConnection();

            // 1️⃣ Total records
            String totalQuery = "SELECT COUNT(*) FROM vw_gl_accounts";
            pstmt = conn.prepareStatement(totalQuery);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                recordsTotal = rs.getInt(1);
            }
            rs.close();
            pstmt.close();

            // 2️⃣ Search condition
            String searchSql = "";
            if (searchValue != null && !searchValue.trim().isEmpty()) {
                searchSql = " WHERE GL_Account LIKE ? OR Code_Description LIKE ? "
                          + "OR Level_1 LIKE ? OR Level_2 LIKE ? OR Level_3 LIKE ? OR Level_4 LIKE ? ";
            }

            // 3️⃣ Filtered count
            String countFilteredQuery = "SELECT COUNT(*) FROM vw_gl_accounts" + searchSql;
            pstmt = conn.prepareStatement(countFilteredQuery);

            if (!searchSql.isEmpty()) {
                String searchPattern = "%" + searchValue + "%";
                for (int i = 1; i <= 6; i++) {
                    pstmt.setString(i, searchPattern);
                }
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                recordsFiltered = rs.getInt(1);
            }
            rs.close();
            pstmt.close();

            // 4️⃣ Data query with order + limit
            String orderBy = " ORDER BY " 
                    + columns[Integer.parseInt(orderColumnIndex)] 
                    + " " + orderDir;

            String limit = " LIMIT ?, ?";

            String dataQuery = "SELECT Code_ID, GL_Account, Code_Description, "
                    + "Level_1, Level_2, Level_3, Level_4, "
                    + "FS_Account_Type, Normal_Balance "
                    + "FROM vw_gl_accounts"
                    + searchSql
                    + orderBy
                    + limit;

            pstmt = conn.prepareStatement(dataQuery);

            int paramIndex = 1;

            if (!searchSql.isEmpty()) {
                String searchPattern = "%" + searchValue + "%";
                for (int i = 0; i < 6; i++) {
                    pstmt.setString(paramIndex++, searchPattern);
                }
            }

            pstmt.setInt(paramIndex++, start);
            pstmt.setInt(paramIndex, length);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                JSONObject row = new JSONObject();
                row.put("Code_ID", rs.getString("Code_ID"));
                row.put("GL_Account", rs.getString("GL_Account"));
                row.put("Code_Description", rs.getString("Code_Description"));
                row.put("Level_1", rs.getString("Level_1"));
                row.put("Level_2", rs.getString("Level_2"));
                row.put("Level_3", rs.getString("Level_3"));
                row.put("Level_4", rs.getString("Level_4"));
                row.put("FS_Account_Type", rs.getString("FS_Account_Type"));
                row.put("Normal_Balance", rs.getString("Normal_Balance"));

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