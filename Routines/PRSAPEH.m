PRSAPEH ;HISC/REL-Set Employee Holiday ;08/01/00
 ;;4.0;PAID;**4,58**;Sep 21, 1995
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?29,"SET EMPLOYEE HOLIDAY"
 S PRSTLV=7 D ^PRSAUTL G:TLI<1 EX
 D NOW^%DTC S NOW=%
 S %DT="X",X="T+5" D ^%DT
 S %DT="AEPX",%DT("A")="Benefit Date: ",%DT(0)=-Y W ! D ^%DT G:Y<1 EX
 S Y=$G(^PRST(458,"AD",Y)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I PPI="" W !!,*7,"Pay Period is Not Open Yet!" G EX
NME K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE,$D(^PRST(458,PPI,""E"",+Y))",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 G:DFN<1 EX
 I '$D(^PRST(458,PPI,"E",DFN,"D",DAY,0)) W *7,!!,"No Time record exists for that date." G NME
 I $P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12) W !!,"This date already flagged as a Holiday Benefit Day." G NME
 I "T"'[$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2) G P1
 K ^PRST(458,PPI,"E",DFN,"D",DAY,2),^(3),^(10)
 S TT="HX",LLL=DT,DUP=1 D S0^PRSAPPH
P1 W "  ... done" G NME
THANK ; Thanksgiving Correction
 S PPI=$O(^PRST(458,"B","95-23",0)) I 'PPI W !,"PayPeriod 95-23 not found in File 458." G EX
 S HOL(2951123)=12 D NOW^%DTC S NOW=%
 F DFN=0:0 S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  S TT="HX",DUP=0 D E^PRSAPPH
EX G KILL^XUSCLEAN
