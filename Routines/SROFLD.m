SROFLD ;B'HAM ISC/MAM - GET FILE & FIELD FOR KEY RESTRICTION ; 10 DEC 1992  11:45 AM
 ;;3.0; Surgery ;;24 Jun 93
 S SRSOUT=0 K DIC,DA,DO S DIC=1,DIC(0)="QEAMZ",DIC("A")="Select File: " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S SRFILE=Y,DI=+Y,N=0 D DI^DIU I Y<0 S SRSOUT=1 G END
 S SRFILE=DI,SRFIELD=+Y,SRENTRY=DI_","_SRFIELD
 I '$O(^SRP("B",SRENTRY,0)) D ADD G END
 S SRP=$O(^SRP("B",SRENTRY,0))
 Q
END D ^SRSKILL W @IOF
 Q
ADD ; add entry in PERSON FIELD RESTRICTION file
 W !!,"This field does not exist in the PERSON FIELD RESTRICTION file.  Do you",!,"want to add it ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N",SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter RETURN or 'YES' to add this entry to the file so that restrictions may",!,"be applied, or 'NO' to quit this option." G ADD
 I "Yy"'[SRYN S SRSOUT=1 Q
 K DIC,DD,DINUM,DO,DA S DIC="^SRP(",DIC(0)="L",DLAYGO=131,X=SRENTRY D FILE^DICN S SRP=+Y
 W ! K DIE,DA,DR S DA=SRP,DIE=131,DR="5T;3T" D ^DIE K DR,DA
 Q
