<cfscript>
// Instantiate MSPB display component
mspbComponent = new components.master_file_display_mspb_component();
</cfscript>

<cfinclude template="submitted.data.mspb.cfm">
<cfinclude template="admin.judge.data.cfm">
<cfinclude template="appellant.data.cfm">
<cfinclude template="appellant.rep.data.cfm">

<cfscript>
	// Default all variables to empty string if not yet defined
	varList = "appellant_prefix,appellant_pronoun1,appellant_pronoun2,appellant_eid,appellant_ssn,appellant_fname,appellant_lname,appellant_addr,appellant_city,appellant_state,appellant_zip,appellant_phone,appellant_facility,appellant_district,appellant_email,appellant_rep_prefix,appellant_rep_fname,appellant_rep_lname,appellant_rep_company,appellant_rep_addr,appellant_rep_city,appellant_rep_state,appellant_rep_zip,appellant_rep_phone,appellant_rep_fax,aj_fname,aj_lname,aj_title,aj_addr,aj_city,aj_state,aj_zip,aj_phone,aj_fax,mspb_office,docket_no,attorney_name,attorney_title,paralgl_name,lr_mgr,hr_mgr,dist_mgr,hr_mgr_dist,ohna_dist,alo_office,alo_addr1,alo_addr2,alo_phone,alo_fax,admin_assist";
	for (v in listToArray(varList)) {
		if (!structKeyExists(variables, v)) {
			variables[v] = "";
		}
	}

	// Pre-fetch all entity role lists
	qry_lr_mgr      = mspbComponent.getEntityListByRole("LRMGR");
	qry_hr_mgr      = mspbComponent.getEntityListByRole("HRMGR");
	qry_dist_mgr    = mspbComponent.getEntityListByRole("DMGR");
	qry_hr_mgr_dist = mspbComponent.getEntityListByRole("HRDST");
	qry_ohna_dist   = mspbComponent.getEntityListByRole("OHNA");
	qry_paralgl     = mspbComponent.getEntityListByRole("PLGL");
	qry_attorney    = mspbComponent.getAttorneyList();
</cfscript>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Legal Libs Templates - MSPB</title>
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
				<a href="case.files.home.cfm">Home</a> &nbsp;&nbsp;&nbsp;
				<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D#encodeForURL(url.matterkey)#" target="_blank">LawManager</a> &nbsp;&nbsp;&nbsp;
				<a href="admin.pages.cfm">Legal Libs Admin</a>
			</td>
			<td align="right" class="TextMaingr" bgcolor="##D9E9EA">WLO - MSPB</td>
		</tr>

		<tr><td><br><br></td></tr>

		<!--- Row: Appellant Prefix / AJ First Name --->
		<tr>
			<td width="15%" align="right" class="TextMaingr">Mr. / Ms.</td>
			<td>
				<select name="appellant_prefix" size="1" tabindex="1">
					#mspbComponent.renderOption("Mr.", appellant_prefix)#
					#mspbComponent.renderOption("Ms.", appellant_prefix)#
				</select>
			</td>
			<td align="right" class="TextMaingr">AJ First Name</td>
			<td><cfinput type="text" size="40" name="aj_fname" value="#aj_fname#" maxlength="40" tabindex="28"></td>
		</tr>

		<!--- Row: Pronoun1 / AJ Last Name --->
		<tr>
			<td align="right" class="TextMaingr">he / she / they</td>
			<td>
				<select name="appellant_pronoun1" size="1" tabindex="2">
					#mspbComponent.renderOption("he", appellant_pronoun1)#
					#mspbComponent.renderOption("she", appellant_pronoun1)#
					#mspbComponent.renderOption("they", appellant_pronoun1)#
				</select>
			</td>
			<td align="right" class="TextMaingr">AJ Last Name</td>
			<td><cfinput type="text" size="40" name="aj_lname" value="#aj_lname#" maxlength="40" tabindex="29"></td>
		</tr>

		<!--- Row: Pronoun2 / AJ Title --->
		<tr>
			<td align="right" class="TextMaingr">his / her / their</td>
			<td>
				<select name="appellant_pronoun2" size="1" tabindex="3">
					#mspbComponent.renderOption("his", appellant_pronoun2)#
					#mspbComponent.renderOption("her", appellant_pronoun2)#
					#mspbComponent.renderOption("their", appellant_pronoun2)#
				</select>
			</td>
			<td width="10%" align="right" class="TextMaingr">AJ Title</td>
			<td>
				<select name="aj_title" size="1" tabindex="30">
					#mspbComponent.renderOption("Administrative Judge", aj_title)#
					#mspbComponent.renderOption("Supervisory Administrative Judge", aj_title)#
					#mspbComponent.renderOption("Chief Administrative Judge", aj_title)#
				</select>
			</td>
		</tr>

		<!--- Row: Appellant EID / AJ Address --->
		<tr>
			<td align="right" class="TextMaingr">Appellant EID</td>
			<td><cfinput type="text" size="9" name="appellant_eid" value="#appellant_eid#" maxlength="8" tabindex="4"></td>
			<td align="right" class="TextMaingr">AJ Address</td>
			<td width="20%"><cfinput type="text" size="40" name="aj_addr" value="#aj_addr#" maxlength="80" tabindex="31"></td>
		</tr>

		<!--- Row: Appellant SSN / AJ City/State/Zip --->
		<tr>
			<td align="right" class="TextMaingr">Appellant SSN</td>
			<td><cfinput type="text" size="10" name="appellant_ssn" value="#appellant_ssn#" maxlength="9" tabindex="5"></td>
			<td align="right" class="TextMaingr">AJ City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="aj_city" value="#aj_city#" maxlength="20" tabindex="32">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="aj_state" value="#aj_state#" maxlength="2" tabindex="33">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="aj_zip" value="#aj_zip#" maxlength="10" tabindex="34">
			</td>
		</tr>

		<!--- Row: Appellant First Name / MSPB Office --->
		<tr>
			<td align="right" class="TextMaingr">Appellant First Name</td>
			<td><cfinput type="text" size="40" name="appellant_fname" value="#appellant_fname#" maxlength="40" tabindex="6"></td>
			<td width="10%" align="right" class="TextMaingr">MSPB Office</td>
			<td>
				<select name="mspb_office" size="1" tabindex="35">
					#mspbComponent.renderOption("Western Regional Office", mspb_office)#
					#mspbComponent.renderOption("Denver Field Office", mspb_office)#
					#mspbComponent.renderOption("Los Angeles District", mspb_office)#
					#mspbComponent.renderOption("San Francisco District", mspb_office)#
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Last Name / AJ Phone --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Last Name</td>
			<td><cfinput type="text" size="40" name="appellant_lname" value="#appellant_lname#" maxlength="40" tabindex="7"></td>
			<td align="right" class="TextMaingr">AJ Phone</td>
			<td><cfinput type="text" size="15" name="aj_phone" value="#aj_phone#" maxlength="15" tabindex="36"></td>
		</tr>

		<!--- Row: Appellant Address / AJ Fax --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Address</td>
			<td><cfinput type="text" size="40" name="appellant_addr" value="#appellant_addr#" maxlength="80" tabindex="8"></td>
			<td align="right" class="TextMaingr">AJ Fax</td>
			<td><cfinput type="text" size="15" name="aj_fax" value="#aj_fax#" maxlength="15" tabindex="37"></td>
		</tr>

		<!--- Row: Appellant City/State/Zip / Divider --->
		<tr>
			<td align="right" class="TextMaingr">Appellant City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="appellant_city" value="#appellant_city#" maxlength="20" tabindex="9">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="appellant_state" value="#appellant_state#" maxlength="2" tabindex="10">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="appellant_zip" value="#appellant_zip#" maxlength="10" tabindex="11">
			</td>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
		</tr>

		<!--- Row: Appellant Phone / LR Manager --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Phone</td>
			<td><cfinput type="text" size="15" name="appellant_phone" value="#appellant_phone#" maxlength="15" tabindex="12"></td>
			<td align="right" class="TextMaingr">LR Manager</td>
			<td>
				<select name="lr_mgr" size="1" tabindex="38">
					<option value="">Select One...</option>
					<cfloop query="qry_lr_mgr">
						#mspbComponent.renderOption(qry_lr_mgr.name, lr_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Facility / HR Manager --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Facility</td>
			<td><cfinput type="text" size="60" name="appellant_facility" value="#appellant_facility#" maxlength="70" tabindex="13"></td>
			<td align="right" class="TextMaingr">HR Manager</td>
			<td>
				<select name="hr_mgr" size="1" tabindex="39">
					<option value="">Select One...</option>
					<cfloop query="qry_hr_mgr">
						#mspbComponent.renderOption(qry_hr_mgr.name, hr_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant District / District Manager --->
		<tr>
			<td align="right" class="TextMaingr">Appellant District</td>
			<td><cfinput type="text" size="60" name="appellant_district" value="#appellant_district#" maxlength="60" tabindex="14"></td>
			<td align="right" class="TextMaingr">District Manager</td>
			<td>
				<select name="dist_mgr" size="1" tabindex="40">
					<option value="">Select One...</option>
					<cfloop query="qry_dist_mgr">
						#mspbComponent.renderOption(qry_dist_mgr.name, dist_mgr)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Docket No / H&R Mgr District --->
		<tr>
			<td align="right" class="TextMaingr">Docket No.</td>
			<td><cfinput type="text" size="25" name="docket_no" value="#docket_no#" maxlength="25" tabindex="15"></td>
			<td align="right" class="TextMaingr">H&amp;R Mgr - District</td>
			<td>
				<select name="hr_mgr_dist" size="1" tabindex="41">
					<option value="">Select One...</option>
					<cfloop query="qry_hr_mgr_dist">
						#mspbComponent.renderOption(qry_hr_mgr_dist.name, hr_mgr_dist)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Email / OHNA District --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Email</td>
			<td><cfinput type="text" size="40" name="appellant_email" value="#appellant_email#" maxlength="40" tabindex="16"></td>
			<td align="right" class="TextMaingr">OHNA - District</td>
			<td>
				<select name="ohna_dist" size="1" tabindex="42">
					<option value="">Select One...</option>
					<cfloop query="qry_ohna_dist">
						#mspbComponent.renderOption(qry_ohna_dist.name, ohna_dist)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Divider --->
		<tr>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
			<td colspan="2" align="right" class="TextMaingr"><hr></td>
		</tr>

		<!--- Row: Appellant Rep Prefix / WO Office --->
		<tr>
			<td align="right" class="TextMaingr">Mr. / Ms.</td>
			<td>
				<select name="appellant_rep_prefix" size="1" tabindex="17">
					#mspbComponent.renderOption("Mr.", appellant_rep_prefix)#
					#mspbComponent.renderOption("Ms.", appellant_rep_prefix)#
				</select>
			</td>
			<td width="10%" align="right" class="TextMaingr">WO Office</td>
			<td width="30%">
				<cfset woOffices = "Denver|Long Beach|Salt Lake|San Diego|San Francisco|Seattle">
				<select name="alo_office" size="1" tabindex="43">
					<cfloop list="#woOffices#" delimiters="|" index="office">
						#mspbComponent.renderOption(office, alo_office)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Rep First Name / WO Address1 --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Rep. First Name</td>
			<td><cfinput type="text" size="40" name="appellant_rep_fname" value="#appellant_rep_fname#" maxlength="40" tabindex="18"></td>
			<td align="right" class="TextMaingr">WO Address1</td>
			<td>
				<cfset addr1Options = "1745 Stout Street, Suite 500|300 Long Beach Blvd., Rm 240|9350 South 150 East, Suite 800|11255 Rancho Carmel Dr., Rm 1440|1300 Evans Ave., Rm 217|P.O. Box 3686">
				<select name="alo_addr1" size="1" tabindex="44">
					<cfloop list="#addr1Options#" delimiters="|" index="addr">
						#mspbComponent.renderOption(addr, alo_addr1)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Rep Last Name / WO Address2 --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Rep. Last Name</td>
			<td><cfinput type="text" size="40" name="appellant_rep_lname" value="#appellant_rep_lname#" maxlength="40" tabindex="19"></td>
			<td align="right" class="TextMaingr">WO Address2</td>
			<td>
				<cfset addr2Options = "Denver, CO 80299-5555|Long Beach, CA 90802-2496|Sandy, UT 84070-2716|San Diego, CA 92197-4400|San Francisco, CA 94188-3790|Seattle, WA 98124-3686">
				<select name="alo_addr2" size="1" tabindex="45">
					<cfloop list="#addr2Options#" delimiters="|" index="addr">
						#mspbComponent.renderOption(addr, alo_addr2)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Rep Company / Attorney --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Rep. Company</td>
			<td><cfinput type="text" size="25" name="appellant_rep_company" value="#appellant_rep_company#" maxlength="25" tabindex="20"></td>
			<td width="10%" align="right" class="TextMaingr">Attorney</td>
			<td width="30%">
				<select name="attorney_name" size="1" tabindex="46">
					<option value="">Select One...</option>
					<cfloop query="qry_attorney">
						#mspbComponent.renderOption(qry_attorney.name, attorney_name)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Rep Address / Attorney Title --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Rep. Address</td>
			<td><cfinput type="text" size="40" name="appellant_rep_addr" value="#appellant_rep_addr#" maxlength="80" tabindex="21"></td>
			<td width="10%" align="right" class="TextMaingr">Attorney Title</td>
			<td width="30%">
				<select name="attorney_title" size="1" tabindex="47">
					<option value="">Select One...</option>
					#mspbComponent.renderOption("Attorney", attorney_title)#
					#mspbComponent.renderOption("Senior Litigation Counsel", attorney_title)#
					#mspbComponent.renderOption("Managing Counsel", attorney_title)#
					#mspbComponent.renderOption("Deputy Managing Counsel", attorney_title)#
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Rep City/State/Zip / Paralegal --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Rep. City</td>
			<td class="TextMaingr">
				<cfinput type="text" size="20" name="appellant_rep_city" value="#appellant_rep_city#" maxlength="20" tabindex="22">&nbsp;State&nbsp;
				<cfinput type="text" size="2" name="appellant_rep_state" value="#appellant_rep_state#" maxlength="2" tabindex="23">&nbsp;Zip&nbsp;
				<cfinput type="text" size="11" name="appellant_rep_zip" value="#appellant_rep_zip#" maxlength="12" tabindex="24">
			</td>
			<td width="10%" align="right" class="TextMaingr">Paralegal</td>
			<td width="30%">
				<select name="paralgl_name" size="1" tabindex="48">
					<option value="">Select One...</option>
					<cfloop query="qry_paralgl">
						#mspbComponent.renderOption(qry_paralgl.name, paralgl_name)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Rep Phone / WO Phone --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Rep. Phone</td>
			<td><cfinput type="text" size="15" name="appellant_rep_phone" value="#appellant_rep_phone#" maxlength="15" tabindex="26"></td>
			<td align="right" class="TextMaingr">WO Phone</td>
			<td>
				<cfset woPhones = "(206) 381-6620|(206) 381-6623|(206) 381-6624|(206) 381-6625|(206) 381-6626|(206) 381-6628|(303) 313-5560|(303) 313-5567|(303) 313-5577|(303) 313-5579|(303) 313-5791|(415) 550-5300|(415) 550-5381|(415) 550-5397|(415) 550-5473|(415) 550-5493|(415) 550-5495|(562) 628-1340|(562) 628-1344|(562) 628-1345|(562) 628-1346|(562) 628-1347|(562) 628-1350|(562) 628-1351|(562) 628-1354|(562) 628-1357|(801) 984-8400|(801) 984-8403|(801) 984-8404|(801) 984-8420|(801) 984-8423|(801) 984-8428|(801) 984-8432|(858) 674-2686|(858) 674-2738|(858) 674-2742|(858) 674-2748">
				<select name="alo_phone" size="1" tabindex="49">
					<option value="">Select One...</option>
					<cfloop list="#woPhones#" delimiters="|" index="phone">
						#mspbComponent.renderOption(phone, alo_phone)#
					</cfloop>
				</select>
			</td>
		</tr>

		<!--- Row: Appellant Rep Fax / WO Fax --->
		<tr>
			<td align="right" class="TextMaingr">Appellant Rep. Fax</td>
			<td><cfinput type="text" size="15" name="appellant_rep_fax" value="#appellant_rep_fax#" maxlength="15" tabindex="27"></td>
			<td align="right" class="TextMaingr">WO Fax</td>
			<td>
				<cfset woFaxes = "(206) 381-6621|(303) 313-5561|(650) 357-6336|(650) 357-6705|(650) 577-5679|(650) 578-1817|(650) 578-3806|(801) 984-8402">
				<select name="alo_fax" size="1" tabindex="50">
					<option value="">Select One...</option>
					<cfloop list="#woFaxes#" delimiters="|" index="fax">
						#mspbComponent.renderOption(fax, alo_fax)#
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
					<option value="">Select One...</option>
					<cfloop list="#assistants#" delimiters="|" index="asst">
						#mspbComponent.renderOption(asst, admin_assist)#
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
