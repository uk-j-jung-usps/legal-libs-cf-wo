

<!---******************** Assistant US Attorney's Information Queries ********************--->

<!--- Query AUSA's name and title --->
<cfquery name="qry_ausa" datasource="lawmanager">
  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name, trim(initcap(b.title)) as title
  from matter a, entity b, matterentity c
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and  c.matter_entity_type_key=11
</cfquery>


<cfif qry_ausa.RecordCount gt 0>   <!--- if AUSA's data available from LM --->
	<cfset ausa_fname = qry_ausa.first_name>
	<cfset ausa_lname = qry_ausa.last_name>
	<cfset ausa_title = qry_ausa.title>
	
	<!---<cfoutput>#ausa_fname#</cfoutput>--->	

<cfelse>  <!--- Initialize AUSA's variables if not found in LawManager --->

	<cfset ausa_fname = "">
	<cfset ausa_lname = "">
	<cfset ausa_title = "">		
	
</cfif>



<!---
<cfloop index = "LoopCount" from = "1" to = "51">

<cfoutput>#qry_last_submitted_data.tempvar_value#  </cfoutput>
The loop index is <cfoutput>#LoopCount#</cfoutput>.

</cfloop>
--->