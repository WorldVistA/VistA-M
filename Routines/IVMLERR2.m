IVMLERR2 ;ALB/RMO,ERC - IVM Transmission Error Processing - Protocols; 15-SEP-1997 ; 5/29/07 9:29am
 ;;2.0;INCOME VERIFICATION MATCH;**9,121**; 21-OCT-94;Build 45
 ;
 ;This routine contains the IVM transmission log error processing
 ;protocols.
 ;
 ;See EN^IVMLERR1 for additional documentation on 'system wide variables'
 ;used in this routine.
 ;
CL ;Entry point for IVMLE CHANGE LIST protocol
 ; Input  -- IVMEPSTA Error processing statuses
 ; Output -- IVMEPSTA Error processing statuses
 ;           VALMSG   Custom message
 ;           VALMBCK  R   =Refresh screen
 N DIR,DTOUT,DUOUT,Y
 D FULL^VALM1
 ;
 ;Ask user to select error processing statuses
 S DIR(0)="SMO^1:New;2:Checked;3:Both"
 S DIR("A")="Select Error Processing Status"
 D ^DIR
 ;
 ;Process user response
 S:Y=3 Y="1^2"
 I Y,"^1^2^"[(U_Y_U) D
 . S IVMEPSTA=Y
 . ;Re-build error list for selected statuses
 . D BLD^IVMLERR
 S VALMSG=$$MSG^IVMLERR
 S VALMBCK="R"
 Q
 ;
CD ;Entry point for IVMLE CHANGE DATE RANGE protocol
 ; Input  -- IVMBEG   Begin date
 ;           IVMEND   End date
 ; Output -- IVMBEG   Begin date
 ;           IVMEND   End date
 ;           VALMSG   Custom message
 ;           VALMBCK  R   =Refresh screen
 N VALMB,VALMBEG,VALMEND
 S VALMB=IVMBEG
 ;
 ;Ask user for date range
 D RANGE^VALM1
 ;
 ;Process user response
 I 'VALMBEG!((IVMBEG=VALMBEG)&(IVMEND=VALMEND)) D
 . W !!,"Date Range was not changed."
 . D PAUSE^VALM1
 . S VALMBCK=""
 ELSE  D
 . S IVMBEG=VALMBEG,IVMEND=VALMEND
 . ;Re-build error list for selected date range
 . D BLD^IVMLERR
 . S VALMBCK="R"
 S VALMSG=$$MSG^IVMLERR
 Q
 ;
SL ;Entry point for IVMLE SORT LIST protocol
 ; Input  -- IVMSRTBY Sort by criteria
 ; Output -- IVMSRTBY Sort by criteria
 ;           VALMSG   Custom message
 ;           VALMBCK  R   =Refresh screen
 N DIR,Y
 D FULL^VALM1
 ;
 ;Ask user to select sort criteria
 S DIR(0)="SMO^P:Patient Name;D:Date/Time ACK Received;E:Error Message"
 S DIR("A")="Select Sort By"
 S DIR("B")="P"
 D ^DIR
 S IVMY=$G(Y)
 ;S IVMSRTBY=$S($G(Y)="E":"E",$G(Y)="D":"D",1:"P")
 ;if sorting by error message ask if just Person Not Found
 I $G(Y)="E" D
 . N DIR,Y
 . S DIR(0)="SMO^O:'Person Not Found' only;A:All Error Messages"
 . S DIR("A")="Select ALL Error Messages or 'Person Not Found' only"
 . D ^DIR
 . I $D(DIRUT)!($D(DIROUT)) G ASK^IVMLERR
 . ;if by 'Person Not Found' only, use Error Processing
 . ;Status of NEW and CHECKED
 . I $G(Y)="O" S IVMEPSTA="1^2",IVMY="O"
 ;if the report has not run once already, Q and return to 
 ;INIT^IVMLERR
 I $G(IVMFLG)=1 D  Q
 . S IVMFLG=0
 . S IVMSRTBY=IVMY
 ;
 ;Process user response
 I "^P^D^E^O^"[(U_IVMY_U),IVMSRTBY'=IVMY D
 . S IVMSRTBY=IVMY
 . ;Re-build error list for selected sort criteria
 . D BLD^IVMLERR
 S VALMSG=$$MSG^IVMLERR
 S VALMBCK="R"
 Q
 ;
CE ;Entry point for IVMLE CHECK ERROR OFF LIST protocol
 ; Input  -- None
 ; Output -- VALMSG   Custom message
 ;           VALMBCK  R   =Refresh screen
 N IVMLINE,IVMNUM,IVMTLIEN,VALMY
 ;
 ;Ask user to select transmission errors to check off the list
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 ;
 ;Process user selection
 S IVMNUM=0
 F  S IVMNUM=$O(VALMY(IVMNUM)) Q:'IVMNUM  D
 . ;Invoke call to check error off list
 . I $D(^TMP(IVMARY_"IDX",$J,IVMNUM)) S IVMLINE=+^(IVMNUM),IVMTLIEN=+$P(^(IVMNUM),U,2) D CHKERR(IVMARY,IVMLINE,IVMTLIEN)
 S VALMBCK="R"
 S VALMSG=$$MSG^IVMLERR
 Q
 ;
CHKERR(IVMARY,IVMLINE,IVMTLIEN) ;Check error off list
 ; Input  -- IVMARY   Global array subscript
 ;           IVMLINE  Line number
 ;           IVMTLIEN IVM transmission log IEN
 ; Output -- None
 N IVMERMSG
 I $$ERRSTAT^IVMTLOG(IVMTLIEN,2,.IVMERMSG) D
 . D FLDTEXT^VALM10(IVMLINE,"STATUS","Checked")
 . D FLDCTRL^VALM10(IVMLINE,"STATUS",IOINHI,IOINORM)
 ELSE  D
 . W !,^TMP(IVMARY,$J,IVMLINE,0)
 . W:$G(IVMERMSG)'="" !,"...",$$LOWER^VALM1(IVMERMSG)
 . W !,"...Unable to check error off list"
 . D PAUSE^VALM1
 Q
 ;
RP ;Entry point for IVMLE RETRANSMIT PATIENT protocol
 ; Input  -- None
 ; Output -- VALMSG   Custom message
 ;           VALMBCK  R   =Refresh screen
 N IVMLINE,IVMNUM,IVMTLIEN,IVMTLOG,VALMY
 ;
 ;Ask user to select transmission errors to retransmit patient
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 ;
 ;Process user selection
 S IVMNUM=0
 F  S IVMNUM=$O(VALMY(IVMNUM)) Q:'IVMNUM  D
 . I $D(^TMP(IVMARY_"IDX",$J,IVMNUM)) S IVMLINE=+^(IVMNUM),IVMTLIEN=+$P(^(IVMNUM),U,2) D
 . . ;Get information for IVM transmission log entry and invoke code
 . . ;to set patient to retransmit
 . . I $$GET^IVMTLOG(IVMTLIEN,.IVMTLOG) D SETPAT(IVMARY,IVMLINE,.IVMTLOG)
 S VALMBCK="R"
 S VALMSG=$$MSG^IVMLERR
 Q
 ;
SETPAT(IVMARY,IVMLINE,IVMTLOG) ;Set patient to retransmit
 ; Input  -- IVMARY   Global array subscript
 ;           IVMLINE  Line number
 ;           IVMTLOG  IVM transmission log entry array
 ; Output -- None
 N IVMERMSG,IVMEVTS
 M IVMEVTS=IVMTLOG("EVENTS")
 ;
 ;Set patient to retransmit
 I $$SETSTAT^IVMPLOG(IVMTLOG("PAT"),.IVMEVTS,.IVMERMSG) D
 . D UPDPAT(IVMARY,IVMTLOG("PAT"))
 ELSE  D
 . W !,^TMP(IVMARY,$J,IVMLINE,0)
 . W:$G(IVMERMSG)'="" !,"...",$$LOWER^VALM1(IVMERMSG)
 . W !,"...Unable to set transmit flag for patient"
 . D PAUSE^VALM1
 Q
 ;
UPDPAT(IVMARY,IVMDFN) ;Update all IVM transmssion error log entries in the list
 ;for the patient as retransmit
 ; Input  -- IVMARY   Global array subscript
 ;           IVMDFN   IVM patient IEN
 ; Output -- None
 N IVMLINE,IVMTLIEN
 ;
 ;Loop through entries in the list for the patient
 S IVMLINE=0
 F  S IVMLINE=$O(^TMP(IVMARY_"IDX",$J,"PT",IVMDFN,IVMLINE)) Q:'IVMLINE  S IVMTLIEN=+^(IVMLINE) D
 . ;Update entry as retransmit
 . D FLDTEXT^VALM10(IVMLINE,"RETRANSMIT","*")
 . D FLDCTRL^VALM10(IVMLINE,"RETRANSMIT",IOINHI,IOINORM)
 . ;Invoke code to check error off the list
 . D CHKERR(IVMARY,IVMLINE,IVMTLIEN)
 Q
