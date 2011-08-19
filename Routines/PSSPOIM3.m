PSSPOIM3 ;BIR/RTR/WRT-Initial Solution and Additive matching ; 10/09/97 13:08
 ;;1.0;PHARMACY DATA MANAGEMENT;**2**;9/30/97
 ;
 S (PSSSSS1,PSOOOUT)=0,PSSSSS=1
 S X1=DT,X2=-365 D C^%DTC S PSXDATE=X
 W !!?5,"MATCHING IV ADDITIVES!",! S BBBBB="" F  S BBBBB=$O(^PS(52.6,"B",BBBBB)) Q:BBBBB=""!($G(PSOOOUT))  F AAAA=0:0 S AAAA=$O(^PS(52.6,"B",BBBBB,AAAA)) Q:'AAAA!($G(PSOOOUT))  I AAAA,$D(^PS(52.6,AAAA,0)),'$P(^(0),"^",11),$P(^(0),"^",2) D
 .S BBBB=+$P(^PS(52.6,AAAA,0),"^",2) Q:'$D(^PSDRUG(BBBB,0))
 .S PSXADATE=+$P($G(^PS(52.6,AAAA,"I")),"^") I PSXADATE,PSXADATE<PSXDATE Q
 .S PSSSSS1=1
 .S PSAIEN=AAAA,PSANAME=$P(^PS(52.6,PSAIEN,0),"^"),PSDISP=$P(^(0),"^",2),PSPOI=$P(^(0),"^",11) W !,"IV Additive ->  ",PSANAME,! S PSSSSS=1 D ENTER^PSSADDIT
 .W ! K DIR S DIR(0)="Y",DIR("A")="Continue matching IV Additives",DIR("B")="YES" D ^DIR W !! K DIR I Y'=1 S PSOOOUT=1
 I 'PSSSSS1 W !?3,"IV Additives are all matched!",!
 I $G(PSOOOUT) G END
SOL K PSPOI S PSSSSS1=0,PSSSSS=1
 W !!?5,"MATCHING IV SOLUTIONS!",! S AAAAA="" F  S AAAAA=$O(^PS(52.7,"B",AAAAA)) Q:AAAAA=""!($G(PSOOOUT))  F AAAA=0:0 S AAAA=$O(^PS(52.7,"B",AAAAA,AAAA)) Q:'AAAA!($G(PSOOOUT))  I AAAA,$D(^PS(52.7,AAAA,0)),'$P(^(0),"^",11),$P(^(0),"^",2) D
 .S BBBB=+$P(^PS(52.7,AAAA,0),"^",2) Q:'$D(^PSDRUG(BBBB,0))
 .S PSXSDATE=+$P($G(^PS(52.7,AAAA,"I")),"^") I PSXSDATE,PSXSDATE<PSXDATE Q
 .S PSSSSS1=1
 .S PSSIEN=AAAA,PSSNAME=$P(^PS(52.7,AAAA,0),"^"),PSDISP=$P(^(0),"^",2),PSSOI=$P(^(0),"^",11),PSSVOL=$P(^(0),"^",3) W !!,"IV Solution -> ",PSSNAME,"   ",PSSVOL S PSSSSS=1 D ENTER^PSSSOLIT
 .W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Continue matching IV Solutions" D ^DIR W !! K DIR I Y'=1 S PSOOOUT=1
 I 'PSSSSS1 W !?3,"IV Solutions are all matched!",!
END K PSSSSS1,AAAA,BBBB,CCCC Q
 ;
DIR I $G(PSOIEN),$D(^PS(50.7,PSOIEN)),$P(^PS(50.7,PSOIEN,0),"^",4)]"" W !!,"This Orderable Item is Inactive.   ***" S Y=$P(^PS(50.7,PSOIEN,0),"^",4) X ^DD("DD") W ?43,Y,!
 I $G(PSSOI),$D(^PS(50.7,PSSOI)),$P(^PS(50.7,PSSOI,0),"^",4)]"" W !!,"This Orderable Item is Inactive.   ***" S Y=$P(^PS(50.7,PSSOI,0),"^",4) X ^DD("DD") W ?43,Y,!
 I $G(PSPOI),$D(^PS(50.7,PSPOI)),$P(^PS(50.7,PSPOI,0),"^",4)]"" W !!,"This Orderable Item is Inactive.   ***" S Y=$P(^PS(50.7,PSPOI,0),"^",4) X ^DD("DD") W ?43,Y,!
 K DIR,PSSDIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Edit Orderable Item" D ^DIR K DIR I Y=1 S PSSDIR=1
 Q
