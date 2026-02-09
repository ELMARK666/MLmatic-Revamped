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
@WebServlet("/fs_ho_current")
public class fs_ho_current extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        Connection conn = null;

        try {
            conn = matic_fs.getConnection();

            // PARAMETERS (MATCH AJAX EXACTLY)
            String action                  = request.getParameter("action");
            String ho_current_date_gl_from = request.getParameter("ho_current_date_gl_from"); // RAW
            String ho_current_date_gl_to   = request.getParameter("ho_current_date_gl_to");   // RAW
            String ho_current_zones        = request.getParameter("ho_current_zones");
            String ho_current_criteria     = request.getParameter("ho_current_criteria");
            String ho_current_region       = request.getParameter("ho_current_region");
            String ho_current_gl           = request.getParameter("ho_current_gl");
            String ho_current_category     = request.getParameter("ho_current_category");

            /* DEBUG */
            System.out.println("ACTION      : " + action);
            System.out.println("DATE FROM   : " + ho_current_date_gl_from);
            System.out.println("DATE TO     : " + ho_current_date_gl_to);
            System.out.println("ZONE        : " + ho_current_zones);
            System.out.println("CRITERIA    : " + ho_current_criteria);
            System.out.println("REGION      : " + ho_current_region);
            System.out.println("GL CODE     : " + ho_current_gl);
            System.out.println("CATEGORY    : " + ho_current_category);

            /* TEMP OUTPUT */
            out.print("<tr><td colspan='5' style='text-align:center;'>YES</td></tr>");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<tr><td colspan='5' style='text-align:center;'>Error: "
                    + e.getMessage() + "</td></tr>");
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception ignored) {}
            out.close();
        }
    }
}

