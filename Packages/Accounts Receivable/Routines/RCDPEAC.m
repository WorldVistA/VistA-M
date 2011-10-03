RCDPEAC ;ALB/TMK - ACTIVE BILLS WITH EEOB ON FILE ;27-JAN-2004
 ;;4.5;Accounts Receivable;**208**;Mar 20, 1995
 ;
EN ; Entrypoint for producing the report
 N RCSORT,RCINS,ZTRTN,ZTDESC,ZTSAVE,ZTSK,%ZIS,POP
 Q:'$$SELECT(.RCINS,.RCSORT)
 W !
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="ENQ^RCDPEAC",ZTDESC="AR - ACTIVE BILLS WITH EEOB REPORT",ZTSAVE("RCINS")="",ZTSAVE("RCSORT")="",ZTSAVE("RCINS(")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
ENQ ; Queued entrypoint for the report
 ; RCSORT and array RCINS must exist
 ; RCINS = "A" for all ins co, "R" for range, "S" for selected individual
 ;         for RCINS="R"  ("FR")=from payer name and ("TR")=to payer name
 ;         for RCINS="S"  ("S",INS CO IEN IN FILE 36)=""
 ; RCSORT = "PN" for sort by patient name followed by ;- if reverse order
 ;          "L4" for sort by patient SSN followed by ;- if reverse order
 ;
 N Z,Z0,RCACT,RCBILL,RCEOB,RCTOT,RCSTOP,RCNEW,RCZ,RCZ0
 K ^TMP($J,"RCSORT")
 S RCACT=+$O(^PRCA(430.3,"AC",102,0)) ; Get active status ien
 G:'RCACT ENOUT
 ;
 S RCBILL=0
 F  S RCBILL=$O(^PRCA(430,"AC",RCACT,RCBILL)) Q:RCBILL=""  I +$G(^PRCA(430,RCBILL,7))>0,$$INCLUDE(.RCINS,RCBILL),$$EEOB(RCBILL,.RCEOB) D
 . S (RCTOT,RCEOB)=0 F  S RCEOB=$O(RCEOB(RCEOB)) Q:'RCEOB  S RCTOT=RCTOT+$G(^IBM(361.1,RCEOB,1)),^TMP($J,"RCSORT",$$INSNM(RCBILL),$$SL1(RCSORT,RCBILL),RCBILL,+RCEOB(RCEOB),RCEOB)=""
 . I $O(RCEOB(0)) S ^TMP($J,"RCSORT",$$INSNM(RCBILL),$$SL1(RCSORT,RCBILL),RCBILL)=RCTOT
 ;
 S RCZ="",(RCPG,RCSTOP,RCNEW)=0
 F  S RCZ=$O(^TMP($J,"RCSORT",RCZ)) Q:RCZ=""!RCSTOP  S RCZ0="" S:$G(RCINS)="R"!($G(RCINS)="S") RCNEW=1 D
 . I RCSORT'["-" D
 .. S RCZ0="" F  S RCZ0=$O(^TMP($J,"RCSORT",RCZ,RCZ0)) Q:RCZ0=""!RCSTOP  D OUTPUT(RCZ,RCZ0,RCSORT,.RCSTOP,.RCINS,.RCPG,RCNEW) S RCNEW=0
 . I RCSORT["-" D
 .. S RCZ0="" F  S RCZ0=$O(^TMP($J,"RCSORT",RCZ,RCZ0),-1) Q:RCZ0=""!RCSTOP  D OUTPUT(RCZ,RCZ0,RCSORT,.RCSTOP,.RCINS,.RCPG,.RCNEW) S RCNEW=0
 ;
 I 'RCSTOP,RCPG D ASK(.RCSTOP)
 ;
ENOUT I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCSORT")
 Q
 ;
OUTPUT(RCZ,RCZ0,RCSORT,RCSTOP,RCINS,RCPG,RCNEW) ; Output the data
 ; RCZ, RCZ0 are the first 2 sort levels for the array
 ; RCINS = insurance co info array
 ; RCSTOP passed by ref - returned if user chooses to stop
 ; RCNEW = 1 if the header should be forced to print
 N RCZ1,RCBILL,RC399,RCPT,RC430,RC0,RCEOB,X,Y
 S RCBILL=0 F  S RCBILL=$O(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL)) Q:'RCBILL!RCSTOP  S RCZ1="" F  S RCZ1=$O(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL,RCZ1)) Q:RCZ1=""!RCSTOP  D
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W !!,"***TASK STOPPED BY USER***" Q
 . S RCSTOP=$$NEWPG(.RCPG,.RCINS,RCNEW) S RCNEW=0
 . Q:RCSTOP
 . S RC399=$G(^DGCR(399,RCBILL,0)),RCPT=+$P(RC399,U,2),RC430=$G(^PRCA(430,RCBILL,0))
 . S RCSTOP=$$NEWPG(.RCPG,.RCINS,RCNEW) Q:RCSTOP
 . S X=$$GET1^DIQ(430,RCBILL_",",11)
 . W !,$E($P(RC399,U)_$J("",8),1,8)_"  "_$E($P($G(^DPT(RCPT,0)),U)_$J("",25),1,25)_"  "_$E($P($G(^DPT(RCPT,0)),U,9)_$J("",10),1,10)_"  ",$E($$INSNM(RCBILL)_$J("",30),1,30)
 . W !,$J("",8)_$E($J(+$P(RC430,U,3),"",2)_$J("",13),1,13)_"  "_$E($J(+$G(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL)),"",2)_$J("",13),1,13)_"  "_$E($J(+X,"",2)_$J("",12),1,12)
 . I $P($G(^PRCA(430,RCBILL,6)),U,4) W "  "_$$FMTE^XLFDT($P(^PRCA(430,RCBILL,6),U,4),2)
 . S RCEOB=0 F  S RCEOB=$O(^TMP($J,"RCSORT",RCZ,RCZ0,RCBILL,RCZ1,RCEOB)) Q:'RCEOB!RCSTOP  D
 .. S RCSTOP=$$NEWPG(.RCPG,.RCINS,RCNEW)
 .. Q:RCSTOP
 .. S RC0=$G(^IBM(361.1,RCEOB,0))
 .. S RCSTOP=$$NEWPG(.RCPG,.RCINS,RCNEW) Q:RCSTOP
 .. W !,?10,$E($P(RC0,U,7)_$J("",27),1,27)_"  "_$E($$FMTE^XLFDT($P(RC0,U,5),"2D")_$J("",8),1,8)_" "_$E($$FMTE^XLFDT($P(RC0,U,6),"2D")_$J("",8),1,8)_" "_$E($S(RCZ1:$$FMTE^XLFDT(RCZ1,"2D"),1:"")_$J("",8),1,8)
 .. W " "_$J(+$G(^IBM(361.1,RCEOB,1)),"",2)
 ;
 Q
 ;
INCLUDE(RCINS,RCZ) ; Function returns 1 if record should be included based
 ; on ins co
 ; RCINS = array containing insurance co information
 ; RCZ = ien of the entry in file 430
 N OK,RCI,RCINM
 S OK=0
 S RCI=+$$INS(RCZ)
 ;
 I 'RCI G INCQ ; Not a third party bill
 ;
 I RCINS="A" S OK=1
 ;
 I RCINS="S"!(RCINS="R") D
 . I RCINS="S" S:$D(RCINS("S",RCI)) OK=1 Q
 . S RCINM=$$INSNM(RCZ) ; INS CO NAME
 . I $S(RCINM=RCINS("FR")!(RCINM]RCINS("FR")):RCINM']RCINS("TO"),1:0) S OK=1
 ;
INCQ Q OK
 ;
INSNM(RCZ) ; Returns the name of the insurance co for bill ien RCZ file 430
 N NM
 S NM=$P($G(^DIC(36,+$$INS(RCZ),0)),U)
 Q NM
 ;
INS(RCZ) ; Returns ien of insurance co for bill ien RCZ from file 430
 N RC
 S RC=$P($G(^PRCA(430,RCZ,0)),U,9) ;DEBTOR
 Q $S($P($G(^RCD(340,+RC,0)),U)'["DIC(36":"",1:+^(0))
 ;
NEWPG(RCPG,RCINS,RCNEW) ; Check for new page needed, output header
 ; RCINS = ins co selection criteria
 ; RCNEW = 1 to force new page
 ; Function returns 1 if user chooses to stop output
 I RCNEW!'RCPG!(($Y+5)>IOSL) D
 . D:RCPG ASK(.RCSTOP) I RCSTOP Q
 . D HDR(.RCPG,.RCINS)
 Q RCSTOP
 ;
EEOB(RCZ,RCEOB) ; Find all non-MRA  EEOBs for bill ien RCZ
 ; Function returns 1 if any valid EEOBs found, 0 if none
 ; RCEOB(eob ien)=date posted returned for valid EEOBs found -
 ;                pass by reference
 N OK,Z
 K RCEOB
 ;
 S OK=0
 S Z=0 F  S Z=$O(^IBM(361.1,"B",RCZ,Z)) Q:'Z  I $P($G(^IBM(361.1,Z,0)),U,4)'=1 D
 . N Z0,Z1,Z00
 . S Z0=+$O(^RCY(344.4,"ADET",Z,0)) ; ERA entry received in
 . S Z1=+$P($G(^RCY(344.4,Z0,0)),U,8) ; Receipt
 . S Z00=$P($G(^RCY(344.4,Z0,0)),U,14)
 . I Z1,$S(Z00=1!(Z00=2):1,1:0) S RCEOB(Z)=+$P($G(^RCY(344,Z1,0)),U,8),OK=1
 ;
 Q OK
 ;
SL1(RCSORT,RCZ) ; Function returns 1st sort level data from ien RCZ in file 430
 ; RCSORT = "PN" for patient name sort = "L4" for SSN last 4 sort
 N DAT
 I RCSORT="PN" S DAT=$P($G(^DPT(+$P($G(^PRCA(430,RCZ,0)),U,7),0)),U)
 I RCSORT="L4" S DAT=$P($G(^DPT(+$P($G(^PRCA(430,RCZ,0)),U,7),0)),U,9),DAT=$E(DAT,$L(DAT)-3,$L(DAT))
 Q $S($G(DAT)'="":DAT,1:" ")
 ;
SELECT(RCINS,RCSORT) ; Select insurance co and sort criteria
 ; Function returns values selected for RCSORT and RCINS - passed by ref
 N RCQUIT,DONE,DIR,X,Y
 S (RCQUIT,DONE)=0
 S DIR(0)="SA^A:ALL;S:SPECIFIC;R:RANGE",DIR("A")="RUN REPORT FOR (A)LL, (S)PECIFIC, OR (R)ANGE OF INSURANCE COMPANIES?: ",DIR("B")="ALL" W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 ;
 S RCINS=Y
 I RCINS="S" D  G:RCQUIT SELQ
 . W !
 . F  D LIST(.DIR,.RCINS) S DIR("A")="SELECT "_$S($O(RCINS("S",0)):"ANOTHER ",1:"")_"INSURANCE COMPANY"_$S($O(RCINS("S",0)):" (PRESS RETURN WHEN DONE)",1:"")_": ",DIR(0)="PAO^DIC(36,:AEMQ" D ^DIR K DIR D  Q:Y'>0
 .. I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 .. I Y>0 S RCINS("S",+Y)=""
 . I '$O(RCINS("S",0)) S RCQUIT=1 W !!,"NO INSURANCE COMPANIES SELECTED - NO REPORT GENERATED" S DIR(0)="E" D ^DIR K DIR
 ;
 I RCINS="R" D  I RCQUIT W !!,"NO INSURANCE COMPANY NAME RANGE SELECTED - NO REPORT GENERATED" S DIR(0)="E" D ^DIR K DIR G SELQ
 . W !
 . S DIR("?")="ENTER 1-30 UPPERCASE CHARACTERS OF THE FIRST NAME TO INCLUDE"
 . S DIR(0)="FA^1:30^K:X'?.U X",DIR("A")="START WITH INSURANCE COMPANY NAME: " D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . S RCINS("FR")=Y
 . S DIR("?")="ENTER 1-30 UPPERCASE CHARACTERS OF THE LAST NAME TO INCLUDE"
 . S DIR(0)="FA^1:30^K:X'?.U X",DIR("A")="GO TO INSURANCE COMPANY NAME: ",DIR("B")=$E(RCINS("FR"),1,27)_"ZZZ"
 . F  W ! D ^DIR Q:$S($D(DTOUT)!$D(DUOUT):1,1:RCINS("FR")']Y)  W !,"'GO TO' NAME MUST COME AFTER 'START WITH' NAME"
 . K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . S RCINS("TO")=Y
 S DIR(0)="SA^P:PATIENT NAME;L:LAST 4 OF PATIENT SSN",DIR("A")="WITHIN INS CO, SORT BY (P)ATIENT NAME OR (L)AST 4 OF SSN?: ",DIR("B")="PATIENT NAME" W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 S RCSORT=$S(Y="P":"PN",1:"L4")
 S DIR(0)="SA^F:FIRST TO LAST;L:LAST TO FIRST",DIR("A")="SORT "_$S(RCSORT="PN":"PATIENT NAME",1:"LAST 4")_" (F)IRST TO LAST OR (L)AST TO FIRST?: ",DIR("B")="FIRST TO LAST" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SELQ
 I Y="L" S RCSORT=RCSORT_";-"
 S DONE=1
 ;
SELQ Q DONE
 ;
LIST(DIR,RCINS) ; Sets up help array for ins co selected in DIR("?")
 N CT,Z
 S CT=1
 I '$O(RCINS("S",0)) S DIR("?")="NO INSURANCE COMPANIES SELECTED" Q
 S DIR("?",1)="INSURANCE COMPANIES ALREADY SELECTED:"
 S Z=0 F  S Z=$O(RCINS("S",Z)) Q:'Z  S CT=CT+1,DIR("?",CT)="   "_$P($G(^DIC(36,Z,0)),U)
 S DIR("?")=" "
 Q
 ;
HDR(RCPG,RCINS) ;Print report hdr
 ; RCPG = last page #
 N Z,Z0,X
 I RCPG!($E(IOST,1,2)="C-") W @IOF,*13
 S RCPG=$G(RCPG)+1
 W !,?5,"EDI LOCKBOX ACTIVE BILLS W/EEOB REPORT",?55,$$FMTE^XLFDT(DT,2),?70,"Page: ",RCPG
 W !!,"INSURANCE SELECTED: "_$S(RCINS="A":"ALL",RCINS="R":"RANGE FROM "_RCINS("FR")_"-"_RCINS("TO"),1:"")
 S Z0=""
 I RCINS="S" S Z=0,Z0="" F  S Z=$O(RCINS("S",Z)) Q:'Z  S X=$P($G(^DIC(36,Z,0)),U) D
 . I $L(Z0)+$L(X)>79 W Z0 S Z0="" W !
 . S Z0=Z0_$S(Z0'="":",",1:"")_X
 I Z0'="" W Z0
 W !!,"BILL #    PATIENT NAME              SSN         INS CO NAME"
 W !,"        AMOUNT BILLED  AMOUNT PAID    BALANCE       DT REFERRED REG COUNSEL"
 W !!,?10,"TRACE #"_$J("",22)_"DT REC'D DT PAID  DT POST  AMOUNT PAID"
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
ASK(RCSTOP) ;
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;
