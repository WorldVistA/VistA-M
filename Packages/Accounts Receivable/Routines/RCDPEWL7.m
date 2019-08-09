RCDPEWL7 ;ALB/TMK/KML - EDI LOCKBOX WORKLIST ERA DISPLAY SCREEN ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**208,222,269,276,298,304,318,321,326,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
BLD(RCSORT) ; Build list with sort criteria
 ; RCSORT = the sort levels to use to display the data in ^ pieces
 ;  piece 1 = the codes for the first level sort (sort code;null or -)
 ;  piece 2 = the codes for the second level sort
 ;     sort code is the type of data to sort by;- indicates reverse order
 N Z,Z1,RCT,RCZ
 S (RCT,VALMCNT)=0
 I '$D(^TMP($J,"RCERA_LIST")) D
 . S Z=0 F  S Z=$O(^TMP("RCDPE-ERA_WLDX",$J,Z)) Q:'Z  S RCZ=$P($G(^(Z)),U,2) D
 .. I $$FILTER(RCZ) S ^TMP($J,"RCERA_LIST",$$SL(RCZ,$P(RCSORT,U)),$$SL(RCZ,$P(RCSORT,U,2)),RCZ)=""
 . K ^TMP("RCDPE-ERA_WLDX",$J),^TMP("RCDPE-ERA_WL",$J)
 ;
 S Z=""
 I RCSORT'["PN;-" D
 . F  S Z=$O(^TMP($J,"RCERA_LIST",Z)) Q:Z=""  S Z1="" F  S Z1=$O(^TMP($J,"RCERA_LIST",Z,Z1)) Q:Z1=""  D EXTRACT(Z,Z1,.RCT)
 ;
 I $P(RCSORT,U)["PN;-" D
 . F  S Z=$O(^TMP($J,"RCERA_LIST",Z),-1) Q:Z=""  S Z1="" F  S Z1=$O(^TMP($J,"RCERA_LIST",Z,Z1)) Q:Z1=""  D EXTRACT(Z,Z1,.RCT)
 ;
 I $P(RCSORT,U,2)["PN;-" D
 . F  S Z=$O(^TMP($J,"RCERA_LIST",Z)) Q:Z=""  S Z1="" F  S Z1=$O(^TMP($J,"RCERA_LIST",Z,Z1),-1) Q:Z1=""  D EXTRACT(Z,Z1,.RCT)
 ;
 I '$O(^TMP($J,"RCERA_LIST",0)) D SET("No ERAs left for your selection criteria")
 K ^TMP($J,"RCERA_LIST")
 S ^TMP("RCERA_PARAMS",$J,"SORT")=RCSORT
 Q
 ;
EXTRACT(RCSRT1,RCSRT2,RCT) ; Extract the data
 ; RCSRT1 = data value at 1st sort level
 ; RCSRT2 = data value at 2nd sort level
 ; RCT = running entry counter - returned if passed by ref
 N AUTOCOMP,FIRST,MDT,RC0,RCARC,RCEFT,RCEXCEP,RCPOST,RCSTAT,RCZ,X,XX,Z,Z0 ;PRCA*4.5*318 Variable XX added
 S RCZ=0 F  S RCZ=$O(^TMP($J,"RCERA_LIST",RCSRT1,RCSRT2,RCZ)) Q:'RCZ  D
 . S RCT=RCT+1,RC0=$G(^RCY(344.4,RCZ,0))
 . S RCEFT=+$O(^RCY(344.31,"AERA",RCZ,0))
 . S MDT=$$MATCHDT^RCDPEWL7(RCEFT,"2D") ; PRCA*4.5*326 - Add date matched
 . S RCEXCEP=$$XCEPT^RCDPEWLP(RCZ)  ; prca*4.5*298  assignment of ERA exception flag
 . S AUTOCOMP=$$STA(RCZ) ;PRCA*4.5*326
 . S RCARC=$$WLF^RCDPEWLZ(RCZ)
 . S RCSTAT=$S('RCEFT:U_$S($P(RC0,U,15)="CHK":"(CHECK PAYMENT EXPECTED)",$P(RC0,U,15)="NON":"(NO PAYMENT EXPECTED)",$P(RC0,U,9)=2:"(CHECK PAYMENT CHOSEN)",1:"N/A"),1:$$FMSSTAT^RCDPUREC(+$P($G(^RCY(344.31,RCEFT,0)),U,9)))
 . S RCPOST=$S(RCEFT:"EFT RECEIPT STATUS: ",1:"")_$P(RCSTAT,U,2)
 . ;prca*4.5*298 include Auto-Post Complete indicator and ERA exception flag in $SELECT statement
 . S X=$E(RCT_$J("",5),1,5)_"  "_$S(RCEXCEP]"":RCEXCEP,AUTOCOMP]"":AUTOCOMP,RCARC]"":RCARC,$D(^RCY(344.49,RCZ)):" ",1:"-")_$E($P(RC0,U)_$J("",10),1,10)_"  "_$E($P(RC0,U,2)_$J("",50),1,50)
 . D SET(X,RCT,RCZ)
 . S X=$J("",43)_$J($$FMTE^XLFDT($P(RC0,U,7),"2D"),8)_$J("",2)_$J(+$P(RC0,U,5),12,2)
 . S $E(X,73,80)=$$FMTE^XLFDT($P(RC0,U,7),"2D")
 . D SET(X,RCT,RCZ)
 . ; PRCA*4.5*326 Start changed block
 . S X=$J("",8)_$E($P(RC0,U,6)_$J("",30),1,30)_"  APPROX # EEOBs: "_+$$CTEEOB^RCDPEWLB(RCZ)
 . D SET(X,RCT,RCZ)
 . S X=$P(RC0,U,9),XX=$$EXTERNAL^DILFD(344.4,.09,"",$P(RC0,U,9))
 . S XX=$S(X=1:"EFT MATCHED",X=2:"CHK MATCHED",X=3:"MATCH-0 PAY",XX=-1:"MATCH W/ERR",1:$P(XX," ",1))
 . I X=2 S MDT=$$GET1^DIQ(344.4,RCZ_",",5.03,"I") I MDT'="" S MDT=$$FMTE^XLFDT(MDT,"2D")
 . S:$$UNBAL^RCDPEAP1(RCZ) XX=XX_" - UNBALANCED"
 . S X=$J("",8)_$E(XX_$J("",25),1,25)_" "_$E(MDT_$J("",8),1,8)
 . S X=X_"  "_RCPOST
 . ; PRCA*4.5*326 End changed block
 . D SET(X,RCT)
 . D SET(" ",RCT)
 ;.; prca*4.5*298  per patch requirements, keep code related to
 ;. ; creating/maintaining batches but just remove from execution.
 ;. ;I $G(^TMP("RCERA_PARAMS",$J,"BATCHON")) D
 ;.. ;S Z=0 F  S Z=$O(^RCY(344.49,RCZ,3,Z)) Q:'Z  S Z0=$G(^(Z,0)) I Z0'="" D
 ;...; S X=$J("",12)_$E("- BATCH #"_$P(Z0,U)_$J("",4),1,13)_" "_$E($P(Z0,U,2)_$J("",30),1,30)_"  "_$S('$P(Z0,U,3):"NOT ",1:"")_"READY TO POST"
 ;... ;D SET(X,RCT)
 ;
 S VALMSG="Enter ?? for more actions and help" ; PRCA*4.5*326
 ;
 Q
 ;
 ; BEGIN PRCA*4.5*326
STA(RCZ) ;Determine auto-post status and if marked for auto-post
 ; Input - RCZ = ERA ien
 ; Output - "" = UNPOSTED
 ;          "A" = COMPLETE
 ;          "P" = PARTIAL
 ;          "M" = MARKED
 N STA
 ;Get ERA auto-post status
 S STA=$$GET1^DIQ(344.4,RCZ_",",4.02,"I")
 ;Not auto-post ERA
 Q:STA="" ""
 ;Unposted but marked for autopost
 I STA=0,$$GET1^DIQ(344.4,RCZ_",",4.04,"I")]"" Q "M"
 ;Unposted - EFT still not accepted
 Q:STA=0 ""
 ;Complete
 Q:STA=2 "A"
 ;Partial
 N MATCH,SUB
 S MATCH=0,SUB=0
 F  S SUB=$O(^RCY(344.4,RCZ,1,SUB)) Q:'SUB  D  Q:MATCH
 .S MATCH=$$GET1^DIQ(344.41,SUB_","_RCZ,6,"I")
 Q $S(MATCH:"M",1:"P")
 ; END PRCA*4.5*326
 ;
MATCHDT(RCEFT,FORMAT) ;EP
 ; Get the Date the ERA was matched
 ; Input: RCEFT    - IEN for file 344.31
 ;        FORMAT   - (Optional) date format for second parameter of FMTE^XLFDT (Defaults to 2DZ)
 ; Returns: External date when the ERA was matched or ""
 I '$G(RCEFT) Q ""
 N IENS,XX
 I $G(FORMAT)="" S FORMAT="2DZ"
 S XX=$O(^RCY(344.31,RCEFT,4,"A"),-1)   ; Get last Match Status History record
 Q:XX="" ""
 S IENS=XX_","_RCEFT_","
 S XX=$$GET1^DIQ(344.314,IENS,.02,"I")
 Q:XX="" ""
 S XX=$$FMTE^XLFDT(XX,FORMAT)
 Q XX
 ;
SL(Y,SORT) ; Returns data for sort level from entry Y in file 344.4
 ; SORT = the sort data in ';' delimited pieces
 ;    pc 1 = code for sort data
 ;    pc 2 = the order requested (- or null)
 ;
 N RC0,DAT,SORT1,SORT2
 S SORT1=$P(SORT,";"),SORT2=$P(SORT,";",2)
 S RC0=$G(^RCY(344.4,Y,0)),DAT=" "
 ; No sort
 I SORT="" G SLQ
 ; Amt paid
 I SORT1="AP" D  G SLQ
 . S DAT=SORT2_+$P(RC0,U,5)
 ; ERA date pd
 I SORT1="DP" D  G SLQ
 . S DAT=SORT2_($P(RC0,U,4)\1)
 ; Payer name
 I SORT1="PN" D  G SLQ
 . S DAT=$$UP^RCDPEARL($P(RC0,U,6))
 ; ERA date received
 I SORT1="DR" D  G SLQ
 . S DAT=SORT2_($P(RC0,U,7)\1)
 ;
SLQ Q $S(DAT'="":DAT,1:" ")
 ;
INIT ; Entry point for List template to build the display of ERAs
 ;
 ; Parameters for selecting ERAs to be included in the list are
 ; contained in the global ^TMP("RCERA_PARAMS",$J,parameter name)
 ;
 N RCZ,RC0,RCT,RCTT,RCQUIT,RCDTFR,RCDTTO,DTOUT,DUOUT,DIR,X,Y,Z,Z1,RCPOST,RCEFT,RCINDX,QFLG
 D CLEAN^VALM10
 K ^TMP("RCDPE-ERA_WL",$J),^TMP("RCDPE-ERA_WLDX",$J),^TMP($J,"RCERA_LIST")
 ;
 S (RCT,RCTT,RCQUIT)=0
 ;
 S RCDTFR=+$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U),RCDTTO=$S($P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U,2):$P(^("RCDT"),U,2),1:DT)
 ;
 S RCINDX=$S(RCDTFR:RCDTFR-.00000001,1:0)
 W !!,"SEARCHING, PLEASE STANDBY (PRESS '^' TO QUIT SEARCH)",!!
 F  S RCINDX=$O(^RCY(344.4,"AFD",RCINDX)) Q:'RCINDX!(RCINDX\1>RCDTTO)!RCQUIT  S RCZ=0 F  S RCZ=$O(^RCY(344.4,"AFD",RCINDX,RCZ)) Q:'RCZ  D  Q:RCQUIT
 . S RCTT=RCTT+1
 . I RCTT>19999 D  Q:RCQUIT=1
 . . S RCTT=0
 . . D WAIT^DICD
 . . D INITKB^XGF ; supported by DBIA 3173
 . . S QFLG=$$READ^XGF(1,1)
 . . Q:$G(DTOUT)
 . . S:QFLG="^" RCQUIT=1 Q
 . . I $D(DUOUT)!(Y=0) S RCQUIT=1 Q
 . . D RESETKB^XGF
 . ;
 . S RC0=$G(^RCY(344.4,RCZ,0))
 . I $$FILTER(RCZ) S ^TMP($J,"RCERA_LIST",$$SL(RCZ,"DR"),$$SL(RCZ,""),RCZ)=""
 ;
 ; Output the list
 I 'RCQUIT D
 . D:$D(^TMP($J,"RCERA_LIST")) BLD("DR^N")
 . ; If no ERAs found display the message below in the list area
 . I '$O(^TMP("RCDPE-ERA_WL",$J,0)) D
 . . S ^TMP("RCDPE-ERA_WL",$J,1,0)="THERE ARE NO ERAs MATCHING YOUR SELECTION CRITERIA" S VALMCNT=2
 I RCQUIT K ^TMP("RCDPE-ERA_WL",$J),^TMP("RCDPE-ERA_WLDX",$J),^TMP($J,"RCERA_LIST") S VALMQUIT=""
 Q
 ;
HDR ; Header for ERA Worklist (List user Current Screen View selections)
 ; Input: ^TMP("RCERA_PARAMS",$J)
 ; Output: VALMHDR
 N X,XX,XX2
 ;
 ; PRCA*4.5*321 - Total re-write of header subroutine to add new filters and shorten lines etc.
 ; First header line. Date range and Pharmacy/Tricare/Medical
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCDT"))
 S XX="DATE RANGE  : "
 I $P(X,U) D  ;
 . S XX=XX_$$FMTE^XLFDT($P(X,U),2)
 . I $P(X,U,2) S XX=XX_"-"_$$FMTE^XLFDT($P(X,U,2),2)
 E  S XX=XX_"NONE SELECTED"
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCTYPE"))
 S XX2="MEDICAL/PHARM/TRIC: " ; PRCA*4.5*332
 S XX2=XX2_$S(X="M":"MEDICAL ONLY",X="P":"PHARMACY ONLY",X="T":"TRICARE ONLY",1:"ALL")
 S XX=$$SETSTR^VALM1(XX2,XX,40,41)
 S VALMHDR(1)=XX
 ;
 ; Second header line. Match/Unmatched and Auto-posting/Non Autoposting
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCMATCH"))
 S XX="MATCH STATUS: "_$S(X="N":"NOT MATCHED",X="M":"MATCHED",1:"BOTH")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCAUTOP"))
 S XX2="AUTO-POSTING: "
 S XX2=XX2_$S(X="A":"AUTO-POSTING ONLY",X="N":"NON AUTO-POSTING ONLY",1:"BOTH")
 S XX=$$SETSTR^VALM1(XX2,XX,46,35)
 ; BEGIN PRCA*4.5*326
 I X'="N" D
 .S X=$G(^TMP("RCERA_PARAMS",$J,"RCAPSTA"))
 .S XX2="AUTOP: "_$S(X="P":"PARTIAL",X="C":"COMPLETE",X="M":"MARKED",1:"ALL")
 .S XX=$$SETSTR^VALM1(XX2,XX,27,15)
 ; END PRCA*4.5*326
 S VALMHDR(2)=XX
 ;
 ; Third header line. Post status, payer name range and zero payment/payment
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))
 S XX="POST STATUS : "_$S(X="U":"UNPOSTED",X="P":"POSTED",1:"BOTH")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCPAYR"))
 I $P(X,U)="A"!(X="") D  ;
 . S XX2="ALL PAYERS"
 E  D  ;
 . S XX2=$P(X,U,2)_"-"_$P(X,U,3)
 . I $L(XX2)>11 S XX2="RANGE"
 S XX2="PAYERS: "_XX2
 S XX=$$SETSTR^VALM1(XX2,XX,26,20)
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCPAYMNT"))
 S XX2="PAYMENT TYPE: "
 S XX2=XX2_$S(X="Z":"ZERO PAYMENTS ONLY",X="P":"PAYMENTS ONLY",1:"BOTH")
 S XX=$$SETSTR^VALM1(XX2,XX,46,35)
 S VALMHDR(3)=XX
 ;
 S VALMHDR(4)="#       ERA #            Trace#"
 Q
 ;
FNL ; -- Clean up list
 K ^TMP("RCDPE-ERA_WL",$J),^TMP("RCDPE-ERA_WLDX",$J),^TMP("RCERA_PARAMS",$J),^TMP($J,"RCERA_LIST")
 Q
 ;
SET(X,RCSEQ,RCSEQ1) ; -- set arrays
 ; X = the data to set into the global
 ; RCSEQ = the selectable line #
 ; RCSEQ1 = the ien of the entry in file 344.4
 S VALMCNT=VALMCNT+1,^TMP("RCDPE-ERA_WL",$J,VALMCNT,0)=X
 I $G(RCSEQ) S ^TMP("RCDPE-ERA_WL",$J,"IDX",VALMCNT,RCSEQ)=$G(RCSEQ1)
 I $G(RCSEQ1) S ^TMP("RCDPE-ERA_WLDX",$J,RCSEQ)=VALMCNT_U_RCSEQ1
 Q
 ;
ENTERWL ; Enter the worklist with an ERA
 D WL($$SEL())
 D BLD($G(^TMP("RCERA_PARAMS",$J,"SORT")))
 S VALMBCK="R"
 Q
 ;
SEL() ; Select an ERA from the ERA list
 N RCDA,VALMY
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S RCERA=0
 S RCDA=0 F  S RCDA=$O(VALMY(RCDA)) Q:'RCDA  S RCERA=+$P($G(^TMP("RCDPE-ERA_WLDX",$J,RCDA)),U,2)
 ;
 Q RCERA
 ;
WL(RCERA) ; Enter worklist
 ;
 ;             input - RCERA = ien of the ERA entry in file 344.4
 ;
 N DA,DIE,DIR,DR,DTOUT,DUOUT,I,PREVENT,RC0,RCNOED,RCQUIT,RCSORT,RCEXC,RETCODES,STATE,TYPE,X,Y
 Q:RCERA'>0
 ; PRCA*4.5*304 - Reentry if we cleared exceptions
WL1 ; retest to make sure this ERA does not have an exception
 S TYPE=$S($$PAYTYPE(RCERA,"P"):"P",1:"M"),RCEXC=0 ; PRCA*4.5*321
 ; PRCA*4.5*304 - see if we have the ERA and go to WL1 to retest.
 I ($$XCEPT^RCDPEWLP(RCERA)]"")&(TYPE="M") D EXCDENY^RCDPEWLP Q  ;cannot process MEDICAL ERA if exception exists then fall back to Worklist.
 ; PRCA*4.5*304 - Removed the G:($G(RCERA)'="")&&($G(RCEXC)=1) WL1 from above so it falls back to the worklist instead of going forward to the "Select ERA"
 ; I ($$XCEPT^RCDPEWLP(RCERA)]"")&(TYPE="M") D EXCDENY^RCDPEWLP G:($G(RCERA)'="")&&($G(RCEXC)=1) WL1 Q
 S (RCQUIT,RCNOED,PREVENT)=0,RC0=$G(^RCY(344.4,RCERA,0)),RCSORT=""
 I $P(RC0,U,8) D
 . I '$D(^RCY(344.49,RCERA,0)) D  Q
 .. S RCQUIT=1
 .. W ! S DIR(0)="EA",DIR("A",1)="A SCRATCH PAD WAS NOT CREATED FOR THIS ERA BEFORE POSTING",DIR("A",2)="USE THE VIEW/PRINT ERA OPTION TO SEE ITS DETAIL",DIR("A")="Press ENTER to continue: " D ^DIR K DIR Q
 . ;
 . S RCNOED=+$P(RC0,U,8)
 . S DIR(0)="EA",DIR("A",1)="THIS ERA ALREADY HAS A RECEIPT - YOU MAY ONLY VIEW ITS SCRATCH PAD",DIR("A")="Press ENTER to continue: "
 . W ! D ^DIR K DIR W !
 G:RCQUIT WLQ
 G:RCNOED WLD   ; already has a receipt so no need to check for older unposted EFTs
 ; function $$AGEDEFTS - search for any UNPOSTED EFTs older than 14 days (medical) or 30 days (pharmacy)
 ; return value of 0, 2, or 3 represent that entry into scratchpad can occur
 S TYPE=$S(TYPE="P":"P",$$PAYTYPE(RCERA,"T"):"T",1:"M") ; PRCA*4.5*332
 S RETCODES=$$AGEDEFTS^RCDPEWLP(RCERA,TYPE) ; PRCA*4.5*332
 S PREVENT=0
 F I=1:1 S STATE=$P(RETCODES,U,I) Q:STATE=""  I $E(STATE,2)=TYPE,$E(STATE,1)=1 S PREVENT=1 ; PRCA*4.5*332
 Q:PREVENT   ; prevent user from entering scratchpad; there are older EFTs on the system that need to be worked.
WLD ;
 D DISP^RCDPEWL(RCERA,RCNOED)
 ;
 ; prca*4.5*298  per patch requirements, keep code related to 
 ; creating/maintaining batches but just remove from execution.
 ;I 'RCQUIT,$G(^TMP("RCBATCH_SELECTED",$J)) D
 ;. S DA(1)=RCERA,DA=+$G(^TMP("RCBATCH_SELECTED",$J)),DR=".05////0",DIE="^RCY(344.49,"_DA(1)_",3," D ^DIE
 ;. L -^RCY(344.49,DA(1),3,DA,0)
 ;. K ^TMP("RCBATCH_SELECTED",$J)
 ;E  D
 ;L -^RCY(344.4,RCERA,0)
WLQ ;
 L -^RCY(344.4,RCERA,0)
 Q
 ;
PRERA ; View/Print ERA from ERA list menu
 N RCSCR
 S RCSCR=$$SEL()
 I RCSCR>0 D PRERA^RCDPEWL0
 S VALMBCK="R"
 Q
 ;
BAT(RCERA) ; Select batch, if needed
 ; Returns 1 if batch selected OK or no batch needed
 ; RCERA = ien of entry in file 344.49
 N RCINUSE,RCQUIT,RCADJ,RC0,RCOK,DIR,DTOUT,DUOUT,X,Y,Z
 K ^TMP("RCBATCH_SELECTED",$J)
 S RCOK=1
 I '$O(^RCY(344.49,RCERA,3,0)) G BATQ
 S RC0=$G(^RCY(344.4,RCERA,0))
 S (RCQUIT,RCADJ)=0
 I $$HASADJ^RCDPEWL8(RCERA) D
 . S RCADJ=1
 . S DIR("A",1)="THIS ERA HAS NEGATIVE ADJUSTMENTS THAT NEED TO BE DISTRIBUTED TO OTHER",DIR("A",2)="PAYMENTS ON THE ERA.  YOU CANNOT SELECT ANY INDIVIDUAL BATCHES UNTIL",DIR("A",3)="THE DISTRIBUTIONS ARE COMPLETE."
 . S DIR("A")="Press ENTER to continue: ",DIR(0)="EA" W ! D ^DIR K DIR
 S RCINUSE=+$O(^RCY(344.49,"AINUSE",1,RCERA,0))
 I RCINUSE D
 . N OK,Z
 . Q:RCADJ!$P(RC0,U,8)
 . S OK=0 S Z=0 F  S Z=$O(^RCY(344.49,RCERA,3,Z)) Q:'Z  I '$P($G(^RCY(344.49,RCERA,3,Z,0)),U,5) S OK=1 Q
 . I 'OK D  Q
 .. S DIR("A",1)="ALL BATCHES WITHIN THIS ERA ARE CURRENTLY IN USE - TRY AGAIN LATER",DIR("A")="Press ENTER to continue: ",DIR(0)="EA" W ! D ^DIR K DIR S RCQUIT=1,RCOK=0 Q
 . W !!,"AT LEAST 1 BATCH WITHIN THIS ERA IS CURRENTLY IN USE",!,"AT THIS TIME, YOU CAN ONLY ACCESS INDIVIDUAL BATCHES",!
 . D SELBAT^RCDPEWL8(RCERA,.RCQUIT)
 . I RCQUIT S RCOK=0
 E  D
 . Q:$P(RC0,U,8)!RCADJ  ; Always require the entire ERA be used
 . S DIR(0)="SA^E:(E)NTIRE ERA;B:(B)ATCH",DIR("A")="DO YOU WANT THE (E)NTIRE ERA OR JUST A (B)ATCH?: " W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1,RCOK=0 Q
 . I Y="E" D  Q
 .. S RCQUIT=1 F Z=1:1:2 L +^RCY(344.4,RCERA,0):5 I $T S RCQUIT=0 Q
 .. I RCQUIT S RCOK=0,DIR(0)="EA",DIR("A",1)="ANOTHER USER IS CURRENTLY USING THIS ERA, TRY AGAIN LATER",DIR("A")="Press ENTER to continue: " W ! D ^DIR K DIR Q
 . D SELBAT^RCDPEWL8(RCERA,.RCQUIT)
 . I RCQUIT S RCOK=0
 ;
BATQ Q RCOK
 ;
PAYTYPE(IEN,TYPE) ; EP - New way to tell if a payer is pharamcy, Tricare or medical - Added for PRCA*4.5*321
 ; Input: IEN - Internal entry number of an ERA (#344.4)
 ;        TYPE="P" - Pharmacy, "T" - Tricare, "M" - Medical
 ;        ("M" is neither pharmacy nor Tricare)
 ; Return: 1 - Payer on ERA matches the TYPE
 ;         0 - Payer on ERA does not match the type. Or can't find payer.
 ;
 N FLAG,RETURN
 S RETURN=0
 I '$$PAYFLAGS(IEN,.FLAG) Q 0
 I TYPE="P",FLAG("P") S RETURN=1
 I TYPE="T",FLAG("T") S RETURN=1
 I TYPE="M",'FLAG("P"),'FLAG("T") S RETURN=1
 Q RETURN
 ;
PAYFLAGS(IEN,FLAG) ; EP - Return the pharmacy and tricare flags for an ERA
 ; Input: IEN - Internal entry number of an ERA (#344.4)
 ; Return: 1 - Payer found
 ;         0 - Can't find payer.
 ; Variable FLAG passed by reference to return values of the pharmacy and Tricare flags.
 ;
 N RCINS,RCPAYIEN,RCTIN,X
 S RCTIN=$$GET1^DIQ(344.4,IEN_",",.03)
 I RCTIN="" Q 0
 S RCINS=$$GET1^DIQ(344.4,IEN_",",.06)
 I RCINS="" Q 0
 ;
 ; Find a payer that matches both TIN and PAYER NAME from the ERA
 S RCPAYIEN=""
 S X=0
 F  S X=$O(^RCY(344.6,"C",RCTIN_" ",X)) Q:'X  D  Q:RCPAYIEN  ;
 . N PAYNAME
 . S PAYNAME=$$GET1^DIQ(344.6,X_",",.01)
 . I PAYNAME=RCINS S RCPAYIEN=X
 I 'RCPAYIEN Q 0
 ;
 S FLAG("P")=+$$GET1^DIQ(344.6,RCPAYIEN_",",.09,"I")
 S FLAG("T")=+$$GET1^DIQ(344.6,RCPAYIEN_",",.1,"I")
 Q 1
 ;
 ; BEGIN PRCA*4.5*326
HELP ; list manager help
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF
 W !,"ePay Electronic Remittance Advice Status"
 W !!,"The following ERA Status indicators may appear to the left of ERA number:",!
 ;
 W !," '-' = No scratchpad."
 W !," 'x' = EXC exceptions exist."
 W !," 'c' = No-pay ERA with auto-decrease CARCs."
 W !," 'A' = Auto-post complete."
 W !," 'P' = Auto-post partially completed."
 W !," 'M' = Marked for Auto-post, waiting processing."
 D PAUSE^VALM1
 Q
 ; Following FILTER code moved from RCDPEWL0 due to routine size
FILTER(IEN344P4) ; Returns 1 if record in entry IEN344P4 in 344.4 passes
 ; the edits for the worklist selection of ERAs
 ; Parameters found in ^TMP("RCERA_PARAMS",$J)
 N OK,RCPOST,RCAPST,RCAPSTA,RCAUTOP,RCMATCH,RCTYPE,RCDFR,RCDTO,RCPAYFR,RCPAYMNT,RCPAYTO,RCPAYR,RC0,RC4
 S OK=1,RC0=$G(^RCY(344.4,IEN344P4,0)),RC4=$G(^RCY(344.4,IEN344P4,4))
 ;
 S RCMATCH=$G(^TMP("RCERA_PARAMS",$J,"RCMATCH")),RCPOST=$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))
 S RCAUTOP=$G(^TMP("RCERA_PARAMS",$J,"RCAUTOP")),RCTYPE=$G(^TMP("RCERA_PARAMS",$J,"RCTYPE"))
 S RCDFR=+$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U),RCDTO=+$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U,2)
 S RCPAYR=$P($G(^TMP("RCERA_PARAMS",$J,"RCPAYR")),U),RCPAYFR=$P($G(^TMP("RCERA_PARAMS",$J,"RCPAYR")),U,2),RCPAYTO=$P($G(^TMP("RCERA_PARAMS",$J,"RCPAYR")),U,3)
 S RCPAYMNT=$G(^TMP("RCERA_PARAMS",$J,"RCPAYMNT"))    ; PRCA*4.5*321
 S RCAPSTA=$G(^TMP("RCERA_PARAMS",$J,"RCAPSTA"))
 ;
 ; Post status
 I $S(RCPOST="B":0,RCPOST="U":$P(RC0,U,14),1:'$P(RC0,U,14)) S OK=0 G FQ
 ; Auto-Posting status
 I $S(RCAUTOP="B":0,RCAUTOP="A":($P(RC4,U,2)=""),1:($P(RC4,U,2)'="")) S OK=0 G FQ
 ; If ERA is autopost and filtering on selected Autopost statuses check status
 I $P(RC4,U,2)'="",RCAPSTA'="A",(RCAUTOP="B")!(RCAUTOP="A") D  G:OK=0 FQ
 .;Auto-post Status
 .S RCAPST=$$GET1^DIQ(344.4,IEN344P4_",",4.02,"I")
 .;Complete filter
 .I RCAPSTA="C" S:RCAPST'=2 OK=0 G FQ
 .;Partial filter
 .I RCAPSTA="P" S:RCAPST'=1 OK=0 G FQ
 .;Marked for Auto-post filter - ignores if not partial post or unposted
 .I RCAPSTA="M",RCAPST'=1,RCAPST'=0 S OK=0 G FQ
 .;Marked for Auto-post filter - ignores PARTIAL auto-post era if no lines on ERA are marked
 .I RCAPSTA="M",RCAPST=1,'$O(^RCY(344.4,"AP",1,IEN344P4,"")) S OK=0 G FQ
 .;Marked for Auto-post filter - ignores UNPROCESSED auto-post era if no marked for autopost user 
 .I RCAPSTA="M",RCAPST=0,$$GET1^DIQ(344.4,IEN344P4_",",4.04,"I")="" S OK=0 G FQ
 ; Match status
 I $S(RCMATCH="B":0,RCMATCH="N":$P(RC0,U,9),1:'$P(RC0,U,9)) S OK=0 G FQ
 ; Medical/Pharmacy/Tricare Claim
 ; I $S(RCTYPE="B":0,RCTYPE="M":$$PHARM^RCDPEWLP(IEN344P4),1:'$$PHARM^RCDPEWLP(IEN344P4)) S OK=0 G FQ
 I RCTYPE'="A" D  I 'OK G FQ
 . N RCFLAG
 . I '$$PAYFLAGS^RCDPEWL7(IEN344P4,.RCFLAG) S OK=0 Q
 . I RCTYPE="P",'RCFLAG("P") S OK=0 Q
 . I RCTYPE="T",'RCFLAG("T") S OK=0 Q
 . I RCTYPE="M",(RCFLAG("P")!RCFLAG("T")) S OK=0
 ; dt rec'd range
 I $S(RCDFR=0:0,1:$P(RC0,U,7)\1<RCDFR) S OK=0 G FQ
 I $S(RCDTO=DT:0,1:$P(RC0,U,7)\1>RCDTO) S OK=0 G FQ
 ; Payer name
 I RCPAYR'="A" D  G:'OK FQ
 . N Q
 . S Q=$$UP^RCDPEARL($P(RC0,U,6))
 . I $S(Q=RCPAYFR:1,Q=RCPAYTO:1,Q]RCPAYFR:RCPAYTO]Q,1:0) Q
 . S OK=0
 ; PRCA*4.5*321 - Start modified code block
 ; Zero amount or payment
 I RCPAYMNT'="B" D  ;
 . I RCPAYMNT="Z",$P(RC0,U,5) S OK=0 Q
 . I RCPAYMNT="P",'$P(RC0,U,5) S OK=0
 ; PRCA*4.5*321 - End modified code block
 ;
FQ Q OK
 ; END PRCA*4.5*326
