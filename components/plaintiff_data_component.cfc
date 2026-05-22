component displayname="Plaintiff Data Component" hint="Data access for plaintiff information." {

	/**
	 * Parses a "City, ST Zip" combined string into individual components.
	 * @citystzip The combined city/state/zip string.
	 * @return Struct with keys: city, state, zip.
	 */
	public struct function parseCityStZip(required string citystzip) {
		var result = { city: "", state: "", zip: "" };
		if (len(trim(arguments.citystzip))) {
			result.city = listFirst(arguments.citystzip);
			if (listLen(arguments.citystzip) >= 2) {
				result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
			}
			var zipindex = reFind("[0-9]{5}", arguments.citystzip);
			if (zipindex >= 1) {
				result.zip = mid(arguments.citystzip, zipindex, 5);
			}
		}
		return result;
	}

	/**
	 * Retrieves plaintiff entity by matter key (matter_entity_type_key = 33).
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name, plaintiff_eid, plaintiff_facility, plaintiff_district.
	 */
	public query function getPlaintiff(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name,
					b.usps_eid AS plaintiff_eid,
					trim(d.finance_name) AS plaintiff_facility,
					trim(e.lvl2_desc) || ', ' || trim(e.lvl3_desc) AS plaintiff_district
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 INNER JOIN lawmanager.fncm d ON a.usps_fac_id = d.lm_facility_key
			 INNER JOIN lawmanager.matterclientorgsusps e ON a.usps_client_orgs_key = e.usps_client_orgs_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 33",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves plaintiff address and email by entity key.
	 * @entityKey The entity_key to look up.
	 * @return Query with entity_key, street, city, state, zip_code, email.
	 */
	public query function getPlaintiffAddress(required numeric entityKey) {
		return queryExecute(
			"SELECT a.entity_key,
					trim(b.street) AS street,
					trim(b.city) AS city,
					b.state,
					trim(b.zip_code) AS zip_code,
					c.eaddress AS email
			 FROM lawmanager.entity a
			 LEFT JOIN lawmanager.address b ON a.entity_key = b.entity_key
			 LEFT JOIN lawmanager.eaddress c ON a.entity_key = c.entity_key
			 WHERE a.entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves plaintiff SSN from hr.emp_xref by entity key.
	 * @entityKey The entity_key to look up.
	 * @return Query with plaintiff_ssn column (may be empty if table not accessible).
	 */
	public query function getPlaintiffSSN(required numeric entityKey) {
		return queryExecute(
			"SELECT ssn AS plaintiff_ssn
			 FROM hr.emp_xref
			 WHERE entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves docket/case number for a matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with forum_number column.
	 */
	public query function getDocketNumber(required numeric matterKey) {
		return queryExecute(
			"SELECT forum_number
			 FROM lawmanager.forum
			 WHERE matter_key = :matterKey
			   AND venue_type_key IN (10, 11, 12, 13)
			   AND forum_type_key = 3",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves defendant name for a matter (matter_entity_type_key = 36).
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key and defendant columns.
	 */
	public query function getDefendant(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key, trim(b.name) AS defendant
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 36",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

}
