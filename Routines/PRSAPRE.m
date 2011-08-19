PRSAPRE ; HISC/MGD-Add Employee to Pay Period ;03/03/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S DIC="^PRST(458,",DIC(0)="AEQM",DIC("A")="Select PAY PERIOD: " W ! D ^DIC K DIC G:Y<1 EX S PPI=+Y
 S D1=$P($G(^PRST(458,PPI,1)),"^",14),X1=D1,X2=5 D C^%DTC I DT>X W *7,!!,"This Pay Period ended more than 5 days ago!" G EX
 D ^PRSAPPH
 N MIEN
P0 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC(" W ! D ^DIC S DFN=+Y K DIC
 G:DFN<1 EX
 I $D(^PRST(458,PPI,"E",DFN)) W *7,!!,"Pay Period Already Open for this Employee." G P0
 I $P($G(^PRSPC(DFN,"LWOP")),"^",1)="Y" W !!,"Warning: 30-day LWOP Indicator is set."
 I $P($G(^PRSPC(DFN,1)),"^",20)="Y" W !!,"Warning: No-Pay Indicator is set."
 I $P($G(^PRSPC(DFN,1)),"^",33)'="N" W !!,"Warning: Separation Indicator is not N."
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8) I TLE="" W !!,"Warning: No T&L Unit has been specified."
OK R !!,"OK to Create Record for this Employee? ",X:DTIME G:'$T!(X["^") EX S:X="" X="*" S X=$TR(X,"yesno","YESNO")
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G OK
 G P0:X?1"N".E,P2:TLE'=""
P1 K DIC S DIC="^PRST(455.5,",DIC(0)="AEQM" W ! D ^DIC K DIC G EX:$D(DTOUT),EX:$D(DUOUT),P1:Y<1
 S TLE=$P(Y,"^",2)
 S DA=DFN,DIE="^PRSPC(",DR="7////^S X=TLE" D ^DIE
P2 S PPIP=PPI-1
 S MIEN=$$MIEN^PRSPUT1(DFN,+$G(^PRST(458,PPI,1)))
 D MOV^PRSAPPO I $D(HOL) D NOW^%DTC S NOW=%,TT="HX",DUP=0 D E^PRSAPPH
 W !!?5,"Pay Period opened for this Employee." G P0
EX G KILL^XUSCLEAN
