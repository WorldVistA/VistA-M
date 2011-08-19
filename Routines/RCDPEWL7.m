RCDPEWL7 ;ALB/TMK - EDI LOCKBOX WORKLIST ERA DISPLAY SCREEN ;16-JAN-04
 ;;4.5;Accounts Receivable;**208,222**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
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
 N FIRST,RCZ,RC0,RCEFT,RCSTAT,RCPOST,X,Z,Z0
 S RCZ=0 F  S RCZ=$O(^TMP($J,"RCERA_LIST",RCSRT1,RCSRT2,RCZ)) Q:'RCZ  D
 . S RCT=RCT+1,RC0=$G(^RCY(344.4,RCZ,0))
 . S RCEFT=+$O(^RCY(344.31,"AERA",RCZ,0))
 . S RCSTAT=$S('RCEFT:U_$S($P(RC0,U,15)="CHK":"(CHECK PAYMENT EXPECTED)",$P(RC0,U,15)="NON":"(NO PAYMENT EXPECTED)",$P(RC0,U,9)=2:"(CHECK PAYMENT CHOSEN)",1:"N/A"),1:$$FMSSTAT^RCDPUREC(+$P($G(^RCY(344.31,RCEFT,0)),U,9)))
 . S RCPOST=$S(RCEFT:"EFT RECEIPT STATUS: ",1:"")_$P(RCSTAT,U,2)
 . S X=$E(RCT_$J("",4),1,4)_$S($D(^RCY(344.49,RCZ)):" ",1:"-")_$E($P(RC0,U)_$J("",5),1,5)_"  "_$E($P(RC0,U,2)_$J("",30),1,30)_"  "_$J($$FMTE^XLFDT($P(RC0,U,7),"2D"),8)_$J("",5)_$J(+$P(RC0,U,5),12,2)
 . S $E(X,73,80)=$$FMTE^XLFDT($P(RC0,U,7),"2D")
 . D SET(X,RCT,RCZ)
 . S X=$J("",12)_$E($P(RC0,U,6)_$J("",30),1,30)_"  APPROX # EEOBs: "_+$$CTEEOB^RCDPEWLB(RCZ)
 . D SET(X,RCT,RCZ)
 . S X=$J("",12)_$E($$EXTERNAL^DILFD(344.4,.09,"",$P(RC0,U,9))_$J("",30),1,30)_"  "_RCPOST
 . D SET(X,RCT)
 . I $G(^TMP("RCERA_PARAMS",$J,"BATCHON")) D
 .. S Z=0 F  S Z=$O(^RCY(344.49,RCZ,3,Z)) Q:'Z  S Z0=$G(^(Z,0)) I Z0'="" D
 ... S X=$J("",12)_$E("- BATCH #"_$P(Z0,U)_$J("",4),1,13)_" "_$E($P(Z0,U,2)_$J("",30),1,30)_"  "_$S('$P(Z0,U,3):"NOT ",1:"")_"READY TO POST"
 ... D SET(X,RCT)
 . D SET(" ",RCT)
 S VALMSG="'-' Before the ERA # indicates no scratchpad entry yet"
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
 . S DAT=$$UPPER($P(RC0,U,6))
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
 N RCZ,RC0,RCT,RCTT,RCQUIT,RCDTFR,RCDTTO,DTOUT,DUOUT,DIR,X,Y,Z,Z1,RCPOST,RCEFT,RCINDX
 D CLEAN^VALM10
 K ^TMP("RCDPE-ERA_WL",$J),^TMP("RCDPE-ERA_WLDX",$J),^TMP($J,"RCERA_LIST")
 ;
 S (RCT,RCTT,RCQUIT)=0
 ;
 S RCDTFR=+$P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U),RCDTTO=$S($P($G(^TMP("RCERA_PARAMS",$J,"RCDT")),U,2):$P(^("RCDT"),U,2),1:DT)
 ;
 S RCINDX=$S(RCDTFR:RCDTFR-.00000001,1:0)
 F  S RCINDX=$O(^RCY(344.4,"AFD",RCINDX)) Q:'RCINDX!(RCINDX\1>RCDTTO)!RCQUIT  S RCZ=0 F  S RCZ=$O(^RCY(344.4,"AFD",RCINDX,RCZ)) Q:'RCZ  D  Q:RCQUIT
 . ;
 . S RCTT=RCTT+1 I '(RCTT#5000) D  Q:RCQUIT
 .. S DIR("A",1)=RCTT_" ERA RECORDS HAVE ALREADY BEEN SEARCHED USING YOUR CRITERIA",DIR("A",2)="LAST DATE SEARCHED WAS "_$$FMTE^XLFDT(RCINDX,"2D"),DIR("A")="DO YOU WANT TO CONTINUE THIS SEARCH?: "
 .. S DIR("B")="NO",DIR("?")="RESPOND NO HERE AND RESTART TO SELECT A DATE RANGE TO LIMIT THE SEARCH",DIR(0)="YA" W ! D ^DIR K DIR
 .. I Y=1!$D(DTOUT) W !,$S($D(DTOUT):"TIME OUT - ",1:""),"SEARCH CONTINUED",! Q
 .. I $D(DUOUT)!(Y=0) S RCQUIT=1 Q
 . ;
 . S RC0=$G(^RCY(344.4,RCZ,0))
 . I $$FILTER^RCDPEWL0(RCZ) S ^TMP($J,"RCERA_LIST",$$SL(RCZ,"DR"),$$SL(RCZ,""),RCZ)=""
 ;
 ; Output the list
 I 'RCQUIT D
 . D:$D(^TMP($J,"RCERA_LIST")) BLD("DR^N")
 . I '$O(^TMP("RCDPE-ERA_WL",$J,0)) D
 .. S DIR(0)="EA",DIR("A",1)="THERE ARE NO ERAs MATCHING YOUR SELECTION CRITERIA",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR S RCQUIT=1
 I RCQUIT K ^TMP("RCDPE-ERA_WL",$J),^TMP("RCDPE-ERA_WLDX",$J),^TMP($J,"RCERA_LIST") S VALMQUIT=""
 Q
 ;
HDR ; Header for ERA list
 N X
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCMATCH"))
 S VALMHDR(1)=$E("SELECTED:  MATCH STATUS: "_$S(X="N":"NOT MATCHED",X="M":"MATCHED",1:"BOTH")_$J("",38),1,38)
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCPOST"))
 S VALMHDR(1)=VALMHDR(1)_"  POST STATUS: "_$S(X="U":"UNPOSTED",X="P":"POSTED",1:"BOTH")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCDT"))
 S VALMHDR(2)=$J("",11)_"DATE RANGE  : "_$S($P(X,U):$$FMTE^XLFDT($P(X,U),2)_$S($P(X,U,2):"-"_$$FMTE^XLFDT($P(X,U,2),2),1:""),1:"NONE SELECTED")
 S X=$G(^TMP("RCERA_PARAMS",$J,"RCPAYR"))
 S VALMHDR(3)=$J("",11)_$S($P(X,U)="A"!(X=""):"ALL PAYERS",1:"PAYERS: "_$P(X,U,2)_"-"_$P(X,U,3))
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
 ; RCERA = ien of the ERA entry in file 344.4
 N RC0,RCNOED,RCQUIT,RCSORT,DA,DIE,X,Y,DR,DIR,DTOUT,DUOUT
 Q:RCERA'>0
 S (RCQUIT,RCNOED)=0,RC0=$G(^RCY(344.4,RCERA,0)),RCSORT=""
 I $P(RC0,U,8) D
 . I '$D(^RCY(344.49,RCERA,0)) D  Q
 .. S RCQUIT=1
 .. W ! S DIR(0)="EA",DIR("A",1)="A SCRATCH PAD WAS NOT CREATED FOR THIS ERA BEFORE POSTING",DIR("A",2)="USE THE VIEW/PRINT ERA OPTION TO SEE ITS DETAIL",DIR("A")="PRESS RETURN TO CONTINUE: " D ^DIR K DIR Q
 . ;
 . S RCNOED=+$P(RC0,U,8)
 . S DIR(0)="EA",DIR("A",1)="THIS ERA ALREADY HAS A RECEIPT - YOU MAY ONLY VIEW ITS SCRATCH PAD",DIR("A")="PRESS RETURN TO CONTINUE "
 . W ! D ^DIR K DIR W !
 I 'RCQUIT D
 . N RCQUIT
 . D DISP^RCDPEWL(RCERA,RCNOED)
 ;
 I 'RCQUIT,$G(^TMP("RCBATCH_SELECTED",$J)) D
 . S DA(1)=RCERA,DA=+$G(^TMP("RCBATCH_SELECTED",$J)),DR=".05////0",DIE="^RCY(344.49,"_DA(1)_",3," D ^DIE
 . L -^RCY(344.49,DA(1),3,DA,0)
 . K ^TMP("RCBATCH_SELECTED",$J)
 E  D
 . L -^RCY(344.4,RCERA,0)
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
 . S DIR("A")="PRESS RETURN TO CONTINUE: ",DIR(0)="EA" W ! D ^DIR K DIR
 S RCINUSE=+$O(^RCY(344.49,"AINUSE",1,RCERA,0))
 I RCINUSE D
 . N OK,Z
 . Q:RCADJ!$P(RC0,U,8)
 . S OK=0 S Z=0 F  S Z=$O(^RCY(344.49,RCERA,3,Z)) Q:'Z  I '$P($G(^RCY(344.49,RCERA,3,Z,0)),U,5) S OK=1 Q
 . I 'OK D  Q
 .. S DIR("A",1)="ALL BATCHES WITHIN THIS ERA ARE CURRENTLY IN USE - TRY AGAIN LATER",DIR("A")="PRESS RETURN TO CONTINUE ",DIR(0)="EA" W ! D ^DIR K DIR S RCQUIT=1,RCOK=0 Q
 . W !!,"AT LEAST 1 BATCH WITHIN THIS ERA IS CURRENTLY IN USE",!,"AT THIS TIME, YOU CAN ONLY ACCESS INDIVIDUAL BATCHES",!
 . D SELBAT^RCDPEWL8(RCERA,.RCQUIT)
 . I RCQUIT S RCOK=0
 E  D
 . Q:$P(RC0,U,8)!RCADJ  ; Always require the entire ERA be used
 . S DIR(0)="SA^E:(E)NTIRE ERA;B:(B)ATCH",DIR("A")="DO YOU WANT THE (E)NTIRE ERA OR JUST A (B)ATCH?: " W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1,RCOK=0 Q
 . I Y="E" D  Q
 .. S RCQUIT=1 F Z=1:1:2 L +^RCY(344.4,RCERA,0):5 I $T S RCQUIT=0 Q
 .. I RCQUIT S RCOK=0,DIR(0)="EA",DIR("A",1)="ANOTHER USER IS CURRENTLY USING THIS ERA, TRY AGAIN LATER",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR Q
 . D SELBAT^RCDPEWL8(RCERA,.RCQUIT)
 . I RCQUIT S RCOK=0
 ;
BATQ Q RCOK
 ;
UPPER(X) ; Function returns X as all upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
