
<cfinclude template = "submitted.data.dct.cfm"><!--- grab last submitted data from cmft_matterkey_pairs table--->
<cfinclude template = "ausa.data.cfm">
<cfinclude template = "plaintiff.data.cfm">
<cfinclude template = "plaintiff.rep.data.cfm">




<cfset usdj_fname = "">
<cfset usdj_lname = "">
<cfset usdj_title = "">
<cfset usdj_addr = "">
<cfset usdj_city = "">
<cfset usdj_state = "">
<cfset usdj_zip = "">
<cfset usdj_office = "">
<cfset usdj_phone = "">
<cfset usdj_fax = "">




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Legal Libs Templates</title>
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
	<td align=right class=TextMaingrcolapan=5 bgcolor="#D9E9EA">	WLO - District Court	


	<tr>
		<td width=12% align="right" class=TextMaingr>Plaintiff EID </td>
		<td ><cfinput type="text" size="9" name="plaintiff_eid"  value="#plaintiff_eid#" maxlength="8"  tabindex=1> </td>

		<td  width=15% align="right" class=TextMaingr >Mr. / Ms. </td>
		<td>

			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="ausa_prefix" size="1" tabindex=32>
						<!---<option value="">Select One...</option>		--->	
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="ausa_prefix" size="1" tabindex=32>
							<option value="#ausa_prefix#" selected="selected">#ausa_prefix#</option>
						<option value="Mr.">Mr.</option>
						<option value="Ms." >Ms.</option>				
					</select>
				</cfoutput>		
			</cfif>
		</td>		
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Plaintiff SSN </td>
		<td ><cfinput type="text" size="10" name="plaintiff_ssn"  value="#plaintiff_ssn#" maxlength="9"  tabindex=2> </td>

		<td  align="right" class=TextMaingr>AUSA First Name </td>
		<td ><cfinput type="text" size="40" name="ausa_fname"  value="#ausa_fname#" maxlength="40"  tabindex=33> </td>
	</tr>


	<tr>
		<td align="right" class=TextMaingr>Case Number </td>
		<td ><cfinput type="text" size="25" name="case_no"  value="#case_no#" maxlength="25"  tabindex=3> </td>	

		<td  align="right" class=TextMaingr>AUSA Last Name </td>
		<td ><cfinput type="text" size="40" name="ausa_lname"  value="#ausa_lname#" maxlength="40"  tabindex=34> </td>
	</tr>

	<tr>
		<td align="right" class=TextMaingr>Plaintiff First Name </td>
		<td ><cfinput type="text" size="40" name="plaintiff_fname"  value="#plaintiff_fname#" maxlength="40"  tabindex=4> </td>	

		<td align="right" class=TextMaingr>AUSA Bar No. </td>
		<td ><cfinput type="text" size="40" name="ausa_bar_no"  value="#ausa_bar_no#" maxlength="80"  tabindex=35> </td>

	<tr>
		<td align="right" class=TextMaingr>Plaintiff Last Name </td>
		<td ><cfinput type="text" size="40" name="plaintiff_lname"  value="#plaintiff_lname#" maxlength="40"  tabindex=5> </td>	


		<td align="right" class=TextMaingr>AUSA Title </td>
		<td ><cfinput type="text" size="40" name="ausa_title"  value="#ausa_title#" maxlength="80"  tabindex=36> </td>

	<tr>
	
		<td align="right" class=TextMaingr>Plaintiff Address </td>
		<td ><cfinput type="text" size="40" name="plaintiff_addr"  value="#plaintiff_addr#" maxlength="80"  tabindex=6> </td>	

		<td  width=10% align="right" class=TextMaingr>AUSA District </td>
		<td width=30%>
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="ausa_district" size="1" tabindex=37>
					<option > </option>
					<option value="Central District of California">Central District of California</option>
					<option value="District of Hawaii">District of Hawaii</option>
					<option value="Eastern District of California" >Eastern District of California</option>
					<option value="Northern District">Northern District</option>
					<option value="Southern District of California">Southern District of California</option>
				</select>
			<cfelse>
				<cfoutput>
				<select name="ausa_district" size="1" tabindex=37>
					<option > </option>					
					<option value="#ausa_district#" selected="selected">#ausa_district#</option>
					<option value="Central District of California">Central District of California</option>
					<option value="District of Hawaii">District of Hawaii</option>
					<option value="Eastern District" >Eastern District</option>
					<option value="Northern District">Northern District</option>
					<option value="Southern District">Southern District</option>
				</select>
				</cfoutput>				
			</cfif>
		</td>		

		
	<tr>
		<td align="right" class=TextMaingr>Plaintiff City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="plaintiff_city"  value="#plaintiff_city#" maxlength="20" tabindex=7>&nbsp;State&nbsp;<cfinput type="text" size="2" name="plaintiff_state"  value="#plaintiff_state#" maxlength="2" tabindex=8> &nbsp;Zip&nbsp;<cfinput type="text" size="11" name="plaintiff_zip"  value="#plaintiff_zip#" maxlength="10" tabindex=9> </td>			

		<td align="right" class=TextMaingr>AUSA Address1 </td>
		<td>
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="ausa_addr1" size="1" tabindex=38>
					<option> </option>
					<option value="Federal Building 9th Floor">Federal Bulding 9th Floor</option>
					<option value="Federal Building Suite 7516" >Federal Bulding Suite 7516</option>
					<option value="Federal Office Building">Federal Office Building</option>
					<option value="Southern District of California">Southern District of California</option>
					<option value="PJKK Federal Building">PJKK Federal Building</option>									
				</select>
			<cfelse>
				<cfoutput>
					<select name="ausa_addr1" size="1" tabindex=38>
					<option value="#ausa_addr1#" selected="selected">#ausa_addr1#</option>
					<option> </option>
					<option value="Federal Building 9th Floor">Federal Bulding 9th Floor</option>
					<option value="Federal Building Suite 7516" >Federal Bulding Suite 7516</option>
					<option value="Federal Office Building">Federal Office Building</option>
					<option value="Southern District of California">Southern District of California</option>
					<option value="PJKK Federal Building">PJKK Federal Building</option>							
					</select>
				</cfoutput>				
			</cfif>
		</td>		
		
		
		
	<tr>
		<td align="right" class=TextMaingr>Plaintiff Facility </td>
		<td ><cfinput type="text" size="60" name="plaintiff_facility"  value="#plaintiff_facility#"  maxlength="70"  tabindex=10> </td>			
		
		<td align="right" class=TextMaingr>AUSA Address2 </td>
		<td>
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="ausa_addr2" size="1" tabindex=39>
					<option value="450 Golden Gate Avenue, Box 36055">450 Golden Gate Avenue, Box 36055</option>
					<option value="501 I Street, Ste 10-100" >501 I Street, Ste 10-100</option>
					<option value="300 N. Los Angeles Street">300 N. Los Angeles Street</option>
					<option value="880 Front Street, Rm 6293">880 Front Street, Rm 6293</option>
					<option value="300 Ala Moana Blvd. Rm 6-100">300 Ala Moana Blvd. Rm 6-100</option>	
					<option value="2500 Tulare Street, Suite 4401">2500 Tulare Street, Suite 4401</option>												
				</select>
			<cfelse>
				<cfoutput>
					<select name="ausa_addr2" size="1" tabindex=39>
					<option value="#ausa_addr2#" selected="selected">#ausa_addr2#</option>
					<option value="450 Golden Gate Avenue, Box 36055">450 Golden Gate Avenue, Box 36055</option>
					<option value="501 I Street, Ste 10-100" >501 I Street, Ste 10-100</option>
					<option value="300 N. Los Angeles Street">300 N. Los Angeles Street</option>
					<option value="880 Front Street, Rm 6293">880 Front Street, Rm 6293</option>
					<option value="300 Ala Moana Blvd. Rm 6-100">300 Ala Moana Blvd. Rm 6-100</option>
					<option value="2500 Tulare Street, Suite 4401">2500 Tulare Street, Suite 4401</option>												
					</select>
				</cfoutput>				
			</cfif>
		</td>		
		
		
		
	<tr>
		<td align="right" class=TextMaingr>Plaintiff District </td>
		<td ><cfinput type="text" size="60" name="plaintiff_district"  value="#plaintiff_district#" maxlength="60" tabindex=11 > </td>		
	
		<td align="right" class=TextMaingr>AUSA CityStZip </td>
		<td>
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="ausa_citystzip" size="1" tabindex=40>
					<option value="San Francisco, CA 94102-3495">San Francisco, CA 94102-3495</option>
					<option value="Sacramento, CA 95814" >Sacramento, CA 95814</option>
					<option value="Los Angeles, CA 90012">Los Angeles, CA 90012</option>
					<option value="San Diego, CA 92101">San Diego, CA 92101</option>
					<option value="Honolulu, HI 96850">Honolulu, HI 96850</option>
					<option value="Fresno, CA  93721">Fresno, CA  93721</option>														
				</select>
			<cfelse>
				<cfoutput>
					<select name="ausa_citystzip" size="1" tabindex=40>
					<option value="#ausa_citystzip#" selected="selected">#ausa_citystzip#</option>
					<option value="San Francisco, CA 94102-3495">San Francisco, CA 94102-3495</option>
					<option value="Sacramento, CA 95814" >Sacramento, CA 95814</option>
					<option value="Los Angeles, CA 90012">Los Angeles, CA 90012</option>
					<option value="San Diego, CA 92101">San Diego, CA 92101</option>
					<option value="Honolulu, HI 96850">Honolulu, HI 96850</option>
					<option value="Fresno, CA  93721">Fresno, CA  93721</option>											
					</select>
				</cfoutput>				
			</cfif>
		</td>		
		
				

	<tr>
		<td align="right" class=TextMaingr>Plaintiff Email </td>
		<td ><cfinput type="text" size="40" name="plaintiff_email"  value="#plaintiff_email#" maxlength="40"  tabindex=12> </td>

		<td align="right" class=TextMaingr>AUSA Phone </td>
		<td>
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="ausa_phone" size="1" tabindex=41>
					<option value="415-436-7200">415-436-7200</option>
					<option value="916-554-2700" >916-554-2700</option>
					<option value="213-894-2404">213-894-2404</option>
					<option value="213-894-2458">213-894-2458</option>
					<option value="619-557-5610">619-557-5610</option>
					<option value="808-541-2850">808-541-2850</option>
					<option value="559-497-4019">559-497-4019</option>													
				</select>
			<cfelse>
				<cfoutput>
					<select name="ausa_phone" size="1" tabindex=41>
					<option value="#ausa_phone#" selected="selected">#ausa_phone#</option>
					<option value="415-436-7200">415-436-7200</option>
					<option value="916-554-2700" >916-554-2700</option>
					<option value="213-894-2404">213-894-2404</option>
					<option value="213-894-2458">213-894-2458</option>
					<option value="619-557-5610">619-557-5610</option>
					<option value="808-541-2850">808-541-2850</option>
					<option value="559-497-4019">559-497-4019</option>												
					</select>
				</cfoutput>				
			</cfif>
			AUSA Fax 
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="ausa_fax" size="1" tabindex=42>
					<option value="415-436-7234">415-436-7234</option>
					<option value="916-554-2900" >916-554-2900</option>
					<option value="213-894-7819">213-894-7819</option>
					<option value="619-546-0720">619-546-0720</option>
					<option value="808-541-2958">808-541-2958</option>
					<option value="559-497-4099">559-497-4099</option>														
				</select>
			<cfelse>
				<cfoutput>
					<select name="ausa_fax" size="1" tabindex=42>
					<option value="#ausa_fax#" selected="selected">#ausa_fax#</option>
					<option value="415-436-7234">415-436-7234</option>
					<option value="916-554-2900" >916-554-2900</option>
					<option value="213-894-7819">213-894-7819</option>
					<option value="619-546-0720">619-546-0720</option>
					<option value="808-541-2958">808-541-2958</option>
					<option value="559-497-4099">559-497-4099</option>											
					</select>
				</cfoutput>				
			</cfif>			
		</td>		



	<tr>
		<td align="right" class=TextMaingr>Defendant Name </td>
		<td ><cfinput type="text" size="60" name="defendant_name"  value="#defendant_name#" maxlength="60"  tabindex=13> </td>		

		<td align="right" class=TextMaingr>AUSA Email </td>
		<td ><cfinput type="text" size="40" name="ausa_email"  value="#ausa_email#" maxlength="40"  tabindex=43> </td>
	</tr>			
		
	<tr>
		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>
		<td align="right" class=TextMaingr>AUSA Chief First Name 
		<td>		
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="ausa_chief_fname" size="1" tabindex=44>
				<!---<option value="">Select One...</option>--->			
				<option value="Alex">Alex</option>
				<option value="derrick" >Derrick</option>
				<option value="Lee">Lee</option>
				<option value="Robyn-Marie Lyn">Robyn-Marie Lyn</option>
				<option value="Sylvia">Sylvia</option>
				<option value="Thomas C.">Thomas C.</option>								
			</select>
		<cfelse>
			<cfoutput>
				<select name="ausa_chief_fname" size="1" tabindex=44>
				<option value="#ausa_chief_fname#" selected="selected">#ausa_chief_fname#</option>			
				<option value="Alex">Alex</option>
				<option value="Derrick" >Derrick</option>
				<option value="Lee">Lee</option>
				<option value="Robyn-Marie Lyn">Robyn-Marie Lyn</option>
				<option value="Sylvia">Sylvia</option>
				<option value="Thomas C.">Thomas C.</option>						
				</select>
			</cfoutput>				
		</cfif>			
		</td>
		
	<tr>
		<td align="right" class=TextMaingr>Plaintiff Rep. First Name </td>
		<td ><cfinput type="text" size="40" name="plaintiff_rep_fname"  value="#plaintiff_rep_fname#" maxlength="40"  tabindex=14> </td>
	
		
		<td align="right" class=TextMaingr>AUSA Chief Last Name </td>
		<td>
		<!--- GAC - 08/14/2015 - Added Helper under dropdown as requested by Alvin Samonte on 8/14/2015 --->		
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="ausa_chief_lname" size="1" tabindex=45>
				<!---<option value="">Select One...</option>--->			
				<option value="Helper">Helper</option>
				<option value="Monteleone">Monteleone</option>
				<option value="Quast">Quast</option>
				<option value="Stahl" >Stahl</option>
				<option value="Tse">Tse</option>
				<option value="Watson">Watson</option>
				<option value="Weidman">Weidman</option>								
			</select>
		<cfelse>
			<cfoutput>
				<select name="ausa_chief_lname" size="1" tabindex=45>
				<option value="#ausa_chief_lname#" selected="selected">#ausa_chief_lname#</option>			
				<option value="Helper">Helper</option>
				<option value="Monteleone">Monteleone</option>
				<option value="Quast">Quast</option>
				<option value="Stahl" >Stahl</option>
				<option value="Tse">Tse</option>
				<option value="Watson">Watson</option>
				<option value="Weidman">Weidman</option>						
				</select>
			</cfoutput>				
		</cfif>			
		</td>		
		
	<tr>
		<td align="right" class=TextMaingr>Plaintiff Rep. Last Name </td>
		<td ><cfinput type="text" size="40" name="plaintiff_rep_lname"  value="#plaintiff_rep_lname#" maxlength="40"  tabindex=15> </td>		
		

		<td align="right" class=TextMaingr>US Attorney </td>
		<td ><cfinput type="text" size="40" name="ausa_us_attorney"  value="#ausa_us_attorney#" maxlength="60"  tabindex=46> </td>			

				
	<tr>
		<td align="right" class=TextMaingr>Plaintiff Rep. Company</td>
		<td ><cfinput type="text" size="25" name="plaintiff_rep_company"  value="#plaintiff_rep_company#" maxlength="25"  tabindex=16> </td>	
	
		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>		


	<tr>		
		<td align="right" class=TextMaingr>Plaintiff Rep. Address </td>
		<td ><cfinput type="text" size="40" name="plaintiff_rep_addr"  value="#plaintiff_rep_addr#" maxlength="80"  tabindex=17> </td>		

		<td align="right" class=TextMaingr>USDJ First Name </td>
		<td ><cfinput type="text" size="40" name="usdj_fname"  value="#usdj_fname#" maxlength="40"  tabindex=47> </td>

	<tr>
		<td align="right" class=TextMaingr>Plaintiff Rep. City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="plaintiff_rep_city"  value="#plaintiff_rep_city#" maxlength="20" tabindex=18>&nbsp;State&nbsp;<cfinput type="text" size="2" name="plaintiff_rep_state"  value="#plaintiff_rep_state#" maxlength="2" tabindex=19> &nbsp;Zip&nbsp;<cfinput type="text" size="11" name="plaintiff_rep_zip"  value="#plaintiff_rep_zip#" maxlength="10" tabindex=20> </td>			


		<td align="right" class=TextMaingr>USDJ Last Name </td>
		<td ><cfinput type="text" size="40" name="usdj_lname"  value="#usdj_lname#" maxlength="40"  tabindex=48> </td>

	<tr>
		<td align="right" class=TextMaingr>Plaintiff Rep. Phone </td>
		<td ><cfinput type="text" size="15" name="plaintiff_rep_phone"  value="#plaintiff_rep_phone#" maxlength="15"  tabindex=21>  Plaintiff Rep. Fax  <cfinput type="text" size="15" name="plaintiff_rep_fax"  value="#plaintiff_rep_fax#" maxlength="15"  tabindex=22></td>		

		<td align="right" class=TextMaingr>USDJ Title </td>
		<td ><cfinput type="text" size="40" name="usdj_title"  value="#usdj_title#" maxlength="80"  tabindex=49> </td>

	<tr>
		<td align="right" class=TextMaingr>Plaintiff Rep. Email </td>
		<td ><cfinput type="text" size="40" name="plaintiff_rep_email"  value="#plaintiff_rep_email#" maxlength="40"  tabindex=23> </td>

		<td align="right" class=TextMaingr>USDJ Address </td>
		<td ><cfinput type="text" size="40" name="usdj_addr"  value="#usdj_addr#" maxlength="80"  tabindex=50> </td>

	<tr>
		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>

		<td align="right" class=TextMaingr>USDJ City </td>
		<td class=TextMaingr><cfinput type="text" size="20" name="usdj_city"  value="#usdj_city#" maxlength="20" tabindex=51>&nbsp;State&nbsp;<cfinput type="text" size="2" name="usdj_state"  value="#usdj_state#" maxlength="2" tabindex=52> &nbsp;Zip&nbsp;<cfinput type="text" size="11" name="usdj_zip"  value="#usdj_zip#" maxlength="10" tabindex=53> </td>			


	<tr>
		<td  width=10% align="right" class=TextMaingr>WO Office </td>
		<td width=30%>
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_office" size="1" tabindex=24>
					<option value="Denver">Denver</option>
					<option value="Long Beach">Long Beach</option>
					<option value="Salt Lake">Salt Lake</option>
					<option value="San Diego">San Diego</option>
					<option value="San Francisco">San Francisco</option>
					<option value="Seattle">Seattle</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_office" size="1" tabindex=24>
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
	
		<td align="right" class=TextMaingr>USDJ Office </td>
		<td ><cfinput type="text" size="40" name="usdj_office"  value="#usdj_office#" maxlength="40"  tabindex=54> </td>


	<tr>
		<td align="right" class=TextMaingr>WO Address1 </td>
		<td>
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr1" size=2 tabindex=25 multiple>
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
					<select name="alo_addr1" size="2" tabindex=25 multiple>
						<option value="#alo_addr1#" selected="selected">#alo_addr1#</option>
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

		<td align="right" class=TextMaingr>USDJ Phone </td>
		<td ><cfinput type="text" size="15" name="usdj_phone"  value="#usdj_phone#" maxlength="15"  tabindex=55>  USDJ Fax  <cfinput type="text" size="15" name="usdj_fax"  value="#usdj_fax#" maxlength="15"  tabindex=55></td>		



	<tr>
		<td align="right" class=TextMaingr>WO Address2 </td>
		<td>
			
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr2" size="1" tabindex=26>
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
					<select name="alo_addr2" size="2" tabindex=26>
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

		<td  colspan=2 align="right" class=TextMaingr ><hr > </td>


	<tr>
		<td align="right" class=TextMaingr>WO Phone </td>
		<td>
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_phone" size="1" tabindex=27>
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
			<select name="alo_phone" size="1" tabindex=27>
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
		</td>
	
	
		<td align="right" class=TextMaingr>LR Manager </td>
		<td >
			<cfquery name="qry_lr_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'LRMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>
			<cfif not qry_last_submitted_data.RecordCount gt 0>      
				<select name="lr_mgr" tabindex=56>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_lr_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>
      	</select>
      <cfelse>
				<select name="lr_mgr" size="1" tabindex=56>
						<cfoutput>
						<option value="#lr_mgr#" selected="selected">#lr_mgr#</option>
						</cfoutput>
			     	<cfoutput query="qry_lr_mgr">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>
      </cfif>		
		 </td>



	<tr>
		<td align="right" class=TextMaingr>WO Fax </td>
		<td>
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_fax" size="1" tabindex=28>
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
			<select name="alo_fax" size="1" tabindex=28>
					<!---<option value="#alo_fax#" selected="selected">#alo_fax#</option>--->  <!---commented out 4/29/2019  changed the fax to efax no.  --->
					<option value="(303) 313-5561">(303) 313-5561</option>
					<option value="(650) 357-6705">(650) 357-6705</option>
					<option value="(650) 357-6336">(650) 357-6336</option>
					<option value="(801) 984-8402">(801) 984-8402</option>
					<option value="(650) 578-3806">(650) 578-3806</option>
					<option value="(650) 578-1817">(650) 578-1817</option>
					<option value="(650) 577-5679">(650) 577-5679</option>
					<option value="(206) 381-6621">(206) 381-6621</option>
		</cfoutput>		
		</cfif>			
		</td>
	
		<td align="right" class=TextMaingr>HR Manager </td>		
		<td >                    
			<cfquery name="qry_hr_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'HRMGR' and a.entity_key = b.entity_key  and b.group_prefix = 'WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
				<select name="hr_mgr" tabindex=57>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_hr_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="hr_mgr" size="1" tabindex=57>
					<cfoutput>
					<option value="#hr_mgr#" selected="selected">#hr_mgr#</option>
					</cfoutput>
		     	<cfoutput query="qry_hr_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>							
				</select>
    	</cfif>      	    	
		</td>	



	<tr>
		<td  width=10% align="right" class=TextMaingr>Attorney </td>
		<td width=30%>
			<cfquery name="qry_attorney" datasource="lawmanager">
				select b.entity_key, b.attorney_name as name 
				from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'ATTNY' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="attorney_name" tabindex=29>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_attorney">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="attorney_name" size="1" tabindex=29>
						<cfoutput>
						<option value="#attorney_name#" selected="selected">#attorney_name#</option>
						</cfoutput>
			     	<cfoutput query="qry_attorney">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>
    	</cfif>	
		</td>	
		
	
		<td align="right" class=TextMaingr>District Manager </td>
		<td >
			<cfquery name="qry_dist_mgr" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'DMGR' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>
        
 			<cfif not qry_last_submitted_data.RecordCount gt 0>      
				<select name="dist_mgr" tabindex=58>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_dist_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="dist_mgr" size="1" tabindex=58>
					<cfoutput>
					<option value="#dist_mgr#" selected="selected">#dist_mgr#</option>
					</cfoutput>
		     	<cfoutput query="qry_dist_mgr">
		        <option value="#name#" >#name#
		      </cfoutput>							
				</select>
    	</cfif>     
		</td>
		
		

	<tr>
		<td  width=10% align="right" class=TextMaingr>Attorney Title</td>
		<td width=30%>

		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="attorney_title" size="1" tabindex=30>
					<option value="">Select One...</option>		
					<option value="Attorney">Attorney</option>						
					<option value="Senior Litigation Counsel">Senior Litigation Counsel</option>
					<option value="Managing Counsel" >Managing Counsel</option>
					<option value="Deputy Managing Counsel">Deputy Managing Counsel</option
			</select>
		<cfelse>
			<cfoutput>
						<select name="attorney_title" size="1" tabindex=30>
						<option value="#attorney_title#" selected="selected">#attorney_title#</option>	
						<option value="Attorney">Attorney</option>						
						<option value="Senior Litigation Counsel">Senior Litigation Counsel</option>
						<option value="Managing Counsel" >Managing Counsel</option>
						<option value="Deputy Managing Counsel">Deputy Managing Counsel</option					
				</select>
			</cfoutput>		
		</cfif>

		</td>	

		<td align="right" class=TextMaingr>H&R Mgr - District </td>
		<td >     
			<cfquery name="qry_hr_mgr_dist" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'HRDST' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>
           
			<cfif not qry_last_submitted_data.RecordCount gt 0>       
				<select name="hr_mgr_dist" tabindex=59>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_hr_mgr_dist">
		       <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="hr_mgr_dist" size="1" tabindex=59>
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
		<td  width=10% align="right" class=TextMaingr>Paralegal </td>
		<td width=30%>
			<cfquery name="qry_paralgl" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'PLGL' and a.entity_key = b.entity_key and b.group_prefix = 'WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
      
				<select name="paralgl_name" tabindex=31>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_paralgl">
		        <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="paralgl_name" size="1" tabindex=31>
						<cfoutput>
						<option value="#paralgl_name#" selected="selected">#paralgl_name#</option>
						</cfoutput>
			     	<cfoutput query="qry_paralgl">
			        <option value="#name#" >#name#
			      </cfoutput>							
				</select>

    	</cfif>      
		</td>	
		
		<td align="right" class=TextMaingr>OHNA - District </td>
		<td >
			<cfquery name="qry_ohna_dist" datasource="lawmanager">
				select b.entity_key, initcap(first_name) ||' '|| initcap(last_name) as name from ENTITY a, cmft_entity_wo b
				where b.entity_role = 'OHNA' and a.entity_key = b.entity_key and b.group_prefix='WO' order by sort_fld                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			</cfquery>

			<cfif not qry_last_submitted_data.RecordCount gt 0>      
				<select name="ohna_dist" tabindex=60>
					<option value="">Select One...</option>
		     	<cfoutput query="qry_ohna_dist">
		      <option value="#name#" >#name#
		      </cfoutput>
	      </select>	
      <cfelse>      
				<select name="ohna_dist" size="1" tabindex=60>
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
		<td colspan=5 align=middle><br><br><input type="image" src="img/save_continue1.gif" border=0  value="submit"  tabindex=52>	</td>



</table>
</div>
</cfform>
</body>
</html>
