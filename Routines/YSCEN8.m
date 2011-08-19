YSCEN8 ;ALB/ASF-TREATMENT PLAN TRACKER ;4/3/90  11:14 ;
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSCENTPT
 ;
 W @IOF,!?IOM-$L("T R E A T M E N T   P L A N   T R A C K E R")\2,"T R E A T M E N T   P L A N   T R A C K E R"
EL ;
 R !!,"(E)nter or (L)ist? L// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" G:YSTOUT END^YSCEN14
 S YSR1="X",YSR2="L",YSR3="EL" D ^YSCEN14 G END^YSCEN2:X=-1,EL:X="?",EN2:X="L"
 ;
ENED ; Called from MENU option YSCENTPTE
 ;
 K YSOPT1,YSOPT2 D UN^YSCEN2 G:Y<1 END S P1=0,T6="A" D FS0^YSCEN,L1^YSCEN2
3 ;
 N DIC,DLAYGO,DR,DIE,DA,YDA,D S DIC("S")="I $P(^(7),U)=W1",DIC="^YSG(""INP"",",DIC(0)="AEQ",D="CP",DIC("W")="W:X="" "" $P(^DPT($P(^YSG(""INP"",+Y,0),U,2),0),U)" D IX^DIC Q:Y'>0  S (YDA,DA)=+Y K DIC
 S DIE="^YSG(""INP"",",DR="10;11" L +^YSG("INP",DA) D ^DIE L -^YSG("INP",DA) S YSTOUT=$D(DTOUT) I YSTOUT G END
 G 3
 ;
EN2 ; Called from MENU option YSCENTPTP
 ;
 D AX^YSCEN3 G:Y<1!POP END I $D(IO("Q")) D  G END
 .K IO("Q") S ZTRTN="ENQ^YSCEN8",ZTDESC="YS IP 8" F ZZ="T6","W1","W2","YSFLG" S ZTSAVE(ZZ)=""
 .I  D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7)
ENQ ;
 K ^UTILITY($J),YSOPT1 S YSOPT2="LIST^YSCEN8",P1=0,Q3=0
 ;%%%% CHECK%%%%
 S R1="",R2="" S:$D(^%ZIS(2,IOST(0),5)) R1=$P(^(5),U,4),R2=$P(^(5),U,5)
 D L2^YSCEN2:T6'="A",L1^YSCEN2:T6="A"
 D KILL^%ZTLOAD
END ;
 K ZTSK,A1,C,C1,D0,DIC,DIE,DIYS,DQ,DR,G,G2,I,L,L1,M1,N1,P1,Q3,R,R1,R2,U1,X,X1,X2,X9,Y,YSTM,YSOPT1,YSOPT2,R,M3,M2,U3,W2,W1,W4,X7,T6,YSDFN,DA,^UTILITY($J) W !! D ^%ZISC Q
LIST ;
 Q:T6=-1  S (M3,U3)="??" S:$D(^YSG("SUB",T6,"TXP")) M3=$P(^("TXP"),U),U3=$P(^("TXP"),U,2) D H1
 S N1="" F  S N1=$O(^UTILITY($J,N1)) Q:N1=""!Q3  D L2
 K ^UTILITY($J) D WAIT^YSCEN1 Q
L2 ;
 S YSDFN=0 F  S YSDFN=$O(^UTILITY($J,N1,YSDFN)) Q:'YSDFN  S X7=0 D WAIT:$Y+5>IOSL Q:Q3  D L3
 Q
L3 ;
 S DA=^UTILITY($J,N1,YSDFN),G=^YSG("INP",DA,0),G1="" S:$D(^YSG("INP",DA,1)) G1=^(1)
 S M1=$P(G1,U,4),U1=$P(G1,U,5),A1=$P(G,U,3),X9=$P(G,U,5)
 S X1=DT,X2=A1 D ^%DTC S L=X
 W !,$E($P(^DPT(YSDFN,0),U),1,18),?19,$$FMTE^XLFDT(A1,"5ZD"),?31,L Q:T6="UN"  I M1?1N.N S X1=M1,X2=A1 D ^%DTC W ?30 D:X>M3&($L(R1)) R1 W $$FMTE^XLFDT(M1,"5ZD") D:X>M3&($L(R2)) R2
 IF M3'?1N.E D:$L(R1) R1 W " NOT DEFINED" D:$L(R2) R2 D D3 Q
 I M1="",L>M3 W ?30 D:$L(R1) R1 W "OVERDUE ",L-M3," DAYS" D:$L(R2) R2 D D3 Q
 I M1="",L=M3 W ?30,"DUE TODAY" D D3 Q
 I M1="" W ?30,"DUE IN ",M3-L," DAYS" D D3 Q
CC ;
 S X1=DT,X2=$S(U1?7N:U1,1:M1) D ^%DTC S L1=X
 S X=$S(U1?7N:$$FMTE^XLFDT(U1,"5ZD"),1:"UPDATE") W ?40,X
 IF U3'?1N.E D:$L(R1) R1 W " NOT DEFINED" D:$L(R2) R2 D D3 Q
 I L1>U3 W ?$X+1 D:$L(R1) R1 W "OVERDUE ",L1-U3," DAYS" D:$L(R2) R2 D D3 Q
 I L1=U3 W ?$X+1,"DUE TODAY" D D3 Q
 I (U3-L1)<4 W ?$X+1,"DUE IN ",U3-L1," DAYS" D D3 Q
 D D3 Q
H1 ;
 W @IOF,?10,W2 W ?$X+2,"Treatment Plan Tracking",!,"Master due ",M3," days after entry   Updates due every ",U3," days"
 S G2=$S(T6="UN":"UNASSIGNED",1:^YSG("SUB",T6,0)) I T6="UN" W !,G2,?30,YSTM," patients are unassigned" G H12
 W !,$P(G2,U),?20,YSTM," patients",?35,$P(^YSG("SUB",T6,1),U,3)," beds",?45,"Team Leader: " S X=$P(G2,U,9) D D3^YSCEN2 W !,"Physician: " S X=$P(G2,U,2) D D3^YSCEN2 W ?33,"Psychologist: " S X=$P(G2,U,3) D D3^YSCEN2
H12 ;
 W !?3,"name",?19,"entry",?31,"days   Master",?43,"Update",?63,$S(T6?1N.N:$P(G2,U,10),1:""),! F ZZ=1:1:11 W "-------"
 Q
D3 ;
 Q:X9'?1N.N  S X9=$P(^VA(200,X9,0),U),X9(2)=$E($P(X9,",",2),1,2) S X9(2)=$S(X9(2)?1P.E:$E(X9(2),2),1:$E(X9(2))) W ?62+X7,$P(X9,","),",",X9(2) Q
WAIT ;
 D WAIT^YSCEN1 Q:Q3  D H1 Q
R1 ;
 W @R1 S X7=X7+$S(R1?.E1"G4".E:2,R1?.E1"m".E:4,1:3) Q
R2 ;
 W @R2 S X7=X7+$S(R2?.E1"G0".E:2,1:3) Q
