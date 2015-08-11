RCDPEWLP ;ALBANY/KML - EDI LOCKBOX ERA and EEOB WORKLIST procedures ;Oct 15, 2014@12:37:32
 ;;4.5;Accounts Receivable;**298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; prca*4.5*298 - procedures built to handle outstanding EFTs; and ERAs with exceptions;
 ;
AGEDEFTS(ERADA,TYPE) ; search medical or pharmacy aged EFTs that have not been posted 
 ;   ENTRY point for the Select ERA action on the ERA Worklist screen
 ;      input - ERADA = Internal Entry Number in file 344.4
 ;              TYPE = represents if pharmacy or medical ERA
 ;                      "M" (medical ERA-EFT); "P" (phamacy ERA-EFT);
 ;       OUTPUT - UNPOST
 ;                        = 1P - error condition for aged, unposted pharmacy EFTs
 ;                        = 2P - warning condition for aged,unposted medical EFTs
 ;                        = 3P  - Override exists for aged, unposted pharmacy EFTs
 ;                        = 1M - error condition for aged, unposted medical EFTs
 ;                        = 2M - warning condition for aged, unposted medical EFTs
 ;                        = 3M  - Override exists for aged, unposted medical EFTs
 ;                        = 0  - there exist no error or warning conditions
 ;  possible values for UNPOST = "1P" or "2P" or "3P" or "1M" or "2M" or "3M" or "1P^1M" or "1P^2M" or"
 ;                               "1P^3M" or "2P^1M" or "2P^2M" or "2P^3M" or "3P^1M" or "3P^2M" or "3P^3M"
 ;
 ; 1. If there are unposted payments (EFTs) associated with third party medical claims more than 14 calendar days old, 
 ;       the system shall display a WARNING message for action Select ERA on the ERA WORKLIST, and allow to enter the worklist
 ; 2. If there are unposted payments (EFTs) associated with pharmacy claims more than 21 calendar days old, 
 ;       the system shall display a WARNING message for action Select ERA on the ERA WORKLIST, and allow to enter the worklist
 ; 3. If there are unposted payments (EFTs) associated with third party medical or pharmacy claims, 
 ;        aged more than the number of days specified in site parameters,
 ;             the system shall display an error message for action Select ERA on the EEOB WORKLIST [RCDPE EDI LOCKBOX WORKLIST]
 ;  additional conditions for item 3 below:   
 ; 3a.  If the user has selected a medical ERA that is 14 days or older, allow the user to create the scratchpad.
 ; 3b.  If the user has selected a pharmacy ERA that is 21 days or older, allow the user to create the scratchpad.
 ; 3c.  If an override exists, allow the user to create the scratchpad.
 ; 3d.  If the user has selected a medical ERA that has been received within 14 days, and there are aged,unposted EFTs, and there is no override, prevent user from entering scratchpad
 ; 3e.  If the user has selected a pharmacy ERA that has been received within 21 days,and there are aged,unposted EFTs, and there is no override, prevent user from entering scratchpad
 ;Do not consider EFTs that are older than two months prior to national release.
 ;  note: EFTs that designated to be auto-posted to a receipt are included in the search for aged, unposted EFTs
 N X,EFTDA,UNPOST,EFT0,SELERADT,STARTDT,DATE,RC3444,RC34431
 S UNPOST=0
 S RC3444=^RCY(344.4,ERADA,0)
 I '$P(RC3444,U,5) G AEFTSQ   ; ignore selected ERAs that have ZERO payment 
 S EFTDA=+$O(^RCY(344.31,"AERA",ERADA,0))
 S:EFTDA RC34431=^RCY(344.31,EFTDA,0)
 I 'EFTDA,$P(RC3444,U,9)=2 G AEFTSQ   ; ignore selected ERAs that are MATCHED TO PAPER CHECK
 I 'EFTDA,$P(RC3444,U,15)="CHK" G AEFTSQ  ;ignore selected ERAs that are UNMATCHED and have an EXPECTED PAYMENT CODE of "CHK"
 I 'EFTDA S SELERADT=$P($P(RC3444,U,7),".")  ; FILE DATE/TIME (344.4, .07) of the selected ERA when there isn't an associated EFT (unmatched ERA)
 E  S SELERADT=$P(RC34431,U,13)  ; DATE RECEIVED (344.31,.13) of the EFT associated with the selected ERA 
 I TYPE="P" D  G AEFTSQ
 . I $$FMDIFF^XLFDT(DT,SELERADT)>21 S UNPOST=0 Q   ;the selected ERA is older than 21 days, quit determination and allow user to enter scratchpad with selected ERA
 . S UNPOST=$$GETEFTS(TYPE)   ; selected ERA was received less than 21 days ago; gather any unposted, aged EFTs
 I TYPE="M" D
 . I $$FMDIFF^XLFDT(DT,SELERADT)>14 S UNPOST=0 Q   ;the selected ERA is older than 14 days, quit determination and allow user to enter scratchpad with selected ERA
 . S UNPOST=$$GETEFTS(TYPE)  ; selected ERA was received less than 14 days ago; gather any unposted, aged EFTs
AEFTSQ ; 
 Q UNPOST
 ;
GETEFTS(TYPE,OPTION) ; ENTRY point for Unposted EFT Override option; 
 ;  set up search criteria for unposted EFTs; if aged, unposted EFTs exist then generate warning/prevention messages
 ;           input - 
 ;                   TYPE = "M" (medical ERA-EFT); "P" (phamacy ERA-EFT); "B" (both pharmacy and medical)
 ;                   OPTION = if = null or undefined then Select ERA action on the ERA Worklist called this function
 ;                            if = 1 then Override option called this function
 ;       OUTPUT - OUTCOME
 ;                        = 1P - error condition for aged, unposted pharmacy EFTs
 ;                        = 2P - warning condition for aged,unposted medical EFTs
 ;                        = 3P  - Override exists for aged, unposted pharmacy EFTs
 ;                        = 1M - error condition for aged, unposted medical EFTs
 ;                        = 2M - warning condition for aged, unposted medical EFTs
 ;                        = 3M  - Override exists for aged, unposted medical EFTs
 ;                        = 0  - there exist no error or warning conditions
 ;  possible values for OUTCOME = "1P" or "2P" or "3P" or "1M" or "2M" or "3M" or "1P^1M" or "1P^2M" or"
 ;                               "1P^3M" or "2P^1M" or "2P^2M" or "2P^3M" or "3P^1M" or "3P^2M" or "3P^3M"
 ;
 N OVERRIDE,DAYSLIMIT,OUTCOME,TRARRY,ARRAY,STR,X,DTARRY
 S OPTION=$G(OPTION)
 I TYPE="B" S DAYSLIMT("M")=$$GET1^DIQ(344.61,1,.06),DAYSLIMT("P")=$$GET1^DIQ(344.61,1,.07)  ; both medical and pharmacy EFTs need to be evaluated
 E  S DAYSLIMT(TYPE)=$$GET1^DIQ(344.61,1,$S(TYPE="M":.06,1:.07))   ; number of days an EFT can age before post prevention rules apply
 S STARTDT=$$CUTOFF
 D EFTDET(STARTDT,TYPE,.DAYSLIMT,.TRARRY)
 ;  aged unposted EFTs exist;    generate prevention message and if this was called within Worklist (and not Override option) then generate msg with list of TRACE #s
 F X="P","M" I $D(TRARRY("ERROR",X)) D
 . D CHECK^RCDPEUPO(X,.OVERRIDE)  ; determine if Override exists
 . I OVERRIDE S OUTCOME=$G(OUTCOME)_3_X_U
 . E  S OUTCOME=$G(OUTCOME)_1_X_U
 . K TRARRY("WARNING",X)  ; Error message supersede warning message.  No need to display warning msg if error condition exists
 . Q:OPTION  Q:OVERRIDE
 . M ARRAY=TRARRY("ERROR",X)
 . D FTRACE(.ARRAY,.STR),PREVMSG(X,.DAYSLIMT,.STR)
 . K ARRAY
 F X="P","M" I $D(TRARRY("WARNING",X)) D
 . S OUTCOME=$G(OUTCOME)_2_X_U
 . Q:OPTION  ; function was called by the OVERRIDE option; don't need to display list of trace numbers
 . M ARRAY=TRARRY("WARNING",X)
 . D FTRACE(.ARRAY,.STR),WARNMSG(X,.STR)
 . K ARRAY ; aged unposted EFTs > 21 days exist; generate warning message
 S:'$D(OUTCOME) OUTCOME=0  ; error or warning conditions do not exist
GETSQ ;
 Q OUTCOME
 ;
CUTOFF() ;  RETURN EFT cut-off date
 ; EFT cut-off date represents 2 months prior to install date of patch 298 (ignore EFTS that are aged older than the 2 month prior date)
 N RCX,DATE
 S RCX=+$P($G(^RCY(344.61,1,0)),U,9)
 S:RCX=0 RCX=DT
 S DATE=$$FMADD^XLFDT(RCX,-61,0,0)
 Q DATE
 ;
EFTDET(RECVDT,TYPE,DAYSLIMT,TRARRY) ;  gather EFT data
 ;         only collect EFTs that meet the requirements of aged and unposted
 ;
 ;        input - RECVDT   = date to start $ORDER through the DATE RECEIVED cross-reference of 344.3
 ;                TYPE     = "M" (medical ERA-EFT); "P" (phamacy ERA-EFT); "B" (both pharmacy and medical)
 ;                DAYSLIMT =  number of days an EFT can age before post prevention rules apply
 ;                TRARRY   = passed by reference, array to hold trace numbers that represent the aged, unposted EFTs
 ; 
 ;        output - TRARRY  = array of trace numbers that need to be reported as aged and unposted  
 ;  
 N AGED,EFT0,EFTDA,ERAREC,MSTATUS,TRACE
 S EFTDA=""
 F  S RECVDT=$O(^RCY(344.31,"ADR",RECVDT)) Q:'RECVDT  F  S EFTDA=$O(^RCY(344.31,"ADR",RECVDT,EFTDA)) Q:'EFTDA  D
 . S EFT0=$G(^RCY(344.31,EFTDA,0)) Q:EFT0=""
 . Q:+$P(EFT0,U,7)=0  ;ignore zero payment amts
 . I $P($G(^RCY(344.31,EFTDA,3)),U,2)]"" Q  ; Ignore duplicate EFTs which have been removed 
 . S ERAREC=+$P(EFT0,U,10)  ; ERA RECORD (344.31, .1)  pointer to ERA record
 . I ERAREC,$P($G(^RCY(344.4,ERAREC,0)),U,14)=1 Q  ; DETAIL POST STATUS (344.4, .14);  ignore posted ERA-EFTs 
 . I 'ERAREC,$P($G(^RCY(344.31,EFTDA,0)),U,8) Q:$$PROC(EFTDA)  ;Exclude EFT matched to Paper EOB if receipt is processed
 . S MSTATUS=+$P(EFT0,U,8)  ;  MATCH STATUS (344.31,, .08)
 . S AGED=$$FMDIFF^XLFDT(DT,RECVDT)  ; get aged number of days of the EFT
 . S TRACE=$P(EFT0,U,4)  ; TRACE # (344.31, .04)
 . I (TYPE="B")!(TYPE="P"),$$PHARM(ERAREC) D
 . . I AGED>DAYSLIMT("P") S TRARRY("ERROR","P",TRACE)="ERA = "_ERAREC_U_MSTATUS Q   ; aged unposted EFT that generates the error message and will prevent user from entering the scratchpad with the selected ERA
 . . I '$D(TRARRY("ERROR")),AGED>21 S TRARRY("WARNING","P",TRACE)="ERA = "_ERAREC_U_MSTATUS   ;aged unposted PHARMACY EFT that will generate a warning message when entering the scratchpad with the selected ERA
 . I (TYPE="B")!(TYPE="M"),'$$PHARM(ERAREC) D
 . . I AGED>DAYSLIMT("M") S TRARRY("ERROR","M",TRACE)="ERA = "_ERAREC_U_MSTATUS Q  ; aged unposted EFT that generates the error message and will prevent user from entering the scratchpad with the selected ERA
 . . I '$D(TRARRY("ERROR")),AGED>14 S TRARRY("WARNING","M",TRACE)="ERA = "_ERAREC_U_MSTATUS  ;aged unposted MEDICAL EFT that will generate a warning message when entering the scratchpad with the selected ERA
 Q
 ;
PROC(EFTDA) ; Check if TR Receipt for an EFT linked to Paper EOB is processed 
 ; Input - EFT IEN
 ; Output - Boolean (Returns 1 if TR receipt exists and is OPEN, otherwise returns 0)
 ;
 ;Find TR receipt and check if it does not have a status of CLOSED
 N IEN344,RET S IEN344=$O(^RCY(344,"AEFT",EFTDA,0)) I IEN344 S:$P($G(^RCY(344,IEN344,0)),U,14)'=1 RET=1
 Q +$G(RET)
 ;
FTRACE(TRARRY,STR) ; input array needs to be formatted as a string of trace#s each separated by commas to be displayed in the warning or error message
 ;          input -  TRARRY = passed by reference, array of trace numbers that represent the aged, unposted EFTs
 ;                   STR = passed by reference, empty array that will be populated with trace numbers
 ;                  
 ;          output - STR   = reconstructed array of trace numbers    
 ;
 ; fixed code follows
 N CTR,LEN,TRACE,X
 K STR  ; array returned
 S CTR=1,TRACE=""
 F  S TRACE=$O(TRARRY(TRACE)) Q:TRACE=""  D
 . S STR(CTR)=$G(STR(CTR))  ; initialize
 . I $L(STR(CTR))+$L(TRACE)>77 S CTR=CTR+1,STR(CTR)=TRACE Q
 . S STR(CTR)=STR(CTR)_$S(STR(CTR)]"":",",1:"")_TRACE  ; add comma if needed
 Q 
 ;
WARNMSG(TYPE,STR) ;  Display warning message when aged, unposted EFTs exist
 ;
 ;          input - TYPE   = "P" (pharmacy); "M" (medical)
 ;                  STR    = populated array where each subscrpt contains a string of trace numbers in "trace#, trace#," format
 ;                           passed by reference   
 ;               
 N DIR,LN,X,Y
 S LN=5,X=0
 S DIR(0)="EA"
 S DIR("A",1)="WARNING: Unposted "_$S(TYPE="P":"pharmacy ",1:"medical ")_"EFTs exist that are more than "_$S(TYPE="P":21,1:14)_" days old."
 S DIR("A",2)=" "  ; blank line
 S DIR("A",3)="Post the older payments first. The EFTs may be unmatched or matched."
 S DIR("A",4)="Trace number(s) associated with unposted EFTs:"
 F  S X=$O(STR(X)) Q:'X  S DIR("A",LN)=STR(X),LN=LN+1
 S DIR("A",LN)=" "  ; blank line
 S DIR("A")="Press ENTER to continue: " W ! D ^DIR
 Q
 ;
PREVMSG(TYPE,DAYS,STR) ;  Display Error message when aged, unposted EFTs exist
 ;
 ;          input - TYPE   = "P" (pharmacy); "M" (medical)
 ;                  DAYS   =  number of days an EFT can age before post prevention rules apply
 ;                  STR    =  passed by reference, name of array that will return reformatted array of trace numbers
 ;                  
 ;          output - STR   = populated array where each subscrpt contains a string of trace numbers in "trace#, trace#," format     
 ;
 N DIR,LN,X,Y
 S LN=6,X=0
 S DIR(0)="EA"
 S DIR("A",1)="ERROR: Unposted "_$S(TYPE="P":"Pharmacy ",1:"Medical ")_"EFTs exist that are more than "_$S(TYPE="P":DAYS("P"),1:DAYS("M"))_" days old. Scratchpad"
 S DIR("A",2)="creation is not allowed for newer payments. Post older payments first."
 S DIR("A",3)="The EFTs may be matched or unmatched."
 S DIR("A",4)=" "  ; blank line
 S DIR("A",5)="Trace number(s) associated with unposted EFTs:"
 F  S X=$O(STR(X)) Q:'X  S DIR("A",LN)=" "_STR(X),LN=LN+1
 S DIR("A",LN)=" "  ; blank line
 S DIR("A")="Press ENTER to continue: " W ! D ^DIR
 Q
 ;
EXCDENY ; praca*4.5*298 display access denied message for those ERAs that are selected off the ERA Worklist and have exceptions  
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="ACCESS DENIED:  Scratchpad creation is not allowed when third party"
 S DIR("A",2)="medical exceptions exist.  Fix Transmission Exceptions first and then Data"
 S DIR("A",3)="Exceptions with the EXE EDI Lockbox 3rd Party Exceptions option which is"
 S DIR("A",4)="located on the EDI Lockbox Main Menu."
 S DIR("A",5)=""
 S DIR("A")="Press ENTER to continue: " W ! D ^DIR
 Q
 ;
EXCWARN(ERADA) ; prca*4.5*298  generate warning when exception exists
 ; 
 ;      input - ERADA = Internal Entry Number in file 344.4
 ;      output - WARNING MESSAGE if exception exists on the ERA
 ;              
 ;
 Q:$$PHARM(ERADA)  ; ignore pharmacy ERAs
 Q:$$XCEPT(ERADA)=""  ; exception does not exist
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="WARNING: Fix Transmission Exceptions first and then Data Exceptions via"
 S DIR("A",2)="the EXE EDI Lockbox 3rd Party Exceptions option which is located on the"
 S DIR("A",3)="EDI Lockbox Main Menu."
 S DIR("A",4)=" "
 S DIR("A")="Press ENTER to continue: " W ! D ^DIR
 Q
 ;
XCEPT(ERADA) ; prca*4.5*298  return ERA exception state
 ; 
 ;      input - ERADA = Internal Entry Number in file 344.4
 ;      output - "x" or ""
 ;                "x" = exception exists for at least one of the claims in the ERA
 ;
 N RES
 S RES=$S($D(^RCY(344.4,"AEXC",1,ERADA)):"x",$D(^RCY(344.4,"AEXC",2,ERADA)):"x",$D(^RCY(344.4,"AEXC",99,ERADA)):"ERADA",1:"")
 Q RES
 ;
PHARM(X1) ; prca*4.5*298  determine if pharmacy ERA
 ;
 ;      input - X1 = Internal Entry Number in file 344.4
 ;      output - 1 or 0
 ;      1 = pharmacy ERA
 ;      0 = non-pharmacy ERA
 ;     
 Q $S($D(^RCY(344.4,X1,1,"ECME")):1,1:0)
 ;
GETPHARM(PRCAIEN,RCARRY) ;prca*4.5*298  return pharmacy data to show on EEOB items in scratchpad
 ; 
 ;   input -    PRCAIEN = ien to record in 430
 ;              RCARRY = Array name that will be used to store and return pharmacy data elements
 ;   output -   RCARRY = holds pharmacy data 
 ; IA 6033 (controlled subscription) - read access of file 362.4.  status is pending
 ; ICR 1878 (supported) - usage of EN^PSOORDER
 ;
 N RC0,RXDATA,RXIEN,RCDFN,RXFILL
 K RCARRY
 Q:PRCAIEN=""
 S RCDFN=$P(^PRCA(430,PRCAIEN,0),U,7)
 S RC0=+$O(^IBA(362.4,"C",PRCAIEN,0))
 Q:RC0=0
 S RXDATA=$G(^IBA(362.4,RC0,0))
 S RCARRY("DOS")=$$FMTE^XLFDT($P(RXDATA,U,3),"2Z")
 S RCARRY("FILL")=+$P(RXDATA,U,10)          ; rx fill#
 S RXIEN=+$P(RXDATA,U,5)            ; RX ien ptr file 52
 D EN^PSOORDER(RCDFN,RXIEN)
 S RCARRY("RX")=$P(^TMP("PSOR",$J,RXIEN,0),U,5)
 I RCARRY("FILL")=0 S RCARRY("RELEASED STATUS")=$S($P(^TMP("PSOR",$J,RXIEN,0),U,13)]"":"Released",1:"Not Released")   ; determine release status from Rx on the first fill (no refills)
 I RCARRY("FILL")>0 S RCARRY("RELEASED STATUS")=$S($P(^TMP("PSOR",$J,RXIEN,"REF",RCARRY("FILL"),0),U,8)]"":"Released",1:"Not Released")  ; ; determine release status from Rx refill #
 Q
 ;
CV ; Change View action for ERA Worklist
 D FULL^VALM1 D PARAMS^RCDPEWL0("CV")
 D HDR^RCDPEWL7,INIT^RCDPEWL7 S VALMBCK="R",VALMBG=1
 Q
 ;
NOEDIT ; Display no edit allowed selected ERA is designated for auto-posting
 N DIR
 S DIR(0)="EA",DIR("A",1)="This action is not available for Auto-Posted ERAs."
 S DIR("A")="Press ENTER to continue: "
 W ! D ^DIR K DIR W !
 Q
 ;
VR(ERADA) ;   handling of auto-posted ERAs ; entry point for the Look at Receipt protocol for standard Worklist;
 ;  
 ;    input - ERADA = ien from file 344.49 (and 344.4)
 ;
 N RCDA,RCZ,RCZ0,EEOBREC
 D SEL^RCDPEWL(.RCDA)  ; select an EEOB off the scratchpad
 S RCZ=+$O(RCDA(0)),RCZ=+$G(RCDA(RCZ)) Q:'RCZ
 S RCZ0=$G(^RCY(344.49,ERADA,1,RCZ,0))
 S EEOBREC=$P($G(^RCY(344.4,ERADA,1,+$P(RCZ0,U,9),4)),U,3)
 I EEOBREC']"" D NOVIEW Q 
 D EN^VALM("RCDPE AUTO EOB RECEIPT PREVIEW")
 Q
 ;
NOVIEW ; selected EEOB cannot be viewed if no receipt number
 N DIR
 S DIR(0)="EA",DIR("A",1)="THIS ACTION IS NOT AVAILABLE SINCE THE EEOB HAS NOT BEEN AUTO-POSTED."
 S DIR("A")="Press ENTER to continue: "
 W ! D ^DIR K DIR W !
 Q
 ;
INIT(ERADA,EEOBREC) ;  List Template - RCDPE AUTO EOB RECEIPT PREVIEW entry point
 ;  display EEOBs that have been posted (receipt exists)
 ;
 ;            input - ERADA = ien from file 344.49 (and 344.4)
 ;                    EEOBREC = selected EEOBs receipt
 ;            output - ^TMP("RCDPE_AP_EOB_PREVIEW",$J)
 N X,Z,Z1,Z10,Z0,Z2,RCZ
 N RCPT
 K ^TMP("RCDPE_AP_EOB_PREVIEW",$J)
 S VALMCNT=0,VALMBG=1
 S Z=0 F  S Z=$O(^RCY(344.49,ERADA,1,Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 . I $P(Z0,U)\1=+Z0 S Z2=$P(Z0,U,2)
 . S RCPT=+$P($G(^RCY(344.4,ERADA,1,+$P(Z0,U,9),4)),U,3),RCPT(RCPT)=""  ; receipt array
 . I $P($P(Z0,U),".",2),$D(RCPT(EEOBREC)) D   ; if the EEOB has same receipt# has the selected EEOB then it can be listed on the preview screen
 .. S:$P(Z0,U,2)="" $P(Z0,U,2)=Z2
 .. S RCZ=$S(+$P(Z0,U,6)=0:0,+$P(Z0,U,6)<0:-1,$P(Z0,U,7):1,1:2)
 .. S RCZ(RCZ,Z)=Z0
 .. K RCPT
 .. S Z1=0 F  S Z1=$O(^RCY(344.49,ERADA,1,Z,1,Z1)) Q:'Z1  S Z10=$G(^(Z1,0)) D
 ... I $P(Z10,U,5)=1 S RCZ(RCZ,Z,"ADJ",Z1)="Dec adj $"_$J(0-$P(Z10,U,3),"",2)_" pending - ",RCZ(RCZ,Z,"ADJ",Z1,1)=$J("",4)_$P(Z10,U,9)
 F RCZ=1,2,0,-1 D
 . Q:'$D(RCZ(RCZ))
 . I RCZ=1 D SET("PAYMENTS (LINES FOR RECEIPT):")
 . I RCZ=0,VALMCNT>0 D SET(" ") D SET("ZERO DOLLAR PAYMENTS:")
 . I RCZ=-1,VALMCNT>0 D SET(" ") D SET("LINES WITH NEGATIVE BALANCES STILL NEEDING TO BE DISTRIBUTED:")
 . S Z=0 F  S Z=$O(RCZ(RCZ,Z)) Q:'Z  S Z0=RCZ(RCZ,Z) D
 .. S X=""
 .. S X=$$SETFLD^VALM1($P(Z0,U),X,"LINE #")
 .. S X=$$SETFLD^VALM1($S($P(Z0,U,7):$$BN1^PRCAFN($P(Z0,U,7)),1:$S(RCZ=0:"",1:"[SUSPENSE]")_$S($P(Z0,U,2)["**ADJ"&'$P($P(Z0,U,2),"ADJ",2):"TOTALS MISMATCH ADJ",1:$P(Z0,U,2))),X,"ACCOUNT")
 .. S X=$$SETFLD^VALM1($J(+$P(Z0,U,6),"",2),X,"AMOUNT")
 .. D SET(X)
 .. S Z1=0 F  S Z1=$O(RCZ(RCZ,Z,"ADJ",Z1)) Q:'Z1  D SET($J("",12)_$G(RCZ(RCZ,Z,"ADJ",Z1))) S Z2=0 F  S Z2=$O(RCZ(RCZ,Z,"ADJ",Z1,Z2)) Q:'Z2  D SET($J("",12)_$G(RCZ(RCZ,Z,"ADJ",Z1,Z2)))
 Q
 ;
SET(X) ;
 S VALMCNT=VALMCNT+1
 S ^TMP("RCDPE_AP_EOB_PREVIEW",$J,VALMCNT,0)=X
 Q
 ;
HDR ;
 D HDR^RCDPEWL
 Q
 ;
FNL ;
 K ^TMP("RCDPE_AP_EOB_PREVIEW",$J)
 Q
 ;RCDPEWLP
