


		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif isdefined('comp_rep_citystzip') AND  len(comp_rep_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset comp_rep_city = ListFirst(comp_rep_citystzip) >
				<cfset comp_rep_state = Left(Trim(ListGetAt(comp_rep_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",comp_rep_citystzip)>
				<cfif zipindex gte 1>
					<cfset comp_rep_zip = Mid(comp_rep_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset comp_rep_zip = 0>
				</cfif>	
			<cfelse>
				<cfset comp_rep_city = "">
				<cfset comp_rep_state = "">
				<cfset comp_rep_zip = "">			
			</cfif>
		<cfelse>
			<cfset comp_rep_addr= "">
			<cfset comp_rep_city = "">
			<cfset comp_rep_state = "">
			<cfset comp_rep_zip = "">
		</cfif>


