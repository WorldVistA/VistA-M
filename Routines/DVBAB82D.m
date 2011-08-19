DVBAB82D ;BHAMOI/JFW - CAPRI CNH DELIMITED REPORTS ; 9/24/10 1:59pm
 ;;2.7;AMIE;**149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Input : DVBARPTID - Identifies report to delimit
 ;        ^TMP("DVBA",$J,1) contains report in standard output
 ;Output: ^TMP("DVBADLMTD",$J) contains delimited report
 ;
DLMTRPT(DVBARPTID) ;delimit CNH report
 N DVBADLMTR,DVBADRPT
 S DVBADLMTR="^",DVBADRPT=$NA(^TMP("DVBADLMTD",$J))
 K @DVBADRPT
 ;create specific delimited report
 D @(DVBARPTID_"(DVBADLMTR,DVBADRPT)")
 K ^TMP("DVBA",$J)
 Q
 ;
11(DVBADLMTR,DVBADRPT) ;Nursing Home Roster Report Output
 N DVBAI,DVBAX,DVBAQUIT,DVBASTR,DVBACNTR,DVBATMP,DVBAVEN,DVBAVENID
 ;check to see if any results found
 I ('$D(^TMP("DVBA",$J,1,9))) D  Q
 .S @DVBADRPT@(1)="No data found."_$C(13)
 D COLHDR52(DVBADLMTR,DVBADRPT)  ;delimited column header info
 S DVBACNTR=$O(@DVBADRPT@("A"),-1)+1
 S DVBAI=8 F  S DVBAI=$O(^TMP("DVBA",$J,1,DVBAI)) Q:'+DVBAI  D
 .S DVBASTR=$G(^TMP("DVBA",$J,1,DVBAI))
 .;ignore blank lines (Seperates Entries) OR report headers 
 .Q:((DVBASTR="")!($E(DVBASTR,1,11)="VENDOR NAME")!($E(DVBASTR,1)=" ")!(DVBASTR[$C(10)))
 .S DVBAVEN=$$TRUNC($E(DVBASTR,1,49)),DVBAVENID=$$TRUNC($E(DVBASTR,51,80))
 .S DVBAQUIT=0,DVBAX=DVBAI
 .;quit inner loop when no more veterans for specific vendor
 .;or end of global array reached
 .F  S DVBAX=$O(^TMP("DVBA",$J,1,DVBAX)) Q:((DVBAQUIT)!('+DVBAX))  D
 ..S DVBASTR=$G(^TMP("DVBA",$J,1,DVBAX)),DVBATMP=""
 ..I ($E(DVBASTR,1)'=" ") S DVBAQUIT=1,DVBAI=DVBAX  Q
 ..;Vendor Name^Vendor ID
 ..S DVBATMP=DVBAVEN_DVBADLMTR_DVBAVENID_DVBADLMTR
 ..;Veteran Name^Veteran ID^Admit DT^Auth. To Date
 ..S DVBATMP=DVBATMP_$$TRUNC($E(DVBASTR,5,36))_DVBADLMTR_$$TRUNC($E(DVBASTR,38,52))_DVBADLMTR
 ..S DVBATMP=DVBATMP_$$TRIM($$TRUNC($E(DVBASTR,54,64)))_DVBADLMTR_$$TRIM($$TRUNC($E(DVBASTR,66,80)))
 ..;Save off CNH info and increment counters
 ..S @DVBADRPT@(DVBACNTR)=DVBATMP_$C(13),DVBACNTR=DVBACNTR+1
 Q
 ;
12(DVBADLMTR,DVBADRPT) ;CNH Admission/Discharge Report Output
 N DVBAI,DVBASTR,DVBACNTR,DVBATMP
 ;check to see if any results found
 I ('$D(^TMP("DVBA",$J,1,7))) D  Q
 .S @DVBADRPT@(1)="No data found for parameters entered."_$C(13)
 D COLHDR53(DVBADLMTR,DVBADRPT)  ;delimited column header info
 S DVBACNTR=$O(@DVBADRPT@("A"),-1)+1
 S DVBAI=6 F  S DVBAI=$O(^TMP("DVBA",$J,1,DVBAI)) Q:'+DVBAI  D
 .S DVBASTR=$G(^TMP("DVBA",$J,1,DVBAI))
 .;ignore blank lines (Seperates Entries) OR report headers 
 .Q:((DVBASTR="")!($E(DVBASTR,1)=" ")!(DVBASTR[$C(10)))
 .S DVBATMP=""
 .;Patient Name^Patient ID^Eligibility
 .S DVBATMP=$$TRUNC($E(DVBASTR,1,31))_DVBADLMTR_$$TRUNC($E(DVBASTR,33,47))_DVBADLMTR_$$TRUNC($E(DVBASTR,49,80))_DVBADLMTR
 .S DVBAI=DVBAI+1,DVBASTR=$G(^TMP("DVBA",$J,1,DVBAI))
 .;Activity Type^Date^Date/Time^Sub Type
 .S DVBATMP=DVBATMP_$P($$TRIM(DVBASTR)," ")_DVBADLMTR_$$TRUNC($E(DVBASTR,20,35))_DVBADLMTR_$$TRUNC($E(DVBASTR,53,80))_DVBADLMTR
 .S DVBAI=DVBAI+1,DVBASTR=$G(^TMP("DVBA",$J,1,DVBAI))
 .;Nursing Home Information (ID^Name^Address^Phone) is optional
 .D:(DVBASTR="")
 ..S DVBATMP=DVBATMP_DVBADLMTR_DVBADLMTR_DVBADLMTR
 .D:(DVBASTR'="")
 ..S DVBATMP=DVBATMP_$$TRUNC($E(DVBASTR,43,80))_DVBADLMTR_$$TRUNC($E(DVBASTR,11,41))_DVBADLMTR
 ..S DVBASTR=$$TRIM($$TRUNC($G(^TMP("DVBA",$J,1,DVBAI+1))))
 ..S:(DVBASTR]"") DVBATMP=DVBATMP_DVBASTR_" "  ;Address 1
 ..S DVBATMP=DVBATMP_$$TRIM($$TRUNC($G(^TMP("DVBA",$J,1,DVBAI+2))))_DVBADLMTR  ;Address 2
 ..S DVBATMP=DVBATMP_$$TRIM($$TRUNC($P($G(^TMP("DVBA",$J,1,DVBAI+3)),":",2)))  ;Phone
 ..S DVBAI=DVBAI+3
 .;Save off CNH info and increment counters
 .S @DVBADRPT@(DVBACNTR)=DVBATMP_$C(13),DVBACNTR=DVBACNTR+1
 Q
 ;
 ;Input : DVBADLMTR - Delimiter to use between components
 ;        DVBADRPT  - Delimited Report container (Full Global Ref)
 ;Output: Delimited report info added to DVBADRPT
13(DVBADLMTR,DVBADRPT) ; CNH stays > 90 days Report Output
 N DVBAI,DVBASTR,DVBACNTR,DVBATMP
 ;check to see if any results found
 I ($G(^TMP("DVBA",$J,1,9))="") D  Q
 .S @DVBADRPT@(1)="No data found for parameter entered."_$C(13)
 D COLHDR50(DVBADLMTR,DVBADRPT)  ;delimited column header info
 S DVBACNTR=$O(@DVBADRPT@("A"),-1)+1
 S DVBAI=8 F  S DVBAI=$O(^TMP("DVBA",$J,1,DVBAI)) Q:'+DVBAI  D
 .S DVBASTR=$G(^TMP("DVBA",$J,1,DVBAI))
 .Q:(DVBASTR["***LOS =")  ;end of report info
 .;ignore blank lines OR report headers 
 .Q:((DVBASTR="")!($E(DVBASTR,1,7)="VETERAN")!($E(DVBASTR,1)=" ")!(DVBASTR[$C(10)))
 .S DVBATMP=""
 .;Veteran^Pt.ID^Marital St.^Adm. Date^LOS^Vendor
 .S DVBATMP=$$TRUNC($E(DVBASTR,1,17))_DVBADLMTR_$$TRUNC($E(DVBASTR,19,31))_DVBADLMTR
 .S DVBATMP=DVBATMP_$$TRUNC($E(DVBASTR,33,34))_DVBADLMTR_$$TRUNC($E(DVBASTR,36,44))_DVBADLMTR
 .S DVBATMP=DVBATMP_$$TRIM($$TRUNC($E(DVBASTR,46,52)))_DVBADLMTR_$$TRUNC($E(DVBASTR,54,80))
 .;Save off CNH info and increment counters
 .S @DVBADRPT@(DVBACNTR)=DVBATMP_$C(13),DVBACNTR=DVBACNTR+1
 Q
 ;
 ;Delimited Column header for CNH stays in excess of 90 days Report
COLHDR50(DVBADLMTR,DVBADRPT) ;
 N DVBAHDR
 S DVBAHDR="Veteran"_DVBADLMTR_"Pt. ID"_DVBADLMTR_"Marital St."_DVBADLMTR
 S DVBAHDR=DVBAHDR_"Adm. Date"_DVBADLMTR_"LOS"_DVBADLMTR_"Vendor"
 S @DVBADRPT@($O(@DVBADRPT@("A"),-1)+1)=DVBAHDR_$C(13)
 Q
 ;
 ;Delimited Column header for Nursing Home Roster Report
COLHDR52(DVBADLMTR,DVBADRPT) ;
 N DVBAHDR
 S DVBAHDR="Vendor Name"_DVBADLMTR_"Vendor ID"_DVBADLMTR_"Veteran Name"_DVBADLMTR
 S DVBAHDR=DVBAHDR_"Veteran ID"_DVBADLMTR_"Admit DT"_DVBADLMTR_"Auth. To Date"
 S @DVBADRPT@($O(@DVBADRPT@("A"),-1)+1)=DVBAHDR_$C(13)
 Q
 ;
 ;Delimited Column header for Admission/Discharge Report
COLHDR53(DVBADLMTR,DVBADRPT) ;
 N DVBAHDR
 S DVBAHDR="Patient Name"_DVBADLMTR_"Patient ID"_DVBADLMTR_"Eligibility"_DVBADLMTR
 S DVBAHDR=DVBAHDR_"Activity Type"_DVBADLMTR_"Actvity Date/Time"_DVBADLMTR
 S DVBAHDR=DVBAHDR_"Activity Sub Type"_DVBADLMTR_"CNH ID"_DVBADLMTR
 S DVBAHDR=DVBAHDR_"CNH Name"_DVBADLMTR_"CNH Address"_DVBADLMTR_"CNH Phone #"
 S @DVBADRPT@($O(@DVBADRPT@("A"),-1)+1)=DVBAHDR_$C(13)
 Q
 ;
 ;Input : DVBASTR - string to check for trailing spaces
 ;Output: String with trailing spaces, Line/Form feeds removed
TRUNC(DVBASTR) ;remove trailing spaces and line/form feeds in string
 N DVBAX
 Q:(DVBASTR="") ""
 F DVBAX=$L(DVBASTR):-1:0  Q:(($E(DVBASTR,DVBAX,DVBAX)'=" ")&(($E(DVBASTR,DVBAX,DVBAX))'[$C(13))&($E(DVBASTR,DVBAX,DVBAX)'[$C(12)))
 Q ($E(DVBASTR,1,DVBAX))
 ;
 ;Input : DVBASTR - string to check for leading spaces
 ;Output: String with leading spaces removed
TRIM(DVBASTR) ;remove leading spaces in string
 N DVBAX
 Q:(DVBASTR="") ""
 F DVBAX=1:1:$L(DVBASTR)  Q:($E(DVBASTR,DVBAX,DVBAX)?1AN)
 Q ($E(DVBASTR,DVBAX,$L(DVBASTR)))
