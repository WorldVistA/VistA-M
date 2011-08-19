SROKEY1 ;B'HAM ISC/MAM - REMOVE KEY RESTRICTIONS ; 9 JAN 1992
 ;;3.0; Surgery ;;24 Jun 93
 W @IOF,!,"Remove 'PERSON' field restrictions: ",! S SRSOUT=0 K DIC,DA,DO S DIC=1,DIC(0)="QEAMZ",DIC("A")="Select File: " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S SRFILE=Y,DI=+Y,N=0 D DI^DIU I Y<0 S SRSOUT=1 G END
 S SRFILE=DI,SRFIELD=+Y,SRENTRY=DI_","_SRFIELD
 I '$O(^SRP("B",SRENTRY,0)) W !!,"There are no restrictions currently applied to this field.",!!,"Press RETURN to continue " R X:DTIME G END
 S SRP=$O(^SRP("B",SRENTRY,0))
 I '$O(^SRP(SRP,1,0)) W !!,"There are no keys restricting entries in this field.",!!,"Press RETURN to continue " R X:DTIME G END
 W @IOF,!,"Current Restrictions for this Field: ",!
 S (CNT,KEY)=0 F  S KEY=$O(^SRP(SRP,1,KEY)) Q:'KEY  S CNT=CNT+1,SRKEY(CNT)=$P(^SRP(SRP,1,KEY,0),"^")_"^"_KEY W !,?2,CNT_".",?5,$P(SRKEY(CNT),"^")
 I '$D(SRKEY(2)) S NUMBER=1 D ONE G END
REMOVE W !!,"Do you want to remove one of these keys ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N" Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' if you want to remove one of the keys currently used to restrict",!,"entries in this field.  Enter 'NO' if you do not want to remove any existing",!,"keys." D RET G:SRSOUT END G REMOVE
 S FLAG=0 I "Yy"[SRYN D TAKEY G:SRSOUT END S FLAG=1
END D ^SRSKILL W @IOF
 Q
TAKEY ; remove security keys
 W !!,"Select Number or 'ALL': " R NUMBER:DTIME I '$T!("^"[NUMBER) S SRSOUT=1 Q
 I '$D(SRKEY(NUMBER)),NUMBER'="ALL" W !!,"Select the number corresponding to the key you want to remove, or enter 'ALL'",!,"to remove all keys." G TAKEY
 I NUMBER="ALL" W !!,"Removing all restrictions..." H 2 S NUMBER=0 F  S NUMBER=$O(SRKEY(NUMBER)) Q:'NUMBER  D DIK
 I '$O(SRKEY(0)) Q
DIK S DA=$P(SRKEY(NUMBER),"^",2),DA(1)=SRP,DIK="^SRP("_SRP_",1," D ^DIK K DA,DIK,SRKEY(NUMBER)
 Q
RET W !!,"Press RETURN to continue, or '^' to quit " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
ONE ; only one key
 W !!,"Do you want to remove the "_$P(SRKEY(1),"^")_" key ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to remove this key, eliminating all restrictions on this field, or",!,"'NO' to leave the restriction in place." G ONE
 I "Yy"[SRYN S NUMBER=1 D DIK
 Q
