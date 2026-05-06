<cfinclude template = "submitted.data.eeoc.cfm">
<cfinclude template = "complainant.data.cfm">
<cfinclude template = "complainant.rep.data.cfm">
<cfinclude template = "admin.judge.data.cfm">



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
<title>Legal Libs Templates!</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/form.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#ffffff"
			leftmargin="0"
			topmargin="5"
			marginheight="5"
			marginwidth="0"
			background="img/bck_yellowbox1.gif">




<cfform action="save.input.data.cfm" method="post" enctype="application/x-www-form-urlencoded" name="entityform" enablecab="yes" >	

<input name="matterkey" type="hidden" value="<cfoutput>#url.matterkey#</cfoutput>" >
<input name="matternumber" type="hidden" value="<cfoutput>#url.matternumber#</cfoutput>" >
<input name="mattertypekey" type="hidden" value="<cfoutput>#url.mattertypekey#</cfoutput>" >


<div class="styleSelect">	

<table align="center" width="85%" border="0" cellspacing="1" cellpadding="1" bgcolor="#ffffff" >

	<tr>
	<td colspan=3 class=TextMaingrcolapan=5 bgcolor="#D9E9EA"> <a href="case.files.home.cfm"> Home </a> &nbsp;&nbsp;&nbsp;
	<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D<cfoutput>#matterkey#</cfoutput>" target="_blank"> LawManager</a> &nbsp;&nbsp;&nbsp;
	<a href="admin.pages.cfm"> Legal Libs Admin </a>
	<td align=right class=TextMaingrcolapan=5 bgcolor="#D9E9EA">	WLO - EEOC
	
	<!---<a href="template.list.cfm?matterkey=<cfoutput>#matterkey#</cfoutput>"> Template Selection</a> &nbsp;&nbsp;&nbsp;--->
	<!---<a href="question.list.cfm"> Dynamic Template Questions</a> &nbsp;&nbsp;&nbsp;--->
	</td>
	
	<tr>
	<td>  <br><br>
	</td>
		
	<tr>
		<td  width=15% align="right" class=TextMaingr >Mr. / Ms. </td>
		<td>

<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="comp_prefix" size="1" tabindex=1>
						<!---<option value="">Select One...</option>		--->	
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="comp_prefix" size="1" tabindex=1>
							<option value="#comp_prefix#" selected="selected">#comp_prefix#</option>
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>				
					</select>
				</cfoutput>		
			</cfif>--->
            

				<cfoutput>
					<select name="comp_prefix" size="1" tabindex=1>
						<option value="Mr." <cfif isdefined('comp_prefix') AND comp_prefix eq 'Mr.'> selected="selected" </cfif>>Mr.</option>
						<option value="Ms." <cfif isdefined('comp_prefix') AND  comp_prefix eq 'Ms.'> selected="selected" </cfif>>Ms.</option>				
					</select>
				</cfoutput>		
	
            
		</td>
		
		<td  width=15% align="right" class=TextMaingr>AJ First Name </td>
		<td ><cfinput type="text" size="40" name="aj_fname"  value="#aj_fname#" maxlength="40"  tabindex=28> </td>		
	</tr>			


	<tr>
		<td  align="right" class=TextMaingr >he / she / they </td>
		<td>
<!---            <cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="comp_pronoun1" size="1" tabindex=2>
						<!---<option value="">Select One...</option>--->	
						<option value="he">he</option>
						<option value="she" >she</option>
						<option value="they" >they</option>					
				</select>
			<cfelse>
				<cfoutput>
					<select name="comp_pronoun1" size="1" tabindex=1>
						<option value="#comp_pronoun1#" selected="selected">#comp_pronoun1#</option>
						<option value="he">he</option>
						<option value="she" >she</option>
						<option value="they" >they</option>				
					</select>
				</cfoutput>		
			</cfif>--->
            
<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="comp_pronoun1" size="1" tabindex=2>
						<!---<option value="">Select One...</option>--->	
						<option value="he">he</option>
						<option value="she" >she</option>
						<option value="they" >they</option>					
				</select>
			<cfelse>--->
				<cfoutput>
					<select name="comp_pronoun1" size="1" tabindex=1>
						<!---<option value="#comp_pronoun1#" selected="selected">#comp_pronoun1#</option>--->
						<option value="he"  <cfif isdefined('comp_pronoun1') AND comp_pronoun1 eq 'he'> selected="selected" </cfif>>he</option>
						<option value="she"  <cfif isdefined('comp_pronoun1') AND  comp_pronoun1 eq 'she'> selected="selected" </cfif>>she</option>
						<option value="they"  <cfif isdefined('comp_pronoun1') AND  comp_pronoun1 eq 'they'> selected="selected" </cfif>>they</option>				
					</select>
				</cfoutput>		
			<!---</cfif>--->
            


		</td>
		
		<td  align="right" class=TextMaingr>AJ Last Name </td>
		<td ><cfinput type="text" size="40" name="aj_lname"  value="#aj_lname#" maxlength="40"  tabindex=29> </td>
	</tr>			


	<tr>
		<td  align="right" class=TextMaingr>his / her / their </td>
		<td >
			
<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="comp_pronoun2" size="1" tabindex=3>
						<!---<option value="">Select One...</option>		--->	
						<option value="his">his</option>
						<option value="her" >her</option>
						<option value="their" >their</option>					
				</select>
			<cfelse>
				<cfoutput>
					<select name="comp_pronoun2" size="1" tabindex=1>
						<option value="#comp_pronoun2#" selected="selected">#comp_pronoun2#</option>
						<option value="his">his</option>
						<option value="her" >her</option>
						<option value="their" >their</option>				
					</select>
				</cfoutput>		
			</cfif>	--->
            
<!---            <cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="comp_pronoun2" size="1" tabindex=3>
						<!---<option value="">Select One...</option>		--->	
						<option value="his">his</option>
						<option value="her" >her</option>
						<option value="their" >their</option>					
				</select>
			<cfelse>--->
				<cfoutput>
					<select name="comp_pronoun2" size="1" tabindex=1>
						<!---<option value="#comp_pronoun2#" selected="selected">#comp_pronoun2#</option>--->
						<option value="his" <cfif isdefined('comp_pronoun2') AND  comp_pronoun2 eq 'his'>selected="selected" </cfif>>his</option>
						<option value="her"  <cfif  isdefined('comp_pronoun2') AND comp_pronoun2 eq 'her'>selected="selected" </cfif>>her</option>
						<option value="their" <cfif  isdefined('comp_pronoun2') AND comp_pronoun2 eq 'their'>selected="selected" </cfif>>their</option>				
					</select>
				</cfoutput>		
			<!---</cfif>	--->		

		</td>
		
		<td  width=10% align="right" class=TextMaingr>AJ Title </td>
		<td >
<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="aj_title" size="1" tabindex=30>
						<!---<option value="">Select One...</option>		--->	
						<option value="Administrative Judge">Administrative Judge</option>
						<option value="Supervisory Administrative Judge" >Supervisory Administrative Judge</option>
						<option value="Chief Administrative Judge">Chief Administrative Judge</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="aj_title" size="1" tabindex=35>
							<option value="#aj_title#" selected="selected">#aj_title#</option>				
							<option value="Administrative Judge">Administrative Judge</option>
							<option value="Supervisory Administrative Judge" >Supervisory Administrative Judge</option>
							<option value="Chief Administrative Judge">Chief Administrative Judge</option>							
					</select>
				</cfoutput>		
			</cfif>	--->
            
            
<!---            <cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="aj_title" size="1" tabindex=30>
						<!---<option value="">Select One...</option>		--->	
						<option value="Administrative Judge">Administrative Judge</option>
						<option value="Supervisory Administrative Judge" >Supervisory Administrative Judge</option>
						<option value="Chief Administrative Judge">Chief Administrative Judge</option>
				</select>
			<cfelse>--->
				<cfoutput>
					<select name="aj_title" size="1" tabindex=35>
							<!---<option value="#aj_title#" selected="selected">#aj_title#</option>--->				
							<option value="Administrative Judge"<cfif isdefined('aj_title') AND aj_title eq 'Administrative Judge'>selected="selected" </cfif>>Administrative Judge</option>
							<option value="Supervisory Administrative Judge" <cfif isdefined('aj_title') AND  aj_title eq 'Supervisory Administrative Judge'>selected="selected" </cfif>>Supervisory Administrative Judge</option>
							<option value="Chief Administrative Judge"<cfif isdefined('aj_title') AND  aj_title eq 'Chief Administrative Judge'>selected="selected" </cfif>>Chief Administrative Judge</option>							
					</select>
				</cfoutput>		
			<!---</cfif>--->		
		</td>		
	</tr>		


	<tr>
		<td align="right" class=TextMaingr>Complainant EID </td>
		<td ><cfinput type="text" size="9" name="comp_eid"  value="#comp_eid#" maxlength="8"  tabindex=4> </td>
		
		<td align="right" class=TextMaingr>AJ Address </td>
		<td width= 20%><cfinput type="text" size="40" name="aj_addr"  value="#aj_addr#" maxlength="80" tabindex=31 > </td>		
	</tr>

	<tr>
		<td align="right" class=TextMaingr>Complainant SSN </td>
		<td ><cfinput type="text" size="10" name="comp_ssn"  value="#comp_ssn#" maxlength="9"  tabindex=5> </td>
		
		<td align="right" class=TextMaingr>AJ City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="aj_city"  value="#aj_city#" maxlength="20" tabindex=32>&nbsp;State&nbsp;<cfinput type="text" size="2" name="aj_state"  value="#aj_state#" maxlength="2" tabindex=33> &nbsp;Zip&nbsp;<cfinput type="text" size="11" name="aj_zip"  value="#aj_zip#" maxlength="10" tabindex=34> </td>
		
	</tr>

	<tr>
		<td align="right" class=TextMaingr>Complainant First Name </td>
		<td ><cfinput type="text" size="40" name="comp_fname"  value="#comp_fname#" maxlength="40"  tabindex=6> </td>
		
		<td  width=10% align="right" class=TextMaingr>EEOC Office </td>
		<td >
<!---		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="eeoc_office" size="1" tabindex=35>
					<option value="Chicago District">Chicago District</option>
					<option value="Los Angeles District">Los Angeles District</option>
					<option value="San Francisco District" >San Francisco District</option>
					<option value="Phoenix District" >Phoenix District</option>					
					<option value="Albuquerque District" >Albuquerque District</option>					
					<option value="Denver Field Office" >Denver Field Office</option>		
					<option value="St. Louis District" >St. Louis District</option>	
					<option value="Minneapolis Area Office" >Minneapolis Area Office</option>
					<option value="Seattle Field Office">Seattle Field Office</option>
					<option value="New Orleans Field Office">New Orleans Field Office</option>
					<option value="Houston District">Houston District</option>
			</select>
		<cfelse>
		<cfoutput>
			<select name="eeoc_office" size="1" tabindex=35>
					<option value="#eeoc_office#" selected="selected">#eeoc_office#</option>
					<option value="Chicago District">Chicago District</option>
					<option value="Los Angeles District">Los Angeles District</option>
					<option value="San Francisco District" >San Francisco District</option>					
					<option value="Phoenix District" >Phoenix District</option>
					<option value="Albuquerque District" >Albuquerque District</option>	
					<option value="Denver Field Office" >Denver Field Office</option>			
					<option value="St. Louis District" >St. Louis District</option>	
					<option value="Minneapolis Area Office" >Minneapolis Area Office</option>
					<option value="Seattle Field Office">Seattle Field Office</option>
					<option value="New Orleans Field Office">New Orleans Field Office</option>
					<option value="Houston District">Houston District</option>
				</select>
		</cfoutput>		
		</cfif>--->
        
<!---        		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="eeoc_office" size="1" tabindex=35>
					<option value="Chicago District">Chicago District</option>
					<option value="Los Angeles District">Los Angeles District</option>
					<option value="San Francisco District" >San Francisco District</option>
					<option value="Phoenix District" >Phoenix District</option>					
					<option value="Albuquerque District" >Albuquerque District</option>					
					<option value="Denver Field Office" >Denver Field Office</option>		
					<option value="St. Louis District" >St. Louis District</option>	
					<option value="Minneapolis Area Office" >Minneapolis Area Office</option>
					<option value="Seattle Field Office">Seattle Field Office</option>
					<option value="New Orleans Field Office">New Orleans Field Office</option>
					<option value="Houston District">Houston District</option>
			</select>
		<cfelse>--->
		<cfoutput>
			<select name="eeoc_office" size="1" tabindex=35>
					<!---<option value="#eeoc_office#" selected="selected">#eeoc_office#</option>--->
					<option value="Albuquerque District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Albuquerque District'>selected="selected" </cfif>>Albuquerque District</option>	
					<option value="Atlanta District Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Atlanta District Office'>selected="selected" </cfif>>Atlanta District Office</option>
					<option value="Baltimore Field Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Baltimore Field Office'>selected="selected" </cfif>>Baltimore Field Office</option>
					<option value="Birmingham District Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Birmingham District Office'>selected="selected" </cfif>>Birmingham District Office</option>
					<option value="Charlotte District Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Charlotte District Office'>selected="selected" </cfif>>Charlotte District Office</option>
					<option value="Chicago District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Chicago District'>selected="selected" </cfif>>Chicago District</option>
					<option value="Cleveland Field Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Cleveland Field Office'>selected="selected" </cfif>>Cleveland Field Office</option>
					<option value="Denver Field Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Denver Field Office'>selected="selected" </cfif>>Denver Field Office</option>
					<option value="Houston District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Houston District'>selected="selected" </cfif>>Houston District</option>
					<option value="Indianapolis District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Indianapolis District'>selected="selected" </cfif>>Indianapolis District</option>
					<option value="Los Angeles District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Los Angeles District'>selected="selected" </cfif>>Los Angeles District</option>
					<option value="Miami District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Miami District'>selected="selected" </cfif>>Miami District</option>
					<option value="Memphis District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Memphis District'>selected="selected" </cfif>>Memphis District</option>
					<option value="Milwaukee Area Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Milwaukee Area Office'>selected="selected" </cfif>>Milwaukee Area Office</option>
					<option value="Minneapolis Area Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Minneapolis Area Office'>selected="selected" </cfif>>Minneapolis Area Office</option>	
					<option value="New Orleans Field Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'New Orleans Field Office'>selected="selected" </cfif>>New Orleans Field Office</option>
					<option value="Philadelphia District Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Philadelphia District Office'>selected="selected" </cfif>>Philadelphia District Office</option>
					<option value="Phoenix District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Phoenix District'>selected="selected" </cfif>>Phoenix District</option>
					<option value="San Francisco District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'San Francisco District'>selected="selected" </cfif>>San Francisco District</option>
					<option value="Seattle Field Office" <cfif isdefined('eeoc_office') AND eeoc_office eq 'Seattle Field Office'>selected="selected" </cfif>>Seattle Field Office</option>
					<option value="St. Louis District" <cfif isdefined('eeoc_office') AND eeoc_office eq 'St. Louis District'>selected="selected" </cfif>>St. Louis District</option>	
					<option value="Washington Field Office"<cfif isdefined('eeoc_office') AND eeoc_office eq 'Washington Field Office'>selected="selected" </cfif>>Washington Field Office</option>
				</select>
		</cfoutput>		
		<!---</cfif>--->
		</td>
	</tr>
		

	<tr>
		<td align="right" class=TextMaingr>Complainant Last Name </td>
		<td ><cfinput type="text" size="40" name="comp_lname"  value="#comp_lname#" maxlength="40" tabindex=7 > </td>
		
		<td align="right" class=TextMaingr>AJ Phone </td>		
		<td ><cfinput type="text" size="15" name="aj_phone"  value="#aj_phone#" maxlength="15"  tabindex=36> </td>			
	</tr>

		
	<tr>
		<td align="right" class=TextMaingr>Complainant Address </td>
		<td ><cfinput type="text" size="40" name="comp_addr"  value="#comp_addr#" maxlength="80"  tabindex=8> </td>
		
		<td align="right" class=TextMaingr>AJ Fax </td>
		<td ><cfinput type="text" size="15" name="aj_fax"  value="#aj_fax#" maxlength="15"  tabindex=37> </td>		
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Complainant City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="comp_city"  value="#comp_city#" maxlength="20" tabindex=9>&nbsp;State&nbsp;<cfinput type="text" size="2" name="comp_state"  value="#comp_state#" maxlength="2" tabindex=10> &nbsp;Zip&nbsp;<cfinput type="text" size="11" name="comp_zip"  value="#comp_zip#" maxlength="10" tabindex=11> </td>

		<td  colspan=2 align="right" class=TextMaingr ><hr ></td>
	</tr>

		
	<tr>
		<td align="right" class=TextMaingr>Complainant Phone </td>
		<td ><cfinput type="text" size="15" name="comp_phone"  value="#comp_phone#" maxlength="15"  tabindex=12> </td>
		
		<td align="right" class=TextMaingr>LR Manager </td>
		<td >
			<!--- LR Managers Query--->
			<cfquery name="qry_lr_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'LRMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld
             </cfquery>
      
<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>      
				<select name="lr_mgr" tabindex=38>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_lr_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>
      	</select>
      <cfelse>

					<select name="lr_mgr" size="1" tabindex=35>
							<cfoutput>
							<option value="#lr_mgr#" selected="selected">#lr_mgr#</option>
							</cfoutput>
				     	<cfoutput query="qry_lr_mgr">
				        <option value="#name#" >#name#
				      </cfoutput>							
					</select>

      </cfif>--->
      
<!---      <cfif not qry_last_submitted_data.RecordCount gt 0>      
				<select name="lr_mgr" tabindex=38>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_lr_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>
      	</select>
      <cfelse>--->

					<select name="lr_mgr" size="1" tabindex=35>
<!---							<cfoutput>
							<option value="#lr_mgr#" selected="selected">#lr_mgr#</option>
							</cfoutput>--->
				     	<cfoutput query="qry_lr_mgr">
				        <option value="#name#" <cfif isdefined('lr_mgr') AND qry_lr_mgr.name eq lr_mgr>selected="selected" </cfif>>#name#
				      </cfoutput>							
					</select>

   <!---   </cfif>--->
      
      
      	
		 </td>
	</tr>

	

	<tr>
		<td align="right" class=TextMaingr>Complainant Facility </td>
		<td ><cfinput type="text" size="60" name="comp_facility"  value="#comp_facility#"  maxlength="70"  tabindex=13> </td>
		
		<td align="right" class=TextMaingr>HR Manager </td>		
		<td >                    
			<!--- HR Managers Query--->
			<cfquery name="qry_hr_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'HRMGR' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld
                </cfquery>			

<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="hr_mgr" tabindex=39>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_hr_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="hr_mgr" size="1" tabindex=39>
						<cfoutput>
						<option value="#hr_mgr#" selected="selected">#hr_mgr#</option>
						</cfoutput>
			     	<cfoutput query="qry_hr_mgr">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>

    	</cfif> --->
        
<!---        <cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="hr_mgr" tabindex=39>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_hr_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>    --->  
				<select name="hr_mgr" size="1" tabindex=39>
<!---						<cfoutput>
						<option value="#hr_mgr#" selected="selected">#hr_mgr#</option>
						</cfoutput>--->
			     	<cfoutput query="qry_hr_mgr">
			        <option value="#name#" <cfif isdefined('hr_mgr') AND qry_hr_mgr.name eq hr_mgr>selected="selected" </cfif>>#qry_hr_mgr.name#
			      </cfoutput>							
				</select>

    	<!---</cfif>  --->    
      	
		</td>	
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Complainant District </td>
		<td ><cfinput type="text" size="60" name="comp_district"  value="#comp_district#" maxlength="60" tabindex=14 > </td>
		
		<td align="right" class=TextMaingr>District Manager </td>
		<td >
		<!--- District Managers Query--->
			<cfquery name="qry_dist_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'DMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld 			</cfquery>
        
        
      
<!--- 			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
			<select name="dist_mgr" tabindex=40>
				<option value="">Select One...</option>
	     	<cfoutput query="qry_dist_mgr">
	        <option value="#name#" >--#name#
	      </cfoutput>
      </select>	
      <cfelse> --->     
				<select name="dist_mgr" size="1" tabindex=40>
						<!---<cfoutput>
						<option value="#dist_mgr#" selected="selected">#dist_mgr#</option>
						</cfoutput>--->
			     	<option value="">Select One...</option>
					<cfoutput query="qry_dist_mgr">
			        <option value='#name#' <cfif isdefined('dist_mgr') AND qry_dist_mgr.name eq dist_mgr> selected='selected'</cfif>>#name#</option>
			      </cfoutput>							
				</select>
<!--- </cfif>  --->
    	  
   
		</td>		
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Agency No. </td>
		<td ><cfinput type="text" size="25" name="agency_no"  value="#agency_no#" maxlength="25"  tabindex=15> </td>
		
		<td align="right" class=TextMaingr>H&R Mgr - District </td>
		<td >     
			<cfquery name="qry_hr_mgr_dist" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'HRDST' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld  			
			</cfquery>
           

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
			<select name="hr_mgr_dist" tabindex=41>
		
			  <option value="">Select One...</option>
				<cfoutput query="qry_hr_mgr_dist">
					<option value="#name#" >#name#</option>
				</cfoutput>
			</select>	
      <cfelse>      
				<select name="hr_mgr_dist" size="1" tabindex=39>
			<!---			<cfoutput>
						<option value="#hr_mgr_dist#" selected="selected">#hr_mgr_dist#</option>
						</cfoutput>--->
                     <option value="">Select One...</option>   
                        
			     	<cfoutput query="qry_hr_mgr_dist">
			        <option value="#name#" <cfif isdefined('hr_mgr_dist') AND qry_hr_mgr_dist.name eq hr_mgr_dist> selected='selected'</cfif> >#qry_hr_mgr_dist.name#</option>
			      </cfoutput>							
				</select>

    	</cfif>	  
   </td>		
	</tr>


	<tr>
		<td align="right" class=TextMaingr>EEOC No. </td>
				<td >
			<cfquery name="qry_eeoc_no" datasource="lawmanager">
 			select forum_number from forum where matter_key=#matterkey#  <!---and venue_type_key like '8%'--->
            </cfquery>

<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="eeoc_no" tabindex=16>
					<option value="Not Yet Assigned">Not Yet Assigned</option>
		     	<cfoutput query="qry_eeoc_no">
		        <option value="#forum_number#" >#forum_number#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="eeoc_no" size="1" tabindex=16>
						<cfoutput>
						<option value="#eeoc_no#" selected="selected">#eeoc_no#</option>
						</cfoutput>
			     	<cfoutput query="qry_eeoc_no">
			        <option value="#forum_number#" >#forum_number#
			      </cfoutput>							
				</select>
    	</cfif>	--->
        
        
     <cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="eeoc_no" tabindex=16>
					<option value="Not Yet Assigned">Not Yet Assigned</option>
		     	<cfoutput query="qry_eeoc_no">
		        <option value="#forum_number#" >#forum_number#
		      </cfoutput>
	      </select>	
      <cfelse>    
				<select name="eeoc_no" size="1" tabindex=16>
		<!---				<cfoutput>
						<option value="#eeoc_no#" selected="selected">#eeoc_no#</option>
						</cfoutput>--->
                       <option value="Not Yet Assigned">Not Yet Assigned</option> 
			     	<cfoutput query="qry_eeoc_no">
                    
			        <option value="#forum_number#" <cfif isdefined('ohna_dist') AND qry_eeoc_no.forum_number eq eeoc_no> selected='selected'</cfif>>#qry_eeoc_no.forum_number#
			      </cfoutput>							
				</select>
    </cfif>
		
		<td align="right" class=TextMaingr>OHNA - District </td>
		<td >
			<cfquery name="qry_ohna_dist" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'OHNA' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld 			</cfquery>

<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
			<select name="ohna_dist" tabindex=42>
				<option value="">Select One...</option>
	     	<cfoutput query="qry_ohna_dist">
	        <option value="#name#" >#name#
	      </cfoutput>
      </select>	
      <cfelse>      
				<select name="ohna_dist" size="1" tabindex=39>
						<cfoutput>
						<option value="#ohna_dist#" selected="selected">#ohna_dist#</option>
						</cfoutput>
			     	<cfoutput query="qry_ohna_dist">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>

    	</cfif>	--->
        
        
     <!---  <cfif not qry_last_submitted_data.RecordCount gt 0>    
      
			<select name="ohna_dist" tabindex=42>
				<option value="">Select One...</option>
	     	<cfoutput query="qry_ohna_dist">
	        <option value="#name#" >#name#
	      </cfoutput>
      </select>	
      <cfelse>   --->  
				<select name="ohna_dist" size="1" tabindex=39>
				<!---		<cfoutput>
						<option value="#ohna_dist#" selected="selected">#ohna_dist#</option>
						</cfoutput>--->
			     	<cfoutput query="qry_ohna_dist">
			        <option value="#name#" <cfif isdefined('ohna_dist') AND trim(qry_ohna_dist.name) eq trim(ohna_dist)> selected='selected'</cfif> >#name#</option>
			      </cfoutput>							
				</select>

    	<!---</cfif>	--->

		</td>		
	</tr>
 

	<tr>
		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>
		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>
	</tr>	



	<tr>
		<td  align="right" class=TextMaingr>Mr. / Ms. </td>
		<td tabindex=17>
		
<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="comp_rep_prefix" size="1" tabindex=17>
						<!---<option value="">Select One...</option>		--->	
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="comp_rep_prefix" size="1" tabindex=1>
							<option value="#comp_rep_prefix#" selected="selected">#comp_rep_prefix#</option>
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>				
					</select>
				</cfoutput>		
			</cfif>--->
            
            			<!---<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="comp_rep_prefix" size="1" tabindex=17>
						<!---<option value="">Select One...</option>		--->	
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>
				</select>
			<cfelse>--->
				<cfoutput>
					<select name="comp_rep_prefix" size="1" tabindex=1>
				<!---			<option value="#comp_rep_prefix#" selected="selected">#comp_rep_prefix#</option>--->
						<option value="Mr."<cfif isdefined('comp_rep_prefix') AND trim(comp_rep_prefix) eq 'Mr.'> selected='selected'</cfif>>Mr.</option>
						<option value="Ms." <cfif isdefined('comp_rep_prefix') AND trim(comp_rep_prefix) eq 'Ms.'> selected='selected'</cfif>>Ms.</option>				
					</select>
				</cfoutput>		
			<!---</cfif>---> 			





		</td>
		
		<td  width=10% align="right" class=TextMaingr>WO Office </td>
		<td width=30%>
			

            
<!---            <cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_office" size="1" tabindex=43>
					<option value="Long Beach">Long Beach</option>
					<option value="San Francisco" >San Francisco</option>
					<option value="San Diego">San Diego</option>
					<option value="Seattle Field Office">Seattle Field Office</option>
				</select>
			<cfelse>--->
				<cfoutput>
					<select name="alo_office" size="1" tabindex=43>
					<!---<option value="#alo_office#" selected="selected">#alo_office#</option>--->
					<option value="Denver"<cfif isdefined('alo_office') AND trim(alo_office) eq 'Denver'> selected='selected'</cfif>>Denver</option>
					<option value="Long Beach"<cfif isdefined('alo_office') AND trim(alo_office) eq 'Long Beach'> selected='selected'</cfif>>Long Beach</option>
					<option value="Miami"<cfif isdefined('alo_office') AND trim(alo_office) eq 'Miami'> selected='selected'</cfif>>Miami</option>
					<option value="Salt Lake" <cfif isdefined('alo_office') AND trim(alo_office) eq 'Salt Lake'> selected='selected'</cfif>>Salt Lake</option>
					<option value="San Diego"<cfif isdefined('alo_office') AND trim(alo_office) eq 'San Diego'> selected='selected'</cfif>>San Diego</option>
					<option value="San Francisco" <cfif isdefined('alo_office') AND trim(alo_office) eq 'San Francisco'> selected='selected'</cfif>>San Francisco</option>
						
					<option value="Seattle"<cfif isdefined('alo_office') AND trim(alo_office) eq 'Seattle'> selected='selected'</cfif>>Seattle</option>					
					</select>
				</cfoutput>				
			
			<!---</cfif>--->

		</td>				
	</tr>			


	<tr>
		<td align="right" class=TextMaingr>Comp. Rep. First Name </td>
		<td ><cfinput type="text" size="40" name="comp_rep_fname"  value="#comp_rep_fname#" maxlength="40"  tabindex=18> </td>
		
		<td align="right" class=TextMaingr>WO Address1 </td>
		<td>

<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr1" size=1 tabindex=43 >
					<!---<option value="">Select One...</option>	--->
					<option value="1745 Stout Street, Suite 500">1745 Stout Street, Suite 500</option>				
					<option value="300 Long Beach Blvd., Rm 240">300 Long Beach Blvd., Rm 240</option>
					<option value="9350 South 150 East, Suite 800" selected="selected">9350 South 150 East, Suite 800</option>
					<option value="11255 Rancho Carmel Dr., Rm 1440">11255 Rancho Carmel Dr., Rm 1440</option>
					<option value ="1300 Evans Ave PO Box 883790, Room 217">1300 Evans Ave PO Box 883790, Room 217</option>
					<option value ="PO Box 3686">PO Box 3686</option>

				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_addr1" size="1" tabindex=43 >
					<option value="#alo_addr1#" selected="selected">#alo_addr1#</option>
					<!---<option value="">Select One...</option>--->			
					<option value="300 Long Beach Blvd., Rm 240">300 Long Beach Blvd., Rm 240</option>
					<option value="1300 Evans Ave., Rm 217 P.O. Box 883790" >1300 Evans Ave., Rm 217 P.O. Box 883790</option>
					<!---<option value="P.O. Box 883790">P.O. Box 883790</option>--->				
					<option value="11255 Rancho Carmel Dr., Rm 1440">11255 Rancho Carmel Dr., Rm 1440</option>		
					<option value="909 First Avenue ##400">909 First Avenue ##400</option>
					</select>
				</cfoutput>				
			
			</cfif>--->
            
            
<!---            <cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr1" size=1 tabindex=43 >
					<!---<option value="">Select One...</option>	--->		
					<option value="300 Long Beach Blvd., Rm 240">300 Long Beach Blvd., Rm 240</option>
					<option value="1300 Evans Ave., Rm 217 P.O. Box 883790" selected="selected">1300 Evans Ave., Rm 217 P.O. Box 883790</option>
					<!---<option value="P.O. Box 883790">P.O. Box 883790</option>--->		
					<option value="11255 Rancho Carmel Dr., Rm 1440">11255 Rancho Carmel Dr., Rm 1440</option>
					<option value ="909 First Avenue #400">909 First Avenue #400</option>
				</select>
			<cfelse>--->
				<cfoutput>
					<select name="alo_addr1" size="1" tabindex=43 >
					<option value="1745 Stout Street, Suite 500"<cfif isdefined('alo_addr1') AND trim(alo_addr1) eq '1745 Stout Street, Suite 500'> selected='selected'</cfif>>1745 Stout Street, Suite 500</option>					
					<option value="300 Long Beach Blvd., Rm 240"<cfif isdefined('alo_addr1') AND trim(alo_addr1) eq '300 Long Beach Blvd., Rm 240'> selected='selected'</cfif>>
						300 Long Beach Blvd., Rm 240</option>
					<option value="Miami Tower 100 SE 2nd Street, Suite 1500"<cfif isdefined('alo_addr1') AND trim(alo_addr1) eq 'Miami Tower 100 SE 2nd Street, Suite 1500'> selected='selected'</cfif>>
						Miami Tower 100 SE 2nd Street, Suite 1500</option>
					<option value="9350 South 150 East, Suite 400"<cfif isdefined('alo_addr1') AND trim(alo_addr1) eq '9350 South 150 East, Suite 400'> selected='selected'</cfif>>9350 South 150 East, Suite 400</option>
					<option value="11255 Rancho Carmel Dr., Rm 1440"<cfif isdefined('alo_addr1') AND trim(alo_addr1) eq '11255 Rancho Carmel Dr., Rm 1440'> selected='selected'</cfif>>
						11255 Rancho Carmel Dr., Rm 1440</option>
					<option value="1300 Evans Ave., Rm 217"<cfif isdefined('alo_addr1') AND trim(alo_addr1) eq '1300 Evans Ave., Rm 217'> selected='selected'</cfif>>
						1300 Evans Ave., Rm 217</option>		
					<option value="P.O. Box 3686"<cfif isdefined('alo_addr1') AND trim(alo_addr1) eq 'P.O. Box 3686'> selected='selected'</cfif>>
						P.O. Box 3686</option>
					</select>
				</cfoutput>				
			
			<!---</cfif>	--->	

		</td>			
	</tr>
		


	<tr>
		<td align="right" class=TextMaingr>Comp. Rep. Last Name </td>
		<td ><cfinput type="text" size="40" name="comp_rep_lname"  value="#comp_rep_lname#" maxlength="40"  tabindex=19> </td>
		
		<td align="right" class=TextMaingr>WO  Address2 </td>
		<td>
			
<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr2" size="1" tabindex=45>
					<option value="">Select One...</option>		
					<option value="Denver, CO 80299-5555">Denver, CO 80299-5555</option>
					<option value="Long Beach, CA 90802-2496" selected="selected">Long Beach, CA 90802-2496</option>
					<option value="Sandy, Ut 84070-2716">Sandy, Ut 84070-2716</option>
					<option value="San Diego, CA 92197-4400">San Diego, CA 92197-4400</option>
					<option value="San Francisco, CA 94188-3790">San Francisco, CA 94188-3790</option>
					<option value="Seattle, WA 98124-3686">Seattle, WA 98124-3686</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_addr2" size="1" tabindex=45>
					<option value="Denver, CO 80299-5555">Denver, CO 80299-5555</option>
					<option value="Long Beach, CA 90802-2496" selected="selected">Long Beach, CA 90802-2496</option>
					<option value="Sandy, Ut 84070-2716">Sandy, Ut 84070-2716</option>
					<option value="San Diego, CA 92197-4400">San Diego, CA 92197-4400</option>
					<option value="San Francisco, CA 94188-3790">San Francisco, CA 94188-3790</option>
					<option value="Seattle, WA 98124-3686">Seattle, WA 98124-3686</option>
					</select>
				</cfoutput>				
			
			</cfif>--->
            
<!---            <cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr2" size="1" tabindex=45>
					<option value="">Select One...</option>		
					<option value="Long Beach, CA 90802-2496">Long Beach, CA 90802-2496</option>
					<option value="San Francisco, CA 94188-3790" selected="selected">San Francisco, CA 94188-3790</option>
					<option value="San Diego, CA 92197-4400">San Diego, CA 92197-4400</option>
					<option value="Seattle, WA 98104">Seattle, WA 98104</option>
				</select>
			<cfelse>--->
				<cfoutput>
					<select name="alo_addr2" size="1" tabindex=45>
					<!---<option value="#alo_addr2#" selected="selected">#alo_addr2#</option>--->			
						<option value="Denver, CO 80299-5555"<cfif isdefined('alo_addr2') AND trim(alo_addr2) eq 'Denver, CO 80299-5555'> selected='selected'</cfif>>Denver, CO 80299-555</option>					
						<option value="Long Beach, CA 90802-2496"<cfif isdefined('alo_addr2') AND trim(alo_addr2) eq 'Long Beach, CA 90802-2496'> selected='selected'</cfif>>
							Long Beach, CA 90802-2496</option>
						<option value="Miami, FL 33131"<cfif isdefined('alo_addr2') AND trim(alo_addr2) eq 'Miami, FL 33131'> selected='selected'</cfif>>
							Miami, FL 33131</option>
						<option value="Sandy, UT 84070-2773"<cfif isdefined('alo_addr2') AND trim(alo_addr2) eq 'Sandy, UT 84070-2773'> selected='selected'</cfif>>Sandy, UT 84070-2773</option>
						<option value="San Diego, CA 92197-4400"<cfif isdefined('alo_addr2') AND trim(alo_addr2) eq 'San Diego, CA 92197-4400'> selected='San Diego, CA 92197-4400'</cfif>>
							San Diego, CA 92197-4400</option>	
						<option value="San Francisco, CA 94188-3790"<cfif isdefined('alo_addr2') AND trim(alo_addr2) eq 'San Francisco, CA 94188-3790'> selected='selected'</cfif>>
							San Francisco, CA 94188-3790</option>
						<option value="Seattle, WA 98124-3686"<cfif isdefined('alo_addr2') AND trim(alo_addr2) eq 'Seattle, WA 98124-3686'> selected='selected'</cfif>>
							Seattle, WA 98124-3686</option>
					</select>
				</cfoutput>				
			
		<!---	</cfif>	--->			

		</td>		
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Comp. Rep. Company</td>
		<td ><cfinput type="text" size="25" name="comp_rep_comp"  value="#comp_rep_comp#" maxlength="25"  tabindex=20> </td>

		<td  width=10% align="right" class=TextMaingr>Attorney </td>
		<td width=30%>
			<cfquery name="qry_attorney" datasource="lawmanager">
				select b.entity_key, b.attorney_name as name 
				from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'ATTNY' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld
             </cfquery>

<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="attorney_name" tabindex=46>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_attorney">
		        <option value="#name#" >#name#</option>
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="attorney_name" size="1" tabindex=46>
				<!---
				
				Commented out.  It was causing erronous name  8/1/2019
						<cfoutput>
						<option value="#attorney_name#" selected="selected">#attorney_name#</option>
						</cfoutput>
						
				--->		
			     	<cfoutput query="qry_attorney">
			        <option value="#name#" >#name#</option>
			      </cfoutput>							
				</select>
    	</cfif>	--->
        
<!---       <cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="attorney_name" tabindex=46>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_attorney">
		        <option value="#name#" >#name#</option>
		      </cfoutput>
	      </select>	
      <cfelse> --->     
				<select name="attorney_name" size="1" tabindex=46>
				<!---
				
				Commented out.  It was causing erronous name  8/1/2019
						<cfoutput>
						<option value="#attorney_name#" selected="selected">#attorney_name#</option>
						</cfoutput>
						
				--->		
			     	<cfoutput query="qry_attorney">
			        <option value="#name#"<cfif isdefined('attorney_name') AND trim(attorney_name) eq qry_attorney.name> selected='selected'</cfif>>#qry_attorney.name#</option>
			      </cfoutput>							
				</select>
    	<!---</cfif>	--->
		</td>	
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Comp. Rep. Address </td>
		<td ><cfinput type="text" size="40" name="comp_rep_addr"  value="#comp_rep_addr#" maxlength="80" tabindex=21 > </td>
		
		<td  width=10% align="right" class=TextMaingr>Attorney Title</td>
		<td width=30%>

<!---		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="attorney_title" size="1" tabindex=47>
					<option value="">Select One...</option>		
					<option value="Attorney">Attorney</option>						
					<option value="Senior Litigation Counsel">Senior Litigation Counsel</option>
					<option value="Managing Counsel" >Managing Counsel</option>
					<option value="Deputy Managing Counsel">Deputy Managing Counsel</option
			></select>
		<cfelse>
			<cfoutput>
						<select name="attorney_title" size="1" tabindex=47>
						<option value="#attorney_title#" selected="selected">#attorney_title#</option>	
						<option value="Attorney">Attorney</option>						
						<option value="Senior Litigation Counsel">Senior Litigation Counsel</option>
						<option value="Managing Counsel" >Managing Counsel</option>
						<option value="Deputy Managing Counsel">Deputy Managing Counsel</option					
				></select>
			</cfoutput>		
		</cfif>--->
        
<!---        <cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="attorney_title" size="1" tabindex=47>
					<option value="">Select One...</option>		
					<option value="Attorney">Attorney</option>						
					<option value="Senior Litigation Counsel">Senior Litigation Counsel</option>
					<option value="Managing Counsel" >Managing Counsel</option>
					<option value="Deputy Managing Counsel">Deputy Managing Counsel</option
			></select>
		<cfelse>--->
			<cfoutput>
						<select name="attorney_title" size="1" tabindex=47>
						<!---<option value="#attorney_title#" selected="selected">#attorney_title#</option>	--->
						<option value="Attorney"<cfif isdefined('attorney_title') AND trim(attorney_title) eq 'Attorney'> selected='selected'</cfif>>Attorney</option>						
						<option value="Senior Litigation Counsel"<cfif isdefined('attorney_title') AND trim(attorney_title) eq 'Senior Litigation Counsel'> selected='selected'</cfif>>
                        Senior Litigation Counsel</option>
						<option value="Managing Counsel"<cfif isdefined('attorney_title') AND trim(attorney_title) eq 'Managing Counsel'> selected='selected'</cfif>>
                        Managing Counsel</option>
						<option value="Deputy Managing Counsel"<cfif isdefined('attorney_title') AND trim(attorney_title) eq 'Deputy Managing Counsel'> selected='selected'</cfif>>
                        Deputy Managing Counsel</option					
				></select>
			</cfoutput>		
		<!---</cfif>--->

		</td>	
	</tr>		



	<tr>
		<td align="right" class=TextMaingr>Comp. Rep. City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="comp_rep_city"  value="#comp_rep_city#" maxlength="20" tabindex=22>&nbsp;State&nbsp;
		<cfinput type="text" size="2" name="comp_rep_state"  value="#comp_rep_state#" maxlength="2" tabindex=23> &nbsp;Zip&nbsp;
		<cfinput type="text" size="11" name="comp_rep_zip"  value="#comp_rep_zip#" maxlength="12" tabindex=24> 
		</td>
			
		<td  width=10% align="right" class=TextMaingr>Paralegal </td>
		<td width=30%>
			<cfquery name="qry_paralgl" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'PLGL' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld  			
			</cfquery>

<!---			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="paralgl_name" tabindex=48>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_paralgl">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="paralgl_name" size="1" tabindex=48>
						<cfoutput>
						<option value="#paralgl_name#" selected="selected">#paralgl_name#</option>
						</cfoutput>
			     	<cfoutput query="qry_paralgl">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>

    	</cfif> --->
        
<!---       <cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="paralgl_name" tabindex=48>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_paralgl">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>  --->    
				<select name="paralgl_name" size="1" tabindex=48>
<!---						<cfoutput>
						<option value="#paralgl_name#" selected="selected">#paralgl_name#</option>
						</cfoutput>--->
			     	<cfoutput query="qry_paralgl">
			        <option value="#name#"<cfif isdefined('paralgl_name') AND trim(qry_paralgl.name) eq paralgl_name> selected='selected'</cfif>>#name#</option>
			      </cfoutput>							
				</select>

    	<!---</cfif> --->     

		</td>			
	</tr>


	
	<tr>
		<td align="right" class=TextMaingr>Comp. Rep. Phone </td>
		<td ><cfinput type="text" size="15" name="comp_rep_phone"  value="#comp_rep_phone#" maxlength="15"  tabindex=26> </td>
		
		<td align="right" class=TextMaingr>WO Phone </td>
		<td>
        
<!---        <cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_phone" size="1" tabindex=49>
					<option value="">Select One...</option>			
					<option value="(562) 628-1340">(562) 628-1340</option>
					<option value="(415) 550-5300">(415) 550-5300</option>
					<option value="(858) 674-2738">(858) 674-2738</option>
			</select>
		<cfelse>
		<cfoutput>
			<select name="alo_phone" size="1" tabindex=49>
					<option value="#alo_phone#" selected="selected">#alo_phone#</option>	
					<option value="(562) 628-1340">(562) 628-1340</option>
					<option value="(415) 550-5300">(415) 550-5300</option>
					<option value="(858) 674-2738">(858) 674-2738</option>					
			</select>
		</cfoutput>		
		</cfif>	--->

<!---		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_phone" size="1" tabindex=49>
					<option value="">Select One...</option>			

			</select>
		<cfelse>--->
		<cfoutput>
			<select name="alo_phone" size="1" tabindex=49>
					<!---<option value="#alo_phone#" selected="selected">#alo_phone#</option>--->	
				
				<option value="(206) 381-6620"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(206) 381-6620'> selected='selected'</cfif>>(206) 381-6620</option>
				<option value="(206) 381-6624"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(206) 381-6624'> selected='selected'</cfif>>(206) 381-6624</option>
				<option value="(206) 381-6623"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(206) 381-6623'> selected='selected'</cfif>>(206) 381-6623</option>
				<option value="(206) 381-6625"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(206) 381-6625'> selected='selected'</cfif>>(206) 381-6625</option>
				<option value="(206) 381-6626"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(206) 381-6626'> selected='selected'</cfif>>(206) 381-6626</option>
				<option value="(206) 381-6628"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(206) 381-6628'> selected='selected'</cfif>>(206) 381-6628</option>
				<option value="(206) 381-6630"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(206) 381-6630'> selected='selected'</cfif>>(206) 381-6630</option>
				<option value="(303) 313-5560"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(303) 313-5560'> selected='selected'</cfif>>(303) 313-5560</option>
				<option value="(303) 313-5567"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(303) 313-5567'> selected='selected'</cfif>>(303) 313-5569</option>
				<option value="(303) 313-5576"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(303) 313-5576'> selected='selected'</cfif>>(303) 313-5576</option>
				<option value="(303) 313-5577"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(303) 313-5577'> selected='selected'</cfif>>(303) 313-5577</option>
				<option value="(303) 313-5579"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(303) 313-5579'> selected='selected'</cfif>>(303) 313-5579</option>
				<option value="(303) 313-5791"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(303) 313-5791'> selected='selected'</cfif>>(303) 313-5791</option>
				<option value="(415) 550-5300"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(415) 550-5300'> selected='selected'</cfif>>(415) 550-5300</option>
				<option value="(415) 550-5381"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(415) 550-5381'> selected='selected'</cfif>>(415) 550-5381</option>
				<option value="(415) 550-5397"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(415) 550-5397'> selected='selected'</cfif>>(415) 550-5397</option>
				<option value="(415) 550-5473"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(415) 550-5473'> selected='selected'</cfif>>(415) 550-5473</option>
				<option value="(415) 550-5493"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(415) 550-5493'> selected='selected'</cfif>>(415) 550-5493</option>
				<option value="(415) 550-5495"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(415) 550-5495'> selected='selected'</cfif>>(415) 550-5495</option>
				<option value="(562) 628-1340"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1340'> selected='selected'</cfif>>(562) 628-1340</option>
				<option value="(562) 628-1344"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1344'> selected='selected'</cfif>>(562) 628-1344</option>
				<option value="(562) 628-1345"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1345'> selected='selected'</cfif>>(562) 628-1345</option>
				<option value="(562) 628-1346"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1346'> selected='selected'</cfif>>(562) 628-1346</option>
				<option value="(562) 628-1347"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1347'> selected='selected'</cfif>>(562) 628-1347</option>
				<option value="(562) 628-1350"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1350'> selected='selected'</cfif>>(562) 628-1350</option>
				<option value="(562) 628-1351"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1351'> selected='selected'</cfif>>(562) 628-1351</option>
				<option value="(562) 628-1354"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1354'> selected='selected'</cfif>>(562) 628-1354</option>
				<option value="(562) 628-1357"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(562) 628-1357'> selected='selected'</cfif>>(562) 628-1357</option>
				<option value="(801) 984-8400"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(801) 984-8400'> selected='selected'</cfif>>(801) 984-8400</option>
				<option value="(801) 984-8403"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(801) 984-8403'> selected='selected'</cfif>>(801) 984-8403</option>
				<option value="(801) 984-8404"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(801) 984-8404'> selected='selected'</cfif>>(801) 984-8404</option>
				<option value="(801) 984-8420"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(801) 984-8420'> selected='selected'</cfif>>(801) 984-8420</option>
				<option value="(801) 984-8423"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(801) 984-8423'> selected='selected'</cfif>>(801) 984-8423</option>
				<option value="(801) 984-8428"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(801) 984-8428'> selected='selected'</cfif>>(801) 984-8428</option>
				<option value="(801) 984-8432"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(801) 984-8432'> selected='selected'</cfif>>(801) 984-8432</option>
				<option value="(858) 674-2686"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(858) 674-2686'> selected='selected'</cfif>>(858) 674-2686</option>
				<option value="(858) 674-2738"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(858) 674-2738'> selected='selected'</cfif>>(858) 674-2738</option>
				<option value="(858) 674-2742"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(858) 674-2742'> selected='selected'</cfif>>(858) 674-2742</option>
				<option value="(858) 674-2748"<cfif isdefined('alo_phone') AND trim(alo_phone) eq '(858) 674-2748'> selected='selected'</cfif>>(858) 674-2748</option>	
			</select>
		</cfoutput>		
		<!---</cfif>--->		

		</td>		
	</tr>
	
		<tr>
		<td align="right" class=TextMaingr>Comp. Rep. Fax </td>
		<td ><cfinput type="text" size="15" name="comp_rep_fax"  value="#comp_rep_fax#" maxlength="15"  tabindex=27> </td>
		
		<td align="right" class=TextMaingr>WO Fax </td>
		<td>

		<cfoutput>
			<select name="alo_fax" size="1" tabindex=50>
				<!--- <option value="#alo_fax#" selected="selected">#alo_fax#</option> --->
				<option value="(303) 313-5561"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(303) 313-5561'> selected='selected'</cfif>>(303) 313-5561</option>
				<option value="(650) 357-6705"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(650) 357-6705'> selected='selected'</cfif>>(650) 357-6705</option>
				<option value="(650) 357-6336"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(650) 357-6336'> selected='selected'</cfif>>(650) 357-6336</option>
				<option value="(801) 984-8402"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(801) 984-8402'> selected='selected'</cfif>>(801) 984-8402</option>
				<option value="(650) 578-1817"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(650) 578-1817'> selected='selected'</cfif>>(650) 578-1817</option>
				<option value="(650) 578-3806"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(650) 578-3806'> selected='selected'</cfif>>(650) 578-3806</option>
				<option value="(650) 577-5679"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(650) 577-5679'> selected='selected'</cfif>>(650) 577-5679</option>
				<option value="(206) 381-6621"<cfif isdefined('alo_fax') AND trim(alo_fax) eq '(206) 381-6621'> selected='selected'</cfif>>(206) 381-6621</option>					
			</select>
		</cfoutput>		
			

		</td>			
	</tr>


		<tr>	
		<td>&nbsp;
		<td>	
		<td align="right" class=TextMaingr >Legal Admin. Assistant </td>
		<td>
        
		<cfoutput>
			<select name="admin_assist" size="1" tabindex=51>
					<!---<option value="#admin_assist#" selected="selected">#admin_assist#</option>--->
					<option value="Shelley Bormann"<cfif isdefined('admin_assist') AND  trim(admin_assist) eq 'Shelley Bormann'> selected='selected'</cfif>>Shelley Bormann</option>
					<option value="Wilma Bray"<cfif isdefined('admin_assist') AND  trim(admin_assist) eq 'Wilma Bray'> selected='selected'</cfif>>Wilma Bray</option>
					<option value="Shana Brown-Spates"<cfif isdefined('admin_assist') AND trim(admin_assist) eq 'Shana Brown-Spates'> selected='selected'</cfif>>Shana Brown-Spates</option>	
					<option value="Tia Johnstun"<cfif isdefined('admin_assist') AND  trim(admin_assist) eq 'Tia Johnstun'> selected='selected'</cfif>>Tia Johnstun</option>
					<option value="Carol Lalor"<cfif isdefined('admin_assist') AND  trim(admin_assist) eq 'Carol Lalor'> selected='selected'</cfif>>Carol Lalor</option>
					<option value="Janet Huimin Luo"<cfif isdefined('admin_assist') AND  trim(admin_assist) eq 'Janet Huimin Luo'> selected='selected'</cfif>>Janet Huimin Luo</option>
					<option value="Vivienne Hansen"<cfif isdefined('admin_assist') AND trim(admin_assist) eq 'Vivienne Hansen'> selected='selected'</cfif>>Vivienne Hansen</option>
					<option value="Alvin Samonte"<cfif isdefined('admin_assist') AND trim(admin_assist) eq 'Alvin Samonte'> selected='selected'</cfif>>Alvin Samonte</option>									
			</select>
		</cfoutput>			
			
		</td>
		<tr/>


	<tr>
		<td colspan=5 align=middle><br><br><input type="image" src="img/save_continue1.gif" border=0  value="submit"  tabindex=52>	</td>



</table>
</div>
</cfform>
</body>
</html>
