PRSATPD ; HISC/REL-Payroll Clear Prior Exceptions ;8/30/95  09:16
 ;;4.0;PAID;;Sep 21, 1995
 R !!,"Select T&L Unit (or ALL): ",X:DTIME G:'$T!("^"[X) EX S X=$TR(X,"al","AL") I X="ALL" S TLE="" G L1
 K DIC S DIC="^PRST(455.5,",DIC(0)="EMQ" D ^DIC G EX:$D(DTOUT),PRSATPD:Y<1
 S TLE=$P(Y,"^",2)
L1 S PRSTLV=3 D Q1 G EX
Q1 ; Process List
 D NOW^%DTC S DT=%\1,(PG,QT)=0 D HDR I TLE'="" D Q2 G:QT EX D:$Y>3 H1 G EX
 S PDA=0 F  S PDA=$O(^PRST(458.5,PDA)) Q:PDA'>0  I '$P($G(^PRST(458,PDA,0)),"^",6) D  G:QT EX
 .S DFN=$P($G(^PRST(458.5,PDA,0)),"^",2) Q:'DFN  D CHK
 .Q:'$D(^PRST(458.5,"C",DFN,PDA))
 .S Y0=$G(^PRSPC(DFN,0)) D PRT Q
 D:$Y>3 H1 G EX
Q2 S NX="" F  S NX=$O(^PRSPC("ATL"_TLE,NX)) Q:NX=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NX,DFN)) Q:DFN<1  I $D(^PRST(458.5,"C",DFN)) D  G:QT Q3
 .F PDA=0:0 S PDA=$O(^PRST(458.5,"C",DFN,PDA)) Q:PDA<1  D CHK
 .Q:'$D(^PRST(458.5,"C",DFN))
 .S Y0=$G(^PRSPC(DFN,0))
 .F PDA=0:0 S PDA=$O(^PRST(458.5,"C",DFN,PDA)) Q:PDA<1  D PRT Q:QT
 .Q
Q3 Q
CHK ; Check Exception
 S X=$G(^PRST(458.5,PDA,0)),PDTI=$P(X,"^",3) Q:'PDTI  Q:$P(X,"^",6)
 S Y=$G(^PRST(458,"AD",PDTI)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2) Q:'PPI
 S ESTR=$P(X,"^",5)_"^"_$P(X,"^",4)
 D ^PRSATPE I '$D(ER) S DA=PDA D REM^PRSATPF Q
 F K=0:0 S K=$O(ER(K)) Q:K<1  I ER(K)=ESTR K ER(K) G C1
 S DA=PDA D REM^PRSATPF
C1 F K=0:0 S K=$O(ER(K)) Q:K<1  S X1=PDTI,X2=ER(K) D ^PRSATPF
 Q
PRT ; List entries
 S X=$G(^PRST(458.5,PDA,0)),PDTI=$P(X,"^",3),TIM=$P(X,"^",4),TXT=$P(X,"^",5) Q:'PDTI  Q:$P(X,"^",6)
 I $Y>(IOSL-6) D HDR Q:QT
 W !!,$P(Y0,"^",1) W:$P(Y0,"^",8)'="" " (",$P(Y0,"^",8),")"
 S X=PDTI D DTP^PRSAPPU W !?5,Y W:TIM'="" ?16,TIM W ?24,TXT
P0 R !!,"Clear Prior Pay Period Exception? ",X:DTIME S:'$T!(X["^") QT=1 Q:QT  S X=$TR(X,"yesno","YESNO")
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES to Clear or NO or RETURN to bypass" G P0
 I X'?1"Y".E Q
 D NOW^%DTC S $P(^PRST(458.5,PDA,0),"^",6,8)="1^"_DUZ_"^"_% Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?26,"PRIOR PAY PERIOD EXCEPTIONS"
 S X=DT D DTP^PRSAPPU W !?35,Y Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
