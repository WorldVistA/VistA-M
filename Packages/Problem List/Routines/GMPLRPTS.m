GMPLRPTS ; SLC/MKB -- Problem List Mgt Reports ;1/26/95  10:00
 ;;2.0;Problem List;**2**;Aug 25, 1994
PAT ; List patients having data in Problem file #9000011
 N DFN,IFN,CNT,ST S GMPRT=0
 D WAIT^DICD
 F DFN=0:0 S DFN=$O(^AUPNPROB("AC",DFN)) Q:DFN'>0  D
 . S (CNT("A"),CNT("I"),IFN)=0
 . F  S IFN=$O(^AUPNPROB("AC",DFN,IFN)) Q:IFN'>0  I $P($G(^AUPNPROB(IFN,1)),U,2)'="H" S ST=$P(^(0),U,12),CNT(ST)=CNT(ST)+1
 . I (CNT("A")>0)!(CNT("I")>0) S GMPRT=GMPRT+1,^TMP("GMPRT",$J,$P(^DPT(DFN,0),U))="  "_+CNT("A")_$E("       ",1,7-$L(CNT("A")))_+CNT("I") W "."
 I GMPRT'>0 W $C(7),!!,"No patient data available.",! G PATQ
 S GMPLHDR="PROBLEM LIST PATIENT LISTING",GMPLCNT=1
 D DEVICE G:$D(GMPQUIT) PATQ
 D PRT
PATQ D KILL
 Q
 ;
PROB ; Search for/List patients with selected problem
 N X,Y,GMPTERM,GMPTEXT,IFN,DFN,STATUS,ST,TXT,NAME
PROB1 D SEARCH^GMPLX(.X,.Y) G:Y'>0 PROBQ
 S GMPTERM=Y,GMPTEXT=$$UP^XLFSTR(X) S:+GMPTERM'>1 GMPTERM="1^"_GMPTEXT
 S STATUS=$$STATUS G:STATUS="^" PROBQ
 D WAIT^DICD S GMPRT=0
 F IFN=0:0 S IFN=$O(^AUPNPROB("C",+GMPTERM,IFN)) Q:IFN'>0  D
 . Q:$P($G(^AUPNPROB(IFN,1)),U,2)="H"
 . Q:STATUS'[$P($G(^AUPNPROB(IFN,0)),U,12)
 . S NODE=$G(^AUPNPROB(IFN,0)),DFN=$P(NODE,U,2),NAME=$P(^DPT(DFN,0),U),ST=$S($P(NODE,U,12)="A":"active",1:"inactive"),TXT=$P(NODE,U,5)
 . I GMPTERM'>1,GMPTEXT'=$$UP^XLFSTR($P(^AUTNPOV(+TXT,0),U)) Q
 . I '$D(^TMP("GMPRT",$J,NAME)) S GMPRT=GMPRT+1,^TMP("GMPRT",$J,NAME)=ST Q
 . Q:(" "_^TMP("GMPRT",$J,NAME))[(" "_ST)  ; already included
 . S:$E(ST)="a" ^TMP("GMPRT",$J,NAME)=ST_", "_^TMP("GMPRT",$J,NAME)
 . S:$E(ST)="i" ^TMP("GMPRT",$J,NAME)=^TMP("GMPRT",$J,NAME)_", "_ST
 I GMPRT'>0 W $C(7),!!,"No patient data available.",! D KILL G PROB1
 S GMPLHDR="PATIENTS WITH '"_$$UP^XLFSTR($P(GMPTERM,U,2))_"'",GMPLCNT=0
 D DEVICE I $D(GMPQUIT) D KILL G PROB1
 D PRT D KILL G PROB1
PROBQ D KILL
 Q
 ;
KILL ; Clean-up after ourselves
 K GMPRT,GMPLHDR,GMPQUIT,X,Y,^TMP("GMPRT",$J)
 Q
 ;
DEVICE ; Prompt for device to send report to -- Sets GMPQUIT to quit
 S %ZIS="Q" D ^%ZIS I POP S GMPQUIT=1 G DQ
 I $D(IO("Q")) D
 . S ZTRTN="PRT^GMPLRPTS",ZTDESC=GMPLHDR
 . S (ZTSAVE("GMPRT"),ZTSAVE("^TMP(""GMPRT"",$J,"),ZTSAVE("GMPLHDR"),ZTSAVE("GMPLCNT"))=""
 . D ^%ZTLOAD,HOME^%ZIS S:$D(ZTSK) GMPQUIT=1
DQ K IO("Q"),POP,%ZIS,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 Q
 ;
PRT ; Print patient listing from ^TMP("GMPRT",$J,)
 U IO N NAME,PAGE S NAME="",PAGE=0 D HDR
 F  S NAME=$O(^TMP("GMPRT",$J,NAME)) Q:NAME=""  D  Q:$D(GMPQUIT)
 . I $Y>(IOSL-4) D RETURN Q:$D(GMPQUIT)  D HDR
 . W !,NAME,?60,^TMP("GMPRT",$J,NAME)
 W:'$D(GMPQUIT) !!?10,"Total of "_GMPRT_" patients found."
 W:IOST?1"P".E @IOF I IOST'?1"P".E,'$D(GMPQUIT) D RETURN
 I $D(ZTQUEUED) S ZTREQ="@" D KILL
 D ^%ZISC
 Q
 ;
HDR ; Prints report header
 W @IOF S PAGE=PAGE+1
 W GMPLHDR,?60,$$EXTDT^GMPLX(DT),?70,"PAGE "_PAGE,!!
 W "Patient Name",?60,$S(GMPLCNT:"# Active/Inactive",1:"Status"),!
 W $$REPEAT^XLFSTR("-",79),!
 Q
 ;
RETURN ; Checks for end-of-page, continue
 Q:IOST?1"P".E  N X,Y,DIR,I
 F I=1:1:(IOSL-$Y-2) W !
 S DIR(0)="E" D ^DIR S:'Y GMPQUIT=1
 Q
 ;
STATUS() ; Prompts for problem status to search for
 N DIR,X,Y
 S DIR(0)="SA^A:ACTIVE;I:INACTIVE;B:BOTH;"
 S DIR("A")="Select STATUS: ",DIR("B")="ACTIVE"
 S DIR("?",1)="To list only those patients with this problem in a specific status, select:",DIR("?",2)="          ACTIVE",DIR("?",3)="          INACTIVE",DIR("?")="          BOTH ACTIVE & INACTIVE"
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) Y="^" S:Y="B" Y="AI"
 Q Y
