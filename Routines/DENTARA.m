DENTARA ;ISC2/HAG-RELEASE ALL SERVICE REPORT ; 11/3/88  6:19 PM ;
 ;;1.2;DENTAL;**1,9,24**;JAN 26, 1989
 W !! K ^UTILITY($J,"DENTERR"),^UTILITY($J,"DENTV"),^UTILITY($J,"DENTR"),^UTILITY($J,"DENTP") S Z5="",Z1=0 G W:'$D(^DENT(225,0)) F Z3=0:1:2 S Z1=$O(^(Z1)) Q:Z1'>0  S Z2=Z1
 G:Z3=0 W I Z3>1 S DIC="^DENT(225,",DIC(0)="AEMNQZ",DIC("A")="Select STATION.DIVISION: " S:$D(DENTSTA) DIC("B")=$S(DENTSTA[" ":+DENTSTA,1:DENTSTA) D ^DIC Q:Y<0  K DIC("A"),DIC("B")
 S Z1=$S(Z3=1:Z2,1:+Y) S (DENTSTA,Z3)=$P(^DENT(225,Z1,0),U,1),DENTZ1=Z3 I DENTSTA="" D W S Y=-1 Q
 S:$L(DENTSTA)=3 DENTSTA=DENTSTA_"  "
D1 W !!,"Enter the starting and ending dates you wish to release. ",!
 S %DT("A")="STARTING DATE: ",%DT="AEPX" D ^%DT K %DT("A") G EXIT:Y<0 S DENTSD=Y,(TD,SD)=DENTSD-.0001 X ^DD("DD") S H1=Y
D2 S %DT("A")="ENDING DATE: ",%DT="AEPX" D ^%DT K %DT("A") G EXIT:Y<0 S DENTED=Y+.24 X ^DD("DD") S H2=Y
 I DENTED<SD W *7,!!,"End date before Start Date?" G D1
CLASS ;CLASS I-VI
 W @IOF,!!,?10,"Processing Class I-VI report",! R F1:2
 F F1=0:0 S X3=223,SD=$O(^DENT(223,"B",SD)) Q:SD>DENTED!(SD'>0)  S DENT1=$O(^(+SD,0)) Q:DENT1'>0  S D2=$P(^DENT(223,DENT1,0),"^",29) I $S(D2'=DENTZ1:0,'$D(^(.1)):1,'$P(^(.1),"^",2):1,1:0) D S,^DENTAR3,EN1^DENTAR S F1=1
 I 'F1 W !,"There is no Class I-IV data to release for the timeframe you specified",*7 R X:3
PERS ;PERSONAL REPORT
 W @IOF,!!,?10,"Processing Adminstrative Personnel report",! R F1:3 S SD=TD
 F F1=0:0 S X3=224,SD=$O(^DENT(224,"B",SD)) Q:SD>DENTED!(SD'>0)  S DENT1=$O(^(+SD,0)) Q:DENT1'>0  S D2=$P(^DENT(224,DENT1,0),"^",10) I $S(D2'=DENTZ1:0,'$D(^(.1)):1,'$P(^(.1),"^",2):1,1:0) D S,^DENTAR4 I '$D(DENTF) D EN1^DENTAR S F1=1
 I 'F1 W !,"There is no personnel data to release for the timeframe you specified",*7 R X:3
 K DENTF
FEE ;FEE BASIS REPORT
 W @IOF,!!,?10,"Processing Applications and Dental Fee report",! R F1:2 S SD=TD
 F F1=0:0 S X3=222,SD=$O(^DENT(222,"B",SD)) Q:SD>DENTED!(SD'>0)  S DENT1=$O(^(+SD,0)) Q:DENT1'>0  S D2=$P(^DENT(222,DENT1,0),"^",28) I $S(D2'=DENTZ1:0,'$D(^(.1)):1,'$P(^(.1),"^",2):1,1:0) D S,^DENTAR5,EN1^DENTAR S F1=1
 I 'F1 W !,"There is no applications and dental fee data to release for the time frame",!,"you specified",*7 R X:3
TREAT ;TREATMENT REPORT
 W @IOF,!!,?10,"Processing Treatment data report",! R F1:2 S Z3=DENTZ1
 D NOREV^DENTAR16 D:'$D(DENTF1) EN1^DENTAR1
 G EXIT
S S (DENTY0,Y(0))=^DENT(X3,DENT1,0),Z2=DENTZ1,(DENT,Z)=$P(Y(0),"^"),Z1=1700+$E(Z,1,3),Z=+$E(Z,4,5)+2,Z=$P($T(DATE),";",Z),Z1=Z_" "_Z1,Z3="STATION NUMBER: "_Z2 Q
DATE ;;JANUARY;FEBRUARY;MARCH;APRIL;MAY;JUNE;JULY;AUGUST;SEPTEMBER;OCTOBER;NOVEMBER;DECEMBER
W W !!,"Stations have not been entered in the Dental Site Parameter file.",!,"You must enter a station before you can use this option" G EXIT
EXIT K %,A,D2,DENT,DENTZ1,DENT1,DENT2,DENTF,DENTF1,DIC,F1,I,S,SD,TD,J,O,K,X,XX,X1,X2,X3,X4,Y,Z,Z1,Z2,Z3 Q
