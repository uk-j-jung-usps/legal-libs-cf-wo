<cfset serverName = CGI.SERVER_NAME>
<cfset serverPort = CGI.SERVER_PORT>
<cfset serverProtocol = CGI.SERVER_PROTOCOL>
<cfset httpHost = CGI.HTTP_HOST>

<cfset coldfusionVersion = SERVER.COLDFUSION.PRODUCTVERSION>
<cfset cfAppServerName = SERVER.COLDFUSION.APPSERVER>

<cfset serverNameOne = getPageContext().getRequest().getServerName()>
<cfset aceid = #mid(AUTH_USER,8,6)#>


<!--- Debug: Show what we're checking --->
<cfset debugInfo = "">
<cfif FindNoCase("localhost", serverName) OR FindNoCase("127.0.0.1", serverName)>
    <cfset environment = "local">
    <cfset debugInfo = "Matched: localhost or 127.0.0.1">
<cfelseif FindNoCase("eagnmnss58b", serverName)>
    <cfset environment = "DEV">
    <cfset debugInfo = "Matched: DEV">
<cfelseif FindNoCase("eagnmnwbd240", serverName)>
    <cfset environment = "SIT">
    <cfset debugInfo = "Matched: SIT">
<cfelseif FindNoCase("eagnmnss29c", serverName)>
    <cfset environment = "CAT">
    <cfset debugInfo = "Matched: CAT">
<cfelse>
    <cfset environment = "production">
    <cfset debugInfo = "NO MATCH - defaulted to production">
</cfif>

<!--- Display Server Info --->
<cfoutput>
	<h2>User: #aceid#</h2>
    <h2>Server Information</h2>
    <p><strong>CGI Server Name:</strong> #serverName#</p>
	<p><strong>Server Name One:</strong> #serverNameOne#</p>
	<p><strong>CF App Server Name:</strong> #cfAppserverName#</p>
	<p><strong>Port Number:</strong> #serverPort#</p>
	<p><strong>Server Protocol:</strong> #serverProtocol#</p>
	<p><strong>Http Host:</strong> #httpHost#</p>
    <p><strong>Environment:</strong> <span style="color: red; font-weight: bold;">#environment#</span></p>
    <p><strong>Debug:</strong> <span style="color: blue;">#debugInfo#</span></p>
    <p><strong>ColdFusion Version:</strong> #coldfusionVersion#</p>
    <hr>
    
</cfoutput>