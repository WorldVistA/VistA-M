SDES2RECLDIPREAS ; ALB/TJB,JDJ - VISTA SCHEDULING GET DELETE REASON RPC in FILE 403.56 ;JUL 25, 2025
 ;;5.3;Scheduling;**864,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to HELP^DIE is supported by IA #2053
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q  ;No Direct Call
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
GETDELREASON(JSONRETURN,SDCONTEXT,SDPARAM) ;
 ;
 N RETURN,ERRORS
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("DeleteReason",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 ;Visitor Pattern
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 D BUILDDATA(.RETURN)
 D BUILDJSON^SDES2JSON(.JSONRETURN,.RETURN)
 Q
 ;
 ; Data returned by D FIELD^DID will look like:
 ; Need to parse the data and put it in the returned array
 ; K RESULT D FIELD^DID(403.56,203,"","SET OF CODES","RESULT","ERR")
 ; ZW RESULT
 ; RESULT("SET OF CODES")="1:FAILURE TO RESPOND;2:MOVED;3:DECEASED;4:DOESN'T WANT V
 ; A SERVICES;5:RECEIVED CARE AT ANOTHER VA;6:OTHER;7:APPT SCHEDULED;8:VET SELF-CANCEL;"
BUILDDATA(RETURN) ;
 N NUMCODES,MYHELP,MYENTRY,I
 K MYHELP D FIELD^DID(403.56,203,"","SET OF CODES","MYHELP","ERR")
 S NUMCODES=MYHELP("SET OF CODES")
 F I=1:1:($L(MYHELP("SET OF CODES"),";")-1) S MYENTRY=$P(MYHELP("SET OF CODES"),";",I) I MYENTRY'="" D
 . S RETURN("DeleteReason",I,"Code")=$P(MYENTRY,":",1)
 . S RETURN("DeleteReason",I,"Description")=$P(MYENTRY,":",2)
 Q
