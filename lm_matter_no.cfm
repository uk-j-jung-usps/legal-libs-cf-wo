<!DOCTYPE html>
<html>
<body background="img/bck_yellowbox1.gif">
<head>

<cfset aceid = #mid(AUTH_USER,5,6)#>


<cfset ucaseform.matter_no = ucase(form.matter_no)>
<!---
<cfoutput> #ucase(ucaseform.matter_no)#</cfoutput>
--->



<cfif IsDefined("ucaseform.matter_no")>
		<cfquery name="qry_matter_no" datasource="#datasrc#" username="lawmanager">
	    select substr(matter_number, 1, 2) as matter_prefix, matter_key, matter_type_key from matter where matter_number='#ucaseform.matter_no#'
		</cfquery>
		


		<cfif qry_matter_no.RecordCount>
		  <cfswitch expression="#qry_matter_no.matter_type_key#">
		  
		    <cfcase value="9">
		    	<cfif qry_matter_no.matter_prefix eq "WI">
						  <cflocation url="wi/master.file.detail.display.eeoc_WI.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#ucaseform.matter_no#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">
					  </cfif>
					
		    	<cfif qry_matter_no.matter_prefix eq "SF">
						  <cflocation url="master.file.detail.display.eeoc.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#ucaseform.matter_no#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">
					  </cfif>		
		    	<cfif qry_matter_no.matter_prefix eq "SL">
						  <cflocation url="sl/master.file.detail.display.eeoc_SL.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#ucaseform.matter_no#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">
					  </cfif>						  
				<cfif qry_matter_no.matter_prefix eq "WO">
						  <cflocation url="master.file.detail.display.eeoc.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#ucaseform.matter_no#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">
					  </cfif>			  				
				  </cfcase>
				
		    <cfcase value="8">
					  <cfif qry_matter_no.matter_prefix eq "WI">
						  <cflocation url="wi/legallibs_message_mspb.cfm">
					  </cfif>
					  <cfif qry_matter_no.matter_prefix eq "SF">
						  <cflocation url="master.file.detail.display.mspb.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#matter_no#&mattertypekey=#qry_matter_no.matter_type_key#">
					  </cfif>	
					  <cfif qry_matter_no.matter_prefix eq "SL">
						  <cflocation url="sl/master.file.detail.display.mspb_SL.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#ucaseform.matter_no#&mattertypekey=#qry_matter_no.matter_type_key#&matter_prefix=#qry_matter_no.matter_prefix#">					     
					  </cfif>
					  
					  <cfif qry_matter_no.matter_prefix eq "WO">
						  <cflocation url="master.file.detail.display.mspb.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#matter_no#&mattertypekey=#qry_matter_no.matter_type_key#">
					  </cfif>	
				  </cfcase>				


				
		    <cfcase value="5">
					  <cfif qry_matter_no.matter_prefix eq "WI">
						  <cflocation url="wi/legallibs_message_district_court.cfm">
					  </cfif>	
					  <cfif qry_matter_no.matter_prefix eq "SF">
						  <cflocation url="master.file.detail.display.dct.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#matter_no#&mattertypekey=#qry_matter_no.matter_type_key#">
					  </cfif>
					  <cfif qry_matter_no.matter_prefix eq "SL">
						  <cflocation url="sl/master.file.detail.display.dct_SL.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#matter_no#&mattertypekey=#qry_matter_no.matter_type_key#">
					  </cfif>	

					  <cfif qry_matter_no.matter_prefix eq "WO">
						  <cflocation url="master.file.detail.display.dct.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#matter_no#&mattertypekey=#qry_matter_no.matter_type_key#">
					  </cfif>					  
				  </cfcase>	
				
		    <cfcase value="1">
		    	<cfquery name="qry_advice_subpoena" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
		    	select a.matter_key, a.matter_type_key, a.matter_name 
							from matter a, mattercategoryusps b
 						where matter_number='#ucaseform.matter_no#' and a.matter_key=b.matter_key 
 						and b.category_type_key=8 and subcategory_type_key=199
						</cfquery>
					<cfif qry_advice_subpoena.RecordCount>
						<cflocation url="master.file.detail.display.advice_fssc.cfm?matterkey=#qry_matter_no.matter_key#&matternumber=#ucaseform.matter_no#&mattertypekey=#qry_matter_no.matter_type_key#&mattername=#qry_advice_subpoena.matter_name#">
					<cfelse>
						<cflocation url="master.file.detail.display.other.cfm">
					</cfif>
				</cfcase>								
			  <cfdefaultcase>
			   	<cflocation url="master.file.detail.display.other.cfm">
			  </cfdefaultcase>				
				
		  </cfswitch>


		<cfelse>

			<cflocation url="case.files.home.cfm?matternoerror=Y">
		</cfif>			

</cfif>

</body>
</html>
