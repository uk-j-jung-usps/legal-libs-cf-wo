<cfscript>
// Helper function: Render a select option with proper selected state
function renderOption(value, currentValue = "") {
	var isSelected = (structKeyExists(arguments, "currentValue") && len(trim(arguments.currentValue)) && trim(arguments.currentValue) EQ trim(arguments.value)) ? ' selected="selected"' : '';
	return '<option value="#encodeForHTMLAttribute(arguments.value)#"#isSelected#>#encodeForHTML(arguments.value)#</option>';
}
</cfscript>

<cfinclude template="new.submitted.data.eeoc.cfm">
<cfinclude template="new.complainant.data.cfm">
<cfinclude template="new.complainant.rep.data.cfm">
<cfinclude template="new.admin.judge.data.cfm">

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

<cfscript>
	// Default all variables to empty string if not yet defined
	varList = "comp_prefix,comp_pronoun1,comp_pronoun2,comp_eid,comp_ssn,comp_fname,comp_lname,comp_addr,comp_city,comp_state,comp_zip,comp_phone,comp_facility,comp_district,comp_rep_prefix,comp_rep_fname,comp_rep_lname,comp_rep_comp,comp_rep_addr,comp_rep_city,comp_rep_state,comp_rep_zip,comp_rep_phone,comp_rep_fax,aj_fname,aj_lname,aj_title,aj_addr,aj_city,aj_state,aj_zip,aj_phone,aj_fax,agency_no,eeoc_no,eeoc_office,attorney_name,attorney_title,paralgl_name,lr_mgr,hr_mgr,dist_mgr,hr_mgr_dist,ohna_dist,alo_office,alo_addr1,alo_addr2,alo_phone,alo_fax,admin_assist";
	for (v in listToArray(varList)) {
		if (!structKeyExists(variables, v)) {
			variables[v] = "";
		}
	}
</cfscript>

<cfoutput>
<cfform action="new.save.input.data.cfm" method="post" name="entityform">

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
				<a href="new.admin.pages.cfm">Legal Libs Admin</a>
			</td>
			<td align="right" class="TextMaingr" bgcolor="##D9E9EA">WLO - EEOC</td>
		</tr>

		<tr><td><br><br></td></tr>

		<!--- Row: Prefix / AJ First Name --->
		<tr>
			<td width="15%" align="right" class="TextMaingr">Mr. / Ms.</td>
			<td>
				<select name="comp_prefix" size="1" tabindex="1">
					#renderOption("Mr.", comp_prefix)#
					#renderOption("Ms.", comp_prefix)#
				</select>
			</td>
			<td width="15%" align="right" class="TextMaingr">AJ First Name</td>
			<td><cfinput type="text" size="40" name="aj_fname" value="#aj_fname#" maxlength="40" tabindex="28"></td>
		</tr>

		<!--- Row: Pronoun1 / AJ Last Name --->
		<tr>
			<td align="right" class="TextMaingr">he / she / they</td>
			<td>
				<select name="comp_pronoun1" size="1" tabindex="2">
					#renderOption("he", comp_pronoun1)#
					#renderOption("she", comp_pronoun1)#
					#renderOption("they", comp_pronoun1)#
				</select>
			</td>
			<td align="right" class="TextMaingr">AJ Last Name</td>
			<td><cfinput type="text" size="40" name="aj_lname" value="#aj_lname#" maxlength="40" tabindex="29"></td>
		</tr>

		<!--- Row: Pronoun2 / AJ Title --->
		<tr>
			<td align="right" class="TextMaingr">his / her / their</td>
			<td>
				<select name="comp_pronoun2" size="1" tabindex="3">
					#renderOption("his", comp_pronoun2)#
					#renderOption("her", comp_pronoun2)#
					#renderOption("their", comp_pronoun2)#
				</select>
			</td>
			<td width="10%" align="right" class="TextMaingr">AJ Title</td>
			<td>
				<select name="aj_title" size="1" tabindex="35">
					#renderOption("Administrative Judge", aj_title)#
					#renderOption("Supervisory Administrative Judge", aj_title)#
					#renderOption("Chief Administrative Judge", aj_title)#
				</select>
			</td>
		</tr>

		<!--- Row: Comp EID / AJ Address --->
		<tr>
			<td align="right" class="TextMaingr">Complainant EID</td>
			<td><cfinput type="text" size="9" name="comp_eid" value="#comp_eid#" maxlength="8" tabindex="4"></td>
			<td align="right" class="TextMaingr">AJ Address</td>
			<td width="20%"><cfinput type="text" size="40" name="aj_addr" value="#aj_addr#" maxlength="80" tabindex="31"></td>
		</tr>

		<!--- Row: Comp SSN / AJ City/State/Zip --->
		<tr>
			<td align="right" class="TextMaingr">Complainant SSN</td>
			<td><cfinput type="text" size="10" name="comp_ssn" value="#comp_ssn#" maxlength="9" tabindex="5"></td>
			<td align="right" class="TextMaingr">AJ City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="aj_city" value="#aj_city#" maxlength="20" tabindex="32">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="aj_state" value="#aj_state#" maxlength="2" tabindex="33">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="aj_zip" value="#aj_zip#" maxlength="10" tabindex="34">
			</td>
		</tr>

		<!--- Row: Comp First Name / EEOC Office --->
		<tr>
			<td align="right" class="TextMaingr">Complainant First Name</td>
			<td><cfinput type="text" size="40" name="comp_fname" value="#comp_fname#" maxlength="40" tabindex="6"></td>
			<td width="10%" align="right" class="TextMaingr">EEOC Office</td>
			<td>
				<select name="eeoc_office" size="1" tabindex="35">
					<cfset eeocOffices = "Albuquerque District,Atlanta District Office,Baltimore Field Office,Birmingham District Office,Charlotte District Office,Chicago District,Cleveland Field Office,Denver Field Office,Houston District,Indianapolis District,Los Angeles District,Miami District,Memphis District,Milwaukee Area Office,Minneapolis Area Office,New Orleans Field Office,Philadelphia District Office,Phoenix District,San Francisco District,Seattle Field Office,St. Louis District,Washington Field Office">
					<cfloop list="#eeocOffices#" index="office">
						#renderOption(office, eeoc_office)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Last Name / AJ Phone --->
		<tr>
			<td align="right" class="TextMaingr">Complainant Last Name</td>
			<td><cfinput type="text" size="40" name="comp_lname" value="#comp_lname#" maxlength="40" tabindex="7"></td>
			<td align="right" class="TextMaingr">AJ Phone</td>
			<td><cfinput type="text" size="15" name="aj_phone" value="#aj_phone#" maxlength="15" tabindex="36"></td>
		</tr>

		<!--- Row: Comp Address / AJ Fax --->
		<tr>
			<td align="right" class="TextMaingr">Complainant Address</td>
			<td><cfinput type="text" size="40" name="comp_addr" value="#comp_addr#" maxlength="80" tabindex="8"></td>
			<td align="right" class="TextMaingr">AJ Fax</td>
			<td><cfinput type="text" size="15" name="aj_fax" value="#aj_fax#" maxlength="15" tabindex="37"></td>
		</tr>

		<!--- Row: Comp City/State/Zip / Divider --->
		<tr>
			<td align="right" class="TextMaingr">Complainant City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="comp_city" value="#comp_city#" maxlength="20" tabindex="9">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="comp_state" value="#comp_state#" maxlength="2" tabindex="10">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="comp_zip" value="#comp_zip#" maxlength="10" tabindex="11">
			</td>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
		</tr>

		<!--- Row: Comp Phone / LR Manager --->
		<tr>
			<td align="right" class="TextMaingr">Complainant Phone</td>
			<td><cfinput type="text" size="15" name="comp_phone" value="#comp_phone#" maxlength="15" tabindex="12"></td>
			<td align="right" class="TextMaingr">LR Manager</td>
			<td>
				<cfquery name="qry_lr_mgr" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'LRMGR' AND b.group_prefix = 'WO'
					ORDER BY sort_fld
				</cfquery>
				<select name="lr_mgr" size="1" tabindex="35">
					<cfloop query="qry_lr_mgr">
						#renderOption(qry_lr_mgr.name, lr_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Facility / HR Manager --->
		<tr>
			<td align="right" class="TextMaingr">Complainant Facility</td>
			<td><cfinput type="text" size="60" name="comp_facility" value="#comp_facility#" maxlength="70" tabindex="13"></td>
			<td align="right" class="TextMaingr">HR Manager</td>
			<td>
				<cfquery name="qry_hr_mgr" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'HRMGR' AND b.group_prefix = 'WO'
					ORDER BY sort_fld
				</cfquery>
				<select name="hr_mgr" size="1" tabindex="39">
					<cfloop query="qry_hr_mgr">
						#renderOption(qry_hr_mgr.name, hr_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp District / District Manager --->
		<tr>
			<td align="right" class="TextMaingr">Complainant District</td>
			<td><cfinput type="text" size="60" name="comp_district" value="#comp_district#" maxlength="60" tabindex="14"></td>
			<td align="right" class="TextMaingr">District Manager</td>
			<td>
				<cfquery name="qry_dist_mgr" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'DMGR' AND b.group_prefix = 'WO'
					ORDER BY sort_fld
				</cfquery>
				<select name="dist_mgr" size="1" tabindex="40">
					<option value="">Select One...</option>
					<cfloop query="qry_dist_mgr">
						#renderOption(qry_dist_mgr.name, dist_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Agency No / HR Mgr District --->
		<tr>
			<td align="right" class="TextMaingr">Agency No.</td>
			<td><cfinput type="text" size="25" name="agency_no" value="#agency_no#" maxlength="25" tabindex="15"></td>
			<td align="right" class="TextMaingr">H&amp;R Mgr - District</td>
			<td>
				<cfquery name="qry_hr_mgr_dist" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'HRDST' AND b.group_prefix = 'WO'
					ORDER BY sort_fld
				</cfquery>
				<select name="hr_mgr_dist" size="1" tabindex="41">
					<option value="">Select One...</option>
					<cfloop query="qry_hr_mgr_dist">
						#renderOption(qry_hr_mgr_dist.name, hr_mgr_dist)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: EEOC No / OHNA District --->
		<tr>
			<td align="right" class="TextMaingr">EEOC No.</td>
			<td>
				<cfquery name="qry_eeoc_no_list" datasource="lawmanager">
					SELECT forum_number
					FROM lawmanager.forum
					WHERE matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
				</cfquery>
				<select name="eeoc_no" size="1" tabindex="16">
					<option value="Not Yet Assigned"<cfif eeoc_no EQ "Not Yet Assigned"> selected="selected"</cfif>>Not Yet Assigned</option>
					<cfloop query="qry_eeoc_no_list">
						#renderOption(qry_eeoc_no_list.forum_number, eeoc_no)#
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
					ORDER BY sort_fld
				</cfquery>
				<select name="ohna_dist" size="1" tabindex="39">
					<cfloop query="qry_ohna_dist">
						#renderOption(qry_ohna_dist.name, ohna_dist)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Divider --->
		<tr>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
		</tr>

		<!--- Row: Comp Rep Prefix / WO Office --->
		<tr>
			<td align="right" class="TextMaingr">Mr. / Ms.</td>
			<td>
				<select name="comp_rep_prefix" size="1" tabindex="17">
					#renderOption("Mr.", comp_rep_prefix)#
					#renderOption("Ms.", comp_rep_prefix)#
				</select>
			</td>
			<td width="10%" align="right" class="TextMaingr">WO Office</td>
			<td width="30%">
				<select name="alo_office" size="1" tabindex="43">
					<cfset woOffices = "Denver,Long Beach,Miami,Salt Lake,San Diego,San Francisco,Seattle">
					<cfloop list="#woOffices#" index="office">
						#renderOption(office, alo_office)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Rep First Name / WO Address1 --->
		<tr>
			<td align="right" class="TextMaingr">Comp. Rep. First Name</td>
			<td><cfinput type="text" size="40" name="comp_rep_fname" value="#comp_rep_fname#" maxlength="40" tabindex="18"></td>
			<td align="right" class="TextMaingr">WO Address1</td>
			<td>
				<cfset addr1Options = "1745 Stout Street, Suite 500|300 Long Beach Blvd., Rm 240|Miami Tower 100 SE 2nd Street, Suite 1500|9350 South 150 East, Suite 400|11255 Rancho Carmel Dr., Rm 1440|1300 Evans Ave., Rm 217|P.O. Box 3686">
				<select name="alo_addr1" size="1" tabindex="43">
					<cfloop list="#addr1Options#" delimiters="|" index="addr">
						#renderOption(addr, alo_addr1)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Rep Last Name / WO Address2 --->
		<tr>
			<td align="right" class="TextMaingr">Comp. Rep. Last Name</td>
			<td><cfinput type="text" size="40" name="comp_rep_lname" value="#comp_rep_lname#" maxlength="40" tabindex="19"></td>
			<td align="right" class="TextMaingr">WO Address2</td>
			<td>
				<cfset addr2Options = "Denver, CO 80299-5555|Long Beach, CA 90802-2496|Miami, FL 33131|Sandy, UT 84070-2773|San Diego, CA 92197-4400|San Francisco, CA 94188-3790|Seattle, WA 98124-3686">
				<select name="alo_addr2" size="1" tabindex="45">
					<cfloop list="#addr2Options#" delimiters="|" index="addr">
						#renderOption(addr, alo_addr2)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Rep Company / Attorney --->
		<tr>
			<td align="right" class="TextMaingr">Comp. Rep. Company</td>
			<td><cfinput type="text" size="25" name="comp_rep_comp" value="#comp_rep_comp#" maxlength="25" tabindex="20"></td>
			<td width="10%" align="right" class="TextMaingr">Attorney</td>
			<td width="30%">
				<cfquery name="qry_attorney" datasource="lawmanager">
					SELECT b.entity_key, b.attorney_name AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'ATTNY' AND b.group_prefix = 'WO'
					ORDER BY sort_fld
				</cfquery>
				<select name="attorney_name" size="1" tabindex="46">
					<cfloop query="qry_attorney">
						#renderOption(qry_attorney.name, attorney_name)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Rep Address / Attorney Title --->
		<tr>
			<td align="right" class="TextMaingr">Comp. Rep. Address</td>
			<td><cfinput type="text" size="40" name="comp_rep_addr" value="#comp_rep_addr#" maxlength="80" tabindex="21"></td>
			<td width="10%" align="right" class="TextMaingr">Attorney Title</td>
			<td width="30%">
				<select name="attorney_title" size="1" tabindex="47">
					#renderOption("Attorney", attorney_title)#
					#renderOption("Senior Litigation Counsel", attorney_title)#
					#renderOption("Managing Counsel", attorney_title)#
					#renderOption("Deputy Managing Counsel", attorney_title)#
				</select>
			</td>
		</tr>

		<!--- Row: Comp Rep City/State/Zip / Paralegal --->
		<tr>
			<td align="right" class="TextMaingr">Comp. Rep. City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="comp_rep_city" value="#comp_rep_city#" maxlength="20" tabindex="22">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="comp_rep_state" value="#comp_rep_state#" maxlength="2" tabindex="23">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="comp_rep_zip" value="#comp_rep_zip#" maxlength="12" tabindex="24">
			</td>
			<td width="10%" align="right" class="TextMaingr">Paralegal</td>
			<td width="30%">
				<cfquery name="qry_paralgl" datasource="lawmanager">
					SELECT b.entity_key, initcap(first_name) || ' ' || initcap(last_name) AS name
					FROM lawmanager.entity a
					INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
					WHERE b.entity_role = 'PLGL' AND b.group_prefix = 'WO'
					ORDER BY sort_fld
				</cfquery>
				<select name="paralgl_name" size="1" tabindex="48">
					<cfloop query="qry_paralgl">
						#renderOption(qry_paralgl.name, paralgl_name)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Rep Phone / WO Phone --->
		<tr>
			<td align="right" class="TextMaingr">Comp. Rep. Phone</td>
			<td><cfinput type="text" size="15" name="comp_rep_phone" value="#comp_rep_phone#" maxlength="15" tabindex="26"></td>
			<td align="right" class="TextMaingr">WO Phone</td>
			<td>
				<cfset woPhones = "(206) 381-6620|(206) 381-6623|(206) 381-6624|(206) 381-6625|(206) 381-6626|(206) 381-6628|(206) 381-6630|(303) 313-5560|(303) 313-5567|(303) 313-5576|(303) 313-5577|(303) 313-5579|(303) 313-5791|(415) 550-5300|(415) 550-5381|(415) 550-5397|(415) 550-5473|(415) 550-5493|(415) 550-5495|(562) 628-1340|(562) 628-1344|(562) 628-1345|(562) 628-1346|(562) 628-1347|(562) 628-1350|(562) 628-1351|(562) 628-1354|(562) 628-1357|(801) 984-8400|(801) 984-8403|(801) 984-8404|(801) 984-8420|(801) 984-8423|(801) 984-8428|(801) 984-8432|(858) 674-2686|(858) 674-2738|(858) 674-2742|(858) 674-2748">
				<select name="alo_phone" size="1" tabindex="49">
					<cfloop list="#woPhones#" delimiters="|" index="phone">
						#renderOption(phone, alo_phone)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Comp Rep Fax / WO Fax --->
		<tr>
			<td align="right" class="TextMaingr">Comp. Rep. Fax</td>
			<td><cfinput type="text" size="15" name="comp_rep_fax" value="#comp_rep_fax#" maxlength="15" tabindex="27"></td>
			<td align="right" class="TextMaingr">WO Fax</td>
			<td>
				<cfset woFaxes = "(206) 381-6621|(303) 313-5561|(650) 357-6336|(650) 357-6705|(650) 577-5679|(650) 578-1817|(650) 578-3806|(801) 984-8402">
				<select name="alo_fax" size="1" tabindex="50">
					<cfloop list="#woFaxes#" delimiters="|" index="fax">
						#renderOption(fax, alo_fax)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Legal Admin Assistant --->
		<tr>
			<td>&nbsp;</td>
			<td></td>
			<td align="right" class="TextMaingr">Legal Admin. Assistant</td>
			<td>
				<cfset assistants = "Shelley Bormann|Wilma Bray|Shana Brown-Spates|Tia Johnstun|Carol Lalor|Janet Huimin Luo|Vivienne Hansen|Alvin Samonte">
				<select name="admin_assist" size="1" tabindex="51">
					<cfloop list="#assistants#" delimiters="|" index="asst">
						#renderOption(asst, admin_assist)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Submit Button --->
		<tr>
			<td colspan="5" align="center">
				<br><br>
				<input type="image" src="/WO/img/save_continue1.gif" alt="Save and Continue" border="0" value="submit" tabindex="52">
			</td>
		</tr>

	</table>
	</div>

</cfform>
</cfoutput>

</body>
</html>
