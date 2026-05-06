


		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(appellant_rep_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset appellant_rep_city = ListFirst(appellant_rep_citystzip) >
				<cfset appellant_rep_state = Left(Trim(ListGetAt(appellant_rep_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",appellant_rep_citystzip)>
				<cfif zipindex gte 1>
					<cfset appellant_rep_zip = Mid(appellant_rep_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset appellant_rep_zip = 0>
				</cfif>	
			<cfelse>
				<cfset appellant_rep_city = "">
				<cfset appellant_rep_state = "">
				<cfset appellant_rep_zip = "">			
			</cfif>
		<cfelse>
			<cfset appellant_rep_addr= "">
			<cfset appellant_rep_city = "">
			<cfset appellant_rep_state = "">
			<cfset appellant_rep_zip = "">
		</cfif>


