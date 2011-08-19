SCMCHLR4 ;ALB/KCL - PCMM HL7 Reject Processing - Protocols; 10-JAN-2000
 ;;5.3;Scheduling;**210,272,505**;AUG 13, 1993;Build 20
 ;
 ;This routine contains the PCMM Transmission Error processing protocols.
 ;See EN^SCMCHLR2 for additional documentation on 'system wide' variables
 ;used in this routine.
 ;
CS ; Description: Entry point for SCMC LE CHANGE STATUS protocol.
 ;
 ;  Input:
 ;   SCEPS - Error Processing Status
 ;               1 -> New
 ;               2 -> Checked
 ;               3 -> Both
 ;
 ; Output:
 ;    SCEPS - Error Processing Status
 ;                1 -> New
 ;                2 -> Checked
 ;                3 -> Both
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N DIR,DTOUT,DUOUT,Y
 ;
 ;Set screen to full scrolling region
 D FULL^VALM1
 N DIRUT,SCBEG,SCEND,SCEPS,SCSORTBY
 ;
 ;Ask user to select error processing status
 S DIR(0)="SMO^1:New;2:Checked;3:Both"
 S DIR("A")="Select Error Processing Status"
 D ^DIR
 ;
 ;Process user response
 I Y D
 .S SCEPS=Y
 .;rebuild error list for selected error processing status
 .D BUILD^SCMCHLR1
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
CD ; Description: Entry point for SCMC LE CHANGE DATE RANGE protocol.
 ;
 ;  Input:
 ;   SCBEG - Begin date for date range
 ;   SCEND - End date for date range
 ;
 ; Output:
 ;    SCBEG - Begin date for date range
 ;    SCEND - End date for date range
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N VALMB,VALMBEG,VALMEND,X,X1,X2
 ;
 ;Ask user for date range (default 2 wks prior to today)
 S X1=DT,X2=-14
 D C^%DTC
 S VALMB=X
 D RANGE^VALM1
 ;
 ;Process user response
 I 'VALMBEG!('VALMEND)!((SCBEG=VALMBEG)&(SCEND=VALMEND)) D
 .W !!,"Date Range was not changed."
 .D PAUSE^VALM1
 .S VALMBCK=""
 E  D
 .S SCBEG=VALMBEG,SCEND=VALMEND
 .;rebuild error list for selected date range
 .D BUILD^SCMCHLR1
 .;Refresh screen when returning from action
 .S VALMBCK="R"
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 Q
 ;
 ;
SL ; Description: Entry point for SCMC LE SORT LIST protocol.
 ;
 ;  Input:
 ;   SCSORTBY - Sort by criteria
 ;
 ; Output:
 ;  SCSORTBY - Sort by criteria
 ;   VALMBCK - 'R'=Refresh screen
 ;
 N DIR,DTOUT,DUOUT,Y
 ;
 ;Sets screen to full scrolling region
 D FULL^VALM1
 ;
 ;Ask user to select sort by criteria
 S DIR(0)="SMO^N:Patient Name;D:Date Error Received;P:Provider;I:Institution"
 S DIR("A")="Select Sort By"
 D ^DIR
 ;
 ;Process user response
 I "^N^D^P^I^"[("^"_Y_"^"),SCSORTBY'=Y D
 .S SCSORTBY=Y
 .;rebuild error list for selected sort criteria
 .D BUILD^SCMCHLR1
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
CE ; Description: Entry point for SCMC LE CHECK ERROR OFF LIST protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   VALMSG - Custom message
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N NODE,SCLINE,SCNUM,SCTLIEN,SCERIEN,VALMY
 ;
 ;Ask user to select transmission errors to check off the list
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 ;
 ;Process user selection
 S SCNUM=0
 F  S SCNUM=$O(VALMY(SCNUM)) Q:'SCNUM  D
 .;invoke call to check error off list
 .I $D(^TMP(SCARY_"IDX",$J,SCNUM)) D
 ..S NODE=$G(^TMP(SCARY_"IDX",$J,SCNUM))
 ..S SCLINE=+NODE,SCTLIEN=+$P(NODE,"^",2),SCERIEN=+$P(NODE,"^",3)
 ..D CHKERR(SCARY,SCLINE,SCTLIEN,SCERIEN)
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
RP ; Description: Entry point for SCMC LE RETRANSMIT PATIENT protocol.
 ;
 ;  Input: None
 ;
 ; Output: 
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N NODE,SCLINE,SCNUM,SCTLIEN,SCTLOG,VALMY
 ;
 ;Ask user to select transmission errors to retransmit patient
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 ;
 ;Process user selections
 S SCNUM=0
 F  S SCNUM=$O(VALMY(SCNUM)) Q:'SCNUM  D
 .;
 .I $D(^TMP(SCARY_"IDX",$J,SCNUM)) D
 ..S NODE=$G(^TMP(SCARY_"IDX",$J,SCNUM))
 ..S SCLINE=+NODE,SCTLIEN=+$P(NODE,"^",2),SCERIEN=+$P(NODE,"^",3)
 ..;get information for PCMM HL7 Transmission Log entry and invoke code
 ..;to set patient to 'retransmit'.
 ..I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D SETPAT(SCARY,SCLINE,.SCTLOG)
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
PE ; Description: Entry point for SCMC LE PRINT ERROR CODES protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  VALMBCK - 'R'=Refresh screen
 ;
 ;Sets screen to full scrolling region
 D FULL^VALM1
 ;
 ;Print PCMM Transmission Error Code Report
 D ECRPRT^SCMCHLR7
 D PAUSE^VALM1
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
RA ; Description: Entry point for SCMC LE RETRANSMIT ALL protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N DIR,DTOUT,DUOUT,Y
 ;
 ;Sets screen to full scrolling region
 D FULL^VALM1
 ;
 ;Ask user if they want to retransmit all patients
 S DIR(0)="Y"
 S DIR("A")="Mark all patients for re-transmission"
 S DIR("A",1)="This action will allow all patients to be marked for re-transmission."
 S DIR("A",2)="The error processing status for all patients will be marked as checked."
 S DIR("B")="NO"
 D ^DIR
 ;
 ;Process user response
 I '$D(DIRUT) D
 .I +Y D
 ..;set all patients as re-transmit
 ..D UPDALL
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
CHKERR(SCARY,SCLINE,SCTLIEN,SCERIEN) ;
 ; Description: Used to check an error off the list.
 ;
 ;  Input:
 ;     SCARY - Global array subscript
 ;    SCLINE - Line number
 ;   SCTLIEN - PCMM HL7 Transmission Log IEN
 ;   SCERIEN - IEN of record in Error Code (#404.47142) multiple
 ;
 ; Output: None
 ;
 N SCERMSG
 ;
 I $$UPDEPS^SCMCHLA(SCTLIEN,SCERIEN,2,.SCERMSG) D
 .D FLDTEXT^VALM10(SCLINE,"STATUS","Checked")
 .D FLDCTRL^VALM10(SCLINE,"STATUS",IOINHI,IOINORM)
 E  D
 .W !,^TMP(SCARY,$J,SCLINE,0)
 .W:$G(SCERMSG)'="" !,"...",$$LOWER^VALM1(SCERMSG)
 .W !,"...Unable to check error off list"
 .D PAUSE^VALM1
 Q
 ;
 ;
SETPAT(SCARY,SCLINE,SCTLOG) ; Description: Used to set patient to marked for re-transmit.
 ;
 ;  Input:
 ;    SCARY - Global array subscript
 ;   SCLINE - Line number
 ;   SCTLOG - Transmission log entry array
 ;
 ; Output: None
 ;
 N SCERROR
 ;
 ;Set patient to marked for re-transmit
 I $$UPDSTAT^SCMCHLA(SCTLIEN,"M",.SCERROR) D
 .D UPDPAT(SCARY,$S($G(SCTLOG("DFN")):SCTLOG("DFN"),1:"W"),$S('$G(SCTLOG("DFN")):SCLINE,1:""))
 E  D
 .W !,^TMP(SCARY,$J,SCLINE,0)
 .W:$G(SCERMSG)'="" !,"...",$$LOWER^VALM1(SCERROR)
 .W !,"...Unable to mark patient for re-transmit"
 .D PAUSE^VALM1
 Q
 ;
 ;
UPDPAT(SCARY,SCDFN,LINE) ; Description: Update all PCMM HL7 Transmission Log
 ; entries in the list for the patient as 'marked for re-transmit'.
 ;
 ;  Input:
 ;   SCARY - Global array subscript
 ;   SCDFN - Patient IEN
 ;
 ; Output: None
 ;
 N SCLINE,SCTLIEN
 S:'$G(LINE) LINE=9999999
 ;
 ;Loop thru entries in the list for the patient
 S SCLINE=0
 I SCDFN="W",LINE'=9999999 S SCLINE=LINE-.01
 F  S SCLINE=$O(^TMP(SCARY_"IDX",$J,"PT",SCDFN,SCLINE)) Q:(('SCLINE)!(SCLINE>LINE))  S SCTLIEN=+^(SCLINE) D
 .;update entry as marked for re-transmit
 .D FLDTEXT^VALM10(SCLINE,"RETRANS","*")
 .D FLDCTRL^VALM10(SCLINE,"RETRANS",IOINHI,IOINORM)
 .;invoke code to check error off the list
 .D CHKERR(SCARY,SCLINE,SCTLIEN,SCERIEN)
 Q
 ;
 ;
UPDALL ; Description: Update all PCMM HL7 Transmission Log
 ; entries in the list as 'marked for re-transmit'.
 ;
 ;  Input: None
 ; Output: None
 ;
 N SCLINE,SCTLIEN,SCDFN
 ;
 ;Loop thru entries in the list for all patients
 S SCDFN=""
 F  S SCDFN=$O(^TMP(SCARY_"IDX",$J,"PT",SCDFN)) Q:'SCDFN  D
 .;Loop thru entries in the list for the patient
 .S SCLINE=0
 .F  S SCLINE=$O(^TMP(SCARY_"IDX",$J,"PT",SCDFN,SCLINE)) Q:'SCLINE  D
 ..S NODE=^TMP(SCARY_"IDX",$J,"PT",SCDFN,SCLINE)
 ..S SCTLIEN=+NODE,SCERIEN=+$P(NODE,"^",2)
 ..;
 ..;get information for PCMM HL7 Transmission Log entry and invoke code
 ..;to set patient to 'retransmit'.
 ..I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D SETPAT(SCARY,SCLINE,.SCTLOG)
 ..;
 ..;update entry as marked for re-transmit
 ..D FLDTEXT^VALM10(SCLINE,"RETRANS","*")
 ..D FLDCTRL^VALM10(SCLINE,"RETRANS",IOINHI,IOINORM)
 ..;invoke code to check error off the list
 ..D CHKERR(SCARY,SCLINE,SCTLIEN,SCERIEN)
 ;
 Q
