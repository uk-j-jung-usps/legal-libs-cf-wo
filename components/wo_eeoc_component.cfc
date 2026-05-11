component displayname="WO EEOC Component" hint="Data access functions for WO EEOC Legal Libs" {

	/**
	 * Retrieves matter details by matter_key including prefix, number, name, and type.
	 * @matterKey The matter_key to look up.
	 * @return Query result with matter_prefix, matter_number, matter_name, matter_type_key.
	 */
	public query function getMatterByKey(required numeric matterKey) {
		var qry = new query();
		qry.setDatasource("lawmanager");
		qry.addParam(name="matterKey", value=arguments.matterKey, cfsqltype="cf_sql_integer");
		var result = qry.execute(
			sql="SELECT substr(matter_number, 1, 2) AS matter_prefix,
					    matter_number,
					    matter_name,
					    matter_type_key
				 FROM matter
				 WHERE matter_key = :matterKey"
		);
		return result.getResult();
	}

    public query function qryAdviceSubpoena(required String matterNumber){
        var qry = new query();
        qry.setDatasource("lawmanager");
        qry.addParam(name="matterNumber", value=arguments.matterNumber, cfsqltype="cf_sql_varchar");
        var result = qry.execute(
            sql="SELECT a.matter_key, a.matter_type_key, a.matter_name
                 FROM matter a
                 INNER JOIN mattercategoryusps b ON a.matter_key = b.matter_key
                 WHERE matter_number = :matterNumber
                   AND b.category_type_key = 8
                   AND b.subcategory_type_key = 199"
        );
        return result.getResult();
    }

    public query function qryMatterNo(required String matterNumber) {
        var qry = new query();
        qry.setDatasource("lawmanager");
        qry.addParam(name="matterNumber", value=arguments.matterNumber, cfsqltype="cf_sql_varchar");
        var result = qry.execute(
            sql="SELECT substr(matter_number, 1, 2) as matter_prefix, matter_key, matter_type_key
                 FROM matter a
                 WHERE matter_number = :matterNumber"
        );
        return result.getResult();
    }

	/**
	 * Builds a URL query string from matter parameters.
	 * @matterKey The matter key.
	 * @matterNumber The matter number.
	 * @matterTypeKey The matter type key.
	 * @matterPrefix The matter prefix (optional).
	 * @includePrefix Whether to include matter_prefix in the query string. Default true.
	 * @return URL-encoded query string.
	 */
	public string function buildQS(
		required string matterKey,
		required string matterNumber,
		required string matterTypeKey,
		string matterPrefix = "",
		boolean includePrefix = true
	) {
		var qs = "matterkey=" & encodeForURL(arguments.matterKey)
		       & "&matternumber=" & encodeForURL(arguments.matterNumber)
		       & "&mattertypekey=" & encodeForURL(arguments.matterTypeKey);
		if (arguments.includePrefix && len(trim(arguments.matterPrefix))) {
			qs &= "&matter_prefix=" & encodeForURL(arguments.matterPrefix);
		}
		return qs;
	}

}