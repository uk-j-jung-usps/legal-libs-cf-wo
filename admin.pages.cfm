<cfscript>
	// Extract ACE ID from authenticated user
	aceid = (isDefined("AUTH_USER") && len(AUTH_USER) >= 5) ? mid(AUTH_USER, 5, 6) : "";

	// Authorized admin users
	authorizedUsers = "kb23tj,x7xtm0,f24hn0,q204b0,kb7c8g,qchrg0,r8500b,dd32j0,k6gvn0,ysrj00";
	isAuthorized = listFindNoCase(authorizedUsers, aceid);
</cfscript>

<cfif isAuthorized>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Legal Libs Admin</title>
	<link href="/WO/css/form.css" rel="stylesheet" type="text/css">
	<script>
		function toggle(source) {
			var checkboxes = document.getElementsByName("templateid");
			for (var i = 0; i < checkboxes.length; i++) {
				checkboxes[i].checked = source.checked;
			}
		}
	</script>
</head>
<body style="margin:0; padding:5px 0 0 0; background-color:#ffffff; background-image:url('/WO/img/bck_yellowbox1.gif');">

<cfform action="sort.entity.list.action.cfm" method="post" name="template_form">

<div class="styleSelect">

	<table align="center" width="450" border="0" cellspacing="10" cellpadding="10" bgcolor="#ffffff">
		<tr>
			<td colspan="3" align="center"><img src="/WO/img/LL_header.gif" alt="Legal Libs" border="0" width="300" height="80"></td>
		</tr>
		<tr><td><hr></td></tr>
	</table>

	<table align="center" width="450" border="0" cellspacing="10" cellpadding="10" bgcolor="#ffffff">
		<tr>
			<td align="right"><a href="case.files.home.cfm">Home</a></td>
		</tr>
		<tr>
			<td><ul><li><a href="delist.entity.cfm">Remove Entities from Lists</a></li></ul></td>
		</tr>
		<tr>
			<td><ul><li><a href="search.add.entity.cfm">Search and Add Entity to List</a></li></ul></td>
		</tr>
		<tr>
			<td><ul><li><a href="sort.entity.list.cfm">Sort Entity Lists</a></li></ul></td>
		</tr>
	</table>

	<cfscript>
		if (isDefined("confirm_msg") && len(trim(confirm_msg))) {
			writeOutput('<script>alert("List(s) have been reordered successfully!");</script>');
		}
	</cfscript>

</div>
</cfform>

</body>
</html>

<cfelse>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Access Denied</title>
	<link href="/WO/css/form.css" rel="stylesheet" type="text/css">
</head>
<body>
	<p>Sorry! You are not authorized to access this Legal Libs Admin page.</p>
</body>
</html>

</cfif>
