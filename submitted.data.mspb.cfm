

<!--- Query data fields from the last submission by the user for this matterkey--->

<!---<cfif IsDefined("url.matterkey")>--->
	<cfquery name="qry_last_submitted_data" datasource="lawmanager">
	  select tempvar_key, tempvar_key_name, tempvar_value
	  from cmft_matterkey_pairs
	  where matter_key=#url.matterkey# order by tempvar_key
	</cfquery>
<!---<cfelse>--->

<!---</cfif>	--->




<!---
<cfoutput query="qry_last_submitted_data">
#tempvar_value# #tempvar_key#<br>
</cfoutput>
--->

<cfloop Query="qry_last_submitted_data">
<cfoutput>

 <cfswitch expression="#tempvar_key#">

    <cfcase value="81"> 
			<cfif len(tempvar_key)>
      	<cfset docket_no= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>			
    </cfcase>

    <cfcase value="43"> 
			<cfif len(tempvar_key)>
      	<cfset appellant_email= #trim(qry_last_submitted_data.tempvar_value)#>
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

    <cfcase value="67"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_addr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="68"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_citystzip= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="69"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_phone= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="71"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_eid = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="66"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_facility = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="64"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_fname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="65"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_lname = #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="76"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_addr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="75"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_company= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>
    
    <cfcase value="73"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_fname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>    

    <cfcase value="74"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_lname= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>     

    <cfcase value="70"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_ssn= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase> 

    <cfcase value="25"> 
			<cfif len(tempvar_key)>    
        <cfset dist_mgr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="80"> 
			<cfif len(tempvar_key)>    
        <cfset mspb_office= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="29"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_pronoun1= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="30"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_pronoun2= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="31"> 
			<cfif len(tempvar_key)>    
        <cfset hr_mgr_dist= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="32"> 
			<cfif len(tempvar_key)>    
        <cfset hr_mgr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="34"> 
			<cfif len(tempvar_key)>    
        <cfset alo_addr1= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="35"> 
			<cfif len(tempvar_key)>    
        <cfset alo_addr2= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="37"> 
			<cfif len(tempvar_key)>    
        <cfset alo_fax= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="38"> 
			<cfif len(tempvar_key)>    
        <cfset alo_office= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="40"> 
			<cfif len(tempvar_key)>    
        <cfset alo_phone= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="42"> 
			<cfif len(tempvar_key)>    
        <cfset lr_mgr= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="72"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_prefix= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="45"> 
			<cfif len(tempvar_key)>    
        <cfset ohna_dist= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="51"> 
			<cfif len(tempvar_key)>    
        <cfset paralgl_name= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="55"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_citystzip= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>	    
    </cfcase>

    <cfcase value="77"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_prefix= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="78"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_phone= #trim(qry_last_submitted_data.tempvar_value)#>
      </cfif>		       
    </cfcase>

    <cfcase value="79"> 
			<cfif len(tempvar_key)>    
        <cfset appellant_rep_fax= #trim(qry_last_submitted_data.tempvar_value)#>
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
	
