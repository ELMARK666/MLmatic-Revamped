<!--main header-->
<div class="header">
    <a href="#" class="menu-item" data-target="home"><i class="fas fa-home"></i> Home</a>
    <a href="#" class="menu-item" data-target="bookkeeping"><i class="fas fa-eye"></i> Bookkeeping</a>
    <a href="#" class="menu-item" data-target="generalledger"><i class="fas fa-cog"></i> General Ledger</a>
    <a href="#" class="menu-item" data-target="financialreports"><i class="fas fa-cog"></i> Financial Reports</a>
    <a href="#" class="menu-item" data-target="analysis"><i class="fas fa-cog"></i> Analysis</a>
    <a href="#" class="menu-item" data-target="fsarchive"><i class="fas fa-cog"></i> FS Archive</a>
    <a href="#" class="menu-item" data-target="settings"><i class="fas fa-cog"></i> Settings</a>
    <a href="#" class="menu-item" data-target="Logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    <img src="../style/image/faq.png" alt="Logo" style = "float: left; margin-left: 10px;  height: 40px;" />
</div>
<div class="dashboard">
    <div class="container" id="welcomeContainer">
        <h1>Welcome!</h1><br>
        <div class="section">
            <h4>Checklist</h4>
            <p class="indent">Reports Completion</p>
            <p class="indent">Cash on Hand</p>
            <p class="indent">Cash In Bank</p>
            <p class="indent">Receivables</p>
            <p class="indent">Inventory</p>
            <p class="indent">Fixed Assets</p>
        </div>
        <div class="section">
            <h4>Accrual Monitoring</h4>
            <p class="indent">911 Alarm / SSMI</p>
            <p class="indent">Rental</p>
            <p class="indent">Security Guard</p>
            <p class="indent">Smart</p>
        </div>
        <div class="section">
            <h4>Notes</h4>
        </div>
        <div class="section">
            <h4>Leave Schedule</h4>
        </div>
    </div>
    <div class="charts">
        <div class="container" id="pieContainer">
            <h3>Report Status</h3>
        </div>
        <div class="container" id="barContainer">
            <h3>Bookkeepers' Performance</h3>
        </div>
    </div>
    <div class="container" id="welcomeContainerRight">
        <br><br><br><br>
        <h2>Reminders / Advisories</h2>
        <div class="section">
            <p class="indent">a. Make sure that there is a report for fleet card;</p>
            <p class="indent">b. Make sure to check permits;</p>
            <p class="indent">c. Review regions with allocation;</p>
            <p class="indent">d. Ask for credit card charges and additional charge;</p>
        </div>
        <div class="section">
            <p class="indent">e. 1% credit card add-on rate is not recorded, this is for the bank.</p>
            <p class="indent">f. Allowed categories for multi-adjustments</p>
        </div>
        <div class="section">
            <p class="indent">g. No approval of leave/overtime, if bookkeeper fails to update this file.</p>
            <p class="indent">i. Record CTPL insurance incentives for officers, on item setup request.</p>
            <p class="indent">k. Report for Live Selling for HO recording only.</p>
        </div>
    </div>
</div>
<!--2nd header-->
<div class="sub-header" id="subHeader" style="display:none;">
    <div id="bookkeepingMenu" class="submenu">
        <a href="#" class="submenu-item" data-sub="dataentry">Data Entry</a>
        <a href="#" class="submenu-item" data-sub="ediupload">EDI Upload</a>
        <a href="#" class="submenu-item" data-sub="assetregistration">Asset Registration</a>
        <a href="#" class="submenu-item" data-sub="rentalupdate">Rental Update</a>
        <a href="#" class="submenu-item" data-sub="allocation">Allocation</a>
        <a href="#" class="submenu-item" data-sub="datachecking">Data Checking</a>
        <a href="#" class="submenu-item" data-sub="adjustment">Adjustment</a>
        <a href="#" class="submenu-item" data-sub="datareconciliation">Data Reconciliation</a>
        <a href="#" class="submenu-item" data-sub="datastatus">Data Status</a>
        <a href="#" class="submenu-item" data-sub="monthyearendclosing">Month / Year End Closing</a>
    </div>
    <div id="generalledgerMenu" class="submenu" style="display:none;">
        <a href="#" class="submenu-item" data-sub="glcards">GL Cards</a>
        <a href="#" class="submenu-item" data-sub="accountbalance">Account Balance</a>
    </div>
    <div id="financialreportsMenu" class="submenu" style="display:none;">
        <a href="#" class="submenu-item" data-sub="balancesheet">Balance Sheet</a>
        <a href="#" class="submenu-item" data-sub="incomestatement">Income Statement</a>
        <a href="#" class="submenu-item" data-sub="otherreports">Other Reports</a>
    </div>
    <div id="analysisMenu" class="submenu" style="display:none;">
        <div class="dropdown">
            <a href="#" class="popup-link" data-popup="#narrativereportPopup">Narrative Report</a>
        </div>
        <div id="narrativereportPopup" class="popup-container" style="display:none; flex-direction: column; gap: 10px;">
            <div class="form-row" style="display:flex; gap:10px; flex-wrap:nowrap; align-items:center;">
                <select class="form-control date_start" name="losing_month1" required></select>
                <select class="form-control date_end" name="losing_month2" required></select>
                <select class="form-control year_select" name="losing_year" required>
                    <option value="">YYYY</option>
                </select>
                <select class="form-control zone-select" id="losing_zones" name="losing_zones"></select>
                <select class="form-control region-select" id="losing_region" name="losing_region"></select>
                <button type="submit" class="form-control" id="losing_load" name="losing_load">Search</button>
                <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel</button>
            </div>
        </div>
    </div>
    <div id="fsarchiveMenu" class="submenu" style="display:none;">
        <a href="#" class="submenu-item" data-sub="archivebalancesheet">Balance Sheet</a>
        <a href="#" class="submenu-item" data-sub="archiveincomestatement">Income Statement</a>
    </div>
    <div id="settingsMenu" class="submenu" style="display:none;">
        <a href="#" class="submenu-item" data-sub="records">Records</a>
        <a href="#" class="submenu-item" data-sub="user">User</a>
    </div>
</div>
<!--3rd header-->
<div class="sub-sub-header" id="subSubHeader" style="display:none;">
    <!--bookkeeping-->
    <div id="dataentry" class="subsubmenu" style="display:none;">
        <a href="#" id="gleWebLink">GLE Web</a>
        <a href="#" id="onlinebcadataLink">Online BCA Data</a>
        <a href="#" id="postodistransactionLink">Post ODIS Transaction</a>
    </div>
    <div id="ediupload" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="hotransactionLink">HO Transactions</a>
    </div>
    <div id="assetregistration" class="subsubmenu" style="display:none; align-items: center;">
        <a href="#" id="registrationLink">Registration</a>
        <a href="#" id="generationLink">Generation</a>
        <a href="#" id="managementLink">Management</a>
    </div>
    <div id="rentalupdate" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="importdataLink">Import Data</a>
        <a href="#" id="viewimportdataLink">View Imported Data</a>
    </div>
    <div id="allocation" class="subsubmenu" style="display:none;">
        <a href="#" id="branchexpenseLink">Branch Expense</a>
        <a href="#" id="crrfliquidationLink">CRRF Liquidation</a>
        <a href="#" id="smartplanholdersLink">Smart Planholders</a>
        <a href="#" id="edireportLink">EDI Report</a>
    </div>
    <div id="datachecking" class="subsubmenu" style="display: none;">
<!--        <a href="#" id="errorcorporateaccountsLink">Error Corporate Accounts</a>-->
        <a href="#" id="incomeexpenseaccountsLink">Income/Expense Accounts</a>
        <a href="#" id="spcostingLink">SP Costing</a>
        <a href="#" id="sundryaccountLink">Sundry Account</a>
    </div>
    <div id="adjustment" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="singleinputajeLink">Single Input AJE</a>
        <a href="#" id="multiloadajeLink">Multi Load AJE</a>
        <a href="#" id="outputtaxreversalLink">Output Tax Reversal</a>
    </div>
    <div id="datareconciliation" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="drcashbalanceLink">Cash Balance</a>
        <a href="#" id="bankbalanceLink">Bank Balance</a>
        <a href="#" id="drreceivablesLink">Receivables</a>
        <a href="#" id="qclinterestLink">QCL Interest</a>
        <a href="#" id="billspaymentLink">Bills Payment</a>
        <a href="#" id="corporatepaymentLink">Corporate Payout</a>
        <a href="#" id="paymentsolutionsLink">Payment Solutions</a>
        <a href="#" id="jewelrysalesLink">Jewelry Sales</a>
        <a href="#" id="ispdinsurancesalesLink">ISPD Insurance Sales</a>
        <a href="#" id="ispdincentivesLink">ISPD Incentives</a>
    </div>
    <div id="datastatus" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="dataperdateLink">Data per Date</a>
        <a href="#" id="webdataLink">Web Data</a>
    </div>
    <div id="monthyearendclosing" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="incomesummarypostingLink">Income Summary Posting</a>
        <a href="#" id="yearendclosingLink">Year End Closing</a>
    </div>
    <!--general ledger-->
    <div id="glcards" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="peraccountsLink">Per Accounts</a>
        <a href="#" id="percategoryLink">Per Category</a>
        <a href="#" id="perrangeLink">Per Range</a>
    </div>
    <div id="accountbalance" class="subsubmenu" style="display:none; display: flex; gap: 30px; align-items: center;">
        <a href="#" id="checkglbalanceLink">Check Teller Balance</a>
        <a href="#" id="hocurrentLink">HO Current (Due to/from)</a>
        <a href="#" id="allocatedexpensesLink">Allocated Expenses</a>
        <a href="#" id="glcheckingLink">GL Checking</a>
    </div>
    <!--financial reports-->
    <div id="balancesheet" class="subsubmenu" style="display:none;">
        <a href="#" id="bsgeneralbalancesheetLink">General Balance Sheet</a>
        <a href="#" id="horizontalbalancesheetLink">Horizontal Balance Sheet</a>
        <a href="#" id="verticalbalancesheetLink">Vertical Balance Sheet</a>
        <a href="#" id="bylevelbalancesheetLink">By Level Balance Sheet</a>
    </div>
    <div id="incomestatement" class="subsubmenu" style="display:none;">
        <a href="#" id="isgeneralincomestatementLink">General Income Statement</a>
        <a href="#" id="horizontalincomestatementLink">Horizontal Income Statement</a>
        <a href="#" id="verticalincomestatementLink">Vertical Income Statement</a>
        <a href="#" id="bylevelincomestatementLink">By Level Income Statement</a>
        <a href="#" id="monthlybranchincomestatementLink">Monthly Branch Income Statement</a>
    </div>
    <div id="otherreports" class="subsubmenu" style="display:none;">
        <a href="#" id="grossrevenueLink">Gross Revenue</a>
        <a href="#" id="incomesummaryLink">Income Summary</a>
        <a href="#" id="losingbranchesLink">Losing Branches</a>
        <a href="#" id="orcashbalanceLink">Cash Balance</a>
        <a href="#" id="orbankbalanceLink">Bank Balance</a>
        <a href="#" id="orreceivablesLink">Receivables</a>
    </div>
    <!--fs archive-->
    <div id="archivebalancesheet" class="subsubmenu" style="display:none;">
        <a href="#" id="absgeneralbalancesheetLink">General Balance Sheet</a>
    </div>
    <div id="archiveincomestatement" class="subsubmenu" style="display:none;">
        <a href="#" id="aisgeneralincomestatementLink">General Income Statement</a>
    </div>
    <!--settings-->
    <div id="records" class="subsubmenu" style="display:none;">
        <a href="#" id="branchlistLink">Branch List</a>
        <a href="#" id="glaccountLink">GL Account</a>
    </div>
    <div id="user" class="subsubmenu" style="display:none;">
        <a href="#" id="passwordchangeLink">Password Change</a>
    </div>
</div>

<div class="edi-logs" id="ediLogs" style="max-height: 700px; display:none;">
    <br><br>
    <div class="edi-container">
        
        <!-- Table 1 -->
        <div class="edi-table-wrapper table1" style="overflow-y: auto; max-height: 750px;">
            <table class="table table-bordered table-hover edi-table" style="width:100%; border-collapse: collapse;">
                <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                    <tr><th colspan="2" class="nameofregion1">Region :</th></tr>
                    <tr>
                        <th>Branches</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody class="narrativereport_report_1">
                    <tr><td colspan="4"><center>- No Data -</center></td></tr>
                </tbody>
            </table>
        </div>

        <!-- Table 2 -->
        <div class="edi-table-wrapper table2 " style="overflow-y: auto; max-height: 750px;">
            <table class="table table-bordered table-hover edi-table" style="width:100%; border-collapse: collapse;">
                <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                    <tr>
                        <th class="nameofbranch"></th>
                        <th colspan="2" class="em" style="text-align: center;"></th>
                        <th colspan="2" class="mm" style="text-align: center;"></th>
                        <th colspan="2" class="sm" style="text-align: center;"></th>
                    </tr>
                    <tr>
                        <th style="text-align: center;">Particular</th>
                        <th style="text-align: center;">Amount</th>
                        <th style="text-align: center;">%</th>
                        <th style="text-align: center;">Amount</th>
                        <th style="text-align: center;">%</th>
                        <th style="text-align: center;">Amount</th>
                        <th style="text-align: center;">%</th>
                    </tr>
                </thead>
                <tbody class="narrativereport_report_2">
                    <tr><td colspan="7"><center>- No Data -</center></td></tr>
                </tbody>
            </table>
        </div>

        <!-- Table 3 -->
        <div class="edi-table-wrapper table3" style="overflow-y: auto; max-height: 740px;">
            <table class="table table-bordered table-hover edi-table" style="width:100%; border-collapse: collapse;">
                <tbody class="narrativereport_report_3" style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                    <tr>
                        <td colspan='3'><center>- No Narrative Performance Report Generated -</center></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

