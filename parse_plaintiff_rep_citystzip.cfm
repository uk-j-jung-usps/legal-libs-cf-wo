

		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(plaintiff_rep_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset plaintiff_rep_city = ListFirst(plaintiff_rep_citystzip) >
				<cfset plaintiff_rep_state = Left(Trim(ListGetAt(plaintiff_rep_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",plaintiff_rep_citystzip)>
				<cfif zipindex gte 1>
					<cfset plaintiff_rep_zip = Mid(plaintiff_rep_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset plaintiff_rep_zip = 0>
				</cfif>	
			<cfelse>
				<cfset plaintiff_rep_city = "">
				<cfset plaintiff_rep_state = "">
				<cfset plaintiff_rep_zip = "">			
			</cfif>
		<cfelse>
			<cfset plaintiff_rep_addr= "">
			<cfset plaintiff_rep_city = "">
			<cfset plaintiff_rep_state = "">
			<cfset plaintiff_rep_zip = "">
		</cfif>



