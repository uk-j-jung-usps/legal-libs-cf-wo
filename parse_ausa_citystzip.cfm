



		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(ajs_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset ausa_city = ListFirst(ajs_citystzip) >
				<cfset ausa_state = Left(Trim(ListGetAt(ajs_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",ajs_citystzip)>
				<cfif zipindex gte 1>
					<cfset ausa_zip = Mid(ajs_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset ausa_zip = 0>
				</cfif>	
			<cfelse>
				<cfset ausa_city = "">
				<cfset ausa_state = "">
				<cfset ausa_zip = "">			
			</cfif>
		<cfelse>
			<cfset ausa_addr= "">
			<cfset ausa_city = "">
			<cfset ausa_state = "">
			<cfset ausa_zip = "">
		</cfif>
