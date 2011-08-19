YSCEN7 ;ALB/ASF-MH CENSUS TEAM HX ;4/3/90  11:13 ;
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
CLN ;
 K IOP,YSTY,YSIDT,N4,YSAGE,B1,YSDOB,YSNM,YSSEX,YSSSN,YSTM,YSUS,YSUSER,YSBID D KVAR^VADPT Q
FINO ;
 D WAIT^YSCEN1,KILL^%ZTLOAD
FIN ;
 D CLN K C,DIYS,ZTSK,W2,X,Y,YSFS,G1,P1,T,G2,T3,T4,T5,T8,W1,Y,Y1,Y7,YSDFN,I,F,Q3,X1,YS,^UTILITY($J),YSPCK,IOP W !! D ^%ZISC Q
 ;
HIST ; Called from MENU option YSCENTAH
 ;
 K YS,Y7,T3,T4,T5,W1 S IOP=0 D ^%ZIS Q:POP  K IOP W @IOF,!!,"TEAM ADMISSION RECORD",!!
HISTQ ;
 R !,"Do you wish to see all wards? N// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" G:YSTOUT FIN
 S YSR1="X",YSR2="N",YSR3="YN",YSR4="Answer No to restrict listing to one ward" D ^YSCEN14 G FIN:X=-1,HISTQ:X="?" D X3:X="Y",X1:X="N"
HS ;
 G:'$D(YS) FIN K IOP S %ZIS="Q" D ^%ZIS G:POP FIN I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^YSCEN7",ZTDESC="YS IP 7",(ZTSAVE("W1"),ZTSAVE("W2"),ZTSAVE("YS("))="" D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) G FIN
ENQ ;
 U IO W @IOF,!!,"TEAM ADMISSION RECORD" S X="NOW",%DT="T" D ^%DT,ENDD^YSUTL W ?60,Y,! S X="T-14",%DT="T" D ^%DT S T8=9999999-Y
 W !,"This is a listing of recent team assignments and re-assignments by time",!,"for the past 14 days or less.  It does not indicate ward admission dates.",!
 W !,"The following wards are included: " S (X1,YSFIRST)=0 F  S YSFIRST=YSFIRST+1,X1=$O(YS(X1)) Q:'X1  S W2=$P(^YSG("CEN",X1,0),U,2) S X=$S(YSFIRST=1:"W W2",$X+$L(W2)+2>IOM:"W "","",!,W2",1:"W "", "",W2") X X
 S YSPCK=0 W !! S (T3,Q3)=0 F  S T3=$O(^YSG("INP","AST",T3)) Q:'T3!(T3>T8)!Q3  D HS1
 S T8=T8+1 F  S T8=$O(^YSG("INP","AST",T8)) Q:'T8  K ^YSG("INP","AST",T8)
 W:YSPCK'=1 !!?2,"No team assignments or re-assignments within the last 14 days were found.",!,$C(7) D FINO Q
HS1 ;
 S T4=0 F  S T4=$O(^YSG("INP","AST",T3,T4)) Q:'T4  D HS2:$D(YS(T4))
 Q
HS2 ;
 S T5=0 F  S T5=$O(^YSG("INP","AST",T3,T4,T5)) Q:'T5  D HS3
 Q
HS3 ;
 S DA=0 F  S DA=$O(^YSG("INP","AST",T3,T4,T5,DA)) Q:'DA  D HS4
 Q
HS4 ;
 I $D(^YSG("INP",DA)) S YSDFN=$P(^YSG("INP",DA,0),U,2) D HSP Q
 I '$D(^YSG("INP",DA)) K ^YSG("INP","AST",T3,T4,T5,DA)
 Q
HSP ;
 Q:Q3  S:'$D(Y7) Y7=9999999 S X=9999999-T3,%DT="T" D ^%DT S Y1=Y,X=Y#1 X:X ^DD("FUNC",2,1) W !,$$FMTE^XLFDT(Y,"5ZD")," ",$G(X) W ?22,$P(^DPT(YSDFN,0),U) S Y7=Y1,YSPCK=1
 W ?47,$P(^DIC(42,T4,0),U),"  ",$P(^YSG("SUB",T5,0),U) D:$Y+4>IOSL WW Q
X1 ;
 W !!,"Enter each ward to be displayed",!,"and hit return when all desired wards are entered",!
X2 ;
 D UN^YSCEN2 K:X="^" YS Q:Y<1  S YS(+Y)="" G X2
X3 ;
 K YS S F=0 F  S F=$O(^YSG("CEN","AFS",F)) Q:'F  S W1=$O(^YSG("CEN","AFS",F,0)) Q:'W1  S YS(W1)=""
 Q
WW ;
 D WAIT^YSCEN1 Q:Q3  W @IOF,"TEAM ADMISSION RECORD cont",! S Y7=9999999 Q
END ;
 K %DT,I,X,Y,Y1 Q
