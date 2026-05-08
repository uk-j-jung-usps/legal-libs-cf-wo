

<!--- ********** define the variable owcp_because for tempalte EEOC Template Ltr Applnt Rep Req Auth final.rtf **********--->
		<cfset owcp_becuase = "">


<!--- ********** Query templates for specific matter type**********--->

  <cfswitch expression="#mattertypekey#">
   <cfcase value="9">
		<cfquery name="qry_template_list" datasource="lawmanager">
		  select * from cmft_templates where matter_type_key = '9' and lmgroup_key = '34690387'  order by template_name 
		</cfquery>
	 </cfcase>
   <cfcase value="8">
		<cfquery name="qry_template_list" datasource="lawmanager">
		  select * from cmft_templates where matter_type_key = '8' and lmgroup_key = '34690387' order by template_name 
		</cfquery>
	 </cfcase>		 
   <cfcase value="5">
		<cfquery name="qry_template_list" datasource="lawmanager">
		  select * from cmft_templates where matter_type_key = '5' and lmgroup_key = '34690387' order by template_name 
		</cfquery>
	 </cfcase>		 
 </cfswitch>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title>Template Selection List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/WO/css/form.css" rel="stylesheet" type="text/css">


<script language="JavaScript">
function toggle(source) {

  checkboxes = document.getElementsByName("templateid");
  for(var i=0, n=checkboxes.length;i<n;i++) {
    checkboxes[i].checked = source.checked;
  }
}

</script>



<script>
 function showElement(layer) {
     var myLayer = document.getElementById(layer);
     if (myLayer.style.display == "none") {
         myLayer.style.display = "table-cell";
         myLayer.backgroundPosition = "top";
     } else {
         myLayer.style.display = "none";
     }
 }
   
 function hideElement(layer) {
     var myLayer = document.getElementById(layer);
     if (myLayer.style.display == "block") {
         myLayer.style.display = "table-cell";
         myLayer.backgroundPosition = "top";
     } else {
         myLayer.style.display = "none";
     }
 }    
    
</script

</head>
<body bgcolor="#ffffff"
			leftmargin="0"
			topmargin="5"
			marginheight="5"
			marginwidth="0"
			background="img/bck_yellowbox1.gif">


<cfform action="process.templates.cfm" method="post" enctype="application/x-www-form-urlencoded" name="template_form" enablecab="yes" >
<cfoutput>	
<input name="matterkey" type="hidden" value="#url.matterkey#" >
<input name="matternumber" type="hidden" value="#url.matternumber#" >
<input name="mattertypekey" type="hidden" value="#url.mattertypekey#" >
<input name="ownerkey" type="hidden" value="#url.ownerkey#" >

</cfoutput>

<!---	
<cfoutput>#matterkey#</cfoutput><br>
<cfoutput>SQL: #qry_template_list.getMetaData().getExtendedMetaData().sql#</cfoutput>
--->


<div class="styleSelect">	

<table align="center" width="85%" border="0" cellspacing="3" cellpadding="3" bgcolor="#ffffff" >


	<tr>
	<td  class=TextMaingrcolapan=5 bgcolor="#ffffff"> <a href="case.files.home.cfm"> Home</a>&nbsp;&nbsp;&nbsp;
	<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D<cfoutput>#matterkey#</cfoutput>" target="_blank"> LawManager</a> &nbsp;&nbsp;&nbsp;
	
	  <cfswitch expression="#mattertypekey#">
	   <cfcase value="9">
			 <a href="master.file.detail.display.eeoc.cfm?matterkey=<cfoutput>#matterkey#&matternumber=#matternumber#&mattertypekey=#mattertypekey#</cfoutput>"> Back to EEOC Data Input Screen</a> &nbsp;&nbsp;&nbsp; 
		 </cfcase>
	   <cfcase value="8">
			 <a href="master.file.detail.display.mspb.cfm?matterkey=<cfoutput>#matterkey#&matternumber=#matternumber#&mattertypekey=#mattertypekey#</cfoutput>"> Back to MSPB Data Input Screen</a> &nbsp;&nbsp;&nbsp;
		 </cfcase>		 
	   <cfcase value="5">
			 <a href="master.file.detail.display.dct.cfm?matterkey=<cfoutput>#matterkey#&matternumber=#matternumber#&mattertypekey=#mattertypekey#</cfoutput>"> Back to DCT Data Input Screen</a> &nbsp;&nbsp;&nbsp;
		 </cfcase>		 
	 </cfswitch>

	</td>
	<td align=right>
	  <cfswitch expression="#mattertypekey#">
	   <cfcase value="9">
			 Template Selection List - EEOC
		 </cfcase>
	   <cfcase value="8">
			 Template Selection List - MSPB 
		 </cfcase>		 
	   <cfcase value="5">
			 Template Selection List - DCT
		 </cfcase>		 
	 </cfswitch>		
  </td>
	<!---<a href="master.file.detail.display.eeoc.cfm?matterkey=<cfoutput>#matterkey#&matternumber=#matternumber#</cfoutput>"> EEOC Input Data Screen</a> &nbsp;&nbsp;&nbsp;--->

	</td>
</table>

<table align="center" width="85%" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
	<tr>
	<td colspan=5><input type="image" src="/WO/img/submit3.png" border=0 width=62 height=23  value="submit" > &nbsp;&nbsp; <A href="javascript:document.template_form.reset()" > <IMG alt="" src="/WO/img/reset.png" border=0 width=62 height=23></A>

	<tr><td colspan=4><input type="checkbox" onClick="toggle(this)" /> Select All<br/>

	<cfoutput Query="qry_template_list">
		<tr>
		<td width=3><cfinput type="checkbox"  name="templateid" value="#qry_template_list.template_key#" >
		<td>#qry_template_list.template_name#  <!---,#qry_template_list.template_key#	--->
	

		<tr >
		<cfif (trim(qry_template_list.template_key) eq "78") or ((trim(qry_template_list.template_key) eq "80"))>
				<tr>
				<td></td>
				<td> Are there allegations directly implicating a work related injury?
					 <cfinput type="radio"  name="owcp_answer" value="1" onclick="javascript:showElement('owcp_because')">Yes 
				  <cfinput type="radio"  name="owcp_answer" value="0" onclick="javascript:hideElement('owcp_because')">No
				</tr>
				<tr>
				<td></td>
		  <td colspan=4 id="owcp_because" style="display: none"><textarea name="owcp_because" cols="120" rows="5"></textarea> </td></td>
	  </tr>  
	 </cfif>
	 
 
	 
	 
	 
	 
		</tr>	

	</cfoutput>
	<tr>


	<cfif not #mattertypekey# eq 5>
		<td><td colspan=4><input type="image" src="img/submit3.png" border=0 width=62 height=23  value="submit" > &nbsp;&nbsp; <A href="javascript:document.template_form.reset()" > <IMG alt="" src="img/reset.png" border=0 width=62 height=23 ></A>
	</cfif>

</table>
</div>
</cfform>
</body>
</html>
