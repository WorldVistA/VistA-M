VAQBUL02 ;ALB/JRP - BULLETINS;20-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;**9,16,20**;NOV 17, 1993
PROCESS(TRANPTR,REASON,ARRAY1) ;SEND REQUIRES PROCESSING BULLETIN
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         REASON - Why transaction requires processing
 ;         ARRAY1 - Array of pointers to VAQ - DATA SEGMENT that
 ;                  were contained in the request but over the maximium
 ;                  time & occurrence limit allowed for automatic
 ;                  processing (full global ref)
 ;                    ARRAY1(Pointer)=MaxTime^MaxOccur^ReqTime^ReqOccur
 ;OUTPUT : 0 - Bulletin sent
 ;         -1^Error_Text - Bulletin not sent
 ;NOTES  : If segments were not checked against maximum limits, still
 ;         pass an array reference for ARRAY1.  If ARRAY1 doesn't exist
 ;         the information will not be used.
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass valid transaction"
 S REASON=$G(REASON)
 S ARRAY1=$G(ARRAY1)
 ;DECLARE VARIABLES
 N TRANNUM,TMP,NAME,PID,DOB,DOMAIN,X,LINE,USER,SITE,XMY,TMPARR
 N SEGPTR,SEGABB,MAXTIM,MAXOCC,TIME,OCCUR,SSN,Y,ERROR
 S TMPARR="^TMP(""VAQ-BUL"","_$J_")"
 K @TMPARR
 S TRANNUM=+$G(^VAT(394.61,TRANPTR,0))
 S TMP=$G(^VAT(394.61,TRANPTR,"QRY"))
 S NAME=$P(TMP,"^",1)
 S SSN=$P(TMP,"^",2)
 S DOB=$P(TMP,"^",3)
 S PID=$P(TMP,"^",4)
 S:(NAME="") NAME="Not listed"
 S:(PID="") PID=SSN
 S DOB=$$DOBFMT^VAQUTL99(DOB,0)
 S:(DOB="") DOB="Not listed"
 S USER=$P($G(^VAT(394.61,TRANPTR,"RQST1")),"^",2)
 S:(USER="") USER="Unknown"
 S TMP=$G(^VAT(394.61,TRANPTR,"RQST2"))
 S SITE=$P(TMP,"^",1)
 S DOMAIN=$P(TMP,"^",2)
 S:(SITE="") SITE="Could not be determined"
 S:(DOMAIN="") DOMAIN="Could not be determined"
 ;BUILD TEXT OF MESSAGE
 S LINE=1
 S TMP="The following PDX Request requires manual processing ..."
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP=""
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  Transaction number: "_TRANNUM
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  Name: "_NAME
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  PID: "_PID
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  DOB: "_DOB
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP=""
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  Requested by: "_USER
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  Site: "_SITE
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  Domain: "_DOMAIN
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP=""
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  Reason for manual processing:"
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP="  "_REASON
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 S TMP=""
 S @TMPARR@(LINE,0)=TMP
 S LINE=LINE+1
 ;PRINT SEGMENTS EXCEEDING MAXIMUM LIMITS (IF PASSED)
 I (ARRAY1'="") I (+$O(@ARRAY1@(""))) D
 .S TMP="  Segments that were over the allowable time & occurrence limits:"
 .S @TMPARR@(LINE,0)=TMP
 .S LINE=LINE+1
 .S TMP=""
 .S @TMPARR@(LINE,0)=TMP
 .S LINE=LINE+1
 .S TMP="               Requested    Maximum      Requested      Maximum"
 .S @TMPARR@(LINE,0)=TMP
 .S LINE=LINE+1
 .S TMP="  Segment        Time        Time        Occurrence    Occurrence"
 .S @TMPARR@(LINE,0)=TMP
 .S LINE=LINE+1
 .S TMP="  -------      ---------    -------      ----------    ----------"
 .S @TMPARR@(LINE,0)=TMP
 .S LINE=LINE+1
 .S SEGPTR=""
 .F  S SEGPTR=+$O(@ARRAY1@(SEGPTR)) Q:('SEGPTR)  D
 ..S SEGABB=$P($G(^VAT(394.71,SEGPTR,0)),"^",2)
 ..Q:(SEGABB="")
 ..S TMP=$G(@ARRAY1@(SEGPTR))
 ..S MAXTIM=$P(TMP,"^",1)
 ..S:(MAXTIM="") MAXTIM="NA"
 ..S:(MAXTIM="@") MAXTIM="-"
 ..S MAXOCC=$P(TMP,"^",2)
 ..S:(MAXOCC="") MAXOCC="NA"
 ..S:(MAXOCC="@") MAXOCC="-"
 ..S TIME=$P(TMP,"^",3)
 ..S:(MAXTIM="NA") TIME="NA"
 ..S:(TIME="") TIME="-"
 ..S OCCUR=$P(TMP,"^",4)
 ..S:(MAXOCC="NA") OCCUR="NA"
 ..S:((OCCUR="")!(OCCUR=0)) OCCUR="-"
 ..S TMP=""
 ..S TMP=$$INSERT^VAQUTL1(SEGABB,TMP,3)
 ..S TMP=$$INSERT^VAQUTL1(TIME,TMP,16)
 ..S TMP=$$INSERT^VAQUTL1(MAXTIM,TMP,29)
 ..S TMP=$$INSERT^VAQUTL1(OCCUR,TMP,42)
 ..S TMP=$$INSERT^VAQUTL1(MAXOCC,TMP,56)
 ..S @TMPARR@(LINE,0)=TMP
 ..S LINE=LINE+1
 ;SEND TO PROCESSING GROUP
 S XMY("G.VAQ MANUAL PROCESSING")=""
 ;SEND TO SECURITY OFFICER IF LOCAL PATIENT IS SENSITIVE
 S:((+$$RES^VAQUTL99(DOMAIN,SSN))=-4) TMP=$$LOADXMY^DGSEC()
 S:((+$$RES^VAQUTL99(DOMAIN,NAME))=-4) TMP=$$LOADXMY^DGSEC()
 ;SEND BULLETIN
 S TMP="Process PDX Request for "_NAME
 S X="PDX"
 S Y="Patient Data eXchange"
 S ERROR=+$$SENDBULL^VAQBUL(TMP,X,Y,TMPARR)
 K @TMPARR
 Q:(ERROR<0) "-1^Unable to generate and send bulletin"
 Q 0
