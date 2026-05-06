



<cfset aj_email = "">
<cfset court_rptr_name = "">
<cfset court_rptr_phone = "">
<cfset court_rptr_email = "">
<cfset comp_rep_email = "">

		

<!--- Query data fields from the last submission by the user for this matterkey--->

<!---<cfif IsDefined("url.matterkey")>--->
	<cfquery name="qry_last_submitted_data" datasource="lawmanager">
	  select tempvar_key, tempvar_key_name, tempvar_value
	  from cmft_matterkey_pairs
	  where matter_key=#url.matterkey# order by tempvar_key
	</cfquery>
<!---<cfelse>--->

<!---</cfif>	--->

<!---<cfoutput>#qry_last_submitted_data.RecordCount#</cfoutput>--->


<!---
<cfoutput query="qry_last_submitted_data">
#tempvar_value# #tempvar_key#<br>
</cfoutput>
--->

<cfloop Query="qry_last_submitted_data">
<cfoutput>

 <cfswitch expression="#tempvar_key#">

    <cfcase value="1"> 
			<cfif len(tempvar_key)>
      	<cfset agency_no= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>			
    </cfcase>

    <cfcase value="2"> 
			<cfif len(tempvar_key)>
      	<cfset ajs_citystzip= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>			
    </cfcase>
    
    <cfcase value="3"> 
			<cfif len(tempvar_key)>    
        <cfset aj_addr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase> 
    
    <cfcase value="4"> 
			<cfif len(tempvar_key)>    
        <cfset aj_fax= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="5"> 
			<cfif len(tempvar_key)>    
        <cfset aj_fname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="6"> 
			<cfif len(tempvar_key)>    
        <cfset aj_lname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="7"> 
			<cfif len(tempvar_key)>    
        <cfset aj_title = #trim(qry_last_submitted_data.tempvar_value)#>
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

    <cfcase value="11"> 
			<cfif len(tempvar_key)>    
        <cfset comp_addr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="12"> 
			<cfif len(tempvar_key)>    
        <cfset aj_phone= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="13"> 
			<cfif len(tempvar_key)>    
        <cfset comp_citystzip= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="14"> 
			<cfif len(tempvar_key)>    
        <cfset comp_eid = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="15"> 
			<cfif len(tempvar_key)>    
        <cfset comp_facility = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="16"> 
			<cfif len(tempvar_key)>    
        <cfset comp_fname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="17"> 
			<cfif len(tempvar_key)>    
        <cfset comp_lname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="18"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_addr = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="19"> 
			<cfif len(tempvar_key)>    
        <cfset comp_phone = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="20"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_comp = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>
    
    <cfcase value="21"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_fname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>    

    <cfcase value="22"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_lname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>     

    <cfcase value="23"> 
			<cfif len(tempvar_key)>    
        <cfset comp_ssn = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase> 

    <cfcase value="24"> 
			<cfif len(tempvar_key)>    
        <cfset comp_district = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="25"> 
			<cfif len(tempvar_key)>    
        <cfset dist_mgr = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="26"> 
			<cfif len(tempvar_key)>    
        <cfset eeoc_no = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="27"> 
			<cfif len(tempvar_key)>    
        <cfset eeoc_office = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="29"> 
			<cfif len(tempvar_key)>    
        <cfset comp_pronoun1 = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="30"> 
			<cfif len(tempvar_key)>    
        <cfset comp_pronoun2 = #trim(qry_last_submitted_data.tempvar_value)#>
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

    <cfcase value="44"> 
			<cfif len(tempvar_key)>    
        <cfset comp_prefix = #trim(qry_last_submitted_data.tempvar_value)#>
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

    <cfcase value="55"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_citystzip = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="56"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_prefix = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="54"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_fax = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="61"> 
			<cfif len(tempvar_key)>    
        <cfset admin_assist = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="78"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_phone = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="168"> 
			<cfif len(tempvar_key)>    
        <cfset comp_title = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>
    
    <cfcase value="169"> 
			<cfif len(tempvar_key)>    
        <cfset comp_email = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>    
    
    <cfcase value="171"> 
			<cfif len(tempvar_key)>    
        <cfset comp_rep_email = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="172"> 
			<cfif len(tempvar_key)>    
        <cfset aj_email = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="173"> 
			<cfif len(tempvar_key)>    
        <cfset paralegal_phone = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="174"> 
			<cfif len(tempvar_key)>    
        <cfset court_rptr_name = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="175"> 
			<cfif len(tempvar_key)>    
        <cfset court_rptr_phone = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="176"> 
			<cfif len(tempvar_key)>    
        <cfset court_rptr_email = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>


 </cfswitch>
 


 </cfoutput>
 
</cfloop>

