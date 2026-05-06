

<cfset entity_cat_flag =  "">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title>Search and add Entity</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/form.css" rel="stylesheet" type="text/css">



</head>
<body bgcolor="#ffffff"
			leftmargin="0"
			topmargin="5"
			marginheight="5"
			marginwidth="0"
			background="img/bck_yellowbox1.gif">


<cfform action="search.add.entity.cfm" method="get" enctype="application/x-www-form-urlencoded" name="assign_form" enablecab="yes" >


<div class="styleSelect">	

	<table align="center" width="450" border="0" cellspacing="4" cellpadding="4" bgcolor="#ffffff">		      
		<tr>
	  	<td colspan=3><a href="case.files.home.cfm">Home</a> | <a href="admin.pages.cfm">Legal Libs Admin</a><br><br><br></td></tr>
			<!--- Field: Last Name --->
		<tr>
	  	<td align="right" class=TextMainb >Last Name: </td>
	    <td width=25><select name="LastNameOperator">
				<option value="BEGINS_WITH">begins with
	  		<option value="EQUALS">is          		
	    		</select></td>
	  	<td>&nbsp;<input type="text" name="LastNameValue" size="30" <!---value= 
	  	
	  	<cfif isdefined("LastNameValue")>
	  		"<cfoutput>#LastNameValue#</cfoutput>" 
	  	<cfelse>
	  		""
	  	</cfif>---></td></tr>
	
			<!--- Field: First Name --->
		<tr>
	  	<td align="right" class=TextMainb>First Name:</td>
	    <td><select name="FirstNameOperator">
				<option value="BEGINS_WITH">begins with
	  		<option value="EQUALS">is
	    		</select></td>
	    <td>&nbsp;<input type="text" name="FirstNameValue"size="30"  <!---value= 
	 
	  	<cfif isdefined("FirstNameValue")>
	  		"<cfoutput>#FirstNameValue#</cfoutput>" 
	  	<cfelse>
	  		""
	  	</cfif>---> </td>
	 </tr>  
	
	
		<cfif not isdefined("LastNameValue") and not isdefined("FirstNameValue")> 
			<tr>
				<td colspan=4 align=right><input type="image" src="img/submit3.png" border=0 width=62 height=23 value="submit" > &nbsp;&nbsp; <A href="javascript:document.assign_form.reset()" > <IMG alt="" src="img/reset.png" border=0 width=62 height=23></A>
			</tr>
		</cfif>
	</table>


<cfif isdefined("LastNameValue") and isdefined("FirstNameValue")>

	<cfif #len(LastNameValue)# or #len(FirstNameValue)#>

		<cfset WhereClause = "0=0">
		<cfset LastNameValue = Replace(LastNameValue, "'", "''", "all")>
	
		<cfif LastNameOperator EQ "EQUALS">
		   <cfset WhereClause = WhereClause & " AND trim(last_name) = '" & #UCASE(LastNameValue)# & "'" >
		<cfelse>
		   <cfset WhereClause = WhereClause & " AND trim(last_name) like '" & #UCASE(LastNameValue)# & "%'" >
		</cfif>
	
	
		<cfif FirstNameOperator EQ "EQUALS">
		   <cfset WhereClause = WhereClause & " AND trim(first_name) = '" & #UCASE(FirstNameValue)# & "'" >
		<cfelse>
		   <cfset WhereClause = WhereClause & " AND trim(first_name) like '" & #UCASE(FirstNameValue)# & "%'" >
		</cfif>
	
		<!---<cfset WhereClause = WhereClause & " AND new_entity_code = 'LL'">--->
		<cfset WhereClause = WhereClause & " AND trim(entity_role) is null and a.entity_key = b.entity_key">
	
	  <!---<cfoutput>#WhereClause#</cfoutput><br>--->



		<cfquery name="qry_inactive_list" datasource="lawmanager" result="r">
			select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from entity a, cmft_entity_wo b where 
			#PreserveSingleQuotes(WhereClause)#                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
		</cfquery>

		
		<!---<cfoutput>#r.sql#  </cfoutput>--->
		
		<!---keep the entity_key in the query above t be used in the last query at the bottom--->
		<CFSET session.entity_key = "#qry_inactive_list.entity_key#">
	
		<cfif qry_inactive_list.RecordCount gt 0>
		
			<table align="center" width="450" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff">
				<tr>
					<td colspan=3>&nbsp;<br><br><br><hr></td>
				<tr> 
				  <td colspan=3>&nbsp;<br></td>
				<tr>
					<td width=70% rowspan=7 valign=top><cfoutput><b>#qry_inactive_list.name#</b></cfoutput></td>
					<td valign=top ><input type="Radio" name="entity_category" value="HRMGR" ></td>				
					<td valign=top > HR Manager</td>
				<tr>
					<td valign=top ><input type="Radio" name="entity_category" value="LRMGR" ></td>			
					<td valign=top > LR Manager</td>
				<tr>
					<td valign=top ><input type="Radio" name="entity_category" value="DMGR" ></td>			
					<td valign=top > District Manager</td>
				<tr>
					<td valign=top width=5><input type="Radio" name="entity_category" value="HRDST" ></td>
					<td valign=top > H&R Manager</td>							
				<tr>
					<td valign=top ><input type="Radio" name="entity_category" value="OHNA" ></td>
					<td valign=top > OHNA Manager</td>									
				<tr>
					<td valign=top ><input type="Radio" name="entity_category" value="ATTNY" ></td>
					<td valign=top > Attorney</td>				
				<tr>
					<td valign=top ><input type="Radio" name="entity_category" value="PLGL" ></td>	
					<td valign=top > Paralegal</td>	
	
				<cfif isdefined("LastNameValue") and isdefined("FirstNameValue")> 				
					<tr>
						<td colspan=4><input type="image" src="img/submit3.png" border=0 width=62 height=22 value="submit" > &nbsp;&nbsp; <A href="javascript:document.assign_form.reset()" > <IMG alt="" src="img/reset.png" border=0 width=62 height=22></A>
					</tr>
				</cfif>
			</table>
		<cfelse>
			<cfif  isdefined("LastNameValue") and  isdefined("FirstNameValue")> 
				<table align="center" width="450" border="0" cellspacing="0" cellpadding="2" bgcolor="#ffffff">
				<tr>
					<td colspan=4 align=right><input type="image" src="img/submit3.png" border=0 width=62 height=22 value="submit" > &nbsp;&nbsp; <A href="javascript:document.assign_form.reset()" > <IMG alt="" src="img/reset.png" border=0 width=62 height=22></A>
				</tr>
				<tr>
				<td > Entity not found. try again.</td>
				
				</table>
			</cfif>	
		</cfif>
		
	<cfelse>

		<cfif not IsDefined("entity_category") >
			<table align="center" width="450" border="0" cellspacing="0" cellpadding="2" bgcolor="#ffffff">
			<tr>
				<td colspan=10 align=right><input type="image" src="img/submit3.png" border=0 width=62 height=22 value="submit" > &nbsp;&nbsp; <A href="javascript:document.assign_form.reset()" > <IMG alt="" src="img/reset.png" border=0 width=62 height=22></A>		
			</table>
			<script>
				alert("Must select a category to enlist the person!")
			</script>
		</cfif>			

	</cfif>
	
</cfif>


<cfif IsDefined("entity_category")>


	<cfif #len(entity_category)#>
	 <cfswitch expression="#Trim(entity_category)#"> 
	   <cfcase value="HRMGR">
		 	<cfset entity_role = 'HRMGR'>		 
	   </cfcase>
	   
	   <cfcase value="LRMGR">
		 	<cfset entity_role = 'LRMGR'>		 
	   </cfcase>
	   
	   <cfcase value="DMGR">
		 	<cfset entity_role = 'DMGR'>		 
	   </cfcase>

	   <cfcase value="HRDST">
		 	<cfset entity_role = 'HRDST'>		 
	   </cfcase>

	   <cfcase value="OHNA">
		 	<cfset entity_role = 'OHNA'>		 
	   </cfcase>

	   <cfcase value="ATTNY">
		 	<cfset entity_role = 'ATTNY'>		 
	   </cfcase>

	   <cfcase value="PLGL">
		 	<cfset entity_role = 'PLGL'>		 
	   </cfcase>
	   
	   <cfdefaultcase>
	 		<cfset entity_role = ' '>
	   </cfdefaultcase>		
	   		   
	 </cfswitch>

	</cfif>

	<!---***update cmft_entity table to give the entity the role user has selected by checking the desired readio button***--->
	
	<cfif #len(entity_role)#>
	
			<cfquery name="assign_entity_role" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '<cfoutput>#entity_role#</cfoutput>'
				where entity_key = '#session.entity_key#'
			</cfquery>

			<cflocation url="sort.entity.list.cfm?confirm_msg1=Y">
	</cfif>
</cfif>




</div>
</cfform>
</body>
</html>
