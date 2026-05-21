<cfscript>
// Insert user-selected answers to dynamic template questions into CMFT_DYNAMIC_ANS table

// Default all answer variables
for (i = 1; i <= 11; i++) {
	if (!isDefined("answer#i#")) {
		variables["answer#i#"] = "";
	}
}

// Retrieve all template questions
qry_template_questions = queryExecute(
	"SELECT dynamic_quest_key, template_key FROM lawmanager.cmft_dynamic_quest ORDER BY dynamic_quest_key",
	{},
	{ datasource = "lawmanager" }
);

// Build answer lookup map keyed by question number
answerMap = {
	"1"  = answer1,
	"2"  = answer2,
	"3"  = answer3,
	"4"  = answer4,
	"5"  = answer5,
	"6"  = answer6,
	"7"  = answer7,
	"8"  = answer8,
	"9"  = answer9,
	"10" = answer10,
	"11" = answer11
};

// Insert each question's answer into the dynamic answers table
for (row in qry_template_questions) {
	var keyStr = toString(row.dynamic_quest_key);
	var answerValue = structKeyExists(answerMap, keyStr) ? answerMap[keyStr] : "";

	queryExecute(
		"INSERT INTO lawmanager.CMFT_DYNAMIC_ANS
			(dynamic_quest_key, matter_key, answer, date_added, added_by, template_key)
		 VALUES
			(:questKey, :matterKey, :answer, SYSDATE, :ownerKey, :templateKey)",
		{
			questKey    = { value = row.dynamic_quest_key, cfsqltype = "cf_sql_integer" },
			matterKey   = { value = matterkey, cfsqltype = "cf_sql_integer" },
			answer      = { value = answerValue, cfsqltype = "cf_sql_varchar" },
			ownerKey    = { value = owner_key, cfsqltype = "cf_sql_integer" },
			templateKey = { value = row.template_key, cfsqltype = "cf_sql_integer" }
		},
		{ datasource = "lawmanager" }
	);
}
</cfscript>
