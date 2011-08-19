YSCEN22 ;ALB/ASF,ALB/XAK,ALB/MJK-LONG PRINTOUT ;4/16/92  10:01 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
EN ;
 D LG^YSCEN23
ZZ ;
 S (G0,G1,G2,G3,G4)=0 F ZZ=0:1:4 S:$D(^YSG("INP",DA,ZZ)) @("G"_ZZ)=^YSG("INP",DA,ZZ)
 W !!,"Ward: ",$P(^DIC(42,W1,0),U),?40,"Entry: " S Y=$P(G0,U,3) D ENDD^YSUTL W $P(Y,"  ") I $D(^DPT(YSDFN,.101)) S X=$S($X+16>IOM:"!",1:"?$X+2") W @X,"Bed: ",^(.101)
 S Y=$P(G1,U) W !,$S(Y?1"v".E:"Voluntary patient",Y?1"i".E:"Involuntary patient",1:"Voluntary status undefined") S Y=$P(G1,U,2) W ?40,$S(Y?1"o".E:"Open ward",Y?1"c".E:"Closed ward",1:"open/closed undefined")
 S Y=$P(G1,U,3) I Y?1N W "  Level: ",Y
 W !,"Team: ",$S($P(G0,U,4)?1N.N:$P(^YSG("SUB",$P(G0,U,4),0),U),1:"UNASSIGNED")
 I $P(G0,U,4) S G5=$P(^YSG("SUB",$P(G0,U,4),0),U,10) W ?40,$S(G5]"":G5,1:"Staff"),": " S X=$P(G0,U,5) D:X?1N.E D3^YSCEN2
 I G1'=0 W !,"Hair: ",$P(G1,U,6),?15,"Eyes: ",$P(G1,U,7),?40,"Ht: ",$P(G1,U,8),?50,"Wt: ",$P(G1,U,9)
 I G2 W !,"Physical Description: ",G2
 W:G3'=0 !,"** Medical Alert: ",G3 W:G4'=0 !,"Special Diet: ",G4
PT ;
 W !,"Team history for this MH ward admission: " S X=0 F  S X=$O(^YSG("INP",DA,6,X)) Q:'X  S YSTP1=+^(X,0),Y=$P(^(0),U,2) W !?3,X,". ",$P(^YSG("SUB",YSTP1,0),U),"  on  " D DD^%DT W Y K YSTP1
 ;
COM ;  Called by routines YSCEN1, YSCEN24, YSCEN54
 ;
 K ^UTILITY($J,"W"),G0,G1,G2,G3,G4,G5 S YDA=DA Q:'$D(^YSG("INP",YDA,"AB"))  W !?7,"Inpatient Comments:" S G0=0,DIWL=3,DIWR=75,DIWF="WR"
 F  S G0=$O(^YSG("INP",YDA,"AB",G0)) Q:'G0  S G1=0 F  S G1=$O(^YSG("INP",YDA,"AB",G0,G1)) Q:'G1  W !! D COM1
 K G0,G1,G2 Q
COM1 ;
 S G2=0 F  S G2=$O(^YSG("INP",YDA,5,G1,1,G2)) Q:'G2  S X=^(G2,0) D ^DIWP
 D ^DIWW K ^UTILITY($J,"W") W "Entered by: ",$P(^VA(200,$P(^YSG("INP",YDA,5,G1,0),U,2),0),U)," on " S (YSTM,YSDTM)=9999999.999999-G0,Y=YSTM\1 D ENDD^YSUTL W Y D ENHM^YSUTL W " at ",YSTM K YSHM Q
 Q  ;K G0,G1,G2,G3,G4,G5 Q
 ;
AA ; Called from MENU option YSCENIL
 ;
 S (Q3,P,P1)=0,YSOPT2="BB^YSCEN22" D UN^YSCEN2 G:Y<1 END
AA1 ;
 W !!,"All patients on ",W2,"? N// " R X:DTIME S YSTOUT='$T,YSUOUT=X["^" G:YSTOUT END
 S YSR1="X",YSR2="N",YSR3="YN" D ^YSCEN14 G AA1:X="?",END:X=-1,CC:X="N"
 K IOP S %ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTRTN="AAQ^YSCEN22",(ZTSAVE("W1"),ZTSAVE("P1"),ZTSAVE("W2"),ZTSAVE("YSOPT2"))="",ZTDESC="YS IP LONG" D ^%ZTLOAD W $S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) G END
AAQ ;
 S P1=0 D FS0^YSCEN S P1=0 D L1^YSCEN2 G END0
BB ;
 Q:Q3  S N="" F  S N=$O(^UTILITY($J,N)) Q:N=""  D B1 Q:Q3
 Q
B1 ;
 S YSDFN=0 F  S YSDFN=$O(^UTILITY($J,N,YSDFN)) Q:'YSDFN  S DA=^(YSDFN) D EN S W=$P(^DIC(42,W1,0),U) D:IOST?1"C-".E WAIT^YSCEN1 Q:Q3
 Q
CC ;
 K YSOPT2,IOP D FS0^YSCEN,L1^YSCEN2
 K DIC,DLAYGO,DR,DIE,DA,D S DIC("S")="I $P(^(7),U)=W1",DIC="^YSG(""INP"",",DIC(0)="AEQ",D="CP",DIC("W")="W:X="" "" $P(^DPT($P(^YSG(""INP"",+Y,0),U,2),0),U)" D IX^DIC G:Y<1 END S DA=+Y,YSDFN=$P(^YSG("INP",DA,0),U,2) K DIC
 S %ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTRTN="CCQ^YSCEN22",(ZTSAVE("W1"),ZTSAVE("YSDFN"),ZTSAVE("P1"),ZTSAVE("W2"),ZTSAVE("YSOPT2"))="",ZTDESC="YS IP LONG" D ^%ZTLOAD W $S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) G END
CCQ ;
 D EN
END0 ;
 D KILL^%ZTLOAD
END ;
 K ZTSK,YSDFN,DIC,G,G1,G2,G3,I,Q3,YSOPT1,YSOPT2,Y,J,K,X,C1,DA,P,P1,R,T6,W1,W2,X1,YSSSN,YSTM,N,W,^UTILITY($J),YSBID,VA,PTI D KVAR^VADPT W ! D ^%ZISC Q
