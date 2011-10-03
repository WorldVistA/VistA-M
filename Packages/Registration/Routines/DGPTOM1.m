DGPTOM1 ;ALB/AS - PTF MEANS TEST INDICATOR OF 'U' REPORT ; 19 MAR 87  14:00
 ;;5.3;Registration;;Aug 13, 1993
 S IOP="HOME" D ^%ZIS K IOP D LO^DGUTL,Q,ASK G:DGQ Q
 S DGPGM="^DGPTOM2",DGVAR="DUZ^DGD^DGP^DGSD^DGED" D ZIS^DGUTQ G:POP Q U IO S X=132 X ^%ZOSF("RM") D ^DGPTOM2,CLOSE^DGUTQ G Q
RD S X="" R X:DTIME I X["^"!('$T) S DGQ=1 Q
 S X=$E(X) Q
ASK S DGQ="" W !!,"Choose DATE RANGE by ",!?4,"(D)ISCHARGE DATE or (A)DMISSION DATE: DISCHARGE// " S Z="^DISCHARGE DATE^ADMISSION DATE" D RD Q:DGQ  I X="" S X="D" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"A - to choose beginning and ending report dates by admission dates",!?12,"or",!?12,"D - to choose by discharge dates",! S %="" G ASK
 S DGD=$S(X="D":1,1:0)
 ;
DT W ! S %DT="AEXP",%DT(0)=-DT,%DT("A")="Start with "_$S(DGD:"DISCHARGE",1:"ADMISSION")_" DATE: " D ^%DT K %DT S:X["^" DGQ=1 Q:DGQ  G:Y<0 DT
 S %DT(0)=Y,DGSD=Y-.1,%DT="AEXP",%DT("A")="  End with "_$S(DGD:"DISCHARGE",1:"ADMISSION")_" DATE: " D ^%DT K %DT S:X["^" DGQ=1 Q:DGQ  G:Y<0 DT
 I (DGSD+10000)<Y W !,*7,?12,"Please limit your date range to no more than 1 year." G DT
 S DGED=Y_.9
 ;
P W !!,"Sort by (P)ATIENT NAME or (T)ERMINAL DIGIT ORDER: PATIENT// " S Z="^PATIENT NAME^TERMINAL DIGIT ORDER" D RD Q:DGQ  I X="" S X="P" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"T - to have report sorted by terminal digit order or",!?12,"P - to sort by patient last name",! S %="" G P
 S DGP=$S(X="P":1,1:0)
 W !!,"You have selected output for: ",!?4,"Patients ",$S(DGD:"discharged",1:"admitted")," between "
 S Y=(DGSD+.1) X ^DD("DD") W ?4,Y," and " S Y=$P(DGED,".") X ^DD("DD") W Y,"."
 W !?4,"Report to be sorted by ",$S(DGP:"patient last name.",1:"terminal digit order."),!
OK W "IS THIS CORRECT:" S %=1 D YN^DICN I '% W !!?6,"Enter <RET> if this information is correct",!?10,"Enter 'N' for NO to exit",!! G OK
 S:%'=1 DGQ=1 Q
Q K DGD,DGP,DGSD,DGED,DGPGM,DGVAR,DGQ,POP,X,Y,Z,%,%DT Q
