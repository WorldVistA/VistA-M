DGPTODI1 ;ALB/AS - DRG INDEX REPORT ; 20 MAY 87  09:00
 ;;5.3;Registration;;Aug 13, 1993
 S IOP="HOME" D ^%ZIS K IOP D LO^DGUTL,Q,ASK G:DGQ Q
 S DGPGM="^DGPTODI2",DGVAR="DUZ^DGD^DGB^DGR^DGP^DGS^DGC1^DGC2^DGSD^DGED^DGC"
 W !!?12,*7,"** NOTE:  132 columns required for output",! D ZIS^DGUTQ G:POP Q U IO S X=132 X ^%ZOSF("RM") D ^DGPTODI2,CLOSE^DGUTQ G Q
RD S X="" R X:DTIME I X["^"!('$T) S DGQ=1 Q
 S X=$E(X) Q
ASK S DGQ="" W !!,"For (A)CTIVE ADMISSIONS or",!?4,"(D)ISCHARGED PATIENTS: DISCHARGED// " S Z="^ACTIVE ADMISSIONS^DISCHARGED PATIENTS" D RD Q:DGQ  I X="" S X="D" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"A - Active admissions (all current inpatients) or",!?12,"D - Discharged patients within a date range",! S %="" G ASK
 S DGD=$S(X="D":1,1:0) I 'DGD S DGSD=0,DGED=(DT_.9),DGB=1,DGS=0 G R
DC W ! S %DT="AEXP",%DT(0)=-DT,%DT("A")="Start with DISCHARGE DATE: " D ^%DT S:X["^" DGQ=1 Q:DGQ  G:Y<0 DC S DGSD=Y-.1
 S %DT("A")="  End with DISCHARGE DATE: ",%DT(0)=DGSD D ^%DT S:X["^" DGQ=1 Q:DGQ  G:Y<0 DC I (DGSD+10000)<Y W !,*7,?12,"Please limit your discharge date range to no more than 1 year" G DC
 S DGED=Y_.9
B W !!,"For (T)RANSFER DRGs or",!?4,"(D)RG from 701/702/703 TRANSACTIONS: TRANSFER DRGs// " S Z="^TRANSFER DRGs^DRGs from 701/702/703 TRANSACTIONS" D RD Q:DGQ  I X="" S X="T" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"D - to include DRGs calculated using diagnosis codes from",!?16,"701/702/703 transactions",!?12,"T - to include TRANSFER DRGs based on diagnosis codes from",!?16,"501 transactions",! S %="" G B
 S DGB=$S(X="T":1,1:0)
S W !!,"Choose PTF Status(es) to include:",!?4,"(A)LL STATUSES or",!?4,"(O)PEN,(C)LOSED,(R)ELEASED,(T)RANSMITTED ONLY: ALL// "
 S Z="^ALL STATUSES^OPEN^CLOSED^RELEASED^TRANSMITTED" D RD Q:DGQ  I X="" S X="A" W X
 D IN^DGHELP I %=-1 D H^DGPTODI4 G S
 S DGS=$S(X="A":"A",X="O":0,X="C":1,X="R":2,1:3)
R W !!,"(R)ANGE or (E)XACT MATCH or (A)LL DRGs: ALL// " S Z="^RANGE^EXACT MATCH^ALL" D RD Q:DGQ  I X="" S X="A" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"R - to specify a range of DRGs or",!?12,"A - to select ALL DRGs or",!?12,"E - to specify a DRG to match exactly",! S %="" G R
 S DGR=$S(X="E":0,1:1)
 I X="A" S DGR=2,(DGC1,DGC2)="" G P
 S DIC(0)="AMEZQ",DIC="^ICD(" D E^DGPTODI4:'DGR,RANGE^DGPTODI4:DGR=1 Q:DGQ
P W !!,"Sort by (P)ATIENT NAME or (T)ERMINAL DIGIT ORDER: PATIENT// " S Z="^PATIENT NAME^TERMINAL DIGIT ORDER" D RD Q:DGQ  I X="" S X="P" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"T - to sort by terminal digit order or",!?12,"P - to sort by patient last name",! S %="" G P
 S DGP=$S(X="P":1,1:0)
C W !!,"Choose (I)NCLUDE or (S)UPPRESS NO CODES LISTING: INCLUDE// " S Z="^INCLUDE NO CODES LISTING^SUPPRESS NO CODES LISTING" D RD Q:DGQ  I X="" S X="I" W X
 D IN^DGHELP I %=-1 D C^DGPTODI4 G C
 S DGC=$S(X="I":1,1:0)
 W !!,"You have selected output for: ",!?4,$S(DGD:"Patients discharged between ",1:"Active admissions.")
 I DGD S Y=(DGSD+.1) X ^DD("DD") W ?4,Y," and " S Y=$P(DGED,".") X ^DD("DD") W Y,!?4,$S('DGB:"not ",1:""),"including TRANSFER DRGs with ",$S(DGS="A":"All",DGS=0:"Open",DGS=1:"Closed",DGS=2:"Released",1:"Transmitted")," PTF status"
 W:DGD $S(DGS="A":"es",1:" only"),"." W !?4,"Search for ",$S(DGR=2:"all DRG codes",1:"DRG code: ") W DGC1 W:DGR=1 " to DRG code: ",DGC2 W "."
 W !?4,"No Codes Listing ",$S(DGC:"included",1:"suppressed"),"."
 W !?4,"Sort report by ",$S(DGP:"patient last name.",1:"terminal digit order."),!
OK W "IS THIS CORRECT" S %=1 D YN^DICN I '% W !!?6,"Enter <RET> if this information is correct",!?10,"Enter 'N' for NO to exit",!! G OK
 S:%'=1 DGQ=1 Q
Q K DGD,DGB,DGR,DGC,DGP,DGS,DGC1,DGC2,DGSD,DGED,DGQ,DGPGM,DGVAR,X,Y,Z,DIC,POP,%DT,% Q
