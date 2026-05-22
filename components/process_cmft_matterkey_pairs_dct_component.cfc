component displayname="Process CMFT Matterkey Pairs DCT Component" hint="Data access and helper functions for DCT (District Court) matterkey pairs processing." {

	/**
	 * Converts a string to proper case, handling ampersand characters.
	 * @input The string to convert.
	 * @return Proper-cased string.
	 */
	public string function toProperCase(required string input) {
		var result = reReplace(lCase(arguments.input), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL");
		var ampPos = find("&", result, 1);
		if (ampPos != 0 && ampPos < len(result)) {
			result = left(result, ampPos) & uCase(mid(result, ampPos + 1, 1)) & mid(result, ampPos + 2, len(result) - ampPos - 1);
		}
		return result;
	}

	/**
	 * Concatenates city, state, and zip into a formatted string.
	 * @city The city name.
	 * @state The state abbreviation.
	 * @zip The zip code.
	 * @return Formatted "City, ST Zip" string or concatenation of available parts.
	 */
	public string function formatCityStateZip(required string city, required string state, required string zip) {
		if (len(trim(arguments.city)) && len(trim(arguments.state)) && len(trim(arguments.zip))) {
			return trim(arguments.city) & ", " & trim(arguments.state) & " " & trim(arguments.zip);
		}
		return trim(arguments.city) & trim(arguments.state) & trim(arguments.zip);
	}

	/**
	 * Retrieves all relevant template variables for DCT (matter_type_key = 5).
	 * @return Query with tempvar_key and tempvar_name.
	 */
	public query function getTempVars() {
		return queryExecute(
			"SELECT tempvar_key, tempvar_name
			 FROM lawmanager.cmft_tempvars
			 WHERE (matter_type_key = :matterTypeKey5
			        OR matter_type_key = :matterTypeKey0)
			   AND control IS NULL",
			{
				matterTypeKey5 = { value = 5, cfsqltype = "cf_sql_integer" },
				matterTypeKey0 = { value = 0, cfsqltype = "cf_sql_integer" }
			},
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves attorney email from EADDRESS table by attorney name.
	 * @attorneyName The attorney name to look up.
	 * @return Query with eaddress column.
	 */
	public query function getAttorneyEmail(required string attorneyName) {
		return queryExecute(
			"SELECT c.eaddress
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
			 INNER JOIN lawmanager.eaddress c ON a.entity_key = c.entity_key
			 WHERE b.attorney_name = :attorneyName",
			{ attorneyName = { value = arguments.attorneyName, cfsqltype = "cf_sql_varchar" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Inserts a template variable pair into CMFT_MATTERKEY_PAIRS.
	 * @matterKey The matter_key for the record.
	 * @tempvarKeyName The template variable name.
	 * @tempvarValue The template variable value.
	 * @tempvarKey The template variable key (numeric).
	 * @ownerKey The owner_key (can be empty string for null).
	 */
	public void function insertMatterkeyPair(
		required numeric matterKey,
		required string tempvarKeyName,
		required string tempvarValue,
		required numeric tempvarKey,
		required string ownerKey
	) {
		queryExecute(
			"INSERT INTO lawmanager.cmft_matterkey_pairs
				(matter_key, tempvar_key_name, tempvar_value, tempvar_key, date_added, added_by)
			 VALUES (
				:matterKey,
				:tempvarKeyName,
				:tempvarValue,
				:tempvarKey,
				:dateAdded,
				:ownerKey
			 )",
			{
				matterKey      = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" },
				tempvarKeyName = { value = arguments.tempvarKeyName, cfsqltype = "cf_sql_varchar" },
				tempvarValue   = { value = arguments.tempvarValue, cfsqltype = "cf_sql_varchar" },
				tempvarKey     = { value = arguments.tempvarKey, cfsqltype = "cf_sql_integer" },
				dateAdded      = { value = now(), cfsqltype = "cf_sql_timestamp" },
				ownerKey       = { value = arguments.ownerKey, cfsqltype = "cf_sql_integer", null = !len(trim(arguments.ownerKey)) }
			},
			{ datasource = "lawmanager" }
		);
	}

}
