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
@WebServlet("/fs_rent_gl_checking")
public class fs_rent_gl_checking extends HttpServlet {

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
            String gl_check_date_from = request.getParameter("gl_check_date_from");
            String gl_check_date_to   = request.getParameter("gl_check_date_to");
            String gl_check_zones     = request.getParameter("gl_check_zones");
            String gl_check_region    = request.getParameter("gl_check_region");
            String gl_check_gl_from   = request.getParameter("gl_check_gl_from");
            String gl_check_gl_to     = request.getParameter("gl_check_gl_to");

            /* DEBUG */
            System.out.println("ACTION: " + action);
            System.out.println("DATE FROM : " + gl_check_date_from);
            System.out.println("DATE TO   : " + gl_check_date_to);
            System.out.println("ZONE      : " + gl_check_zones);
            System.out.println("REGION    : " + gl_check_region);
            System.out.println("GL FROM   : " + gl_check_gl_from);
            System.out.println("GL TO     : " + gl_check_gl_to);

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
