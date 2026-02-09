import db.matic_fs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.time.YearMonth;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Horizontalbalance_comparative")
public class Horizontalbalance_comparative extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter write = response.getWriter();
        
        Connection conn = null;
        PreparedStatement pstRev = null;
        PreparedStatement pstExp = null;
        ResultSet rsRev = null;
        ResultSet rsExp = null;
        
        String m1 = request.getParameter("month1");
        String yy = request.getParameter("year1");
        String m2 = request.getParameter("month2");
        String yy2 = request.getParameter("year2");
        String m3 = request.getParameter("month3");
        String yy3 = request.getParameter("year3");
        String z = request.getParameter("zone");
        String r = request.getParameter("region");
        String b = request.getParameter("branch");
        String c = request.getParameter("code");
        String f = request.getParameter("group");
        
        int month = Integer.parseInt(m1);
        int year = Integer.parseInt(yy);
        YearMonth ym = YearMonth.of(year, month);
        String startDate = String.format("%04d-%02d-01", year, month);
        String endDate = String.format("%04d-%02d-%02d", year, month, ym.lengthOfMonth());
        
        int month2 = Integer.parseInt(m2);
        int year2 = Integer.parseInt(yy2);
        YearMonth ym2 = YearMonth.of(year2, month2);
        String startDate2 = String.format("%04d-%02d-01", year2, month2);
        String endDate2 = String.format("%04d-%02d-%02d", year2, month2, ym2.lengthOfMonth());
        
        int month3 = Integer.parseInt(m3);
        int year3 = Integer.parseInt(yy3);
        YearMonth ym3 = YearMonth.of(year3, month3);
        String startDate3 = String.format("%04d-%02d-01", year3, month3);
        String endDate3 = String.format("%04d-%02d-%02d", year3, month3, ym3.lengthOfMonth());
        
        try
        {
            String sql = "";
            String sqls = "";
            Double rev3 = 0.0;
            Double rev2 = 0.0;
            Double rev1 = 0.0;
            Double exp3 = 0.0;
            Double exp2 = 0.0;
            Double exp1 = 0.0;
            conn = matic_fs.getConnection();
            Statement stmt = conn.createStatement();
            stmt.execute("SET sql_mode = ''");
                
            sql = "CALL HbalanceRevenue(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstRev = conn.prepareStatement(sql);
            pstRev.setString(1, r);
            pstRev.setString(2, b);
            pstRev.setString(3, f);
            pstRev.setString(4, z);
            pstRev.setString(5, startDate);
            pstRev.setString(6, endDate);
            pstRev.setString(7, startDate2);
            pstRev.setString(8, endDate2);
            pstRev.setString(9, startDate3);
            pstRev.setString(10, endDate3);
            
            rsRev = pstRev.executeQuery();

            while (rsRev.next()) {
                String code = rsRev.getString("Code").replace(".0", "");
                String description = rsRev.getString("Description");
                String amountM1 = rsRev.getString("AmountM1");
                String amountM2 = rsRev.getString("AmountM2");
                String amountM3 = rsRev.getString("AmountM3");
                
                double amountm1 = roundToTwoDecimals(Double.parseDouble(amountM1.replace(",", "")));
                double amountm2 = roundToTwoDecimals(Double.parseDouble(amountM2.replace(",", "")));
                double amountm3 = roundToTwoDecimals(Double.parseDouble(amountM3.replace(",", "")));

                double total2 = amountm3 - amountm1;
                double total3 = amountm3 - amountm2;
                
                double percents2 = (total2 != 0) ? (total2 / amountm1) * 100 : 0.0;
                double percents3 = (total3 != 0) ? (total3 / amountm2) * 100 : 0.0;

                
                if (Double.isNaN(percents2) || Double.isInfinite(percents2)) {
                    percents2 = 0.0;
                }
                if (Double.isNaN(percents3) || Double.isInfinite(percents3)) {
                    percents3 = 0.0;
                }
                
                String formattedAmount3 = formatAmount1WithColor(amountm3);
                String formattedAmount2 = formatAmount1WithColor(amountm2);
                String formattedAmount1 = formatAmount1WithColor(amountm1);
                String formattedtotal3 = formatAmount1WithColor(total3);
                String formattedtotal2 = formatAmount1WithColor(total2);
                String formattedPercent2 = formatPercent1WithColor(percents2);
                String formattedPercent3 = formatPercent1WithColor(percents3);

               
                sqls += "<tr><td>&nbsp;</td>"
                        + "<td>" + code + "</td>"
                        + "<td>" + description + "</td>"
                        + "<td style='text-align:right;'>" + formattedAmount3 + "</td>"
                        + "<td style='text-align:right;'>" + formattedAmount2 + "</td>"
                        + "<td style='text-align:right;'>" + formattedAmount1 + "</td>"
                        + "<td style='text-align:right;'>" + formattedtotal3+"</td>"
                        + "<td style='text-align:right;'>" + formattedPercent3 + "</td>"
                        + "<td style='text-align:right;'>" + formattedtotal2+"</td>"
                        + "<td style='text-align:right;'>" + formattedPercent2 + "</td>"
                        + "</tr>";
                
                rev3 += amountm3;
                rev2 += amountm2;
                rev1 += amountm1;
            }
            
                sqls +="<tr>"
                        + "<td colspan='3'><b>Revenue</b></td>"
                        + "<td style='text-align:right;font-weight: bold;'>"+String.format("%,.2f",rev3)+"</td>"
                        + "<td style='text-align:right;font-weight: bold;'>"+String.format("%,.2f",rev2)+"</td>"
                        + "<td style='text-align:right;font-weight: bold;'>"+String.format("%,.2f",rev1)+"</td>"
                    + "</tr>";
                
            String sql2 = "CALL HbalanceExpense(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pstExp = conn.prepareStatement(sql2);
                pstExp.setString(1, r);
                pstExp.setString(2, b);
                pstExp.setString(3, f);
                pstExp.setString(4, z);
                pstExp.setString(5, startDate);
                pstExp.setString(6, endDate);
                pstExp.setString(7, startDate2);
                pstExp.setString(8, endDate2);
                pstExp.setString(9, startDate3);
                pstExp.setString(10, endDate3);

                rsExp = pstExp.executeQuery();

                while (rsExp.next()) {
                    String amountStr1 = rsExp.getString("Amount_m1");
                    String amountStr2 = rsExp.getString("Amount_m2");
                    String amountStr3 = rsExp.getString("Amount_m3");
                    
                    double amount1 = roundToTwoDecimals(Double.parseDouble(amountStr1.replace(",", "")));
                    double amount2 = roundToTwoDecimals(Double.parseDouble(amountStr2.replace(",", "")));
                    double amount3 = roundToTwoDecimals(Double.parseDouble(amountStr3.replace(",", "")));

                    double tot2 = amount3 - amount1;
                    double tot3 = amount3 - amount2;
                    double percent2 = (amount1 != 0.00) ? (tot2 / amount1) * 100 : 0.00;
                    double percent3 = (amount2 != 0.00) ? (tot3 / amount2) * 100 : 0.00;

                    if (Double.isNaN(percent2) || Double.isInfinite(percent2) || amount1 == 0.00 && amount3 == 0.00) {
                        percent2 = 0.00;
                    }
                    if (Double.isNaN(percent3) || Double.isInfinite(percent3) || amount2 == 0.00 && amount3 == 0.00) {
                        percent3 = 0.00;
                    }
                    String formattedamount3 = formatAmountWithColor(amount3);
                    String formattedamount2 = formatAmountWithColor(amount2);
                    String formattedamount1 = formatAmountWithColor(amount1);
                    String formattedtot3 = formatAmountWithColor(tot3);
                    String formattedtot2 = formatAmountWithColor(tot2);
                    String formattedPercentage2 = formatPercentWithColor(percent2);
                    String formattedPercentage3 = formatPercentWithColor(percent3);
                    
                    sqls += "<tr><td>&nbsp;</td>"
                        + "<td>"+rsExp.getString("Code").replace(".0", "")+"</td>"
                        + "<td>"+rsExp.getString("Description")+"</td>"
                        + "<td style='text-align:right;'>"+formattedamount3+"</td>"
                        + "<td style='text-align:right;'>"+formattedamount2+"</td>"
                        + "<td style='text-align:right;'>"+formattedamount1+"</td>"
                        + "<td style='text-align:right;'>"+formattedtot3+"</td>"
                        + "<td style='text-align:right;'>"+formattedPercentage3+"</td>"
                        + "<td style='text-align:right;'>"+formattedtot2+"</td>"
                        + "<td style='text-align:right;'>"+formattedPercentage2+"</td>"
                        + "</tr>";
                    exp3 += amount3;
                    exp2 += amount2;
                    exp1 += amount1;
                }
                sqls += "<tr><td colspan='3'><b>Expense</b></td>"
                        + "<td style='text-align:right;font-weight: bold;'>"+String.format("%,.2f",exp3)+"</td>"
                        + "<td style='text-align:right;font-weight: bold;'>"+String.format("%,.2f",exp2)+"</td>"
                        + "<td style='text-align:right;font-weight: bold;'>"+String.format("%,.2f",exp1)+"</td>"
                        + "</tr>";
                Double net1 = rev1 - exp1;
                Double net2 = rev2 - exp2;
                Double net3 = rev3 - exp3;

                String netIncome1 = formatAmountWithColor(net1);
                String netIncome2 = formatAmountWithColor(net2);
                String netIncome3 = formatAmountWithColor(net3);

                sqls += "<tr>"
                        + "<td colspan='3'><b>NET Income</b></td>"
                        + "<td style='text-align:right;font-weight: bold;'>" + netIncome3 + "</td>"
                        + "<td style='text-align:right;font-weight: bold;'>" + netIncome2 + "</td>"
                        + "<td style='text-align:right;font-weight: bold;'>" + netIncome1 + "</td>"
                        + "<td style='text-align:right;font-weight: bold;'></td>"
                        + "<td style='text-align:right;font-weight: bold;'></td>"
                        + "<td style='text-align:right;font-weight: bold;'></td>"
                        + "<td style='text-align:right;font-weight: bold;'></td>"
                    + "</tr>";
                write.print(sqls);
        }catch (SQLException | NumberFormatException e) {
            write.print("<tr><td class='alert alert-danger alert-dismissible fade in' colspan='4'>"
                    + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
                    + "Sorry. Unable to process data. Please contact IT Support immediately. Issue : " + e.getMessage()
                    + "</td></tr>");
            e.printStackTrace();
        } finally {
            if (rsExp != null) {
                try {
                    rsExp.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstExp != null) {
                try {
                    pstExp.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } 
            if (rsRev != null) {
                try {
                    rsRev.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstRev != null) {
                try {
                    pstRev.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    private String formatAmountWithColor(double amount) {
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        if (amount < 0) {
            return "<font color='red'>(" + formatter.format(-amount) + ")</font>";
        } else {
            return formatter.format(amount);
        }
    }
    private String formatPercentWithColor(double percent) {
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        if (percent < 0) {
            return "<font color='red'>(" + formatter.format(-percent) + "%)</font>";
        } else {
            return formatter.format(percent) + "%";
        }
    }
     private String formatAmount1WithColor(double amount) {
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        if (amount < 0) {
            return "<font color='red'>(" + formatter.format(-amount) + ")</font>";
        } else {
            return formatter.format(amount);
        }
    }
    private String formatPercent1WithColor(double percent) {
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        if (percent < 0) {
            return "<font color='red'>(" + formatter.format(-percent) + "%)</font>";
        } else {
            return formatter.format(percent) + "%";
        }
    }
    private static double roundToTwoDecimals(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
}