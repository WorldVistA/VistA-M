YSCEN51 ;ALB/ASF-INPATIENT HX CONT ;4/3/90  10:44 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
1 ;  Called from routine YSCEN55
 S YSFL5=0,X=0 Q:'$D(^YSG("INP",W1,6))  F  S X=$O(^YSG("INP",W1,6,X)) Q:'X  S X1=+^(X,0) I $D(YS(X1)) S YSFL5=1 Q
 Q
A ; Called from routine YSCEN55
 K YS,^UTILITY($J) D UN^YSCEN2 Q:Y<1  S (Q3,P1)=0 D FS0^YSCEN
 W !!,"Enter each team desired followed by return and end with just a return",!
A0 ;
 W !,"Select ",W2," Team: " R X:DTIME S YSTOUT='$T,YSUOUT=X["^" Q:YSTOUT!YSUOUT
 S DIC("S")="I $P(^(1),U)=W1,$P(^(1),U,5)'=1",DIC(0)="EQM",DIC="^YSG(""SUB""," D ^DIC K DIC S:Y>0 YS(+Y)="" G:Y>0!(X?1"?".E) A0
 S:'$D(YS) Q3=1 Q
 ;
ENDOC ; Called from MENU option YSCENDCDOC
 ;
 D ^YSLRP G:YSDFN<1 END
 I '$D(^YSG("INP","C",YSDFN)) W !,"No MH inpatient record found",$C(7) G ENDOC
 I $D(^YSG("INP","CP",YSDFN)) W !,"Current MH inpatient.. edit through ENTER/EDIT CURRENT INPATIENT DATA option" G ENDOC
 S (DA,X)=0 F  S X=$O(^YSG("INP","C",YSDFN,X)) Q:'X  S DA=X
DOC ;
 S (YDA,W1)=DA D ZZ^YSCEN54 S X2=$P(^YSG("INP",W1,7),U,2),X1=DT D ^%DTC W !,"Discharge ",X," days ago"
DOCX ;
 R !,"Do you wish to add a comment to the last entry? N// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" G:YSTOUT END
 S YSR1="X",YSR2="N",YSR3="YN" D ^YSCEN14 G DOCX:X="?",END:X'="Y"
 S DA=YDA,YSFLG=0 D CM^YSCEN1
END ;
 K %,%X,D,D0,DA,DIC,DIE,DIPGM,DIW,DIWF,DIWL,DIWR,DIWT,DN,DQ,DR,E2,E3,G,G1,G2,G3,G6,I,J,W1,W2,X,X1,X2,Y,YSAGE,YSDFN,YSDOB,YSDTM,YSNM,YSSEX,YSSSN,YSBID,YSTM,Z,Z1 D KVAR^VADPT Q
