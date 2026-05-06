
	<!---*** If Advice FSSC template has been submitted before, populate the screen with the previously-run data and answers to questions ***--->
	<cfinclude template = "submitted.data.advice_fssc.cfm"><!--- grab last submitted data from cmft_matterkey_pairs table--->

	
	<cfquery name="qry_cmft_dynamic_quest_dd" datasource="lawmanager">
	  select * from CMFT_DYNAMIC_QUEST_DD where dynamic_key=9 order by dynamic_dd_key
	</cfquery>


	<!--- ********** Query templates for specific matter type**********--->
	<cfquery name="qry_template_questions" datasource="lawmanager">
	  select * from cmft_dynamic_quest where dynamic_quest_key >0 and dynamic_quest_key < 12 order by dynamic_quest_key
	</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>	

<script language="JavaScript" src="calendar5.js"></script>
<script language="JavaScript" src="validation.js"></script>

<script type="text/javascript">
 
	function CheckValue() // if you pass the form, checkValue(form)
	{
	 alert('Answering "Yes" to this question requires information for "PO Boxholder Name" and "LKN/PO Box Location"');
	 
	}
</script>

<script language=JavaScript>
function start()
{
        var f=document.getElementById("first");
        var s=document.getElementById("second");
        var l=document.getElementById("last");
        f.style.display = 'none';
        s.style.display = 'none';
        l.style.display = 'none';
}
function disp_div() {
       var word = document.advice_subpoena.via.selectedIndex;
       var selected_text = document.advice_subpoena.via.options[word].text;
       var f=document.getElementById("first");
       var s=document.getElementById("second");
       var l=document.getElementById("last");
        if (selected_text == 'Fax'){
                 f.style.display = 'block';
                 s.style.display = 'none';
                 l.style.display = 'none';
        }else if (selected_text == 'Priority Mail w. Tracking No.'){
                f.style.display = 'none';
                s.style.display = 'block';
                l.style.display = 'none';
        }else if (selected_text == 'First Class Mail'){
                f.style.display = 'none';
                s.style.display = 'none';
                l.style.display = 'block';
        }
}      
</script>



<SCRIPT LANGUAGE="JAVASCRIPT">
function RadioValidator()
{
  var ShowAlert = '';
  var AllFormElements = window.document.getElementById("advice_subpoena").elements;
  for (i = 0; i < AllFormElements.length; i++) 
  {
      if (AllFormElements[i].type == 'radio') 
      {
          var ThisRadio = AllFormElements[i].name;
          var ThisChecked = 'No';
          var AllRadioOptions = document.getElementsByName(ThisRadio);
          for (x = 0; x < AllRadioOptions.length; x++)
          {
               if (AllRadioOptions[x].checked && ThisChecked == 'No')
               {
                   ThisChecked = 'Yes';
                   break;
               } 
          }   
          var AlreadySearched = ShowAlert.indexOf(ThisRadio);
          if (ThisChecked == 'No' && AlreadySearched == -1)
          {
          ShowAlert =  ShowAlert + ThisRadio + ' is missing.\n';
          //alert(ShowAlert);
          }     
      }
  }
  if (ShowAlert != '')
  {
  alert(ShowAlert);
  return false;
  }
  else
  {
  return true;
  }
}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<link href="css/form.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#ffffff"
			leftmargin="0"
			topmargin="5"
			marginheight="5"
			marginwidth="0"
			background="img/bck_yellowbox1.gif"
			onload="start()">

<cfform id="fssc" action="save.input.data.cfm"  method="post" enctype="application/x-www-form-urlencoded" name="advice_subpoena" enablecab="yes" onsubmit="return validateForm()">	

<input name="matterkey" type="hidden" value="<cfoutput>#url.matterkey#</cfoutput>" >
<input name="mattertypekey" type="hidden" value="<cfoutput>#url.mattertypekey#</cfoutput>" >

<div class="styleSelect">

<table align="center" width="85%" border="0" cellspacing="2" cellpadding="2" bgcolor="#ffffff" >
	<tr>
	<td colspan=2 class=TextMaingrcolapan=5 bgcolor="#D9E9EA"> <a href="case.files.home.cfm"> Home </a> &nbsp;&nbsp;&nbsp;
	<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D<cfoutput>#matterkey#</cfoutput>" target="_blank"> LawManager</a> &nbsp;&nbsp;&nbsp;
<!---	<a href="admin.pages.cfm"> Legal Libs Admin </a>--->
	<td align=right class=TextMaingr colspan=5 bgcolor="#D9E9EA" >	<b>Advice-FSSC</b>

 <tr>
 <td colspan=5>  <br></td>
	
	<tr>
		<td width=13% align="right" >USPS Reference# </td>
		<td width=28%><cfinput type="text" size="12" name="matternumber"  value="#url.matternumber#"   tabindex=1> </td>
		
		<td width=16% align="right" >WO Office </td>
		<td colspan=2>
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_office" size="1" tabindex=11>
					<option value="Denver">Denver</option>
					<option value="Long Beach">Long Beach</option>
					<option value="Salt Lake">Salt Lake</option>
					<option value="San Diego">San Diego</option>
					<option value="San Francisco">San Francisco</option>
					<option value="Seattle">Seattle</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_office" size="1" tabindex=11>
						<option value="#alo_office#" selected="selected">#alo_office#</option>
						<option value="Denver">Denver</option>
						<option value="Long Beach">Long Beach</option>
						<option value="Salt Lake">Salt Lake</option>
						<option value="San Diego">San Diego</option>
						<option value="San Francisco">San Francisco</option>
						<option value="Seattle">Seattle</option>							
					</select>
				</cfoutput>				
			</cfif>
		</td>			


 <tr>
		<td  align="right" class=TextMaingr>Work Order No. </td>
		<td > <cfinput type="text" size="50" name="work_order_no"  value="#work_order_no#" maxlength="50"  tabindex=2></td>

		<td align="right" class=TextMaingr>WO Address1 </td>
		<td colspan=2>
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr1" size=2 tabindex=12 multiple>
					<!---<option value="">Select One...</option>	--->		
					<option value="1745 Stout Street, Suite 500">1745 Stout Street, Suite 500</option>
					<option value="300 Long Beach Blvd., Rm 240">300 Long Beach Blvd., Rm 240</option>
					<option value="9350 South 150 East, Suite 800">9350 South 150 East, Suite 800</option>
					<option value="11255 Rancho Carmel Dr., Rm 1440">11255 Rancho Carmel Dr., Rm 1440</option>
					<option value="1300 Evans Ave., Rm 217 P.O. Box 883790">1300 Evans Ave., Rm 217 P.O. Box 883790</option>
					<option value="P.O. Box 3686">P.O. Box 3686</option>
			
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_addr1" size="2" tabindex=12 multiple>
						<option value="#alo_addr1#" selected="selected">#alo_addr1#</option>
						<!---<option value="">Select One...</option>--->			
						<option value="1745 Stout Street, Suite 500">1745 Stout Street, Suite 500</option>
						<option value="300 Long Beach Blvd., Rm 240">300 Long Beach Blvd., Rm 240</option>
						<option value="9350 South 150 East, Suite 800">9350 South 150 East, Suite 800</option>
						<option value="11255 Rancho Carmel Dr., Rm 1440">11255 Rancho Carmel Dr., Rm 1440</option>
						<option value="1300 Evans Ave., Rm 217 P.O. Box 883790">1300 Evans Ave., Rm 217 P.O. Box 883790</option>
						<option value="P.O. Box 3686">P.O. Box 3686</option>
									
					</select>
				</cfoutput>				
			</cfif>			
		</td>			
		

 <tr>
		<td  align="right" >Requester</td>
		<td > <cfinput type="text" size="50" name="recipient_name"  value="#recipient_name#" maxlength="50"  tabindex=3></td>

		<td align="right" class=TextMaingr>WO Address2 </td>
		<td colspan=2>
			<cfif not qry_last_submitted_data.RecordCount gt 0>
				<select name="alo_addr2" size="1" tabindex=13>
					<!---<option value="">Select One...</option>--->			
					<option value="Denver, CO 80299-5555">Denver, CO 80299-5555</option>
					<option value="Long Beach, CA 90802-2496">Long Beach, CA 90802-2496</option>
					<option value="Sandy, UT 84070-2716">Sandy, UT 84070-2716</option>
					<option value="San Diego, CA 92197-4400">San Diego, CA 92197-4400</option>
					<option value="San Francisco, CA 94188-3790">San Francisco, CA 94188-3790</option>
					<option value="Seattle, WA 98124-3686">Seattle, WA 98124-3686</option>
				</select>
			<cfelse>
				<cfoutput>
					<select name="alo_addr2" size="2" tabindex=13>
						<option value="#alo_addr2#" selected="selected">#alo_addr2#</option>			
						<option value="Denver, CO 80299-5555">Denver, CO 80299-5555</option>
						<option value="Long Beach, CA 90802-2496">Long Beach, CA 90802-2496</option>
						<option value="Sandy, UT 84070-2716">Sandy, UT 84070-2716</option>
						<option value="San Diego, CA 92197-4400">San Diego, CA 92197-4400</option>
						<option value="San Francisco, CA 94188-3790">San Francisco, CA 94188-3790</option>
						<option value="Seattle, WA 98124-3686">Seattle, WA 98124-3686</option>
					</select>
				</cfoutput>				
			</cfif>				
		</td>	


 <tr>
		<td align="right" > Requester's Address </td>
		<td ><cfinput type="text" size="50" name="recipient_addr"  value="#recipient_addr#" maxlength="50"  tabindex=4> </td> 
 
		<td  valign=top align="right" >Dispatched Via</td>
	 <cfif not qry_last_submitted_data.RecordCount gt 0>	<!--- first time template submitted --->
	 	<cfset via1="">
				<td >	
						<select name="via" size="1" tabindex=14 onchange="disp_div()";>	
							<option value="">-- Select One --</option>		
							<option value="Via Fax">Fax</option>
							<option value="Via USPS Priority Mail w/Tracking" >Priority Mail w. Tracking No.</option>
							<option value="Via First Class Mail">First Class Mail</option>
						</select>

				</td>
				<td valign=top  width=25%>
			 	<div id="first">
						Fax# <cfinput type="text" size="25" name="fax_no"  value="" maxlength="25"> 
					</div>				
			 	<div id="second">
						Track# <cfinput type="text" size="34" name="tracking_no"  value="" maxlength="35">				
					</div>
				</td>	
		<cfelse> <!--- when template submitted before --->
				<td >		
					<cfset via1="">
					<cfif via eq "Via USPS Priority Mail w/Tracking">
						<cfset via1 = "Priority Mail w. Tracking No.">
					</cfif>
					
					<cfif via eq "Via Fax">
						<cfset via1 = "Fax">
					</cfif>

					<cfif via eq "Via First Class Mail">
						<cfset via1 = "Via First Class Mail">
					</cfif>

					<select name="via" size="1" tabindex=15 onchange="disp_div()">	
						<option value="<cfoutput>#via#</cfoutput>" selected="selected"><cfoutput>#via1#</cfoutput></option>		
						<option value="Via Fax">Fax</option>
						<option value="Via USPS Priority Mail w/Tracking" >Priority Mail w. Tracking No.</option>
						<option value="Via First Class Mail">First Class Mail</option>
					</select>
				</td>

				<td valign=top  width=25%>				
			 	<div id="first">
						Fax# <cfinput type="text" size="25" name="fax_no"  value="#fax_no#" maxlength="25" > 
					</div>				
			 	<div id="second">
						Track# <cfinput type="text" size="34" name="tracking_no"  value="#tracking_no#" maxlength="35">				
					</div>
				</td>
		</cfif>		

		
 <tr>
		<td align="right" class=TextMaingr> Requester's City </td>
		<td  ><cfinput type="text" size="20" name="recipient_city"  value="#recipient_city#" maxlength="20" tabindex=5>&nbsp;State &nbsp;<cfinput type="text" size="2" name="recipient_state"  value="#recipient_state#" maxlength="2" tabindex=6> &nbsp;Zip&nbsp;<cfinput type="text" size="5" name="recipient_zip"  value="#recipient_zip#" maxlength="11" tabindex=7 > </td>	

		<td align="right" class=TextMaingr>WO Phone </td>
		<td colspan=2>

		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_phone" size="1" tabindex=15>
				<option value="">Select One...</option>			
				<option value="(206) 381-6620">(206) 381-6624</option>
				<option value="(206) 381-6624">(206) 381-6624</option>
				<option value="(206) 381-6623">(206) 381-6623</option>
				<option value="(206) 381-6625">(206) 381-6625</option>
				<option value="(206) 381-6626">(206) 381-6626</option>
				<option value="(206) 381-6628">(206) 381-6628</option>
				<option value="(303) 313-5560">(303) 313-5560</option>
				<option value="(303) 313-5567">(303) 313-5569</option>
				<option value="(303) 313-5577">(303) 313-5577</option>
				<option value="(303) 313-5579">(303) 313-5579</option>
				<option value="(303) 313-5791">(303) 313-5791</option>
				<option value="(415) 550-5300">(415) 550-5300</option>
				<option value="(415) 550-5381">(415) 550-5381</option>
				<option value="(415) 550-5397">(415) 550-5397</option>
				<option value="(415) 550-5473">(415) 550-5473</option>
				<option value="(415) 550-5493">(415) 550-5493</option>
				<option value="(415) 550-5495">(415) 550-5495</option>
				<option value="(562) 628-1340">(562) 628-1340</option>
				<option value="(562) 628-1344">(562) 628-1344</option>
				<option value="(562) 628-1345">(562) 628-1345</option>
				<option value="(562) 628-1346">(562) 628-1346</option>
				<option value="(562) 628-1347">(562) 628-1347</option>
				<option value="(562) 628-1350">(562) 628-1350</option>
				<option value="(562) 628-1351">(562) 628-1351</option>
				<option value="(562) 628-1354">(562) 628-1354</option>
				<option value="(562) 628-1357">(562) 628-1357</option>
				<option value="(801) 984-8400">(801) 984-8400</option>
				<option value="(801) 984-8403">(801) 984-8403</option>
				<option value="(801) 984-8404">(801) 984-8404</option>
				<option value="(801) 984-8420">(801) 984-8420</option>
				<option value="(801) 984-8423">(801) 984-8423</option>
				<option value="(801) 984-8428">(801) 984-8428</option>
				<option value="(801) 984-8432">(801) 984-8432</option>
				<option value="(858) 674-2686">(858) 674-2686</option>
				<option value="(858) 674-2738">(858) 674-2738</option>
				<option value="(858) 674-2742">(858) 674-2742</option>
				<option value="(858) 674-2748">(858) 674-2748</option>
			</select>
		<cfelse>
		<cfoutput>
		 <cfif len(trim(#alo_phone#))>              
			 <select name="alo_phone" size="1" tabindex=15>
				<option value="#alo_phone#" selected="selected">#alo_phone#</option>	
				<option value="(206) 381-6620">(206) 381-6624</option>
				<option value="(206) 381-6624">(206) 381-6624</option>
				<option value="(206) 381-6623">(206) 381-6623</option>
				<option value="(206) 381-6625">(206) 381-6625</option>
				<option value="(206) 381-6626">(206) 381-6626</option>
				<option value="(206) 381-6628">(206) 381-6628</option>
				<option value="(303) 313-5560">(303) 313-5560</option>
				<option value="(303) 313-5567">(303) 313-5569</option>
				<option value="(303) 313-5577">(303) 313-5577</option>
				<option value="(303) 313-5579">(303) 313-5579</option>
				<option value="(303) 313-5791">(303) 313-5791</option>
				<option value="(415) 550-5300">(415) 550-5300</option>
				<option value="(415) 550-5381">(415) 550-5381</option>
				<option value="(415) 550-5397">(415) 550-5397</option>
				<option value="(415) 550-5473">(415) 550-5473</option>
				<option value="(415) 550-5493">(415) 550-5493</option>
				<option value="(415) 550-5495">(415) 550-5495</option>
				<option value="(562) 628-1340">(562) 628-1340</option>
				<option value="(562) 628-1344">(562) 628-1344</option>
				<option value="(562) 628-1345">(562) 628-1345</option>
				<option value="(562) 628-1346">(562) 628-1346</option>
				<option value="(562) 628-1347">(562) 628-1347</option>
				<option value="(562) 628-1350">(562) 628-1350</option>
				<option value="(562) 628-1351">(562) 628-1351</option>
				<option value="(562) 628-1354">(562) 628-1354</option>
				<option value="(562) 628-1357">(562) 628-1357</option>
				<option value="(801) 984-8400">(801) 984-8400</option>
				<option value="(801) 984-8403">(801) 984-8403</option>
				<option value="(801) 984-8404">(801) 984-8404</option>
				<option value="(801) 984-8420">(801) 984-8420</option>
				<option value="(801) 984-8423">(801) 984-8423</option>
				<option value="(801) 984-8428">(801) 984-8428</option>
				<option value="(801) 984-8432">(801) 984-8432</option>
				<option value="(858) 674-2686">(858) 674-2686</option>
				<option value="(858) 674-2738">(858) 674-2738</option>
				<option value="(858) 674-2742">(858) 674-2742</option>
				<option value="(858) 674-2748">(858) 674-2748</option>				
				 </select>
				<cfelse>
			 <select name="alo_phone" size="1" tabindex=16>
				<option value="(206) 381-6620">(206) 381-6624</option>
				<option value="(206) 381-6624">(206) 381-6624</option>
				<option value="(206) 381-6623">(206) 381-6623</option>
				<option value="(206) 381-6625">(206) 381-6625</option>
				<option value="(206) 381-6626">(206) 381-6626</option>
				<option value="(206) 381-6628">(206) 381-6628</option>
				<option value="(303) 313-5560">(303) 313-5560</option>
				<option value="(303) 313-5567">(303) 313-5569</option>
				<option value="(303) 313-5577">(303) 313-5577</option>
				<option value="(303) 313-5579">(303) 313-5579</option>
				<option value="(303) 313-5791">(303) 313-5791</option>
				<option value="(415) 550-5300">(415) 550-5300</option>
				<option value="(415) 550-5381">(415) 550-5381</option>
				<option value="(415) 550-5397">(415) 550-5397</option>
				<option value="(415) 550-5473">(415) 550-5473</option>
				<option value="(415) 550-5493">(415) 550-5493</option>
				<option value="(415) 550-5495">(415) 550-5495</option>
				<option value="(562) 628-1340">(562) 628-1340</option>
				<option value="(562) 628-1344">(562) 628-1344</option>
				<option value="(562) 628-1345">(562) 628-1345</option>
				<option value="(562) 628-1346">(562) 628-1346</option>
				<option value="(562) 628-1347">(562) 628-1347</option>
				<option value="(562) 628-1350">(562) 628-1350</option>
				<option value="(562) 628-1351">(562) 628-1351</option>
				<option value="(562) 628-1354">(562) 628-1354</option>
				<option value="(562) 628-1357">(562) 628-1357</option>
				<option value="(801) 984-8400">(801) 984-8400</option>
				<option value="(801) 984-8403">(801) 984-8403</option>
				<option value="(801) 984-8404">(801) 984-8404</option>
				<option value="(801) 984-8420">(801) 984-8420</option>
				<option value="(801) 984-8423">(801) 984-8423</option>
				<option value="(801) 984-8428">(801) 984-8428</option>
				<option value="(801) 984-8432">(801) 984-8432</option>
				<option value="(858) 674-2686">(858) 674-2686</option>
				<option value="(858) 674-2738">(858) 674-2738</option>
				<option value="(858) 674-2742">(858) 674-2742</option>
				<option value="(858) 674-2748">(858) 674-2748</option>				
				 </select>				
				</cfif>
		</cfoutput>		
		</cfif>			

		</td>			


	<tr>
		<td align="right" class=TextMaingr >Case No. </td>
		<td ><cfinput type="text" size="50" name="case_no"  value="#case_no#" maxlength="50"  tabindex=8> </td>	

		<td align="right" class=TextMaingr>WO Fax </td>
		<td colspan=2>
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<select name="alo_fax" size="1" tabindex=17>
					<option value="">Select One...</option>			
					<option value="(303) 313-5561">(303) 313-5561</option>
					<option value="(650) 357-6705">(650) 357-6705</option>
					<option value="(801) 984-8401">(801) 984-8401</option>
					<option value="(650) 578-3806">(650) 578-3806</option>
					<option value="(650) 578-1817">(650) 578-1817</option>
					<option value="(650) 577-5679">(650) 577-5679</option>
					<option value="(206) 381-6621">(206) 381-6621</option>
			</select>
		<cfelse>
		<cfoutput>
		 <cfif len(trim(#alo_fax#))> 		
				<select name="alo_fax" size="1" tabindex=16>
					<option value="#alo_fax#" selected="selected"> #alo_fax#</option>
					<option value="(303) 313-5561">(303) 313-5561</option>
					<option value="(650) 357-6705">(650) 357-6705</option>
					<option value="(801) 984-8401">(801) 984-8401</option>
					<option value="(650) 578-3806">(650) 578-3806</option>
					<option value="(650) 578-1817">(650) 578-1817</option>
					<option value="(650) 577-5679">(650) 577-5679</option>
					<option value="(206) 381-6621">(206) 381-6621</option>					
				</select>
				<cfelse>
				<select name="alo_fax" size="1" tabindex=16>
					<option value="(303) 313-5561">(303) 313-5561</option>
					<option value="(650) 357-6705">(650) 357-6705</option>
					<option value="(801) 984-8401">(801) 984-8401</option>
					<option value="(650) 578-1817">(650) 578-1817</option>
					<option value="(650) 577-5679">(650) 577-5679</option>
					<option value="(206) 381-6621">(206) 381-6621</option>				
				</select>				
				
				</cfif>				
		</cfoutput>		
		</cfif>			
		</td>					
	</tr>	

 <tr>
		<td width=12% align="right" class=TextMaingr >Plaintiff/Petitioner and Defendant/Respondent </td>
		<cfif not qry_last_submitted_data.RecordCount gt 0>
				<td ><cfinput type="text" size="50" name="case_name"  value="#mattername#"  maxlength="50" tabindex=9> </td> 
		<cfelse>
				<td ><cfinput type="text" size="50" name="case_name"  value="#case_name#"  maxlength="50" tabindex=9> </td> 
		</cfif>
		
		<td align="right" >Date Subpoena <br>Received </td>
		<td  colspan=2><input name="recvd_date" tabindex=17 type="text" value="<cfoutput>#DateFormat(recvd_date, "mm/dd/yyyy")#</cfoutput>"  size=11 maxlength="10" onchange="CheckDate(this)" onkeydown="FormatDate(this, window.event.keyCode,'down')" onkeyup="FormatDate(this, window.event.keyCode,'up')" > <img src="img/cal.gif" alt="Display Calendar" onClick="javascript:rec_date.popup();"> (mm/dd/yyyy)</td>

	</tr>

	<tr>
		<td  align="right" class=TextMaingr>PO Boxholder Name </td>
		<td > <cfinput type="text" size="50" name="customer_name"  value="#customer_name#" maxlength="50"  tabindex=10></td> 
				
		<td align="right" class=TextMaingr>LKN/PO Box Location </td>
		<td colspan=2><cfinput type="text" size="50" name="po_loc_lkn_box"  value="#po_loc_lkn_box#" tabindex=18> </td>			

	</tr>

	<tr>		<td  colspan=5 align="right" class=TextMaingr ><hr ></td>			

</table>

<!---	**********************************************************************************************************</td>--->

<table align="center" width="85%" border="0" cellspacing="4" cellpadding="4" bgcolor="#ffffff" >
<tr>
	<td colspan=3><b>All questions listed below must be answered.</b>

	
<cfoutput Query="qry_template_questions">
<tr>

 <td width=14 valign=middle> #qry_template_questions.dynamic_quest_key#-</td>
 <td width=70%>#qry_template_questions.question#  </td>
 <td >
 				
  <cfswitch expression="#qry_template_questions.dynamic_quest_key#">

	 <cfcase value="1">
	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer1" value="1" tabindex=19>Yes 
			  <cfinput type="radio"  name="answer1" value="0" tabindex=20>No
		 <cfelse>
			 	<cfif answer1 eq "1">
			  	<cfinput type="radio"  name="answer1" value="1" tabindex=19 checked="checked">Yes
			   <cfinput type="radio"  name="answer1" value="0" tabindex=20 >No		  	 
			  </cfif>
	
			  <cfif answer1 eq "0">
			 	 <cfinput type="radio"  name="answer1" value="1" tabindex=19 >Yes
			   <cfinput type="radio"  name="answer1" value="0" tabindex=20 checked="checked">No		 
			  </cfif>
		 </cfif>	 
	 </cfcase>


	 <cfcase value="2">
		 <select name="answer2" size="1" tabindex=21>
			<option value="6">Both testimony and records</option>
			<option value="7" >Testimony only</option>
			<option value="8" >Documents only</option>							
		 </select>	 
	 </cfcase>

	 <cfcase value="3">
	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer3" value="1" tabindex=22>Yes 
			  <cfinput type="radio"  name="answer3" value="0" tabindex=23>No
		 <cfelse>
			 	<cfif answer3 eq "1">
			  	<cfinput type="radio"  name="answer3" value="1" tabindex=22 checked="checked">Yes
			   <cfinput type="radio"  name="answer3" value="0" tabindex=23 >No		  	 
			  </cfif>
	
			  <cfif answer3 eq "0">
			 	 <cfinput type="radio"  name="answer3" value="1" tabindex=22 >Yes
			   <cfinput type="radio"  name="answer3" value="0" tabindex=23 checked="checked">No		 
			  </cfif>
		 </cfif>
	 </cfcase>

	 <cfcase value="4">
	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer4" value="1" tabindex=24 onclick="CheckValue()"/>Yes 
			  <cfinput type="radio"  name="answer4" value="0" tabindex=25>No
		 <cfelse>
			 	<cfif answer4 eq "1">
			  	<cfinput type="radio"  name="answer4" value="1" tabindex=24 checked="checked" onclick="CheckValue()"/>Yes
			   <cfinput type="radio"  name="answer4" value="0" tabindex=25 >No		  	 
			  </cfif>
	
			  <cfif answer4 eq "0">
			 	 <cfinput type="radio"  name="answer4" value="1" tabindex=24 onclick="CheckValue()"/>Yes
			   <cfinput type="radio"  name="answer4" value="0" tabindex=25 checked="checked">No		 
			  </cfif>
		 </cfif>
	 </cfcase>


	 <cfcase value="5">
	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer5" value="1" tabindex=26 >Yes 
			  <cfinput type="radio"  name="answer5" value="0" tabindex=27>No
		 <cfelse>
			 	<cfif answer5 eq "1">
			  	<cfinput type="radio"  name="answer5" value="1" tabindex=26 checked="checked" > Yes
			   <cfinput type="radio"  name="answer5" value="0" tabindex=27 >No		  	 
			  </cfif>
	
			  <cfif answer5 eq "0">
			 	 <cfinput type="radio"  name="answer5" value="1" tabindex=26 >Yes
			   <cfinput type="radio"  name="answer5" value="0" tabindex=27 checked="checked">No		 
			  </cfif>
		 </cfif>
	 </cfcase>


	 <cfcase value="6">
	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer6" value="1" tabindex=28>Yes 
			  <cfinput type="radio"  name="answer6" value="0" tabindex=29>No
		 <cfelse>
			 	<cfif answer6 eq "1">
			  	<cfinput type="radio"  name="answer6" value="1" tabindex=28 checked="checked">Yes
			   <cfinput type="radio"  name="answer6" value="0" tabindex=29 >No		  	 
			  </cfif>
	
			  <cfif answer6 eq "0">
			 	 <cfinput type="radio"  name="answer6" value="1" tabindex=28 >Yes
			   <cfinput type="radio"  name="answer6" value="0" tabindex=29 checked="checked">No		 
			  </cfif>
		 </cfif>
	 </cfcase>


	 <cfcase value="7">

	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer7" value="1" tabindex=30>Yes 
			  <cfinput type="radio"  name="answer7" value="0" tabindex=31>No
		 <cfelse>
			 	<cfif answer7 eq "1">
			  	<cfinput type="radio"  name="answer7" value="1" tabindex=30 checked="checked">Yes
			   <cfinput type="radio"  name="answer7" value="0" tabindex=31 >No		  	 
			  </cfif>
	
			  <cfif answer7 eq "0">
			 	 <cfinput type="radio"  name="answer7" value="1" tabindex=30 >Yes
			   <cfinput type="radio"  name="answer7" value="0" tabindex=31 checked="checked">No		 
			  </cfif>
		 </cfif>
	 </cfcase>


	 <cfcase value="8">
	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer8" value="1" tabindex=32>Yes 
			  <cfinput type="radio"  name="answer8" value="0" tabindex=33>No
		 <cfelse>
			 	<cfif answer8 eq "1">
			  	<cfinput type="radio"  name="answer8" value="1" tabindex=32 checked="checked">Yes
			   <cfinput type="radio"  name="answer8" value="0" tabindex=33 >No		  	 
			  </cfif>
	
			  <cfif answer8 eq "0">
			 	 <cfinput type="radio"  name="answer8" value="1" tabindex=32 >Yes
			   <cfinput type="radio"  name="answer8" value="0" tabindex=33 checked="checked">No		 
			  </cfif>
		 </cfif>
	 </cfcase>


	 <cfcase value="9">
		 <select name="answer9" size="1" tabindex=34>
			<option value="1">Deposition Testimony</option>
			<option value="2" >Records Production</option>
			<option value="3" >Deposition Testimony and Production of Docs</option>
		 </select>
	 </cfcase>


	 <cfcase value="10">
		 <select name="answer10" size="1" tabindex=35>
			<option value="9" >Provide records</option>			 
			<option value="4">Provide testimony</option>
			<option value="5" >Provide testimony and records</option>					
			
		 </select>
	 </cfcase>


	 <cfcase value="11">
	 	<cfif not qry_last_submitted_data_answers.RecordCount gt 0>
			  <cfinput type="radio"  name="answer11" value="1" tabindex=36>Yes 
			  <cfinput type="radio"  name="answer11" value="0" tabindex=37>No
		 <cfelse>
			 	<cfif answer11 eq "1">
			  	<cfinput type="radio"  name="answer11" value="1" tabindex=36 checked="checked">Yes
			   <cfinput type="radio"  name="answer11" value="0" tabindex=37 >No		  	 
			  </cfif>
	
			  <cfif answer11 eq "0">
			 	 <cfinput type="radio"  name="answer11" value="1" tabindex=36 >Yes
			   <cfinput type="radio"  name="answer11" value="0" tabindex=37 checked="checked">No		 
			  </cfif>
		 </cfif>
	 </cfcase>

	 </cfswitch>

	</cfoutput>

</table>

<table align="center" width="85%" border="0" cellspacing="4" cellpadding="4" bgcolor="#ffffff" >
	<tr>
		<td colspan=5 align=middle><br><br><input type="image" src="img/submit3.png" width=66 height=24 border=0  value="submit" onclick="return RadioValidator();" >	<span id="error" style="display:none;"></span></td>
</table>

</div>
</cfform>

<script language="JavaScript">
	<!-- // create calendar object(s) just after form tag closed
	 // specify form element as the only parameter (document.forms['formname'].elements['inputname']);
	 // note: you can have as many calendar objects as you need for your application
	
	var rec_date = new calendar5(document.advice_subpoena.recvd_date);

	
	
	//-->
</script>

<!---<cfoutput>#via#</cfoutput>--->
</body>
</html>


