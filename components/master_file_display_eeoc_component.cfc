component displayname="Master File Display EEOC Component" hint="Data access and helper functions for EEOC master file detail display." {

	/**
	 * Renders an HTML select option with proper selected state.
	 * @value The option value and display text.
	 * @currentValue The currently selected value to compare against.
	 * @return HTML option string.
	 */
	public string function renderOption(required string value, string currentValue = "") {
		var isSelected = (len(trim(arguments.currentValue)) && trim(arguments.currentValue) == trim(arguments.value)) ? ' selected="selected"' : '';
		return '<option value="#encodeForHTMLAttribute(arguments.value)#"#isSelected#>#encodeForHTML(arguments.value)#</option>';
	}

	/**
	 * Retrieves entity list by role from cmft_entity_wo table.
	 * @entityRole The entity_role code (e.g., 'LRMGR', 'HRMGR', 'DMGR', 'HRDST', 'OHNA', 'PLGL').
	 * @groupPrefix The group_prefix filter (default 'WO').
	 * @return Query with entity_key and name.
	 */
	public query function getEntityListByRole(required string entityRole, string groupPrefix = "WO") {
		return queryExecute(
			"SELECT b.entity_key,
					initcap(first_name) || ' ' || initcap(last_name) AS name
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
			 WHERE b.entity_role = :entityRole
			   AND b.group_prefix = :groupPrefix
			 ORDER BY b.sort_fld",
			{
				entityRole  = { value = arguments.entityRole, cfsqltype = "cf_sql_varchar" },
				groupPrefix = { value = arguments.groupPrefix, cfsqltype = "cf_sql_varchar" }
			},
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves attorney list from cmft_entity_wo table.
	 * Uses attorney_name column instead of first_name/last_name.
	 * @groupPrefix The group_prefix filter (default 'WO').
	 * @return Query with entity_key and name.
	 */
	public query function getAttorneyList(string groupPrefix = "WO") {
		return queryExecute(
			"SELECT b.entity_key, b.attorney_name AS name
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
			 WHERE b.entity_role = 'ATTNY'
			   AND b.group_prefix = :groupPrefix
			 ORDER BY b.sort_fld",
			{ groupPrefix = { value = arguments.groupPrefix, cfsqltype = "cf_sql_varchar" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves EEOC forum numbers for a given matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with forum_number column.
	 */
	public query function getEeocNumberList(required numeric matterKey) {
		return queryExecute(
			"SELECT forum_number
			 FROM lawmanager.forum
			 WHERE matter_key = :matterKey",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

}
