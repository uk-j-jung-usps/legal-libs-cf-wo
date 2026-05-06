/***********************************************************************************************************************************
 CUSTOM DATE FUNCTIONS WRITTEN BY Dest@pobox.com
	FormatDate()-  AUTOINSERTS the /'s IN A DATE
	CheckDate()- Validates Date Entered is a Valid Date

	COPY AND PASTE THE FOLLOWING INTO YOUR INPUT FIELD AND CHANGE TO APPROPRIATE FRAME LOCATION (ie: parent. or self.) :
	onchange="CheckDate(this)" onkeydown="FormatDate(this, window.event.keyCode,'down')" onkeyup="FormatDate(this, window.event.keyCode,'up')"
***********************************************************************************************************************************/
function Change_Case(frm,type){
	var new_val = document[frm][type].value;
	new_val = new_val.toUpperCase();
	document[frm][type].value = new_val;
}

function FormatDate(i, delKey,direction) {
  if (i.value.length < 10) {
  	if (delKey!=9) { //tab
	  	if(delKey!=8 && delKey!=46 && delKey!=16 &&  !(delKey>36 && delKey<41)){ //if the delete, backspace, shift, are not the keys that caused the keyup event.
  			var fieldLen = i.value.length
   			if ((delKey >= 48 && delKey <= 57) || (delKey >= 96 && delKey <=105)) {
   				if (fieldLen == 2 || fieldLen == 5) {
      				i.value = i.value + "/";
		     	}
   			} else {
   				if (direction == "up") {
     				if (i.value.length == 0) {
      					i.value = ""
	     			} else {
		      			i.value = i.value.substring(0,i.value.length-1)
	   				}
    			}
	 		}
  			i.focus()
	  	}
 	} else {
 		if (direction == "down") {
	 		CheckDate(i)
  		}
  	}
 }
}
function CheckDate(THISDATE) {
	var err=0
	a=THISDATE.value
	if (a.length != 10) err=1
	b = a.substring(0, 2)// month
	c = a.substring(2, 3)// '/'
	d = a.substring(3, 5)// day
	e = a.substring(5, 6)// '/'
	f = a.substring(6, 10)// year
	if (b<1 || b>12) err = 1
	if (d<1 || d>31) err = 1
	if (f<1900) err = 1
	if (b==4 || b==6 || b==9 || b==11){
		if (d==31) err=1
	}
	if (b==2){
		var g=parseInt(f/4)
		if (isNaN(g)) {
			err=1
		}
		if (d>29) err=1
		if (d==29 && ((f/4)!=parseInt(f/4))) err=1
	}

        if (a=="") {err=0}

        if (err==1) {
		alert(THISDATE.value + ' is not a valid date. Please re-enter.');
		THISDATE.value = ""
	}
}

function toAlphaNumber(inputname,checkString)
{
    var newString = "";    // REVISED/CORRECTED STRING
    var count = 0;         // COUNTER FOR LOOPING THROUGH STRING

	checkString = checkString.replace("$", "");
	checkString = checkString.replace(",", "");

    // LOOP THROUGH STRING CHARACTER BY CHARACTER
    for (var i = 0; i < checkString.length; i++)
	 {
        var ch = checkString.substring(i, i+1);

		{
        // ENSURE CHARACTER IS AN ALPHA OR NUMERIC CHARACTER
        	if ((ch >= "0" && ch <= "9") || (ch = ".")){
            newString += ch;
        	}
		}
    }

    if (checkString != newString) {
	alert("Please enter a number in this field");
	//document.formname.inputname.focus();
	var blank = "";
	return blank;
    }
    return checkString;
}

function LimitText(fieldObj,maxChars)
{
  var result = true;
  if (fieldObj.value.length >= maxChars){
		alert('Maximum number of characters has been reached for this field.');
    result = false;
	}
  if (window.event)
    window.event.returnValue = result;
  return result;
}

function chng_action(process){
	if (process == 'pay'){
		document.pass_var_pay.submit();
	}
	else if (process == 'time'){
		document.pass_var_time.submit();
	}
	else if (process == 'addi'){
		document.pass_var_addi.submit();
	}
  else if (process == 'del'){
    if (confirm("Are you sure you want to delete this work item?")) {
      document.pass_var_del.submit();
    }
	}
}

function rtrim(strMyString) {
    //alert(strMyString);
	return(strMyString.replace(/^\s*/,""));
}

function ltrim(strMyString) {
    return(strMyString.replace(/\s*$/, ""));
}

function trim(strMyString) {
    return(rtrim(ltrim(strMyString)));
}

// ===================================================================
// Author: Matt Kruse <matt@mattkruse.com>
// WWW: https://www.mattkruse.com/
//
// NOTICE: You may use this code for any purpose, commercial or
// private, without any further permission from the author. You may
// remove this notice from your final code if you wish, however it is
// appreciated by the author if at least my web site address is kept.
//
// You may *NOT* re-distribute this code in any way except through its
// use. That means, you can include it in your product, or your web
// site, or any other form where the code is actually being used. You
// may not put the plain javascript up on your site for download or
// include it in your javascript libraries for download.
// If you wish to share this code with others, please just point them
// to the URL instead.
// Please DO NOT link directly to my .js files from your site. Copy
// the files to your server and use them there. Thank you.
// ===================================================================


// ------------------------------------------------------------------
// These functions use the same 'format' strings as the
// java.text.SimpleDateFormat class, with minor exceptions.
// The format string consists of the following abbreviations:
//
// Field        | Full Form          | Short Form
// -------------+--------------------+-----------------------
// Year         | yyyy (4 digits)    | yy (2 digits), y (2 or 4 digits)
// Month        | MMM (name or abbr.)| MM (2 digits), M (1 or 2 digits)
// Day of Month | dd (2 digits)      | d (1 or 2 digits)
// Hour (1-12)  | hh (2 digits)      | h (1 or 2 digits)
// Hour (0-23)  | HH (2 digits)      | H (1 or 2 digits)
// Hour (0-11)  | KK (2 digits)      | K (1 or 2 digits)
// Hour (1-24)  | kk (2 digits)      | k (1 or 2 digits)
// Minute       | mm (2 digits)      | m (1 or 2 digits)
// Second       | ss (2 digits)      | s (1 or 2 digits)
// AM/PM        | a                  |
//
// NOTE THE DIFFERENCE BETWEEN MM and mm! Month=MM, not mm!
// Examples:
//  "MMM d, y" matches: January 01, 2000
//                      Dec 1, 1900
//                      Nov 20, 00
//  "M/d/yy"   matches: 01/20/00
//                      9/2/00
//  "MMM dd, yyyy hh:mm:ssa" matches: "January 01, 2000 12:30:45AM"
// ------------------------------------------------------------------

var MONTH_NAMES=new Array('January','February','March','April','May','June','July','August','September','October','November','December','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
function LZ(x) {return(x<0||x>9?"":"0")+x}

// ------------------------------------------------------------------
// isDate ( date_string, format_string )
// Returns true if date string matches format of format string and
// is a valid date. Else returns false.
// It is recommended that you trim whitespace around the value before
// passing it to this function, as whitespace is NOT ignored!
// ------------------------------------------------------------------
function isDate(val,format) {
	var date=getDateFromFormat(val,format);
	if (date==0) { return false; }
	return true;
	}

// -------------------------------------------------------------------
// compareDates(date1,date1format,date2,date2format)
//   Compare two date strings to see which is greater.
//   Returns:
//   1 if date1 is greater than date2
//   0 if date2 is greater than date1 of if they are the same
//  -1 if either of the dates is in an invalid format
// -------------------------------------------------------------------
function compareDates(date1,dateformat1,date2,dateformat2) {
	var d1=getDateFromFormat(date1,dateformat1);
	var d2=getDateFromFormat(date2,dateformat2);
	if (d1==0 || d2==0) {
		return -1;
		}
	else if (d1 > d2) {
		return 1;
		}
	return 0;
	}

// ------------------------------------------------------------------
// formatDate (date_object, format)
// Returns a date in the output format specified.
// The format string uses the same abbreviations as in getDateFromFormat()
// ------------------------------------------------------------------
function formatDate(date,format) {
	format=format+"";
	var result="";
	var i_format=0;
	var c="";
	var token="";
	var y=date.getYear()+"";
	var M=date.getMonth()+1;
	var d=date.getDate();
	var H=date.getHours();
	var m=date.getMinutes();
	var s=date.getSeconds();
	var yyyy,yy,MMM,MM,dd,hh,h,mm,ss,ampm,HH,H,KK,K,kk,k;
	// Convert real date parts into formatted versions
	var value=new Object();
	if (y.length < 4) {y=""+(y-0+1900);}
	value["y"]=""+y;
	value["yyyy"]=y;
	value["yy"]=y.substring(2,4);
	value["M"]=M;
	value["MM"]=LZ(M);
	value["MMM"]=MONTH_NAMES[M-1];
	value["d"]=d;
	value["dd"]=LZ(d);
	value["H"]=H;
	value["HH"]=LZ(H);
	if (H==0){value["h"]=12;}
	else if (H>12){value["h"]=H-12;}
	else {value["h"]=H;}
	value["hh"]=LZ(value["h"]);
	if (H>11){value["K"]=H-12;} else {value["K"]=H;}
	value["k"]=H+1;
	value["KK"]=LZ(value["K"]);
	value["kk"]=LZ(value["k"]);
	if (H > 11) { value["a"]="PM"; }
	else { value["a"]="AM"; }
	value["m"]=m;
	value["mm"]=LZ(m);
	value["s"]=s;
	value["ss"]=LZ(s);
	while (i_format < format.length) {
		c=format.charAt(i_format);
		token="";
		while ((format.charAt(i_format)==c) && (i_format < format.length)) {
			token += format.charAt(i_format++);
			}
		if (value[token] != null) { result=result + value[token]; }
		else { result=result + token; }
		}
	return result;
	}

// ------------------------------------------------------------------
// Utility functions for parsing in getDateFromFormat()
// ------------------------------------------------------------------
function _isInteger(val) {
	var digits="1234567890";
	for (var i=0; i < val.length; i++) {
		if (digits.indexOf(val.charAt(i))==-1) { return false; }
		}
	return true;
	}
function _getInt(str,i,minlength,maxlength) {
	for (var x=maxlength; x>=minlength; x--) {
		var token=str.substring(i,i+x);
		if (token.length < minlength) { return null; }
		if (_isInteger(token)) { return token; }
		}
	return null;
	}

// ------------------------------------------------------------------
// getDateFromFormat( date_string , format_string )
//
// This function takes a date string and a format string. It matches
// If the date string matches the format string, it returns the
// getTime() of the date. If it does not match, it returns 0.
// ------------------------------------------------------------------
function getDateFromFormat(val,format) {
	val=val+"";
	format=format+"";
	var i_val=0;
	var i_format=0;
	var c="";
	var token="";
	var token2="";
	var x,y;
	var now=new Date();
	var year=now.getYear();
	var month=now.getMonth()+1;
	var date=now.getDate();
	var hh=now.getHours();
	var mm=now.getMinutes();
	var ss=now.getSeconds();
	var ampm="";

	while (i_format < format.length) {
		// Get next token from format string
		c=format.charAt(i_format);
		token="";
		while ((format.charAt(i_format)==c) && (i_format < format.length)) {
			token += format.charAt(i_format++);
			}
		// Extract contents of value based on format token
		if (token=="yyyy" || token=="yy" || token=="y") {
			if (token=="yyyy") { x=4;y=4; }
			if (token=="yy")   { x=2;y=2; }
			if (token=="y")    { x=2;y=4; }
			year=_getInt(val,i_val,x,y);
			if (year==null) { return 0; }
			i_val += year.length;
			if (year.length==2) {
				if (year > 70) { year=1900+(year-0); }
				else { year=2000+(year-0); }
				}
			}
		else if (token=="MMM"){
			month=0;
			for (var i=0; i<MONTH_NAMES.length; i++) {
				var month_name=MONTH_NAMES[i];
				if (val.substring(i_val,i_val+month_name.length).toLowerCase()==month_name.toLowerCase()) {
					month=i+1;
					if (month>12) { month -= 12; }
					i_val += month_name.length;
					break;
					}
				}
			if ((month < 1)||(month>12)){return 0;}
			}
		else if (token=="MM"||token=="M") {
			month=_getInt(val,i_val,token.length,2);
			if(month==null||(month<1)||(month>12)){return 0;}
			i_val+=month.length;}
		else if (token=="dd"||token=="d") {
			date=_getInt(val,i_val,token.length,2);
			if(date==null||(date<1)||(date>31)){return 0;}
			i_val+=date.length;}
		else if (token=="hh"||token=="h") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<1)||(hh>12)){return 0;}
			i_val+=hh.length;}
		else if (token=="HH"||token=="H") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<0)||(hh>23)){return 0;}
			i_val+=hh.length;}
		else if (token=="KK"||token=="K") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<0)||(hh>11)){return 0;}
			i_val+=hh.length;}
		else if (token=="kk"||token=="k") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<1)||(hh>24)){return 0;}
			i_val+=hh.length;hh--;}
		else if (token=="mm"||token=="m") {
			mm=_getInt(val,i_val,token.length,2);
			if(mm==null||(mm<0)||(mm>59)){return 0;}
			i_val+=mm.length;}
		else if (token=="ss"||token=="s") {
			ss=_getInt(val,i_val,token.length,2);
			if(ss==null||(ss<0)||(ss>59)){return 0;}
			i_val+=ss.length;}
		else if (token=="a") {
			if (val.substring(i_val,i_val+2).toLowerCase()=="am") {ampm="AM";}
			else if (val.substring(i_val,i_val+2).toLowerCase()=="pm") {ampm="PM";}
			else {return 0;}
			i_val+=2;}
		else {
			if (val.substring(i_val,i_val+token.length)!=token) {return 0;}
			else {i_val+=token.length;}
			}
		}
	// If there are any trailing characters left in the value, it doesn't match
	if (i_val != val.length) { return 0; }
	// Is date valid for month?
	if (month==2) {
		// Check for leap year
		if ( ( (year%4==0)&&(year%100 != 0) ) || (year%400==0) ) { // leap year
			if (date > 29){ return false; }
			}
		else { if (date > 28) { return false; } }
		}
	if ((month==4)||(month==6)||(month==9)||(month==11)) {
		if (date > 30) { return false; }
		}
	// Correct hours value
	if (hh<12 && ampm=="PM") { hh=hh-0+12; }
	else if (hh>11 && ampm=="AM") { hh-=12; }
	var newdate=new Date(year,month-1,date,hh,mm,ss);
	return newdate.getTime();
	}

function check_mandatory(frm,type){

        var sta = trim(document[frm].status.value);
        var rcv = new Date(document[frm].date_rcvd.value);
        var ass = document[frm].assigned_emp.value;
        var off = document[frm].office.value;
        var cat = trim(document[frm].cat.value);
        var subc = document[frm].sub_cat.value;
        var des = document[frm].description.value;
        var clnt = document[frm].level_1_desc.value;
        var manner_of_disposn = trim(document[frm].manner_of_disposn.value);
        var date_disp = new Date(document[frm].date_disp.value);

        dToday = new Date();

        if (type =='L'){
				var date_scc_add = new Date(2999, 6, 7);  // Date as of when SCC is required July 7, 2003 (yyyy,mm,dd)
				var date_origofflr_add = new Date(2003, 9, 1);  // Date as of when SCC is required October 1, 2003 (yyyy,mm,dd)
        var date_nlrb_info = new Date(2003, 8, 7);  // Date as of when SCC is required November, 1 2003 (yyyy,mm,dd)

				var cas = document[frm].case_name.value;
				var docket = document[frm].docket.value;
				var juris = trim(document[frm].data_entry_value.value); // Jurisdiction

				var f_adr = trim(document[frm].first_adr.value);
				var f_adr_dt = new Date(document[frm].f_adr_dt.value);
				var f_adr_out = document[frm].first_adr_outcome.value;

				var s_adr = trim(document[frm].second_adr.value);
				var s_adr_dt = new Date(document[frm].s_adr_dt.value);
				var s_adr_out = document[frm].second_adr_outcome.value;

				var date_eval = new Date(document[frm].date_eval.value);
				var date_inci = new Date(document[frm].date_inci.value);
				var mon_liab = document[frm].mon_liab.value;
				var relief_paid = document[frm].relief_paid.value;
				var atty_agn = document[frm].atty_agn.value;
				var mon_rem = document[frm].mon_rem.value;
				var atty_for = document[frm].atty_for.value;
				var disp_filed = document[frm].disp_filed.value;
				var granted = document[frm].granted.value;
				var clntnot45 = document[frm].clntnot45.value;
				var eeo_no = document[frm].eeo_no.value;
				var origofflr = document[frm].origofflr.value;
				var nlrb_info = document[frm].nlrb_info.value;
				var trial = document[frm].trial.value;
				var nlrb_action = document[frm].nlrb_action.value;

				// Significant Case Checklist fields
				var principal_clnt = document[frm].principal_clnt.value;
				var cont_liab_rpt = document[frm].cont_liab_rpt.value;
				var cont_liab_amt = document[frm].cont_liab_amt.value;
				var out_reason = document[frm].out_reason.value;
				var act_dif_out = document[frm].act_dif_out.value;
				var advised_wit = document[frm].advised_wit.value;
				var attn_any = document[frm].attn_any.value;
				var attn_desc = document[frm].attn_desc.value;
				var brief_out = document[frm].brief_out.value;
				var avoid_out = document[frm].avoid_out.value;


        if (sta.length == 0){
                alert("Please select Status");
                document[frm].status.focus();
        }
        else if (cas.length == 0){
                alert("Please enter Case name");
                document[frm].case_name.focus();
        }
        else if (isNaN(rcv)){
                alert("Please select Date Received in LD");
                document[frm].date_rcvd.focus();
        }
        else if (rcv > dToday){
                alert("Date Received must be less than or equal to todays date");
                document[frm].date_rcvd.focus();
        }
        else if (ass.length == 0){
                alert("Please select Assigned Employee");
                document[frm].assigned_emp.focus();
        }
        else if (! isNaN(date_eval) && date_eval < rcv){
                alert("1st Date Evaluation must be later than the date received");
                document[frm].date_eval.focus();
        }
        else if (docket.length == 0){
                alert("Please enter Docket Number");
                document[frm].docket.focus();
        }
        else if (off.length == 0){
                alert("Please select Office");
                document[frm].office.focus();
        }
        else if (! isNaN(date_inci) && date_inci > rcv){
                alert("Date of Incident must be prior to the date received");
                document[frm].date_inci.focus();
        }
        else if (subc.length == 0){
                alert("Please select Subcategory");
        }
        else if (juris.length == 0){
                alert("Please enter Jurisdiction");
        }
        else if ((juris == "USAD EEOC" || juris == "USAD MSPB") && typeof(eeo_no) != "undefined" && eeo_no.length == 0 && sta == "CLOSED"){
                alert("EEO # is required when jurisdiction is an EEOC or MSPB case before work item may be closed");
                document[frm].eeo_no.focus();
        }
        else if (juris == "USAD EEOC" && date_origofflr_add <= rcv && origofflr != "N" && origofflr != "Y"){
				// typeof(origofflr) != "undefined" && origofflr.length == 0 &&
                alert("Originating Office is required for all EEOC cases\n received on or after October 1st, 2003.");
                document[frm].origofflr.focus();
        }
        else if (juris == "USAD NLRB" && date_nlrb_info <= rcv && nlrb_info != "N" && nlrb_info != "Y"){
				// typeof(origofflr) != "undefined" && origofflr.length == 0 &&
                alert("NLRB Information field must be selected with all NLRB matters \n received on or after September 7th, 2003.");
                document[frm].nlrb_info.focus();
        }

				else if ((subc=="NLCA" || subc=="NLCB") && juris != "USAD NLRB"){
                alert("Jurisdiction for NLRB cases should be USAD NLRB");
        }
        else if (juris.substr(0,4) == "USAP" && typeof(een_no) != "undefined" && een_no.length == 0){
                alert("Trial info is not valid for Appellate Cases");
                document[frm].date_eval.focus();
        }
        else if ((subc!="NLCA" && subc!="NLCB") && nlrb_action.lenght > 0){
                alert("NLRB Action is not a valid entry when type of case is not NLRB");
                document[frm].nlrb_action.focus();
        }
        else if (clnt.length == 0){
                alert("Please enter Client Organization");
                document[frm].level_1_desc.focus();
        }
        else if (typeof(des) == "undefined" || des.length == 0){
                alert("Please enter Description");
                document[frm].description.focus();
        }
        else if (isNaN(date_eval) && sta == "CLOSED"){
                alert("Please enter 1st Date Evaluation before closing a case");
                document[frm].date_eval.focus();
        }
        else if (! isNaN(date_eval) && date_eval > dToday) {
                alert("1st Date Evaluation must be less than or equal to todays date");
                document[frm].date_eval.focus();
        }
        else if (! isNaN(date_eval) && date_eval < rcv) {
                alert("1st Date Evaluation must be later or equal to the received date");
                document[frm].date_eval.focus();
        }
        else if (clntnot45.length == 0 && sta == "CLOSED"){
                alert("Please enter whether client notified within 45 days");
                document[frm].clntnot45.focus();
        }
        else if (f_adr.length == 0 && sta == "CLOSED"){
                alert("Please enter 1st ADR before closing a case");
                document[frm].first_adr.focus();
        }
        else if (! isNaN(f_adr_dt) && f_adr_dt < rcv){
                alert("1st ADR Date must be later than the received date");
                document[frm].f_adr_dt.focus();
        }
        else if (! isNaN(date_disp) && f_adr_dt > date_disp){
                alert("1st ADR Date must be prior to the disposed date");
                document[frm].f_adr_dt.focus();
        }
        else if (f_adr != "N" && sta == "CLOSED" && isNaN(f_adr_dt)){
                alert("1st ADR Date must be included when ADR was used");
                document[frm].f_adr_dt.focus();
        }
        else if (f_adr != "N" && ! isNaN(f_adr_dt) && sta == "CLOSED" && f_adr_out.length == 0){
                alert("1st ADR Outcome must be included when ADR was used");
                document[frm].first_adr_outcome.focus();
        }
        else if (s_adr.length != 0 && sta == "CLOSED" && isNaN(s_adr_dt)){
                alert("2nd ADR Date must be included when 2nd ADR was used");
                document[frm].s_adr_dt.focus();
        }
        else if (! isNaN(s_adr_dt) && s_adr_dt <= f_adr_dt){
                alert("2nd ADR Date must be later than the 1st ADR Date");
                document[frm].s_adr_dt.focus();
        }
        else if (s_adr != "N" && ! isNaN(s_adr_dt) && sta == "CLOSED" && s_adr_out.length == 0){
                alert("2nd ADR Outcome must be included when 2nd ADR was used");
                document[frm].second_adr_outcome.focus();
        }
        else if (mon_liab.length == 0 && sta == "CLOSED"){
                alert("Please enter Potential Monetary Liablity before closing a case");
                document[frm].mon_liab.focus();
        }
        else if (relief_paid.length == 0 && sta == "CLOSED"){
                alert("Please enter Relief Paid before closing a case");
                document[frm].relief_paid.focus();
        }
        else if (atty_agn.length == 0 && sta == "CLOSED"){
                alert("Please enter Attorney, Fees & Cost liability before closing a case");
                document[frm].atty_agn.focus();
        }
        else if (mon_rem.length == 0 && sta == "CLOSED"){
                alert("Please enter Monetary Remedy Sought before closing a case");
                document[frm].mon_rem.focus();
        }
        else if (atty_for.length == 0 && sta == "CLOSED"){
                alert("Please enter Attorney, Fees & Cost Sought before closing a case");
                document[frm].atty_for.focus();
        }
        else if (disp_filed.length == 0 && sta == "CLOSED"){
                alert("Please enter Dispositive Motion Filed before closing a case");
                document[frm].disp_filed.focus();
        }
        else if (granted.length == 0 && sta == "CLOSED" && disp_filed == "Y"){
                alert("Please enter Dispositive Motion Filed Granted before closing a case");
                document[frm].granted.focus();
        }
        else if (manner_of_disposn.length == 0 && sta == "CLOSED"){
                alert("Please enter Manner of Disposition before closing a case");
                document[frm].manner_of_disposn.focus();
        }
        else if (isNaN(date_disp) && sta == "CLOSED"){
                alert("Please enter Disposition Date before closing a case");
                document[frm].date_disp.focus();
        }
        else if (! isNaN(date_disp) && date_disp > dToday){
                alert("Disposition Date must be less than or equal to todays date");
                document[frm].date_disp.focus();
        }
        else if (! isNaN(date_disp) && date_disp < rcv){
                alert("Date Disposed can not be less than Date Received");
                document[frm].date_disp.focus();
        }
        else if ((isNaN(date_disp) || manner_of_disposn.length == 0) && sta == "CLOSED"){
                alert("If case is closed, Manner of Disposition and Date Disposed cannot be blank");
                document[frm].manner_of_disposn.focus();
        }
        else if (isNaN(date_disp) && manner_of_disposn.length > 0){
                alert("Please enter Disposition Date");
                document[frm].date_disp.focus();
        }
        else if (! isNaN(date_disp) && manner_of_disposn.length == 0){
                alert("Please enter Manner of Disposition");
                document[frm].manner_of_disposn.focus();
        }
        else if (! isNaN(date_disp) && manner_of_disposn.length != 0 && sta != "CLOSED" && sta != "TRANSFERRED"){
                alert("Status of this matter should be closed");
                document[frm].status.focus();
        }
		// Start Check for Significant Case Checklist
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && principal_clnt.length == 0){
				alert("Principal Client is required for all cases where monetary liability or $ relief paid is $100,000 or more");
				document[frm].principal_clnt.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && cont_liab_rpt.length == 0){
			alert("Contingent Liability Report question is required for all cases where monetary liability or $ relief paid is $100,000 or more");
			document[frm].cont_liab_amt.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && cont_liab_amt.length == 0 && cont_liab_rpt=="Y"){
				alert("Contingent Liability Amount is required when listed on the Contingent Liability Report");
				document[frm].cont_liab_amt.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && out_reason.length == 0){
				alert("Reason for Outcome is required");
				document[frm].out_reason.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && act_dif_out.length == 0){
				alert("Action that could have resulted in a different outcome is required");
				document[frm].act_dif_out.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && avoid_out.length == 0){
				alert("Action with respect to postal personnel or procedures that would help to avoid similiar outcomes in the future is required");
				document[frm].avoid_out.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && brief_out.length == 0){
				alert("Have you or your manager briefed the client on the outcome of this case is required");
				document[frm].avoid_out.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && advised_wit.length == 0){
				alert("Have you or your manager advised management's witnesses on the outcome of this case is required");
				document[frm].avoid_out.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && attn_any.length == 0){
				alert("Has this case attracted any media or political attention is required");
				document[frm].avoid_out.focus();
		}
		else if ((mon_liab >= 100000 || relief_paid >= 100000) && date_scc_add < date_disp && manner_of_disposn.length > 0 && sta == "CLOSED" && attn_desc.length == 0 && attn_any=="Y"){
				alert("Describe the media or political attention that was attracted by this case");
				document[frm].attn_desc.focus();
		}
		else{
			document[frm].submit();
        }
	}
        else if (type =='A'){

        var cas0 = document[frm].case_name.value;
        var cas1 = trim(document[frm].last_case_name.value+", "+document[frm].first_case_name.value+" "+document[frm].mi_case_name.value);
        var rbval = document[frm].rbCaseType.value;
        var finance_no = document[frm].finance_no.value;
        var date_inci = new Date(document[frm].date_inci.value);

        var f_adr = trim(document[frm].first_adr.value);
        var f_adr_dt = new Date(document[frm].f_adr_dt.value);
        var f_adr_out = document[frm].first_adr_outcome.value;
        var clntnot45 = document[frm].clntnot45.value;

        var date_req_recon = new Date(document[frm].date_req_recon.value);
        var recon_ass_emp = document[frm].recon_ass_emp.value;
        var recon_manner_of_disposn = document[frm].recon_manner_of_disposn.value;
        var date_disp_recon = new Date(document[frm].date_disp_recon.value);

        if((sta.length == 0)){
                alert("Please select Status");
                document[frm].status.focus();
        }
        else if ((cas1.length == 1) && (rbval=='0')){
                alert("Please enter Case name");
                document[frm].last_case_name.focus();
                }
        else if ((cas0.length == 0) && (rbval=='1')){
                alert("Please enter Case name");
                document[frm].case_name.focus();
                }
        else if (isNaN(rcv)){
                alert("Please select Date Received in LD");
                document[frm].date_rcvd.focus();
        }
        else if (rcv > dToday){
                alert("Date Received must be less than or equal to todays date");
                document[frm].date_rcvd.focus();
        }
        else if (ass.length == 0){
                alert("Please select Assigned Employee");
                document[frm].assigned_emp.focus();
        }
        else if (off.length == 0){
                alert("Please select Office");
                document[frm].office.focus();
        }
        else if (! isNaN(date_inci) && date_inci > rcv){
                alert("Date of Incident must be prior to the date received");
                document[frm].date_inci.focus();
        }
        else if (subc.length == 0){
                alert("Please select Subcategory");
        }
        else if (clnt.length == 0){
                alert("Please enter Client Organization");
                document[frm].level_1_desc.focus();
        }
        else if (typeof(des) == "undefined" || des.length == 0){
                alert("Please enter Description");
                document[frm].description.focus();
        }
        else if (f_adr.length == 0 && sta == "CLOSED"){
                alert("Please enter 1st ADR before closing a case");
                document[frm].first_adr.focus();
        }
        else if (f_adr != "N" && sta == "CLOSED" && isNaN(f_adr_dt)){
                alert("ADR Date must be included when ADR was used");
                document[frm].f_adr_dt.focus();
        }
        else if (! isNaN(f_adr_dt) && f_adr_dt < rcv){
                alert("ADR Date must be later than the received date");
                document[frm].f_adr_dt.focus();
        }
        else if (! isNaN(date_disp) && f_adr_dt > date_disp){
                alert("ADR Date must be prior to the disposed date");
                document[frm].date_disp.focus();
        }
        else if (f_adr != "N" && ! isNaN(f_adr_dt) && sta == "CLOSED" && f_adr_out.length == 0){
                alert("ADR Outcome must be included when ADR was used");
                document[frm].first_adr_outcome.focus();
        }
        else if (finance_no.length == 0 && cat == "TORTS" && sta == "CLOSED"){
                alert("If type of case is TORTS and status of case is CLOSED, Finance No. is required");
                document[frm].finance_no.focus();
        }
        else if (isNaN(date_inci) && cat == "TORTS" && sta == "CLOSED"){
                alert("If type of case is TORTS and status of case is CLOSED, Date of Incident is required");
                document[frm].date_inci.focus();
        }
        else if (! isNaN(date_inci) && date_inci > rcv){
                alert("Date of Incident must be less than the date received");
                document[frm].date_inci.focus();
        }
        else if (! isNaN(date_disp) && date_disp < rcv){
                alert("Date Disposed can not be less than Date Received");
                document[frm].date_disp.focus();
        }
        else if (clntnot45.length == 0 && sta == "CLOSED"){
                alert("Please enter whether client notified within 45 days");
                document[frm].clntnot45.focus();
        }
        else if (! isNaN(date_disp) && date_disp > dToday){
                alert("Disposition Date must be less than or equal to todays date");
                document[frm].date_disp.focus();
        }
        else if ((isNaN(date_disp) || manner_of_disposn.length == 0) && sta == "CLOSED"){
                alert("If case is closed, Manner of Disposition and Date Disposed cannot be blank");
                document[frm].manner_of_disposn.focus();
        }
        else if (! isNaN(date_disp) && manner_of_disposn.length == 0){
                alert("Please enter Manner of Disposition");
                document[frm].manner_of_disposn.focus();
        }
        else if (isNaN(date_disp) && manner_of_disposn.length != 0){
                alert("Please enter Disposition Date");
                document[frm].date_disp.focus();
        }
        else if (isNaN(date_req_recon) && ! isNaN(date_disp) && manner_of_disposn.length != 0 && sta == "OPEN"){
                alert("Status of this matter should be closed");
                document[frm].status.focus();
        }
        else if (! isNaN(date_req_recon) && recon_ass_emp.length != 0 && manner_of_disposn != "DENIED"){
                alert("Manner of Disposition must be set to Denied before a reconsideration can be entered");
                document[frm].manner_of_disposn.focus();
        }
        else if (! isNaN(date_req_recon) && recon_ass_emp.length != 0 && manner_of_disposn == "DENIED" && sta != "REOPENED" && isNaN(date_disp_recon)){
                alert("Status for reconsiderations must be set to Reopened");
                document[frm].status.focus();
        }
        else if (! isNaN(date_req_recon) && recon_ass_emp.length == 0 && manner_of_disposn == "DENIED"){
                alert("Employee asssigned for reconsideration should not be blank with a request for reconsideration");
                document[frm].recon_ass_emp.focus();
        }
        else if (isNaN(date_req_recon) && recon_ass_emp.length > 0){
                alert("Date of request for reconsideration must be entered before assigning an employee to the reconsideration");
                document[frm].date_req_recon.focus();
        }
        else if (! isNaN(date_req_recon) && date_req_recon < date_disp){
                alert("Date of Request for Reconsidation must be later than the Date Disposed");
                document[frm].date_inci.focus();
        }
        else if (! isNaN(date_disp_recon) && recon_manner_of_disposn.length == 0){
                alert("Manner of Disposition for Reconsideration must be entered when Date of Disposition for Reconsidation has been entered");
                document[frm].recon_manner_of_disposn.focus();
        }

        else if (isNaN(date_disp_recon) && recon_manner_of_disposn.length > 0){
                alert("Date of Disposition for Reconsidation must be entered when Manner of Disposition for Reconsideration entered");
                document[frm].date_disp_recon.focus();
        }
        else{
                if (rbval=='0') {
                        casL=document[frm].last_case_name.value;
                        casF=document[frm].first_case_name.value;
                        casM=document[frm].mi_case_name.value;

                        casName=((casL.length > 0) ? casL : "")+((casF.length > 0) ? ", "+casF : "")+((casM.length > 0) ? " "+casM+"." : "");

                        document.adj_add.case_name.value=casName;
                        }

                document[frm].submit();
        }
	}
	else if (type =='D'){

        var cas = document[frm].case_name.value;
        if (typeof(f_adr) != "undefined") {
                var f_adr = trim(document[frm].first_adr.value);
        }

        var f_adr_dt = new Date(document[frm].f_adr_dt.value);

        if (typeof(f_adr_out) != "undefined") {
                var f_adr_out = document[frm].first_adr_outcome.value;
        }

        if((sta.length == 0)){
          alert("Please select Status");
          document[frm].status.focus();
        }
        else if (cas.length == 0){
          alert("Please enter Case name");
          document[frm].case_name.focus();
        }
        else if (isNaN(rcv)){
          alert("Please select Date Received in LD");
          document[frm].date_rcvd.focus();
        }
		else if (rcv > dToday){
			alert("Date Received must be less than or equal to todays date");
			document[frm].date_rcvd.focus();
		}
		else if (ass.length == 0){
			alert("Please select Assigned Employee");
			document[frm].assigned_emp.focus();
		}
		else if (off.length == 0){
			alert("Please select Office");
			document[frm].office.focus();
		}
		else if (subc.length == 0){
                        alert("Please select Subcategory");
		}
		else if (typeof(des) == "undefined" || des.length == 0){
			alert("Please enter Description");
			document[frm].description.focus();
		}
		else if (clnt.length == 0){
			alert("Please enter Client Organization");
			document[frm].level_1_desc.focus();
		}
        else if (! isNaN(date_disp) && f_adr_dt > date_disp){
                alert("ADR Date must be prior to the disposed date");
                document[frm].f_adr_dt.focus();
        }
        else if (! isNaN(f_adr_dt) && f_adr_dt < rcv){
                alert("1st ADR Date must be later than the received date");
                document[frm].f_adr_dt.focus();
        }
        else if (! isNaN(date_disp) && f_adr_dt > date_disp){
                alert("1st ADR Date must be prior to the disposed date");
                document[frm].f_adr_dt.focus();
        }
        else if (typeof(f_adr)!= "undefined" && f_adr != "N" && sta == "CLOSED" && isNaN(f_adr_dt)){
                alert("1st ADR Date must be included when ADR was used");
                document[frm].f_adr_dt.focus();
        }
        else if (typeof(f_adr)!= "undefined" && f_adr != "N" && ! isNaN(f_adr_dt) && sta == "CLOSED" && typeof(f_adr_out)== "undefined"){
                alert("1st ADR Outcome must be included when ADR was used");
                document[frm].first_adr_outcome.focus();
        }
        else if (! isNaN(date_disp) && date_disp < rcv){
                alert("Date Disposed can not be less than Date Received");
                document[frm].date_disp.focus();
        }
        else if (! isNaN(date_disp) && date_disp > dToday){
                alert("Date Disposed can not be beyond the current date");
                document[frm].date_disp.focus();
        }
        else if ((isNaN(date_disp) || manner_of_disposn.length == 0) && sta == "CLOSED"){
                alert("If case is closed, Manner of Disposition and Date Disposed cannot be blank");
                document[frm].manner_of_disposn.focus();
        }
        else if (! isNaN(date_disp) && manner_of_disposn.length == 0){
                alert("Please enter Manner of Disposition");
                document[frm].manner_of_disposn.focus();
        }
        else if (! isNaN(date_disp) && manner_of_disposn.length != 0 && sta == "OPEN" ){
                alert("Status of this matter should be closed");
                document[frm].status.focus();
        }
        else if (isNaN(date_disp) && manner_of_disposn.length > 0){
                alert("Please enter Disposition Date");
                document[frm].date_disp.focus();
        }
        else{
                document[frm].submit();
        }
	}
}


//this function will disable the form elements like:
//any Input type that's text
//Select box
//Radio
//This function will also remove any image that has the following names cal.gif or 3dotbutton.
//Written by - Ilyas Hamidzai
function doDisable(bDisable, fObj)
{
	if ( !bDisable) //dont do function if we don't need to turn items to disable.
		return;
	if ( !fObj) //check to see if object exists
		return;

	var i = 0;
	for (i=0; i < fObj.elements.length; i++) //go through all form elements
	{
		if ( fObj.elements[i].type.toUpperCase() != "BUTTON" &&  fObj.elements[i].type.toUpperCase() != "HIDDEN" &&
			 fObj.elements[i].type.toUpperCase() != "SUBMIT" &&  fObj.elements[i].type.toUpperCase() != "RESET" )
		{
			fObj.elements[i].disabled = true;
		}
	}
	for (i=0; i < document.images.length; i++)
	{
		if ( document.images[i].src.indexOf("cal.gif") >-1  || document.images[i].src.indexOf("3dotbutton") > -1)
		{
			document.images[i].lastOnClick = document.images[i].onclick;
			document.images[i].lastSRC = document.images[i].src;
			document.images[i].onclick="";
			document.images[i].src="img/clear.gif";
		}
	}
}



//this function will disable the form elements like:
//any Input type that's text
//Select box
//Radio
//This function will also remove any image that has the following names cal.gif or 3dotbutton.
//Written by - Ilyas Hamidzai
function doEnable(fObj)
{
	if ( !fObj) //dont do function if we don't need to turn items to disable.
	{	alert("error: form was not found");
		return;
	}

	var i = 0;

	for (i=0; i < fObj.elements.length; i++) //go through all form elements
	{
		if ( fObj.elements[i].type.toUpperCase() != "BUTTON" &&  fObj.elements[i].type.toUpperCase() != "HIDDEN" &&
			 fObj.elements[i].type.toUpperCase() != "SUBMIT" &&  fObj.elements[i].type.toUpperCase() != "RESET" )
		{
			fObj.elements[i].disabled = false;
		}
	}//end of for loop

	for (i=0; i < document.images.length; i++)
	{
		if ( document.images[i].lastOnClick && document.images[i].lastSRC)
		{
			document.images[i].onclick = document.images[i].lastOnClick ;
			document.images[i].src = document.images[i].lastSRC;
		}
	}

	return true;
}

//This function opens the printing window.
//@-Written by Ilyas Hamidzai
function doPrint(strAction, strWorkID, strType)
{
 	var myWindow = window.open(strAction + '?workitem=' + strWorkID + '&type=' +strType + '','winscript','height=600,width=800,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=1,menubar=no,resizable=1,scroll=1');
	myWindow.print();
	return false
}

var OSELECT = null;
var OADRWIN = null;

function do_Comment_win(oSelect,oText)
{
	//open the window
	var myWindow = window.open('','Comments','height=500,width=700,toolbar=no,location=no,directories=no,status=no,scrollbars=0,menubar=no,resizable=1,scroll=1');
	//set the global objects of select box and
	//the current popup window. These two are used for the call back funtion ClickADRText
	OADRWIN =  myWindow;
	OSELECT =  oSelect;
	OTEXT = oText;

	myWindow.document.write("<link rel=stylesheet type='text/css' href='test.css'>");

	myWindow.document.write("<title>Comments</title>");
	myWindow.document.write("<form name='frmCom'>")

	myWindow.document.write('<table border="0" cellpadding="0" cellspacing="0" width="100%" class="AdjTD" >');
	myWindow.document.write("<tr>");
	myWindow.document.write('<td><div align="left">&nbsp;&nbsp;Comments:</div></td>')
	myWindow.document.write("</tr>");
	myWindow.document.write("<tr>");
	//myWindow.document.write('     <td align="right" width="15%" class="AdjTD" valign="top">Comments</td>');
	myWindow.document.write('     <td class="AdjTD">&nbsp;&nbsp;<TEXTAREA class="AdjTextArea" NAME="ccomments" rows="25" cols="105" wrap="soft" TITLE="Comments">'+OTEXT+'</TEXTAREA>');
	myWindow.document.write("     </td>");
	myWindow.document.write("</tr>");
	myWindow.document.write("</table>");
	myWindow.document.write('<br><div align="center">')
	myWindow.document.write('<input class="bttn" type="button" name="abutton" value="Copy Comments" onclick="opener.fClose(document.frmCom.ccomments.value);"></div>');
	myWindow.document.write("</form>");

	return true;
}

function fClose(cComs)
{
	OSELECT.value=cComs;
	OADRWIN.close();
}

//This function opens the ADR Definition window.
//@-Written by Ilyas Hamidzai and Greg Castle

function do_ADR_desc_win( oSelect )
{
	//open the window
	var myWindow = window.open('','ADRDescription','height=350,width=500,toolbar=no,location=no,directories=no,status=no,scrollbars=0,menubar=no,resizable=0,scroll=1');
	//set the global objects of select box and
	//the current popup window. These two are used for the call back funtion ClickADRText
	OADRWIN =  myWindow;
	OSELECT =  oSelect;
	myWindow.document.write("<link rel=stylesheet type='text/css' href='test.css'>");

	myWindow.document.write("<title>ADR Definitions</title>");
	myWindow.document.write("<form name='test'>")

	//create table in the window.
	myWindow.document.write('<table bgcolor="6699cc" border=0>');
	myWindow.document.write("<tr>");
	myWindow.document.write("&nbsp; </tr>");
	myWindow.document.write('<tr><td colspan="2" align="center"><font class="TextMainW">Select ADR to see definition</font></td></tr>');

	myWindow.document.write(" <tr>");
	myWindow.document.write("		<td valign=\"top\" width=\"200\">\n");
	myWindow.document.write("     <table border=0>\n");
	var i = 0;
	//get adr info and print it in the table. this will also set the
	//onclick and onmouseover functions ( functions are in a call back mode

	//creates list box
	myWindow.document.write('<tr>')
	myWindow.document.write('<td colspan="2"><br><br><br><br></td></tr>')
	myWindow.document.write('<div align="left">')
	myWindow.document.write("       <tr>\n")
	arraylength=adr_array_adr.length;
	//alert(arraylength);
	myWindow.document.write('<select class="AdjSelect" name="cADR" onchange="opener.ChangeADRText(this.value, oADR_TEXT, document.test.abutton);" width="40" size="8">')

	// check the length of the pulldown, if 8 then 1st adr, if 7 2nd adr, if 1st adr we use all options, if 2nd adr we skip the 1st option "ADR Not Used"
	if (OSELECT.length==8) {
		for (i = 1; i < adr_array_adr.length; i++)
		{
		myWindow.document.write('<option class="AdjOption" value='+i+'>'+adr_array_desc[i]+'</option>')
		}
	}
	else if (OSELECT.length==7) {
		for (i = 2; i < adr_array_adr.length; i++)
		{
		myWindow.document.write('<option class="AdjOption" value='+i+'>'+adr_array_desc[i]+'</option>')
		}
	}

	myWindow.document.write("</select>")
	myWindow.document.write("       </tr>\n")
	myWindow.document.write("</div>")
	//end of list box creation

	/*  for (i = 1; i < adr_array_adr.length; i++)
	{
	myWindow.document.write("				<tr>\n");
	myWindow.document.write("					<TD onmouseover=\"opener.ChangeADRText(" + i + ", oADR_TEXT);\" \n");
	myWindow.document.write(" onclick=\"opener.ClickADRText(" + i + ");\" >" + adr_array_desc[i] + "</TD>\n");
	myWindow.document.write("				</tr>\n");
	} */
	//end table formating
	myWindow.document.write("			</table>\n");
	myWindow.document.write("		</td>\n");
	//myWindow.document.write("   <td valign=\"top\">\n");
	myWindow.document.write("   <td valign=\"top\" width=\"300\" bgcolor=\"#fde5c6\">\n");

	//create the object to write the dymanmic text to
	myWindow.document.write("&nbsp;     <span name=\"oADR_TEXT\" id=\"oADR_TEXT\"></span>\n");
	myWindow.document.write("		</td>\n");
	myWindow.document.write("	</tr>\n");
	myWindow.document.write("</table>\n");
	//print close button
	myWindow.document.write("<br>")
	myWindow.document.write('<div align="center">')
	myWindow.document.write("<input class='bttn' type='button' name='abutton' disabled value='Select ADR' onclick=opener.ClickADRText(document.test.cADR[document.test.cADR.selectedIndex].value); ></div>");
	myWindow.document.write("</form>");

	return true;
}

//this is the call back funtion for on mouse over the adr
//this function get the index of the array and the object to write the description
function ChangeADRText(idx, oADR_TEXT, button)
{

  if ( oADR_TEXT )
		oADR_TEXT.innerHTML = adr_array_com[idx];

  button.disabled = false;
}
//this function set the select box and closes the window.
//once closed the select box should be selected the correct choice and the
//window should close and be set to null.
function ClickADRText(idx)
{

  if ( OADRWIN )
    OADRWIN.close();

  // if lenght of pulldown is 8 we are at 1st adr and use all options, if at 2nd adr we skip the 1st option "ADR Not Used"
  if (OSELECT.length==8){
     OSELECT.options[idx].selected = true;
    }
  else {
     OSELECT.options[idx-1].selected = true;
      }

	OADRWIN = null;
	OSELECT = null;
}
