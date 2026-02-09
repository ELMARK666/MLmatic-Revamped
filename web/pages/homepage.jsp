<%@ page import="java.sql.*" %>
<%@ page import="db.DataSource" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <title>Home</title>
        <meta charset="UTF-8">
        <meta name="description" content="M. Lhuillier Accounting Tool for CAD">
        <meta name="keywords" content="bookkeeping,reconciliation,consolidation,loading of parteners data">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="assets/images/favicon.ico">
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Ubuntu:300,300i,400,400i,500,500i,700,700i" rel="stylesheet">
        <link rel="stylesheet" href="../style/css/swiper.min.css">
        <link rel="stylesheet" href="../style/css/animate.css">
        <link rel="stylesheet" href="../style/css/iconfont.css">
        <link rel="stylesheet" href="../style/css/font-awesome.min.css">
        <link rel="stylesheet" href="../style/css/bootstrap.min.css">
        <script src="../style/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>
    </head>
    <jsp:include page="style.jsp" />
    <body>
        <jsp:include page="header.jsp" />  
        <jsp:include page="bookkeeping.jsp" /> 
        <jsp:include page="financialreports.jsp" /> 
        <jsp:include page="generalledger.jsp" /> 
    <footer>
        <p>&copy; M. Lhuillier Financial Services, Inc. All rights reserved.</p>
    </footer>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const headers = document.querySelectorAll(".menu-item");
            const subHeaders = document.getElementById("subHeader");
            const subSubHeaders = document.getElementById("subSubHeader");

            function hideAllSubmenus() {
                document.querySelectorAll(".submenu").forEach(menu => menu.style.display = "none");
                subHeaders.style.display = "none";
                subSubHeaders.style.display = "none";
                document.querySelectorAll(".subsubmenu").forEach(sub => sub.style.display = "none");
            }

            function removeActiveHeaders() {
                headers.forEach(h => h.classList.remove("active-link"));
                document.querySelectorAll(".submenu a, .subsubmenu a").forEach(link => {
                    link.classList.remove("active-link");
                    link.style.color = "";
                });
            }

            headers.forEach(header => {
                header.addEventListener("click", function(e) {
                    e.preventDefault();
                    const target = this.dataset.target;

                    removeActiveHeaders();
                    this.classList.add("active-link");

                    if (target === "home") {
                        hideAllSubmenus();
                        return;
                    }

                    const submenu = document.getElementById(target + "Menu");
                    if (!submenu) return;

                    subHeaders.style.display = "block";

                    document.querySelectorAll(".submenu").forEach(menu => {
                        menu.style.display = (menu === submenu && menu.style.display !== "block") ? "block" : "none";
                    });

                    subSubHeaders.style.display = "none";
                    document.querySelectorAll(".subsubmenu").forEach(sub => sub.style.display = "none");
                });
            });
            // Sub-header
            document.querySelectorAll(".submenu-item").forEach(item => {
                item.addEventListener("click", function(e) {
                    e.preventDefault();
                    const targetSub = this.dataset.sub;
                    const subsubmenu = document.getElementById(targetSub);
                    
                    // Reset to default
                    document.querySelectorAll(".subsubmenu a").forEach(link => {
                        link.classList.remove("active-link");
                        link.style.color = "black";
                        link.style.fontWeight = "normal";
                        link.style.textDecoration = "none";
                    });
                    //slightly inherit BG
                    document.querySelectorAll(".submenu a").forEach(link => {
                        if (link !== this) {
                            link.classList.remove("active-link");
                            link.style.color = getComputedStyle(link.parentElement).backgroundColor;
                            link.style.color = "rgba(0,0,0,0.2)";
                            link.style.fontWeight = "normal";
                            link.style.textDecoration = "none";
                        }
                    });

                    // Selected sub-header
                    this.classList.add("active-link");
                    this.style.color = "#000000"; 
                    this.style.fontWeight = "normal";
                    this.style.textDecoration = "none";

                    // Show/hide sub-subheaders
                    if (!subsubmenu) return;

                    document.getElementById("subSubHeader").style.display = "block";
                    document.querySelectorAll(".subsubmenu").forEach(sub => {
                        sub.style.display = (sub === subsubmenu && sub.style.display !== "flex" && sub.style.display !== "block") 
                            ? "flex" 
                            : "none";
                    });
                });
            });

            // Sub-sub-header
            document.querySelectorAll(".subsubmenu a").forEach(link => {
                link.addEventListener("click", function(e) {
                    e.preventDefault();

                    document.querySelectorAll(".subsubmenu a").forEach(l => {
                        if (l !== this) {
                            l.classList.remove("active-link");
                            l.style.color = getComputedStyle(l.parentElement).backgroundColor;
                            l.style.color = "rgba(0,0,0,0.2)";
                            l.style.fontWeight = "normal";
                            l.style.textDecoration = "none";
                        }
                    });

                    // Selected sub-sub-header
                    this.classList.add("active-link");
                    this.style.color = "#000000";
                    this.style.fontWeight = "normal";
                    this.style.textDecoration = "none";
                });
            });

            // Home dashboard
            const dashboard = document.querySelector(".dashboard");
            const allMenuLinks = document.querySelectorAll('.menu-item, .submenu a, .subsubmenu a, .sub-sub-header a');

            dashboard.style.display = "flex";
            allMenuLinks.forEach(link => {
                link.addEventListener("click", function(e) {
                    const target = this.dataset.target;
                    dashboard.style.display = (target === "home") ? "flex" : "none";
                });
            });

            // Logout
            const logoutLink = document.querySelector('[data-target="logout"]');
            if (logoutLink) {
                logoutLink.addEventListener("click", function(e) {
                    e.preventDefault();
                    window.location.href = "../Login/index.jsp";
                });
            }

            // Containers logic
            const containersMap = {
                gleWebLink: ".glecontainer",
                onlinebcadataLink: ".onlinebcadatacontainer",
                postodistransactionLink: ".postodistransactioncontainer",
                hotransactionLink: ".hotransactioncontainer",
                registrationLink: ".registrationcontainer",
                generationLink: ".generationcontainer",
                managementLink: ".managementcontainer",
                importdataLink: ".importdatacontainer",
                viewimportdataLink: ".viewimportdatacontainer",
                branchexpenseLink: ".branchexpensecontainer",
                crrfliquidationLink: ".crrfliquidationcontainer",
                smartplanholdersLink: ".smartplanholderscontainer",
                edireportLink: ".edireportcontainer",
                errorcorporateaccountsLink: ".errorcorporateaccountscontainer",
                incomeexpenseaccountsLink: ".incomeexpenseaccountscontainer",
                spcostingLink: ".spcostingcontainer",
                sundryaccountLink: ".sundryaccountcontainer",
                singleinputajeLink: ".singleinputajecontainer",
                multiloadajeLink: ".multiloadajecontainer",
                outputtaxreversalLink: ".outputtaxreversalcontainer",
                drcashbalanceLink: ".drcashbalancecontainer",
                bankbalanceLink: ".bankbalancecontainer",
                drreceivablesLink: ".drreceivablescontainer",
                qclinterestLink: ".qclinterestcontainer",
                billspaymentLink: ".billspaymentcontainer",
                corporatepaymentLink: ".corporatepaymentcontainer",
                paymentsolutionsLink: ".paymentsolutionscontainer",
                jewelrysalesLink: ".jewelrysalescontainer",
                ispdinsurancesalesLink: ".ispdinsurancesalescontainer",
                ispdincentivesLink: ".ispdincentivescontainer",
                dataperdateLink: ".dataperdatecontainer",
                webdataLink: ".webdatacontainer",
                incomesummarypostingLink: ".incomesummarypostingcontainer",
                yearendclosingLink: ".yearendclosingcontainer",
                
                peraccountsLink: ".peraccountscontainer",
                perrangeLink: ".perrangecontainer",
                percategoryLink: ".percategorycontainer",
                checkglbalanceLink: ".checkglbalancecontainer",
                hocurrentLink: ".hocurrentcontainer",
                allocatedexpensesLink: ".allocatedexpensescontainer",
                glcheckingLink: ".glcheckingcontainer",
                
                bsgeneralbalancesheetLink: ".bsgeneralbalancesheetcontainer",
                horizontalbalancesheetLink: ".horizontalbalancesheetcontainer",
                verticalbalancesheetLink: ".verticalbalancesheetcontainer",
                bylevelbalancesheetLink: ".bylevelbalancesheetcontainer",
                isgeneralincomestatementLink: ".isgeneralincomestatementcontainer",
                horizontalincomestatementLink: ".horizontalincomestatementcontainer",
                verticalincomestatementLink: ".verticalincomestatementcontainer",
                bylevelincomestatementLink: ".bylevelincomestatementcontainer",
                monthlybranchincomestatementLink: ".monthlybranchincomestatementcontainer",
                grossrevenueLink: ".grossrevenuecontainer",
                incomesummaryLink: ".incomesummarycontainer",
                losingbranchesLink: ".losingbranchescontainer",
                orreceivablesLink: ".orreceivablescontainer",
                orcashbalanceLink: ".orcashbalancecontainer",
                orbankbalanceLink: ".orbankbalancecontainer",
                
                absgeneralbalancesheetLink: ".absgeneralbalancesheetcontainer",
                aisgeneralincomestatementLink: ".aisgeneralincomestatementcontainer",
                
                branchlistLink: ".branchlistcontainer",
                glaccountLink: ".glaccountcontainer",
                passwordchangeLink: ".passwordchangecontainer"
            };

            function hideAllContainers() {
                Object.values(containersMap).forEach(selector => {
                    const container = document.querySelector(selector);
                    if (container) container.style.display = "none";
                });
            }

            Object.entries(containersMap).forEach(([linkId, containerSelector]) => {
                const link = document.getElementById(linkId);
                const container = document.querySelector(containerSelector);
                if (link && container) {
                    link.addEventListener("click", (e) => {
                        e.preventDefault();
                        hideAllContainers();
                        container.style.display = (container.style.display === "block") ? "none" : "block";
                    });
                }
            });

            allMenuLinks.forEach(link => {
                link.addEventListener('click', (e) => {
                    if (!Object.keys(containersMap).includes(link.id)) {
                        hideAllContainers();
                    }
                });
            });
            document.querySelectorAll(".popup-link").forEach(link => {
                link.addEventListener("click", function(e) {
                    e.preventDefault();
                    const popupSelector = this.dataset.popup; 
                    const popup = document.querySelector(popupSelector);
                    if (popup) {
                        popup.style.display = (popup.style.display === "flex") ? "none" : "flex";
                    }
                });
            });
        });
    </script>
    <!-- ANALYSIS -->
    <script>
        $(document).ready(function () {

            $(document).on("click", "#losing_load", function (e) {
                e.preventDefault();

                var losingMonth1 = parseInt($(".date_start").val()); 
                var losingMonth2 = parseInt($(".date_end").val());   
                var losingYear = parseInt($(".year_select").val());
                var losingZone = $("#losing_zones").val();
                var losingRegion = $("#losing_region").val();
                var selectedRegion = $("#losing_region option:selected").text();

                if (isNaN(losingMonth1) || isNaN(losingMonth2)) {
                    alert("Please select both start and end months.");
                    return;
                }

                var monthDiff = (losingMonth2 - losingMonth1 + 12) % 12;
                if (monthDiff !== 2) {
                    alert('The data could not be loaded. The comparison is limited to a three-month period.');
                    return;
                }

                var losingMonthMid = (losingMonth1 % 12) + 1; 
                var midYear = losingMonthMid <= losingMonth1 ? losingYear + 1 : losingYear;
                var endYear = losingMonth2 <= losingMonth1 ? losingYear + 1 : losingYear;

                $(".nameofregion1").text("Region: " + selectedRegion);

                $(".em").text(getMonthName(losingMonth2) + " " + endYear);    
                $(".mm").text(getMonthName(losingMonthMid) + " " + midYear);     
                $(".sm").text(getMonthName(losingMonth1) + " " + losingYear);       

                $("#narrativereportPopup").fadeOut(300, function () {
                    $(this).addClass("popup-hidden");
                });
                $("#ediLogs").css("margin-top", "-35px").fadeIn(300);

                $.ajax({
                    url: "../View_Details?data=view", 
                    type: "POST",
                    data: {
                        month1: losingMonth1,
                        midMonth: losingMonthMid,
                        month2: losingMonth2,
                        yearStart: losingYear,
                        yearMid: midYear,
                        yearEnd: endYear,
                        zone: losingZone,
                        region: losingRegion
                    },
                    success: function (response) {
                        $(".narrativereport_report_1").html(response || "<tr><td colspan='4'><center>- No Data -</center></td></tr>");
                        
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX Error:", error);
                    }
                });
            });
            $(document).on("click", ".view-details", function () {
                var branchid = $(this).data("branch");
                var branchName = $(this).closest("tr").find("td:first").text();
                var losingMonth1 = parseInt($(".date_start").val()); 
                var losingMonth2 = parseInt($(".date_end").val());   
                var losingYear = parseInt($(".year_select").val());
                var losingZone = $("#losing_zones").val();
                var losingRegion = $("#losing_region").val();

                var losingMonthMid = (losingMonth1 % 12) + 1; 
                var midYear = losingMonthMid <= losingMonth1 ? losingYear + 1 : losingYear;
                var endYear = losingMonth2 <= losingMonth1 ? losingYear + 1 : losingYear;

                $(".nameofbranch").text(branchName);
                
                $.ajax({
                    url: "../View_Details?data=branch",
                    type: "POST",
                    data: {
                        branchId: branchid,
                        month1: losingMonth1,
                        midMonth: losingMonthMid,
                        month2: losingMonth2,
                        yearStart: losingYear,
                        yearMid: midYear,
                        yearEnd: endYear,
                        zone: losingZone,
                        region: losingRegion
                    },
                    success: function (branchResponse) {
                        $(".narrativereport_report_2").html(branchResponse || "<tr><td colspan='7'><center>- No Data -</center></td></tr>");
                    },
                    error: function (xhr, status, error) {
                        console.error("Branch AJAX Error:", error);
                    }
                });
                $.ajax({
                    url: "../View_Details?data=narra",
                    type: "POST",
                    data: {
                        branchId: branchid,
                        month1: losingMonth1,
                        midMonth: losingMonthMid,
                        month2: losingMonth2,
                        yearStart: losingYear,
                        yearMid: midYear,
                        yearEnd: endYear,
                        zone: losingZone,
                        region: losingRegion
                    },
                    success: function (branchResponse) {
                        $(".narrativereport_report_3").html(branchResponse || "<tr><td colspan='7'><center>- No Data -</center></td></tr>");
                    },
                    error: function (xhr, status, error) {
                        console.error("Branch AJAX Error:", error);
                    }
                });
            });

            function getMonthName(monthNumber) {
                const monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];
                return monthNames[monthNumber - 1];
            }

            $(document).on("click", '[data-popup="#narrativereportPopup"]', function () {
                $("#narrativereportPopup").removeClass("popup-hidden").hide().fadeIn(300);
                $("#ediLogs").css("margin-top", "20px");
            });

            $(document).on("click", ".menu-item, .submenu-item, .subsubmenu a", function () {
                $("#ediLogs").hide();
                $("#narrativereportPopup").hide();
            });

        });
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const hoTransactionContainer = document.querySelector(".hotransactioncontainer");
            const hoTransactionForm = document.querySelector("#save_asset");
            const hoSubmitBtn = document.querySelector("button[name='hotransaction_submit']");
            const hoTransactionLink = document.getElementById("hotransactionLink");

            if (hoTransactionContainer) {
                hoTransactionContainer.classList.add("hotranimation");
            }

            if (hoSubmitBtn && hoTransactionForm) {
                hoSubmitBtn.addEventListener("click", (e) => {
                    if (hoTransactionForm.checkValidity()) {
                        if (hoTransactionContainer) {
                            hoTransactionContainer.classList.add("form-hidden");
                        }
                    } else {
                        e.preventDefault(); 
                        hoTransactionContainer.classList.remove("form-hidden");
                        hoTransactionForm.reportValidity(); 
                    }
                });
            }

            if (hoTransactionLink) {
                hoTransactionLink.addEventListener("click", (e) => {
                    e.preventDefault();
                    if (hoTransactionContainer) {
                        hoTransactionContainer.style.display = "block";
                        hoTransactionContainer.classList.remove("form-hidden");
                    }
                });
            }
        });
        
        //search asset before generate
        $('#generate_submit').on('click', function(event)
        {
           event.preventDefault();
           var action = $('#action').val();
           var region = $('#generate_region').val();
           var zone = $('#generate_zones').val();
           var date = $('#generate_date').val();
           $('#Generate').attr('disabled', false);
           
           $('#generate_asset_report').html("<tr><td colspan='6'><center>Generating data. Please wait</center></td></tr>");
           $.ajax({
                url: "../asset",
                type: "POST",
                data: {action:action, region:region, zone:zone, date:date},
                success: function(data)
                {
                if(data==="")
                {
                $('#generate_asset_report').html("<tr><td colspan='6'><center>No Records</center></td></tr>");
                }
                else
                {
                $('#generate_asset_report').html(data);
                }
                 var rowCount = $('#generate_asset_report').html(data).find('tr').length;
                 document.getElementById("bilang").innerHTML = rowCount;
                }
            });
        });
        
        //generate asset
        $('#generate_asset').on('click', function(event)
        {
            event.preventDefault();
            var action = "generate_asset";
            var region = $('#generate_region').val();
            var zone = $('#generate_zones').val();
            var date = $('#generate_date').val();
            $(this).attr("value","Generating..");
            $.ajax({
                url: "../asset",
                type: "POST",
                data: {action:action, region:region, zone:zone, date:date},
                success: function(data)
                {
                    alert(data);
                    $('#generate_asset').attr("value","Generate");
                    $('#generate_asset_report').html("<tr><td colspan='6'><center>Done!</center></td></tr>");
                    $('#generate_region').val('');       // Reset region input
                    $('#generate_zones').val('');         // Reset zone input
                    $('#generate_date').val(''); 
                }, error: function()
                {
                    alert('Unable to Generate');
                }
            });
        });
        
        //search asset in Manage asset sectuib 
        
        $('#manage_submit').on('click', function (event) {
            event.preventDefault();

            $('#manage_asset_report').html("<tr><td colspan='11'><center>Generating records....</center></td></tr>");

            $.ajax({
                url: "../record_new_asset?asset=search",
                type: "POST",
                data: {
                    action: "filter_manage_asset",
                    management_search_asset: $('#management_search_asset').val(),
                    management_asset_criteria: $('#manage_asset_criteria').val(),
                    management_date_from: $('#management_date_from').val(),
                    management_date_to: $('#management_date_to').val(),
                    manage_zones: $('#manage_zones').val()
                },
                success: function (data) {
                    $("#manage_asset_report").html(data);
                },
                error: function (xhr, status, error) {
                    alert("Error loading data: " + error);
                }
            });
        });
        //OPEN POPUP
        $(document).on("click", ".open-dispose", function () {
            var code = $(this).data("code");

            // Put code inside modal
            $("#dispose_asset_code").text(code);

            // Show modal
            $("#disposeModal").modal("show");
        });


    </script>

    <script>
        //for GLE WEB Modal
        document.addEventListener("DOMContentLoaded", () => {
            const modalMap = {
                forzone: "zoneModal",
                forregion: "regionModal",
                forarea: "areaModal",
                forcode: "codeModal",
                forbname: "nameModal"
            };

            document.querySelectorAll(".search-button").forEach(button => {
                button.addEventListener("click", (e) => {
                    e.preventDefault();
                    const modalId = modalMap[Array.from(button.classList).find(c => modalMap[c])];
                    if (!modalId) return;
                    const modal = document.getElementById(modalId);
                    if (!modal) return;
                    modal.style.display = "flex";
                });
            });

            document.querySelectorAll(".modal").forEach(modal => {
                const closeBtn = modal.querySelector(".close");
                if (closeBtn) {
                    closeBtn.addEventListener("click", () => {
                        modal.style.display = "none";
                    });
                }
                modal.addEventListener("click", (e) => {
                    if (e.target === modal) {
                        modal.style.display = "none";
                    }
                });
            });
        });
        $(document).ready(function(){
            $(".clear-button").click(function() {
                $("#ho_zone, #ho_region, #ho_area, #ho_branch-code, #ho_branch-name, #ho_date-from, #ho_date-to").val("").removeData("id");
                $(".hotable tbody").html(`
                    <tr>
                        <td colspan="7" style="text-align: center; color: #777; padding: 20px;">
                            No data available in table
                        </td>
                    </tr>
                `);
            });
            $(".forzone").click(function(){
                $("#zoneModal").fadeIn();
                loadData("zones");
            });
            $(".forregion").click(function(){
                const zoneId = $("#ho_zone").data("id");
                $("#regionModal").fadeIn();
                loadData("regions", zoneId);
            });
            $(".forarea").click(function(){
                const regionId = $("#ho_region").data("id");
                $("#areaModal").fadeIn(); 
                loadData("areas", "", regionId);  
            });

            $(".forcode").click(function(){
                const areaId = $("#ho_area").data("id");
                $("#codeModal").fadeIn(); 
                loadData("branchCodes", "", "", areaId);  
            });

            $(".forbname").click(function(){
                const codeId = $("#ho_branch-code").data("id");
                $("#nameModal").fadeIn(); 
                loadData("branchNames", "", "", "", codeId);  
            });

            $(".modal .close").click(function(){
                $(this).closest(".modal").fadeOut();
            });

            $(".modal").click(function(e){
                if($(e.target).hasClass("modal")) {
                    $(this).fadeOut();
                }
            });

            function loadData(type, zoneId = "", regionId = "", areaID = "", codeID = "") {
                $.ajax({
                    url: "../populate?data=ho",
                    type: "POST",
                    data: { type: type, zoneId: zoneId, regionId: regionId,  areaID: areaID, codeID: codeID},
                    success: function(html) {
                        const tableMap = {
                            "zones": "#zoneTable tbody",
                            "regions": "#regionTable tbody",
                            "areas": "#areaTable tbody",
                            "branchCodes": "#codeTable tbody",
                            "branchNames": "#nameTable tbody"
                        };
                        $(tableMap[type]).html(html);
                    },
                    error: function() { console.error("Failed to load " + type); }
                });
            }

            $(document).on("click", ".selectItem", function() {
                const type = $(this).data("type");
                const id = $(this).closest("tr").find("td:first").text().trim(); 
                const name = $(this).closest("tr").find("td:nth-child(2)").text().trim(); 

                switch (type) {
                    case "zones":
                        $("#ho_zone").val(name).data("id", id); 
                        break;

                    case "regions":
                        $("#ho_region").val(name).data("id", id);
                        break;

                    case "areas":
                        $("#ho_area").val(name).data("id", id);
                        break;

                    case "branchCodes":
                        $("#ho_branch-code").val(id).data("id", id);
                        $("#ho_branch-name").val(name).data("id", id);
                        break;

                    case "branchNames":
                        $("#ho_branch-name").val(name).data("id", id);
                        break;
                }

                $(this).closest(".modal").fadeOut();
            });

        });
    </script> 
    <!-- FOR ASSET REGISTRATION-->
    <script>
        const assetCodes = {
            "Appraisal Tools": "APP",
            "Computer Equipment and Peripherals": "CEP",
            "Dealer Incentives": "DI",
            "Furnitures and Fixtures": "FFE",
            "Goodwill": "GW",
            "Leasehold Improvement": "LRI",
            "Office Equipment": "OE",
            "Mobile Van / Kiosk": "MVK",
            "Prepaid ADS": "PDS",
            "Pre-Operating Expense": "POE",
            "Prepaid Rentals": "PR",
            "Repair and Maintenance": "RM",
            "Service Vehicle": "SV",
            "Softwares": "SW",
            "T-Shirts/Flyers/Calendar": "TFC"
          };

          // When user selects a category
          document.getElementById("asset_cat").addEventListener("change", function() {
            const selectedCategory = this.value;
            const codeField = document.getElementById("asset_code");
            const codeField1 = document.getElementById("asset_code_insert");

            // Set code or clear if none
            codeField.value = assetCodes[selectedCategory] || "";
            codeField1.value = assetCodes[selectedCategory] || "";
          });

            function computeRetirementDate() {
                const depDate = document.getElementById('dep_date').value;
                const life = parseInt(document.getElementById('life').value);
                const retireInput = document.getElementById('retire_date');

                // Clear if no date or invalid input
                if (!depDate || isNaN(life)) {
                  retireInput.value = "";
                  return;
                }

                // Compute new date (Depreciation Date + Life in months)
                const newDate = moment(depDate).add(life, 'months').format('YYYY-MM-DD');

                // Set computed date in retire_date input
                retireInput.value = newDate;
              }

              // Recalculate whenever the user changes date or life
              document.getElementById('life').addEventListener('keyup', computeRetirementDate);
              document.getElementById('dep_date').addEventListener('change', computeRetirementDate);
    </script>
    <script>
        $(document).ready(function() {
            $(".edi-logs").hide();

            $(document).on("click", "[id$='_submit']", function() {
                const $button = $(this);
                const $container = $button.closest("div[class$='container']");
                const $formPopup = $container.find(".form-popup");
                const $ediLogs = $container.find(".edi-logs");

                let isValid = true;

                $formPopup.find("select").each(function() {
                    const $field = $(this);
                    if ($field.is(":disabled")) return;
                    const value = $field.val();
                    
                    if (!value || value === "" || value.toUpperCase() === "YYYY") {
                        $field.addClass("is-invalid");
                        isValid = false;
                    } else {
                        $field.removeClass("is-invalid");
                    }
                });

                if (!isValid) {
                    alert("Please fill out all required fields before proceeding.");
                    return;
                }

                $formPopup.slideUp(300, function() {
                    $ediLogs.css({
                        "margin-top": "-55px",
                        "transition": "margin-top 0.3s ease"
                    }).slideDown(300);
                });
            });

            $(document).on("click", "[id$='Link']", function() {
                const $containerClass = $(this).attr("id").replace("Link", "container");
                const $container = $("." + $containerClass);
                const $formPopup = $container.find(".form-popup");
                const $ediLogs = $container.find(".edi-logs");

                $formPopup.slideDown(300);
//                $formPopup.slideToggle(300);
                
                $ediLogs.css({
                    "margin-top": "0",
                    "transition": "margin-top 0.3s ease"
                });
            });

            $(document).on("change", "select", function() {
                if ($(this).val() && $(this).val() !== "" && $(this).val().toUpperCase() !== "YYYY") {
                    $(this).removeClass("is-invalid");
                }
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $(".edi-logs").hide();

            $(document).on("click", "[id$='_submit']", function() {
                const $button = $(this);
                const $container = $button.closest("div[class$='container']");
                const $formPopup = $container.find(".form-popup");
                const $ediLogs = $container.find(".edi-logs");

                let isValid = true;

                $formPopup.find("select").each(function() {
                    const $field = $(this);
                    if ($field.is(":disabled")) return;
                    const value = $field.val();
                    
                    if (!value || value === "" || value.toUpperCase() === "YYYY") {
                        $field.addClass("is-invalid");
                        isValid = false;
                    } else {
                        $field.removeClass("is-invalid");
                    }
                });

                if (!isValid) {
                    alert("Please fill out all required fields before proceeding.");
                    return;
                }

                $formPopup.slideUp(300, function() {
                    $ediLogs.css({
                        "margin-top": "-55px",
                        "transition": "margin-top 0.3s ease"
                    }).slideDown(300);
                });
            });

            $(document).on("click", "[id$='Link']", function() {
                const $containerClass = $(this).attr("id").replace("Link", "container");
                const $container = $("." + $containerClass);
                const $formPopup = $container.find(".form-popup");
                const $ediLogs = $container.find(".edi-logs");

                $formPopup.slideDown(300);
//                $formPopup.slideToggle(300);
                
                $ediLogs.css({
                    "margin-top": "0",
                    "transition": "margin-top 0.3s ease"
                });
            });

            $(document).on("change", "select", function() {
                if ($(this).val() && $(this).val() !== "" && $(this).val().toUpperCase() !== "YYYY") {
                    $(this).removeClass("is-invalid");
                }
            });
        });
    </script>
    <script>
        $(document).ready(function() {
            $("[id$='_table']").each(function() {
                $(this).DataTable({
                    paging: true,
                    searching: true,
                    ordering: true,
                    info: true,
                    lengthChange: true,
                    autoWidth: false,
                    responsive: true,
                    pageLength: 10
                });
            });
        });
        document.addEventListener('DOMContentLoaded', () => {

            const months = [
                { value: "01", name: "Jan" },
                { value: "02", name: "Feb" },
                { value: "03", name: "Mar" },
                { value: "04", name: "Apr" },
                { value: "05", name: "May" },
                { value: "06", name: "Jun" },
                { value: "07", name: "Jul" },
                { value: "08", name: "Aug" },
                { value: "09", name: "Sep" },
                { value: "10", name: "Oct" },
                { value: "11", name: "Nov" },
                { value: "12", name: "Dec" }
            ];

            function populateMonths(selector) {
                document.querySelectorAll(selector).forEach(select => {
                    select.innerHTML = '<option value="">MM</option>';
                    months.forEach(month => {
                        const opt = document.createElement('option');
                        opt.value = month.value;
                        opt.textContent = month.name;
                        select.appendChild(opt);
                    });
                });
            }

            function populateYears(selector) {
                const currentYear = new Date().getFullYear();
                document.querySelectorAll(selector).forEach(select => {
                    select.innerHTML = '<option value="">YYYY</option>';
                    for (let y = currentYear - 2; y <= currentYear + 1; y++) {
                        const opt = document.createElement('option');
                        opt.value = y;
                        opt.textContent = y;
                        select.appendChild(opt);
                    }
                });
            }

            populateMonths('.date_start');
            populateMonths('.date_end');
            populateYears('.year_select');
        });
        $(document).ready(function() {
            var table = $("#allbranch").DataTable({
                processing: false,
                ajax: {
                    url: "../newSettings?action=newpopulate",
                    type: "POST"
                }
            });

            $(document).on("click", ".update", function() {
                var branchName = $(this).data("name");          
                var statusText = $(this).text().trim();       

                $("#branchNameModal").text("Branch: " + branchName);
                $("#branchStatusModal").text("Status: " + statusText);

                $("#statusModal").modal('show'); 
            });

            $(".form-row").one("mouseenter click", function () {
                const $zone = $(this).find(".zone-select");
                const $region = $(this).find(".region-select"); 
                const $branch = $(this).find(".branch-select");
                const $request = $(this).find(".req-select");
                const $month = $(this).find(".date_start");
                const $year  = $(this).find(".year_select");

                $.ajax({
                    url: "../populate?data=asset",
                    type: "POST",
                    data: { type: "zones" },
                    success: function (data) {
                        $zone.html(data);
                    }
                });
                $zone.on("change", function () {
                    const zoneId = $(this).val();
                    let postData = { type: "regions" };
                    if (zoneId) postData.zoneId = zoneId;
                    
                    $.ajax({
                        url: "../populate?data=asset",
                        type: "POST",
                        data: postData,
                        success: function (data) {
                            $region.html(data);
                        },
                        error: function () {
                            console.error("Failed to load regions");
                        }
                    });
                });
                $region.on("change", function () {
                    const regionId = $(this).val();
                    let postBranches = { type: "branches" };
                    if (regionId) postBranches.regionId = regionId;
        
                    $.ajax({
                        url: "../populate?data=asset",
                        type: "POST",
                        data: postBranches,
                        success: function (data) {
                            $branch.html(data);
                        },
                        error: function () {
                            console.error("Failed to load branches");
                        }
                    });
                    
                    let postReq = { type: "request" };
                    if (regionId) postReq.regionId = regionId;
        
                    const m = $month.val();
                    const y = $year.val();

                    if (m) postReq.month = m;
                    if (y) postReq.year = y;

                    $.ajax({
                        url: "../populate?data=asset",
                        type: "POST",
                        data: postReq,
                        success: function (data) {
                            $request.html(data);
                        }
                    });
                });
            });
            $(".group-select, .zone-select").on("change", function () {

                const container = $(this).closest(".income-container");

                const group = container.find(".group-select").val();
                const zone = container.find(".zone-select").val();

                const $region = container.find(".region-select");
                const $code = container.find(".code-select");
                const $branch = container.find(".branch-select");
               
                $region.prop("disabled", false);
                $code.prop("disabled", false);
                $branch.prop("disabled", false);

                if (group === "Consolidated") {
                    if (zone === "ALL") {
                        $region.prop("disabled", true);
                        $code.prop("disabled", true);
                        $branch.prop("disabled", true);
                    } else {
                        $region.prop("disabled", false);
                        $code.prop("disabled", true);
                        $branch.prop("disabled", true);
                    }
                }

                else if (group === "Region") {
                    if (zone === "ALL") {
                        $region.prop("disabled", true);
                    } else {
                        $region.prop("disabled", false);
                    }
                    $code.prop("disabled", true);
                    $branch.prop("disabled", true);
                }

                else if (group === "Branch") {
                    $region.prop("disabled", false);
                    $code.prop("disabled", false);
                    $branch.prop("disabled", false);
                }
            });

            function delay(callback, ms) {
                var timer = 0;
                return function() {
                  var context = this, args = arguments;
                  clearTimeout(timer);
                  timer = setTimeout(function () {
                    callback.apply(context, args);
                  }, ms || 0);
                };
              }

               $('.code-select').keyup(delay(function(){
                const prefix = $(this).data("prefix");  

                const zone = $('#' + prefix + '_zones').val();
                const costcenter = $('#' + prefix + '_code').val();
                const region = $('#' + prefix + '_region').val();
                const branch = $('#' + prefix + '_branch');
                
                   $.ajax({
                       url: "../new_branch",
                       type: "POST",
                       dataType: "text",
                       data: {zone:zone, costcenter:costcenter,region:region},
                       success: function(data)
                       {
                            var result = JSON.parse(data);
                            $('#' + prefix + '_branch').val(result.Branch);
                            if($('#' + prefix + '_branch').val() === "")
                            {
                                swal ("Oops", "No Record Found", "error");
                                $('#' + prefix + '_code').focus();
                            }
                       }
                });
            }, 1000));
        });

         function delay(callback, ms) {
            var timer = 0;
            return function() {
              var context = this, args = arguments;
              clearTimeout(timer);
              timer = setTimeout(function () {
                callback.apply(context, args);
              }, ms || 0);
            };
          }

            $('#branch_id').keyup(delay(function() {
                var zone = $('#asset_zones').val();
                var region = $('#asset_region').val();
                var costcenter = $('#branch_id').val();

                // ? Basic validation before making AJAX call
                if (!zone && !region) {
                    alert("Please select Zone and Region first!");
                    $('#asset_zones, #asset_region').css('border-color', 'red');
                    $('#asset_brach_name').val("");
                    return;
                }
                if (!zone) {
                    alert("Zone is required!");
                    $('#asset_zones').css('border-color', 'red');
                    $('#asset_region').css('border-color', '');
                    $('#asset_brach_name').val("");
                    return;
                }
                if (!region) {
                    alert("Region is required!");
                    $('#asset_region').css('border-color', 'red');
                    $('#asset_zones').css('border-color', '');
                    $('#asset_brach_name').val("");
                    return;
                }

                $.ajax({
                    url: "../populate?data=cc",
                    type: "POST",
                    dataType: "text",
                    data: { zone: zone, region: region, asset_branch_id: costcenter },
                    success: function(data) {
                        // ? Handle different server responses
                        if (data === "Zone is required!") {
                            alert("Zone is required!");
                            $('#asset_zones').css('border-color', 'red');
                            $('#asset_region').css('border-color', '');
                            $('#asset_brach_name').val("");
                            $('#branch_id').focus();
                        } 
                        else if (data === "Region is required!") {
                            alert("Region is required!");
                            $('#asset_region').css('border-color', 'red');
                            $('#asset_zones').css('border-color', '');
                            $('#asset_brach_name').val("");
                            $('#branch_id').focus();
                        } 
                        else if (data === "Please Select Zone and Region") {
                            alert("Please select Zone and Region first!");
                            $('#asset_zones, #asset_region').css('border-color', 'red');
                            $('#asset_brach_name').val("");
                            $('#branch_id').focus();
                        } 
                        else if (data === "No record Found") {
                            alert("No record found for this Branch ID!");
                            $('#asset_brach_name').val("");
                            $('#branch_id').focus();
                        } 
                        else {
                            // ? Success ? display branch name

                            $('#asset_brach_name_s').val(data);
                            $('#asset_brach_name').val(data);
                            $('#asset_zones, #asset_region').css('border-color', '');
                        }
                    },
                    error: function() {
                        // ?? AJAX failure
                        alert("Something went wrong while fetching branch name.");
                    }
                });
            }, 1000));
            //for selected branchname to input type to save in db
            $("#asset_branch").on("change", function () {
                const branchId = $(this).val();                    // selected value
                const branchName = $(this).find("option:selected").text(); // selected text

                $("#branch_id").val(branchId);                     // branch id
                $("#branch_name_s").val(branchName);              // branch name
            });
    </script>
    <!-- BOOKKEEPING - DATA CHECKING -->
    <script>
        $("button[data-prefix]").on("click", function(event) {
            event.preventDefault();

            const prefix = $(this).data("prefix");
            const container = $("." + prefix + "container");

            const monthStart = container.find(".date_start").val();
            const year = container.find(".year_select").val();
            const zone = container.find(".zone-select").val();
            const region = container.find(".region-select").val();
            const criteria = container.find(".criteria_select").val();
            const monthEnd = container.find(".date_end").val();
            const branch = container.find(".branch-select").val();

            const reportContainer = container.find("#" + prefix + "_report");
            const submitBtn = $(this);

            reportContainer.html("<tr><td class='auto-colspan'><center>Generating data....</center></td></tr>");
            submitBtn.text("Searching..");

            let url = {
                incomeexpenseaccounts : "../Datacheck?data=iea",
                spcosting             : "../Datacheck?data=sp",
                sundryaccount         : "../Datacheck?data=sa"
                
            };

            let postData = { monthStart, year, zone, region };
            if (criteria) postData.criteria = criteria;
            if (monthEnd) postData.monthEnd = monthEnd;
            if (branch) postData.branch = branch;

            $.ajax({
                url: url[prefix],
                type: "POST",
                data: postData,
                success: function(data) {
                    submitBtn.text("Search");

                    let zoneText = container.find(".zone-select option:selected").text();
                    let regionText = container.find(".region-select option:selected").text();
                    container.find(".zr").html(zoneText + " | " + regionText);

                    if (!data || data.trim() === "") {

                        reportContainer.html("<tr><td class='auto-colspan'><center>- No Record found -</center></td></tr>");
                        container.find("#totalAmount").text("0.00");

                    } else {

                        reportContainer.html(data);

                        let totalVal = container.find("#hiddenTotal").val() || 0;
                        let formatted = parseFloat(totalVal).toLocaleString('en-PH', { 
                            minimumFractionDigits: 2, 
                            maximumFractionDigits: 2 
                        });
                        container.find("#totalAmount").html(formatted);
                    }

                    let colCount = container.find("table thead tr th").length;
                    container.find(".auto-colspan").attr("colspan", colCount);
                },

                error: function(xhr) {
                    submitBtn.text("Search");
                    reportContainer.html("<tr><td class='auto-colspan'><center style='color:red;'>ERROR: " + xhr.responseText + "</center></td></tr>");

                    let colCount = container.find("table thead tr th").length;
                    container.find(".auto-colspan").attr("colspan", colCount);
                }
            });
        });
    </script>
    <!-- BOOKKEEPING - ALLOCATION "BRANCH EXPENSE" -->
    <script>
        $(document).ready(function() {
            let table;
            
            $("#branchexpense_submit").on("click", function(event) {
                event.preventDefault();

                const container = $(".branchexpensecontainer");

                const monthStart = container.find(".date_start").val();
                const year = container.find(".year_select").val();
                const zone = container.find(".zone-select").val();
                const region = container.find(".region-select").val();

                const reportContainer = container.find(".branchexpense_report");
                const submitBtn = $(this);

                if (!monthStart || !year) {
                    alert("Please select Month and Year");
                    return;
                }

                reportContainer.html("<tr><td colspan='8'><center>Generating data....</center></td></tr>");
                submitBtn.text("Searching..");

                $.ajax({
                    url: "../Branchexpense",
                    type: "POST",
                    data: { 
                        monthStart: monthStart, 
                        year: year, 
                        zone: zone, 
                        region: region 
                    },
                    success: function(data) {
                        submitBtn.text("Search");

                        if (!data || data.trim() === "") {
                            reportContainer.html("<tr><td colspan='8'><center>- No Record found -</center></td></tr>");
                        } else {
                            reportContainer.html(data);
                            if ($.fn.DataTable.isDataTable('.branchexpensecontainer .table')) {
                                table.destroy();
                            }

                            table = $('.branchexpensecontainer .table').DataTable({
                                scrollCollapse: true,
                                paging: true,
                                searching: true,
                                ordering: true,
                                columnDefs: [
                                    {targets: [6,7], className: "dt-body-right"} 
                                ]
                            });
                        }
                    },
                    error: function() {
                        submitBtn.text("Search");
                        reportContainer.html("<tr><td colspan='8'><center>- Could not load data -</center></td></tr>");
                        alert('Could not load branchexpense data');
                    }
                });
            });

        });
    </script>
    <!-- BOOKKEEPING - ALLOCATION "CRRF LIQUIDATION" -->
    <script>
        $(document).ready(function() {

            $('#crrfliquidation_submit').on('click', function(e) {
                e.preventDefault(); 

                var fileInput = $('#crrfliquidation_file')[0].files[0];
                var date = $('#crrfliquidation_date').val();
                var region = $('#crrfliquidation_region').val();

                if (!fileInput || !date || !region) {
                    alert('Please fill in all fields.');
                    return;
                }

                var formData = new FormData();
                formData.append('crrfliquidation_file', fileInput);
                formData.append('crrfliquidation_date', date);
                formData.append('crrfliquidation_region', region);

                $.ajax({
                    url: '../Upload_CRRF',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    dataType: 'json',
                    success: function(response) {
                        alert(response.message);

                        $('.form-popup').hide();
                        $('.crrfliquidationcontainer .edi-logs').show();

                        requestList = response.requestList;
                        if (!requestList) {
                            alert("Missing request list name from upload response!");
                            return;
                        }

                        $.ajax({
                            url: '../Allocation_CRRF',
                            type: 'GET',
                            dataType: 'json',
                            data: { requestList: requestList },
                            success: function(data) {
                                let tbody = $('#generatereport'); 
                                tbody.empty(); 

                                if (data.success && data.data.length > 0) {
                                    $('#generatetable tfoot').hide(); 

                                    data.data.forEach(row => {
                                        tbody.append(
                                            '<tr>' +
                                                '<td style="text-align:left;">' + row.ExpenseType + '</td>' +
                                                '<td style="text-align:left;">' + row.Date + '</td>' +
                                                '<td style="text-align:left;">' + row.Region + '</td>' +
                                                '<td style="text-align:center;">' + row.Areaname + '</td>' +
                                                '<td style="text-align:right;">' + parseFloat(row.Amount).toLocaleString() + '</td>' +
                                                '<td style="text-align:center;">' +
                                                    '<button class="btn btn-sm btn-success allocate-btn" data-expensetype="' + row.ExpenseType + '" ' +
                                                        'data-glcode="' + row.GLCode + '" data-code="' + row.Code_id + '" data-date="' + row.Date + '" ' +
                                                        'data-regionname="' + row.Region + '" data-areaid="' + row.Areaid + '" data-regionid="' + row.Regionid + '" ' +
                                                        'data-areaname="' + row.Areaname + '" data-amount="' + row.Amount + '" data-requestlist="' + requestList + '"> Allocate' +  
                                                    '</button>' +
                                                '</td>' +
                                            '</tr>'
                                        );
                                    });
                                } else {
                                    $('#generatetable tfoot').show();
                                }
                            },
                            error: function(xhr, status, error) {
                                alert('Error retrieving data: ' + error);
                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        let errMsg = "Unknown error";
                        try {
                            let resp = JSON.parse(xhr.responseText);
                            if (resp.message) errMsg = resp.message;
                        } catch(e) {}
                        alert('Error: ' + errMsg);
                    }
                });
            });
        });
    </script>
    <!-- BOOKKEEPING - ALLOCATION "CRRF LIQUIDATION" -->
    <script>
        $(document).on('click', '.allocate-btn', function() {
            let $btn = $(this);
            let expenseType = $(this).attr('data-expensetype').replace(/\s+/g, '');
            let glCode = $(this).attr('data-glcode');
            let code_id = $(this).attr('data-code');
            let date = $(this).attr('data-date');
            let region = $(this).attr('data-regionname');
            let regionid = $(this).attr('data-regionid');
            let area = $(this).attr('data-areaname');
            let areaid = $(this).attr('data-areaid');
            let amount = $(this).data('amount');
            let requestList = $(this).attr('data-requestlist');

            console.log("Allocate clicked:", {expenseType, glCode, code_id, date, region, regionid, area, areaid, amount, requestList });
            let postData = { expenseType: expenseType, glCode: glCode, code_id: code_id, date: date, region: region, regionid: regionid, area: area, areaid: areaid, amount: amount, requestList: requestList };
            
            $.ajax({
                url: '../Allocate_Action', 
                type: 'POST',
                data: postData,
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert('Allocation successful: ' + response.message);
                        $btn.prop('disabled', true);
                        $btn.text('Allocated');
                    } else {
                        alert('Allocation failed: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert('Error allocating: ' + error);
                }
            });
        });
    </script>
    <!-- FINANCIAL REPORTS "BALANCE & INCOME STATEMENT" -->
    <script>
        $("button[data-prefix]").on("click", function (event) {
            event.preventDefault();

            const container = $(this).closest(".income-container");

            if (!container.find(".date_start").length ||
                !container.find(".year_select").length) {
                return; 
            }
    
            let monthStart = container.find(".date_start").val();
            let yearStart  = container.find(".year_select").val();
            let monthEndInput = container.find(".date_end");
            let monthEnd = monthEndInput.length ? monthEndInput.val() : monthStart;

            let group  = container.find(".group-select").val();
            let zone   = container.find(".zone-select").val();
            let region = container.find(".region-select").val();
            let branch = container.find(".branch-select").val();
            let level  = container.find(".level-select").val();
            let endMonth = parseInt(monthEnd);

            const monthNames = ["January","February","March","April","May","June","July","August","September","October","November","December"];

            let months = [];
            let currentMonth = parseInt(monthStart);
            let currentYear  = parseInt(yearStart);

//            while (true) {
//                let monthStr = currentMonth < 10 ? "0" + currentMonth : "" + currentMonth;
//
//                months.push({ month: monthStr, year: currentYear.toString() });
//
//                if (currentMonth === parseInt(monthEnd)) break;
//
//                currentMonth++;
//                if (currentMonth > 12) {
//                    currentMonth = 1;
//                    currentYear++;
//                }
//            }
            let safety = 0;
            while (true) {
                if (safety++ > 100) break; 

                let monthStr = currentMonth.toString().padStart(2, "0");
                months.push({ month: monthStr, year: currentYear.toString() });

                if (currentMonth === endMonth) break;

                currentMonth++;
                if (currentMonth > 12) {
                    currentMonth = 1;
                    currentYear++;
                }
            }

            let month1 = months[0].month, year1 = months[0].year;
            let month2 = months[1] ? months[1].month : null, year2 = months[1] ? months[1].year : null;
            let month3 = months[2] ? months[2].month : null, year3 = months[2] ? months[2].year : null;

            container.find(".month1").text(monthNames[month1-1] + " " + year1);
            container.find(".month2").text(month2 ? monthNames[month2-1] + " " + year2 : "");
            container.find(".month3").text(month3 ? monthNames[month3-1] + " " + year3 : "");

            container.find(".3vs2").text(
                monthNames[months[months.length-1].month-1] + " vs " + (months[months.length-2] ? monthNames[months[months.length-2].month-1] : "")
            );

            container.find(".3vs1").text(
                monthNames[months[months.length-1].month-1] + " vs " + monthNames[months[0].month-1]
            );

            const prefix = $(this).data("prefix");

            if (prefix === "isgeneralincomestatement") {
                $.post("../Isgeneralincomestatement?action=filter",
                    { monthStart, yearStart, group, zone, region, branch},
                    response => container.find(".isgeneralincomestatement_report").html(response || noRecord())
                ).fail(() => alert("Could not load General Income Statement data"));
            }
            if (prefix === "horizontalincomestatement") {
                $.post("../Horizontalincome_comparative",
                    { month1, year1, month2, year2, month3, year3, group, zone, region, branch },
                    response => container.find(".horizontalincomestatement_report").html(response || noRecord())
                ).fail(() => alert("Could not load Horizontal Comparative data"));
            }
            if (prefix === "verticalincomestatement") {
                $.post("../Verticalincome_comparative",
                    { month1, year1, month2, year2, month3, year3, group, zone, region, branch },
                    response => container.find(".verticalincomestatement_report").html(response || noRecord())
                ).fail(() => alert("Could not load Vertical Comparative data"));
            }
            if (prefix === "bylevelincomestatement") {
                $.post("../Levelincome_comparative",
                    { month1, year1, month2, year2, month3, year3, group, zone, region, branch, level },
                    response => container.find(".bylevelincomestatement_report").html(response || noRecord())
                ).fail(() => alert("Could not load By Level Comparative data"));
            }
            
            if (prefix === "bsgeneralbalancesheet") {
                $.post("../Bsgeneralbalancesheet",
                    { monthStart, yearStart, group, zone, region, branch},
                    response => container.find(".bsgeneralbalancesheet_report").html(response || noRecord())
                ).fail(() => alert("Could not load General Balance Sheet data"));
            }
            if (prefix === "horizontalbalancesheet") {
                $.post("../Horizontalbalance_comparative",
                    { month1, year1, month2, year2, month3, year3, group, zone, region, branch },
                    response => container.find(".horizontalbalancesheet_report").html(response || noRecord())
                ).fail(() => alert("Could not load Horizontal Comparative data"));
            }
            if (prefix === "verticalbalancesheet") {
                $.post("../Verticalbalance_comparative",
                    { month1, year1, month2, year2, month3, year3, group, zone, region, branch },
                    response => container.find(".verticalbalancesheet_report").html(response || noRecord())
                ).fail(() => alert("Could not load Vertical Comparative data"));
            }
            if (prefix === "bylevelbalancesheet") {
                $.post("../Levelbalance_comparative",
                    { month1, year1, month2, year2, month3, year3, group, zone, region, branch, level },
                    response => container.find(".bylevelbalancesheet_report").html(response || noRecord())
                ).fail(() => alert("Could not load By Level Comparative data"));
            }

            function noRecord() {
                return "<tr><td colspan='20'><center>- No Record found -</center></td></tr>";
            }
            function noRecordSimple() {
                return "<tr><td colspan='3'><center>- No Record found -</center></td></tr>";
            }
        });
        
        function updateNameOfRegion() {
            
            const container = $(this).closest(".income-container");
            
            let zone   = container.find(".zone-select option:selected").text();
            let region = container.find(".region-select option:selected").text();
            let branch = container.find(".branch-select option:selected").text();
            let group = container.find(".group-select option:selected").text();

            let display = "";

            if (group === "Region") {
                display = region || "";
                container.find("#nameofregion").text("Region : " + display);
            }
            else if (group === "Branch") {
                display = branch || "";
                container.find("#nameofregion").text("Branch : " + display);
            }
            else if (group === "Consolidated") {
                display = zone || "";
                container.find("#nameofregion").text("Zone : " + display);
            }

//            container.find("#nameofregion").text("Region/Branch : " + display);
        }

        $(".zone-select, .region-select, .branch-select, .group-select")
            .on("change keyup", updateNameOfRegion);
        
    </script>
    <!-- FINANCIAL REPORTS - INCOME STATEMENT "MONTHLY BRANCH INCOME STATEMENT" -->
    <script>
        $(document).ready(function() {
            var yearSelect = $('#yearSelect');
            var month1 = $('#month1');
            var month2 = $('#month2');

            var startYear = 2023;
            var currentYear = new Date().getFullYear();
            for (var y = startYear; y <= currentYear + 1; y++) {
                yearSelect.append(new Option(y, y));
            }
            yearSelect.val(currentYear);

            var monthNames = ["January","February","March","April","May","June","July","August","September","October","November","December"];
            month2.empty();
            for (var m = 1; m <= 12; m++) {
                var mm = String(m).padStart(2, '0');
                month2.append(new Option(monthNames[m - 1], mm));
            }

            var now = new Date();
            month2.val(String(now.getMonth() + 1).padStart(2, '0'));

            generateMonthColumns();

            $(document).on('change', '#month2', function() {
                generateMonthColumns();
            });

            $(document).on('click', '#monthlybranchincomestatement_submit', function() {
                generateMonthColumns();
                fetchReportData();
            });
        });

        function generateMonthColumns() {
            var month2 = $('#month2').val();
            var monthNames = ["January","February","March","April","May","June","July","August","September","October","November","December"];

            var selectedMonth = parseInt(month2);
            selectedMonth = Math.min(Math.max(selectedMonth, 1), 12);

            var thead = $(".monthlybranchincomestatement_report_header");
            thead.empty();

            var row1 = "<tr>";

            row1 += "<th rowspan='2'>GL Description</th>";

            for (var m = 1; m <= selectedMonth; m++) {
                row1 += "<th style='text-align:center;'>" + monthNames[m - 1] + "</th>";
            }

            row1 += "</tr>";

            thead.append(row1);
        }

        function updateNoDataColspan() {
            var totalColumns = 0;
            $(".monthlybranchincomestatement_report_header th").each(function() {
                var colspan = parseInt($(this).attr("colspan")) || 1;
                colspan = Math.max(1, colspan);
                totalColumns += colspan;
            });
            $(".monthlybranchincomestatement_report .no-data").attr("colspan", totalColumns);
        }

        function fetchReportData() {
            var zone = $('#monthlybranchincomestatement_zones').val();
            var region = $('#monthlybranchincomestatement_region').val();
            var branch = $('#monthlybranchincomestatement_branch').val();
            var year = $('#yearSelect').val();
            var end = $('#month2').val();
            var start = $('#month1').val();
            var level = $('#levelSelect').val();

            $.ajax({
                url: '../Monthlybranchincomestatement?Data=record', 
                method: 'POST',
                data: {
                    zones: zone,
                    region: region,
                    branch: branch,
                    year: year,
                    level: level, 
                    end: end, 
                    start: start
                },
                beforeSend: function() {
                    $(".monthlybranchincomestatement_report").html('<tr><td colspan="100%">Loading...</td></tr>');
                },
                success: function(response) {
                    $(".monthlybranchincomestatement_report").html(response);
                    updateNoDataColspan(); 
                },
                error: function(xhr, status, error) {
                    console.error("AJAX error:", error);
                    $(".monthlybranchincomestatement_report").html('<tr><td colspan="100%">Error loading data</td></tr>');
                    updateNoDataColspan();
                }
            });
        }
    </script>
    <!-- BOOKKEEPING - DATA RECONCILIATION -->
    <script>        
        
        $("button[data-prefix]").on("click", function(event) {
            event.preventDefault();

            const prefix = $(this).data("prefix");
            const container = $("." + prefix + "container");

            let url = {
                drcashbalance : "../Datarecon?data=cb",
                bankbalance : "../Datarecon?data=bb",
                drreceivables : "../Datarecon?data=r",
                qclinterest : "../Datarecon?data=ql", 
                billspayment : "../Datarecon?data=bp", 
                corporatepayment : "../Datarecon?data=cp", 
                paymentsolutions : "../Datarecon?data=ps"
            };

            if (!url.hasOwnProperty(prefix)) return;

            const monthStart = container.find(".date_start").val();
            const zone = container.find(".zone-select").val();
            const region = container.find(".region-select").val(); 
            const branch = container.find(".branch-select").val();
            const criteriaLabel = container.find(".c1_select option:selected").text();
            const criteria1 = container.find(".c1_select").val();
            const criteria2 = container.find(".c2_select").val();
            const criteria3 = container.find(".c3_select").val();
            
            let dataValue = url[prefix].split("data=")[1];
            let cri = "";

            if (dataValue === "r") {
                cri = "r - Principal"; 
            } else {
                cri = dataValue + " - " + criteriaLabel; 
            }
            
            const reportContainer = container.find("." + prefix + "_report");
            const submitBtn = $(this);

            reportContainer.html("<tr><td colspan='11'><center>Generating data....</center></td></tr>");
            submitBtn.text("Searching..");

            let postData = {monthStart, zone, region};
            if (branch) postData.branch = branch;
            if (cri) postData.cri = cri;
            if (criteria1) postData.criteria1 = criteria1;
            if (criteria2) postData.criteria2 = criteria2;
            if (criteria3) postData.criteria3 = criteria3;

            $.ajax({
                url: url[prefix],
                type: "POST",
                data: postData,
                success: function(data) {
                    submitBtn.text("Search");

                    if (!data || data.trim() === "") {
                        reportContainer.html("<tr><td colspan='11'><center>- No Record found -</center></td></tr>");
                        container.find("#totalAmount").text("0.00");
                    } else {
                        reportContainer.html(data);
                    }
                },
                error: function(xhr) {
                    submitBtn.text("Search");

                    if (xhr.responseText && xhr.responseText.trim() !== "") {
                        reportContainer.html(xhr.responseText);
                    } else {
                        reportContainer.html(
                            "<tr><td colspan='11' style='color:red; text-align:center; font-weight:bold;'>"
                            + "Unknown server error."
                            + "</td></tr>"
                        );
                    }
                }
            });
        });
        $(document).ready(function() {
            $(".c2_select").on("change", function () {
                const value = $(this).val();
                let label = "";

                if (value === "bca") label = "Online BCA";
                else if (value === "tl") label = "Trans Log";

                $(".cselect").text(label);
            });
        });
    </script>
    <script>
        (function() {

            // Prevent double-binding
            if (window.DRReceivableLoaded) return;
            window.DRReceivableLoaded = true;

            var currentRow = null;

            window.openReceivableModal = function(date, zone, region, branch, zoneid, regionid, branchid, amount, adj, cri, btn) {
                currentRow = $(btn).closest("tr");

                currentRow.data("zoneid", zoneid);
                currentRow.data("regionid", regionid);
                currentRow.data("branchid", branchid);
                currentRow.data("cri", cri);

                $("#modal_date").text(date);
                $("#modal_zone").text(zone);
                $("#modal_region").text(region);
                $("#modal_branch").text(branch);
                $("#modal_amount").text(amount);

                $("#modal_adj_under, #modal_adj_over, #modal_adj_remark")
                    .val("")
                    .prop("readonly", false);

                $("#receivableModal").modal("show");
            };

            $(document).on("input", "#modal_adj_under, #modal_adj_over", function () {
                this.value = this.value.replace(/[^0-9.]/g, "");
                if ((this.value.match(/\./g) || []).length > 1) {
                    this.value = this.value.replace(/\.(?=.*\.)/, "");
                }

                let underVal = $("#modal_adj_under").val().trim();
                let overVal = $("#modal_adj_over").val().trim();

                $("#modal_adj_over").prop("readonly", underVal !== "");
                $("#modal_adj_under").prop("readonly", overVal !== "");
            });

            $(document).on("click", "#modal_save_btn", function () {
                if (!currentRow) return;

                let perBook = parseFloat(currentRow.find("td:eq(4)").text().replace(/,/g, "")) || 0;

                let adjVal = 0;
                let isUnder = false;
                let isOver = false;

                if ($("#modal_adj_under").val().trim() !== "") {
                    adjVal = parseFloat($("#modal_adj_under").val()) || 0;
                    isUnder = true;
                } else if ($("#modal_adj_over").val().trim() !== "") {
                    adjVal = parseFloat($("#modal_adj_over").val()) || 0;
                    isOver = true;
                }

                let remarks = $("#modal_adj_remark").val().trim();
                let category = "Autoentries";

                let displayAdj = isUnder ? -adjVal : adjVal;
                currentRow.find("td:eq(5)").text(
                    displayAdj.toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 })
                );

                let newTotal = perBook + (isUnder ? -adjVal : adjVal);

                currentRow.find("td:eq(6)").text(
                    newTotal.toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 })
                );

                if (newTotal === 0) {
                    currentRow.find("td:eq(6) button").remove();
                }

                $.ajax({
                    url: '../Datarecon?data=adj',
                    method: 'POST',
                    data: {
                        date: currentRow.find("td:eq(0)").text(),
                        zoneid: currentRow.data("zoneid"),
                        regionid: currentRow.data("regionid"),
                        branchid: currentRow.data("branchid"),
                        branch: currentRow.find("td:eq(3)").text(),
                        amount: perBook,
                        adjustment: displayAdj,
                        remarks: remarks,
                        category: category, 
                        cri: currentRow.data("cri")
                    }
                });

                $("#modal_adj_under, #modal_adj_over, #modal_adj_remark")
                    .val("")
                    .prop("readonly", false);

                $("#receivableModal").modal("hide");
            });

            window.closeReceivableModal = function() {
                $("#modal_adj_under, #modal_adj_over, #modal_adj_remark")
                    .val("")
                    .prop("readonly", false);
                $("#receivableModal").modal("hide");
            };

        })();
    </script>
    <script>
        $(document).ready(function() {
            $('.submit').on('click', function(event) {
                event.preventDefault();

                var container = $(this).closest('div[class$="container"]');

                container.show();

                container.find(".zone-select, .region-select").trigger("change");
 
                var start = container.find('.date_start').val();
                var end = container.find('.date_end').val();
                var zone = container.find('.zone-select').val();
                var reg = container.find('.region-select').val();
                var branch = container.find('.branch-select').val();
                var c1 = container.find('.c1_select').val();
                var c2 = container.find('.c2_select').val();

                var reportBody = container.find('tbody').first();
                reportBody.html("<tr><td colspan='20'><center>Generating data....</center></td></tr>");
                $(this).attr("value", "Searching..");

            let postData = {zone, reg};
            if (branch) postData.branch = branch;
            if (start) postData.start = start;
            if (end) postData.end = end;
            if (c1) postData.c1 = c1;
            if (c2) postData.c2 = c2;
            
                var ajaxUrl = ""; 
                if (container.hasClass('jewelrysalescontainer')) ajaxUrl = "../DataCheck_Jew";
                else if (container.hasClass('ispdinsurancesalescontainer')) ajaxUrl = "../DataCheck_ISPDInsurance?data=insu";
                else if (container.hasClass('ispdincentivescontainer')) ajaxUrl = "../DataCheck_ISPDInsurance?data=ince";
                else if (container.hasClass('grossrevenuecontainer')) ajaxUrl = "../Otherreports?data=gr";
                else if (container.hasClass('incomesummarycontainer')) ajaxUrl = "../Otherreports?data=is";
                else if (container.hasClass('losingbranchescontainer')) ajaxUrl = "../Otherreports?data=lb";
                else if (container.hasClass('orcashbalancecontainer')) ajaxUrl = "../Otherreports?data=cb";
                else if (container.hasClass('orbankbalancecontainer')) ajaxUrl = "../Otherreports?data=bb";
                else if (container.hasClass('orreceivablescontainer')) ajaxUrl = "../Otherreports?data=r";

                $.ajax({
                    url: ajaxUrl,
                    type: "POST",
                    data: postData,
                    success: function(data) {
                        $(this).attr("value", "Search");
                        if (!data || data.trim() === "") {
                            reportBody.html("<tr><td colspan='20'><center>- No Record found -</center></td></tr>");
                        } else {
                            reportBody.html(data);
                        }
                    }.bind(this),
                    error: function() {
                        alert('Could not load view data');
                        $(this).attr("value", "Search");
                    }.bind(this)
                });
            });
        });
    </script>
    <script>
        function updateNameOfRegion() {

            const container = $(this).closest(".incomesummarycontainer");

            const zone = container.find(".zone-select option:selected").text();
            const region = container.find(".region-select option:selected").text();

            let display = "";

            if (zone) display += zone;
            if (region) display += (display ? " / " : "") + region;

            container.find("#zr").text("Zone / Region : " + display);
        }

        $(".zone-select, .region-select").on("change", updateNameOfRegion);
    </script>
    <script>
        $('#errorcorporateaccounts_submit').on('click', function(event) {
            event.preventDefault();

            var container = $('.errorcorporateaccountscontainer');
            var m1 = container.find('.date_start').val();
            var yy = container.find('.year_select').val();
            var zone = container.find('#errorcorporateaccounts_zones').val();
            var region = container.find('#errorcorporateaccounts_region').val();

            $('#errorcorporateaccounts_report').html("<tr><td colspan='8'><center>Generating data....</center></td></tr>");
            $(this).text("Searching..");

            $.ajax({
                url: "../datacheckcorp",
                type: "POST",
                data: { m1, yy, zone, region },
                success: function(data) {
                    $('#errorcorporateaccounts_submit').text("Search");

                    if ($.fn.DataTable.isDataTable('#errorcorporateaccounts_table')) {
                        $('#errorcorporateaccounts_table').DataTable().clear().destroy();
                    }

                    if (!data || data.trim() === "") {
                        $('#errorcorporateaccounts_report').html("<tr><td colspan='8'><center>- No Record found -</center></td></tr>");
                        $('#totalAmount').text("0.00");
                    } else {
                        $('#errorcorporateaccounts_report').html(data);

                        var totalVal = $('#hiddenTotal').val() || 0;
                        var formatted = parseFloat(totalVal).toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        $('#totalAmount').html(formatted);

                        $('#errorcorporateaccounts_table').DataTable({
                            order: [],
                            paging: true,
                            searching: true,
                            info: true,
                            responsive: true, 
                            drawCallback: function(settings) {
                                var api = this.api();
                                if (api.rows({ filter: 'applied' }).data().length === 0) {
                                    $('#errorcorporateaccounts_table tfoot').hide(); 
                                } else {
                                    $('#errorcorporateaccounts_table tfoot').show(); 
                                }
                            }
                        });
                    }
                },

                error: function() {
                    $('#errorcorporateaccounts_submit').text("Search");
                    $('#errorcorporateaccounts_report').html("<tr><td colspan='8'><center>- Could not load data -</center></td></tr>");
                    alert('Could not load view data');
                }
            });
        });
        
        // Open modal and fill data
        $(document).on("click", ".open-dispose", function () {
            
            $("#m_code_view").val($(this).data("codess"));
            $("#m_code").val($(this).data("code"));
            $("#m_branch").val($(this).data("branch"));
            $("#m_asset").val($(this).data("asset"));
            $("#m_desc").val($(this).data("desc"));
            $("#m_cost").val($(this).data("cost"));
            $("#m_de").val($(this).data("de"));
            $("#m_ad").val($(this).data("ad"));
            $("#m_remain").val($(this).data("remain"));
            $("#m_bv").val($(this).data("bv"));
            $("#m_ref").val($(this).data("ref"));
            $("#m_date").val($(this).data("date"));
            $("#m_scrap").val($(this).data("scrap"));
            $("#m_depdate").val($(this).data("depdate"));
            $("#m_retiredate").val($(this).data("retiredate"));
            $("#m_recID").val($(this).data("recID"));

            $("#modal-dispose").fadeIn(200);
        });

        // Close modal
        $(document).on("click", ".close", function () {
            $("#modal-dispose").fadeOut(200);
        });

        $(window).on("click", function (e) {
            if (e.target.id === "modal-dispose") {
                $("#modal-dispose").fadeOut(200);
            }
        });

    </script>
    <!--GENERAL LEDGER SCRIPTS-->
    <script>
        //LIVE SEARCH GL in per account
            function showResult(str) {
                const live = document.getElementById("livesearch");

                if (str.length === 0) {
                    live.innerHTML = "";
                    live.style.display = "none";
                    return;
                }

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState === 4 && this.status === 200) {
                        live.innerHTML = this.responseText;
                        live.style.display = "block"; // show results
                    }
                };
                xmlhttp.open("GET", "../live_search_gl?q=" + encodeURIComponent(str), true);
                xmlhttp.send();
            }

            function selectItem(value) {
                document.getElementById("per_account_gl").value = value;
                document.getElementById("livesearch").innerHTML = "";
                document.getElementById("livesearch").style.display = "none";
            }
            
            function showResult(str) {
                const live = document.getElementById("livesearch");

                if (str.length === 0) {
                    live.innerHTML = "";
                    live.style.display = "none";
                    return;
                }

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState === 4 && this.status === 200) {
                        live.innerHTML = this.responseText;
                        live.style.display = "block"; // show results
                    }
                }
                xmlhttp.open("GET", "../live_search_gl?q=" + encodeURIComponent(str), true);
                xmlhttp.send();
            }

            function selectItem(value) {
                document.getElementById("per_account_gl").value = value;
                document.getElementById("livesearch").innerHTML = "";
                document.getElementById("livesearch").style.display = "none";
            }
            
            //per category branch enable/disablebakit
            $(document).ready(function() {
                // Initially disable the input
                $('#per_range_branch').prop('disabled', true);

                // Enable input only if "Branch" is selected
                $('#per_range_filter').on('change', function() {
                    if ($(this).val() === "3") { // Branch
                        $('#per_range_branch').prop('disabled', false);
                    } else {
                        $('#per_range_branch').prop('disabled', true);
                        $('#per_range_branch').val(''); // optional: clear input
                    }
                });
            });
            //per range select branch to activate
            $(document).ready(function() {
                // Initially disable the inputs
                $('#per_range_search').prop('disabled', true);
                $('#per_range_region').prop('disabled', true);

                $('#per_range_criteria').on('change', function() {
                    var selected = $(this).val();

                    if (selected === "3") { // Branch
                        $('#per_range_search').prop('disabled', false);
                        $('#per_range_region').prop('disabled', false); // keep region enabled if needed
                    } else if (selected === "2") { // Region
                        $('#per_range_search').prop('disabled', true).val(''); // clear input
                        $('#per_range_region').prop('disabled', false);
                    } else { // Zone or empty
                        $('#per_range_search').prop('disabled', true).val('');
                        $('#per_range_region').prop('disabled', true).val(''); // clear selection
                    }
                });
            });

            //per category
            $(document).ready(function() {
            $('#per_categorys_generate_submit').on('click', function(event) {
                event.preventDefault();

                // Get form values
                let date_from    = $('#per_categorys_date_gl_from').val();
                let date_to      = $('#per_categorys_date_gl_to').val();
                let filter       = $('#per_categorys_filter').val();
                let zone         = $('#per_categorys_zones').val();
                let region       = $('#per_categorys_region').val();
                let gl_from      = $('#per_categorys_gl_from').val();
                let category     = $('#per_categorys_category').val();
                let branch       = $('#per_categorys_branch').val();
                let action       = $('#per_categorys_action').val();
                let per_categorys_table_header       = $('#per_categorys_table_header').val();
                

                // Show loading message
//                $('#per_categorys_ledger').html("<tr><td colspan='7' style='text-align:center;'>Generating data....</td></tr>");

                // Set dynamic table header
//                let header = "<tr><th>GL Code</th><th>Description</th><th>Date</th><th>Region</th><th>Cost Center</th><th>Branches</th><th>Amount</th></tr>";
//                $('#per_categorys_table_header').html(header);
                
                let header;
                if (per_categorys_table_header === "1") {
                    header = "<tr><th>GL Code</th><th>Description</th><th>Date</th><th>Region</th><th>Cost Center</th><th>Branches</th><th>Amount</th></tr>";
                } else {
                    header = "<tr><th>Date</th><th>Branch</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
                }
                $("#table-header").html(header);

                // AJAX call
                $.ajax({
                    url: "../fs_general_ledger_percategorys?ledger=per_categorys",
                    type: "POST",
                    data: {
                        per_categorys_date_gl_from: date_from,
                        per_categorys_date_gl_to: date_to,
                        per_categorys_filter: filter,
                        per_categorys_zones: zone,
                        per_categorys_region: region,
                        per_categorys_gl_from: gl_from,
                        per_categorys_category: category,
                        per_categorys_branch: branch,
                        action: action
                    },
                    success: function(data) {
                        if (data.trim() === "") {
                            $('#per_categorys_ledger').html("<tr><td colspan='7' style='text-align:center;'>No record(s) found</td></tr>");
                        } else {
                            $('#per_categorys_ledger').html(data);
                        }
                    },
                    error: function(xhr, status, error) {
                        $('#per_categorys_ledger').html("<tr><td colspan='7' style='text-align:center;'>Error loading data: " + error + "</td></tr>");
                    }
                });
            });

            // Optional: Enable/disable Branch input based on criteria
            $('#per_categorys_filter').on('change', function() {
                let selected = $(this).val();
                if (selected === "3") { // Branch
                    $('#per_categorys_branch').prop('disabled', false);
                    $('#per_categorys_region').prop('disabled', false);
                } else if (selected === "2") { // Region
                    $('#per_categorys_region').prop('disabled', false);
                    $('#per_categorys_branch').prop('disabled', true).val('');
                } else { // Zone or empty
                    $('#per_categorys_region').prop('disabled', true).val('');
                    $('#per_categorys_branch').prop('disabled', true).val('');
                }
            }).trigger('change'); // Trigger on page load to set default state
        });


        ////per range

            $('#serach_perrange_submit').on('click', function(event) {
                event.preventDefault();

                let per_range_date_gl_from = $('#per_range_date_gl_from').val();
                let per_range_date_gl_to   = $('#per_range_date_gl_to').val();
                let per_cat_zones          = $('#per_range_zones').val();
                let per_cat_region         = $('#per_range_region').val();
                let per_range_gl_from      = $('#per_range_gl_from').val();
                let per_cat_gl_to          = $('#per_range_gl_to').val();
                let per_cat_criteria       = $('#per_range_criteria').val();
                let per_cat_search         = $('#per_range_search').val();
                let per_range_gl_from_new         = $('#per_range_gl_from_new').val();

                let action = "filter_perrange";

                $(this).attr("value", "Searching..");
                $('#ledger_per_range').html("<tr><td colspan='5' style='text-align:center;'>Generating data....</td></tr>");

                // Correct dynamic header
                let header;
                if (per_cat_criteria === "1") {
                    header = "<tr><th>Date</th><th>Region</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
                } else {
                    header = "<tr><th>Date</th><th>Branch</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
                }
                $("#table-header").html(header);

                $.ajax({
                    url: "../fs_general_ledger_perrange?ledger=per_range",
                    type: "POST",
                    data: {
                        per_cat_date_gl_from: per_range_date_gl_from,
                        per_cat_date_gl_to: per_range_date_gl_to,
                        per_cat_zones: per_cat_zones,
                        per_cat_region: per_cat_region,
                        per_range_gl_from_new:per_range_gl_from_new,
                        per_cat_gl_to: per_cat_gl_to,
                        per_cat_criteria: per_cat_criteria,
                        per_cat_search: per_cat_search,
                        action: action
                    },              
                    success: function(data) {
                        if (data.trim() === "") {
                            $('#ledger_per_range').html("<tr><td colspan='6'><center>No record(s) found</center></td></tr>");
                        } else {
                            $('#ledger_per_range').html(data);
                        }
                        $('#serach_perrange_submit').attr("value", "Search");
                    },
                    error: function() {
                        alert('Could not load data');
                    }
                });
            });




        $('#serach_peraccount_submit').on('click', function(event) {
           event.preventDefault();

            var action = $('#action').val();
            var per_account_date_from = $('#per_account_date_from').val();
            var per_account_date_to = $('#per_account_date_to').val();
            var per_account_filter = $('#per_account_filter').val();
            var per_account_zone = $('#per_account_zones').val();
            var per_account_region = $('#per_account_region').val();
            var per_account_criteria_search = $('#per_account_criteria_search').val();
            var per_account_gl = $('#per_account_gl').val();
           
           $(this).attr("value","Searching..");
           $('#ledger_per_accoount').html("<tr><td colspan='6'><center>Generating data....</center></td></tr>");
           
            // ---- Dynamic HEADER ----
            let filter = $("#per_account_filter").val();
            let header = "<tr>" +
             "<th>Date</th>" +
             "<th>Region</th>" +
             "<th>Branch</th>" +
             "<th>GL Code</th>" +
             "<th>Description</th>" +
             "<th>Amount</th>" +
             "</tr>";
            if (filter === "1") {
                header = "<tr><th>Date</th><th>Region</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
            } else {
                header = "<tr><th>Date</th><th>Branch</th><th>GL Code</th><th>Description</th><th>Amount</th></tr>";
            }
            $("#table-header").html(header);
           
           $.ajax({
              url: "../fs_general_ledger?ledger=per_account",
              type: "POST",
              data: {
                    action: action,
                    per_account_date_from: per_account_date_from,
                    per_account_date_to: per_account_date_to,
                    per_account_filter: per_account_filter,
                    per_account_zone: per_account_zone,
                    per_account_region: per_account_region,
                    per_account_criteria_search: per_account_criteria_search,
                    per_account_gl: per_account_gl},
              success: function(data){
                  if(data==="")
                  {
                     $('#ledger_per_accoount').html("<tr><td colspan='6'><center>No record(s) found</center></td></tr>");
                  }
                  else
                  {
                     $('#ledger_per_accoount').html(data);
                  }
                  $('#serach_peraccount_submit').attr("value","Search");
              }, error: function()
              {
                  alert('Could not load data');
              }
           });
        });

        document.addEventListener("DOMContentLoaded", function() 
        {
            const filter = document.getElementById("per_account_filter");
            const regionSelect = document.getElementById("per_account_region");
            const criteriaSelect = document.getElementById("per_account_criteria");
            const glInput = document.getElementById("per_account_gl");
            const criteriaSearch = document.getElementById("per_account_criteria_search");
            const zoneSelect = document.getElementById("per_account_zones");

            function updateInputs() {
                const value = filter.value;

                if(value === "1") { // Zone
                    regionSelect.disabled = true;
                    criteriaSelect.disabled = true;
                    criteriaSearch.disabled = true;
                    glInput.disabled = false;
                    zoneSelect.disabled = false; // Keep zone enabled
                }
                else if(value === "2") { // Region
                    regionSelect.disabled = false;
                    criteriaSelect.disabled = true;
                    glInput.disabled = false;
                    criteriaSearch.disabled = true;
                    zoneSelect.disabled = false;
                }
                else if(value === "3") { // Branch
                    regionSelect.disabled = false;
                    criteriaSelect.disabled = false;
                    glInput.disabled = false;
                    criteriaSearch.disabled = false;
                    zoneSelect.disabled = false;
                }
                else { // Default / empty
                    regionSelect.disabled = false;
                    criteriaSelect.disabled = false;
                    glInput.disabled = false;
                    criteriaSearch.disabled = false;
                    zoneSelect.disabled = false;
                }
            }
            // Run on change
            filter.addEventListener("change", updateInputs);
            // Run on page load in case a value is preselected
            updateInputs();
        });
        
        
        
        //ACCOUNT BALANCE AJAX==========================
        //gl checking total amount
        $('#serach_check_submit').on('click', function (event) {

            event.preventDefault();
            var action = $('#action').val();
            var per_check_date_gl_from = $('#per_check_date_gl_from').val();
            var per_check_zones = $('#per_check_zones').val();
            var per_check_region = $('#per_check_region').val();
            var per_check_gl_from_new = $('#per_check_gl_from_new').val();
            var per_check_gl_to = $('#per_check_gl_to').val();

            $(this).text("Searching...");
            $.ajax({
                url: "../fs_gl_check?ledger=total",
                type: "POST",
                data: {
                    ledger: "check",
                    action: action,
                    per_check_date_gl_from: per_check_date_gl_from,
                    per_check_zones: per_check_zones,
                    per_check_region: per_check_region,
                    per_check_gl_from_new: per_check_gl_from_new,
                    per_check_gl_to: per_check_gl_to
                },
                success: function (data) {
                    if(data==="")
                    {
                      
                    }
                    else
                    {
                      $('#checkgl_total').html(data);
                    }
                }
            });
        });

        $('#search_ho_current_submit').on('click', function (event) {
            event.preventDefault();

            var action                  = $('#action').val();
            var ho_current_date_gl_from = $('#ho_current_date_gl_from').val(); // ? RAW VALUE
            var ho_current_date_gl_to   = $('#ho_current_date_gl_to').val();   // ? RAW VALUE
            var ho_current_zones        = $('#ho_current_zones').val();
            var ho_current_criteria     = $('#ho_current_criteria').val();
            var ho_current_region       = $('#ho_current_region').val();
            var ho_current_gl           = $('#ho_current_gl').val();
            var ho_current_category     = $('#ho_current_category').val();

            // UI feedback
            $(this).text('Searching...');

            $('#ledger_ho_current').html(
                "<tr><td colspan='5' style='text-align:center;'>Generating data...</td></tr>"
            );

            $.ajax({
                url: "../fs_ho_current",
                type: "POST",
                data: {
                    action: action,
                    ho_current_date_gl_from: ho_current_date_gl_from, // SENT AS-IS
                    ho_current_date_gl_to: ho_current_date_gl_to,     // SENT AS-IS
                    ho_current_zones: ho_current_zones,
                    ho_current_criteria: ho_current_criteria,
                    ho_current_region: ho_current_region,
                    ho_current_gl: ho_current_gl,
                    ho_current_category: ho_current_category
                },
                success: function (data) {
                    $('#ledger_ho_current').html(
                        data || "<tr><td colspan='5' style='text-align:center;'>No record(s) found</td></tr>"
                    );
                    $('#search_ho_current_submit').text('Search');
                },
                error: function () {
                    alert('Could not load data');
                    $('#search_ho_current_submit').text('Search');
                }
            });
        });

        
        $('#search_allocated_submit').on('click', function (event) {

            event.preventDefault();

            var action = $('#action_allocated').val();

            var allocated_date_from = $('#allocated_date_from').val();
            var allocated_date_to   = $('#allocated_date_to').val();
            var allocated_zones     = $('#allocated_zones').val();
            var allocated_region    = $('#allocated_region').val();

            $(this).text('Searching...');

            $('#ledger_allocated').html(
                "<tr><td colspan='5' style='text-align:center;'>Generating data...</td></tr>"
            );

            $.ajax({
                url: "../fs_allocated_expenses", // your servlet for allocated expenses
                type: "POST",
                data: {
                    action: action,
                    allocated_date_from: allocated_date_from,
                    allocated_date_to: allocated_date_to,
                    allocated_zones: allocated_zones,
                    allocated_region: allocated_region
                },
                success: function (data) {
                    $('#ledger_allocated').html(data || 
                        "<tr><td colspan='5' style='text-align:center;'>No record(s) found</td></tr>"
                    );
                    $('#search_allocated_submit').text('Search');
                },
                error: function () {
                    alert('Could not load data');
                    $('#search_allocated_submit').text('Search');
                }
            });
        });
        
        $('#search_gl_check_submit').on('click', function (event) {

            event.preventDefault();

            var action = $('#action_gl_check').val();

            var gl_check_date_from = $('#gl_check_date_from').val();
            var gl_check_date_to   = $('#gl_check_date_to').val();
            var gl_check_zones     = $('#gl_check_zones').val();
            var gl_check_region    = $('#gl_check_region').val();
            var gl_check_gl_from   = $('#gl_check_gl_from').val();
            var gl_check_gl_to     = $('#gl_check_gl_to').val();

            $(this).text('Searching...');

            $('#ledger_gl_check').html(
                "<tr><td colspan='5' style='text-align:center;'>Generating data...</td></tr>"
            );

            $.ajax({
                url: "../fs_rent_gl_checking", // servlet URL
                type: "POST",
                data: {
                    action: action,
                    gl_check_date_from: gl_check_date_from,
                    gl_check_date_to: gl_check_date_to,
                    gl_check_zones: gl_check_zones,
                    gl_check_region: gl_check_region,
                    gl_check_gl_from: gl_check_gl_from,
                    gl_check_gl_to: gl_check_gl_to
                },
                success: function (data) {
                    $('#ledger_gl_check').html(data || 
                        "<tr><td colspan='5' style='text-align:center;'>No record(s) found</td></tr>"
                    );
                    $('#search_gl_check_submit').text('Search');
                },
                error: function () {
                    alert('Could not load data');
                    $('#search_gl_check_submit').text('Search');
                }
            });
        });
        //======================================================

            
            </script>    

    <style>
        .modal { display:none; position:fixed; z-index:999; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,0.5);}
        .modal-content {margin-top: 66px; background:#fff; margin:10% auto; padding:20px; width:600px; border-radius:6px; position:relative;}
        .modal-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-gap: 12px 20px;
            margin-top: 10px;
        }

        .modal-grid div label {
            font-weight: bold;
            margin-bottom: 3px;
            display: block;
        }

        .modal-grid input {
            width: 100%;
        }
        .close { position:absolute; top:10px; right:15px; font-size:18px; text-decoration:none; color:#333;}
        .close:hover { color:red; }
        
        .transfer-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 12px 20px;
            margin-bottom: 20px;
        }

        .transfer-grid label {
            font-weight: 600;
            margin-bottom: 3px;
            display: block;
        }
    </style>
    <div id="modal-dispose" class="modal">
        <div class="modal-content">
          <span class="close">&times;</span>

          <h3>Manage Asset #</h3>

          <form id="dispose Form" method="post" action="../record_transfer_asset">
              <div>
                <label>Action</label>
                <select id="asset_action" name="modal_action">
                    <option value="">Select Action</option>
                    <option value="dispose">Dispose Asset</option>
                    <option value="transfer">Transfer Asset</option>
                </select>
              </div>
            <div class="modal-grid">
              <div>
                <label>Code:</label>
                <input type="text" id="m_code" name="modal_code" class="form-control" readonly>
              </div>

              <div>
                <label>Branch:</label>
                <input type="text" id="m_branch" name="modal_branch" class="form-control" readonly>
              </div>

              <div>
                <label>Asset:</label>
                <input type="text" id="m_asset" name="modal_asset" class="form-control" readonly>
              </div>

              <div>
                <label>Description:</label>
                <input type="text" id="m_desc" name="modal_description" class="form-control" readonly>
              </div>

              <div>
                <label>Cost:</label>
                <input type="text" id="m_cost" name="modal_cost" class="form-control" readonly>
              </div>

              <div>
                <label>Depreciation:</label>
                <input type="text" id="m_de" name="modal_depreciation" class="form-control" readonly>
              </div>

              <div>
                <label>Accu. Dep.:</label>
                <input type="text" id="m_ad" name="modal_accu_dep" class="form-control" readonly>
              </div>

              <div>
                <label>Asset Lives:</label>
                <input type="text" id="m_remain" name="modal_asset_lives" class="form-control" readonly>
              </div>

              <div>
                <label>Book Value:</label>
                <input type="text" id="m_bv" name="modal_book_value" class="form-control" >
              </div>

              <div>
                <label>Reference Number</label>
                <input type="text" id="m_ref" name="modal_ref" class="form-control" >
                <input type="hidden" id="m_scrap" name="modal_scrap" class="form-control" >
                <input type="hidden" id="m_depdate" name="modal_depdate" class="form-control" >
                <input type="hidden" id="m_retiredate" name="modal_retiredate" class="form-control" >
                <input type="hidden" id="m_recID" name="modal_recID" class="form-control" >
              </div>

              <div>
                <label>Date:</label>
                <input type="text" id="m_date" name="modal_date" class="form-control" >
              </div>
            </div>

            <hr>

                <!-- Transfer To Section -->
                <div id="transfersec" class="form-row" style="display:none;margin-left: 5px;">

                    <p><strong>Transfer to:</strong></p>

                    <div class="transfer-grid">
                        <div class="">
                            <label>Zone</label>
                            <select name="transfer_zone" id="transfer_zones" class="form-control zone-select">
                                <option value="">Select Zone</option>
                            </select>
                        </div>

                        <div>
                            <label>Region</label>
                            <select name="transfer_region" id="transfer_region" class="form-control region-select">
                                <option value="">Select Region</option>
                            </select>
                        </div>

                        <div>
                            <label>Branch Name</label>
                            <select name="transfer_branch_id" id="transfer_branch" class="form-control branch-select">
                                <option value="">Select Region</option>
                            </select>
                            <input type="hidden" name="transfer_branch_hidden" id="transfer_branch_hidden">
                        </div>

                        <div>
                            <label>Branch ID</label>
                            <input type="text" id="transfer_branch_id" name="transfer_branch_id" class="form-control branch-select" readonly>
                            <input type="hidden" id="transfer_branch_id_hidden" name="transfer_branch_id" class="form-control branch-select">
                        </div>
                    </div>

                </div>
                <button type="submit" class="btn btn-primary" style="margin-top:15px;">Submit</button>
                </form> 
            </div>
        </div>
    
    
    </body>
</html>