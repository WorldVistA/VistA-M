QAOSPPR0 ;HISC/DAD-PEER REVIEWER WORKSHEET ;2/16/93  09:31
 ;;3.0;Occurrence Screen;;09/14/1993
 S QAOSSCRN=+$G(^QA(741,QAOSD0,"SCRN")),QAOSPEER=$O(^QA(741.2,"C",2,0)),QAOSREVR=2,QAOSQUIT=0
 I QAOSDATA=1 S QAOSD1="" D LOOP1 W:$E(IOST)'="C" @IOF D  G EXIT
 . Q:$E(IOST)'="C"  Q:QAOSQUIT
 . K DIR S DIR(0)="E" D ^DIR K DIR
 . S QAOSQUIT=$S(Y'>0:1,1:0)
 . Q
 I QAOSDATA=2,'$D(^QA(741,QAOSD0,"REVR","B",QAOSPEER)) S QAOSD1="" D LOOP1 W:$E(IOST)'="C" @IOF D  G EXIT
 . Q:$E(IOST)'="C"  Q:QAOSQUIT
 . K DIR S DIR(0)="E" D ^DIR K DIR
 . S QAOSQUIT=$S(Y'>0:1,1:0)
 . Q
 F QAOSD1=0:0 S QAOSD1=$O(^QA(741,QAOSD0,"REVR","B",QAOSPEER,QAOSD1)) Q:QAOSD1'>0!QAOSQUIT  D LOOP1 W:$E(IOST)'="C" @IOF I ('QAOSQUIT),$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S QAOSQUIT=$S(Y'>0:1,1:0) Q:QAOSQUIT
EXIT ;
 K ARRAY,D0,DIWF,DIWL,DIWR,LOC,QA,QAOSD1,QAOSHEAD,QAOSMULT,QAOSPAGE,QAOSREVR,QAOSSCRN,QAOSPEER,X,XX,Y
 Q
LOOP1 ;
 S QAOSMULT=$S(QAOSD1'>0:"",$D(^QA(741,QAOSD0,"REVR",QAOSD1,0))#2:^(0),1:"")
 S QA=$P(QAOSMULT,"^",2) S $P(QAOSREVR,"^",2)=$S(QA'>0:"",$D(^VA(200,QA,0))#2:$P(^(0),"^"),1:"")
 S QAOSPAGE=1 D ^QAOSPHDR
 S QAOSHEAD="FINDINGS" W !!,QAOSHEAD
 F QA=0:0 S QA=$O(^QA(741.6,"B",QA)) Q:QA'>0!QAOSQUIT  F D0=0:0 S D0=$O(^QA(741.6,"B",QA,D0)) Q:D0'>0!QAOSQUIT  S LOC=^QA(741.6,D0,0) I $P(LOC,"^",3)["2" W !?3,$S($P(QAOSMULT,"^",5)=D0:"_X_",1:"___"),?8,$J(QA,3,0),?15,$P(LOC,"^",2) D CHK
 Q:QAOSQUIT
 W !!,"If quality of care is rated as level 2 or 3, indicate involved practitioner(s).",!!,"   __________________________________________________________________________" S QAOSHEAD="" D CHK Q:QAOSQUIT
 K ARRAY
 F QA=0:0 S QA=$O(^QA(741.7,"B",QA)) Q:QA'>0  F D0=0:0 S D0=$O(^QA(741.7,"B",QA,D0)) Q:D0'>0  S LOC=^QA(741.7,D0,0) I $P(LOC,"^",2)["2" S ARRAY(+LOC)=$S(QAOSD1'>0:"___",$D(^QA(741,QAOSD0,"REVR",QAOSD1,2,"B",D0)):"_X_",1:"___")_"^"_$P(LOC,"^",3)
 S QAOSHEAD="ACTION(S)" W !!,QAOSHEAD F QA=0:0 S QA=$O(ARRAY(QA)) Q:QA'>0!QAOSQUIT  W !?3,$P(ARRAY(QA),"^"),?8,$J(QA,3,0),?15,$P(ARRAY(QA),"^",2) D CHK
 Q:QAOSQUIT
 S QAOSHEAD="SEVERITY OF OUTCOME" W !!,QAOSHEAD
 S LOC=$S(QAOSHOW=3!(QAOSDATA=1):"",1:$P($G(^QA(741,QAOSD0,0)),"^",18))
 F QA=-1:0 S QA=$O(^QA(741.8,"B",QA)) Q:QA=""!QAOSQUIT  F D0=0:0 S D0=$O(^QA(741.8,"B",QA,D0)) Q:D0'>0!QAOSQUIT  W !?3,$S(D0=LOC:"_X_",1:"___"),?8,$J(QA,3,0),?15,$P(^QA(741.8,D0,0),"^",2) D CHK
 Q:QAOSQUIT
 W !!,"DATE REVIEW COMPLETED: " S Y=$P(QAOSMULT,"^",3) X ^DD("DD") W $S(Y]"":Y,1:"____________________")
 S QAOSPDUE=$P($G(^QA(741,QAOSD0,0)),"^",12),QAOSPDAY=$P($G(^QA(740,1,"OS")),"^") I QAOSPDUE!QAOSPDAY D
 . S Y=QAOSPDUE X ^DD("DD") W ?47,"DUE DATE: "
 . W $S((QAOSHOW=3)!(QAOSDATA=1)!(Y=""):"____________________",1:Y)
 . Q
 D CHK Q:QAOSQUIT
 S QAOSHEAD="" W !!,"Can steps be taken to improve the care of similar patients in the future?" D CHK Q:QAOSQUIT
 W !,"___ YES, ___ NO.  If YES, describe.  (Please answer even if quality of" D CHK W !,"care was rated as ""LEVEL 1"".)" D CHK Q:QAOSQUIT
 S QAOSHEAD="" W !!,"Should the care in this case be considered for educational presentations" D CHK Q:QAOSQUIT
 W !,"because it was exemplary? ___ YES, ___ NO.  If YES, describe." D CHK Q:QAOSQUIT
 S QAOSHEAD="COMMENTS" W !!,QAOSHEAD S DIWL=4,DIWR=75,DIWF="" K ^UTILITY($J,"W")
 I QAOSHOW'=3,QAOSDATA=2 F QAOSS0=0:0 S QAOSS0=$O(^QA(741,QAOSD0,"REVR",+QAOSD1,3,QAOSS0)) Q:QAOSS0'>0  S X=^QA(741,QAOSD0,"REVR",QAOSD1,3,QAOSS0,0) D ^DIWP
 F QA=0:0 S QA=$O(^UTILITY($J,"W",DIWL,QA)) Q:QA'>0!QAOSQUIT  W !?3,^UTILITY($J,"W",DIWL,QA,0) D CHK
 Q:QAOSQUIT
BLANK I $Y<(IOSL-6) W ! G BLANK
 W !,"SIGNATURE"
 Q
CHK ;
 Q:$Y'>(IOSL-6)  N D0,QA,Y I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S QAOSQUIT=$S(Y'>0:1,1:0) Q:QAOSQUIT
 D ^QAOSPHDR W !!,QAOSHEAD
 Q
