PSDEST ;BIR/BJW-Destroy a Drug from the Holding file ; 9 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**, "P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSDMGR",DUZ)) W !!,"Please contact your Pharmacy Coordinator for access to",!,"destroy Controlled Substances.",!!,"PSDMGR security key required.",! G END
 S PSDUZ=DUZ
 I PSDUZ S PSDUZAN=$P($G(^VA(200,+PSDUZ,0)),"^")
SETDATE ;7/17/96,inital set to current date
 S PSDT=DT
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) ASKN
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
ASKN ;ask holding number
 W !!,?3,"**Searching for the next available drug awaiting destruction**",!
 K DIC,DA S DIC=58.86,DIC("A")="Select Destructions #: ",DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",7)=PSDS"
 F PSD=0:0 S PSD=$O(^PSD(58.86,PSD)) Q:'PSD!($D(DIC("B")))  I $D(^PSD(58.86,PSD,0)),'+$P(^(0),"^",10),+$P(^(0),"^",7)=+PSDS S DIC("B")=PSD
 D ^DIC K DA,DIC G:Y<0 END S PSDA=+Y
 W !!,?3,"**You Must enter a DATE to destroy or cancel this Holding Num**"
DISPLAY ;
 K LN S $P(LN,"-",30)="",PSDR=$P(Y(0),"^",2),PSDRN=$S($P($G(^PSD(58.86,PSDA,1)),"^")]"":$P($G(^PSD(58.86,PSDA,1)),"^"),1:$P($G(^PSDRUG(+PSDR,0)),"^")),NUM=$P(Y(0),"^"),QTY=$P(Y(0),"^",3)
 S PSDCT=$S($P(Y(0),"^",8)]"":$P(Y(0),"^",8),1:1),NBKU=$S($P(Y(0),"^",12)]"":$P(Y(0),"^",12),1:$P($G(^PSD(58.8,+PSDS,1,+PSDR,0)),"^",8))
 S PSDCAN=$P($G(^PSD(58.86,PSDA,3)),"^") I PSDCAN S Y=PSDCAN X ^DD("DD") S PSDCAN=Y D MSG2 G ASKN
 S PSDST=$P(Y(0),"^",11) I PSDST S Y=PSDST X ^DD("DD") S PSDST=Y D MSG1 G ASKN
 W @IOF,!,"HOLDING FOR DESTRUCTION",!,LN,!!,"Holding Number: ",NUM
 W !,"Drug: ",PSDRN,!,"Quantity "_$S($D(^PSD(58.8,+PSDR,0)):"("_NBKU_")",1:"")_": ",QTY,!
OK ;ask ok
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to destroy this Controlled Substances"
 S DIR("?",1)="Answer 'YES' if you are destroying this drug,",DIR("?")="answer 'NO' and this drug will remain pending destruction."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 S ANS=Y(0) I ANS="YES" D DATE G:'$D(PSDT) END G DIE
 I ANS="NO" G OK1 G:'$D(PSDT) END
DATE ; ask date,7/17/96 added %DT("B")default date or user can enter new date
 K %DT W !
 S %DT="AEPTX",%DT(0)="-NOW",%DT("A")="DATE DESTROYED/CANCELLED: ",%DT("B")=$$FMTE^XLFDT(PSDT) D ^%DT G:Y<0 END S PSDT=Y W !
 Q
OK1 ;ask if entry error
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="NO",DIR("A")="Was this a destruction holding number entry error"
 S DIR("?",1)="Answer 'NO' drug will be destroyed,",DIR("?")="answer 'YES' and this drug will not be destroyed."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
OK2 ;ask do you want to cancel holding #,E3R# 4990
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to cancel this destruction holding number"
 S DIR("?",1)="Answer 'NO' if you do not want to cancel this destruction holding number,",DIR("?")="answer 'YES' and the destruction holding number will be cancelled."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 I 'Y DO MSG G ASKN
DIRC ;enter reason,date and pharmacist cancelling holding #,E3R# 4990
 W !! D DATE G:'$D(PSDT) END
 K DA,DIR,DIRUT S DIR(0)="58.86,17" D ^DIR K DIR I $D(DIRUT) D MSG G END
 S PSDCOM3=Y
 K DIRUT,DTOUT,DUOUT
 I PSDT S (Y,YYY)=PSDT X ^DD("DD") S PSDT=Y
 W !,"DATE/TIME CANCELLED: ",PSDT
 W !,"CANCELLED BY: ",PSDUZAN
DIE1 ;update 58.86 for cancelling holding #,E3R# 4990
 ;The AC,AD X-ref's entries are built on the condition that data is in
 ;Field 10(date/time destroyed),11/29/95 added I $D(Y) 
 K DA,DIE,DR S DA=PSDA,DIE=58.86,DR="9////"_PSDUZ_";10///"_PSDT_";15///"_PSDT_";16////"_PSDUZ_";17////"_PSDCOM3_";11///^S X=PSDCT;12///^S X=NBKU" D ^DIE K DA,DIE,DR I $D(Y) D MSG G END
 W !!,"Holding Number: ",NUM,?19," flagged as entry error"
 S PSDT=YYY G ASKN
DIE ;update 58.86
 ;10/22/96 added / to fld#11,12 to remove prompt;11/29/95 added I $D(Y)
 W !,?3,"** Updating the record **",! K DA,DIE,DR S DA=PSDA,DIE=58.86,DR="9////"_PSDUZ_";10///"_PSDT_";11///^S X=PSDCT;12///^S X=NBKU" D ^DIE K DA,DIE,DR
 I $D(Y) D MSG G END
 W !!,?3,"=> Holding Number: ",NUM," has been destroyed.",!!
 G ASKN
END K %,%DT,%H,%I,ANS,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,LN,NBKU,NUM
 K PSD,PSDA,PSDCAN,PSDCOM3,PSDR,PSDRN,PSDCT,PSDS,PSDSN,PSDT,PSDST,PSDUZ,PSDUZAN,QTY,X,Y,YYY
 Q
MSG W !!,"No action taken",!!
 Q
MSG1 ;msg when already destroyed
 W $C(7),!!,"Drug: ",PSDRN,!,"=> Destruction #: ",NUM," was destroyed on ",PSDST,".",!!
 Q
MSG2 ;msg when cancelled,E3R# 4990
 W $C(7),!!,"Drug: ",PSDRN,!,"=> Destruction #: ",NUM," was cancelled on ",PSDCAN,".",!!
 Q
