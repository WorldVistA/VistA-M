RCDPEWLP ;ALBANY/KML - EDI LOCKBOX ERA and EEOB WORKLIST procedures ;10 Oct 2018 11:49:24
 ;;4.5;Accounts Receivable;**298,303,304,319,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; PRCA*4.5*298 - handle outstanding EFTs & ERAs with exceptions
 ;
AGEDEFTS(ERADA,TYPE) ;function, Search medical or pharmacy aged EFTs that have not been posted 
 ; ENTRY point for the Select ERA action on the ERA Worklist screen
 ; Input:   ERADA - IEN in file 344.4
 ;          TYPE    - Medical, Pharmacy or Tricare (M,P, T)
 ; Returns: 
 ; "1P" Error for aged, unposted pharmacy EFTs
 ; "2P" Warning for aged,unposted pharmacy EFTs
 ; "3P" Override exists for aged, unposted pharmacy EFTs
 ; "1M" Error for aged, unposted medical EFTs
 ; "2M" Warning for aged, unposted medical EFTs
 ; "3M" Override exists for aged, unposted medical EFTs
 ; "1T" Error for aged, unposted Tricare EFTs
 ; "2T" Warning for aged, unposted Tricare EFTs
 ; "3T" Override exists for aged, unposted Tricare EFTs
 ;  0   No error or warning conditions
 ;  NOTE: may be more than one - "1P" or "2P" or "3P" or "3P^2M" or "3P^3M", etc.
 ;
 ;for action Select ERA:
 ; 1. If unposted payments (EFTs) associated with 3rd party Medical claims > than 14 days, display WARNING message for action 
 ;    Select ERA on the ERA WORKLIST, allow user to enter the worklist
 ; 2. If there are unposted payments (EFTs) associated with Pharmacy claims > 21 days, display a WARNING message
 ;    on the ERA WORKLIST, enter worklist
 ; 3. If there are unposted payments (EFTs) associated with 3rd party Tricare claims 
 ;    > 14 calendar days, display WARNING message, enter worklist
 ; 4. If there are unposted payments (EFTs) associated with 3rd party medical, pharmacy or
 ;    Tricare claims, aged > the number of days in site parameters, display error message
 ;additional criteria for item 3:
 ;create scratchpad if:
 ; 3a. medical ERA is 14 days or older
 ; 3b. pharmacy ERA is 21 days or older
 ; 3c. Tricare ERA is 14 days or older
 ; 3d. If override exists
 ;DO NOT create scratchpad if no override and:
 ; 3e. medical ERA received within 14 days and there are aged, unposted EFTs
 ; 3f. pharmacy ERA received within 21 days and there are aged, unposted EFTs
 ; 3g. Tricare ERA received within 14 days and there are aged, unposted EFTs
 ;
 ;Do not consider EFTs older than two months prior to national release
 ;Note: EFTs to be auto-posted to a receipt included in search for aged, unposted EFTs
 N DATE,EFTDA,EFT0,RC3444,RC34431,SELERADT,UNPOST,X
 S UNPOST=0
 S RC3444=^RCY(344.4,ERADA,0)
 I '$P(RC3444,U,5) G AEFTSQ  ; skip ERAs with zero payment 
 S EFTDA=+$O(^RCY(344.31,"AERA",ERADA,0))
 S:EFTDA RC34431=^RCY(344.31,EFTDA,0)
 I 'EFTDA,$P(RC3444,U,9)=2 G AEFTSQ  ; Ignore selected ERAs that are MATCHED TO PAPER CHECK
 ;
 ; skip unmatched ERAs with EXPECTED PAYMENT CODE "CHK"
 I 'EFTDA,$P(RC3444,U,15)="CHK" G AEFTSQ
 ;
 ; Use FILE DATE/TIME (344.4, .07) of ERA if no EFT (unmatched ERA),
 ; else use DATE RECEIVED (344.31,.13) of EFT associated with ERA 
 S SELERADT=$S('EFTDA:$P($P(RC3444,U,7),"."),1:$P(RC34431,U,13))
 ;
 I TYPE="P" D  G AEFTSQ
 . I $$FMDIFF^XLFDT(DT,SELERADT)>21 S UNPOST=0 Q  ;ERA older than 21 days, enter scratchpad
 . S UNPOST=$$GETEFTS(TYPE)  ;NOT older than 21 days, get unposted, aged EFTs
 ;
 I TYPE="M" D  G AEFTSQ
 . I $$FMDIFF^XLFDT(DT,SELERADT)>14 S UNPOST=0 Q  ;ERA older than 14 days, enter scratchpad
 . S UNPOST=$$GETEFTS(TYPE)  ;NOT older than 14 days, get unposted, aged EFTs
 ;
 I TYPE="T" D  G AEFTSQ
 . I $$FMDIFF^XLFDT(DT,SELERADT)>14 S UNPOST=0 Q  ;ERA older than 14 days, enter scratchpad
 . S UNPOST=$$GETEFTS(TYPE)  ;NOT older than 14 days, get unposted, aged EFTs
 ;
AEFTSQ ; single exit for function
 Q UNPOST
 ;
GETEFTS(TYPE,OPTION) ;function, EP from RCDPEUPO for Unposted EFT Override option 
 ; Set up search criteria for unposted EFTs. If aged, unposted EFTs create warning/prevention messages
 ; TYPE: "M" (Medical ERA-EFT), "P" (Phamacy ERA-EFT), "T" (Tricare ERA-EFT), "A" (Medical, Pharmacy & Tricare)
 ;OPTION:
 ;  null if Called by Select ERA action on ERA Worklist
 ;  1 if Called by RCDPE UNPOSTED EFT OVERRIDE option
 ; Returns: See output for AGEDEFTS
 ;
 N ARRAY,DAYSLIMT,DTARRY,OUTCOME,OVERRIDE,STARTDT,STR,TRARRY,X
 S OPTION=$G(OPTION)
 I TYPE="A" D  ; Retrieve all Aged Days limits
 . S DAYSLIMT("M")=$$GET1^DIQ(344.61,1,.06)  ; Medical
 . S DAYSLIMT("P")=$$GET1^DIQ(344.61,1,.07)  ; Pharmacy
 . S DAYSLIMT("T")=$$GET1^DIQ(344.61,1,.13)  ; Tricare
 ; Retrieve Aged Days limit for specified type
 I '(TYPE="A") S DAYSLIMT(TYPE)=$$GET1^DIQ(344.61,1,$S(TYPE="M":.06,TYPE="P":.07,1:.13))
 S STARTDT=$$CUTOFF
 D EFTDET(STARTDT,TYPE,.DAYSLIMT,.TRARRY)
 ;
 ; Aged unposted EFTs exist. Create prevention message and if called within
 ; the Worklist (not Override option) plus msg. with list of TRACE #s
 F X="M","P","T" D
 . I $D(TRARRY("ERROR",X)) D
 ..  D CHECK^RCDPEUPO(X,.OVERRIDE)          ; Determine if Override exists
 ..  I OVERRIDE S OUTCOME=$G(OUTCOME)_3_X_U Q
 ..  S OUTCOME=$G(OUTCOME)_1_X_U
 ..  ; do not display warning msg if error condition exists
 ..  K TRARRY("WARNING",X)
 ..  Q:OPTION  Q:OVERRIDE
 ..  Q:(TYPE'="A"&(TYPE'=X))  ; Only show error messages for TYPE
 ..  M ARRAY=TRARRY("ERROR",X)
 ..  D FTRACE(.ARRAY,.STR),PREVMSG(X,.DAYSLIMT,.STR)
 ..  K ARRAY
 ;
 F X="M","P","T" D
 . I $D(TRARRY("WARNING",X)) D
 ..  S OUTCOME=$G(OUTCOME)_2_X_U
 ..  Q:OPTION  ; Called by OVERRIDE option, no trace number list
 ..  Q:(TYPE'="A"&(TYPE'=X))  ; Only show warning messages for TYPE
 ..  M ARRAY=TRARRY("WARNING",X)
 ..  D FTRACE(.ARRAY,.STR),WARNMSG(X,.STR)
 ..  K ARRAY ; aged unposted EFTs > 21 days exist, generate warning message
 ;
 S:'$D(OUTCOME) OUTCOME=0  ; no error or warnings
 ;
 Q OUTCOME
 ;
CUTOFF() ; Returns EFT Cutoff date
 ; date is 2 months prior to install date of patch 298, ignore aged EFTS older than that
 N RCX S RCX=+$P($G(^RCY(344.61,1,0)),U,9)
 S:RCX=0 RCX=DT
 Q $$FMADD^XLFDT(RCX,-61,0,0)
 ;
EFTDET(RECVDT,TYPE,DAYSLIMT,TRARRY) ; Gather EFT data, Only EFTs that are aged and unposted
 ;Input: 
 ; RECVDT - start date in DATE RECEIVED cross-reference of file 344.3
 ; TYPE- "M" - (Medical ERA-EFT), "P" (Phamacy ERA-EFT), "T" (TRICARE ERA-EFT), "A" (Medical, Pharmacy and Tricare)
 ; DAYSLIMT - days EFT can age before post prevention rules apply
 ;Output:
 ; TRARRY - Array of trace numbers of the aged, unposted EFTs
 ;  
 N EFTDA
 F  S RECVDT=$O(^RCY(344.31,"ADR",RECVDT)) Q:'RECVDT  D
 . S EFTDA="" F  S EFTDA=$O(^RCY(344.31,"ADR",RECVDT,EFTDA)) Q:'EFTDA  D
 ..  D CHKEFT(RECVDT,EFTDA,TYPE,.DAYSLIMT,.TRARRY)
 Q
 ;
CHKEFT(RECVDT,EFTDA,TYPE,DAYSLIMT,TRARRY) ; Check EFT for warnings/errors
 ;Input:
 ; RECVDT - Date Received
 ; EFTDA - IEN of EDI THIRD PARY EFT DETAIL
 ; TYPE - "M" (Medical ERA-EFT), "P" (Phamacy ERA-EFT), "T"(Tricare ERA-EFT), "A" (Medical, Pharmacy and Tricare)
 ; DAYSLIMT  - days an EFT can age before post prevention rules apply 
 ; TRARRY    - Array with warning error info
 ;
 N AGED,EFTTYPE,ERAREC,MSTATUS,TRACE
 Q:$G(^RCY(344.31,EFTDA,0))=""  ; skip, no data
 Q:+$$GET1^DIQ(344.31,EFTDA_",",.07,"I")=0  ; skip, zero payment amt.
 ;
 ; Ignore duplicate EFTs which have been removed 
 Q:$$GET1^DIQ(344.31,EFTDA_",",.18,"I")  ;^DD(344.31,.18,0)="DATE/TIME DUPLICATE REMOVED
 S ERAREC=+$$GET1^DIQ(344.31,EFTDA_",",.1,"I")  ; Pointer to ERA record
 I ERAREC,$$GET1^DIQ(344.4,ERAREC_",",.14,"I")=1 Q  ; Ignore posted ERA-EFTs 
 ;
 ; Exclude EFT matched to Paper EOB if receipt is processed
 I 'ERAREC,$$GET1^DIQ(344.31,EFTDA_",",.08,"I") Q:$$PROC(EFTDA)
 S MSTATUS=+$$GET1^DIQ(344.31,EFTDA_",",.08,"I")  ; MATCH STATUS
 S AGED=$$FMDIFF^XLFDT(DT,RECVDT)  ; days aged for EFT
 S TRACE=$$GET1^DIQ(344.31,EFTDA_",",.04,"I")  ; TRACE #
 S:TRACE="" TRACE="(No trace #)"
 ; no ERA, cannot evaluate further
 I 'ERAREC D  Q  ;
 . S EFTTYPE=$S($$ISTYPE^RCDPEU1(344.31,EFTDA,"P"):"P",$$ISTYPE^RCDPEU1(344.31,EFTDA,"T"):"T",1:"M")
 . S TRARRY("WARNING",EFTTYPE,TRACE)="No ERA found"_U_MSTATUS
 ;
 I (TYPE="A")!(TYPE="P"),$$PHARM(ERAREC) D  Q
 . ; Aged, unposted EFT gets error message, no scratchpad for the ERA
 . I AGED>DAYSLIMT("P") S TRARRY("ERROR","P",TRACE)="ERA = "_ERAREC_U_MSTATUS Q
 . ; Aged, unposted PHARMACY EFT display warning message when entering scratchpad with the ERA
 . I '$D(TRARRY("ERROR")),AGED>21 S TRARRY("WARNING","P",TRACE)="ERA = "_ERAREC_U_MSTATUS
 ;
 I (TYPE="A")!(TYPE="T"),$$ISTYPE^RCDPEU1(344.31,EFTDA,"T") D  Q  ; is payer type Tricare?
 . ; Aged, unposted EFT gets error message, no scratchpad for the ERA
 . I AGED>DAYSLIMT("T") S TRARRY("ERROR","T",TRACE)="ERA = "_ERAREC_U_MSTATUS Q
 . ; Aged, unposted MEDICAL EFT display warning message when entering scratchpad with the ERA
 . I '$D(TRARRY("ERROR")),AGED>14 S TRARRY("WARNING","T",TRACE)="ERA = "_ERAREC_U_MSTATUS
 ;
 I (TYPE="A")!(TYPE="M"),'$$PHARM(ERAREC) D
 . I AGED>DAYSLIMT("M") S TRARRY("ERROR","M",TRACE)="ERA = "_ERAREC_U_MSTATUS Q
 . ; Aged, unposted MEDICAL EFT warning message when entering scratchpad with ERA
 . I '$D(TRARRY("ERROR")),AGED>14 S TRARRY("WARNING","M",TRACE)="ERA = "_ERAREC_U_MSTATUS
 ;
 Q
 ;
PROC(EFTDA) ; Check if TR Receipt for an EFT linked to Paper EOB is processed 
 ; Input:   EFTDA - IEN for file 344.31
 ; Returns: 1 if TR receipt exists and is OPEN, 0 otherwise
 N IEN344,RET S RET=0
 ; Find TR receipt and check if status is not CLOSED
 S IEN344=$O(^RCY(344,"AEFT",EFTDA,0))
 I IEN344,$$GET1^DIQ(344,IEN344_",",.14,"I")'=1 S RET=1
 Q RET
 ;
FTRACE(TRARRY,STR) ; both args. passed by ref.
 ; TRARRY  - trace numbers of aged, unposted EFTs
 ; returns: STR - array of trace numbers separated by commas for warning or error message
 N CTR,LEN,TRACE,X
 K STR S CTR=1,TRACE=""
 F  S TRACE=$O(TRARRY(TRACE)) Q:TRACE=""  D
 . S STR(CTR)=$G(STR(CTR))  ; Initialize
 . I $L(STR(CTR))+$L(TRACE)>77 S CTR=CTR+1,STR(CTR)=TRACE Q
 . S STR(CTR)=STR(CTR)_$S(STR(CTR)]"":",",1:"")_TRACE  ; comma if needed
 Q 
 ;
WARNMSG(TYPE,STR) ; warning message when aged, unposted EFTs exist
 ; Input: TYPE - "M" - Medical, "P" - Pharmacy or "T" - Tricare
 ; STR - Array, subscripts are strings in "trace#, trace#," format
 N DIR,LN,X,Y
 S DIR(0)="EA"
 S DIR("A",1)="WARNING: Unposted "_$S(TYPE="P":"pharmacy",TYPE="M":"medical",1:"TRICARE")
 S DIR("A",1)=DIR("A",1)_" EFTs exist that are more than "_$S(TYPE="P":21,1:14)_" days old."
 S DIR("A",2)=" "
 S DIR("A",3)="Post the older payments first. The EFTs may be unmatched or matched."
 S DIR("A",4)="Trace number(s) associated with unposted EFTs:"
 S LN=4,X=0 F  S X=$O(STR(X)) Q:'X  S LN=LN+1,DIR("A",LN)=STR(X)
 S LN=LN+1,DIR("A",LN)=" "
 S DIR("A")="Press ENTER to continue: "
 W !
 D ^DIR
 Q
 ;
PREVMSG(TYPE,DAYS,STR) ; Display Error message when aged, unposted EFTs exist
 ;Input:
 ; TYPE - "M":Medical, "P":Pharmacy, "T":Tricare
 ; DAYS - days EFT can age before post prevention rules apply
 ; STR - Array, each subscrpt is string of trace numbers in "trace#, trace#," format     
 ;
 N DIR,LN,X,Y
 S DIR(0)="EA"
 S DIR("A",1)="ERROR: Unposted "_$S(TYPE="P":"Pharmacy",TYPE="M":"Medical",1:"TRICARE")
 S DIR("A",1)=DIR("A",1)_" EFTs exist that are more than "_DAYS(TYPE)_" days old. Scratchpad"
 S DIR("A",2)="creation is not allowed for newer payments. Post older payments first."
 S DIR("A",3)="The EFTs may be matched or unmatched."
 S DIR("A",4)=" "
 S DIR("A",5)="Trace number(s) associated with unposted EFTs:"
 S LN=5,X=0 F  S X=$O(STR(X)) Q:'X  S LN=LN+1,DIR("A",LN)=" "_STR(X)
 S LN=LN+1,DIR("A",LN)=" "
 S DIR("A")="Press ENTER to continue: "
 W !
 D ^DIR
 Q
 ;
EXCDENY ; PRCA*4.5*298
 ; access denied message for ERAs selected off ERA Worklist with exceptions  
 ; PRCA*4.5*304 - undeclared parameters (from WL^RCDPEWL7): RCERA and RCEXC 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCDWLIEN,X,Y
 S DIR(0)="YA"
 S DIR("A",1)="ACCESS DENIED:  Scratchpad creation is not allowed when third party"
 S DIR("A",2)="medical exceptions exist.  Fix Transmission Exceptions first and then Data"
 S DIR("A",3)="Exceptions with the EXE EDI Lockbox 3rd Party Exceptions option which is"
 S DIR("A",4)="located on the EDI Lockbox Main Menu."
 S DIR("A",5)=" "
 ;PRCA*4.5*304 - Allow user to fix exceptions
 S DIR("A")="Do you want to begin clearing Exceptions for this ERA (Y/N)?: "
 S DIR("B")="Y"
 W ! D ^DIR
 ;PRCA*4.5*304 - allow jump to work on Exceptions
 ; If 'yes' to work on exceptions?, set neeeded vars., default payer range is ALL (for now)
 I Y=1 D  S:$G(RCMBG)'="" VALMBG=RCMBG S:$G(RCDWLIEN)'="" RCERA=RCDWLIEN S RCEXC=1 K RCMBG
 . S RCMBG=$G(VALMBG),RCDWLIEN=RCERA D EN^RCDPEX1
 Q
 ;
EXCWARN(ERADA) ; prca*4.5*298 warning msg. if exception
 ; Input:   ERADA - IEN in file 344.4
 ; Output:  WARNING MESSAGE if exception exists on ERA
 ;              
 Q:$$PHARM(ERADA)  ; Ignore pharmacy ERA
 Q:$$XCEPT(ERADA)=""  ; no exception
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="WARNING: Fix Transmission Exceptions first and then Data Exceptions via"
 S DIR("A",2)="the EXE EDI Lockbox 3rd Party Exceptions option which is located on the"
 S DIR("A",3)="EDI Lockbox Main Menu."
 S DIR("A",4)=" "
 S DIR("A")="Press ENTER to continue: "
 W !
 D ^DIR
 Q
 ;
XCEPT(ERADA) ; prca*4.5*298, return ERA exception state
 ; Input: ERADA - IEN in file 344.4
 ; Returns: "x" or null, "x": Exception for a claim in the ERA
 N RES
 S RES=$S($D(^RCY(344.4,"AEXC",1,ERADA)):"x",$D(^RCY(344.4,"AEXC",2,ERADA)):"x",$D(^RCY(344.4,"AEXC",99,ERADA)):"ERADA",1:"")
 Q RES
 ;
PHARM(X1) ; prca*4.5*298, function, Pharmacy, or Medical ERA?
 ; X1 - IEN file 344.4
 ; Returns: 1: Pharmacy ERA, 0: Non-pharmacy ERA
 Q $S($D(^RCY(344.4,X1,1,"ECME")):1,1:0)
 ;
GETPHARM(PRCAIEN,RCARRY) ;prca*4.5*298 return pharmacy data to show on EEOB items in scratchpad
 ; Input: PRCAIEN - IEN file 430
 ; Output: RCARRY  - holds pharmacy data 
 ; IA 6033 - read access file 362.4
 ; ICR 1878 - EN^PSOORDER call
 N RC0,RCDFN,RXDATA,RXFILL,RXIEN
 K RCARRY
 Q:PRCAIEN=""
 S RCDFN=$P(^PRCA(430,PRCAIEN,0),U,7)
 S RC0=+$O(^IBA(362.4,"C",PRCAIEN,0)) Q:RC0=0
 S RXDATA=$G(^IBA(362.4,RC0,0))
 S RCARRY("DOS")=$$FMTE^XLFDT($P(RXDATA,U,3),"2Z")
 S RCARRY("FILL")=+$P(RXDATA,U,10)  ; Rx fill#
 S RXIEN=+$P(RXDATA,U,5)  ; Rx IEN in file 52
 D EN^PSOORDER(RCDFN,RXIEN)
 S RCARRY("RX")=$P(^TMP("PSOR",$J,RXIEN,0),U,5)
 I RCARRY("FILL")=0 D
 . S RCARRY("RELEASED STATUS")=$S($P(^TMP("PSOR",$J,RXIEN,0),U,13)]"":"Released",1:"Not Released")   ; determine release status from Rx on the first fill (no refills)
 I RCARRY("FILL")>0 D
 . S RCARRY("RELEASED STATUS")=$S($P($G(^TMP("PSOR",$J,RXIEN,"REF",RCARRY("FILL"),0)),U,8)]"":"Released",1:"Not Released")  ; ; determine release status from Rx refill # ;PRCA319 add $G()
 Q
 ;
CV ; Change View action for ERA Worklist
 D FULL^VALM1
 D PARAMS^RCDPEWL0("CV")
 D HDR^RCDPEWL7,INIT^RCDPEWL7
 S VALMBCK="R",VALMBG=1
 Q
 ;
NOEDIT ; no edit allowed, ERA designated for auto-posting
 N DIR
 S DIR(0)="EA",DIR("A",1)="This action is not available for Auto-Posted ERAs."
 S DIR("A")="Press ENTER to continue: "
 W ! D ^DIR W !
 Q
 ;
VR(ERADA) ; handle auto-posted ERAs, Look at Receipt protocol for standard Worklist
 ; Input: ERADA - IEN from file 344.49 (and 344.4)
 N RCDA,RCZ,RCZ0,EEOBREC
 D SEL^RCDPEWL(.RCDA)  ; Select EEOB off scratchpad
 S RCZ=+$O(RCDA(0)),RCZ=+$G(RCDA(RCZ))
 Q:'RCZ
 S RCZ0=$G(^RCY(344.49,ERADA,1,RCZ,0))
 S EEOBREC=$P($G(^RCY(344.4,ERADA,1,+$P(RCZ0,U,9),4)),U,3)
 I EEOBREC']"" D NOVIEW Q 
 D EN^VALM("RCDPE AUTO EOB RECEIPT PREVIEW")
 Q
 ;
NOVIEW ; selected EEOB cannot be viewed if no receipt number
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="THIS ACTION IS NOT AVAILABLE SINCE THE EEOB HAS NOT BEEN AUTO-POSTED."
 S DIR("A")="Press ENTER to continue: "
 W ! D ^DIR W !
 Q
 ;
INIT(ERADA,EEOBREC) ; List Template - RCDPE AUTO EOB RECEIPT PREVIEW entry point
 ; Display EEOBs that have been posted (receipt exists)
 ; Input:
 ; ERADA - IEN file 344.49 (and 344.4)
 ; EEOBREC - Selected EEOBs receipt
 ; Output:  ^TMP("RCDPE_AP_EOB_PREVIEW",$J)
 N RCPT,RCZ,Z,Z0,Z1,Z2,SEQ
 K ^TMP("RCDPE_AP_EOB_PREVIEW",$J)
 S VALMCNT=0,VALMBG=1
 S SEQ(344.491)=0 F  S SEQ(344.491)=$O(^RCY(344.49,ERADA,1,SEQ(344.491))) Q:'SEQ(344.491)  D
 . S SEQ(344.491,0)=$G(^RCY(344.49,ERADA,1,SEQ(344.491),0))
 . I $P(SEQ(344.491,0),U)\1=+SEQ(344.491,0) S SEQ("claim#")=$P(SEQ(344.491,0),U,2)
 . S RCPT=+$P($G(^RCY(344.4,ERADA,1,+$P(SEQ(344.491,0),U,9),4)),U,3),RCPT(RCPT)=""  ; receipt array
 . I $P($P(SEQ(344.491,0),U),".",2),$D(RCPT(EEOBREC)) D   ; if the EEOB has same receipt# as selected EEOB it can be on the preview screen
 ..  S:$P(SEQ(344.491,0),U,2)="" $P(SEQ(344.491,0),U,2)=SEQ("claim#")
 ..  ;RCZ=0:zero payments, -1:negative bal., 1:lines for rcpt., 2:other lines
 ..  S RCZ=$S(+$P(SEQ(344.491,0),U,6)=0:0,+$P(SEQ(344.491,0),U,6)<0:-1,$P(SEQ(344.491,0),U,7):1,1:2)
 ..  S RCZ(RCZ,SEQ(344.491))=SEQ(344.491,0)
 ..  K RCPT
 ..  S SEQ(344.4911)=0  F  S SEQ(344.4911)=$O(^RCY(344.49,ERADA,1,SEQ(344.491),1,SEQ(344.4911))) Q:'SEQ(344.4911)  D
 ...   S SEQ(344.4911,0)=$G(^RCY(344.49,ERADA,1,SEQ(344.491),1,SEQ(344.4911),0))
 ...   I $P(SEQ(344.4911,0),U,5)=1 D  ;(#.05) BACKGROUND ACTION [5S] - '1' FOR DECREASE ADJUSTMENT; 
 ....    S RCZ(RCZ,SEQ(344.491),"ADJ",SEQ(344.4911))="Dec adj $"_$J(0-$P(SEQ(344.4911,0),U,3),"",2)_" pending - "
 ....    S RCZ(RCZ,SEQ(344.491),"ADJ",SEQ(344.4911),1)=$J("",4)_$P(SEQ(344.4911,0),U,9)
 ;
 F RCZ=1,2,0,-1 D:$D(RCZ(RCZ))
 . I RCZ=1 D SET("PAYMENTS (LINES FOR RECEIPT):")
 . I RCZ=0,VALMCNT>0 D SET(" "),SET("ZERO DOLLAR PAYMENTS:")
 . I RCZ=-1,VALMCNT>0 D SET(" "),SET("LINES WITH NEGATIVE BALANCES STILL NEEDING TO BE DISTRIBUTED:")
 . S Z=0 F  S Z=$O(RCZ(RCZ,Z)) Q:'Z  D
 ..  S Z0=RCZ(RCZ,Z),X=""
 ..  S X=$$SETFLD^VALM1($P(Z0,U),X,"LINE #")
 ..  S X=$$SETFLD^VALM1($S($P(Z0,U,7):$$BN1^PRCAFN($P(Z0,U,7)),1:$S(RCZ=0:"",1:"[SUSPENSE]")_$S($P(Z0,U,2)["**ADJ"&'$P($P(Z0,U,2),"ADJ",2):"TOTALS MISMATCH ADJ",1:$P(Z0,U,2))),X,"ACCOUNT")
 ..  S X=$$SETFLD^VALM1($J(+$P(Z0,U,6),"",2),X,"AMOUNT")
 ..  D SET(X)
 ..  S Z1=0 F  S Z1=$O(RCZ(RCZ,Z,"ADJ",Z1)) Q:'Z1  D
 ...   D SET($J("",12)_$G(RCZ(RCZ,Z,"ADJ",Z1)))
 ...   S Z2=0 F  S Z2=$O(RCZ(RCZ,Z,"ADJ",Z1,Z2)) Q:'Z2  D SET($J("",12)_$G(RCZ(RCZ,Z,"ADJ",Z1,Z2)))
 Q
 ;
SET(X) ;
 S VALMCNT=VALMCNT+1,^TMP("RCDPE_AP_EOB_PREVIEW",$J,VALMCNT,0)=X
 Q
 ;
HDR ;
 D HDR^RCDPEWL Q
 ;
FNL ;
 K ^TMP("RCDPE_AP_EOB_PREVIEW",$J) Q
 ;
