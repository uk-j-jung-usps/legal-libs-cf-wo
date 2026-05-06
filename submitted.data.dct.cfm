

<cfset ausa_us_attorney = "">
<cfset ausa_bar_no = "">
<cfset ausa_email = "">

<!--- Query data fields from the last submission by the user for this matterkey--->


	<cfquery name="qry_last_submitted_data" datasource="lawmanager">
	  select tempvar_key, tempvar_key_name, tempvar_value
	  from cmft_matterkey_pairs
	  where matter_key=#url.matterkey# order by tempvar_key
	</cfquery>



<!---
<cfoutput query="qry_last_submitted_data">
#tempvar_value# #tempvar_key#<br>
</cfoutput>
--->

<cfloop Query="qry_last_submitted_data">
<cfoutput>

 <cfswitch expression="#tempvar_key#">

    <cfcase value="112"> 
			<cfif len(tempvar_key)>
      	<cfset case_no= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>			
    </cfcase>

    <cfcase value="86"> 
			<cfif len(tempvar_key)>
      	<cfset plaintiff_fname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>			
    </cfcase>
    
    <cfcase value="87"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_lname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase> 
    
    <cfcase value="88"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_ssn= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="89"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_eid= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="90"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_addr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="91"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_citystzip = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="8"> 
			<cfif len(tempvar_key)>    
        <cfset attorney_name = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="9"> 
			<cfif len(tempvar_key)>    
        <cfset attorney_title = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="24"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_district = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="92"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_facility = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="93"> 
			<cfif len(tempvar_key)>    
        <cfset defendant_name = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="94"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_fname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="95"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_lname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="96"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_title = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="97"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_district = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="98"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_addr1 = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="99"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_addr2 = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>
    
    <cfcase value="100"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_citystzip = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>    

    <cfcase value="101"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_fax = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>     

    <cfcase value="102"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_prefix = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase> 

    <cfcase value="25"> 
			<cfif len(tempvar_key)>    
        <cfset dist_mgr = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="31"> 
			<cfif len(tempvar_key)>    
        <cfset hr_mgr_dist = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="32"> 
			<cfif len(tempvar_key)>    
        <cfset hr_mgr = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="34"> 
			<cfif len(tempvar_key)>    
        <cfset alo_addr1 = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="35"> 
			<cfif len(tempvar_key)>    
        <cfset alo_addr2 = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="37"> 
			<cfif len(tempvar_key)>    
        <cfset alo_fax = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="38"> 
			<cfif len(tempvar_key)>    
        <cfset alo_office = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="40"> 
			<cfif len(tempvar_key)>    
        <cfset alo_phone = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="42"> 
			<cfif len(tempvar_key)>    
        <cfset lr_mgr = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="45"> 
			<cfif len(tempvar_key)>    
        <cfset ohna_dist = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="51"> 
			<cfif len(tempvar_key)>    
        <cfset paralgl_name = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="73"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_fname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="74"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_lname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="75"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_company = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="76"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_addr = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>


    <cfcase value="55"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_citystzip = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="78"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_phone= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="79"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_fax= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="103"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_email= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="111"> 
			<cfif len(tempvar_key)>    
        <cfset plaintiff_rep_email= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>


    <cfcase value="104"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_bar_no= #trim(qry_last_submitted_data.tempvar_value)#>   
      </cfif>	
    </cfcase>
    
    
    <cfcase value="106"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_email= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>
    </cfcase>

    <cfcase value="107"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_chief_fname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>	   
    </cfcase>

    <cfcase value="108"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_chief_lname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>	   
    </cfcase>

    <cfcase value="109"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_us_attorney= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>        
    </cfcase>

    <cfcase value="110"> 
			<cfif len(tempvar_key)>    
        <cfset ausa_phone= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>	   
    </cfcase>
    
    <cfcase value="61"> 
			<cfif len(tempvar_key)>    
        <cfset admin_assist= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>
 
 </cfswitch>
 


 </cfoutput>

</cfloop>
	
