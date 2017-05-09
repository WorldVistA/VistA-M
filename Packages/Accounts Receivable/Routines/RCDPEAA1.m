RCDPEAA1 ;ALB/KML - AUTO POST AWAITING RESOLUTION (APAR) - LIST OF UNPOSTED EEOBS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,304,317**;Mar 20, 1995;Build 8
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; Main entry point
 N RCQUIT,RCPROG
 S RCQUIT=0
 ; Calling Change View API in Menu Option Mode
 D PARAMS("MO") I RCQUIT G ENQ
 D EN^VALM("RCDPE APAR EEOB LIST")
 ;
ENQ Q
 ;
INIT ; Entry point for List template to build the display of EEOBs on APAR
 ;
 ; Parameters for selecting EEOBs to be included in the list are
 ; contained in the global ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,parameter name)
 ;
 N FDTTM,RCDA
 S RCAPAR=1
 D FULL^VALM1,CLEAN^VALM10
 K ^TMP($J,"RCDPE_APAR_EEOB_LIST")
 K ^TMP("RCDPE-APAR_EEOB_WL",$J),^TMP("RCDPE-APAR_EEOB_WLDX",$J)
 ; get ERAs that are in a 'partial' auto-post status
 S RCDA=0 F  S RCDA=$O(^RCY(344.4,"E",1,RCDA)) Q:'RCDA  D
 . I $$FILTER(RCDA)  S RC0=$G(^RCY(344.4,RCDA,0)) S ^TMP($J,"RCDPE_APAR_EEOB_LIST",$$UP^RCDPEARL(+$P(RC0,U,6)),RCDA)=""
 ; Output the list
 I $D(^TMP($J,"RCDPE_APAR_EEOB_LIST")) D BLD
 ; If no EEOBs found display the message below in the list area
 I '$O(^TMP("RCDPE-APAR_EEOB_WL",$J,0)) D
 . S ^TMP("RCDPE-APAR_EEOB_WL",$J,1,0)="There are no EEOBs matching your selection criteria" S VALMCNT=1
 Q
 ;
 ;
BLD ; Build EEOB list to be displayed on APAR screen
 N PN,RCDA,RCDA1,RCSEQ,RCT,WL490,WL4910,ERA40,ERA44,ERA410,ERA414,ERA415,RCARRY,TOTPOSTD,BALANCE
 S (RCT,TOTPOSTD,BALANCE,VALMCNT,RCSEQ)=0,PN="",RCPROG="RCDPEAA1"
 F  S PN=$O(^TMP($J,"RCDPE_APAR_EEOB_LIST",PN),-1) Q:PN=""  S RCDA=0 F  S RCDA=$O(^TMP($J,"RCDPE_APAR_EEOB_LIST",PN,RCDA)) Q:'RCDA  D 
 . ;retrieve unposted EEOB data
 . F  S RCSEQ=$O(^RCY(344.49,RCDA,1,"B",RCSEQ)) Q:'RCSEQ  I RCSEQ#1=0 S RCDA1=+$O(^RCY(344.49,RCDA,1,"B",RCSEQ,0)) I RCDA1 D
 . . S WL490=$G(^RCY(344.49,RCDA,0))  ; data from node 0 of 344.49
 . . S WL4910=$G(^RCY(344.49,RCDA,1,RCDA1,0))  ;data from 0 node of 344.491
 . . I +$P(WL4910,U,3)=0 Q  ; ignore zero value lines
 . . S ERA40=$G(^RCY(344.4,RCDA,0))  ; summary data of ERA
 . . S ERA44=$G(^RCY(344.4,RCDA,4))  ; ERA auto-post date and status
 . . S ERA410=$G(^RCY(344.4,RCDA,1,+$P(WL4910,U,9),0)) ; EEOB level data
 . . S ERA414=$G(^RCY(344.4,RCDA,1,+$P(WL4910,U,9),4))  ; EEOB level data (e.g., receipt# and ECME)
 . . S ERA415=$G(^RCY(344.4,RCDA,1,+$P(WL4910,U,9),5))  ; EEOB level  - auto-post related data
 . . S TOTPOSTD=$S($P(ERA414,U,3)]"":+$P(WL4910,U,3)+TOTPOSTD,1:TOTPOSTD) ; if EEOB line item has a receipt,then add 
 . . ;                                                                     AMOUNT TO POST ON RECEIPT (344.491,.03) to total amount posted (TOTPOSTD)
 . . S BALANCE=$S($P(ERA414,U,3)']"":$P(WL490,U,3)-TOTPOSTD,1:BALANCE)  ; if EEOB line item does not have a receipt, then calculate the unposted balance
 . . ;                                                              using the following calculation: TOTAL PAYMENT RECEIVED (344.49, .03) - total amount posted (TOTPOSTD)
 . . I $P(ERA414,U,3)']"",'$P(ERA415,U,2) D  ; display only EEOB items that do not have a receipt and are not marked for autopost
 . . . S RCT=RCT+1
 . . . S RCARRY(RCT)=$P(ERA40,U)_U_+$P(WL4910,U,9)_U_$P(WL4910,U,2)_U_RCDA1 ;RCARRY=ERA#^SEQ^CLAIM#^ien of 344.491                                                                          
 . I $D(RCARRY) D ERALINES(RCDA,.RCARRY,BALANCE,TOTPOSTD,$P(ERA44,U),$P(ERA40,U,3),$P(ERA40,U,6)) K RCARRY
 . S (BALANCE,TOTPOSTD)=0
 Q
 ;
ERALINES(RCDA,RCARRY,BALANCE,TOTPOSTD,POSTDT,PAYID,PAYNM) ;  set EEOB line into List Manager arrays
 ;
 ;     input - RCDA     = top file ien for files 344.4 and 344.49
 ;             RCARRY   = array that holds the EEOB data to be displayed
 ;             BALANCE  = Amount that is left to be posted                                                  
 ;             TOTPOSTD = Total amount posted thus far against the ERA
 ;             POSTDT   = latest auto-posted date
 ;             PAYID    = payer id
 ;             PAYNM    = payer name
 N RCT,X
 S RCT=0
 F  S RCT=$O(RCARRY(RCT)) Q:'RCT  D 
 . ; line 1 of displayed EEOB item: selectable line #, ERA reference.EEOB seq#, Claim #
 . S X=$J(RCT,3)_"   "_$J($P(RCARRY(RCT),U)_"."_$P(RCARRY(RCT),U,2),14)_"   "_$J($P(RCARRY(RCT),U,3),10)
 . ; cont. line 1 of displayed EEOB item: X_Total posted amt, posted date, Unposted balance
 . S X=X_"   "_$J(TOTPOSTD,12,2)_"   "_$J($$FMTE^XLFDT(POSTDT,"2D"),8)_"   "_$J(BALANCE,12,2)
 . D SET(X,RCT,RCDA,$P(RCARRY(RCT),U,4),BALANCE,TOTPOSTD)
 . ; line 2 of displayed EEOB item: payer name/payer id
 . S X="      "_PAYNM_"/"_PAYID
 . D SET(X,RCT,RCDA,$P(RCARRY(RCT),U,4),BALANCE,TOTPOSTD)
 Q
 ;
SET(X,RCSEQ,RCDA,RCDA1,BALANCE,TOTPOSTD) ; -- set ListManager arrays
 ; X = the data to set into the global
 ; RCSEQ = the selectable line #
 ; RCDA = the ien of the entry in file 344.49
 ; RCDA1 = ien of the entry in file 344.491
 ; BALANCE = Amount that is left to be posted
 ; TOTPOSTD = Total amount posted thus far against the ERA
 S VALMCNT=VALMCNT+1,^TMP("RCDPE-APAR_EEOB_WL",$J,VALMCNT,0)=X
 S ^TMP("RCDPE-APAR_EEOB_WL",$J,"IDX",VALMCNT,RCSEQ)=RCDA
 S ^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ)=VALMCNT_U_RCDA_U_RCDA1_U_$G(BALANCE)_U_$G(TOTPOSTD)
 Q
 ;
HDR ;
 N RCPAYR,X,LINE,RCMDRX,Y
 S RCPAYR=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR"))
 S RCMDRX=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX"))
 S Y=$S(RCMDRX="M":"MEDICAL",RCMDRX="P":"PHARMACY",1:"MEDICAL + PHARMACY")_" CLAIMS"
 S X=$S(($P(RCPAYR,U)="A")!(RCPAYR=""):"ALL PAYERS",1:"PAYERS: "_$P(RCPAYR,U,2)_"-"_$P(RCPAYR,U,3))
 S VALMHDR(1)="Current View:"_$J("",4)_Y_" for "_X
 S VALMHDR(2)=""
 S LINE="      "_$$CJ^XLFSTR("ERA#.Seq",14)_"   "_$$CJ^XLFSTR("Claim#",10)_"    "_$$CJ^XLFSTR("Posted Amt",12)
 S LINE=LINE_"   "_$$CJ^XLFSTR("Post Date",8)_"   "_$$CJ^XLFSTR("Un-posted Bal",12)
 S VALMHDR(3)=LINE
 Q
 ;
EXIT ; -- Clean up list
 K ^TMP("RCDPE-APAR_EEOB_WL",$J),^TMP("RCDPE-APAR_EEOB_WLDX",$J),^TMP("RCDPE_APAR_EEOB_PARAMS",$J),^TMP($J,"RCDPE_APAR_EEOB_LIST")
 K ^TMP("RCDPE_APAR_PVW",$J)
 K RCAPAR
 Q
 ;
PARAMS(SOURCE) ; Retrieve/Edit/Save View Parameters for APAR EEOB Worklist
 ; Input:   SOURCE      - "MO" - Called from Menu Option 
 ;                        "CV" - Called from Change View action
 ; Output: ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR") - P1^P2^P3 Where:
 ;                                                      P1- All Payers/Range of Payers
 ;                                                          ("A": All/"R":Range of Payers)
 ;                                                      P2- START WITH PAYER (e.g.,'AET')
 ;                                                          (Range Limited Only)
 ;                                                      P3- GO TO PAYER (e.g.,'AETZ')
 ;                                                         (Range Limited Only)
 ;         ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX")-  (M)edical, (P)harmacy, or (B)
 ;        
 ;         ^TMP("RCDPE_APAR_PVW",$J)
 ;              The ^TMP("RCDPE_APAR_PVW",$J) global contains the sort/filters of the user's preferred
 ;              view while ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,...)"RCPAYR" & "RCMEDRX" contain the 
 ;              sort/filters of what is currently displayed.
 ;
 ;         Or RCQUIT=1
 N RCXPAR,USEPVW,XX    ;PRCA*4.5*317 added XX
 S RCQUIT=0
 D:SOURCE="MO" GETWLPVW(.RCXPAR)  ;Retrieve user's saved preferred view (if any)
 ;
 ;Only ask user if they want to use their preferred view in the following scenarios:
 ; a) Source is "MO" and user has a preferred view on file
 ; b) Source is "CV" (change view action), user has a preferred view but is
 ;    not using the preferred view criteria at this time.
 S XX=$$PREFVW(SOURCE)
 I ((XX=1)&(SOURCE="MO"))!((XX=0)&(SOURCE="CV")) D  Q:USEPVW
 . ;
 . ; Ask the user if they want to use the preferred view
 . S USEPVW=$$ASKUVW^RCDPEWL0()
 . I USEPVW=-1 S RCQUIT=1 Q
 . Q:'USEPVW
 . ;
 . ; Set the Sort/Filtering Criteria from the preferred view 
 . M ^TMP("RCDPE_APAR_EEOB_PARAMS",$J)=^TMP("RCDPE_APAR_PVW",$J)
 ;
 ;Ask the users for the sort/filter criteria
 D PAYR
 Q:RCQUIT
 D CLMTYP
 Q
 ;
GETWLPVW(RCXPAR)  ; Retrieves the preferred view settings for the APAR worklist
 ; for the user
 ; PRCA*4.5*317 - Added subroutine
 ; Input:   None
 ; Output:  RCXPAR()                        - Array of preferred view sort/filter criteria
 ;          ^TMP("RCDPE_APAR_EEOB_PARAMS",$)- Global array of preferred view settings
 N XX
 K ^TMP("RCDPE_APAR_EEOB_PARAMS",$J)
 D GETLST^XPAR(.RCXPAR,"USR","RCDPE APAR","I")
 D:$D(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS")) PVWSAVE(.RCXPAR)
 ;
 S XX=$G(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS"))
 S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")=$S(XX'="":$TR(XX,";","^"),1:"A")
 S XX=$G(RCXPAR("MEDICAL/PHARMACY"))
 S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX")=$S(XX'="":$TR(XX,";","^"),1:"B")
 Q
 ;
PVWSAVE(RCXPAR) ; Save a copy of the preferred view on file
 ; PRCA*4.5*317 added subroutine
 ; Input: RCXPAR - array of preferred view setting for the user
 ; Output: ^TMP("RCERA_PVW") - a copy of the preferred settings
 ;
 K ^TMP("RCDPE_APAR_PVW",$J)
 ; only continue if we have answers to all APAR related preferred view prompts
 Q:'$D(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS"))
 Q:'$D(RCXPAR("MEDICAL/PHARMACY"))
 ;
 S ^TMP("RCDPE_APAR_PVW",$J,"RCPAYR")=$TR(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS"),";","^")
 S ^TMP("RCDPE_APAR_PVW",$J,"RCMEDRX")=$TR(RCXPAR("MEDICAL/PHARMACY"),";","^")
 Q
 ;
PREFVW(SOURCE,RCXPAR) ; Checks to see if the user has a preferred view
 ; PRCA*4.5*317 added subroutine
 ; When source is 'CV', checks to see if the preferred view is being used
 ; Input:   SOURCE                         - 'MO' - When called from the Lockbox menu
 ;                                                  option
 ;                                           'CV' - When called from the Change View
 ;                                                  action
 ;          RCXPAR                        - Array of preferred view values
 ;          ^TMP("RCDPE_APAR_EEOB_PARAMS")- Global array of currently in use defaults
 ;          ^TMP("RCDPE_APAR_PVW",$J)     - Global array of preferred view settings
 ;
 ; Returns: 1 - User has preferred view if SOURCE is 'MO' or is using
 ;              their preferred view if SOURCE is 'CV'
 ;          0 - User is not using their preferred view
 ;         -1 - User does not have a preferred view
 ;
 I SOURCE="MO" Q $S($D(^TMP("RCDPE_APAR_PVW",$J)):1,1:-1)
 Q:'$D(^TMP("RCDPE_APAR_PVW",$J)) -1      ; No stored preferred view
 Q:$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR"))'=$G(^TMP("RCDPE_APAR_PVW",$J,"RCPAYR")) 0
 Q:$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX"))'=$G(^TMP("RCDPE_APAR_PVW",$J,"RCMEDRX")) 0
 Q 1
 ;
PAYR ; Payer Selection
 ; Input:   ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR") - Current payer selection setting
 ; Output:  ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR") - Updated  payer selection setting
 ;          RCQUIT=1 if user ^ or timed out
 N DIR,DUOUT,DTOUT,RCPAYR,RCPAYRDF,RCXPAR,RCDRLIM,RCERROR,RCAUTOPDF
 N RCTYPEDF,RCQ,X,XX,Y
 S RCPAYRDF=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR"))
 S RCQUIT=0
 K DIR
 S DIR(0)="SA^A:ALL;R:RANGE"
 S DIR("A")="(A)LL payers, (R)ANGE of payer names: "
 S DIR("B")="ALL"
 S DIR("?",1)="Entering ALL will select all payers."
 S DIR("?")="If RANGE is entered, you will be prompted for a payer range."
 S:$P(RCPAYRDF,"^")'="" DIR("B")=$P(RCPAYRDF,"^")  ;Stored preferred view, use as default
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 S RCPAYR=Y
 I RCPAYR="A" S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")=Y Q
 I RCPAYR="R" D  Q:RCQUIT
 . W !,"Names you select here will be the payer names from the ERA, NOT the INS File"
 . K DIR
 . S DIR("?")="Enter a name between 1 and 30 characters in UPPERCASE"
 . S DIR(0)="FA^1:30^K:X'?.U X",DIR("A")="Start with payer name: "
 . S:$P(RCPAYRDF,"^",2)'="" DIR("B")=$P(RCPAYRDF,"^",2)  ;Stored preferred view, use as default
 . W !
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) D  Q
 . . S RCQUIT=1 Q
 . . K ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")
 . S RCPAYR("FROM")=Y
 . K DIR
 . S DIR("?")="Enter a name between 1 and 30 characters in UPPERCASE"
 . S DIR(0)="FA^1:30^K:X'?.U X",DIR("A")="Go to payer name: "
 . S DIR("B")=$E(RCPAYR("FROM"),1,27)_"ZZZ"
 . W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")=RCPAYR_"^"_RCPAYR("FROM")_"^"_Y
 Q
 ;
CLMTYP ; Ask for Medical or Pharmacy (Or Both)
 ; Input:   ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX") - Current Claim Type filter setting
 ; Output:  ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX") - Updated Claim Type filter setting
 ;          ^TMP("RCDPE_APAR_PVW",$J)                   - Global array of preferred view settings
 ;                                                        if user saves as preferred view
 ;          RCQUIT=1  - User ^ or timed out
 N DEF
 S DEF=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX"))
 S DEF=$S(DEF="P":"PHARMACY",DEF="M":"MEDICAL",1:"BOTH")
 S RCQ=$$RTYPE^RCDPESP2(DEF)
 I RCQ=-1 S RCQUIT=1 Q
 S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX")=RCQ
 D SAVEPVW
 Q
 ;
SAVEPVW ; Option to save as User Preferred View
 ; PRCA*4.5*317 added subroutine
 ; Input: ^TMP("RCDPE_APAR_EEOB_PARAMS",$J) - Global array of current worklist settings
 ; Output Current worklist settings set as preferred view (potentially)
 ;        ^TMP("RCDPE_APAR_PVW",$J)         - Global array of preferred view settings
 N DIR,DTOUT,DUOUT,RCERROR,XX
 K DIR
 W !
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to save this as your preferred view (Y/N)? "
 D ^DIR
 Q:Y'=1
 S XX=^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")
 D EN^XPAR(DUZ_";VA(200,","RCDPE APAR","ALL_PAYERS/RANGE_OF_PAYERS",$TR(XX,"^",";"),.RCERROR)
 S XX=^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX")
 D EN^XPAR(DUZ_";VA(200,","RCDPE APAR","MEDICAL/PHARMACY",$TR(XX,"^",";"),.RCERROR)
 ;
 ;Capture new preferred settings for comparison
 K ^TMP("RCDPE_APAR_PVW",$J)
 M ^TMP("RCDPE_APAR_PVW",$J)=^TMP("RCDPE_APAR_EEOB_PARAMS",$J)
 Q
 ;
FILTER(RCDA) ; Returns 1 if record in entry 344.4 passes
 ; the edits for the APAR worklist selection of EEOBs
 ; Parameters found in ^TMP("RCDPE_APAR_EEOB_PARAMS",$J)
 ; 
 ; input - RCDA = IEN OF 344.4
 ; output - returns 1 or 0
 N OK,RC0,RCPAYR,RCPAYFR,RCPAYTO,RCIEN,RCECME,RCERATYP
 S OK=1,RC0=$G(^RCY(344.4,RCDA,0))
 ;
 S RCPAYR=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")),U),RCPAYFR=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")),U,2),RCPAYTO=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")),U,3)
 S RCERATYP=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX"))
 ; Payer name
 I RCPAYR'="A" D  G:'OK FQ
 . N Q
 . S Q=$$UP^RCDPEARL($P(RC0,U,6))
 . I $S(Q=RCPAYFR:1,Q=RCPAYTO:1,Q]RCPAYFR:RCPAYTO]Q,1:0) Q
 . S OK=0
 ; ERA Type (Medical/Pharmacy)
 I RCERATYP'="B" D
 . ; Check the first EOB in the ERA to see if it is a Pharmacy or Medical ERA
 . S RCIEN=$O(^RCY(344.4,RCDA,1,0))
 . I RCIEN="" S OK=0 Q
 . S RCECME=$P($G(^RCY(344.4,RCDA,1,RCIEN,4)),U,2)
 . ; If requested filter is Pharmacy and there is an ECME #, display
 . I RCECME="",RCERATYP="M" Q
 . ; If requested filter is Medical and there is no ECME #, display
 . I RCECME'="",RCERATYP="P" Q
 . ; Otherwise, not valid on the filter, don't display
 . S OK=0
FQ Q OK
 ;
ENTEREOB ; Enter the APAR EEOB SCRATCHPAD
 N X,RCDA,RCDA1,XQORM,RCIENS
 S RCIENS=$$SEL()
 I 'RCIENS G EOBQ
 D EN^VALM("RCDPE APAR SELECTED EEOB")
EOBQ ;
 D INIT
 S VALMBCK="R"
 Q
 ;
SEL() ; Select an item from the APAR list of EEOBs
 N RCDA,VALMY,RCITEMS
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S (RCSEQ,RCDA,RCITEMS)=0
 F  S RCSEQ=$O(VALMY(RCSEQ)) Q:'RCSEQ  S RCITEMS=$P($G(^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ)),U,2,3)_U_RCSEQ
 Q RCITEMS
 ;
CV ;
 ; Change View action for APAR pick list
 D FULL^VALM1 D PARAMS("CV")
 D HDR,INIT S VALMBCK="R",VALMBG=1
 Q
