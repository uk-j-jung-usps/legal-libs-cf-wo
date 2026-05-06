
<!---*** Loop to update the HR Managers list ***--->
<cfif isdefined("combo_key_hr")>
	<cfif #len(combo_key_hr)#>
	<cfoutput>	
			<cfloop index = "combo_key_hr" list = "#combo_key_hr#">
			
				<cfquery name="update_cmft_entity" datasource="lawmanager" >
					UPDATE lawmanager.cmft_entity_wo
					set sort_fld = <cfif IsNumeric("#left(combo_key_hr,4)#")>
												   '#left(combo_key_hr,4)#'
												 <cfelse>
													 1
												 </cfif>																						
					where entity_key = '#mid(combo_key_hr,5,26)#'
				</cfquery>

			</cfloop>
	</cfoutput>
	</cfif>
</cfif>


<!---*** Loop to update the LR Managers list ***--->
<cfif isdefined("combo_key_lr")>
	<cfif #len(combo_key_lr)#>
	<cfoutput>
		<cfloop index = "combo_key_lr" list = "#combo_key_lr#">

			<cfquery name="update_cmft_entity" datasource="lawmanager" >
				UPDATE lawmanager.cmft_entity_wo
				set sort_fld = <cfif IsNumeric("#left(combo_key_lr,4)#")>
											   '#left(combo_key_lr,4)#'
											 <cfelse>
												 1
											 </cfif>																									
				where entity_key = '#mid(combo_key_lr,5,26)#'
			</cfquery>

		</cfloop>
	</cfoutput>
	</cfif>
</cfif>


<!---*** Loop to update the District Managers list ***--->
<cfif isdefined("combo_key_dmgr")>
	<cfif #len(combo_key_dmgr)#>
	<cfoutput>
		<cfloop index = "combo_key_dmgr" list = "#combo_key_dmgr#">

			<cfquery name="update_cmft_entity" datasource="lawmanager" >
				UPDATE lawmanager.cmft_entity_wo
				set sort_fld = <cfif IsNumeric("#left(combo_key_dmgr,4)#")>
											   '#left(combo_key_dmgr,4)#'
											 <cfelse>
												 1
											 </cfif>																									
				where entity_key = '#mid(combo_key_dmgr,5,26)#'
			</cfquery>

		</cfloop>
	</cfoutput>
	</cfif>
</cfif>


<!---*** Loop to update the H&R Managers - District list ***--->
<cfif isdefined("combo_key_hr_dist")>
	<cfif #len(combo_key_hr_dist)#>
	<cfoutput>
		<cfloop index = "combo_key_hr_dist" list = "#combo_key_hr_dist#">

			<cfquery name="update_cmft_entity" datasource="lawmanager" >
				UPDATE lawmanager.cmft_entity_wo
				set sort_fld = <cfif IsNumeric("#left(combo_key_hr_dist,4)#")>
											   '#left(combo_key_hr_dist,4)#'
											 <cfelse>
												 1
											 </cfif>																										
				where entity_key = '#mid(combo_key_hr_dist,5,26)#'
			</cfquery>

		</cfloop>
	</cfoutput>
	</cfif>
</cfif>


<!---*** Loop to update the OHNA Managers list ***--->
<cfif isdefined("combo_key_ohna")>
	<cfif #len(combo_key_ohna)#>
	<cfoutput>
		<cfloop index = "combo_key_ohna" list = "#combo_key_ohna#">

			<cfquery name="update_cmft_entity" datasource="lawmanager" >
				UPDATE lawmanager.cmft_entity_wo
				set sort_fld = <cfif IsNumeric("#left(combo_key_ohna,4)#")>
											   '#left(combo_key_ohna,4)#'
											 <cfelse>
												 1
											 </cfif>																			
				where entity_key = '#mid(combo_key_ohna,5,26)#'
			</cfquery>

		</cfloop>
	</cfoutput>
	</cfif>
</cfif>


<!---*** Loop to update the Attorneys list ***--->
<cfif isdefined("combo_key_attny")>
	<cfif #len(combo_key_attny)#>
	<cfoutput>
		<cfloop index = "combo_key_attny" list = "#combo_key_attny#">

			<cfquery name="update_cmft_entity" datasource="lawmanager" >
				UPDATE lawmanager.cmft_entity_wo
				set sort_fld = <cfif IsNumeric("#left(combo_key_attny,4)#")>
											   '#left(combo_key_attny,4)#'
											 <cfelse>
												 1
											 </cfif>																			
				where entity_key = '#mid(combo_key_attny,5,26)#'
			</cfquery>

		</cfloop>
	</cfoutput>
	</cfif>
</cfif>


<!---*** Loop to update the Paralegals list ***--->
<cfif isdefined("combo_key_plgl")>
	<cfif #len(combo_key_plgl)#>
	<cfoutput>
		<cfloop index = "combo_key_plgl" list = "#combo_key_plgl#">

			<cfquery name="update_cmft_entity" datasource="lawmanager" >
				UPDATE lawmanager.cmft_entity_wo
				set sort_fld = <cfif IsNumeric("#left(combo_key_plgl,4)#")>
											   '#left(combo_key_plgl,4)#'
											 <cfelse>
												 1
											 </cfif>																			
				where entity_key = '#mid(combo_key_plgl,5,26)#'
			</cfquery>

		</cfloop>
	</cfoutput>
	</cfif>
</cfif>


<cflocation url="sort.entity.list.cfm">









