
<!--- HR Managers Query--->
<cfquery name="qry_hr_mgr" datasource="lawmanager">
	select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
	where b.entity_role = 'HRMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
</cfquery>



<!--- LR Managers Query--->
<cfquery name="qry_lr_mgr" datasource="lawmanager">
	select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
	where b.entity_role = 'LRMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
</cfquery>


<!--- District Managers Query--->
<cfquery name="qry_dist_mgr" datasource="lawmanager">
	select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
	where b.entity_role = 'DMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
</cfquery>



<!--- H&R Managers Query--->
<cfquery name="qry_hr_mgr_dist" datasource="lawmanager">
	select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
	where b.entity_role = 'HRDST' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
</cfquery>


<!--- OHNA Managers Query--->
<cfquery name="qry_ohna_dist" datasource="lawmanager">
	select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
	where b.entity_role = 'OHNA' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
</cfquery>


<!--- Attorneys Query--->
<cfquery name="qry_attorney" datasource="lawmanager">
	select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
	where b.entity_role = 'ATTNY' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
</cfquery>


<!--- Paralegals Query--->
<cfquery name="qry_paralgl" datasource="lawmanager">
	select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
	where b.entity_role = 'PLGL' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
</cfquery>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title>Delete Entity</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/form.css" rel="stylesheet" type="text/css">


<script language="JavaScript">
function toggle(source) {

  checkboxes = document.getElementsByName("templateid");
  for(var i=0, n=checkboxes.length;i<n;i++) {
    checkboxes[i].checked = source.checked;
  }
}

</script>


</head>
<body bgcolor="#ffffff"
			leftmargin="0"
			topmargin="5"
			marginheight="5"
			marginwidth="0"
			background="img/bck_yellowbox1.gif">


<cfform action="delist.entity.action.cfm" method="post" enctype="application/x-www-form-urlencoded" name="template_form" enablecab="yes" >



<!---	
<cfoutput>#matterkey#</cfoutput>
<cfoutput>
SQL: #qry_hr_mgrt.getMetaData().getExtendedMetaData().sql#
</cfoutput>
--->


<div class="styleSelect">	

<table align="center" width="35%" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >

	<tr>
	<td colspan=4  >Make selection(s) and click the Submit button to delist.
	<td align=right><a href="case.files.home.cfm"> Home </a>  &nbsp; &nbsp;<a href="admin.pages.cfm">Legal Libs Admin</a>
	</tr>

	<tr>
	<td colspan=6><hr>
	</tr>

	<tr>
		<td valign=top>
			<table align="center" width="200" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
				<tr>
				<td colspan=2><b> HR Managers</b>				
					<cfoutput Query="qry_hr_mgr">
					<tr>
						<td width=3><cfinput type="checkbox"  name="entityid1" value="#qry_hr_mgr.entity_key#" >
						<td>#qry_hr_mgr.name#  <!---,#qry_hr_mgr.entity_key#--->

					</cfoutput>
			</table>
	
		<td valign=top>
			<table align="center" width="200" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
				<tr>
				<td colspan=2><b> LR Managers</b>				
				<cfoutput Query="qry_lr_mgr">
				<tr>
					<td width=3><cfinput type="checkbox"  name="entityid2" value="#qry_lr_mgr.entity_key#" >
					<td>#qry_lr_mgr.name#  <!---,#qry_lr_mgr.entity_key#	--->
				</cfoutput>
			</table>

		<td valign=top>
			<table align="center" width="200" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
				<tr>
				<td colspan=2><b> District Managers</b>				
				<cfoutput Query="qry_dist_mgr">
				<tr>
					<td width=3><cfinput type="checkbox"  name="entityid3" value="#qry_dist_mgr.entity_key#" >
					<td>#qry_dist_mgr.name#  <!---,#qry_dist_mgr.entity_key#	--->
				</cfoutput>
			</table>

		<td valign=top>
			<table align="center" width="200" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
				<tr>
				<td colspan=2><b> H&R MGRs - District</b>				
				<cfoutput Query="qry_hr_mgr_dist">
				<tr>
					<td width=3><cfinput type="checkbox"  name="entityid4" value="#qry_hr_mgr_dist.entity_key#" >
					<td>#qry_hr_mgr_dist.name#  <!---,#qry_hr_mgr_dist.entity_key#	--->
				</cfoutput>
			</table>
		<td valign=top rowspan=4>
			<table align="center" width="200" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
				<tr>
				<td colspan=2><b> Attorneys</b>				
					<cfoutput Query="qry_attorney">
					<tr>
						<td width=3><cfinput type="checkbox"  name="entityid6" value="#qry_attorney.entity_key#" >
						<td><cfif #qry_attorney.name# eq "Sherilyn Deninno">
								 	Sherilyn DeNinno  <!---,#qry_attorney.entity_key#--->	
								<cfelse>
								 	#qry_attorney.name#	
								</cfif>
					</cfoutput>
			</table>

	</tr>

	<tr>
	<td colspan=4><hr>
	</tr>


	<tr>
	
		<td valign=top>
			<table align="center" width="200" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
				<tr>
				<td colspan=2><b> OHNA Managers</b>				
				<cfoutput Query="qry_ohna_dist">
				<tr>
					<td width=3><cfinput type="checkbox"  name="entityid5" value="#qry_ohna_dist.entity_key#" >
					<td>#qry_ohna_dist.name#  <!---,#qry_ohna_dist.entity_key#	--->
				</cfoutput>
			</table>	
	

		<td valign=top>
			<table align="center" width="200" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
				<tr>
				<td colspan=2><b> Paralegals</b>				
					<cfoutput Query="qry_paralgl">
					<tr>
						<td width=3><cfinput type="checkbox"  name="entityid7" value="#qry_paralgl.entity_key#" >
						<td>#qry_paralgl.name#	
					</cfoutput>
			</table>
	<tr>
	<td colspan=4>
	<tr>
	<td colspan=4 align=middle><input type="image" src="img/submit3.png" border=0 width=62 height=23 border=0  value="submit" > &nbsp;&nbsp; <A href="javascript:document.template_form.reset()" > <IMG alt="" src="img/reset.png" border=0 width=62 height=23 border=0></A>
	</tr>
</table>

<cfif isDefined("confirm_msg")>
	<cfif len(trim(confirm_msg))>
		<script language="JavaScript">
			alert("Selected person(s) successfuly removed from their corresponding list(s)!")
		</script>
	</cfif>
</cfif>


</div>
</cfform>
</body>
</html>
