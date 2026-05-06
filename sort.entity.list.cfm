
<!--- HR Managers Query--->
<cfquery name="qry_hr_mgr" datasource="lawmanager">
  select trim(sort_fld)||'         '|| b.entity_key  as combo_key, initcap(first_name) ||' '|| initcap(last_name) as name
  from entity a, cmft_entity_wo b where 
  a.entity_key = b.entity_key and b.entity_role = 'HRMGR' and b.group_prefix='WO' order by b.sort_fld
</cfquery>


<!--- LR Managers Query--->
<cfquery name="qry_lr_mgr" datasource="lawmanager">
  select trim(sort_fld)||'         '|| b.entity_key  as combo_key, initcap(first_name) ||' '|| initcap(last_name) as name
  from entity a, cmft_entity_wo b where 
  a.entity_key = b.entity_key and b.entity_role = 'LRMGR' and b.group_prefix='WO' order by b.sort_fld
</cfquery>


<!--- District Managers Query--->
<cfquery name="qry_dist_mgr" datasource="lawmanager">
  select trim(sort_fld)||'         '|| b.entity_key  as combo_key, initcap(first_name) ||' '|| initcap(last_name) as name
  from entity a, cmft_entity_wo b where 
  a.entity_key = b.entity_key and b.entity_role = 'DMGR' and b.group_prefix='WO' order by b.sort_fld
</cfquery>


<!--- H&R Managers - District Query--->
<cfquery name="qry_hr_mgr_dist" datasource="lawmanager">
  select trim(sort_fld)||'         '|| b.entity_key  as combo_key, initcap(first_name) ||' '|| initcap(last_name) as name
  from entity a, cmft_entity_wo b where 
  a.entity_key = b.entity_key and b.entity_role = 'HRDST' and b.group_prefix='WO' order by b.sort_fld
</cfquery>


<!--- OHNA Managers Query--->
<cfquery name="qry_ohna_mgr" datasource="lawmanager">
  select trim(sort_fld)||'         '|| b.entity_key  as combo_key, initcap(first_name) ||' '|| initcap(last_name) as name
  from entity a, cmft_entity_wo b where 
  a.entity_key = b.entity_key and b.entity_role = 'OHNA' and b.group_prefix='WO' order by b.sort_fld
</cfquery>


<!--- Attorneys Query--->
<cfquery name="qry_attorneys" datasource="lawmanager">
	select trim(sort_fld)||'         '|| b.entity_key  as combo_key, b.attorney_name as name
	from entity a, cmft_entity_wo b where
	a.entity_key = b.entity_key and b.entity_role = 'ATTNY' and b.group_prefix='WO' order by b.sort_fld
</cfquery>



<!--- Paralegals Query--->
<cfquery name="qry_paralegals" datasource="lawmanager">
  select trim(sort_fld)||'         '|| b.entity_key  as combo_key, initcap(first_name) ||' '|| initcap(last_name) as name
  from entity a, cmft_entity_wo b where 
  a.entity_key = b.entity_key and b.entity_role = 'PLGL' and b.group_prefix='WO' order by b.sort_fld
</cfquery>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title>Sort Entity List</title>
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


<cfform action="sort.entity.list.action.cfm" method="post" enctype="application/x-www-form-urlencoded" name="template_form" enablecab="yes" >


<!---	
<cfoutput>#matterkey#</cfoutput>
<cfoutput>
SQL: #qry_hr_mgrt.getMetaData().getExtendedMetaData().sql#
</cfoutput>
--->


<div class="styleSelect">	

<table align="center" width=85% border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >

	<tr>
	<td colspan=3>
	<tr>
	<td colspan=3 >To sort each category place <b>only numbers</b> (not letters) in the sort column and click "Submit" button.<br>
								 All non-numberic entries will be interpreted as number "1".
	<td align=right ><a href="case.files.home.cfm"> Home </a>  &nbsp; &nbsp;<a href="admin.pages.cfm">Legal Libs Admin</a>
	</tr>

	<tr>
	<td colspan=10><hr>
	</tr>

	<tr>
		<td valign=top >
			<table   border="0" width=250 cellspacing="1" cellpadding="1" bgcolor="#ffffff" >
				<tr>
					<td colspan=3 ><b> HR Managers</b>
					<tr>
					<td width=6>Sort:	
				<cfoutput Query="qry_hr_mgr">
				<tr>
					<td ><cfinput type="text" style="width:18px"  name="combo_key_hr" value="#qry_hr_mgr.combo_key#" maxlength="40">		
					<td valign=top>#qry_hr_mgr.name#  <!---,#mid(trim(qry_hr_mgr.combo_key),5,12)#--->
				</cfoutput>
			</table>


		<td valign=top >
			<table   border="0" width=250 cellspacing="1" cellpadding="1" bgcolor="#ffffff" >
				<tr>
					<td colspan=3 ><b> LR Managers</b>
					<tr>
					<td width=6>Sort:	
				<cfoutput Query="qry_lr_mgr">
				<tr>
					<td ><cfinput type="text" style="width:18px"  name="combo_key_lr" value="#qry_lr_mgr.combo_key#" maxlength="40">		
					<td valign=top>#qry_lr_mgr.name#  <!---,#mid(trim(qry_lr_mgr.combo_key),5,12)#--->
				</cfoutput>
			</table>


		<td valign=top >
			<table   border="0" width=250 cellspacing="1" cellpadding="1" bgcolor="#ffffff" >
				<tr>
					<td colspan=3 ><b> District Managers</b>
					<tr>
					<td width=6>Sort:	
				<cfoutput Query="qry_dist_mgr">
				<tr>
					<td ><cfinput type="text" style="width:18px"  name="combo_key_dmgr" value="#qry_dist_mgr.combo_key#" maxlength="40">		
					<td valign=top>#qry_dist_mgr.name#  <!---,#mid(trim(qry_dist_mgr.combo_key),5,12)#--->
				</cfoutput>
			</table>

		<td valign=top rowspan=4>
			<table   border="0" width=250 cellspacing="1" cellpadding="1" bgcolor="#ffffff" >
				<tr>
					<td colspan=3 ><b> Attorneys</b>
					<tr>
					<td width=6>Sort:	
				<cfoutput Query="qry_attorneys">
				<tr>
					<td ><cfinput type="text" style="width:18px"  name="combo_key_attny" value="#qry_attorneys.combo_key#" maxlength="40">		
					<td valign=top>#qry_attorneys.name#  <!---,#mid(trim(qry_attorneys.combo_key),5,12)#--->
				</cfoutput>
			</table>

	</tr>

	<tr>
	<td colspan=3><hr>
	</tr>


	<tr>
		<td valign=top >
			<table   border="0" width=250 cellspacing="1" cellpadding="1" bgcolor="#ffffff" >
				<tr>
					<td colspan=3 ><b> OHNA Managers</b>
					<tr>
					<td width=6>Sort:	
				<cfoutput Query="qry_ohna_mgr">
				<tr>
					<td ><cfinput type="text" style="width:18px"  name="combo_key_ohna" value="#qry_ohna_mgr.combo_key#" maxlength="40">		
					<td valign=top>#qry_ohna_mgr.name#  <!---,#mid(trim(qry_ohna_mgr.combo_key),5,12)#--->
				</cfoutput>
			</table>

		<td valign=top >
			<table   border="0" width=250 cellspacing="1" cellpadding="1" bgcolor="#ffffff" >
				<tr>
					<td colspan=3 ><b> H&R MGRs - District</b>
					<tr>
					<td width=6>Sort:	
				<cfoutput Query="qry_hr_mgr_dist">
				<tr>
					<td ><cfinput type="text" style="width:18px"  name="combo_key_hr_dist" value="#qry_hr_mgr_dist.combo_key#" maxlength="40">		
					<td valign=top>#qry_hr_mgr_dist.name#  <!---,#mid(trim(qry_hr_mgr_dist.combo_key),5,12)#--->
				</cfoutput>
			</table>


		<td valign=top >
			<table   border="0" width=250 cellspacing="1" cellpadding="1" bgcolor="#ffffff" >
				<tr>
					<td colspan=3 ><b> Paralegals</b>
					<tr>
					<td width=6>Sort:	
				<cfoutput Query="qry_paralegals">
				<tr>
					<td ><cfinput type="text" style="width:18px"  name="combo_key_plgl" value="#qry_paralegals.combo_key#" maxlength="40">		
					<td valign=top>#qry_paralegals.name#  <!---,#mid(trim(qry_paralegals.combo_key),5,12)#--->
				</cfoutput>
			</table>
			
	<tr>
	<td	colspan=4>&nbsp;		
	<tr>
	<td colspan=4 align=middle><input type="image" src="img/submit3.png" border=0 width=62 height=22 border=0  value="submit" > &nbsp;&nbsp; <A href="javascript:document.template_form.reset()" > <IMG alt="" src="img/reset1.png" border=0 width=62 height=22 border=0></A>
	</tr>
</table>

<cfif isDefined("confirm_msg")>
	<cfif len(trim(confirm_msg))>
		<script language="JavaScript">
			alert("list(s) have been reordred successfully!")
		</script>
	</cfif>
</cfif>

<cfif isDefined("confirm_msg1")>
	<cfif len(trim(confirm_msg1))>
		<script language="JavaScript">
			alert("Entity has been added to the selected list!")
		</script>
	</cfif>
</cfif>
</div>
</cfform>
</body>
</html>
