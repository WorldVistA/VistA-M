DENTE2 ;ISC2/SAW,HAG-EDIT OPTIONS CON'T ;4/29/96  13:55
 ;;1.2;DENTAL;**20,24**;JAN 26, 1989
TSE ;EDIT TYPE OF SERVICE EDIT FILE
 W !! S DIC="^DIC(220.3,",DIC(0)="AEMNQ" D ^DIC G EXIT:Y<0 S DA=+Y D LOCK^DENTE1 G DENTE2:DENTL=0 S DR=".01:2",DIE=DIC D ^DIE L  G TSE
TSE1 ;ENABLE RE-RELEASE OF TREATMENT DATA FULL SCREEN
 S DENTFUL=1
TDRR ;ENABLE RE-RELEASE OF TREATMENT DATA LINE BY LINE
 D STA^DENTE3 G EXIT:Y<0
TDR W !,"Would you like to enable a range of treatment data entries for re-release" S %=2 D YN^DICN D:%=0 Q1^DENTQ G TDR:%=0,EXIT:%<0 I %=1 D SRD^DENTE3 G TDRR
 S DIC="^DENT(221,",DIC(0)="AEMNQZ",DIC("S")="I $P(^(0),""^"",40)=DENTSTA,$D(^(.1)),$P(^(.1),""^"")" D ^DIC G EXIT:Y<0 K DIC("S") S (DENT,DA)=+Y D LOCK^DENTE1 G TDRR:DENTL=0
 S A1=$P(Y(0),"^",1) S:A1["." A1=$P(A1,".",1) S A2=$P(Y(0),"^",10)
TDRR0 W !,"Would you like to edit/display this treatment data entry" S %=2 D YN^DICN D:%=0 Q2^DENTQ G TDRR0:%=0 I %<0 L  G TDRR
 I %=1 S DENTREL=1 D:'$D(DENTFUL) TRT^DENTE1 D:$D(DENTFUL) TREAT1^DENTE1
TDRR1 W !,"Are you sure you want to enable this treatment data entry for re-release" S %=2 D YN^DICN D:%=0 Q2^DENTQ G TDRR1:%=0 I %'=1 L  G TDRR
 I $D(^DENT(221,DA,.1)),$P(^(.1),"^",2) K ^DENT(221,"AG",DENTSTA,$P(^(.1),"^",2),DA)
 K ^DENT(221,DA,.1) S ^DENT(221,"A",DENTSTA,A1,DA)="",^DENT(221,"AC",DENTSTA,A1,A2,DA)="" W !,"This treatment data entry can now be re-released." L  G TDRR
FBRR ;ENABLE RE-RELEASE OF FEE BASIS DATA
 D STA^DENTE3 G EXIT:Y<0 S DIC="^DENT(222,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),""^"",28)=DENTSTA,$D(^(.1)),$P(^(.1),""^"")" D ^DIC G EXIT:Y<0 K DIC("S") S (DENT,DA)=+Y D LOCK^DENTE1 G FBRR:DENTL=0
FBRR0 W !,"Would you like edit/display this Fee Basis data entry" S %=2 D YN^DICN D:%=0 Q2^DENTQ G FBRR0:%=0 I %<0 L  G FBRR
 I %=1 S DENTREL=1 D FEE1^DENTE1 G:'$D(^DENT(222,DENT,0)) FBRR
FBRR1 W !,"Are you sure you want to enable this Fee Basis data entry for re-release" S %=2 D YN^DICN D:%=0 Q3^DENTQ G FBRR1:%=0 I %'=1 L  G FBRR
 K ^DENT(222,DENT,.1) W !,"This Fee Basis entry can now be re-released." L  G FBRR
PRR ;ENABLE RE-RELEASE OF PERSONNEL DATA
 D STA^DENTE3 G EXIT:Y<0 S DIC="^DENT(224,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),""^"",10)=DENTSTA,$D(^(.1)),$P(^(.1),""^"")" D ^DIC G EXIT:Y<0 K DIC("S") S B(0)=Y(0),(DENT,DA)=+Y D LOCK^DENTE1 G PRR:DENTL=0
PRR0 W !,"Would you like to edit/display this Personnel data entry" S %=2 D YN^DICN D:%=0 Q2^DENTQ G PRR0:%=0 I %<0 L  G PRR
 I %=1 S DENTREL=1 D PERS1^DENTE1 G:'$O(^DENT(224,DENT,0)) PRR
PRR01 W !,"Would you like to edit/display non-clinical time data entries" S %=2 D YN^DICN D:%=0 Q2^DENTQ G PRR01:%=0 I %<0 L  G PRR
 I %=1 D NCLIN^DENTE0
PRR1 W !,"Are you sure you want to enable this Personnel data entry for re-release" S %=2 D YN^DICN D:%=0 Q3^DENTQ G PRR1:%=0 I %'=1 L  G PRR
 W ! S Y(0)=B(0),A1=$E(Y(0),1,5)_"00",A2=$E(A1,1,5)_31.2359 F I=0:0 S A1=$O(^DENT(226,"A1",DENTSTA,A1)) Q:A1=""!(A1>A2)  S A3="" F J=0:0 S A3=$O(^DENT(226,"A1",DENTSTA,A1,A3)) Q:A3=""  K ^DENT(226,A3,.1) S ^DENT(226,"A",DENTSTA,A1,A3)="" W "."
 K ^DENT(224,DENT,.1) W !,"This Personnel data entry (and all related Non Clinical Time entries)",!,"can now be re-released." L  G PRR
ARR ;ENABLE RE-RELEASE OF ADMIN (CLASS I-VI) DATA
 D STA^DENTE3 G EXIT:Y<0 S DIC="^DENT(223,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),""^"",29)=DENTSTA,$D(^(.1)),$P(^(.1),""^"")" D ^DIC G EXIT:Y<0 K DIC("S") S (DENT,DA)=+Y D LOCK^DENTE1 G ARR:DENTL=0
ARR0 W !,"Would you like to edit/display this Class I-VI data entry" S %=2 D YN^DICN D:%=0 Q2^DENTQ G ARR0:%=0 I %<0 L  G ARR
 I %=1 S DENTREL=1 D ADMIN1^DENTE1 G:'$O(^DENT(223,DENT,0)) ARR
ARR1 W !,"Are you sure you want to enable this Class I-VI data entry for re-release" S %=2 D YN^DICN D:%=0 Q3^DENTQ G ARR1:%=0 I %'=1 L  G ARR
 K ^DENT(223,DENT,.1) W !,"This Class I-VI data entry can now be re-released." L  G ARR
D S Z=$P(Y(0),U),Z1=1700+$E(Z,1,3),Z=+$E(Z,4,5)+2,Z=$P($T(T),";",Z),Z1=Z_" "_Z1 Q
T ;;JANUARY;FEBRUARY;MARCH;APRIL;MAY;JUNE;JULY;AUGUST;SEPTEMBER;OCTOBER;NOVEMBER;DECEMBER
EXIT K %,A1,A2,A3,B,DA,DENT,DENTL,DENTFUL,DENTREL,DIC,DIE,DJDN,DR,I,J,X,Y,Z,Z1 Q
