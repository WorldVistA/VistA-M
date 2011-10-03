SCMCHLR5 ;ALB/KCL - PCMM HL7 Reject Processing - Protocols con't ; 10-JAN-2000
 ;;5.3;Scheduling;**210,272**;AUG 13, 1993
 ;
 ;This routine contains the PCMM Transmission Error processing protocols.
 ;See EN^SCMCHLR2 for additional documentation on 'system wide' variables
 ;used in this routine.
 ;
UE ; Description: Entry point for SCMC LE UNCHECK ERROR protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N NODE,SCLINE,SCNUM,SCTLIEN,SCERIEN,VALMY
 ;
 ;Ask user to select transmission errors to uncheck on the list
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 ;
 ;Process user selection
 S SCNUM=0
 F  S SCNUM=$O(VALMY(SCNUM)) Q:'SCNUM  D
 .;invoke call to mark error as new on list
 .I $D(^TMP(SCARY_"IDX",$J,SCNUM)) D
 ..S NODE=$G(^TMP(SCARY_"IDX",$J,SCNUM))
 ..S SCLINE=+NODE,SCTLIEN=+$P(NODE,"^",2),SCERIEN=+$P(NODE,"^",3)
 ..D UNCHKERR(SCARY,SCLINE,SCTLIEN,SCERIEN)
 ;
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
DP ; Description: Entry point for SCMC LE DESELECT PATIENT RETRANSMIT protocol.
 ;
 ;  Input: None
 ;
 ; Output: 
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N NODE,SCLINE,SCNUM,SCTLIEN,SCTLOG,VALMY
 ;
 ;Ask user to select transmission errors to deselect
 D EN^VALM2(XQORNOD(0))
 ;
 ;set screen to full scrolling region
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
 ..I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D DESLPAT(SCARY,SCLINE,.SCTLOG)
 ;
 ;Place custom msg in msg window
 ;S VALMSG=$$MRKMSG^SCMCHLR1
 ;
 ;Refresh screen when returning from action
 S VALMBCK="R"
 Q
 ;
 ;
DA ; Description: Entry point for SCMC LE DESELECT ALL protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  VALMBCK - 'R'=Refresh screen
 ;
 N DIR,DTOUT,DUOUT,Y
 ;
 ;Set screen to full scrolling region
 D FULL^VALM1
 ;
 ;Ask user if they want to deselect all patients for retransmit
 S DIR(0)="Y"
 S DIR("A")="Deselect all patients"
 S DIR("A",1)="This action will allow all patients that are currently"
 S DIR("A",2)="marked for re-transmission to be deselected."
 S DIR("B")="NO"
 D ^DIR
 ;
 ;Process user response
 I '$D(DIRUT) D
 .I +Y D
 ..;set all patients status to rejected
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
UNCHKERR(SCARY,SCLINE,SCTLIEN,SCERIEN) ;
 ; Description: Used to uncheck an error on the list.
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
 ;if status is marked for retransmit error can not be marked as new
 I $$STATUS^SCMCHLA(SCTLIEN)="M" D
 .W !,^TMP(SCARY,$J,SCLINE,0)
 .W:$G(SCERMSG)'="" !,"...",$$LOWER^VALM1(SCERMSG)
 .W !,"...Unable to update error processing status"
 .W !,"...Patient already marked for re-transmission"
 .D PAUSE^VALM1
 E  D
 .I $$UPDEPS^SCMCHLA(SCTLIEN,SCERIEN,1,.SCERMSG) D
 ..D FLDTEXT^VALM10(SCLINE,"STATUS","New")
 ..D FLDCTRL^VALM10(SCLINE,"STATUS",IOINHI,IOINORM)
 Q
 ;
 ;
DESLPAT(SCARY,SCLINE,SCTLOG) ; Description: Used to set patient to rejected.
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
 ;Set patient to rejected
 I $$UPDSTAT^SCMCHLA(SCTLIEN,"RJ",.SCERROR) D
 .D UPDPAT(SCARY,$S($G(SCTLOG("DFN")):SCTLOG("DFN"),1:"W"),$S('$G(SCTLOG("DFN")):SCLINE,1:""))
 E  D
 .W !,^TMP(SCARY,$J,SCLINE,0)
 .W:$G(SCERMSG)'="" !,"...",$$LOWER^VALM1(SCERROR)
 .W !,"...Unable to deselect patient for re-transmit"
 .D PAUSE^VALM1
 Q
 ;
 ;
UPDPAT(SCARY,SCDFN,LINE) ; Description: Update all PCMM HL7 Transmssion Log
 ; entries in the list for the patient as 'rejected'.
 ;
 ;  Input:
 ;   SCARY - Global array subscript
 ;   SCDFN - Patient IEN
 ;
 ; Output: None
 ;
 S:'$G(LINE) LINE=999999
 N SCLINE,SCTLIEN
 ;
 ;Loop thru entries in the list for the patient
 S SCLINE=0
 I SCDFN="W",LINE'=999999 S SCLINE=LINE-.01
 F  S SCLINE=$O(^TMP(SCARY_"IDX",$J,"PT",SCDFN,SCLINE)) Q:(('SCLINE)!(SCLINE>LINE))  S SCTLIEN=+^(SCLINE) D
 .;update entry that was marked for re-transmit to null
 .D FLDTEXT^VALM10(SCLINE,"RETRANS"," ")
 Q
 ;
 ;
UPDALL ; Description: Update all PCMM HL7 Transmssion Log
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
 ..;to set patient to 'rejected'.
 ..I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D DESLPAT(SCARY,SCLINE,.SCTLOG)
 ..;
 ..;update entry that was marked for re-transmit to null
 ..D FLDTEXT^VALM10(SCLINE,"RETRANS"," ")
 ;
 Q
