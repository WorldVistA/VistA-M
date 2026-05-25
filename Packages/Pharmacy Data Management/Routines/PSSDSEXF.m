PSSDSEXF ;BIR/CMF - Exceptions for Dose call Continuation ; Feb 24, 2009@16:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**224,254**;9/30/97;Build 109
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
TWEAK28A(PSSDWLP)  ;; if CPRS call, alter 'Chemo/cycle' errors to generic  ;;254
 ;Full message in 4.5: This chemo drug screening record is coded as a single dose per cycle.
 ;Called from PSSDSEXE
 N PSSDWCNT,PSSDWMSG,PSSDWRSN,FLAG
 S FLAG=0
 S PSSDWCNT=0
 F  S PSSDWCNT=$O(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT)) Q:'PSSDWCNT  D 
 .S PSSDWRSN=$G(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT,"TEXT"))
 .D:PSSDWRSN["chemo drug screening record is coded as a single dose per cycle" 
 ..S PSSDWMSG=$$CHECKMSG^PSSDSEXD(PSSDWLP)_$$MSGEND^PSSDSEXE(PSSDWLP,$P(PSSDBCAR(PSSDWLP),U,2))
 ..S PSSDWRSN=""
 ..S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT,"MSG")=PSSDWMSG
 ..S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT,"TEXT")=PSSDWRSN
 ..D:(PSSDWMSG["Dosing Checks")&(PSSDWCNT=1)
 ...F  S PSSDWCNT=$O(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT)) Q:'PSSDWCNT  D
 ....K ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWCNT)
 ..S $P(PSSDBCAR(PSSDWLP),U,27)=1
 ..S FLAG=1
 Q FLAG
 ;;
TWEAK27A ;;  *254 FDB 4.5
 ;CPRS message contains "Dosing Checks could not", "Age Range", or "contraindicated" 
 ;Called by PSSDSAPA
 N DRUGNAME,EXCLUDE,INTRO,ISCMPLEX,PSSDMSG,PSSDTXT,PSSPC5,PSSPC6
 S ISCMPLEX=0
 S PSSPC5="" F  S PSSPC5=$O(PSSDBCAR(PSSPC5)) Q:PSSPC5=""  D
 .S PSSPC6="" F  S PSSPC6=$O(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSPC5,PSSPC6)) Q:PSSPC6=""  D
 ..S PSSDMSG=$G(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSPC5,PSSPC6,"MSG"))
 ..S PSSDTXT=$G(^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSPC5,PSSPC6,"TEXT"))
 ..S ISCMPLEX=$$ISCMPLEX^PSSDSEXD(PSSPC5)
 ..I $P(PSSDMSG,":")["Dosing Checks" D
 ...S INTRO=$$CHECKMSG^PSSDSEXD(PSSPC5)
 ...I INTRO["Single" S PSSDMSG=INTRO_" could not be done for Drug:"_$P(PSSDMSG,":",2)
 ...S EXCLUDE=($G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSPC5,PSSPC6,"TYPE"))="ExclusionMessage-ExclusionMessageText")
 ...I EXCLUDE,(($$UP^XLFSTR(PSSDTXT)[" AGE")!($$UP^XLFSTR(PSSDTXT)["CONTRAINDICATED")) D
 ....S DRUGNAME=$S(ISCMPLEX:"(Dose="_$G(PSSDSDPL(PSSPC5))_")",1:"")
 ....S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSPC5,PSSPC6,"MSG")=PSSDMSG_DRUGNAME
 ....S $P(PSSDBCAR(PSSPC5),U,27)=1
 Q
 ;;
TWEAK27B ;;  *254 FDB 4.5
 ;Backdoor message contains "Dosing Checks could not", "Age Range", "contraindicated", or "screening supports"
 ;Called by PSSDSAPA
 N EXCLUDE,INTRO,PSSDMSG,PSSDTXT,PSSPC4,PSSPC5,PSSPC7
 S PSSPC5="" F  S PSSPC5=$O(PSSDBCAR(PSSPC5)) Q:PSSPC5=""  D
 .S PSSPC4="" F  S PSSPC4=$O(^TMP($J,PSSDBASG,"OUT",PSSPC4)) Q:PSSPC4=""  D
 ..I '$D(^TMP($J,PSSDBASG,"OUT",PSSPC4,PSSPC5)) Q
 ..S PSSPC7="" F  S PSSPC7=$O(^TMP($J,PSSDBASG,"OUT",PSSPC4,PSSPC5,"ERROR",PSSPC7)) Q:PSSPC7=""  D
 ...S PSSDMSG=$G(^TMP($J,PSSDBASG,"OUT",PSSPC4,PSSPC5,"ERROR",PSSPC7,"MSG"))
 ...S PSSDTXT=$G(^TMP($J,PSSDBASG,"OUT",PSSPC4,PSSPC5,"ERROR",PSSPC7,"TEXT"))
 ...I $P(PSSDMSG,":")["Dosing Checks" D
 ....S INTRO=$$CHECKMSG^PSSDSEXD(PSSPC5)
 ....I INTRO["Single" S PSSDMSG=INTRO_" could not be done for Drug:"_$P(PSSDMSG,":",2)
 ....;First Check - Age Exclusion and Contraindication
 ....S EXCLUDE=($G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSPC5,PSSPC7,"TYPE"))="ExclusionMessage-ExclusionMessageText")
 ....I EXCLUDE,(($$UP^XLFSTR(PSSDTXT)[" AGE")!($$UP^XLFSTR(PSSDTXT)["CONTRAINDICATED")) D  Q
 .....S ^TMP($J,PSSDBASG,"OUT",PSSPC4,PSSPC5,"ERROR",PSSPC7,"MSG")=PSSDMSG
 .....S $P(PSSDBCAR(PSSPC5),U,27)=1
 ....;Second Check - Screening support, No Match
 ....S EXCLUDE=($G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSPC5,PSSPC7,"TYPE"))="ExclusionMessage-NoDosingforProfileandOrder")
 ....I EXCLUDE,(PSSDTXT[" Screening supports the ordered drug") D
 .....S PSSDTXT=$P(^TMP($J,PSSDBASG,"OUT",PSSPC4,PSSPC5,"ERROR",PSSPC7,"TEXT"),":")
 .....S PSSDTXT=PSSDTXT_": No dosing information is available from the database."
 .....S ^TMP($J,PSSDBASG,"OUT",PSSPC4,PSSPC5,"ERROR",PSSPC7,"TEXT")=PSSDTXT
 .....S $P(PSSDBCAR(PSSPC5),U,27)=1
 Q
 ;;
TWEAK26A ;;  *254 FDB 4.5
 ;CPRS message reformatting when subsequenct message is "one or more required patient parameters"
 ;Remove the leading spaces - the indent is for Vista display
 ;Called by TWEAK26^PSSDSEXE
 N NEXT,REASON
 S NEXT=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,PSSDWE2))
 I NEXT'="" D
 .S REASON=$P(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,NEXT),U,10)
 .I $$UP^XLFSTR(REASON)["ONE OR MORE REQUIRED PATIENT PARAMETERS UNAVAILABLE" D
 ..S $P(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,NEXT),U,7)=MESSAGE
 ..S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,3)=$$TRIM^XLFSTR(REASON,"L"," ")
 Q
