<cfscript>
/*
	Process the dynamic template "MSPB Template Ltr Applnt Rep Req Auth final.rtf" (template_key = 80).
	Handles the radio button question (dynamic_quest_key = 24):
	"Are there allegations directly implicating a work related injury?"
	If answered "Yes", saves the reason text into cmft_matterkey_pairs.
*/

// Default variables
param name="owcp_answer" default="";
param name="owcp_because" default="";

// Remove any previous answer for this question/matter combination
queryExecute(
	"DELETE FROM lawmanager.CMFT_DYNAMIC_ANS
	 WHERE matter_key = :matterKey AND dynamic_quest_key = :questKey",
	{
		matterKey = { value = matterkey, cfsqltype = "cf_sql_integer" },
		questKey  = { value = 24, cfsqltype = "cf_sql_integer" }
	},
	{ datasource = "lawmanager" }
);

// Insert the user's answer for the radio button question
queryExecute(
	"INSERT INTO lawmanager.CMFT_DYNAMIC_ANS
		(dynamic_quest_key, matter_key, answer, date_added, added_by, template_key)
	 VALUES
		(:questKey, :matterKey, :answer, SYSDATE, :ownerKey, :templateKey)",
	{
		questKey    = { value = 24, cfsqltype = "cf_sql_integer" },
		matterKey   = { value = matterkey, cfsqltype = "cf_sql_integer" },
		answer      = { value = owcp_answer, cfsqltype = "cf_sql_varchar" },
		ownerKey    = { value = ownerkey, cfsqltype = "cf_sql_integer" },
		templateKey = { value = 80, cfsqltype = "cf_sql_integer" }
	},
	{ datasource = "lawmanager" }
);

// Save the "because" reason text into cmft_matterkey_pairs (tempvar_key = 148)
queryExecute(
	"INSERT INTO lawmanager.CMFT_MATTERKEY_PAIRS
		(matter_key, tempvar_key_name, tempvar_value, tempvar_key, date_added, added_by)
	 VALUES
		(:matterKey, :keyName, :keyValue, :tempvarKey, SYSDATE, :ownerKey)",
	{
		matterKey  = { value = matterkey, cfsqltype = "cf_sql_integer" },
		keyName    = { value = "BECAUSE", cfsqltype = "cf_sql_varchar" },
		keyValue   = { value = trim(owcp_because), cfsqltype = "cf_sql_varchar" },
		tempvarKey = { value = 148, cfsqltype = "cf_sql_integer" },
		ownerKey   = { value = ownerkey, cfsqltype = "cf_sql_integer" }
	},
	{ datasource = "lawmanager" }
);
</cfscript>
