GMPLPRNT ; SLC/MKB,KER -- Problem List prints/displays; 04/15/2002
 ;;2.0;Problem List;**1,13,26,41**;Aug 25, 1994;Build 1
 ;
 ; External References
 ;   DBIA 10090  ^DIC(4
 ;   DBIA 10082  ^ICD9(
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA 10089  ^%ZISC
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10026  ^DIR
 ;   DBIA 10061  OERR^VADPT
 ;   DBIA 10116  CLEAR^VALM1
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10104  $$REPEAT^XLFSTR
 ;   DBIA 10112  $$SITE^VASITE
 ;                   
EN ; Print/Display (Main)
 N DIR,X,Y S VALMBCK=$S(VALMCC:"",1:"R") W !
 I '(($L(GMPLVIEW("ACT")))!(GMPLVIEW("PROV"))!($L(GMPLVIEW("VIEW"),"/")>2)) S Y="A" G EN1
 S DIR(0)="SAOM^C:CURRENT VIEW;A:ALL PROBLEMS;"
 S DIR("A")="Print (C)urrently displayed problems only, or include (A)ll problems? "
 S DIR("?",1)="Enter C to print a copy of your currently displayed view"
 S DIR("?",2)="of this patient's list; to print a complete list of all"
 S DIR("?",3)="active and inactive problems, which may be included in"
 S DIR("?")="the patient's chart, select A."
 D ^DIR G:$D(DTOUT)!($D(DUOUT))!(Y="") ENQ
EN1 ;   Print View
 W ! D @$S(Y="C":"LIST",1:"VAF")
 I GMPRT'>0 W !!,"No problems found.",!,$C(7) H 1 G ENQ
 D DEVICE G:$D(GMPQUIT) ENQ
 D CLEAR^VALM1,PRT S VALMBCK="R"
ENQ ;   Quit Print/Display
 D KILL^GMPLX S VALMSG=$$MSG^GMPLX Q
 ;             
VAF ; Build Chart Copy
 N TOTAL,VIEW K GMPLCURR S (TOTAL,GMPRT)=0
 Q:'$D(^AUPNPROB("AC",+GMPDFN))
 S (VIEW("ACT"),VIEW("VIEW"))="",VIEW("PROV")=0
 D GETPLIST^GMPLMGR1(.GMPRT,.TOTAL,.VIEW)
 S GMPRT=TOTAL
 Q
 ;
LIST ; Build Current View
 S GMPLCURR=1,GMPRT=0 Q:+$G(GMPCOUNT)'>0  N I,IFN
 W !,"One moment, please ..."
 F I=0:0 S I=$O(^TMP("GMPLIDX",$J,I)) Q:I'>0  D
 . S IFN=$P($G(^TMP("GMPLIDX",$J,I)),U,2) Q:IFN'>0
 . S GMPRT=GMPRT+1,GMPRT(I)=IFN W "."
 Q
 ;
DEVICE ; Get Device
 S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP S GMPQUIT=1 G DQ
 I '$D(GMPLCURR) K GMPRINT
 I $D(IO("Q")) D
 . S ZTRTN="PRT^GMPLPRNT",ZTDESC="PROBLEM LIST OF "_$P(GMPDFN,U,2)
 . S (ZTSAVE("GMPRT"),ZTSAVE("GMPRT("),ZTSAVE("GMPDFN"),ZTSAVE("GMPVAMC"))=""
 . S:$D(GMPLCURR) ZTSAVE("GMPLCURR")="" S ZTDTH=$H
 . D ^%ZTLOAD,HOME^%ZIS S:$D(ZTSK) GMPQUIT=1
DQ ;   Quit Device
 K IO("Q"),POP,%ZIS,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 Q
 ;
HDR ; Header Code
 N PAGE S PAGE="Page: "_GMPLPAGE,GMPLPAGE=GMPLPAGE+1
 W $C(13),$$REPEAT^XLFSTR("-",79),!
 I IOST?1"P".E W:$D(GMPLCURR) "** NOT for " W "Medical Record" W:$D(GMPLCURR) " **"
 I IOST'?1"P".E W $P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 W ?41,"|  " W:$D(GMPLCURR) "PARTIAL "
 W "PROBLEM LIST",?(79-$L(PAGE)),PAGE,!
 W $$REPEAT^XLFSTR("-",79),!
 W !,"       Date",?63,"Date of   Date"
 W !,"     Recorded  Problems",?64,"Onset  Resolved"
 W !,$$REPEAT^XLFSTR("-",79)
 Q
 ;
FTR ; Footer Code
 N I,SITE,DFN,VA,VADM,LOC,DATE,FORM
 F I=1:1:(IOSL-$Y-6) W !
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",2)
 S:SITE'["VAMC" SITE=SITE_" VAMC"
 S DFN=+GMPDFN D OERR^VADPT
 S LOC="Pt Loc: "_$S(VAIN(4)]"":$P(VAIN(4),U,2)_"  "_VAIN(5),1:"OUTPATIENT") K VAIN
 I $L(LOC)>51 S LOC=$E(LOC,1,51),FORM="VAF10-141"
 E  S FORM="VA FORM 10-1415"
 W !,$S($D(GMPLFLAG):"$ = Requires verification by provider",1:"")
 W !,$$REPEAT^XLFSTR("-",79)
 W !,$P(GMPDFN,U,2),?(79-$L(SITE)\2),SITE
 S DATE=$$FMTE^XLFDT($E(($$NOW^XLFDT),1,12),2)
 S DATE="Printed:"_$P(DATE,"@")_" "_$P(DATE,"@",2)
 W ?(79-$L(DATE)),DATE
 W !,VA("PID"),?(79-$L(LOC)\2),LOC,?(79-$L(FORM)),FORM
 W !,$$REPEAT^XLFSTR("-",79),@IOF
 Q
 ;
RETURN() ; End of page
 N X,Y,DIR,I F I=1:1:(IOSL-$Y-3) W !
 S DIR(0)="E" D ^DIR
 Q +Y
 ;
PRT ; Body of Problem List
 U IO N I,IFN,GMPLPAGE,GMPLFLAG S GMPLPAGE=1 D HDR
 F I=0:0 S I=$O(GMPRT(I)) Q:I'>0  D  Q:$D(GMPQUIT)
 . S IFN=GMPRT(I) Q:IFN'>0
 . D PROB(IFN,I)
 D FTR:IOST?1"P".E I '$D(GMPQUIT),IOST?1"C".E S I=$$RETURN
 I $D(ZTQUEUED) S ZTREQ="@" K GMPDFN,GMPLCURR,GMPQUIT,GMPRT
 D ^%ZISC
 Q
 ;
PROB(DA,NUM) ; Get Problem Text Line
 N GMPL0,GMPL1,ONSET,DATE,TEXT,NOTES,J,RESOLVED,X,LINES,PROB,SCS,SP
 S GMPL0=$G(^AUPNPROB(DA,0)),GMPL1=$G(^(1)) Q:GMPL0=""  Q:GMPL1=""
 S ONSET=$P(GMPL0,U,13),DATE=$P(GMPL1,U,9),RESOLVED=$P(GMPL1,U,7)
 D SCS^GMPLX1(+DA,.SCS) S SP=$G(SCS(3))
 I 'DATE S DATE=$P(GMPL0,U,8)
 S PROB=$$PROBTEXT^GMPLX(DA)
 S PROB=PROB_" ("_$P($G(^ICD9(+GMPL0,0)),U)_")"
 I $P($G(^AUPNPROB(DA,1)),"^",14)="A" S PROB="*"_PROB
 E  S PROB=" "_PROB
 D WRAP^GMPLX(PROB,50,.TEXT)
 D NOTES(DA) S LINES=TEXT+NOTES+1
 I ($Y+LINES)>(IOSL-7) D  Q:$D(GMPQUIT)
 . I IOST?1"P".E D FTR,HDR Q
 . I $$RETURN W @IOF D HDR Q
 . S GMPQUIT=1
PR1 ; Write Problem Text Line
 W !!,$E("   ",1,3-$L(NUM))_NUM_". "_$J($$EXTDT^GMPLX(DATE),8)
 I $P(GMPL1,U,2)="T",$P($G(^GMPL(125.99,1,0)),U,2) W ?14,"$" S GMPLFLAG=1
 W ?15,TEXT(1),?62,$J($$EXTDT^GMPLX(ONSET),8)
 I $P(GMPL0,U,12)="I" W ?71,$S(RESOLVED:$J($$EXTDT^GMPLX(RESOLVED),8),1:"unknown")
 I TEXT>1 F J=2:1:TEXT W !?15,TEXT(J)
 Q:'NOTES  S DATE=$P(DATE,".")
 F J=1:1:NOTES S X=$S(DATE'=$P(NOTES(J),U):$$EXTDT^GMPLX($P(NOTES(J),U)),1:"") W !?5,$J(X,8),?17,$P(NOTES(J),U,2) S DATE=$P(NOTES(J),U)
 Q
NOTES(IFN) ; Place Comments in NOTES array
 N I,NOTE,DATE,TEXT,FAC,NIFN S (NOTES,I)=0
 Q:'$D(^AUPNPROB(IFN,11))
 S FAC=$O(^AUPNPROB(IFN,11,"B",+GMPVAMC,0)) Q:FAC'>0
 F NIFN=0:0 S NIFN=$O(^AUPNPROB(IFN,11,FAC,11,"B",NIFN)) Q:NIFN'>0  D
 . S NOTE=$G(^AUPNPROB(IFN,11,FAC,11,NIFN,0)) Q:NOTE=""
 . S DATE=$P(NOTE,U,5),TEXT=$P(NOTE,U,3),I=I+1
 . S NOTES(I)=$P(DATE,".")_U_TEXT
 S NOTES=I
 Q
