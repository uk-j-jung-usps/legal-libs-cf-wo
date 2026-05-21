<cfscript>
// Helper function: Render a select option with proper selected state
function renderOption(value, currentValue = "") {
	var isSelected = (len(trim(arguments.currentValue)) && trim(arguments.currentValue) EQ trim(arguments.value)) ? ' selected="selected"' : '';
	return '<option value="#encodeForHTMLAttribute(arguments.value)#"#isSelected#>#encodeForHTML(arguments.value)#</option>';
}

// Helper function: Render radio button pair (Yes/No)
function renderRadio(fieldName, currentValue = "", tabYes, tabNo, onClickYes = "") {
	var checkedYes = (arguments.currentValue EQ "1") ? ' checked="checked"' : '';
	var checkedNo = (arguments.currentValue EQ "0") ? ' checked="checked"' : '';
	var clickAttr = len(arguments.onClickYes) ? ' onclick="#arguments.onClickYes#"' : '';
	return '<input type="radio" name="#arguments.fieldName#" value="1" tabindex="#arguments.tabYes#"#checkedYes##clickAttr#> Yes
			<input type="radio" name="#arguments.fieldName#" value="0" tabindex="#arguments.tabNo#"#checkedNo#> No';
}
</cfscript>

<!--- Load previously submitted data --->
<cfinclude template="submitted.data.advice_fssc.cfm">

<cfscript>
	// Query dropdown options for dynamic questions
	qry_cmft_dynamic_quest_dd = queryExecute(
		"SELECT * FROM lawmanager.CMFT_DYNAMIC_QUEST_DD WHERE dynamic_key = :dynamicKey ORDER BY dynamic_dd_key",
		{ dynamicKey = { value = 9, cfsqltype = "cf_sql_integer" } },
		{ datasource = "lawmanager" }
	);

	// Query template questions
	qry_template_questions = queryExecute(
		"SELECT * FROM lawmanager.cmft_dynamic_quest WHERE dynamic_quest_key > 0 AND dynamic_quest_key < 12 ORDER BY dynamic_quest_key",
		{},
		{ datasource = "lawmanager" }
	);

	// Default all variables to empty string if not yet defined
	varList = "alo_office,alo_addr1,alo_addr2,alo_phone,alo_fax,case_no,case_name,recipient_name,recipient_addr,recipient_city,recipient_state,recipient_zip,work_order_no,customer_name,po_loc_lkn_box,recvd_date,via,via1,fax_no,tracking_no,answer1,answer2,answer3,answer4,answer5,answer6,answer7,answer8,answer9,answer10,answer11";
	for (v in listToArray(varList)) {
		if (!structKeyExists(variables, v)) {
			variables[v] = "";
		}
	}

	// Determine display value for dispatch method
	switch (via) {
		case "Via USPS Priority Mail w/Tracking":
			via1 = "Priority Mail w. Tracking No.";
			break;
		case "Via Fax":
			via1 = "Fax";
			break;
		case "Via First Class Mail":
			via1 = "First Class Mail";
			break;
		default:
			via1 = "";
	}

	// Data arrays for office-related dropdowns
	officeOptions = ["Denver", "Long Beach", "Salt Lake", "San Diego", "San Francisco", "Seattle"];

	addressOptions = [
		"1745 Stout Street, Suite 500",
		"300 Long Beach Blvd., Rm 240",
		"9350 South 150 East, Suite 800",
		"11255 Rancho Carmel Dr., Rm 1440",
		"1300 Evans Ave., Rm 217 P.O. Box 883790",
		"P.O. Box 3686"
	];

	address2Options = [
		"Denver, CO 80299-5555",
		"Long Beach, CA 90802-2496",
		"Sandy, UT 84070-2716",
		"San Diego, CA 92197-4400",
		"San Francisco, CA 94188-3790",
		"Seattle, WA 98124-3686"
	];

	phoneOptions = [
		"(206) 381-6620", "(206) 381-6624", "(206) 381-6623", "(206) 381-6625", "(206) 381-6626", "(206) 381-6628",
		"(303) 313-5560", "(303) 313-5567", "(303) 313-5577", "(303) 313-5579", "(303) 313-5791",
		"(415) 550-5300", "(415) 550-5381", "(415) 550-5397", "(415) 550-5473", "(415) 550-5493", "(415) 550-5495",
		"(562) 628-1340", "(562) 628-1344", "(562) 628-1345", "(562) 628-1346", "(562) 628-1347",
		"(562) 628-1350", "(562) 628-1351", "(562) 628-1354", "(562) 628-1357",
		"(801) 984-8400", "(801) 984-8403", "(801) 984-8404", "(801) 984-8420", "(801) 984-8423", "(801) 984-8428", "(801) 984-8432",
		"(858) 674-2686", "(858) 674-2738", "(858) 674-2742", "(858) 674-2748"
	];

	faxOptions = [
		"(303) 313-5561", "(650) 357-6705", "(801) 984-8401",
		"(650) 578-3806", "(650) 578-1817", "(650) 577-5679", "(206) 381-6621"
	];

	// Use url.mattername as default case_name for first submission
	if (!len(trim(case_name)) && structKeyExists(url, "mattername")) {
		case_name = url.mattername;
	}
</cfscript>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Advice-FSSC Template</title>
	<link href="/WO/css/form.css" rel="stylesheet" type="text/css">
	<script src="calendar5.js"></script>
	<script src="validation.js"></script>
	<style>
		body {
			margin: 0;
			padding: 5px 0 0 0;
			background-color: #ffffff;
			background-image: url('/WO/img/bck_yellowbox1.gif');
		}
		.dispatch-detail { display: none; }
	</style>
</head>
<body>

<cfoutput>
<cfform id="fssc" action="save.input.data.cfm" method="post" name="advice_subpoena">

	<input type="hidden" name="matterkey" value="#encodeForHTMLAttribute(url.matterkey)#">
	<input type="hidden" name="mattertypekey" value="#encodeForHTMLAttribute(url.mattertypekey)#">

	<div class="styleSelect">
	<table align="center" width="85%" border="0" cellspacing="2" cellpadding="2" bgcolor="##ffffff">

		<!--- Navigation Bar --->
		<tr>
			<td colspan="2" class="TextMaingr" bgcolor="##D9E9EA">
				<a href="case.files.home.cfm">Home</a> &nbsp;&nbsp;&nbsp;
				<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D#encodeForURL(url.matterkey)#" target="_blank">LawManager</a>
			</td>
			<td align="right" class="TextMaingr" colspan="5" bgcolor="##D9E9EA"><b>Advice-FSSC</b></td>
		</tr>

		<tr><td colspan="5"><br></td></tr>

		<!--- Row: USPS Reference / WO Office --->
		<tr>
			<td width="13%" align="right">USPS Reference##</td>
			<td width="28%">
				<cfinput type="text" size="12" name="matternumber" value="#encodeForHTMLAttribute(url.matternumber)#" tabindex="1">
			</td>
			<td width="16%" align="right">WO Office</td>
			<td colspan="2">
				<select name="alo_office" size="1" tabindex="11">
					<cfloop array="#officeOptions#" index="opt">
						#renderOption(opt, alo_office)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Work Order No / WO Address1 --->
		<tr>
			<td align="right" class="TextMaingr">Work Order No.</td>
			<td>
				<cfinput type="text" size="50" name="work_order_no" value="#work_order_no#" maxlength="50" tabindex="2">
			</td>
			<td align="right" class="TextMaingr">WO Address1</td>
			<td colspan="2">
				<select name="alo_addr1" size="2" tabindex="12" multiple="multiple">
					<cfloop array="#addressOptions#" index="opt">
						#renderOption(opt, alo_addr1)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Requester / WO Address2 --->
		<tr>
			<td align="right">Requester</td>
			<td>
				<cfinput type="text" size="50" name="recipient_name" value="#recipient_name#" maxlength="50" tabindex="3">
			</td>
			<td align="right" class="TextMaingr">WO Address2</td>
			<td colspan="2">
				<select name="alo_addr2" size="1" tabindex="13">
					<cfloop array="#address2Options#" index="opt">
						#renderOption(opt, alo_addr2)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Requester Address / Dispatched Via --->
		<tr>
			<td align="right">Requester's Address</td>
			<td>
				<cfinput type="text" size="50" name="recipient_addr" value="#recipient_addr#" maxlength="50" tabindex="4">
			</td>
			<td valign="top" align="right">Dispatched Via</td>
			<td>
				<select name="via" size="1" tabindex="14" id="dispatchVia">
					<option value="">-- Select One --</option>
					<option value="Via Fax"#(via EQ "Via Fax") ? ' selected="selected"' : ''#>Fax</option>
					<option value="Via USPS Priority Mail w/Tracking"#(via EQ "Via USPS Priority Mail w/Tracking") ? ' selected="selected"' : ''#>Priority Mail w. Tracking No.</option>
					<option value="Via First Class Mail"#(via EQ "Via First Class Mail") ? ' selected="selected"' : ''#>First Class Mail</option>
				</select>
			</td>
			<td valign="top" width="25%">
				<div id="faxDetail" class="dispatch-detail">
					Fax## <cfinput type="text" size="25" name="fax_no" value="#fax_no#" maxlength="25">
				</div>
				<div id="trackingDetail" class="dispatch-detail">
					Track## <cfinput type="text" size="34" name="tracking_no" value="#tracking_no#" maxlength="35">
				</div>
			</td>
		</tr>

		<!--- Row: Requester City/State/Zip / WO Phone --->
		<tr>
			<td align="right" class="TextMaingr">Requester's City</td>
			<td>
				<cfinput type="text" size="20" name="recipient_city" value="#recipient_city#" maxlength="20" tabindex="5">
				&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="recipient_state" value="#recipient_state#" maxlength="2" tabindex="6">
				&nbsp;Zip&nbsp;
				<cfinput type="text" size="5" name="recipient_zip" value="#recipient_zip#" maxlength="11" tabindex="7">
			</td>
			<td align="right" class="TextMaingr">WO Phone</td>
			<td colspan="2">
				<select name="alo_phone" size="1" tabindex="15">
					<option value="">Select One...</option>
					<cfloop array="#phoneOptions#" index="opt">
						#renderOption(opt, alo_phone)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Case No / WO Fax --->
		<tr>
			<td align="right" class="TextMaingr">Case No.</td>
			<td>
				<cfinput type="text" size="50" name="case_no" value="#case_no#" maxlength="50" tabindex="8">
			</td>
			<td align="right" class="TextMaingr">WO Fax</td>
			<td colspan="2">
				<select name="alo_fax" size="1" tabindex="17">
					<option value="">Select One...</option>
					<cfloop array="#faxOptions#" index="opt">
						#renderOption(opt, alo_fax)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff/Defendant / Date Received --->
		<tr>
			<td width="12%" align="right" class="TextMaingr">Plaintiff/Petitioner and Defendant/Respondent</td>
			<td>
				<cfinput type="text" size="50" name="case_name" value="#case_name#" maxlength="50" tabindex="9">
			</td>
			<td align="right">Date Subpoena<br>Received</td>
			<td colspan="2">
				<input name="recvd_date" tabindex="17" type="text" value="#dateFormat(recvd_date, 'mm/dd/yyyy')#" size="11" maxlength="10"
					onchange="CheckDate(this)"
					onkeydown="FormatDate(this, window.event.keyCode, 'down')"
					onkeyup="FormatDate(this, window.event.keyCode, 'up')">
				<img src="img/cal.gif" alt="Display Calendar" onclick="rec_date.popup();"> (mm/dd/yyyy)
			</td>
		</tr>

		<!--- Row: PO Boxholder Name / LKN/PO Box Location --->
		<tr>
			<td align="right" class="TextMaingr">PO Boxholder Name</td>
			<td>
				<cfinput type="text" size="50" name="customer_name" value="#customer_name#" maxlength="50" tabindex="10">
			</td>
			<td align="right" class="TextMaingr">LKN/PO Box Location</td>
			<td colspan="2">
				<cfinput type="text" size="50" name="po_loc_lkn_box" value="#po_loc_lkn_box#" tabindex="18">
			</td>
		</tr>

		<tr><td colspan="5"><hr></td></tr>
	</table>

	<!--- Dynamic Questions Section --->
	<table align="center" width="85%" border="0" cellspacing="4" cellpadding="4" bgcolor="##ffffff">
		<tr>
			<td colspan="3"><b>All questions listed below must be answered.</b></td>
		</tr>

		<cfloop query="qry_template_questions">
			<tr>
				<td width="14" valign="middle">#qry_template_questions.dynamic_quest_key#-</td>
				<td width="70%">#qry_template_questions.question#</td>
				<td>
					<cfswitch expression="#qry_template_questions.dynamic_quest_key#">

						<cfcase value="1">
							#renderRadio("answer1", answer1, 19, 20)#
						</cfcase>

						<cfcase value="2">
							<select name="answer2" size="1" tabindex="21">
								<option value="6"#(answer2 EQ "6") ? ' selected="selected"' : ''#>Both testimony and records</option>
								<option value="7"#(answer2 EQ "7") ? ' selected="selected"' : ''#>Testimony only</option>
								<option value="8"#(answer2 EQ "8") ? ' selected="selected"' : ''#>Documents only</option>
							</select>
						</cfcase>

						<cfcase value="3">
							#renderRadio("answer3", answer3, 22, 23)#
						</cfcase>

						<cfcase value="4">
							#renderRadio("answer4", answer4, 24, 25, "CheckValue()")#
						</cfcase>

						<cfcase value="5">
							#renderRadio("answer5", answer5, 26, 27)#
						</cfcase>

						<cfcase value="6">
							#renderRadio("answer6", answer6, 28, 29)#
						</cfcase>

						<cfcase value="7">
							#renderRadio("answer7", answer7, 30, 31)#
						</cfcase>

						<cfcase value="8">
							#renderRadio("answer8", answer8, 32, 33)#
						</cfcase>

						<cfcase value="9">
							<select name="answer9" size="1" tabindex="34">
								<option value="1"#(answer9 EQ "1") ? ' selected="selected"' : ''#>Deposition Testimony</option>
								<option value="2"#(answer9 EQ "2") ? ' selected="selected"' : ''#>Records Production</option>
								<option value="3"#(answer9 EQ "3") ? ' selected="selected"' : ''#>Deposition Testimony and Production of Docs</option>
							</select>
						</cfcase>

						<cfcase value="10">
							<select name="answer10" size="1" tabindex="35">
								<option value="9"#(answer10 EQ "9") ? ' selected="selected"' : ''#>Provide records</option>
								<option value="4"#(answer10 EQ "4") ? ' selected="selected"' : ''#>Provide testimony</option>
								<option value="5"#(answer10 EQ "5") ? ' selected="selected"' : ''#>Provide testimony and records</option>
							</select>
						</cfcase>

						<cfcase value="11">
							#renderRadio("answer11", answer11, 36, 37)#
						</cfcase>

					</cfswitch>
				</td>
			</tr>
		</cfloop>
	</table>

	<!--- Submit Button --->
	<table align="center" width="85%" border="0" cellspacing="4" cellpadding="4" bgcolor="##ffffff">
		<tr>
			<td colspan="5" align="center">
				<br><br>
				<input type="image" src="/WO/img/submit3.png" width="66" height="24" border="0" value="submit" onclick="return validateAndSubmit();">
				<span id="error" style="display:none;"></span>
			</td>
		</tr>
	</table>

	</div>
</cfform>
</cfoutput>

<script>
	// Initialize calendar for date field
	var rec_date = new calendar5(document.advice_subpoena.recvd_date);

	// Show/hide dispatch detail fields based on initial value
	(function initDispatch() {
		var viaSelect = document.getElementById("dispatchVia");
		if (viaSelect) {
			toggleDispatchDetails(viaSelect.value);
		}
	})();

	// Handle dispatch method change
	document.getElementById("dispatchVia").addEventListener("change", function () {
		toggleDispatchDetails(this.value);
	});

	function toggleDispatchDetails(value) {
		var faxDiv = document.getElementById("faxDetail");
		var trackDiv = document.getElementById("trackingDetail");
		faxDiv.style.display = (value === "Via Fax") ? "block" : "none";
		trackDiv.style.display = (value === "Via USPS Priority Mail w/Tracking") ? "block" : "none";
	}

	function CheckValue() {
		alert('Answering "Yes" to this question requires information for "PO Boxholder Name" and "LKN/PO Box Location"');
	}

	// Validate all radio button groups are answered
	function validateRadioGroups() {
		var form = document.getElementById("fssc");
		var elements = form.elements;
		var missing = [];
		var checked = {};

		for (var i = 0; i < elements.length; i++) {
			if (elements[i].type === "radio") {
				var name = elements[i].name;
				if (!(name in checked)) {
					checked[name] = false;
				}
				if (elements[i].checked) {
					checked[name] = true;
				}
			}
		}

		for (var name in checked) {
			if (!checked[name]) {
				missing.push(name + " is missing.");
			}
		}

		if (missing.length > 0) {
			alert(missing.join("\n"));
			return false;
		}
		return true;
	}

	// Combined validation on submit
	function validateAndSubmit() {
		if (!validateRadioGroups()) {
			return false;
		}
		if (typeof validateForm === "function" && !validateForm()) {
			return false;
		}
		return true;
	}
</script>

</body>
</html>
