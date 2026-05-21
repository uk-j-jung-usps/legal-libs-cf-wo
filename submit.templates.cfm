<cfscript>
	writeOutput("Processing templates for Legal Libs");
</cfscript>

<cfexecute
	name="D:\Java_Apps\CMFT\Run_CMFT.bat"
	errorFile="D:\Java_Apps\CMFT\Run_CMFT_bat_error.txt"
	outputFile="D:\Java_Apps\CMFT\Run_CMFT_bat_output.txt"
	timeout="120"
/>

<cfscript>
	writeOutput("<br>Processing is complete. Expect an email shortly...");
</cfscript>
