

<cfset aceid = #mid(AUTH_USER,5,6)#>
<cfif aceid eq 'kb23tj' or aceid eq 'x7xtm0' or aceid eq 'f24hn0' or aceid eq 'q204b0' or aceid eq 'kb7c8g' or aceid eq 'qchrg0' or aceid eq 'r8500b' or aceid eq 'dd32j0' or aceid eq 'k6gvn0' or aceid eq 'ysrj00'>


		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
		<html>
		<head>
		
		<title>Legal Libs Admin</title>
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
		
		
		
		
		<div class="styleSelect">	
		
			<table align="center" width="450" border="0" cellspacing="10" cellpadding="10" bgcolor="#ffffff" >
			<tr><td colspan=3 align=center><img src="img/LL_header.gif"  border="0" width=300 height=80>
			<tr><td><hr>
			</table>
		
			<table align="center" width="450" border="0" cellspacing="10" cellpadding="10" bgcolor="#ffffff" >
			<tr>
			<td align=right><a href="case.files.home.cfm"> Home</a>
			<tr>		
			<td><ul><li><a href="delist.entity.cfm"> Remove Entities from Lists</a>
			<tr>
			<td ><ul><li><a href="search.add.entity.cfm"> Search and Add Entity to List</a>	
			<tr>
			<td ><ul><li><a href="sort.entity.list.cfm"> Sort Entity Lists</a>	<br><br><br><br>
		
			</table>
		
		
		
		
		<cfif isDefined("confirm_msg")>
			<cfif len(trim(confirm_msg))>
				<script language="JavaScript">
					alert("list(s) have been reordred successfully!")
				</script>
			</cfif>
		</cfif>
		
		
		</div>
		</cfform>
		</body>
		</html>

<cfelse>

Sorry! You are not authorized to access this Legal Libs Admin page!

</cfif>



	
