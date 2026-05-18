
<cfset aceid = #mid(AUTH_USER,5,6)#>
<cfif  aceid eq "">
	<cfset aceid = "dd32j0">
</cfif>

<!---<cfoutput>#aceid#</cfoutput><br>--->



	<!---********When Legal Libs is launched from LawManager application by selecting a specific case********--->
	<cfif isdefined("url.matterkey")>
			<cfquery name="qry_matter_no" datasource="lawmanager">
		    select substr(matter_number, 1, 2) as matter_prefix, matter_number,matter_name, matter_type_key from matter where matter_key='#url.matterkey#'
			</cfquery>
	<!---		<cfoutput>#qry_matter_no.matter_prefix#</cfoutput><br>--->
			  
			  
			<cfif qry_matter_no.matter_type_key eq "9">
			<!---09/30/2021 Commented code out - Not used
				<cfif qry_matter_no.matter_prefix eq "WI">
					<cflocation url="master.file.detail.display.eeoc_WI.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">
				</cfif>
			End 09/30/2021--->
				<cfif qry_matter_no.matter_prefix eq "SF">
					<cflocation url="master.file.detail.display.eeoc.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">				
				</cfif>
				<cfif qry_matter_no.matter_prefix eq "WO">
					<cflocation url="master.file.detail.display.eeoc.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">				
				</cfif>
			<!---09/30/2021 Commented code out - Not used
				<cfif qry_matter_no.matter_prefix eq "SL">
					<cflocation url="master.file.detail.display.eeoc_SL.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">				
				</cfif>
			End 09/30/2021--->
				
			<cfelseif qry_matter_no.matter_type_key eq "8">
			
			<!---09/30/2021 Commented code out - Not used
				<cfif qry_matter_no.matter_prefix eq "WI">
					<!---<cflocation url="master.file.detail.display.mspb.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">--->
					<cflocation url="legallibs_message_mspb.cfm">
				</cfif>
			End 09/30/2021--->
				<cfif qry_matter_no.matter_prefix eq "SF">
					<cflocation url="master.file.detail.display.mspb.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">
				</cfif>
				<cfif qry_matter_no.matter_prefix eq "WO">
					<cflocation url="master.file.detail.display.mspb.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">
				</cfif>
			<!---09/30/2021 Commented code out - Not used
				<cfif qry_matter_no.matter_prefix eq "SL">
					<cflocation url="master.file.detail.display.mspb_SL.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">
				</cfif>
			End 09/30/2021--->

			<cfelseif qry_matter_no.matter_type_key eq "5">
			<!---09/30/2021 Commented code out - Not used
				<cfif qry_matter_no.matter_prefix eq "WI">
					<!---<cflocation url="master.file.detail.display.dct.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">	--->
					<cflocation url="legallibs_message_district_court.cfm">
				</cfif>
			End 09/30/2021--->
				<cfif qry_matter_no.matter_prefix eq "SF">
					<cflocation url="master.file.detail.display.dct.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">
				</cfif>
				<cfif qry_matter_no.matter_prefix eq "WO">
					<cflocation url="master.file.detail.display.dct.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">
				</cfif>
			<!---09/30/2021 Commented code out - Not used
				<cfif qry_matter_no.matter_prefix eq "SL">
					<cflocation url="master.file.detail.display.dct_SL.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#">
				</cfif>	
			End 09/30/2021--->
					
			<cfelseif qry_matter_no.matter_type_key eq "1">
				
				<!---********Make sure the Advice case deals with Subpoenas and Affidavits********--->
		    <cfquery name="qry_advice_subpoena" datasource="lawmanager">
		    	select a.matter_key, a.matter_type_key, a.matter_name from matter a, mattercategoryusps b	
		    	where matter_number='#qry_matter_no.matter_number#' and a.matter_key=b.matter_key and b.category_type_key=8 and subcategory_type_key=199
			  </cfquery>		
				
					<cfif qry_advice_subpoena.RecordCount>
						<cflocation url="master.file.detail.display.advice_fssc.cfm?matterkey=#url.matterkey#&matternumber=#qry_matter_no.matter_number#&mattertypekey=#qry_matter_no.matter_type_key#&mattername=#qry_advice_subpoena.matter_name#">
					<cfelse>
						<cflocation url="master.file.detail.display.other.cfm">
					</cfif>			
					<!---****end identifying a Subpoenas and Affidavits case *****--->
				
			<cfelse>
					<cflocation url="master.file.detail.display.other.cfm">
			</cfif>
						  

	
	<!---********When Legal Libs is launched directly via a link and outside LM********--->	
	<cfelse>

	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<html>
	<head>
	
	
	<title>Legal Libs Templates!</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/WO/css/form.css" rel="stylesheet" type="text/css">
	
	</head>
	
	<CFPARAM NAME="matternoerror" DEFAULT=''>
	<CFPARAM NAME="confirm_msg" DEFAULT=''>
	
	
	<body bgcolor="#ffffff"
				leftmargin="0"
				topmargin="5"
				marginheight="5"
				marginwidth="0"
				background="/WO/img/bck_yellowbox2.gif">
		
		
	<cfform action="lm_matter_no.cfm" method="post" enctype="application/x-www-form-urlencoded" name="mainform" enablecab="yes" >	
	
	<div class="styleSelect">	
	
	<table align="center" width="450" border="0" cellspacing="20" cellpadding="20" bgcolor="#ffffff" >
	<tr><td colspan=3 align=center><img src="/WO/img/LL_header.gif"  border="0" >
	</table>
		
	<table align="center" width="330" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" >
	
	
	
	<tr><td colspan=3 align=center>&nbsp;<br><br><br><br><!---<img src="/WO/img/header1.gif" width=300 width=80 border="0" >--->
	<tr><br>
		<td width=160 align="right" class=TextMaingr>Enter Matter Number: </td>
		<td  align=middle ><cfinput type="text" size="13" name="matter_no"  value="" maxlength="11" required="yes" message="Please enter a valid LM case number!"  > </td>
			
	
		<td><input type="image" src="/WO/img/go2.gif" border=0  value="submit" >
			
			<!---</a> &nbsp;&nbsp; <A href="javascript:document.mainform.reset()" > <IMG alt="" src="img/reset.gif" border=0></A>---></td>
	
	
	
	
	<tr><td colspan=4>
	
	<cfif len(trim(matternoerror))>		
		<cfoutput>
		<center>
		Invalid matter number. Please try again.
		</center>
		</cfoutput>
	</cfif>
	
	<tr><td  colspan=3 align=center valign=bottom><br><br><br><br><br>
		<tr><td  colspan=3 align=center valign=bottom><a href="admin.pages.cfm"><!---Legal Libs Admin---></a>
	</table>
	</div>
	</cfform>
	</body>
	</html>
	</cfif>
	<cfset confirm_msg = ""> 
	<cfif len(trim(confirm_msg))>
	
		<script language="JavaScript">
		alert("You have successfuly submitted selected template(s). You should receive a confirmation email shortly with an attachment containing processed template(s). <!---It's possible that you do not receive an email due to exchange server failure. In that case, using your browser's 'Back' button, revert back to thelist of tempaltes and re-submit.--->");
		</script>
	
	</cfif>
	