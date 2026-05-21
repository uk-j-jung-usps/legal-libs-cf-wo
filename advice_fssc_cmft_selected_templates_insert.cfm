<cfscript>
// Retrieve the base_key from CMFT_BASE for this matter_key
get_base_key = queryExecute(
	"SELECT base_key FROM lawmanager.cmft_base WHERE matter_key = :matterKey",
	{ matterKey = { value = matterkey, cfsqltype = "cf_sql_integer" } },
	{ datasource = "lawmanager" }
);

cmft_base_key = get_base_key.base_key;

// Insert a record into CMFT_SELECTED_TEMPLATES for the Advice-FSSC template (template_key = 73)
queryExecute(
	"INSERT INTO lawmanager.CMFT_SELECTED_TEMPLATES
		(base_key, template_key, date_added, added_by)
	 VALUES
		(:baseKey, :templateKey, SYSDATE, :ownerKey)",
	{
		baseKey     = { value = cmft_base_key, cfsqltype = "cf_sql_integer" },
		templateKey = { value = 73, cfsqltype = "cf_sql_integer" },
		ownerKey    = { value = owner_key, cfsqltype = "cf_sql_integer" }
	},
	{ datasource = "lawmanager" }
);
</cfscript>
