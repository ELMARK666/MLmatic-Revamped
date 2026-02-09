<div class="glecontainer" style="display:none;">
    <div class="gleheader">GLE SUMMARY</div>
    <div class="form-section form-row1">
        <form action="../post_to_fsw" method="post" >
            <div class="input-group">
                <div class="input-with-button">
                    <select name="gle_zone" id="ho_zone" class="incss zone-select">
                        <option value="">Select Zone</option>
                    </select>
                </div>
            </div>
            <div class="input-group">
                <div class="input-with-button">
                    <select name="gle_region" id="ho_region" class="incss region-select">
                        <option value="">Select Region</option>
                    </select>
                </div>
            </div>
            <div class="input-group buttons">
                <button class="action-button export-button" type="submit" name="force_gle">
                    Export to CAD
                </button>
            </div>
            <div class="input-group">
                <div class="input-with-button">
                    <select name="gle_branch" id="ho_branch-code" class="incss branch-select">
                        <option value="">Select Branch</option>
                    </select>
                </div>
            </div>
            <div class="input-group">
                <div class="input-with-button">
                    <input type="date" id="ho_date-from" name="ho_date-from" class="incss">
                </div>
            </div>
            <div class="input-group buttons">
                <button class="action-button clear-button "><i class="fa-duotone fa-solid fa-arrows-rotate-reverse"></i>Clear</button>
            </div>
            <div class="input-group">
                <div class="input-with-button">
                    <input type="date" id="ho_date-to" name="ho_date-to" class="incss">
                </div>
            </div>
            <div class="input-group">

            </div>
            <div class="input-group buttons">

            </div>
            <div class="input-group">

            </div>
            <div></div>
        </form>
    </div>
</div>
<div id="zoneModal" class="modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
    <div class="modal-content" style="background:white; padding:20px; border-radius:8px; width:90%; max-width:600px; max-height:80vh; overflow:hidden; display:flex; flex-direction:column;">
        <span class="close" style="float:right; cursor:pointer;">&times;</span>
        <h3>Zone Search</h3>
        <div style="flex:1; overflow-y:auto; overflow-x:auto; border:1px solid #ccc; 
                    border-radius:4px; margin-top:10px;">
            <table id="zoneTable" style="width:100%; border-collapse:collapse; min-width:500px;">
                <thead style="position:sticky; top:0; background-color:#dc3545; color:white; text-align:center;">
                    <tr>
                        <th style="padding:8px; border:1px solid #ccc;">Zone ID</th>
                        <th style="padding:8px; border:1px solid #ccc;">Zone Name</th>
                        <th style="padding:8px; border:1px solid #ccc;">Action</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>
<div id="regionModal" class="modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
    <div class="modal-content" style="background:white; padding:20px; border-radius:8px; width:90%; max-width:600px; max-height:80vh; overflow:hidden; display:flex; flex-direction:column;">
        <span class="close" style="float:right; cursor:pointer;">&times;</span>
        <h3>Region Search</h3>
        <div style="flex:1; overflow-y:auto; overflow-x:auto; border:1px solid #ccc; 
                    border-radius:4px; margin-top:10px;">
            <table id="regionTable" style="width:100%; border-collapse:collapse; min-width:500px;">
                <thead style="position:sticky; top:0; background-color:#dc3545; color:white; text-align:center;">
                    <tr>
                        <th style="padding:8px; border:1px solid #ccc;">Region ID</th>
                        <th style="padding:8px; border:1px solid #ccc;">Region Name</th>
                        <th style="padding:8px; border:1px solid #ccc;">Action</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>
<div id="areaModal" class="modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
    <div class="modal-content" style="background:white; padding:20px; border-radius:8px; width:90%; max-width:600px; max-height:80vh; overflow:hidden; display:flex; flex-direction:column;">
        <span class="close" style="float:right; cursor:pointer;">&times;</span>
        <h3>Area Search</h3>
        <div style="flex:1; overflow-y:auto; overflow-x:auto; border:1px solid #ccc; 
                    border-radius:4px; margin-top:10px;">
            <table id="areaTable" style="width:100%; border-collapse:collapse; min-width:500px;">
                <thead style="position:sticky; top:0; background-color:#dc3545; color:white; text-align:center;">
                    <tr>
                        <th style="padding:8px; border:1px solid #ccc;">Area ID</th>
                        <th style="padding:8px; border:1px solid #ccc;">Area Name</th>
                        <th style="padding:8px; border:1px solid #ccc;">Action</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>
<div id="codeModal" class="modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
    <div class="modal-content" style="background:white; padding:20px; border-radius:8px; width:90%; max-width:600px; max-height:80vh; overflow:hidden; display:flex; flex-direction:column;">
        <span class="close" style="float:right; cursor:pointer;">&times;</span>
        <h3>Branch Code Search</h3>
        <div style="flex:1; overflow-y:auto; overflow-x:auto; border:1px solid #ccc; 
                    border-radius:4px; margin-top:10px;">
            <table id="codeTable" style="width:100%; border-collapse:collapse; min-width:500px;">
                <thead style="position:sticky; top:0; background-color:#dc3545; color:white; text-align:center;">
                    <tr>
                        <th style="padding:8px; border:1px solid #ccc;">Branch Code ID</th>
                        <th style="padding:8px; border:1px solid #ccc;">Branch Code Name</th>
                        <th style="padding:8px; border:1px solid #ccc;">Action</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>
<div class="hotransactioncontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <form action="../fs_edi_upload" method="post" enctype="multipart/form-data">
                <div class="form-popup" style="position: fixed; z-index: 10;">
                    <div class="form-row1">
                        <b></b>
                        <!-- Format selection -->
                        <select class="form-control" name="ho_trans" id="ho_trans" required>
                            <option value="">-- Select an option --</option>
                            <option value="AJE">Actual ALL Bonus AJE</option>
                            <option value="ATM POS">ATM POS</option>
                            <option value="Bills Payment">Bills Payment</option>
                            <option value="Branch Expense">Branch Expense</option>
                            <option value="Corporate">Corporate</option>
                            <option value="Domestic Partners">Domestic Partners</option>
                            <option value="ePins">ePins</option>
                            <option value="Forex">Forex</option>
                            <option value="Forex Corporate">Forex Corporate</option>
                            <option value="Insurance">Insurance</option>
                            <option value="KP Income">KP Income</option>
                            <option value="Logistics">Logistics</option>
                            <option value="MLW">MLW</option>
                            <option value="MLX">MLX</option>
                            <option value="OPI">OPI</option>
                            <option value="PEA">PEA</option>
                            <option value="Payroll">Payroll</option>
                            <option value="Payroll Remittance">Payroll Remittance</option>
                            <option value="Paysol">Paysol</option>
                            <option value="Provision">Provision</option>
                            <option value="SG">SG</option>
                            <option value="Smart Billing">Smart Billing</option>
                            <option value="SSMI">SSMI</option>
                            <option value="Telco">Telco</option>
                            <option value="Ticketing">Ticketing</option>   
                        </select>

                        <!-- Date input -->
                        <input type="date" class="form-control" name="trans_date" required>

                        <!-- Description input -->
                        <input type="text" class="form-control hidden" name="description" placeholder="Description">

                        <!-- File input -->
                        <input type="file" class="form-control-file" name="file" style="padding:5px;" accept=".xls" required>

                        <!-- Submit button -->
                        <input type="submit" class="form-control btn btn-success" value ="Submit" name="hotransaction_submit" style="padding:5px;background-color: #ED3500;">
                            

                        <!-- Download EDI Format button -->
                        <button type="button" class="form-control btn btn-success hidden" 
                                onclick="downloadEDI()" style="padding:5px;">
                            <span class="fa fa-download" style="padding:5px;"></span> Download EDI Format
                        </button>
                    </div>

                    <script>
                    function downloadEDI() {
                        var format = document.getElementById('ho_trans').value;
                        if(!format) {
                            alert('Please select a table format first.');
                            return;
                        }
                        // Open servlet with selected format in new tab
                        window.open('../Download_format?ho_trans=' + encodeURIComponent(format), '_blank');
                    }
                    </script>

                </div>
                <% if ("success".equals(request.getParameter("status"))) { %>
                    <div class="alert alert-success">
                        File uploaded and processed successfully.
                    </div>
                <% } %>
            </form>    
            <div class="edi-logs">
                <br>
                <label>Uploaded EDI Logs</label>
                <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr>
                            <th style="width: 10%;">Entries</th>
                            <th style="width: 30%;">Region</th>
                            <th style="width: 20%;">EDI Date</th>
                            <th style="width: 20%;">Uploader</th>
                            <th style="width: 20%;">Date Uploaded</th>
                        </tr>
                    </thead>
                    <tbody id="ediLogs">
                        <tr>
                            <td colspan="5" style="text-align:center; color: gray;">No EDI Logs found.</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="registrationcontainer">
    <div class="form-popup">
        <form method="POST" action="../save_new_asset" id="save_asset" enctype="multipart/form-data" autocomplete="off">
        <div class="form-row" style="display:flex; align-items:center; gap:10px; margin-bottom:15px;">
            <b style="white-space:nowrap; width:130px;">Branch Details:</b>
            <select name="zone" id="asset_zones" class="incss zone-select">
                <option value="">Select Zone</option>
            </select>
            <select name="region" id="asset_region" class="incss region-select">
                <option value="">Select Region</option>
            </select>
            
            <select name="branch_insert" id="asset_branch" class="incss branch-select">
                <option value="">Select Branch</option>
            </select>
            
            <input class="form-control hidden" id="branch_name_s" name="branch_name_insert" placeholder="Branch Name" >
            
            <input id="branch_id" name="asset_branch_id" placeholder="Branch ID" class="incss id-select" readonly>
            <input class="hidden id-select-copy" id="asset_branch_id_s" name="asset_branch_id_insert">
        </div>
        <div class="form-row" style="display:flex; align-items:center; gap:10px; margin-bottom:15px;">
            <b style="white-space:nowrap; width:130px;">Asset Details:</b>
            <input name="ref_id" id="ref_id" placeholder="Reference Number" class="incss">
            <select name="asset_cat" id="asset_cat" class="incss">
                <option value="">Select Asset Category</option>
                <option value="Appraisal Tools">Appraisal Tools</option>
                <option value="Computer Equipment and Peripherals">Computer Equipment and Peripherals</option>
                <option value="Dealer Incentives">Dealer Incentives</option>
                <option value="Furnitures and Fixtures">Furnitures and Fixtures</option>
                <option value="Goodwill">Goodwill</option>
                <option value="Leasehold Improvement">Leasehold Improvement</option>
                <option value="Office Equipment">Office Equipment</option>
                <option value="Prepaid ADS">Prepaid ADS</option>
                <option value="Pre-Operating Expense">Pre-Operating Expense</option>
                <option value="Prepaid Rentals">Prepaid Rentals</option>
                <option value="Repair and Maintenance">Repair and Maintenance</option>
                <option value="Service Vehicle">Service Vehicle</option>
                <option value="Softwares">Softwares</option>
                <option value="T-Shirts/Flyers/Calendar">T-Shirts/Flyers/Calendar</option>
            </select>
            <input class="incss" id="asset_code" name="asset_code" placeholder="Code" readonly>
            <input class="form-control mt-2 hidden" id="asset_code_insert" name="asset_code_insert">
            <input name="desc" id="desc" placeholder="Description" class="incss">
        </div>
        <div class="form-row" style="display:flex; align-items:center; gap:10px; margin-bottom:15px;">
            <b style="white-space:nowrap; width:130px;"></b>
            <input type="text" id="date_rec" name="date_rec" placeholder="Date Received" onfocus="(this.type='date')" onblur="if(!this.value)this.type='text'"class="incss">
            <input name="aqui_cost" id="aqui_cost" placeholder="Acquisition Cost" class="incss">
            <input id="scrap_value" name="scrap_value" placeholder="Scrap Value" class="incss">
            <input type="text" id="dep_date" name="dep_date" placeholder="Depreciation Date" onfocus="(this.type='date')" onblur="if(!this.value)this.type='text'" class="incss">
        </div>
        <div class="form-row" style="display:flex; align-items:center; gap:10px;">
            <b style="white-space:nowrap; width:130px;"></b>
            <input id="life" name="life" placeholder="Asset Life" class="incss">
            <input type="text" id="retire_date" name="retire_date" placeholder="Retirement Date" onfocus="(this.type='date')" onblur="if(!this.value)this.type='text'" class="incss">
            <input type="submit" class="form-control" id="submit" name="submit_asset" value="Submit Asset" style="flex:1; height:38px; background-color:#28a745; color:white; border:none; border-radius:6px; cursor:pointer;">
        </div>
        </form>
    </div>
</div>
<div class="generationcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup" style="position: fixed; z-index: 10;">
                <div class="form-row">
                    <input type="text" class="form-control" id="generate_date" name="generate_date" placeholder="Date" onfocus="(this.type='date')" onblur="if(!this.value)this.type='text'">
                    <select class="form-control zone-select" id="generate_zones" name="generate_zone">
                        <option value="">Select Zone</option>
                    </select>
                    <select class="form-control region-select" id="generate_region" name="generate_region">
                        <option value="">Select Region</option>
                    </select>
                    <input type="hidden" name="action" id="action" value="filter_asset" />
                    <button type="button" class="form-control" id="generate_submit" name="generate_submit" data-prefix="generate">Go</button>
                    <button type="button" class="form-control" id="generate_asset" name="generate_asset" data-prefix="generate">Generate</button>
                    <button type="button" class="btn btn-info form-control hidden" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br>
                <label></label>
                <table class="table table-bordered table-hover" id="generate_report" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Code</th>
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Branch</th>
                            <th style="text-align-last: center;">Asset Lives</th>
                            <th style="text-align-last: center;">Depreciation</th>
                        </tr>
                    </thead>
                    <tbody id="generate_asset_report"></tbody>
                    <tfoot>
                        <tr>
                            <td colspan="6" style="text-align:center;font-weight:bold;">No data available in table.</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="managementcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <select class="form-control zone-select" id="manage_zones" name="manage_zones">
                        <option value="">Select Zone</option>
                    </select>
                    <input type="text" class="form-control" id="management_search_asset" name="management_search_asset" placeholder="Search">
                    <input type="text" class="form-control" id="management_date_from" name="management_date_from" placeholder="Date From:" onfocus="(this.type='date')" onblur="if(!this.value)this.type='text'">
                    <input type="text" class="form-control" id="management_date_to" name="management_date_to" placeholder="Date To:" onfocus="(this.type='date')" onblur="if(!this.value)this.type='text'">
                    <select class="form-control criteria" id="manage_asset_criteria" name="management_asset_criteria">
                        <option value="">Filter By</option>
                        <option value="Asset">Asset(s)</option>
                        <option value="Asset_Code">Asset Code</option>
                        <option value="Branch_Name">Branch Name</option>
                        <option value="Region_ID">Region ID</option>
                    </select>
                    <input type="hidden" name="action" id="action" value="filter_manage_asset" />
                    <button type="button" class="form-control" id="manage_submit" name="manage_submit" data-prefix="generate">Search Asset(s)</button>
                        
                </div>
            </div>
            <div class="edi-logs">
                <br>
                <label></label>
                <table class="table table-bordered table-hover" id="manage_report" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Code</th>
                            <th style="text-align-last: center;">Branch ID</th>
                            <th style="text-align-last: center;">Asset Category</th>
                            <th style="text-align-last: center;">Description</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Depreciation</th>
                            <th style="text-align-last: center;">Accu. Dep.</th>
                            <th style="text-align-last: center;">Asset Lives</th>
                            <th style="text-align-last: center;">Book Value</th>
                            <th style="text-align-last: center;">Date Gen.</th>
                            <th style="text-align-last: center;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="manage_asset_report"></tbody>
                    <tfoot>
                        <tr>
                            <td colspan="11" style="text-align:center;font-weight:bold;">-- No data available in table. --</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>


<div class="importdatacontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row1">
                    <b>importdata</b>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="viewimportdatacontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row1">
                    <b>viewimportdata</b>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="branchexpensecontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <select class="form-control date_start" name="branchexpense_month1" id="branchexpense_month1" data-prefix="branchexpense"></select>
                    <select class="form-control year_select" name="branchexpense_year" id="branchexpense_year" data-prefix="branchexpense">
                        <option value="">YYYY</option>
                    </select>
                    <select class="form-control zone-select" id="branchexpense_zones" name="branchexpense_zones" data-prefix="branchexpense"></select>
                    <select class="form-control region-select" id="branchexpense_region" name="branchexpense_region" data-prefix="branchexpense"></select>
                    <button type="button" class="form-control" id="branchexpense_submit" name="branchexpense_submit" data-prefix="branchexpense">Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel</button>
                </div>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th> 
                                <th>GLCode</th> 
                                <th style="text-align:center;">Zone</th>
                                <th style="text-align:left;">Region</th>
                                <th style="text-align:left;">Branch</th>
                                <th style="text-align:left;">Amount</th> 
                                <th style="text-align:left;">Description</th> 
                                <th style="text-align:left;">Category</th> 
                            </tr>
                        </thead>
                        <tbody class="branchexpense_report">
                            <tr>
                                <td colspan='8'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="crrfliquidationcontainer" style="display:none;">
    <br>
    <div style="padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <b>Upload CRRF</b>
                    <input type="date" class="form-control" id="crrfliquidation_date" name="crrfliquidation_date" required>
                    <select class="form-control" id="crrfliquidation_region" name="crrfliquidation_region">
                            <option value="">Choose</option>
                        <option value="1">NCR Batanes Region</option>
                        <option value="2">NCR Central Region</option>
                        <option value="3">NCR North Region</option>
                        <option value="4">NCR Rizal Region</option>
                        <option value="5">Almasor Region</option>
                        <option value="8">Bazam Region</option>
                        <option value="9">Bulacan Region</option>
                        <option value="6">Camacat Region</option>
                        <option value="4158">Ilocabra Region</option>
                        <option value="13">Laguna Region</option>
                        <option value="7">Pampanga Region</option>
                        <option value="10">North Eastern Luzon Region</option>
                        <option value="11">North Western Luzon Region</option>
                        <option value="12">Northern Luzon Region</option>
                        <option value="49">Quivisagao Region</option>
                        <option value="14">South Eastern Luzon Region</option>
                        <option value="16">South Western Luzon Region</option>
                        <option value="15">Southern Luzon Region</option>
                        <option value="17">TARPAN Luzon Region</option>
                        <option value="22">Bohol Region</option>
                        <option value="18">Cebu Central Region A</option>
                        <option value="31">Cebu Central Region B</option>
                        <option value="19">Cebu North A</option>
                        <option value="30">Cebu North B</option>
                        <option value="20">Cebu South Region</option>
                        <option value="23">Leyte A</option>
                        <option value="4149">Leyte B</option>
                        <option value="21">Neg. Or-Siquijor Region</option>
                        <option value="25">Negros Occidental A</option>
                        <option value="4150">Negros Occidental B</option>
                        <option value="28">Panay Central Region</option>
                        <option value="27">Panay North Region</option>
                        <option value="26">Panay South Region</option>
                        <option value="29">Palawan Region</option>
                        <option value="24">Samar Region</option>
                        <option value="4151">Bukidnon Region</option>
                        <option value="34">CARAGA Norte Region</option>
                        <option value="35">CARAGA Sur Region</option>
                        <option value="40">CDO</option>
                        <option value="39">Cotabato Maguindanao Region</option>
                        <option value="37">Dacoda Region</option>
                        <option value="36">Davao Region</option>
                        <option value="41">Lanao Region</option>
                        <option value="38">Sargen Mindanao Region</option>
                        <option value="46">Socsk Mindanao Region</option>
                        <option value="45">Zambas Region</option>
                        <option value="4157">Zamsulta Region</option>
                        <option value="44">Zamsibugay Mindanao Region</option>
                        <option value="43">Zanorte Region</option>
                        <option value="42">Zasurmis Region</option>
                    </select>
                    <input type="file" id="crrfliquidation_file" name="crrfliquidation_file" class="form-control" accept=".xls,.xlsx,.csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,text/csv" required style="width: 100%;">
                    <button type="submit" class="btn btn-success w-100" name="crrfliquidation_submit" id="crrfliquidation_submit" style="width: 100%;">Upload</button>
                </div>
            </div>
        </div>
        <div class="edi-logs">
            <br><br>
            <label>Expense Allocation</label>
            <table class="table table-bordered table-hover" id="generatetable" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                <thead style="color: Black; text-align: center;">
                    <tr id="table-header">
                        <th style="text-align-last: center;">Expense Type</th>
                        <th style="text-align-last: center;">Date</th>
                        <th style="text-align-last: center;">Region</th>
                        <th style="text-align-last: center;">Scheme</th>
                        <th style="text-align-last: center;">Amount</th>
                        <th style="text-align-last: center;">Action</th>
                    </tr>
                </thead>
                <tbody id="generatereport"></tbody>
                <tfoot>
                    <tr>
                        <td colspan="6" style="text-align:center;font-weight:bold;">No data available in table.</td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
<div class="smartplanholderscontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <input type="date" name = "smartplanholders_date" id = "smartplanholders_date">
                    <button type="submit" class="btn btn-success w-100" name="smartplanholders_submit" id="smartplanholders_submit" style="width: 100%;">Upload</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="edireportcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>edireport</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--<div class="errorcorporateaccountscontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup" style="position: fixed; z-index: 10;">
                <div class="form-row">
                    <select class="form-control date_start" name="errorcorporateaccounts_month1"></select>
                    <select class="form-control year_select" name="errorcorporateaccounts_year">
                        <option value="">YYYY</option>
                    </select>
                    <select class="form-control zone-select" id="errorcorporateaccounts_zones" name="errorcorporateaccounts_zones"></select>
                    <select class="form-control region-select" id="errorcorporateaccounts_region" name="errorcorporateaccounts_region"></select>
                    <button type="button" class="form-control" id="errorcorporateaccounts_submit" name="errorcorporateaccounts_submit" data-prefix="errorcorporateaccounts">Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br>
                <label></label>
                <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Date</th>
                            <th style="text-align-last: center;">GLCode</th>
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Branches</th>
                            <th style="text-align-last: center;">Description</th>
                            <th style="text-align-last: center;" id="_header">Amount</th>
                            <th style="text-align-last: center;">Category</th>
                        </tr>
                    </thead>
                    <tbody id="errorcorporateaccounts_report"></tbody>
                    <tfoot>
                        <tr>
                            <td colspan="6" style="text-align:center;font-weight:bold;">Total</td>
                            <td id="totalAmount" style="text-align:right;font-weight:bold;">0.00</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>-->
<div class="incomeexpenseaccountscontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup" style="position: fixed; z-index: 10;">
                <div class="form-row">
                    <select class="form-control date_start" name="incomeexpenseaccounts_month1"></select>
                    <select class="form-control year_select" name="incomeexpenseaccounts_year">
                        <option value="">YYYY</option>
                    </select>
                    <select class="form-control criteria_select" name="incomeexpenseaccounts_citeria">
                        <option value="both">Criteria</option>
                        <option value="in">Income</option>
                        <option value="ex">Expense</option>
                    </select>
                    <select class="form-control zone-select" id="incomeexpenseaccounts_zones" name="incomeexpenseaccounts_zones"></select>
                    <select class="form-control region-select" id="incomeexpenseaccounts_region" name="incomeexpenseaccounts_region"></select>
                    <select class="form-control branch-select" id="incomeexpenseaccounts_branch" name="incomeexpenseaccounts_branch" data-prefix="incomeexpenseaccounts" required></select>
                    <button type="button" class="form-control" id="incomeexpenseaccounts_submit" name="incomeexpenseaccounts_submit" data-prefix="incomeexpenseaccounts">Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br><br>
                <table class="table table-bordered table-hover" id="incomeexpenseaccounts_table" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Date</th>
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Branches</th>
                            <th style="text-align-last: center;">Description</th>
                            <th style="text-align-last: center;">GLCode</th>
                            <th style="text-align-last: center;" id="_header">Amount</th>
                            <th style="text-align-last: center;">Category</th>
                        </tr>
                    </thead>
                    <tbody id="incomeexpenseaccounts_report">
                        <tr>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td colspan="8"><center>- No Data Generated -</center></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="spcostingcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <select class="form-control date_start" name="spcosting_month1" required></select>
                    <select class="form-control year_select" name="spcosting_year" required>
                        <option value="">YYYY</option>
                    </select>
                    <select class="form-control zone-select" id="spcosting_zones" name="spcosting_zones" required></select>
                    <select class="form-control region-select" id="spcosting_region" name="spcosting_region" required></select>
                    <button type="button" class="form-control" id="spcosting_submit" name="spcosting_submit" data-prefix="spcosting">Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br><br>
                <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th colspan="2" class="zr"></th>
                            <th colspan="2" style="text-align-last: center;">Food Products</th>
                            <th colspan="2" style="text-align-last: center;">Telco Products</th>
                            <th colspan="2" style="text-align-last: center;">Broadband Kit</th>
                            <th colspan="2" style="text-align-last: center;">Sim Pack</th>
                            <th colspan="2" style="text-align-last: center;">Retailer Wallet</th>
                            <th colspan="2" style="text-align-last: center;">Electronic Pins</th>
                            <th colspan="2" style="text-align-last: center;">Prepaid Health Products</th>
                            <th colspan="2" style="text-align-last: center;">Air Ticketing</th>
                            <th colspan="2" style="text-align-last: center;">Sea Ticketing</th>
                            <th colspan="2" style="text-align-last: center;">ML Water</th>
                            <th colspan="2" style="text-align-last: center;">Phones</th>
                            <th colspan="2" style="text-align-last: center;">Logistic Items</th>
                        </tr>
                        <tr>
                            <th style="text-align-last: center;">Date</th>
                            <th style="text-align-last: center;">Branches</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                            <th style="text-align-last: center;">Sales</th>
                            <th style="text-align-last: center;">Cost</th>
                        </tr>
                    </thead>
                    <tbody id="spcosting_report">
                        <tr>
                            <td colspan="26"><center>- No Data Generated -</center></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="sundryaccountcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <select class="form-control date_start" name="sundryaccount_month1" required></select>
                    <select class="form-control year_select" name="sundryaccount_year" required>
                        <option value="">YYYY</option>
                    </select>
                    <select class="form-control zone-select" id="sundryaccount_zones" name="sundryaccount_zones" required></select>
                    <select class="form-control region-select" id="sundryaccount_region" name="sundryaccount_region" required></select>
                    <button type="button" class="form-control" id="sundryaccount_submit" name="sundryaccount_submit" data-prefix="sundryaccount">Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br><br>
                <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Date</th>
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Area</th>
                            <th style="text-align-last: center;">Branch</th>
                            <th style="text-align-last: center;">Amount</th>
                        </tr>
                    </thead>
                    <tbody id="sundryaccount_report">
                        <tr>
                            <td colspan="6"><center>- No Data Generated -</center></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="singleinputajecontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>singleinputaje</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="multiloadajecontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>multiloadaje</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="outputtaxreversalcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>ouputtaxreversal</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="drcashbalancecontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="drcashbalance_zones" name="drcashbalance_zones" data-prefix="drcashbalance" required></select>
                        <select class="form-control region-select" id="drcashbalance_region" name="drcashbalance_region" data-prefix="drcashbalance" required></select>
                        <input type="date" class="form-control date_start" required/>
                        <select class="form-control c1_select" id="drcashbalance_criteria1" name="drcashbalance_criteria1" required>
                            <option value="">Cash</option>
                            <option value="teller">Teller Cash</option>
                            <option value="vault">Vault Cash</option>
                        </select>
                        <select class="form-control c2_select" id="drcashbalance_criteria2" name="drcashbalance_criteria2" required>
                            <option value="">Currency</option>
                            <option value="php">PHP</option>
                            <option value="usd">USD</option>
                            <option value="eur">EUR</option>
                            <option value="jpy">JPY</option>
                        </select>
                        <button type="button" class="form-control" id="drcashbalance_submit" name="drcashbalance_submit" data-prefix="drcashbalance">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th colspan="3" style="text-align-last: center;">AutoEntries</th>
                                <th colspan="3" style="text-align-last: center;">Online BCA</th> 
                                <th style="text-align-last: center;">Variance</th> 
                            </tr>
                            <tr>
                                <th colspan="4" ></th>
                                <th style="text-align-last: center;">Per Book</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th style="text-align-last: center;">Per Report</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th></th> 
                            </tr>
                        </thead>
                        <tbody class="drcashbalance_report">
                            <tr>
                                <td colspan='11'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="bankbalancecontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="bankbalance_zones" name="bankbalance_zones" data-prefix="bankbalance" required></select>
                        <select class="form-control region-select" id="bankbalance_region" name="bankbalance_region" data-prefix="bankbalance" required></select>
                        <input type="date" class="form-control date_start" required/>
                        <select class="form-control c2_select" id="bankbalance_criteria2" name="bankbalance_criteria2" required>
                            <option value="">Currency</option>
                            <option value="php">PHP</option>
                            <option value="usd">USD</option>
                        </select>
                        <button type="button" class="form-control" id="bankbalance_submit" name="bankbalance_submit" data-prefix="bankbalance">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th colspan="3" style="text-align-last: center;">AutoEntries</th>
                                <th colspan="3" style="text-align-last: center;">Online BCA</th> 
                                <th style="text-align-last: center;">Variance</th> 
                            </tr>
                            <tr>
                                <th colspan="4" ></th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th style="text-align-last: center;">Per Report</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th></th> 
                            </tr>
                        </thead>
                        <tbody class="bankbalance_report">
                            <tr>
                                <td colspan='11'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="drreceivablescontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="drreceivables_zones" name="drreceivables_zones" data-prefix="drreceivables" required></select>
                        <select class="form-control region-select" id="drreceivables_region" name="drreceivables_region" data-prefix="drreceivables" required></select>
                        <input type="date" class="form-control date_start" required/>
                        <select class="form-control c2_select" required>
                            <option value="">Select</option>
                            <option value="bca">Online BCA</option>
                            <option value="tl">Trans Log</option>
                        </select>
                        <button type="button" class="form-control" id="drreceivables_submit" name="drreceivables_submit" data-prefix="drreceivables">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th colspan="3" style="text-align-last: center;">AutoEntries</th>
                                <th colspan="3" class="cselect" style="text-align-last: center;"></th> 
                                <th style="text-align-last: center;">Variance</th> 
                            </tr>
                            <tr>
                                <th colspan="4" ></th>
                                <th style="text-align-last: center;">Per Book</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th style="text-align-last: center;">Per Report</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th></th> 
                            </tr>
                        </thead>
                        <tbody class="drreceivables_report">
                            <tr>
                                <td colspan='11'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="qclinterestcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="qclinterest_zones" name="qclinterest_zones" data-prefix="qclinterest" required></select>
                        <select class="form-control region-select" id="qclinterest_region" name="qclinterest_region" data-prefix="qclinterest" required></select>
                        <input type="date" class="form-control date_start" required/>
                        <select class="form-control c1_select" required>
                            <option value="">Select</option>
                            <option value="in">Interest</option>
                            <option value="ad">Adv. Interest</option>
                            <option value="or">Ord. Interest</option>
                            <option value="li">Liquidated Damages</option>
                            <option value="se">Service Charge</option>
                        </select>
                        <select class="form-control c2_select" required>
                            <option value="">Select</option>
                            <option value="bca">Online BCA</option>
                            <option value="tl">Trans Log</option>
                        </select>
                        <button type="button" class="form-control" id="qclinterest_submit" name="qclinterest_submit" data-prefix="qclinterest">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th colspan="3" style="text-align-last: center;">AutoEntries</th>
                                <th colspan="3" class="cselect" style="text-align-last: center;"></th> 
                                <th style="text-align-last: center;">Variance</th> 
                            </tr>
                            <tr>
                                <th colspan="4" ></th>
                                <th style="text-align-last: center;">Per Book</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th style="text-align-last: center;">Per Report</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th></th> 
                            </tr>
                        </thead>
                        <tbody class="qclinterest_report">
                            <tr>
                                <td colspan='11'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="billspaymentcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="billspayment_zones" name="billspayment_zones" data-prefix="billspayment" required></select>
                        <select class="form-control region-select" id="billspayment_region" name="billspayment_region" data-prefix="billspayment" required></select>
                        <input type="date" class="form-control date_start" required/>
                        <select class="form-control c1_select" required>
                            <option value="">Select</option>
                            <option value="p">Principal</option>
                            <option value="c">Commission</option>
                        </select>
                        <select class="form-control c2_select" required>
                            <option value="">Select</option>
                            <option value="bca">Online BCA</option>
                            <option value="tl">Trans Log</option>
                        </select>
                        <button type="button" class="form-control" id="billspayment_submit" name="billspayment_submit" data-prefix="billspayment">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th colspan="3" style="text-align-last: center;">AutoEntries</th>
                                <th colspan="3" class="cselect" style="text-align-last: center;"></th> 
                                <th style="text-align-last: center;">Variance</th> 
                            </tr>
                            <tr>
                                <th colspan="4" ></th>
                                <th style="text-align-last: center;">Per Book</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th style="text-align-last: center;">Per Report</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th></th> 
                            </tr>
                        </thead>
                        <tbody class="billspayment_report">
                            <tr>
                                <td colspan='11'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="corporatepaymentcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="corporatepayment_zones" name="corporatepayment_zones" data-prefix="corporatepayment" required></select>
                        <select class="form-control region-select" id="corporatepayment_region" name="corporatepayment_region" data-prefix="corporatepayment" required></select>
                        <input type="date" class="form-control date_start" required/>
                        <select class="form-control c1_select" required>
                            <option value="">Select</option>
                            <option value="p">Principal</option>
                            <option value="c">Commission</option>
                        </select>
                        <select class="form-control c2_select" required>
                            <option value="">Select</option>
                            <option value="bca">Online BCA</option>
                            <option value="tl">Trans Log</option>
                        </select>
                        <button type="button" class="form-control" id="corporatepayment_submit" name="corporatepayment_submit" data-prefix="corporatepayment">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th colspan="3" style="text-align-last: center;">AutoEntries</th>
                                <th colspan="3" class="cselect" style="text-align-last: center;"></th> 
                                <th style="text-align-last: center;">Variance</th> 
                            </tr>
                            <tr>
                                <th colspan="4" ></th>
                                <th style="text-align-last: center;">Per Book</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th style="text-align-last: center;">Per Report</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th></th> 
                            </tr>
                        </thead>
                        <tbody class="corporatepayment_report">
                            <tr>
                                <td colspan='11'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="paymentsolutionscontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="paymentsolutions_zones" name="paymentsolutions_zones" data-prefix="paymentsolutions" required></select>
                        <select class="form-control region-select" id="paymentsolutions_region" name="paymentsolutions_region" data-prefix="paymentsolutions" required></select>
                        <input type="date" class="form-control date_start" required/>
                        <select class="form-control c1_select" required>
                            <option value="">Select</option>
                            <option value="p">Principal</option>
                            <option value="c">Commission</option>
                        </select>
                        <select class="form-control c2_select" required>
                            <option value="">Select</option>
                            <option value="bca">Online BCA</option>
                            <option value="tl">Trans Log</option>
                        </select>
                        <button type="button" class="form-control" id="paymentsolutions_submit" name="paymentsolutions_submit" data-prefix="paymentsolutions">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th>Date</th>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th colspan="3" style="text-align-last: center;">AutoEntries</th>
                                <th colspan="3" class="cselect" style="text-align-last: center;"></th> 
                                <th style="text-align-last: center;">Variance</th> 
                            </tr>
                            <tr>
                                <th colspan="4" ></th>
                                <th style="text-align-last: center;">Per Book</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th style="text-align-last: center;">Per Report</th>
                                <th style="text-align-last: center;">Adjustment</th> 
                                <th style="text-align-last: center;">Total</th> 
                                <th></th> 
                            </tr>
                        </thead>
                        <tbody class="paymentsolutions_report">
                            <tr>
                                <td colspan='11'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="jewelrysalescontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <input type="date" class="form-control date_start" required/>
                    <select class="form-control zone-select" required></select>
                    <select class="form-control region-select" required></select>
                    <button type="button" class="form-control submit" id="jewelrysales_submit" name="jewelrysales_submit" >Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br><br>
                <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Date</th>
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Branch</th>
                            <th style="text-align-last: center;">Sales - Jewelry</th>
                            <th style="text-align-last: center;">Cost of Sales Jewelries</th>
                            <th style="text-align-last: center;">%</th>
                        </tr>
                    </thead>
                    <tbody id="jewelrysales_report">
                        <tr>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td colspan="7"><center>- No Data Generated -</center></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="ispdinsurancesalescontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <input type="date" class="form-control date_start" required/>
                    <select class="form-control zone-select" id="ispdinsurancesales_zones" name="ispdinsurancesales_zones" required></select>
                    <select class="form-control region-select" id="ispdinsurancesales_region" name="ispdinsurancesales_region" required></select>
                    <button type="button" class="form-control submit" id="ispdinsurancesales_submit" name="ispdinsurancesales_submit">Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br><br>
                <table class="table table-bordered table-hover" id="ispdinsurancesales_table"style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Date</th>
                            <th style="text-align-last: center;">GLCode</th>
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Branches</th>
                            <th style="text-align-last: center;">Description</th>
                            <th style="text-align-last: center;" id="_header">Present Amount</th>
                        </tr>
                    </thead>
                    <tbody id="ispdinsurancesales_report">
                        <tr>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td colspan="7"><center>- No Data Generated -</center></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="ispdincentivescontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <div class="form-row">
                    <input type="date" class="form-control date_start" required/>
                    <select class="form-control zone-select" id="ispdincentives_zones" name="ispdincentives_zones" required></select>
                    <select class="form-control region-select" id="ispdincentives_region" name="ispdincentives_region" required></select>
                    <button type="button" class="form-control submit" id="ispdincentives_submit" name="ispdincentives_submit">Search</button>
                    <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()">
                        <span class="fa fa-file-excel-o"></span> Excel
                    </button>
                </div>
            </div>
            <div class="edi-logs">
                <br><br>
                <table class="table table-bordered table-hover" id="ispdincentives_table" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">GLCode</th>
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Branches</th>
                            <th style="text-align-last: center;">Description</th>
                            <th style="text-align-last: center;" id="_header">Present Amount</th>
                            <th style="text-align-last: center;">Item Code</th>
                        </tr>
                    </thead>
                    <tbody id="ispdincentives_report">
                        <tr>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td colspan="7"><center>- No Data Generated -</center></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                            <td style="display: none;"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="dataperdatecontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="dataperdate_zones" name="dataperdate_zones" data-prefix="dataperdate" required></select>
                        <select class="form-control region-select" id="dataperdate_region" name="dataperdate_region" data-prefix="dataperdate" required></select>
                        <select class="form-control date_start" id="dataperdate_month1" name="dataperdate_month1" required></select>
                        <select class="form-control year_select" id="dataperdate_year" name="dataperdate_year" required>
                            <option value="">YYYY</option>
                        </select>
                        <button type="button" class="form-control" id="dataperdate_submit" name="dataperdate_submit" data-prefix="dataperdate">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <div style="overflow-y: auto; max-height: 700px;">
                    <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse;">
                        <thead style="color: Black; text-align: center; position: sticky; top: 0; background-color: #fff; z-index: 1;">
                            <tr>
                                <th id="nameofregion" colspan="4">Region/Branch :</th> 
                            </tr>
                            <tr>
                                <th>Zone</th> 
                                <th>Region</th> 
                                <th>Branch</th> 
                                <th style="text-align-last: center;">GLE WEB Count</th>
                                <th style="text-align-last: center;">FS Count</th> 
                                <th style="text-align-last: center;">Transaction Variance</th> 
                            </tr>
                        </thead>
                        <tbody class="dataperdate_report">
                            <tr>
                                <td colspan='5'><center>- No Data Generated -</center></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="webdatacontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row">
                        <select class="form-control zone-select" id="webdata_zones" name="webdata_zones" data-prefix="webdata" required></select>
                        <select class="form-control region-select" id="webdata_region" name="webdata_region" data-prefix="webdata" required></select>
                        <select class="form-control date_start" id="webdata_month1" name="webdata_month1" required></select>
                        <select class="form-control year_select" id="webdata_year" name="webdata_year" required>
                            <option value="">YYYY</option>
                        </select>
                        <button type="button" class="form-control" id="webdata_submit" name="webdata_submit" data-prefix="webdata">Search</button>
                        <button type="button" class="btn btn-info form-control" id="excel" onclick="downloadExcel()"><span class="fa fa-file-excel-o"></span> Excel </button>
                    </div>
                </form>
            </div>
            <div class="edi-logs" style="max-height: 700px;">
                <br><br>
                <table class="table table-bordered table-hover" style="width:100%; border-collapse: collapse; margin-top: 10px;">
                    <thead style="color: Black; text-align: center;">
                        <tr id="table-header">
                            <th style="text-align-last: center;">Zone</th>
                            <th style="text-align-last: center;">Region</th>
                            <th style="text-align-last: center;">Branch</th>
                            <th style="text-align-last: center;">GLE Web Count</th>
                            <th style="text-align-last: center;">FS Count</th>
                            <th style="text-align-last: center;">Transaction Variance</th>
                        </tr>
                    </thead>
                    <tbody id="webdata_report"></tbody>
                    <tfoot>
                        <tr>
                            <td colspan="6" style="text-align:center;">- No Data Generated -</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="incomesummarypostingcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>incomesummaryposting</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="yearendclosingcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>yearendclosing</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="absgeneralbalancesheetcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>absgeneralbalancesheet</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="aisgeneralincomestatementcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>aisgeneralincomestatement</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="branchlistcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>branchlist</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="glaccountcontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>glaccount</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="passwordchangecontainer" style="display:none;">
    <br>
    <div style="display: flex; gap: 20px; padding: 0 20px;">
        <div style="flex: 1;">
            <div class="form-popup">
                <form method="POST" enctype="multipart/form-data" autocomplete="off" >
                    <div class="form-row1">
                        <b>passwordchange</b>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="receivableModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Receivable</h5>
            </div>
            <div class="modal-body">
                <p>
                    <strong>Date:</strong> <span id="modal_date"></span>&nbsp&nbsp&nbsp
                    <strong>Branch:</strong> <span id="modal_branch"></span>&nbsp&nbsp&nbsp
                    <strong>Per Book:</strong> <span id="modal_amount"></span>
                </p>
                <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
                    <label style="width: 120px; margin: 0;">Understated :</label>
                    <input type="text" id="modal_adj_under" inputmode="decimal" class="form-control" placeholder="Enter Understated" style="max-width: 180px;">
                </div>
                <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
                    <label style="width: 120px; margin: 0;">Overstated :</label>
                    <input type="text" id="modal_adj_over" inputmode="decimal" class="form-control" placeholder="Enter Overstated" style="max-width: 180px;">
                </div>
                <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
                    <label style="width: 120px; margin: 0;">Remarks :</label>
                    <input type="text" id="modal_adj_remark" class="form-control" placeholder="Enter Remarks" style="max-width: 300px;">
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeReceivableModal()">Close</button>
                <button class="btn btn-primary" id="modal_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>
