<cfscript>
// Helper function: Render a select option with proper selected state
function renderOption(value, currentValue = "") {
	var isSelected = (len(trim(arguments.currentValue)) && trim(arguments.currentValue) EQ trim(arguments.value)) ? ' selected="selected"' : '';
	return '<option value="#encodeForHTMLAttribute(arguments.value)#"#isSelected#>#encodeForHTML(arguments.value)#</option>';
}
</cfscript>

<cfinclude template="new.submitted.data.dct.cfm">
<cfinclude template="new.ausa.data.cfm">
<cfinclude template="new.plaintiff.data.cfm">
<cfinclude template="new.plaintiff.rep.data.cfm">

<cfscript>
	// Default all variables to empty string if not yet defined
	varList = "case_no,plaintiff_eid,plaintiff_ssn,plaintiff_fname,plaintiff_lname,plaintiff_addr,plaintiff_city,plaintiff_state,plaintiff_zip,plaintiff_facility,plaintiff_district,plaintiff_email,defendant_name,plaintiff_rep_fname,plaintiff_rep_lname,plaintiff_rep_company,plaintiff_rep_addr,plaintiff_rep_city,plaintiff_rep_state,plaintiff_rep_zip,plaintiff_rep_phone,plaintiff_rep_fax,plaintiff_rep_email,ausa_prefix,ausa_fname,ausa_lname,ausa_title,ausa_bar_no,ausa_district,ausa_addr1,ausa_addr2,ausa_citystzip,ausa_phone,ausa_fax,ausa_email,ausa_chief_fname,ausa_chief_lname,ausa_us_attorney,usdj_fname,usdj_lname,usdj_title,usdj_addr,usdj_city,usdj_state,usdj_zip,usdj_office,usdj_phone,usdj_fax,attorney_name,attorney_title,paralgl_name,alo_office,alo_addr1,alo_addr2,alo_phone,alo_fax,lr_mgr,hr_mgr,dist_mgr,hr_mgr_dist,ohna_dist";
	for (v in listToArray(varList)) {
		if (!structKeyExists(variables, v)) {
			variables[v] = "";
		}
	}
</cfscript>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Legal Libs Templates</title>
	<link href="/WO/css/form.css" rel="stylesheet" type="text/css">
	<style>
		body {
			margin: 0;
			padding: 5px 0 0 0;
			background-color: #ffffff;
			background-image: url('/WO/img/bck_yellowbox1.gif');
		}
	</style>
</head>
<body>

<cfoutput>
<cfform action="save.input.data.cfm" method="post" name="entityform">

	<input type="hidden" name="matterkey" value="#encodeForHTMLAttribute(url.matterkey)#">
	<input type="hidden" name="matternumber" value="#encodeForHTMLAttribute(url.matternumber)#">
	<input type="hidden" name="mattertypekey" value="#encodeForHTMLAttribute(url.mattertypekey)#">

	<div class="styleSelect">
	<table align="center" width="85%" border="0" cellspacing="1" cellpadding="1" bgcolor="##ffffff">

		<!--- Navigation Bar --->
		<tr>
			<td colspan="3" class="TextMaingr" bgcolor="##D9E9EA">
				<a href="new.case.files.home.cfm">Home</a> &nbsp;&nbsp;&nbsp;
				<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D#encodeForURL(url.matterkey)#" target="_blank">LawManager</a> &nbsp;&nbsp;&nbsp;
				<a href="admin.pages.cfm">Legal Libs Admin</a>
			</td>
			<td align="right" class="TextMaingr" bgcolor="##D9E9EA">WLO - District Court</td>
		</tr>

		<!--- Row: Plaintiff EID / AUSA Prefix --->
		<tr>
			<td width="12%" align="right" class="TextMaingr">Plaintiff EID</td>
			<td><cfinput type="text" size="9" name="plaintiff_eid" value="#plaintiff_eid#" maxlength="8" tabindex="1"></td>
			<td width="15%" align="right" class="TextMaingr">Mr. / Ms.</td>
			<td>
				<select name="ausa_prefix" size="1" tabindex="32">
					#renderOption("Mr.", ausa_prefix)#
					#renderOption("Ms.", ausa_prefix)#
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff SSN / AUSA First Name --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff SSN</td>
			<td><cfinput type="text" size="10" name="plaintiff_ssn" value="#plaintiff_ssn#" maxlength="9" tabindex="2"></td>
			<td align="right" class="TextMaingr">AUSA First Name</td>
			<td><cfinput type="text" size="40" name="ausa_fname" value="#ausa_fname#" maxlength="40" tabindex="33"></td>
		</tr>

		<!--- Row: Case Number / AUSA Last Name --->
		<tr>
			<td align="right" class="TextMaingr">Case Number</td>
			<td><cfinput type="text" size="25" name="case_no" value="#case_no#" maxlength="25" tabindex="3"></td>
			<td align="right" class="TextMaingr">AUSA Last Name</td>
			<td><cfinput type="text" size="40" name="ausa_lname" value="#ausa_lname#" maxlength="40" tabindex="34"></td>
		</tr>

		<!--- Row: Plaintiff First Name / AUSA Bar No --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff First Name</td>
			<td><cfinput type="text" size="40" name="plaintiff_fname" value="#plaintiff_fname#" maxlength="40" tabindex="4"></td>
			<td align="right" class="TextMaingr">AUSA Bar No.</td>
			<td><cfinput type="text" size="40" name="ausa_bar_no" value="#ausa_bar_no#" maxlength="80" tabindex="35"></td>
		</tr>

		<!--- Row: Plaintiff Last Name / AUSA Title --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Last Name</td>
			<td><cfinput type="text" size="40" name="plaintiff_lname" value="#plaintiff_lname#" maxlength="40" tabindex="5"></td>
			<td align="right" class="TextMaingr">AUSA Title</td>
			<td><cfinput type="text" size="40" name="ausa_title" value="#ausa_title#" maxlength="80" tabindex="36"></td>
		</tr>

		<!--- Row: Plaintiff Address / AUSA District --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Address</td>
			<td><cfinput type="text" size="40" name="plaintiff_addr" value="#plaintiff_addr#" maxlength="80" tabindex="6"></td>
			<td width="10%" align="right" class="TextMaingr">AUSA District</td>
			<td width="30%">
				<select name="ausa_district" size="1" tabindex="37">
					<option value=""> </option>
					<cfset ausaDistricts = "Central District of California|District of Hawaii|Eastern District of California|Northern District|Southern District of California">
					<cfloop list="#ausaDistricts#" delimiters="|" index="district">
						#renderOption(district, ausa_district)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff City/State/Zip / AUSA Address1 --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="plaintiff_city" value="#plaintiff_city#" maxlength="20" tabindex="7">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="plaintiff_state" value="#plaintiff_state#" maxlength="2" tabindex="8">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="plaintiff_zip" value="#plaintiff_zip#" maxlength="10" tabindex="9">
			</td>
			<td align="right" class="TextMaingr">AUSA Address1</td>
			<td>
				<cfset ausaAddr1Options = "Federal Building 9th Floor|Federal Building Suite 7516|Federal Office Building|Southern District of California|PJKK Federal Building">
				<select name="ausa_addr1" size="1" tabindex="38">
					<option value=""> </option>
					<cfloop list="#ausaAddr1Options#" delimiters="|" index="addr">
						#renderOption(addr, ausa_addr1)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff Facility / AUSA Address2 --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Facility</td>
			<td><cfinput type="text" size="60" name="plaintiff_facility" value="#plaintiff_facility#" maxlength="70" tabindex="10"></td>
			<td align="right" class="TextMaingr">AUSA Address2</td>
			<td>
				<cfset ausaAddr2Options = "450 Golden Gate Avenue, Box 36055|501 I Street, Ste 10-100|300 N. Los Angeles Street|880 Front Street, Rm 6293|300 Ala Moana Blvd. Rm 6-100|2500 Tulare Street, Suite 4401">
				<select name="ausa_addr2" size="1" tabindex="39">
					<cfloop list="#ausaAddr2Options#" delimiters="|" index="addr">
						#renderOption(addr, ausa_addr2)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff District / AUSA CityStZip --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff District</td>
			<td><cfinput type="text" size="60" name="plaintiff_district" value="#plaintiff_district#" maxlength="60" tabindex="11"></td>
			<td align="right" class="TextMaingr">AUSA CityStZip</td>
			<td>
				<cfset ausaCityOptions = "San Francisco, CA 94102-3495|Sacramento, CA 95814|Los Angeles, CA 90012|San Diego, CA 92101|Honolulu, HI 96850|Fresno, CA 93721">
				<select name="ausa_citystzip" size="1" tabindex="40">
					<cfloop list="#ausaCityOptions#" delimiters="|" index="city">
						#renderOption(city, ausa_citystzip)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff Email / AUSA Phone & Fax --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Email</td>
			<td><cfinput type="text" size="40" name="plaintiff_email" value="#plaintiff_email#" maxlength="40" tabindex="12"></td>
			<td align="right" class="TextMaingr">AUSA Phone</td>
			<td>
				<cfset ausaPhones = "415-436-7200|916-554-2700|213-894-2404|213-894-2458|619-557-5610|808-541-2850|559-497-4019">
				<select name="ausa_phone" size="1" tabindex="41">
					<cfloop list="#ausaPhones#" delimiters="|" index="phone">
						#renderOption(phone, ausa_phone)#
					</cfloop>
				</select>
				&nbsp;AUSA Fax&nbsp;
				<cfset ausaFaxes = "415-436-7234|916-554-2900|213-894-7819|619-546-0720|808-541-2958|559-497-4099">
				<select name="ausa_fax" size="1" tabindex="42">
					<cfloop list="#ausaFaxes#" delimiters="|" index="fax">
						#renderOption(fax, ausa_fax)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Defendant Name / AUSA Email --->
		<tr>
			<td align="right" class="TextMaingr">Defendant Name</td>
			<td><cfinput type="text" size="60" name="defendant_name" value="#defendant_name#" maxlength="60" tabindex="13"></td>
			<td align="right" class="TextMaingr">AUSA Email</td>
			<td><cfinput type="text" size="40" name="ausa_email" value="#ausa_email#" maxlength="40" tabindex="43"></td>
		</tr>

		<!--- Divider / AUSA Chief First Name --->
		<tr>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
			<td align="right" class="TextMaingr">AUSA Chief First Name</td>
			<td>
				<cfset ausaChiefFnames = "Alex|Derrick|Lee|Robyn-Marie Lyn|Sylvia|Thomas C.">
				<select name="ausa_chief_fname" size="1" tabindex="44">
					<cfloop list="#ausaChiefFnames#" delimiters="|" index="fname">
						#renderOption(fname, ausa_chief_fname)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff Rep First Name / AUSA Chief Last Name --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Rep. First Name</td>
			<td><cfinput type="text" size="40" name="plaintiff_rep_fname" value="#plaintiff_rep_fname#" maxlength="40" tabindex="14"></td>
			<td align="right" class="TextMaingr">AUSA Chief Last Name</td>
			<td>
				<cfset ausaChiefLnames = "Helper|Monteleone|Quast|Stahl|Tse|Watson|Weidman">
				<select name="ausa_chief_lname" size="1" tabindex="45">
					<cfloop list="#ausaChiefLnames#" delimiters="|" index="lname">
						#renderOption(lname, ausa_chief_lname)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Plaintiff Rep Last Name / US Attorney --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Rep. Last Name</td>
			<td><cfinput type="text" size="40" name="plaintiff_rep_lname" value="#plaintiff_rep_lname#" maxlength="40" tabindex="15"></td>
			<td align="right" class="TextMaingr">US Attorney</td>
			<td><cfinput type="text" size="40" name="ausa_us_attorney" value="#ausa_us_attorney#" maxlength="60" tabindex="46"></td>
		</tr>

		<!--- Row: Plaintiff Rep Company / Divider --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Rep. Company</td>
			<td><cfinput type="text" size="25" name="plaintiff_rep_company" value="#plaintiff_rep_company#" maxlength="25" tabindex="16"></td>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
		</tr>

		<!--- Row: Plaintiff Rep Address / USDJ First Name --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Rep. Address</td>
			<td><cfinput type="text" size="40" name="plaintiff_rep_addr" value="#plaintiff_rep_addr#" maxlength="80" tabindex="17"></td>
			<td align="right" class="TextMaingr">USDJ First Name</td>
			<td><cfinput type="text" size="40" name="usdj_fname" value="#usdj_fname#" maxlength="40" tabindex="47"></td>
		</tr>

		<!--- Row: Plaintiff Rep City/State/Zip / USDJ Last Name --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Rep. City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="plaintiff_rep_city" value="#plaintiff_rep_city#" maxlength="20" tabindex="18">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="plaintiff_rep_state" value="#plaintiff_rep_state#" maxlength="2" tabindex="19">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="plaintiff_rep_zip" value="#plaintiff_rep_zip#" maxlength="10" tabindex="20">
			</td>
			<td align="right" class="TextMaingr">USDJ Last Name</td>
			<td><cfinput type="text" size="40" name="usdj_lname" value="#usdj_lname#" maxlength="40" tabindex="48"></td>
		</tr>

		<!--- Row: Plaintiff Rep Phone & Fax / USDJ Title --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Rep. Phone</td>
			<td>
				<cfinput type="text" size="15" name="plaintiff_rep_phone" value="#plaintiff_rep_phone#" maxlength="15" tabindex="21">
				&nbsp;Fax&nbsp;
				<cfinput type="text" size="15" name="plaintiff_rep_fax" value="#plaintiff_rep_fax#" maxlength="15" tabindex="22">
			</td>
			<td align="right" class="TextMaingr">USDJ Title</td>
			<td><cfinput type="text" size="40" name="usdj_title" value="#usdj_title#" maxlength="80" tabindex="49"></td>
		</tr>

		<!--- Row: Plaintiff Rep Email / USDJ Address --->
		<tr>
			<td align="right" class="TextMaingr">Plaintiff Rep. Email</td>
			<td><cfinput type="text" size="40" name="plaintiff_rep_email" value="#plaintiff_rep_email#" maxlength="40" tabindex="23"></td>
			<td align="right" class="TextMaingr">USDJ Address</td>
			<td><cfinput type="text" size="40" name="usdj_addr" value="#usdj_addr#" maxlength="80" tabindex="50"></td>
		</tr>

		<!--- Row: Divider / USDJ City/State/Zip --->
		<tr>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
			<td align="right" class="TextMaingr">USDJ City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="usdj_city" value="#usdj_city#" maxlength="20" tabindex="51">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="usdj_state" value="#usdj_state#" maxlength="2" tabindex="52">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="usdj_zip" value="#usdj_zip#" maxlength="10" tabindex="53">
			</td>
		</tr>

		<!--- Row: WO Office / USDJ Office --->
		<tr>
			<td width="10%" align="right" class="TextMaingr">WO Office</td>
			<td width="30%">
				<cfset woOffices = "Denver|Long Beach|Salt Lake|San Diego|San Francisco|Seattle">
				<select name="alo_office" size="1" tabindex="24">
					<cfloop list="#woOffices#" delimiters="|" index="office">
						#renderOption(office, alo_office)#
					</cfloop>
				</select>
			</td>
			<td align="right" class="TextMaingr">USDJ Office</td>
			<td><cfinput type="text" size="40" name="usdj_office" value="#usdj_office#" maxlength="40" tabindex="54"></td>
		</tr>

		<!--- Row: WO Address1 / USDJ Phone & Fax --->
		<tr>
			<td align="right" class="TextMaingr">WO Address1</td>
			<td>
				<cfset woAddr1Options = "1745 Stout Street, Suite 500|300 Long Beach Blvd., Rm 240|9350 South 150 East, Suite 800|11255 Rancho Carmel Dr., Rm 1440|1300 Evans Ave., Rm 217|P.O. Box 3686">
				<select name="alo_addr1" size="1" tabindex="25">
					<cfloop list="#woAddr1Options#" delimiters="|" index="addr">
						#renderOption(addr, alo_addr1)#
					</cfloop>
				</select>
			</td>
			<td align="right" class="TextMaingr">USDJ Phone</td>
			<td>
				<cfinput type="text" size="15" name="usdj_phone" value="#usdj_phone#" maxlength="15" tabindex="55">
				&nbsp;Fax&nbsp;
				<cfinput type="text" size="15" name="usdj_fax" value="#usdj_fax#" maxlength="15" tabindex="56">
			</td>
		</tr>

		<!--- Row: WO Address2 / Divider --->
		<tr>
			<td align="right" class="TextMaingr">WO Address2</td>
			<td>
				<cfset woAddr2Options = "Denver, CO 80299-5555|Long Beach, CA 90802-2496|Sandy, UT 84070-2716|San Diego, CA 92197-4400|San Francisco, CA 94188-3790|Seattle, WA 98124-3686">
				<select name="alo_addr2" size="1" tabindex="26">
					<cfloop list="#woAddr2Options#" delimiters="|" index="addr">
						#renderOption(addr, alo_addr2)#
					</cfloop>
				</select>
			</td>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
		</tr>

		<!--- Row: WO Phone / LR Manager --->
		<tr>
			<td align="right" class="TextMaingr">WO Phone</td>
			<td>
				<cfset woPhones = "(206) 381-6620|(206) 381-6623|(206) 381-6624|(206) 381-6625|(206) 381-6626|(206) 381-6628|(303) 313-5560|(303) 313-5567|(303) 313-5577|(303) 313-5579|(303) 313-5791|(415) 550-5300|(415) 550-5381|(415) 550-5397|(415) 550-5473|(415) 550-5493|(415) 550-5495|(562) 628-1340|(562) 628-1344|(562) 628-1345|(562) 628-1346|(562) 628-1347|(562) 628-1350|(562) 628-1351|(562) 628-1354|(562) 628-1357|(801) 984-8400|(801) 984-8403|(801) 984-8404|(801) 984-8420|(801) 984-8423|(801) 984-8428|(801) 984-8432|(858) 674-2686|(858) 674-2738|(858) 674-2742|(858) 674-2748">
				<select name="alo_phone" size="1" tabindex="27">
					<option value="">Select One...</option>
					<cfloop list="#woPhones#" delimiters="|" index="phone">
						#renderOption(phone, alo_phone)#
					</cfloop>
				</select>
			</td>
			<td align="right" class="TextMaingr">LR Manager</td>
			<td>
				<cfquery name="qry_lr_mgr" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'LRMGR' AND b.group_prefix = 'WO'
					ORDER BY b.sort_fld
				</cfquery>
				<select name="lr_mgr" size="1" tabindex="56">
					<option value="">Select One...</option>
					<cfloop query="qry_lr_mgr">
						#renderOption(qry_lr_mgr.name, lr_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: WO Fax / HR Manager --->
		<tr>
			<td align="right" class="TextMaingr">WO Fax</td>
			<td>
				<cfset woFaxes = "(206) 381-6621|(303) 313-5561|(650) 357-6705|(650) 357-6336|(650) 578-3806|(650) 578-1817|(650) 577-5679|(801) 984-8402">
				<select name="alo_fax" size="1" tabindex="28">
					<option value="">Select One...</option>
					<cfloop list="#woFaxes#" delimiters="|" index="fax">
						#renderOption(fax, alo_fax)#
					</cfloop>
				</select>
			</td>
			<td align="right" class="TextMaingr">HR Manager</td>
			<td>
				<cfquery name="qry_hr_mgr" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'HRMGR' AND b.group_prefix = 'WO'
					ORDER BY b.sort_fld
				</cfquery>
				<select name="hr_mgr" size="1" tabindex="57">
					<option value="">Select One...</option>
					<cfloop query="qry_hr_mgr">
						#renderOption(qry_hr_mgr.name, hr_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Attorney / District Manager --->
		<tr>
			<td width="10%" align="right" class="TextMaingr">Attorney</td>
			<td width="30%">
				<cfquery name="qry_attorney" datasource="lawmanager">
					SELECT b.entity_key, b.attorney_name AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'ATTNY' AND b.group_prefix = 'WO'
					ORDER BY b.sort_fld
				</cfquery>
				<select name="attorney_name" size="1" tabindex="29">
					<option value="">Select One...</option>
					<cfloop query="qry_attorney">
						#renderOption(qry_attorney.name, attorney_name)#
					</cfloop>
				</select>
			</td>
			<td align="right" class="TextMaingr">District Manager</td>
			<td>
				<cfquery name="qry_dist_mgr" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'DMGR' AND b.group_prefix = 'WO'
					ORDER BY b.sort_fld
				</cfquery>
				<select name="dist_mgr" size="1" tabindex="58">
					<option value="">Select One...</option>
					<cfloop query="qry_dist_mgr">
						#renderOption(qry_dist_mgr.name, dist_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Attorney Title / H&R Mgr District --->
		<tr>
			<td width="10%" align="right" class="TextMaingr">Attorney Title</td>
			<td width="30%">
				<select name="attorney_title" size="1" tabindex="30">
					<option value="">Select One...</option>
					#renderOption("Attorney", attorney_title)#
					#renderOption("Senior Litigation Counsel", attorney_title)#
					#renderOption("Managing Counsel", attorney_title)#
					#renderOption("Deputy Managing Counsel", attorney_title)#
				</select>
			</td>
			<td align="right" class="TextMaingr">H&amp;R Mgr - District</td>
			<td>
				<cfquery name="qry_hr_mgr_dist" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'HRDST' AND b.group_prefix = 'WO'
					ORDER BY b.sort_fld
				</cfquery>
				<select name="hr_mgr_dist" size="1" tabindex="59">
					<option value="">Select One...</option>
					<cfloop query="qry_hr_mgr_dist">
						#renderOption(qry_hr_mgr_dist.name, hr_mgr_dist)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Paralegal / OHNA District --->
		<tr>
			<td width="10%" align="right" class="TextMaingr">Paralegal</td>
			<td width="30%">
				<cfquery name="qry_paralgl" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'PLGL' AND b.group_prefix = 'WO'
					ORDER BY b.sort_fld
				</cfquery>
				<select name="paralgl_name" size="1" tabindex="31">
					<option value="">Select One...</option>
					<cfloop query="qry_paralgl">
						#renderOption(qry_paralgl.name, paralgl_name)#
					</cfloop>
				</select>
			</td>
			<td align="right" class="TextMaingr">OHNA - District</td>
			<td>
				<cfquery name="qry_ohna_dist" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'OHNA' AND b.group_prefix = 'WO'
					ORDER BY b.sort_fld
				</cfquery>
				<select name="ohna_dist" size="1" tabindex="60">
					<option value="">Select One...</option>
					<cfloop query="qry_ohna_dist">
						#renderOption(qry_ohna_dist.name, ohna_dist)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Submit Button --->
		<tr>
			<td colspan="5" align="center">
				<br><br>
				<input type="image" src="/WO/img/save_continue1.gif" alt="Save and Continue" border="0" value="submit" tabindex="61">
			</td>
		</tr>

	</table>
	</div>

</cfform>
</cfoutput>

</body>
</html>
