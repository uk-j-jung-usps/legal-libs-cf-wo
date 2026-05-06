
<cfinclude template = "submitted.data.mspb.cfm"><!--- grab last submitted data from cmft_matterkey_pairs table--->
<cfinclude template = "admin.judge.data.cfm">
<cfinclude template = "appellant.data.cfm">
<cfinclude template = "appellant.rep.data.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Legal Libs Templates - MSPB</title>
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

<cfoutput>
<input name="matterkey" type="hidden" value="#url.matterkey#" >
<input name="matternumber" type="hidden" value="#url.matternumber#" >			
<input name="mattertypekey" type="hidden" value="#url.mattertypekey#" >
</cfoutput>

<div class="styleSelect">	

<table align="center" width="85%" border="0" cellspacing="1" cellpadding="1" bgcolor="#ffffff" >


	<tr>
	<td colspan=3 class=TextMaingrcolapan=5 bgcolor="#D9E9EA"> <a href="case.files.home.cfm"> Home </a> &nbsp;&nbsp;&nbsp;
	<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D<cfoutput>#matterkey#</cfoutput>" target="_blank"> LawManager</a> &nbsp;&nbsp;&nbsp;
	<a href="admin.pages.cfm"> Legal Libs Admin </a>
	<td align=right class=TextMaingrcolapan=5 bgcolor="#D9E9EA">	WLO- MSPB		

	<tr>
	<td>  <br><br>
	</td>


	<tr>
		<td  width=15% align="right" class=TextMaingr >Mr. / Ms. </td>
		<td>

			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="appellant_prefix" size="1" tabindex=1>
						<!---<option value="">Select One...</option>		--->	
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="appellant_prefix" size="1" tabindex=1>
							<option value="#appellant_prefix#" selected="selected">#appellant_prefix#</option>
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>				
					</select>
				</cfoutput>		
			</cfif>
		</td>


		<td  align="right" class=TextMaingr>AJ First Name </td>
		<td ><cfinput type="text" size="40" name="aj_fname"  value="#aj_fname#" maxlength="40"  tabindex=28> </td>		
	</tr>			


	<tr>
		<td  align="right" class=TextMaingr >he / she / they </td>
		<td>

			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="appellant_pronoun1" size="1" tabindex=2>
						<!---<option value="">Select One...</option>		--->	
						<option value="he">he</option>
						<option value="she" >she</option>
						<option value="they" >they</option>					
				</select>
			<cfelse>
				<cfoutput>
					<select name="appellant_pronoun1" size="1" tabindex=1>
						<option value="#appellant_pronoun1#" selected="selected">#appellant_pronoun1#</option>
						<option value="he">he</option>
						<option value="she" >sShe</option>
						<option value="they" >they</option>				
					</select>
				</cfoutput>		
			</cfif>

		</td>


		<td  align="right" class=TextMaingr>AJ Last Name </td>
		<td ><cfinput type="text" size="40" name="aj_lname"  value="#aj_lname#" maxlength="40"  tabindex=29> </td>
	</tr>


	<tr>
		<td  align="right" class=TextMaingr>his / her / their </td>
		<td >
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="appellant_pronoun2" size="1" tabindex=3>
						<!---<option value="">Select One...</option>		--->	
						<option value="his">his</option>
						<option value="her" >her</option>
						<option value="their" >their</option>					
				</select>
			<cfelse>
				<cfoutput>
					<select name="appellant_pronoun2" size="1" tabindex=1>
						<option value="#appellant_pronoun2#" selected="selected">#appellant_pronoun2#</option>
						<option value="his">his</option>
						<option value="her" >her</option>
						<option value="their" >their</option>				
					</select>
				</cfoutput>		
			</cfif>			

		</td>


		<td  width=10% align="right" class=TextMaingr>AJ Title </td>
		<td >
			<cfif not qry_last_submitted_data.RecordCount gt 0>
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
			</cfif>			
		</td>		
	</tr>	


	<tr>
		<td align="right" class=TextMaingr>Appellant EID </td>
		<td ><cfinput type="text" size="9" name="appellant_eid"  value="#appellant_eid#" maxlength="8"  tabindex=4> </td>
		
		<td align="right" class=TextMaingr>AJ Address </td>
		<td width= 20%><cfinput type="text" size="40" name="aj_addr"  value="#aj_addr#" maxlength="80" tabindex=31 > </td>		
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Appellant SSN </td>
		<td ><cfinput type="text" size="10" name="appellant_ssn"  value="#appellant_ssn#" maxlength="9"  tabindex=5> </td>
		
		<td align="right" class=TextMaingr>AJ City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="aj_city"  value="#aj_city#" maxlength="20" tabindex=32>&nbsp;State&nbsp;<cfinput type="text" size="2" name="aj_state"  value="#aj_state#" maxlength="2" tabindex=33> &nbsp;Zip&nbsp;<cfinput type="text" size="11" name="aj_zip"  value="#aj_zip#" maxlength="10" tabindex=34> </td>
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Appellant First Name </td>
		<td ><cfinput type="text" size="40" name="appellant_fname"  value="#appellant_fname#" maxlength="40"  tabindex=6> </td>
		
		<td  width=10% align="right" class=TextMaingr>MSPB Office </td>
		<td >
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="mspb_office" size="1" tabindex=35>
					<option value="Western Regional Office" selected="selected">Western Regional Office</option>
					<option value="Denver Field Office" selected="selected">Denver Field Office</option>						
					<option value="Los Angeles District">Los Angeles District</option>
					<option value="San Francisco District" >San Francisco District</option> 
					
			</select>
		<cfelse>
		<cfoutput>
			<select name="mspb_office" size="1" tabindex=35>
					<option value="#mspb_office#" selected="selected">#mspb_office#</option>
					<option value="Western Regional Office">Western Regional Office</option>
					<option value="Denver Field Office" selected="selected">Denver Field Office</option>								
					<option value="Los Angeles District">Los Angeles District</option>
					<option value="San Francisco Distrcit" >San Francisco District</option>	
									
			</select>
		</cfoutput>		
		</cfif>
		</td>
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Appellant Last Name </td>
		<td ><cfinput type="text" size="40" name="appellant_lname"  value="#appellant_lname#" maxlength="40" tabindex=7 > </td>
		
		<td align="right" class=TextMaingr>AJ Phone </td>
		<td ><cfinput type="text" size="15" name="aj_phone"  value="#aj_phone#" maxlength="15"  tabindex=36> </td>			
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Appellant Address </td>
		<td ><cfinput type="text" size="40" name="appellant_addr"  value="#appellant_addr#" maxlength="80"  tabindex=8> </td>
		
		<td align="right" class=TextMaingr>AJ Fax </td>
		<td ><cfinput type="text" size="15" name="aj_fax"  value="#aj_fax#" maxlength="15"  tabindex=37> </td>		
	</tr>

	<tr>
		<td align="right" class=TextMaingr>Appellant City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="appellant_city"  value="#appellant_city#" maxlength="20" tabindex=9>&nbsp;State&nbsp;<cfinput type="text" size="2" name="appellant_state"  value="#appellant_state#" maxlength="2" tabindex=10> &nbsp;Zip&nbsp;<cfinput type="text" size="11" name="appellant_zip"  value="#appellant_zip#" maxlength="10" tabindex=11> </td>

		<td  colspan=2 align="right" class=TextMaingr ><hr ></td>
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Appellant Phone </td>
		<td ><cfinput type="text" size="15" name="appellant_phone"  value="#appellant_phone#" maxlength="15"  tabindex=12> </td>
		
		<td align="right" class=TextMaingr>LR Manager </td>
		<td >
			<cfquery name="qry_lr_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'LRMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>
      
			<cfif not qry_last_submitted_data.RecordCount gt 0>      
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

      </cfif>		
		 </td>
	</tr>




	<tr>
		<td align="right" class=TextMaingr>Appellant Facility </td>
		<td ><cfinput type="text" size="60" name="appellant_facility"  value="#appellant_facility#"  maxlength="70"  tabindex=13> </td>
		
		<td align="right" class=TextMaingr>HR Manager </td>		
		<td >                    
			<cfquery name="qry_hr_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'HRMGR' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
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

    	</cfif>      
      	
		</td>	
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Appellant District </td>
		<td ><cfinput type="text" size="60" name="appellant_district"  value="#appellant_district#" maxlength="60" tabindex=14 > </td>
		
		<td align="right" class=TextMaingr>District Manager </td>
		<td >
			<cfquery name="qry_dist_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'DMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>
        
        
      
 			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
			<select name="dist_mgr" tabindex=40>
				<option value="">Select One...</option>
	     	<cfoutput query="qry_dist_mgr">
	        <option value="#name#" >#name#
	      </cfoutput>
      </select>	
      <cfelse>      
				<select name="dist_mgr" size="1" tabindex=40>
						<cfoutput>
						<option value="#dist_mgr#" selected="selected">#dist_mgr#</option>
						</cfoutput>
			     	<cfoutput query="qry_dist_mgr">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>

    	</cfif>     
   
		</td>		
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Docket No. </td>
		<td ><cfinput type="text" size="25" name="docket_no"  value="#docket_no#" maxlength="25"  tabindex=15> </td>
		
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
	        <option value="#name#" >#name#
	      </cfoutput>
      </select>	
      <cfelse>      
				<select name="hr_mgr_dist" size="1" tabindex=39>
						<cfoutput>
						<option value="#hr_mgr_dist#" selected="selected">#hr_mgr_dist#</option>
						</cfoutput>
			     	<cfoutput query="qry_hr_mgr_dist">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>

    	</cfif>	  
   </td>		
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Appellant email </td>
		<td ><cfinput type="text" size="40" name="appellant_email"  value="#appellant_email#" maxlength="40"  tabindex=15> </td>
		
		<td align="right" class=TextMaingr>OHNA - District </td>
		<td >
			<cfquery name="qry_ohna_dist" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'OHNA' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
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

    	</cfif>	

		</td>		
	</tr>


	<tr>
		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>
		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>
	</tr>	



	<tr>
		<td  align="right" class=TextMaingr>Mr. / Ms. </td>
		<td tabindex=17>
		
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="appellant_rep_prefix" size="1" tabindex=17>
						<!---<option value="">Select One...</option>		--->	
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="appellant_rep_prefix" size="1" tabindex=1>
							<option value="#appellant_rep_prefix#" selected="selected">#appellant_rep_prefix#</option>
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>				
					</select>
				</cfoutput>		
			</cfif> 			

		</td>
		
		<td  width=10% align="right" class=TextMaingr>WO Office </td>
		<td width=30%>
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_office" size="1" tabindex=43>
					<option value="Denver">Denver</option>
					<option value="Long Beach">Long Beach</option>
					<option value="Salt Lake">Salt Lake</option>
					<option value="San Diego">San Diego</option>
					<option value="San Francisco">San Francisco</option>
					<option value="Seattle">Seattle</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_office" size="1" tabindex=43>
						<option value="#alo_office#" selected="selected">#alo_office#</option>
						<option value="Denver">Denver</option>
						<option value="Long Beach">Long Beach</option>
						<option value="Salt Lake">Salt Lake</option>
						<option value="San Diego">San Diego</option>
						<option value="San Francisco">San Francisco</option>
						<option value="Seattle">Seattle</option>						
					</select>
				</cfoutput>				
			
			</cfif>
		</td>				
	</tr>	



	<tr>
		<td align="right" class=TextMaingr>Appellant Rep. First Name </td>
		<td ><cfinput type="text" size="40" name="appellant_rep_fname"  value="#appellant_rep_fname#" maxlength="40"  tabindex=18> </td>
		
		<td align="right" class=TextMaingr>WO Address1 </td>
		<td>
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr1" size=2 tabindex=43 multiple>
					<!---<option value="">Select One...</option>	--->		
					<option value="1745 Stout Street, Suite 500">1745 Stout Street, Suite 500</option>
					<option value="300 Long Beach Blvd., Rm 240">300 Long Beach Blvd., Rm 240</option>
					<option value="9350 South 150 East, Suite 800">9350 South 150 East, Suite 800</option>
					<option value="11255 Rancho Carmel Dr., Rm 1440">11255 Rancho Carmel Dr., Rm 1440</option>
					<!---<option value="1300 Evans Ave., Rm 217 P.O. Box 883790">1300 Evans Ave., Rm 217 P.O. Box 883790</option>--->
					<option value="1300 Evans Ave., Rm 217">1300 Evans Ave., Rm 217</option>
					<option value="P.O. Box 3686">P.O. Box 3686</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_addr1" size="2" tabindex=43 multiple>
					<option value="#alo_addr1#" selected="selected">#alo_addr1#</option>
					<!---<option value="">Select One...</option>--->			
					<option value="1745 Stout Street, Suite 500">1745 Stout Street, Suite 500</option>
					<option value="300 Long Beach Blvd., Rm 240">300 Long Beach Blvd., Rm 240</option>
					<option value="9350 South 150 East, Suite 800">9350 South 150 East, Suite 800</option>
					<option value="11255 Rancho Carmel Dr., Rm 1440">11255 Rancho Carmel Dr., Rm 1440</option>
					<!---<option value="1300 Evans Ave., Rm 217 P.O. Box 883790">1300 Evans Ave., Rm 217 P.O. Box 883790</option>--->
					<option value="1300 Evans Ave., Rm 217">1300 Evans Ave., Rm 217</option>
					<option value="P.O. Box 3686">P.O. Box 3686</option>						
					</select>
				</cfoutput>				
			
			</cfif>			

		</td>			
	</tr>
		

	<tr>
		<td align="right" class=TextMaingr>Appellant Rep. Last Name </td>
		<td ><cfinput type="text" size="40" name="appellant_rep_lname"  value="#appellant_rep_lname#" maxlength="40"  tabindex=19> </td>
		
		<td align="right" class=TextMaingr>WO Address2 </td>
		<td>
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr2" size="1" tabindex=45>
					<!---<option value="">Select One...</option>--->			
					<option value="Denver, CO 80299-5555">Denver, CO 80299-5555</option>
					<option value="Long Beach, CA 90802-2496">Long Beach, CA 90802-2496</option>
					<option value="Sandy, UT 84070-2716">Sandy, UT 84070-2716</option>
					<option value="San Diego, CA 92197-4400">San Diego, CA 92197-4400</option>
					<option value="San Francisco, CA 94188-3790">San Francisco, CA 94188-3790</option>
					<option value="Seattle, WA 98124-3686">Seattle, WA 98124-3686</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_addr2" size="2" tabindex=45>
						<option value="#alo_addr2#" selected="selected">#alo_addr2#</option>			
						<option value="Denver, CO 80299-5555">Denver, CO 80299-5555</option>
						<option value="Long Beach, CA 90802-2496">Long Beach, CA 90802-2496</option>
						<option value="Sandy, UT 84070-2716">Sandy, UT 84070-2716</option>
						<option value="San Diego, CA 92197-4400">San Diego, CA 92197-4400</option>
						<option value="San Francisco, CA 94188-3790">San Francisco, CA 94188-3790</option>
						<option value="Seattle, WA 98124-3686">Seattle, WA 98124-3686</option>						
					</select>
				</cfoutput>				
			
			</cfif>				

		</td>		
	</tr>





	<tr>
		<td align="right" class=TextMaingr>Appellant Rep. Company</td>
		<td ><cfinput type="text" size="25" name="appellant_rep_company"  value="#appellant_rep_company#" maxlength="25"  tabindex=20> </td>

		<td  width=10% align="right" class=TextMaingr>Attorney </td>
		<td width=30%>
			<cfquery name="qry_attorney" datasource="lawmanager">
				select b.entity_key, b.attorney_name as name 
				from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'ATTNY' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="attorney_name" tabindex=46>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_attorney">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="attorney_name" size="1" tabindex=46>
						<cfoutput>
						<option value="#attorney_name#" selected="selected">#attorney_name#</option>
						</cfoutput>
			     	<cfoutput query="qry_attorney">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>
    	</cfif>	
		</td>	
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Appellant Rep. Address </td>
		<td ><cfinput type="text" size="40" name="appellant_rep_addr"  value="#appellant_rep_addr#" maxlength="80" tabindex=21 > </td>
		
		<td  width=10% align="right" class=TextMaingr>Attorney Title</td>
		<td width=30%>

		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="attorney_title" size="1" tabindex=47>
					<option value="">Select One...</option>		
					<option value="Attorney">Attorney</option>						
					<option value="Senior Litigation Counsel">Senior Litigation Counsel</option>
					<option value="Managing Counsel" >Managing Counsel</option>
					<option value="Deputy Managing Counsel">Deputy Managing Counsel</option
			</select>
		<cfelse>
			<cfoutput>
						<select name="attorney_title" size="1" tabindex=47>
						<option value="#attorney_title#" selected="selected">#attorney_title#</option>	
						<option value="Attorney">Attorney</option>						
						<option value="Senior Litigation Counsel">Senior Litigation Counsel</option>
						<option value="Managing Counsel" >Managing Counsel</option>
						<option value="Deputy Managing Counsel">Deputy Managing Counsel</option					
				</select>
			</cfoutput>		
		</cfif>

		</td>	
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Appellant Rep. City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="appellant_rep_city"  value="#appellant_rep_city#" maxlength="20" tabindex=22>&nbsp;State&nbsp;
		<cfinput type="text" size="2" name="appellant_rep_state"  value="#appellant_rep_state#" maxlength="2" tabindex=23> &nbsp;Zip&nbsp;
		<cfinput type="text" size="11" name="appellant_rep_zip"  value="#appellant_rep_zip#" maxlength="12" tabindex=24> 
		</td>
			
		<td  width=10% align="right" class=TextMaingr>Paralegal </td>
		<td width=30%>
			<cfquery name="qry_paralgl" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'PLGL' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>			

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
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

    	</cfif>      

		</td>			
	</tr>



	<tr>
		<td align="right" class=TextMaingr>Appellant Rep. Phone </td>
		<td ><cfinput type="text" size="15" name="appellant_rep_phone"  value="#appellant_rep_phone#" maxlength="15"  tabindex=26> </td>
		
		<td align="right" class=TextMaingr>WO Phone </td>
		<td>

		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_phone" size="1" tabindex=49>
				<option value="">Select One...</option>				
				<option value="(206) 381-6620">(206) 381-6624</option>
				<option value="(206) 381-6624">(206) 381-6624</option>
				<option value="(206) 381-6623">(206) 381-6623</option>
				<option value="(206) 381-6625">(206) 381-6625</option>
				<option value="(206) 381-6626">(206) 381-6626</option>
				<option value="(206) 381-6628">(206) 381-6628</option>
				<option value="(303) 313-5560">(303) 313-5560</option>
				<option value="(303) 313-5567">(303) 313-5569</option>
				<option value="(303) 313-5577">(303) 313-5577</option>
				<option value="(303) 313-5579">(303) 313-5579</option>
				<option value="(303) 313-5791">(303) 313-5791</option>
				<option value="(415) 550-5300">(415) 550-5300</option>
				<option value="(415) 550-5381">(415) 550-5381</option>
				<option value="(415) 550-5397">(415) 550-5397</option>
				<option value="(415) 550-5473">(415) 550-5473</option>
				<option value="(415) 550-5493">(415) 550-5493</option>
				<option value="(415) 550-5495">(415) 550-5495</option>
				<option value="(562) 628-1340">(562) 628-1340</option>
				<option value="(562) 628-1344">(562) 628-1344</option>
				<option value="(562) 628-1345">(562) 628-1345</option>
				<option value="(562) 628-1346">(562) 628-1346</option>
				<option value="(562) 628-1347">(562) 628-1347</option>
				<option value="(562) 628-1350">(562) 628-1350</option>
				<option value="(562) 628-1351">(562) 628-1351</option>
				<option value="(562) 628-1354">(562) 628-1354</option>
				<option value="(562) 628-1357">(562) 628-1357</option>
				<option value="(801) 984-8400">(801) 984-8400</option>
				<option value="(801) 984-8403">(801) 984-8403</option>
				<option value="(801) 984-8404">(801) 984-8404</option>
				<option value="(801) 984-8420">(801) 984-8420</option>
				<option value="(801) 984-8423">(801) 984-8423</option>
				<option value="(801) 984-8428">(801) 984-8428</option>
				<option value="(801) 984-8432">(801) 984-8432</option>
				<option value="(858) 674-2686">(858) 674-2686</option>
				<option value="(858) 674-2738">(858) 674-2738</option>
				<option value="(858) 674-2742">(858) 674-2742</option>
				<option value="(858) 674-2748">(858) 674-2748</option>
			</select>
		<cfelse>
		<cfoutput>
			<select name="alo_phone" size="1" tabindex=49>
				<option value="#alo_phone#" selected="selected">#alo_phone#</option>	
				<option value="(206) 381-6620">(206) 381-6624</option>
				<option value="(206) 381-6624">(206) 381-6624</option>
				<option value="(206) 381-6623">(206) 381-6623</option>
				<option value="(206) 381-6625">(206) 381-6625</option>
				<option value="(206) 381-6626">(206) 381-6626</option>
				<option value="(206) 381-6628">(206) 381-6628</option>
				<option value="(303) 313-5560">(303) 313-5560</option>
				<option value="(303) 313-5567">(303) 313-5569</option>
				<option value="(303) 313-5577">(303) 313-5577</option>
				<option value="(303) 313-5579">(303) 313-5579</option>
				<option value="(303) 313-5791">(303) 313-5791</option>
				<option value="(415) 550-5300">(415) 550-5300</option>
				<option value="(415) 550-5381">(415) 550-5381</option>
				<option value="(415) 550-5397">(415) 550-5397</option>
				<option value="(415) 550-5473">(415) 550-5473</option>
				<option value="(415) 550-5493">(415) 550-5493</option>
				<option value="(415) 550-5495">(415) 550-5495</option>
				<option value="(562) 628-1340">(562) 628-1340</option>
				<option value="(562) 628-1344">(562) 628-1344</option>
				<option value="(562) 628-1345">(562) 628-1345</option>
				<option value="(562) 628-1346">(562) 628-1346</option>
				<option value="(562) 628-1347">(562) 628-1347</option>
				<option value="(562) 628-1350">(562) 628-1350</option>
				<option value="(562) 628-1351">(562) 628-1351</option>
				<option value="(562) 628-1354">(562) 628-1354</option>
				<option value="(562) 628-1357">(562) 628-1357</option>
				<option value="(801) 984-8400">(801) 984-8400</option>
				<option value="(801) 984-8403">(801) 984-8403</option>
				<option value="(801) 984-8404">(801) 984-8404</option>
				<option value="(801) 984-8420">(801) 984-8420</option>
				<option value="(801) 984-8423">(801) 984-8423</option>
				<option value="(801) 984-8428">(801) 984-8428</option>
				<option value="(801) 984-8432">(801) 984-8432</option>
				<option value="(858) 674-2686">(858) 674-2686</option>
				<option value="(858) 674-2738">(858) 674-2738</option>
				<option value="(858) 674-2742">(858) 674-2742</option>
				<option value="(858) 674-2748">(858) 674-2748</option>					
			</select>
		</cfoutput>		
		</cfif>			

		</td		
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Appellant Rep. Fax </td>
		<td ><cfinput type="text" size="15" name="appellant_rep_fax"  value="#appellant_rep_fax#" maxlength="15"  tabindex=27> </td>
		
		<td align="right" class=TextMaingr>WO Fax </td>
		<td>


		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_fax" size="1" tabindex=50>
					<option value="">Select One...</option>			
					<option value="(303) 313-5561">(303) 313-5561</option>
					<option value="(650) 357-6705">(650) 357-6705</option>
					<option value="(650) 357-6336">(650) 357-6336</option>
					<option value="(801) 984-8402">(801) 984-8402</option>
					<option value="(650) 578-3806">(650) 578-3806</option>
					<option value="(650) 578-1817">(650) 578-1817</option>
					<option value="(650) 577-5679">(650) 577-5679</option>
					<option value="(206) 381-6621">(206) 381-6621</option>
					
			</select>
		<cfelse>
		<cfoutput>
			<select name="alo_fax" size="1" tabindex=50>
					<!---<option value="#alo_fax#" selected="selected">#alo_fax#</option>---><!---commented out 4/29/2019 changed fax no. to efax no--->
					<option value="(303) 313-5561">(303) 313-5561</option>
					<option value="(650) 357-6705">(650) 357-6705</option>
					<option value="(650) 357-6336">(650) 357-6336</option>
					<option value="(801) 984-8402">(801) 984-8402</option>
					<option value="(650) 578-3806">(650) 578-3806</option>
					<option value="(650) 578-1817">(650) 578-1817</option>
					<option value="(650) 577-5679">(650) 577-5679</option>
					<option value="(206) 381-6621">(206) 381-6621</option>
										
			</select>
		</cfoutput>		
		</cfif>			

		</td>			
	</tr>



		<tr>	
		<td>&nbsp;
		<td>	
		<td align="right" class=TextMaingr >Legal Admin. Assistant </td>
		<td>


		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="admin_assist" size="1" tabindex=51>
					<option value="">Select One...</option>
					<option value="Shelley Bormann">Shelley Bormann</option>	
					<option value="Wilma Bray">Wilma Bray</option>
					<option value="Shana Brown">Shana Brown</option>
					<option value="Tia Johnstun">Tia Johnstun</option>
					<option value="Carol Lalor">Carol Lalor</option>
					<option value="Janet Huimin Luo"></option>
					<option value="Vivienne Hansen" >Vivienne Hansen</option>
					<option value="Alvin Samonte">Alvin Samonte</option>														
			</select>
		<cfelse>
		<cfoutput>
			<select name="admin_assist" size="1" tabindex=51>
					<option value="#admin_assist#" selected="selected">#admin_assist#</option>
					<option value="Shelley Bormann">Shelley Bormann</option>	
					<option value="Wilma Bray">Wilma Bray</option>
					<option value="Shana Brown">Shana Brown</option>
					<option value="Tia Johnstun">Tia Johnstun</option>
					<option value="Carol Lalor">Carol Lalor</option>
					<option value="Janet Huimin Luo"></option>
					<option value="Vivienne Hansen" >Vivienne Hansen</option>
					<option value="Alvin Samonte">Alvin Samonte</option>							
			</select>
		</cfoutput>		
		</cfif>			
			
		</td>
		<tr/>


	<tr>
		<td colspan=5 align=middle><br><br><input type="image" src="img/save_continue1.gif" border=0  value="submit"  tabindex=52>	</td>



</table>
</div>
</cfform>
</body>
</html>
