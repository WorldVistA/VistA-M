SROKEY ;B'HAM ISC/MAM - UPDATE KEYS RESTRICTING ENTRIES ; 9 JAN 1992
 ;;3.0; Surgery ;;24 Jun 93
 W @IOF,!,"Add 'PERSON' Field Restrictions: ",! S SRSOUT=0 K DIC,DA,DO S DIC=1,DIC(0)="QEAMZ",DIC("A")="Select File: " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S SRFILE=Y,DI=+Y,N=0 D DI^DIU I Y<0 S SRSOUT=1 G END
 S SRFILE=DI,SRFIELD=+Y,SRENTRY=DI_","_SRFIELD
 I '$O(^SRP("B",SRENTRY,0)) D ADD G END
 S SRP=$O(^SRP("B",SRENTRY,0))
EXIST ; edit existing entry
 I '$O(^SRP(SRP,1,0)) S ^SRP(SRP,1,0)="^131.03^^"
 I $O(^SRP(SRP,1,0)) W !!,"Keys Currently used to Restrict Entries: "
 I '$O(^SRP(SRP,1,0)) W !!,"There are no keys restricting entries in this field."
 S (CNT,KEY)=0 F  S KEY=$O(^SRP(SRP,1,KEY)) Q:'KEY  S CNT=CNT+1,SRKEY(CNT)=$P(^SRP(SRP,1,KEY,0),"^")_"^"_KEY W:CNT=1 ! W !,?2,CNT_".",?5,$P(SRKEY(CNT),"^")
ANOTHER W !!,"Do you want to add a key ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' or RETURN to enter a key which will be used to restrict",!,"access to this field, or 'NO' if no additional keys are required." G ANOTHER
 I "Yy"[SRYN W ! S CNT=0,Y=1 F  Q:Y<0  K DIC S DIC=19.1,DIC(0)="QEAMZ",DIC("A")="Select Additional Key: " D ^DIC I Y>0 S CNT=CNT+1,ADDKEY(CNT)=$P(Y,"^",2)
 I $D(ADDKEY(1)) W !!,"Entering Keys..."
 S CNT=0 F  S CNT=$O(ADDKEY(CNT)) Q:'CNT  K DA,DD,DO,DIC S DA(1)=SRP,DLAYGO=130.03,DIC(0)="L",DIC="^SRP("_SRP_",1,",X=ADDKEY(CNT) D FILE^DICN K DLAYGO,DIC
END D ^SRSKILL W @IOF
 Q
RET W !!,"Press RETURN to continue, or '^' to quit: " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
ADD ; add entry in PERSON FIELD RESTRICTION file
 W !!,"This field does not exist in the PERSON FIELD RESTRICTION file.  Do you",!,"want to add it ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N",SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter RETURN or 'YES' to add this entry to the file so that restrictions may",!,"be applied, or 'NO' to quit this option." G ADD
 I "Yy"'[SRYN S SRSOUT=1 Q
 K DIC,DD,DINUM,DO,DA S DIC="^SRP(",DIC(0)="L",DLAYGO=131,X=SRENTRY D FILE^DICN S SRP=+Y
 W ! K DIE,DA,DR S DA=SRP,DIE=131,DR="5T;3T" D ^DIE K DR,DA
 Q
