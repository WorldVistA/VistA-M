RCDPEAA1 ;ALB/KML - AUTO POST AWAITING RESOLUTION (APAR) - LIST OF UNPOSTED EEOBS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,304,317,321,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; Main entry point
 N RCQUIT,RCPROG
 S RCQUIT=0
 S RCPROG="RCDPEAA1"
 ; Calling Change View API in Menu Option Mode
 S RCQUIT=$$PARAMS("MO") ; PRCA*4.5*321
 Q:RCQUIT
 D EN^VALM("RCDPE APAR EEOB LIST")
 ;
ENQ Q
 ;
INIT ; EP Listman Template - RCDPE APAR EEOB LIST
 ;
 ; Parameters for selecting EEOBs to be included in the list are
 ; contained in the global ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,parameter name)
 ;
 ; PRCA*4.5*321 - Start modified code block
 N FDTTM,P1,P2,RCAPAR,RCDA,RCPROG
 S RCAPAR=1,P1="RCDPE_APAR_EEOB_PASS1",P2="RCDPE_APAR_EEOB_PASS2"
 S RCPROG="RCDPE-APAR_EEOB_WL"
 D FULL^VALM1,CLEAN^VALM10
 K ^TMP($J,RCPROG),^TMP($J,P1),^TMP($J,P2)
 K ^TMP(RCPROG,$J),^TMP("RCDPE-APAR_EEOB_WLDX",$J)
 ; First Pass - Get ERAs that are in a 'partial' auto-post status
 S RCDA=0
 F  D  Q:'RCDA
 . S RCDA=$O(^RCY(344.4,"E",1,RCDA))
 . Q:'RCDA
 . Q:'$$FILTER(RCDA)  ; Record didn't pass filter criteria
 . S ^TMP($J,P1,RCDA)=""
 ;
 D:$D(^TMP($J,P1)) BLD^RCDPEAA4(P1,P2,RCPROG) ; Build, Sort and Output the list
 ;
 ; If no EEOBs found display the message below in the list area
 I '$O(^TMP(RCPROG,$J,0)) D
 . S ^TMP(RCPROG,$J,1,0)="THERE ARE NO EEOBs MATCHING YOUR SELECTION CRITERIA"
 . S VALMCNT=1
 ; PRCA*4.5*321 - End modified code block
 Q
 ;
HDR ;
 N LINE,RCMDRX,RCPAYR,SORT,X,Y
 S RCPAYR=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR"))
 S RCMDRX=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX"))
 S Y=$S(RCMDRX="M":"MEDICAL",RCMDRX="P":"PHARMACY",RCMDRX="T":"TRICARE",1:"ALL")_" CLAIMS"
 S X=$S(($P(RCPAYR,U)="A")!(RCPAYR=""):"ALL PAYERS",1:"PAYERS: "_$P(RCPAYR,U,2)_"-"_$P(RCPAYR,U,3))
 S VALMHDR(1)="Current View:"_$J("",4)_Y_" for "_X
 ; PRCA*4.5*321 - Start modified code block
 S SORT=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")),"^",1)
 S X=$S(SORT="N":"Payer Name",SORT="R":"Reason",SORT="D":"Date",SORT="U":"Unposted",1:"Posted")
 S Y=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")),"^",2)
 I SORT="D" S X=X_$S(Y="H":" - Descending",1:" - Ascending")
 E  S X=X_$S(Y="H":" - Highest to Lowest",Y="L":" - Lowest to Highest",1:"")
 S VALMHDR(2)="   Sorted By:"_$J("",4)_X
 S LINE=$J("",10)_$$LJ^XLFSTR("ERA #.Sequence",17)
 S LINE=LINE_$$LJ^XLFSTR("Claim #",14)
 S LINE=LINE_$$RJ^XLFSTR("Posted",13)_" "
 ; S LINE=LINE_$$LJ^XLFSTR("Post Dt",11)
 S LINE=LINE_$$LJ^XLFSTR("Created Dt",11) ; PRCA*4.5*321
 S LINE=LINE_$$RJ^XLFSTR("Unposted",13)
 ; PRCA*4.5*321 - End modified code block
 S VALMHDR(3)=LINE
 Q
 ;
EXIT ; -- Clean up list
 ; PRCA*4.5*321 - Start modified code block
 K ^TMP("RCDPE_APAR_PVW",$J)
 K ^TMP("RCDPE_APAR_EEOB_PARAMS",$J)
 K ^TMP("RCDPE-APAR_EEOB_WL",$J),^TMP("RCDPE-APAR_EEOB_WLDX",$J)
 K ^TMP($J,"RCDPE_APAR_EEOB_PASS1"),^TMP($J,"RCDPE_APAR_EEOB_PASS2")
 ; PRCA*4.5*321 - End modified code block
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
 ;         ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT") - P1^P2 Where
 ;                                                    P1 - Sort Type
 ;                                                         "N" - Payer Name
 ;                                                         "P" - Posted Amount
 ;                                                         "R" - Auto-Post Reject Reason
 ;                                                         "U" - Unposted Amount
 ;                                                    P2 - H - Highest to Lowest Amount
 ;                                                         L - Lowest to Highest Amount
 ;                                                         ""- If P1="N" or "P"
 ; Returns: 1 if user ^ arrowed or timed out, 0 otherwise
 N RCQUIT,RCXPAR,USEPVW,XX    ;PRCA*4.5*321 added RCQUIT
 S (RCQUIT,USEPVW)=0          ;PRCA*4.5*321 initialise USEPW
 ; Retrieve user's saved preferred view (if any)
 D:SOURCE="MO" GETWLPVW(.RCXPAR)
 ;
 ;Only ask user if they want to use their preferred view in the following scenarios:
 ; a) Source is "MO" and user has a preferred view on file
 ; b) Source is "CV" (change view action), user has a preferred view but is
 ;    not using the preferred view criteria at this time.
 S XX=$$PREFVW(SOURCE)
 I ((XX=1)&(SOURCE="MO"))!((XX=0)&(SOURCE="CV")) D  ; PRCA*4.5*321 - move Q:USEPVW
 . ;
 . ; Ask the user if they want to use the preferred view
 . S USEPVW=$$ASKUVW^RCDPEWL0()
 . I USEPVW=-1 S RCQUIT=1 Q
 . Q:'USEPVW
 . ;
 . ; Set the Sort/Filtering Criteria from the preferred view 
 . M ^TMP("RCDPE_APAR_EEOB_PARAMS",$J)=^TMP("RCDPE_APAR_PVW",$J)
 ;
 ; PRCA*4.5*321 - Start modified code block
 Q:USEPVW 0
 Q:RCQUIT 1
 ; PRCA*4.5*326 prompt for type filter first in case we need to use it in payer selection
 S RCQUIT=$$MORP() ; Select Medical or Pharmacy, or Tricare
 Q:RCQUIT 1
 S RCQUIT=$$PAYR() ; Select Payer(s)
 Q:RCQUIT 1
 S RCQUIT=$$SORT() ; Select Sort
 Q:RCQUIT 1
 S RCQUIT=$$SAVEPVW() ; Save Preferred View
 Q:RCQUIT 1
 Q 0
 ; PRCA*4.5*321 - End modified code block
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
 S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX")=$S(XX'="":$TR(XX,";","^"),1:"A") ; PRCA*4.5*326 Default A
 ; PRCA&4.5*321 - add sort to preferened view
 S XX=$G(RCXPAR("SORT"))
 S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")=$S(XX'="":$TR(XX,";","^"),1:"N")
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
 Q:'$D(RCXPAR("SORT"))  ; PRCA*4.5*321
 ;
 S ^TMP("RCDPE_APAR_PVW",$J,"RCPAYR")=$TR(RCXPAR("ALL_PAYERS/RANGE_OF_PAYERS"),";","^")
 S ^TMP("RCDPE_APAR_PVW",$J,"RCMEDRX")=$TR(RCXPAR("MEDICAL/PHARMACY"),";","^")
 S ^TMP("RCDPE_APAR_PVW",$J,"SORT")=$TR(RCXPAR("SORT"),";","^") ; PRCA*4.5*321
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
 Q:$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT"))'=$G(^TMP("RCDPE_APAR_PVW",$J,"SORT")) 0 ; PRCA*4.5*321
 Q 1
 ;
PAYR() ; Payer Selection
 ; Input:   ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR") - Current payer selection setting
 ; Output:  ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR") - Updated  payer selection setting
 ;          RCQUIT=1 if user ^ or timed out
 ; Returns: 1 if user ^ arrowed or time out
 N DIR,DIRUT,DIROUT,DUOUT,DTOUT,RCPAYR,RCPAYRDF,RCXPAR,RCDRLIM,RCERROR,RCAUTOPDF
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
 I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q 1
 S RCPAYR=Y
 I RCPAYR="A" S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")=Y Q 0
 I RCPAYR="R" D  Q:RCQUIT RCQUIT
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
 Q 0
 ;
MORP() ; Ask for Medical or Pharmacy, Tricare (Or All)
 ; Input: None
 ; Returns: 1 if user ^ arrowed or timed out, 0 otherwise
 N DEF
 S DEF=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX"))
 S DEF=$S(DEF="P":"PHARMACY",DEF="M":"MEDICAL",DEF="T":"TRICARE",1:"ALL") ; PRCA*4.5*326
 S RCQ=$$RTYPE^RCDPEU1(DEF) ; PRCA*4.5*326
 I RCQ=-1 Q 1
 S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX")=RCQ
 Q 0
 ;
SORT() ; Ask for Sort - Payer, Dollar, Date, Trace Number
 ; Input: None
 ; Returns: 1 if user ^ arrowed or timed out, 0 otherwise
 N DEF,DIR,DIRUT,DTOUT,DUOUT,P1,X,XX,Y
 S DEF=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")),"^",1)
 S DEF=$S(DEF="D":"DATE",DEF="N":"PAYER NAME",DEF="P":"POSTED",DEF="R":"REASON",DEF="U":"UNPOSTED",1:"")
 S DIR(0)="SA^D:DATE;N:PAYER NAME;P:POSTED;R:REASON;U:UNPOSTED"
 S DIR("A")="Sort By (D)ATE, PAYER (N)AME, (R)EASON, (P)OSTED, (U)NPOSTED: "
 S DIR("B")=$S(DEF'="":DEF,1:"DATE")
 S DIR("?",1)="Enter 'DATE' to sort by date created."
 S DIR("?",2)="Enter 'PAYER NAME' to sort by payer name."
 S DIR("?",3)="Enter 'REASON' to sort by auto-post reject reason."
 S DIR("?",4)="Enter 'POSTED' to sort by the posted amount."
 S DIR("?")="Enter 'UNPOSTED' to sort by the unposted amount."
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I Y="N"!(Y="R") D  Q 0
 . S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")=Y
 ;
 S P1=Y,XX=""
 I P1="P"!(P1="U") S XX=$$HTOL() I XX=-1 Q 1
 I P1="D" S XX=$$DATEORD() I XX=-1 Q 1
 S ^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")=P1_"^"_XX
 Q 0
 ;
HTOL() ; Ask for how dollar amounts should be sorted - either highest to
 ; lowest amount or lowest to highest amount
 ; Input: None
 ; Returns: -1 - if user ^ arrowed or timed out
 ; H - Highest to Lowest
 ; L - Lowest to Highest
 N DEF,DIR,DIRUT,DTOUT,DUOUT,P1,X,Y
 S DEF=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")),"^",2)
 S DEF=$S(DEF="H":"HIGHEST TO LOWEST",DEF="L":"LOWEST TO HIGHEST",1:"")
 S DIR(0)="SA^H:HIGHEST TO LOWEST;L:LOWEST TO HIGHEST"
 S DIR("A")="Sort By (H)IGHEST TO LOWEST or (L)OWEST TO HIGHEST: "
 S DIR("B")=$S(DEF'="":DEF,1:"HIGHEST TO LOWEST")
 S DIR("?",1)="Enter 'HIGHEST TO LOWEST' to sort amounts in decreasing order."
 S DIR("?")="Enter 'LOWEST TO HIGHEST' to sort amounts in increasing order."
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q Y
DATEORD() ; Ask how creation date should be sorted - ascending or descending
 ; Input: None
 ; Returns: -1 - if user ^ arrowed or timed out
 ; H - Descending (Highest to lowest)
 ; L - Ascending (Lowest to Highest)
 N DEF,DIR,DIRUT,DTOUT,DUOUT,P1,X,Y
 S DEF=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")),"^",2)
 S DEF=$S(DEF="H":"DESCENDING",DEF="L":"ASCENDING",1:"")
 S DIR(0)="SA^A:ASCENDING;D:DESCENDING"
 S DIR("A")="Sort in (A)SCENDING or (D)ESCENDING order: "
 S DIR("B")=$S(DEF'="":DEF,1:"ASCENDING")
 S DIR("?",1)="Enter 'ASCENDING' to see oldest EEOBs first."
 S DIR("?")="Enter 'DESCENDING' to see newest EEOBs first."
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 S Y=$S(Y="D":"H",1:"L")
 Q Y
SAVEPVW() ; Option to save as User Preferred View
 ; PRCA*4.5*317 added subroutine
 ; Input: ^TMP("RCDPE_APAR_EEOB_PARAMS",$J) - Global array of current worklist settings
 ; Output Current worklist settings set as preferred view (potentially)
 ;        ^TMP("RCDPE_APAR_PVW",$J)         - Global array of preferred view settings
 ; Returns: 1 - User ^ arrowed or timed out, 0 otherwise
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,XX,Y
 K DIR
 W !
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to save this as your preferred view (Y/N)? "
 D ^DIR
 ; PRCA*4.5*321 ; Start modified code block
 I $D(DTOUT)!$D(DUOUT) Q 1
 I Y=1 D
 . S XX=^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")
 . D EN^XPAR(DUZ_";VA(200,","RCDPE APAR","ALL_PAYERS/RANGE_OF_PAYERS",$TR(XX,"^",";"),.RCERROR)
 . S XX=^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX")
 . D EN^XPAR(DUZ_";VA(200,","RCDPE APAR","MEDICAL/PHARMACY",XX,.RCERROR)
 . S XX=^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"SORT")
 . D EN^XPAR(DUZ_";VA(200,","RCDPE APAR","SORT",$TR(XX,"^",";"),.RCERROR)
 . ;
 . ;Capture new preferred settings for comparison
 . K ^TMP("RCDPE_APAR_PVW",$J)
 . M ^TMP("RCDPE_APAR_PVW",$J)=^TMP("RCDPE_APAR_EEOB_PARAMS",$J)
 Q 0
 ; PRCA*4.5*321 ; End modified code block
 ;
FILTER(RCDA) ; Returns 1 if record in entry 344.4 passes
 ; the edits for the APAR worklist selection of EEOBs
 ; Parameters found in ^TMP("RCDPE_APAR_EEOB_PARAMS",$J)
 ; 
 ; Input: RCDA - Internal IEN OF 344.4
 ; Returns: 1 if the ERA Record passes filters, 0 otherwise
 ; PRCA*4.5*321 - Start modified code block
 N OK,RCECME,RCERATYP,RCIEN,RCPAYR,RCPAYFR,RCPAYTO,XX
 S OK=1
 ;
 S RCPAYR=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")),U,1)
 S RCPAYFR=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")),U,2)
 S RCPAYTO=$P($G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCPAYR")),U,3)
 S RCERATYP=$G(^TMP("RCDPE_APAR_EEOB_PARAMS",$J,"RCMEDRX"))
 ; Payer name filter
 I RCPAYR'="A" D  Q:'OK OK
 . S XX=$$GET1^DIQ(344.4,RCDA,.06,"I") ; Payer Name
 . S XX=$$UP^XLFSTR(XX)
 . ;
 . ; Make sure the Payer is in the selected Payer range
 . I $S(XX=RCPAYFR:1,XX=RCPAYTO:1,XX]RCPAYFR:RCPAYTO]XX,1:0) Q
 . S OK=0
 ;
 ; ERA Type (Medical/Pharmacy) filter
 I RCERATYP'="A" D  ; PRCA*4.5*326
 . I '$$ISTYPE^RCDPEU1(344.4,RCDA,RCERATYP) S OK=0 ; PRCA*4.5*326
 Q OK
 ; PRCA*4.5*321 - End modified code block
 ;
ENTEREOB ; EP Protocol action - RCDPE APAR SELECT EEOB
 ; Enter the APAR EEOB SCRATCHPAD
 N RCDA,RCDA1,RCIENS,X,XQORM
 S VALMBCK="R"
 S RCIENS=$$SEL()
 I 'RCIENS D INIT Q
 D EN^VALM("RCDPE APAR SELECTED EEOB")
 D INIT
 Q
 ;
SEL() ; Select an item from the APAR list of EEOBs
 ; Input: None
 ; Returns: RCIENS - Internal IENs A1^A2^A3 Where:
 ; A1 - IEN for in file 344.49
 ; A2 - IEN for subfile 344.491
 ; A3 - Selectable line item from listman screen
 N RCDA,RCITEMS,RCSEQ,VALMY
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S (RCSEQ,RCDA,RCITEMS)=0
 F  D  Q:'RCSEQ
 . S RCSEQ=$O(VALMY(RCSEQ))
 . Q:'RCSEQ
 . S RCITEMS=$P($G(^TMP("RCDPE-APAR_EEOB_WLDX",$J,RCSEQ)),U,2,3)_U_RCSEQ
 Q RCITEMS
 ;
CV ;
 ; Change View action for APAR pick list
 D FULL^VALM1 D PARAMS("CV")
 D HDR,INIT S VALMBCK="R",VALMBG=1
 Q
