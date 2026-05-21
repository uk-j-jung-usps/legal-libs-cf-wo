<cfscript>
	// Extract ACE ID from authenticated user
	aceid = mid(AUTH_USER, 5, 6);
	if (len(trim(aceid)) == 0) {
		aceid = "dd32j0";
	}
</cfscript>

<!--- When Legal Libs is launched from LawManager application by selecting a specific case --->
<cfif structKeyExists(url, "matterKey")>

	<cfscript>
		woComponent = new components.wo_eeoc_component();
		qry_matter_no = woComponent.getMatterByKey(url.matterKey);
	
		// Build common URL parameters
		matterKey     = encodeForURL(url.matterKey);
		matterNumber  = encodeForURL(qry_matter_no.matter_number);
		matterTypeKey = encodeForURL(qry_matter_no.matter_type_key);
		matterPrefix  = encodeForURL(qry_matter_no.matter_prefix);
        matterName    = encodeForURL(qry_matter_no.matter_name);
		baseParams    = "matterkey=#matterKey#&matternumber=#matterNumber#&mattertypekey=#matterTypeKey#&matter_prefix=#matterPrefix#&mattername=#matterName#";

		matterType = qry_matter_no.matter_type_key;
		prefix     = qry_matter_no.matter_prefix;
	</cfscript>

	<cfswitch expression="#matterType#">

		<!--- EEOC cases (matter_type_key = 9) --->
		<cfcase value="9">
			<cfif prefix EQ "SF" OR prefix EQ "WO">
				<cflocation url="master.file.detail.display.eeoc.cfm?#baseParams#" addtoken="false">
			</cfif>
		</cfcase>

		<!--- MSPB cases (matter_type_key = 8) --->
		<cfcase value="8">
			<cfif prefix EQ "SF" OR prefix EQ "WO">
				<cflocation url="master.file.detail.display.mspb.cfm?#baseParams#" addtoken="false">
			</cfif>
		</cfcase>

		<!--- District Court cases (matter_type_key = 5) --->
		<cfcase value="5">
			<cfif prefix EQ "SF" OR prefix EQ "WO">
				<cflocation url="master.file.detail.display.dct.cfm?#baseParams#" addtoken="false">
			</cfif>
		</cfcase>

		<!--- Advice cases (matter_type_key = 1) - Subpoenas and Affidavits --->
		<cfcase value="1">
			<cfscript>
                woComponentAdviceSubpoena = new components.wo_advice_subpoena_component();
                qry_advice_subpoena = woComponentAdviceSubpoena.getAdviceSubpoenaByMatterKey(url.matterKey);

                matterKey = encodeForURL(qry_advice_subpoena.matter_key);
                matterTypeKey = encodeForURL(qry_advice_subpoena.matter_type_key);
                matterName = encodeForURL(qry_advice_subpoena.matter_name);
            </cfscript>

			<cfif qry_advice_subpoena.recordCount GT 0>
				<cflocation url="master.file.detail.display.advice_fssc.cfm?#baseParams#" addtoken="false">
			<cfelse>
				<cflocation url="master.file.detail.display.other.cfm" addtoken="false">
			</cfif>
		</cfcase>

		<!--- All other case types --->
		<cfdefaultcase>
			<cflocation url="master.file.detail.display.other.cfm" addtoken="false">
		</cfdefaultcase>

	</cfswitch>

<!--- When Legal Libs is launched directly via a link (no matterkey in URL) --->
<cfelse>

	<cfparam name="matternoerror" default="">
	<cfparam name="confirm_msg" default="">

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
				background-image: url('/WO/img/bck_yellowbox2.gif');
			}
			.container {
				width: 450px;
				margin: 0 auto;
				padding: 20px;
				background-color: #ffffff;
				text-align: center;
			}
			.form-table {
				width: 330px;
				margin: 0 auto;
			}
			.error-message {
				text-align: center;
				color: red;
			}
		</style>
	</head>
	<body>

		<cfform action="lm_matter_no.cfm" method="post" name="mainform">

			<div class="styleSelect">
				<div class="container">
					<img src="/WO/img/LL_header.gif" alt="Legal Libs Header" border="0">
				</div>

				<table class="form-table" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="3" align="center">&nbsp;<br><br><br><br></td>
					</tr>
					<tr>
						<td width="160" align="right" class="TextMaingr">Enter Matter Number:&nbsp;</td>
						<td align="center">
							<cfinput type="text" size="13" name="matter_no" value="" maxlength="11"
									 required="yes" message="Please enter a valid LM case number!">
						</td>
						<td>
							<input type="image" src="/WO/img/go2.gif" alt="Submit" border="0" value="submit">
						</td>
					</tr>

					<cfif len(trim(matternoerror))>
						<tr>
							<td colspan="3" class="error-message">
								<cfoutput>Invalid matter number. Please try again.</cfoutput>
							</td>
						</tr>
					</cfif>

					<tr>
						<td colspan="3" align="center" valign="bottom"><br><br><br><br><br></td>
					</tr>
					<tr>
						<td colspan="3" align="center" valign="bottom">
							<a href="admin.pages.cfm"></a>
						</td>
					</tr>
				</table>
			</div>

		</cfform>

	</body>
	</html>

</cfif>

<cfscript>
	confirm_msg = "";
	if (len(trim(confirm_msg))) {
		writeOutput('<script>alert("You have successfully submitted selected template(s). You should receive a confirmation email shortly with an attachment containing processed template(s).");</script>');
	}
</cfscript>
