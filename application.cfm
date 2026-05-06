
<CFSET SERVER_IP = "#CGI.SERVER_NAME#">
<CFSET IP = "#CGI.SERVER_NAME#">
<!--- setting datasource name --->
<cfset datasrc = "lawmanager">


<cfapplication name="Legal Libs" 
	clientmanagement="YES" 
	sessionmanagement="YES" 
	setclientcookies="YES" 
	setdomaincookies="No" 
	searchimplicitscopes="yes"
	sessiontimeout="#CreateTimeSpan(0,1,30,0)#">
	<CFPARAM NAME="client.user_id" DEFAULT=''>
	<CFPARAM NAME="client.password" DEFAULT=''>
	<CFPARAM NAME="client.region_id" DEFAULT=''>	
	<!---
	<CFCOOKIE NAME="CFID" VALUE="#CLIENT.CFID#">
    <CFCOOKIE NAME="CFTOKEN" VALUE="#CLIENT.CFTOKEN#">
	<CFCOOKIE NAME="CFID" VALUE="#SESSION.CFID#">
    <CFCOOKIE NAME="CFTOKEN" VALUE="#SESSION.CFTOKEN#">
	--->


<!--- no caching --->
<CFHEADER Name="Expires" Value="#Now()#">  
<!--- timeout warning 
<CF_TIMEOUTWARNING WarningThreshold="2" TimeOutMinutes="30"> --->
