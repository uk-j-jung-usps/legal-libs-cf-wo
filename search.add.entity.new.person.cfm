

<cfset entity_cat_flag =  "">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title>Search and add Entity</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="\legallibs\WO\css\form.css" rel="stylesheet" type="text/css">
<script src="\legallibs\WO\jquery\jquery.min.js"></script>
<!--- files for the loading spinner --->
<script src="\legallibs\WO\Loading-Visualization-master\dist\main.js"></script>
<link href="\legallibs\WO\Loading-Visualization-master\dist\main.css" rel="stylesheet">
<link href="\legallibs\WO\css\bootstrap.min.css" rel="stylesheet">
<script src="\legallibs\WO\jquery\jquery.min.js"></script>
<script src="\legallibs\WO\Loading-Visualization-master\demo.js"></script>



<script>
	$(document).ready(function(){
		$(".selectResults").hide();
		$(".categories").hide();
		$(".loader").hide();
		$("#assign_form").submit(function(event) {
			event.preventDefault();
			//console.log($(this).serialize());
			$("#selectEntity").empty();
			var searchCriteria = JSON.stringify($(this).serializeArray());
			console.log(searchCriteria);
			$.ajax({
				beforeSend: function() {
					$('.loader').show();
				},
				complete: function() {
					$('.loader').hide();
				},
				type: "GET",
				url: "components/law_lib_db.cfc?method=searchEntityTable&returnformat=json",
				data: {searchString: searchCriteria},
				dataType: "json",
				success: function(data) {
					console.log(data);
					$.each(data, function() {
						$("#selectEntity").append($("<option></option>").val(this.ENTITY_KEY).text(this.NAME));
					})
					$(".selectResults").show();
					$("#assign_form :input").prop('disabled',true);
					$("#selectEntity").prop('disabled',false);
				}
			});
			
		});

		$("#selectEntity").on("click",function(event) {
			console.log(event.target.value);
			$.ajax({
				type: "GET",
				url: "components/law_lib_db.cfc?method=getNameOfPerson&returnformat=json",
				data: {entityId:event.target.value},
				dataType: "json",
				success: function(data) {
					console.log(data);
					//$("#nameGoesHere").html(data.ENTITY_NAME);
					$.each(data,function() {
						$("#nameGoesHere").append($("<td colspan='3'>" + this.ENTITY_NAME + "<input type='hidden' name='entityKey' id='entityKey' value='" + this.ENTITY_KEY + "'><input type='hidden' name='entityName' id='endityName' value='" + this.ENTITY_NAME + "'></td>"));
					})
					$(".categories").show();
					$(".selectResults").hide();
					$("#category_form :input").prop('disabled',false);
				}
			});
		});
		$("#category_form").submit(function(event){
			var formData = $(this);
			
			event.preventDefault();
			var cmftData = JSON.stringify($(this).serializeArray());
			
			var newName = formData[0][1].attributes[3].value;
			var chCat = findCheckedCat(formData);
			
			$.ajax({
				type: "GET",
				url: "components/law_lib_db.cfc?method=insertCmftRecord&returnformat=json",
				data: {cmftData:cmftData},
				dataType: "json",
				success: function(data) {
					console.log(data);
					if(data == "Entity has been added to the selected list."){
						$("#category_form").hide();
						$(".success").append('<p class="TextMainb">' + newName + ' has been added to the ' + chCat + ' list.</p><p class="TextMainb"><a href="sort.entity.list.cfm">Go to sort page</a></p>');
						$(".success").show();
					}
				}
			})
		})
		
		function findCheckedCat(formData) {
			var categories = {2:"HR Manager",3:"LR Manager",4:"District Manager",5:"H&R Manager",6:"OHNA Manager",7:"Attorney",8:"Paralegal"};
			for (var i = 2; i <= 8; i++) {
				if(formData[0][i].checked === true){
					//var category = formData[0][i].attributes[2].value;
					var category = categories[i];
				}

			}
			return category;
		}
	});
</script>
</head>
<body bgcolor="#ffffff"
			leftmargin="0"
			topmargin="5"
			marginheight="5"
			marginwidth="0"
			background="\legallibs\img\bck_yellowbox1.gif">


<form action="" method="get" enctype="application/x-www-form-urlencoded" id="assign_form" name="assign_form" enablecab="yes" >


<div class="styleSelect">	

	<table align="center" width="450" border="0" cellspacing="4" cellpadding="4" bgcolor="#ffffff">		      
		<tr>
	  	<td colspan=3><a href="case.files.home.cfm">Home</a> | <a href="admin.pages.cfm">Legal Libs Admin</a><br><br><br></td></tr>
		  <tr>
			<td colspan="3">
				<div class="success" style="visibility:none;">
					<p class="TextMainb"></p>
				</div>
			</td>
		</tr>
			<!--- Field: Last Name --->
		<tr>
			<td colspan="3">Search for a NEW person to add</td>
		</tr>
		
			<tr>
	  	<td align="right" class=TextMainb >Last Name: </td>
	    <td width=25><select name="LastNameOperator" id="LastNameOperator">
				<option value="BEGINS_WITH">begins with
	  		<option value="EQUALS">is          		
	    		</select></td>
	  	<td>&nbsp;<input type="text" name="LastNameValue" id="LastNameValue" size="30" <!---value= 
	  	
	  	<cfif isdefined("LastNameValue")>
	  		"<cfoutput>#LastNameValue#</cfoutput>" 
	  	<cfelse>
	  		""
	  	</cfif>---></td></tr>
	
			<!--- Field: First Name --->
		<tr>
	  	<td align="right" class=TextMainb>First Name:</td>
	    <td><select name="FirstNameOperator" id="FirstNameOperator">
				<option value="BEGINS_WITH">begins with
	  		<option value="EQUALS">is
	    		</select></td>
	    <td>&nbsp;<input type="text" name="FirstNameValue" id="FirstNameValue" size="30"  </td>
	 </tr>  
	
	
		<cfif not isdefined("LastNameValue") and not isdefined("FirstNameValue")> 
			<tr>
				<!--- <td colspan=3 align=right valign="top"><input name="submit" id="submit" type="image" src="\legallibs\img\submit3.png" border=0 width=62 height=23 value="submit" > &nbsp;&nbsp; <A href="javascript:document.assign_form.reset()" > <IMG name="reset" id="reset" alt="" src="\legallibs\img\reset.png" border=0 width=62 height=23></A> --->
				<td colspan="3" align="right" valign="top"><input type="submit" id="submit" name="submit" value="Submit">&nbsp;&nbsp;<input type="reset" id="reset" name="reset" value="Reset">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			
			
			
		</cfif>
		<tr class="loader">
			<td colspan="4" >
				<div class="lv-dots sm lvl-5" data-label="Loading...">
					<div></div>
					<div></div>
					<div></div>
					<div></div>
				</div>
			</td>
		</tr>
		
	<div id="searchResults"  >
		<tr class="selectResults">
			<td colspan="4" class="TextMainb">Select a name from the drop down</td></tr>
		<tr class="selectResults" ><td colspan="4">
		<select id="selectEntity" name="selectEntity" size="10">
			<option value="0">Select a Law Manager User</option>
		</select></td>
		<!--- <input type="submit" name="btnSubmit" id="btnSubmit" value="Submit"> --->
	</tr>
	</div>
</table>
	
</form>
	
<div class="categories">
	
<form action="" method="get" enctype="application/x-www-form-urlencoded" id="category_form" name="category_form" enablecab="yes" > 	
		
		 
			<table align="center" width="450" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff">
				<tr >
					<td colspan=3>&nbsp;<br><br><br><hr></td>
				
				<tr id="nameGoesHere"> 
				 
				<tr>
				
					<td width=70% rowspan=7 valign=top></td>
					<td valign=top ><input type="Radio" name="entity_category"  value="HRMGR" >
					</td>				
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
	
				 				
					<tr>
						<!--- <td colspan=4><input type="image" src="\legallibs\img\submit3.png" border=0 width=62 height=22 value="submit" > &nbsp;&nbsp; <A href="javascript:document.assign_form.reset()" > <IMG alt="" src="\legallibs\img\reset.png" border=0 width=62 height=22></A> --->
						<td colspan="4"><input type="submit" name="submit2" id="submit2" value="Submit">&nbsp;&nbsp;<input type="reset" name="reset2" id="reset2" value="Reset"></td>
					</tr>
				
			</table>
		</form>
		</div>
		
		
	
	



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
	
			<cfquery name="assign_entity_role" datasource="lawmanager">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '<cfoutput>#entity_role#</cfoutput>'
				where entity_key = '#session.entity_key#'
			</cfquery>

			<cflocation url="sort.entity.list.cfm?confirm_msg1=Y">
	</cfif>
</cfif>
<!--- <div id="searchResults" >
	<form name="searchResultsForm" id="searchResultsForm" action="" method="post">
	<select id="selectEntity">
		<option value="0">Select a Law Manager User</option>
	</select>
	<input type="submit" name="btnSubmit" id="btnSubmit" value="Submit">
</form>
</div>
 --->


</div>

</body>
</html>
