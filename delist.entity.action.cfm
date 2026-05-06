<!---
<cfoutput>
<cfif #len(entityid1)#>
#entityid1#<br>
</cfif>
</cfoutput>
--->


<cfif isdefined("entityid1")>
	<cfif #len(entityid1)#>
		<cfloop index = "ListElement1" list = "#entityid1#">
			<cfquery name="remove_hr_mgr" datasource="lawmanager">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '', sort_fld = ''
				where entity_key = '#ListElement1#'
			</cfquery>
		</cfloop>
	</cfif>
</cfif>


<cfif isdefined("entityid2")>
	<cfif #len(entityid2)#>
		<cfloop index = "ListElement2" list = "#entityid2#">
			<cfquery name="remove_lr_mgr" datasource="lawmanager" result="r">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '', sort_fld = ''
				where entity_key = '#ListElement2#'
			</cfquery>
		</cfloop>
	</cfif>
	<!---<cfoutput>#r.sql#</cfoutput>--->
</cfif>

<cfif isdefined("entityid3")>
<cfif #len(entityid3)#>
	<cfloop index = "ListElement3" list = "#entityid3#">
		<cfquery name="remove_dist_mgr" datasource="lawmanager">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '', sort_fld = ''
				where entity_key = '#ListElement3#'
		</cfquery>
	</cfloop>
</cfif>
</cfif>

<cfif isdefined("entityid4")>
	<cfif #len(entityid4)#>
		<cfloop index = "ListElement4" list = "#entityid4#">
			<cfquery name="remove_dist_mgr" datasource="lawmanager">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '', sort_fld = ''
				where entity_key = '#ListElement4#'
			</cfquery>
		</cfloop>
	</cfif>
</cfif>

<cfif isdefined("entityid5")>
	<cfif #len(entityid5)#>
		<cfloop index = "ListElement5" list = "#entityid5#">
			<cfquery name="remove_ohna_mgr" datasource="lawmanager">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '', sort_fld = ''
				where entity_key = '#ListElement5#'
			</cfquery>
		</cfloop>
	</cfif>
</cfif>

<cfif isdefined("entityid6")>
	<cfif #len(entityid6)#>
		<cfloop index = "ListElement6" list = "#entityid6#">
			<cfquery name="remove_attny" datasource="lawmanager">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '', sort_fld = ''
				where entity_key = '#ListElement6#'
			</cfquery>
		</cfloop>
	</cfif>
</cfif>

<cfif isdefined("entityid7")>
	<cfif #len(entityid7)#>
		<cfloop index = "ListElement7" list = "#entityid7#">
			<cfquery name="remove_plgl" datasource="lawmanager">
				UPDATE lawmanager.cmft_entity_wo
				set entity_role = '', sort_fld = ''
				where entity_key = '#ListElement7#'
			</cfquery>
		</cfloop>
	</cfif>
</cfif>


<cflocation url="delist.entity.cfm">











