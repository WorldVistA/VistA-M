IBTOLR ;ALB/AAS/BGA - LIST CLAIMS TRACKING LIST ENTRIES BEING TRACKED; 04-NOV-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% ;
 ; -- fileman print of random sample cases, etc.
 W !!,"Print List of Visits Requiring Review",!!
 ;
 W !!,"You will need a 132 column printer for this report!",!!
 D SORT G:$G(IBQUIT) END
 D ADM G:$G(IBQUIT) END
 D ASK G:$G(IBQUIT) END
 S DIC="^IBT(356,",FLDS="[IBT LIST VISITS]",BY="[IBT LIST VISITS]"
 ;
 I $G(IBSORT)="H" S DIS(0)="N IBTRND S IBTRND=$G(^IBT(356,D0,0)) I $P(IBTRND,U,20) I $P(IBTRND,U,25)!($P(IBTRND,U,26))!($P(IBTRND,U,27))"
 I $G(IBSORT)="I" S DIS(0)="N IBTRND S IBTRND=$G(^IBT(356,D0,0)) I $P(IBTRND,U,20),$P(IBTRND,U,24)"
 I $G(IBSORT)="B" S DIS(0)="N IBTRND S IBTRND=$G(^IBT(356,D0,0)) I $P(IBTRND,U,20) I $P(IBTRND,U,24)!($P(IBTRND,U,25))!($P(IBTRND,U,26))!($P(IBTRND,U,27))"
 ;
 I $G(IBADM) S DIS(1)="I $P($G(^IBE(356.6,+$P($G(^IBT(356,D0,0)),U,18),0)),U,3)=1"
 ;
 ;
 S IBCNT=0 F I=24:1:27 S IBCNT(I)=0 ;initialize count variable
 S DHIT="D SUB^IBTOLR"
 S DIOEND="D FNL^IBTOLR"
 S DHD="LIST OF VISITS FROM "_IBFR_" TO: "_IBTO_" REQUIRING REVIEWS"
 D EN1^DIP
 W !
 ;
END I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K D,I,J,X,Y,DIC,FLDS,BY,TO,FR,DIS,IBSORT,IBQUIT,IBCNT,IBHIT,DIOEND
 K IBFR,IBTO
 Q
 ;
SORT ; -- ask how they want it sorted
 N DIR
 S DIR(0)="SOBA^H:HOSPITAL REVIEWS;I:INSURANCE REVIEWS;B:BOTH"
 S DIR("A")="Include [H]ospital Reviews  [I]nsurance Reviews  [B]oth: "
 S DIR("B")="B"
 S DIR("?",1)="This report will list visits that are currently indicate that reviews"
 S DIR("?",2)="are required.  Indicate if you want visits that require Hospital Reviews, Insurance Reviews or Both"
 S DIR("?",3)=" ",DIR("?")="The default is Both."
 D ^DIR K DIR
 S IBSORT=Y I "HIB"'[Y!($D(DIRUT)) S IBQUIT=1 Q
 W !
 Q
 ;
ADM S DIR(0)="Y",DIR("A")="List Admissions Only",DIR("B")="YES"
 S DIR("?")="Answer Yes if you only want admissions listed, answer No if you want all visit types (outpatient, prescription, etc) listed"
 D ^DIR K DIR
 S IBADM=Y I $D(DIRUT) S IBQUIT=1
 Q
 ;
ASK N IBBDT,IBEDT
 D DATE^IBOUTL
 I (IBBDT<1)!(IBEDT<1) S IBQUIT=1 Q
 S FR=IBBDT_",?",TO=IBEDT_",?"
 S IBFR=$$DAT1^IBOUTL(IBBDT),IBTO=$$DAT1^IBOUTL(IBEDT)
 Q
 ;
SUB ; -- do subcount
 N IBX,IBI
 S IBX=$G(^IBT(356,D0,0))
 F IBI=24:1:27 I $P(IBX,"^",IBI) S IBCNT(IBI)=IBCNT(IBI)+1
 S IBCNT=IBCNT+1
 Q
 ;
FNL ; -- print sub counts
 Q:'IBCNT
 N IBPLUS
 I $G(IOM)<81 S IBPLUS=4
 W !?72,"----",?77," ---",?(86+$G(IBPLUS)),"----",?(94+$G(IBPLUS))," ---"
 W !,"COUNT",?72,$J(IBCNT(24),4),?77,$J(IBCNT(25),4),?(86+$G(IBPLUS)),$J(+IBCNT(26),4),?(94+$G(IBPLUS)),$J(+IBCNT(27),4)
 Q
