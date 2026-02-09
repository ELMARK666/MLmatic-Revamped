/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 */

import db.matic_fs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ELMARK
 */
@WebServlet("/fs_allocated_expenses")
public class fs_allocated_expenses extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        String ledger = request.getParameter("ledger");

        try {
            conn = matic_fs.getConnection();

            String action = request.getParameter("action");
            String allocated_date_from = request.getParameter("allocated_date_from");
            String allocated_date_to   = request.getParameter("allocated_date_to");
            String allocated_zones     = request.getParameter("allocated_zones");
            String allocated_region    = request.getParameter("allocated_region");

            /* DEBUG */
            System.out.println("ACTION: " + action);
            System.out.println("DATE FROM : " + allocated_date_from);
            System.out.println("DATE TO   : " + allocated_date_to);
            System.out.println("ZONE      : " + allocated_zones);
            System.out.println("REGION    : " + allocated_region);

            /* TEMP OUTPUT TEST */
            out.print("<tr><td colspan='5' style='text-align:center;'>YES</td></tr>");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<tr><td colspan='5' style='text-align:center;'>Error: "
                    + e.getMessage() + "</td></tr>");
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ex) {}
            out.close();
        }
    }
}
