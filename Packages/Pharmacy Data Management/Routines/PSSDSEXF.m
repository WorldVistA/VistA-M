PSSDSEXF ;BIR/CMF-Exceptions for Dose call Continuation ;02/24/09
 ;;1.0;PHARMACY DATA MANAGEMENT;**224**;9/30/97;Build 3
 ;
 ;Called from PSSDSEXE, this routine takes the results from the call to First DataBank and creates displayable TMP
 ;globals for the calling applications. Typically, PSSDBASA indicates a CPRS call, and PSSDBASB indicates a pharmacy call
 ;
 ;PSSDBCAR ARRAY pieces, set mostly in PSSDSAPD are described in PSSDSEXC:
 ;
 ;;
TWEAK200 ;; loop through exception then error globals, ensure no duplicate generic messages
 N PSSDXLP,PSSREPL,PSSDEMSG
 S PSSDXLP=""
 F  S PSSDXLP=$O(^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDXLP)) Q:PSSDXLP=""  D 
 .S PSSDXLP("MSG")="",PSSDXLP("RSN")="",PSSDXLP("TYP")="",PSSDXLP("FLG")=""
 .S PSSDXLP("MSG")=$G(^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDXLP,1))
 .Q:PSSDXLP("MSG")=""
 .S PSSDXLP("TYP")=$S(PSSDXLP("MSG")["Maximum Single":"S",PSSDXLP("MSG")["Max Daily":"D",1:"B")
 .S PSSDXLP("RSN")=$G(^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDXLP,2))
 .D:PSSDXLP("RSN")="" TWEAK205(.PSSDXLP)
 .D:PSSDXLP("FLG")=1
 ..S PSSREPL("Maximum Single Dose Check")="Dosing Checks"
 ..S PSSREPL("Max Daily Dose Check")="Dosing Checks"
 ..S PSSDEMSG=$$REPLACE^XLFSTR(PSSDXLP("MSG"),.PSSREPL)
 ..S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDXLP,1)=PSSDEMSG
 ..S $P(PSSDBCAR(PSSDXLP),U,27)=1
 ..Q
 .Q
 ;;
TWEAK205(PSSDXLP) ;; look for errors matching the exception, remove if found, return flag to TWEAK200
 N PSSDWLP,PSSDWCNT
 S PSSDWLP=PSSDXLP
 S PSSDWCNT=""
 F  S PSSDWCNT=$O(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT)) Q:'PSSDWCNT  D 
 .S PSSDWLP("MSG")=$G(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT,"MSG"))
 .Q:PSSDWLP("MSG")=""
 .S PSSDWLP("RSN")=$G(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT,"TEXT"))
 .D:PSSDWLP("RSN")=""
 ..S PSSDWLP("MSG")="",PSSDWLP("RSN")="",PSSDWLP("TYP")=""
 ..S PSSDWLP("TYP")=$S(PSSDWLP("MSG")["Maximum Single":"S",PSSDWLP("MSG")["Max Daily":"D",1:"B")
 ..S:PSSDWLP("TYP")'=PSSDXLP("TYP") PSSDXLP("FLG")=1
 ..K ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT)
 .Q
 ;;
