component {
    remote function searchEntityTable(searchString) {
        /**
         * the searchString will come in as a json string so we need to deserialize it to an array of structs and then check to see what the values are before 
         * the sql string is returned.
         * we have LastNameOperator
         * LastNameValue
         * FirstNameOperator
         * FirstNameValue
         * 
         */
        writelog(text="this is search",type="information",file="lawlib-search");
        searchStuff = deserializeJson(arguments.searchString);
        lastNameOperator = searchStuff[1].value;
        lastNameValue = searchStuff[2].value;
        firstNameOperator = searchStuff[3].value;
        firstNameValue = searchStuff[4].value;
        
        whereClause = "WHERE ";
        if((len(lastNameValue) > 0) && lastNameOperator == "BEGINS_WITH") {
            whereClause = whereClause & "lawmanager.entity.last_name LIKE (:lastName || '%')";
        } else if ((len(lastNameValue) > 0) && lastNameOperator == "EQUALS") {
            whereClause = whereClause & "lawmanager.entity.last_name = :lastName";
        }
        if((len(firstNameValue) > 0) && firstNameOperator == "BEGINS_WITH" ) {
            whereClause = whereClause & "lawmanager.entity.first_name LIKE (:firstName || '%')";
        } else if ((len(firstNameValue) > 0) && firstNameOperator == "EQUALS") {
            whereClause = whereClause & "lawmanager.entity.first_name = :firstName";
        }
        whereClause = whereClause & " AND lawmanager.cmft_entity_wo.entity_key IS NULL AND lawmanager.entity.person_company_flag = :pcFlag AND lawmanager.entity.active_inactive_flag = :aiFlag AND lawmanager.entity.ba_code = :baCode ";

        sqlString = "SELECT lawmanager.entity.entity_key, lawmanager.entity.name FROM lawmanager.entity LEFT JOIN lawmanager.cmft_entity_wo ON lawmanager.entity.entity_key = lawmanager.cmft_entity_wo.entity_key " & whereClause & " ORDER BY lawmanager.entity.last_name, lawmanager.entity.first_name";
        writelog(text="#sqlstring#",type="information",file="lawlib-search");
        qry = new query();
        qry.setName("entityTableQuery");
        qry.setDatasource("lawmanager");
        qry.addParam(name="lastName",value="#lastNameValue#",cfsqltype="cf_sql_varchar");
        qry.addParam(name="firstName",value="#firstNameValue#",cfsqltype="cf_sql_varchar");
        qry.addParam(name="pcFlag",value="P",cfsqltype="cf_sql_varchar");
        qry.addParam(name="aiFlag",value="A",cfsqltype="cf_sql_varchar");
        qry.addParam(name="baCode",value="6E",cfsqltype="cf_sql_varchar");
        result = qry.execute(sql=sqlString).getResult();
        //resultjson = serializeJSON(data="#result#", queryFormat="true");
        //writelog(text="#resultjson#",type="information",file="lawlib-search");
        resultArr = convertToArray(result);
        return resultArr;

    }

    private function convertToArray(resultQry) {

        convertArr = arrayNew(1);
       // for(row in arguments.resultQry) {
        for (i = 1; i <= arguments.resultQry.recordCount; i++) {
            lmEntity = structnew();
            lmEntity.entity_key = arguments.resultQry["entity_key"][i];
            lmEntity.name = arguments.resultQry["name"][i];
            arrayAppend(convertArr,lmEntity);
        }
        return convertArr;
    }

    remote function getNameOfPerson(entityId) {
      try {  
        sqlString = "SELECT
        ( lawmanager.entity.first_name
          || ' '
          || lawmanager.entity.middle_name
          || ' '
          || lawmanager.entity.last_name ) AS entity_name,
          lawmanager.entity.entity_key as entity_key
    FROM
        lawmanager.entity
    WHERE
        lawmanager.entity.entity_key = :entityId";
        qry= new query();
        qry.setName("qEntityName");
        qry.setDataSource("lawmanager");
        qry.addParam(name="entityId",value="#arguments.entityId#",cfsqltype="cf_sql_numeric");
        
        result =qry.execute(sql=sqlString).getResult();
      } catch(any e) {
        writedump(var="#e#",abort="true");
      }
      resultArr = arrayNew(1);
      for(row in result) {
          temp = structnew();
          temp.entity_name = row.entity_name;
          temp.entity_key = row.entity_key;
          arrayappend(resultArr,temp);
         
      }
        return resultArr; 
    }

    remote function insertCmftRecord(cmftData) {
        try{
        insertData = deserializeJson(cmftData);
        returnMessage = "";
        for(i=1; i <= arraylen(insertData); i++) {
            returnMessage = ListAppend(returnMessage,insertData[i].value,"|");
        }
      
     sqlString = "insert into CMFT_ENTITY_WO (ENTITY_KEY, ENTITY_ROLE, ACTIVE_INACTIVE_FLAG, ADDED_BY, DATE_ADDED, ATTORNEY_NAME, GROUP_PREFIX) Values(
        :entityKey, :entityRole, :active, :addedBy, :addedDate, :attnyName, :groupPrefix )";
    qry = new query();
    qry.setdatasource("lawmanager");
    qry.setname("insertCmft");
    qry.addParam(name="entityKey", value="#insertData[1].value#", cfsqltype="cf_sql_numeric");
    qry.addparam(name="entityRole", value="#insertData[3].value#",cfsqltype="cf_sql_varchar");
    qry.addparam(name="active",value="A",cfsqltype="cf_sql_varchar");
    qry.addparam(name="addedBy",value="1234567", cfsqltype="cf_sql_varchar");
    qry.addparam(name="addedDate",value="#now()#",cfsqltype="cf_sql_timestamp");
    qry.addparam(name="attnyName",value="#insertData[2].value#",cfsqltype="cf_sql_varchar");
    qry.addparam(name="groupPrefix",value="WO",cfsqltype="cf_sql_varchar");
    result = qry.execute(sql=sqlstring).getPrefix();
        
        if(isdefined("result.recordcount") && result.recordcount == 1) {
            returnMessage = "Entity has been added to the selected list.";
        }
    } catch (any e) {
        
        returnMessage = e.message;
    }
        return returnMessage;
    }

    public function qEntityCategories(categoryName) {
        sqlString = "select initcap(first_name) ||' '|| initcap(last_name) as name  from entity a, cmft_entity_wo b where a.entity_key = b.entity_key and b.entity_role = :role and b.group_prefix=:groupPrefix order by last_name";

        qry = new query();
        qry.setdatasource("lawmanager");
        qry.setname("q_hr");
        qry.addParam(name="role",value="#arguments.categoryName#",cfsqltype="cf_sql_varchar");
        qry.addParam(name="groupPrefix",value="WO",cfsqltype="cf_sql_varchar");
        result = qry.execute(sql=sqlString).getResult();

        return result;
    }
}