ENEQPMP ;(WASH ISC)/JED/DH-Establish PMI Parameters ;4.1.98
 ;;7.0;ENGINEERING;**35,52**;Aug 17, 1993
 ;
HDR W @IOF,!!,"PREVENTIVE MAINTENANCE PARAMETERS",!,"Version ",^ENG("VERSION") Q
PMSE ;DEVICE PM EDIT
 I '$D(^XUSEC("ENEDPM",DUZ)) W !!,"Sorry, you need Security Key 'ENEDPM'." D HLD Q
 W @IOF,!! S DIC(0)="AEQM",(DIC,DIE)="^ENG(6914," D ^DIC G:Y'>0 EXIT S DA=+Y
XNPMSE Q:'$D(DA)  I $P($G(^ENG(6914,DA,4,0)),U,4)>0 W !,"Would you like to see the existing PM schedule for this device" S %=1 D YN^DICN G:%=0 XNPMSE I %=1 D DINV^ENEQPMP3 Q:$G(ENX)="^"  G PMSE2
 I $P($G(^ENG(6914,DA,1)),U)]"" G PMSE1
 I $G(ENXP)=2 G PMSE1
 W !,"There is no EQUIPMENT CATEGORY on file for this item. Would you",!,"like to enter one now" S %=1 D YN^DICN G:%=2 PMSE2 Q:%<1  S DR="6" D ^DIE I '$D(^ENG(6914,DA,1)) S ^ENG(6914,DA,1)=""
PMSE1 I $P($G(^ENG(6914,DA,1)),U)="" G PMSE2
 S ENDTYP=$P($G(^ENG(6914,DA,1)),U),ENDVTYP=$P($G(^ENG(6911,ENDTYP,0)),U) W !,"Equipment Category is: ",ENDVTYP I '$D(^ENG(6911,ENDTYP,4)) W !,"There is no defined PM schedule for this category." G PMSE2
 I $D(^ENG(6911,ENDTYP,4)) W !,"Would you like to see the standard PM schedule for this Equipment Category" S %=1 D YN^DICN G:%=-1 EXIT G:%=0 PMSE1 D:%=1 DDT^ENEQPMP3
PMSE10 I $D(^ENG(6911,ENDTYP,4)) W !,"Should this item be given the standard PM schedule for devices",!,"of category ",ENDVTYP S %=1 D YN^DICN G:%=2 PMSE2 I %=0 D PMSEH1 G PMSE10
 I %'>0 G EXIT
 D PMSE3 S I=0 F  S I=$O(^ENG(6914,DA,4,I)) Q:I'>0  I '$D(^(I,1)) S J=0 F  S J=$O(^ENG(6914,DA,4,I,2,J)) Q:J'>0  S ENA=$P(^(J,0),U) I ENA'="M",ENA'["W" D PMSESM Q
 G:'$D(ENXP) PMSE G EXIT
PMSESM S ENSH=$P(^ENG(6914,DA,4,I,0),U),ENSHOP=$P(^DIC(6922,ENSH,0),U) W !!,"PM Schedule for ",ENSHOP," Shop may need a STARTING MONTH."
 S DIE="^ENG(6914,"_DA_",4,",DA=1,DR="2" D ^DIE
 Q
 ;
PMSE2 S DR="[ENEQPMP]" D ^DIE G:'$D(ENXP) PMSE
 G EXIT
 ;
PMSE3 N ENX,DIE,DR
 S I=0 F  S I=$O(^ENG(6914,DA,4,I)) Q:I'>0  I $D(^ENG(6914,DA,4,I,0)),$D(^(1)) S ENB=$P(^ENG(6914,DA,4,I,0),U),ENB(ENB)=^ENG(6914,DA,4,I,1)
 K ^ENG(6914,DA,4) S %X="^ENG(6911,ENDTYP,4,",%Y="^ENG(6914,DA,4," D %XY^%RCR K %X,%Y
 S I=0 F  S I=$O(^ENG(6914,"AB",I)) Q:I'>0  K ^ENG(6914,"AB",I,DA)
 S I=0 F  S I=$O(^ENG(6914,DA,4,I)) Q:I'>0  S ENA=$P(^ENG(6914,DA,4,I,0),U,1),^ENG(6914,"AB",ENA,DA,I)=""
 I $D(^ENG(6914,DA,4,0)) S $P(^(0),U,2)="6914.04P" F I=0:0 S I=$O(^ENG(6914,DA,4,I)) Q:I'>0  S $P(^ENG(6914,DA,4,I,2,0),U,2)="6914.43SA"
 I $D(ENB)\10 F I=0:0 S I=$O(ENB(I)) Q:I'>0  S J=$O(^ENG(6914,DA,4,"B",I,0)) I J>0 S:'$D(^ENG(6914,DA,4,J,1)) ^(1)=ENB(I) Q:'$D(^(1))  I ^(1)']"" S ^(1)=ENB(I)
 S ENX=$P(^ENG(6911,ENDTYP,0),U,3) I ENX]"" D
 . S DIE="^ENG(6914,"
 . S DR="27///^S X=ENX" D ^DIE
 K ENB Q
 ;
PMSEH1 W !,"'YES' will cause the system to automatically assign the standard PM schedule.",!,"'NO' will enable you to enter a special schedule for this device." Q
HLD I $E(IOST,1,2)="C-" R !,"Press <RETURN> to continue...",ENX:DTIME
 Q
EXIT Q:$G(ENXP)=2  G EXIT^ENEQPMP1
 ;ENEQPMP
