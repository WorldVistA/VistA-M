RCDPEWL7 ;ALB/TMK/KML - EDI LOCKBOX WORKLIST ERA DISPLAY SCREEN ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**208,222,269,276,298,304**;Mar 20, 1995;Build 104
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
 .. I $$FILTER^RCDPEWL0(RCZ) S ^TMP($J,"RCERA_LIST",$$SL(RCZ,$P(RCSORT,U)),$$SL(RCZ,$P(RCSORT,U,2)),RCZ)=""
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
 N AUTOCOMP,FIRST,RC0,RCEFT,RCEXCEP,RCPOST,RCSTAT,RCZ,X,Z,Z0
 S RCZ=0 F  S RCZ=$O(^TMP($J,"RCERA_LIST",RCSRT1,RCSRT2,RCZ)) Q:'RCZ  D
 . S RCT=RCT+1,RC0=$G(^RCY(344.4,RCZ,0))
 . S RCEFT=+$O(^RCY(344.31,"AERA",RCZ,0))
 . S RCEXCEP=$$XCEPT^RCDPEWLP(RCZ)  ; prca*4.5*298  assignment of ERA exception flag
 . S AUTOCOMP=$S($P($G(^RCY(344.4,RCZ,4)),U,2)=2:"A",1:"")   ;prca*4.5*298  AUTO-POSTED COMPLETE indicator ("A")
 . S RCSTAT=$S('RCEFT:U_$S($P(RC0,U,15)="CHK":"(CHECK PAYMENT EXPECTED)",$P(RC0,U,15)="NON":"(NO PAYMENT EXPECTED)",$P(RC0,U,9)=2:"(CHECK PAYMENT CHOSEN)",1:"N/A"),1:$$FMSSTAT^RCDPUREC(+$P($G(^RCY(344.31,RCEFT,0)),U,9)))
 . S RCPOST=$S(RCEFT:"EFT RECEIPT STATUS: ",1:"")_$P(RCSTAT,U,2)
 . ;prca*4.5*298 include Auto-Post Complete indicator and ERA exception flag in $SELECT statement
 . S X=$E(RCT_$J("",5),1,5)_"  "_$S(RCEXCEP]"":RCEXCEP,AUTOCOMP]"":AUTOCOMP,$D(^RCY(344.49,RCZ)):" ",1:"-")_$E($P(RC0,U)_$J("",10),1,10)_"  "_$E($P(RC0,U,2)_$J("",50),1,50)
 . D SET(X,RCT,RCZ)
 . S X=$J("",40)_$J($$FMTE^XLFDT($P(RC0,U,7),"2D"),8)_$J("",5)_$J(+$P(RC0,U,5),12,2)
 . S $E(X,73,80)=$$FMTE^XLFDT($P(RC0,U,7),"2D")
 . D SET(X,RCT,RCZ)
 . S X=$J("",12)_$E($P(RC0,U,6)_$J("",30),1,30)_"  APPROX # EEOBs: "_+$$CTEEOB^RCDPEWLB(RCZ)
 . D SET(X,RCT,RCZ)
 . S X=$J("",12)_$E($$EXTERNAL^DILFD(344.4,.09,"",$P(RC0,U,9))_$J("",30),1,30)_"  "_RCPOST
 . D SET(X,RCT)
 . D SET(" ",RCT)
 ;.; prca*4.5*298  per patch requirements, keep code related to
 ;. ; creating/maintaining batches but just remove from execution.
 ;. ;I $G(^TMP("RCERA_PARAMS",$J,"BATCHON")) D
 ;.. ;S Z=0 F  S Z=$O(^RCY(344.49,RCZ,3,Z)) Q:'Z  S Z0=$G(^(Z,0)) I Z0'="" D
 ;...; S X=$J("",12)_$E("- BATCH #"_$P(Z0,U)_$J("",4),1,13)_" "_$E($P(Z0,U,2)_$J("",30),1,30)_"  "_$S('$P(Z0,U,3):"NOT ",1:"")_"READY TO POST"
 ;... ;D SET(X,RCT)
 ;
 S VALMSG="|'-' No scratchpad|'x' EXC |'A' autopost complete"
 ;
 Q
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
 . I (RCTT#10000=0) D  Q:RCQUIT=1
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
 . I $$FILTER^RCDPEWL0(RCZ) S ^TMP($J,"RCERA_LIST",$$SL(RCZ,"DR"),$$SL(RCZ,""),RCZ)=""
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
 N X
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCMATCH"))
 S VALMHDR(1)="SELECTED MATCH STATUS: "_$S(X="N":"NOT MATCHED",X="M":"MATCHED",1:"BOTH")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))
 S $E(VALMHDR(1),42)="POST STATUS     : "_$S(X="U":"UNPOSTED",X="P":"POSTED",1:"BOTH")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCDT"))
 S VALMHDR(2)=$J("",11)_"DATE RANGE: "_$S($P(X,U):$$FMTE^XLFDT($P(X,U),2)_$S($P(X,U,2):"-"_$$FMTE^XLFDT($P(X,U,2),2),1:""),1:"NONE SELECTED")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCAUTOP"))
 S $E(VALMHDR(2),42)="AUTO-POSTING    : "_$S(X="A":"AUTO-POSTING ONLY",X="N":"NON AUTO-POSTING ONLY",1:"BOTH")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCPAYR"))
 S VALMHDR(3)=$J("",10)_$S($P(X,U)="A"!(X=""):"ALL PAYERS",1:"PAYERS: "_$P(X,U,2)_"-"_$P(X,U,3))
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCTYPE"))
 S $E(VALMHDR(3),42)="PHARMACY/MEDICAL: "_$S(X="M":"MEDICAL ONLY",X="P":"PHARMACY ONLY",1:"BOTH")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCERA_TRACE#"))
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
 S TYPE=$S($$PHARM^RCDPEWLP(RCERA):"P",1:"M"),RCEXC=0
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
 S RETCODES=$$AGEDEFTS^RCDPEWLP(RCERA,TYPE)
 F I=1:1 S STATE=$P(RETCODES,U,I) Q:STATE=""  S PREVENT=$S($E(STATE,1)=1:1,1:0)
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
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
