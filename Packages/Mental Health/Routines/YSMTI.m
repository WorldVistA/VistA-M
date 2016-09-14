YSMTI ;ALB.ASF,HIOFO/FT - MUTLIPLE PSYCH TESTS AND INTERVIEWS ;10/23/13 2:06pm
 ;;5.01;MENTAL HEALTH;**53,108**;Dec 30, 1994;Build 17
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to %ZTLOAD APIs supported by DBIA #10063
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to %ZISC supported by IA #10089
 ;Reference to ^XLFDT APIs supported by DBIA #10103
 ;
 ;entry point for YT MTI option
 W @IOF,!?10,"Psychological Testing Mutliple Administraion Reporting",!
PTALL ; SELECT PT
 W ! K DIC,DIK S YSDFN=0,DIC("A")="Select Patient: ",DIC="^YTD(601.2,",DIC(0)="AEQ" D ^DIC Q:Y'>0  S YSDFN=+Y
 K ^TMP("YSMTI",$J,YSDFN)
 I $O(^YTD(601.2,YSDFN,1,0))'>0 W !,"No Tests found" Q
SELTST ;select test
 K DIC S DIC="^YTD(601.2,YSDFN,1,",DIC(0)="AEMZ" D ^DIC Q:Y'>0  S (YSET,YSTEST)=+Y,YSTESTA=$P(^YTT(601,YSTEST,0),U)
 I $P(^YTT(601,YSTEST,0),U,9)'="T" W !,"Only Tests can be graphed" H 2 G SELTST
 D ENFRNT
SELSCAL ;
 S Y="N" I YSTESTA?1."MMP".E!(YSTESTA?1"MCMI".E) K DIR S DIR("A")="Show Full Profile? ",DIR("B")="NO",DIR(0)="Y" D ^DIR Q:$D(DIROUT)
 I Y=1 D ^YSMTI0  G SELSCAL
 K DIC S DIC("A")="Select Scale Number or Name: ",DIC(0)="AEQZM",DIC="^YTT(601,YSTEST,"""_"S"_""",",DIC("W")="W ?10,$P(^(0),U,2)" D ^DIC G:Y'>0 SELTST S YSCALEN=+Y,YSCALET=$P(Y(0),U,2)
 K IOP N POP S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENTASK^YSMTI",ZTDESC="YSMTI" S ZTSAVE("YS*")="" D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) G SELSCAL
 U IO D HDR,CR,HOME^%ZIS D ^%ZISC U IO
 G SELSCAL
ENTASK ;taskman entry
 S:$D(ZTQUEUED) ZTREQ="@"
 D ENFRNT,HDR,CR Q
HDR ;
 S YSLN="",$P(YSLN,"_",79)=""
 W:$Y>0 @IOF,!?7,"**** M U L T I P L E   T E S T   A D M I N I S T R A T I O N S ****"
 W !,VADM(1),?40,"SSN: ","xxx-xx-"_$E($P(VADM(2),U,2),8,11),"  ",$P(VADM(5),U,2),?60,"  DOB: ",$P(VADM(3),U,2)
 S X=$P(^YTT(601,YSTEST,"P"),U) W !?(72-$L(X)/2),X
 S X="Scale: "_YSCALET W !,YSLN,!?(72-$L(X)/2),X,!,YSLN
 W !,"Entered:    Days between   Raw   Scaled"
 Q
CR ;loop thru TMP
 S (YSED,YSED1)=0 F  S YSED=$O(^TMP("YSMTI",$J,YSDFN,YSTEST,YSCALEN,YSED)) Q:YSED'>0  D CR1 S YSED1=YSED
 W !! Q
CR1 S Y=^TMP("YSMTI",$J,YSDFN,YSTEST,YSCALEN,YSED)
 S R=$P(Y,U),S=$P(Y,U,2) S:YSED1 YSED1=$$FMDIFF^XLFDT(YSED,YSED1,1)
 W !,$$FMTE^XLFDT(YSED,"5ZD"),?14,$S(YSED1:$J(YSED1,5),1:"     "),?24,$J(R,6),"   ",$J(S,6)
 Q
ENFRNT ;
 S YSET=YSTEST,DFN=YSDFN D DEM^VADPT,PID^VADPT
 S YSNM=VADM(1),(YSSX,YSSEX)=$P(VADM(5),U),YSDOB=$P(VADM(3),U,2),YSAGE=VADM(4),YSSSN=VA("PID")
LK2 ;LOOP THRU DATES
 S (YSDAT,YSED)=0 F  S YSED=$O(^YTD(601.2,YSDFN,1,YSTEST,1,YSED)) Q:YSED'>0  S YSDAT=YSED  D EXEC,FSD
 Q
EXEC ;SELECT TYPE OF TEST AND EXECUTE PROPER RTN
 K S,R S YSTN=$P(^YTT(601,YSTEST,0),U) Q:'$D(^YTT(601,YSTEST,"R"))  S X=^YTT(601,YSTEST,"R")
 S YSR(0)=$G(^YTT(601.6,YSET,0))
 I $P(YSR(0),U,2)="Y" S X=^YTT(601.6,YSET,1) X X
 Q
FSD ;file scale data
 I '$D(R) S ^TMP("YSMTI",$J,YSDFN,YSET,1,YSED)="" Q
 I $L(R) F I=1:1 Q:$P(R,U,I)=""  S ^TMP("YSMTI",$J,YSDFN,YSET,I,YSED)=$P(R,U,I) S:$D(S) $P(^(YSED),U,2)=$P(S,U,I)
 S I1=0,YSCALEN=0 F  S I1=$O(R(I1)) Q:I1'>0  D FSD1
 Q
FSD1 ;
 F I=1:1 Q:$P(R(I1),U,I)=""  S YSCALEN=YSCALEN+1,^TMP("YSMTI",$J,YSDFN,YSET,YSCALEN,YSED)=$P(R(I1),U,I) S:$D(S(I1)) $P(^(YSED),U,2)=$P(S(I1),U,I)
 Q
