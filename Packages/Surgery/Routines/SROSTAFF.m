SROSTAFF ;B'HAM ISC/MAM - UPDATE STAFF SURGEON INFO ; 2 APR 1992  1:00 pm
 ;;3.0; Surgery ;**18**;24 Jun 93
 S KEY=$O(^DIC(19.1,"B","SR STAFF SURGEON",0))
 S SRSOUT=0 W @IOF,! K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Update Information for which Surgeon: ",DIC("S")="I $L($P(^(0),U,3))" D ^DIC I Y<0 S SRSOUT=1 G END
 S SRSDOC=+Y,SRDOC=$P(Y(0),"^")
 S SRDD=$S($D(^DD(19.12)):"OLD",1:"NEW")
 I $D(^XUSEC("SR STAFF SURGEON",SRSDOC)) D EXISTS G END
ASK W !!,"Do you want to designate this person as a 'Staff Surgeon' ? YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' if this person is a Staff Surgeon, or 'NO' to quit this option." G ASK
 I "Yy"'[SRYN S SRSOUT=1 G END
 D:SRDD="NEW" K7 I SRDD="OLD" D PREK7
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL W @IOF
 Q
K7 ; update key if KERNEL 7 or greater
 K DA,DIC I '$D(^VA(200,SRSDOC,51,0)) S ^VA(200,SRSDOC,51,0)="^"_$P(^DD(200,51,0),"^",2)
 S DA(1)=SRSDOC,DIC="^VA(200,"_SRSDOC_",51,",DIC(0)="LM",DLAYGO=200.051,(DINUM,X)=KEY D FILE^DICN
 W !!,SRDOC_" is now designated as a staff surgeon."
 Q
PREK7 ; update key if KERNEL 6.5 or lower
 K DA,DIC I '$D(^DIC(19.1,KEY,2,0)) S ^DIC(19.1,KEY,2,0)="^"_$P(^DD(19.1,2,0),"^",2)
 S DA(1)=KEY,DIC="^DIC(19.1,"_KEY_",2,",DIC(0)="LM",DLAYGO=19.12,X=SRSDOC D FILE^DICN
 W !!,SRDOC_" is now designated as a staff surgeon."
 Q
EXISTS W !!,"This person is already designated as a staff surgeon.  Do you want to remove",!,"that designation ?  NO//  " R SRYN:DTIME I '$T!("^"[SRYN) S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "NnYy"'[SRYN W !!,"Enter 'YES' to remove the key used to designate this person as a staff",!,"surgeon, or 'NO' to leave this designation unchanged." G EXISTS
 I "Nn"[SRYN S SRSOUT=1 Q
 I SRDD="NEW" D KILLK7 Q
 K SRENTRY S X=0 F  S X=$O(^DIC(19.1,KEY,2,X)) Q:'X!($D(SRENTRY))  I $P(^DIC(19.1,KEY,2,X,0),"^")=SRSDOC S SRENTRY=X
 K DIK S DA=SRENTRY,DA(1)=KEY,DIK="^DIC(19.1,"_DA(1)_",2," W !!,"Removing key designating "_SRDOC_" as a staff surgeon..." D ^DIK
 Q
KILLK7 ; remove key if KERNEL 7 or greater
 K DIK,DA S DA=KEY,DA(1)=SRSDOC,DIK="^VA(200,"_DA(1)_",51," W !!,"Removing key designating "_SRDOC_" as a staff surgeon..." D ^DIK
 Q
