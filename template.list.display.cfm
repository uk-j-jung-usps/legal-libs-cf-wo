<cfscript>
	// Initialize OWCP variable
	owcp_because = "";

	// Map matter type keys to config
	matterTypeConfig = {
		"9": { "label": "EEOC",  "displayPage": "master.file.detail.display.eeoc.cfm" },
		"8": { "label": "MSPB",  "displayPage": "master.file.detail.display.mspb.cfm" },
		"5": { "label": "DCT",   "displayPage": "master.file.detail.display.dct.cfm" }
	};

	currentConfig = structKeyExists(matterTypeConfig, mattertypekey)
		? matterTypeConfig[mattertypekey]
		: { "label": "Unknown", "displayPage": "" };
</cfscript>

<!--- Query templates for the specific matter type --->
<cfquery name="qry_template_list" datasource="lawmanager">
	SELECT template_key, template_name
	FROM lawmanager.cmft_templates
	WHERE matter_type_key = <cfqueryparam value="#mattertypekey#" cfsqltype="cf_sql_integer">
	  AND lmgroup_key = <cfqueryparam value="34690387" cfsqltype="cf_sql_integer">
	ORDER BY template_name
</cfquery>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Template Selection List</title>
	<link href="/WO/css/form.css" rel="stylesheet" type="text/css">
	<style>
		body {
			margin: 0;
			padding: 5px 0 0 0;
			background-color: #ffffff;
			background-image: url('/WO/img/bck_yellowbox1.gif');
		}
	</style>
	<script>
		function toggleAll(source) {
			var checkboxes = document.getElementsByName("templateid");
			for (var i = 0; i < checkboxes.length; i++) {
				checkboxes[i].checked = source.checked;
			}
		}

		function showElement(layerId) {
			var el = document.getElementById(layerId);
			if (el) {
				el.style.display = (el.style.display === "none") ? "table-cell" : "none";
			}
		}

		function hideElement(layerId) {
			var el = document.getElementById(layerId);
			if (el) {
				el.style.display = "none";
			}
		}
	</script>
</head>
<body>

<cfoutput>
<cfform action="process.templates.cfm" method="post" name="template_form">

	<input type="hidden" name="matterkey" value="#encodeForHTMLAttribute(url.matterkey)#">
	<input type="hidden" name="matternumber" value="#encodeForHTMLAttribute(url.matternumber)#">
	<input type="hidden" name="mattertypekey" value="#encodeForHTMLAttribute(url.mattertypekey)#">
	<input type="hidden" name="ownerkey" value="#encodeForHTMLAttribute(url.ownerkey)#">

	<div class="styleSelect">

	<!--- Navigation Bar --->
	<table align="center" width="85%" border="0" cellspacing="3" cellpadding="3" bgcolor="##ffffff">
		<tr>
			<td class="TextMaingr" bgcolor="##ffffff">
				<a href="case.files.home.cfm">Home</a>&nbsp;&nbsp;&nbsp;
				<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D#encodeForURL(matterkey)#" target="_blank">LawManager</a>&nbsp;&nbsp;&nbsp;
				<cfif len(currentConfig.displayPage)>
					<a href="#currentConfig.displayPage#?matterkey=#encodeForURL(matterkey)#&matternumber=#encodeForURL(matternumber)#&mattertypekey=#encodeForURL(mattertypekey)#">Back to #currentConfig.label# Data Input Screen</a>&nbsp;&nbsp;&nbsp;
				</cfif>
			</td>
			<td align="right">Template Selection List - #currentConfig.label#</td>
		</tr>
	</table>

	<!--- Template List --->
	<table align="center" width="85%" border="0" cellspacing="2" cellpadding="2" bgcolor="##ffffff">

		<tr>
			<td colspan="5">
				<input type="image" src="/WO/img/submit3.png" alt="Submit" width="62" height="23" border="0" value="submit">
				&nbsp;&nbsp;
				<a href="javascript:document.template_form.reset()"><img alt="Reset" src="/WO/img/reset.png" width="62" height="23" border="0"></a>
			</td>
		</tr>

		<tr>
			<td colspan="4">
				<input type="checkbox" onclick="toggleAll(this)"> Select All<br>
			</td>
		</tr>

		<cfloop query="qry_template_list">
			<tr>
				<td width="3">
					<cfinput type="checkbox" name="templateid" value="#qry_template_list.template_key#">
				</td>
				<td>#qry_template_list.template_name#</td>
			</tr>

			<!--- OWCP question for templates 78 and 80 --->
			<cfif listFind("78,80", trim(qry_template_list.template_key))>
				<tr>
					<td></td>
					<td>
						Are there allegations directly implicating a work related injury?
						<cfinput type="radio" name="owcp_answer" value="1" onclick="showElement('owcp_because')"> Yes
						<cfinput type="radio" name="owcp_answer" value="0" onclick="hideElement('owcp_because')"> No
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="4" id="owcp_because" style="display: none">
						<textarea name="owcp_because" cols="120" rows="5"></textarea>
					</td>
				</tr>
			</cfif>
		</cfloop>

		<!--- Bottom submit/reset (hidden for DCT) --->
		<cfif mattertypekey NEQ 5>
			<tr>
				<td></td>
				<td colspan="4">
					<input type="image" src="/WO/img/submit3.png" alt="Submit" width="62" height="23" border="0" value="submit">
					&nbsp;&nbsp;
					<a href="javascript:document.template_form.reset()"><img alt="Reset" src="/WO/img/reset.png" width="62" height="23" border="0"></a>
				</td>
			</tr>
		</cfif>

	</table>
	</div>

</cfform>
</cfoutput>

</body>
</html>
