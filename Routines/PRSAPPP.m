PRSAPPP ; HISC/REL-Payroll Process Prior PP ;5/31/95  10:00
 ;;4.0;PAID;**114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S PRSTLV=7
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?26,"PRIOR PAY PERIOD CORRECTIONS"
R0 R !!,"Select T&L Unit (or ALL): ",X:DTIME G:'$T!("^"[X) EX S X=$TR(X,"al","AL") I X="ALL" S TLE=""
 E  K DIC S DIC="^PRST(455.5,",DIC(0)="EMQ" D ^DIC G EX:$D(DTOUT),R0:Y<1 S TLE=$P(Y,"^",2)
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSAPPP",PRSALST="TLE" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Process List
 D NOW^%DTC S DTP=% D DTP S (PG,QT)=0 S LNE="" S $P(LNE,"-",80)=""
 F DFN=0:0 S DFN=$O(^PRST(458,"AXA",DFN)) Q:DFN<1  D CHK I L1 F PPI=0:0 S PPI=$O(^PRST(458,"AXA",DFN,PPI)) Q:PPI<1  F AUN=0:0 S AUN=$O(^PRST(458,"AXA",DFN,PPI,AUN)) Q:AUN<1  D PROC G:QT Q2
Q2 Q
PROC ; Process
 D HDR Q:QT  S PPE=$P($G(^PRST(458,PPI,0)),"^",1) D HDR^PRSADP1 W !,LNE
 S X0=$G(^PRST(458,PPI,"E",DFN,"X",AUN,0)),TYP=$P(X0,"^",4)
 D TM:TYP="T",VC:TYP="V",HZ:TYP="H"
 I $D(^PRST(458,PPI,"E",DFN,"X",AUN,7)) W !!,"Change Remarks: ",^(7)
 D:$E(IOST,1,2)="C-" CLR Q
TM ; Process Time/Tour Change
 W !?29,"* * * Prior Data * * *" S IFN=AUN  S DAY=$P($G(^PRST(458,PPI,"E",DFN,"X",IFN,1)),"^",1),DTE=$P($G(^PRST(458,PPI,2)),"^",+DAY) D GET,DIS^PRSAPPQ
 W !,LNE W !?27,"* * * Corrected Data * * *" S IFN=AUN+1 D GET D DIS^PRSAPPQ
 W !,LNE Q
VC ; Process VCS Sales Change
 W !?29,"* * * Prior Data * * *" S IFN=AUN D GET S Z=AUR(1) D VCS^PRSAPPQ
 W !,LNE W !?27,"* * * Corrected Data * * *" S IFN=AUN+1 D GET S Z=AUR(1) D VCS^PRSAPPQ
 W !,LNE Q
HZ ; Process Hazard Change
 W !?29,"* * * Prior Data * * *" S IFN=AUN D GET S Z=AUR(1) D ED^PRSAPPQ
 W !,LNE W !?27,"* * * Corrected Data * * *" S IFN=AUN+1 D GET S Z=AUR(1) D ED^PRSAPPQ
 W !,LNE Q
GET ; Get Data Array
 K AUR S AUC=0 I '$D(^PRST(458,PPI,"E",DFN,"X",IFN)) S IFN=$O(^(IFN)) I IFN<1 S AUC=1 G G1 ;Get current data
 I $P($G(^PRST(458,PPI,"E",DFN,"X",IFN,0)),"^",4)'=TYP S IFN=IFN+1 G GET
 I TYP="T",$P($G(^PRST(458,PPI,"E",DFN,"X",IFN,1)),"^",1)'=DAY S IFN=IFN+1 G GET
 F L1=1:1:$S(TYP="T":6,1:1) S AUR(L1)=$G(^PRST(458,PPI,"E",DFN,"X",IFN,L1))
 Q
G1 I TYP'="T" G G2
 S L2=0 F L1=0,1,2,10,3,4 S L2=L2+1,AUR(L2)=$G(^PRST(458,PPI,"E",DFN,"D",DAY,L1))
 Q
G2 I TYP="H" S AUR(1)=$G(^PRST(458,PPI,"E",DFN,4))
 I TYP="V" S AUR(1)=$G(^PRST(458,PPI,"E",DFN,2))
 Q
CHK ; Screen Employee for Selected T&L
 S L1=1 Q:TLE=""  S:$P($G(^PRSPC(DFN,0)),"^",8)'=TLE L1=0 Q
CLR ; Clear Entries
 R !!,"Clear Correction? ",X:DTIME S:'$T!(X["^") QT=1 Q:QT  S X=$TR(X,"yesno","YESNO")
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G CLR
 I X'?1"Y".E Q
 D NOW^%DTC S $P(^PRST(458,PPI,"E",DFN,"X",AUN,0),"^",5,7)="P^"_DUZ_"^"_%
 K ^PRST(458,"AXA",DFN,PPI,AUN)
 W " ... done." Q
HDR ; Display Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 Q:$E(IOST,1,2)="C-"
 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?26,"PRIOR PAY PERIOD CORRECTIONS"
 W !!?(80-$L(DTP)\2),DTP Q
DTP ; Printable Date/Time
 S %=DTP,DTP=$J(+$E(DTP,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(DTP,4,5))_"-"_$E(DTP,2,3)
 S:%#1 %=+$E(%_"0",9,10)_"^"_$E(%_"000",11,12),DTP=DTP_$J($S(%>12:%-12,1:+%),3)_":"_$P(%,"^",2)_$S(%<12:"am",%<24:"pm",1:"m") K % Q
EX G KILL^XUSCLEAN
