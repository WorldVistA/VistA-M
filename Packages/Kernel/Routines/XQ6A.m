XQ6A ;SEA/AMF,SLC/CJS- BULK KEY DISTRIBUTION ;5:22 AM  19 Jun 2002
 ;;8.0;KERNEL;**12,147**;Jul 10, 1995
HOLDER ;
 W !!,$S($O(XQHOLD(0))>0:"Another holder: ",1:"Holder of key: ") R X:DTIME S:'$T X=U G:X[U OUT
 I '$L(X) G:($O(XQHOLD(0))>0) OK W " ??",$C(7),!,"You have not yet selected any holders." G HOLDER
 I X["?" S XQH="XQKEYALLOCATE-HOLDER" D:X="?" EN^XQH D:X="??" LSTHOL D:X="???" USERFIL G HOLDER
 S XQM=0 S:"'-"[$E(X,1) X=$E(X,2,999),XQM=1
 ;I $E(X,1,2)'="G." S DIC=200,DIC(0)="EZM",DIC("S")="I $L($P(^(0),U,3))" D ^DIC K DIC W:(Y<0) " ??",$C(7) G:Y<0 HOLDER S XQI=+Y D EACH G HOLDER
 I $E(X,1,2)'="G." S DIC=200,DIC(0)="EZM" D ^DIC K DIC W:(Y<0) " ??",$C(7) G:Y<0 HOLDER S XQI=+Y D EACH G HOLDER
 S X=$E(X,3,999),XMDUZ=DUZ,DIC("S")="D:$P(^(0),U,2)=""PR"" CHK^XMA21",DIC="^XMB(3.8,",DIC(0)="EMZ" D ^DIC K DIC I Y<0 W " ??",$C(7) G HOLDER
 ;S XQJ=0 F XQI=1:1 S XQJ=$O(^XMB(3.8,+Y,1,XQJ)) Q:XQJ'>0!(XQJ'=+XQJ)  S XQI=+^(XQJ,0) I $L($P(^VA(200,XQI,0),U,3)) W !,$P(^(0),U,1) D EACH
 S XQJ=0 F XQI=1:1 S XQJ=$O(^XMB(3.8,+Y,1,XQJ)) Q:XQJ'>0!(XQJ'=+XQJ)  S XQI=+^(XQJ,0) W !,$P(^VA(200,XQI,0),U,1) D EACH
 G HOLDER
 ;
EACH ;Check out each potential user
 I 'XQBOSS,(XQI=DUZ) W !!,$C(7),"==> Sorry, you can't give yourself keys.  See your IRM staff." Q
 I XQM W $S($D(XQHOLD(XQI)):"  Deleted from current list",1:$C(7)_" ??  Holder not on list") K XQHOLD(XQI) Q
 S XQHOLD(XQI)=""
 Q
OK ;
 D LSTKEY,LSTHOL
 W !!,"You are ",$S(XQAL&XQDA:"delegating",XQAL:"allocating",XQDA:"removing delegated",1:"deallocating")," keys."
OK1 R "  Do you wish to proceed? YES// ",X:DTIME S:'$T X=U G:X[U OUT S:(X="") X="Y" I "YyNn"'[$E(X,1) W $C(7)," ??",!,"Please enter 'Y' or 'N'" G OK1
 I $E(X,1)="N"!($E(X,1)="n") R !!,"Do you wish to start again? NO// ",X:DTIME S:'$T X=U G:X[U OUT S:(X="") X="N" G:X["Y"!(X["y") KEY^XQ6 G:"YyNn"'[$E(X,1) OK1 G OUT
 ;
ACT ;Run through list of keys
 F XQK=0:0 S XQK=$O(XQKEY(XQK)) Q:XQK'>0  W !!,$P(^DIC(19.1,XQK,0),U,1)," being ",$S(XQAL&XQDA:"delegated to",XQAL:"assigned to:",1:"taken away from:") D ACT1
 ;
OUT ;Exit point
 K %,DA,DIC,DIE,DR,XMDUZ,XQBOSS,XQKEY,XQAL,XQHOLD,XQI,XQJ,XQK,XQDA,XQSBNFDT,XQH,XQM,XQNM,X,Y
 Q
ACT1 ;Run through list of people
 F XQM=0:0 S XQM=$O(XQHOLD(XQM)) Q:XQM'>0  D ACT2
 Q
ACT2 ;Add keys or DO ACT3 if we're removing them
 N XQEND
 S XQEND=""
 S XQNM=$P(^VA(200,XQM,0),U,1) W !?5,XQNM I 'XQAL D ACT3 Q
 I $D(^VA(200,XQM,$S(XQDA:52,1:51),XQK)) W ?30,"Person already holds key - no action taken" Q
 D UNABLE^XQ6B(XQK,XQM,.XQEND) I XQEND=1 Q
 S DIC(0)="NMQ",DIC("P")=$S(XQDA:"200.052PA",1:"200.051PA"),DIC="^VA(200,XQM,"_$S(XQDA:52,1:51)_",",DA(1)=XQM,X=XQK,DINUM=X D FILE^DICN Q
ACT3 I '$D(^VA(200,XQM,$S(XQDA:52,1:51),XQK)) W ?30,"Person doesn't hold key - no action taken" Q
 S DIK="^VA(200,XQM,"_$S(XQDA:52,1:51)_",",DA(1)=XQM,DA=XQK D ^DIK Q
 Q
LSTKEY ;
 I $O(XQKEY(0))'>0 W !!,"You have not yet selected any keys." Q
 W !!,"You've selected the following keys: ",! S XQJ=0,XQI=5 F XQK=0:1 S XQJ=$O(XQKEY(XQJ)) Q:XQJ'>0  W:'(XQK#XQI) ! W ?(XQK#XQI*15),$P(^DIC(19.1,XQJ,0),U,1)
 Q
LSTHOL ;
 I $O(XQHOLD(0))'>0 W !!,"You have not yet selected any holders." Q
 W !!,"You've selected the following holders: ",! S XQJ=0,XQI=3 F XQK=0:1 S XQJ=$O(XQHOLD(XQJ)) Q:XQJ'>0  W:'(XQK#XQI) ! W ?(XQK#XQI*26),$P(^VA(200,XQJ,0),U,1)
 Q
KEYFIL ;
 I '$D(XQBOSS) S XQBOSS=0 S:(DUZ(0)="@"!($D(^XUSEC("XUMGR",DUZ)))) XQBOSS=1
 S:'XQBOSS DIC("S")="I $D(^VA(200,DUZ,52,+Y,0))"
 R !,"Do you want to see the KEY file? NO// ",X:DTIME S:'$T X="N" Q:X'["Y"&(X'["y")  S X="?",DIC="^DIC(19.1,",DIC(0)="Q" D ^DIC K DIC
 Q
USERFIL ;
 R !,"Do you want to see the current holders of a key? NO//",X:DTIME S:'$T X="N" G:X'["Y"&(X'["y") U0
US0 S DIC=19.1,DIC(0)="AEQMZ" D ^DIC K DIC G:Y<0 U0 W !,"Holders are:" S XQII=0
US1 S XQII=$O(^VA(200,"AB",+Y,XQII)) G:+XQII'>0 US0 W !?5,$S('$D(^VA(200,XQII,0)):XQII,1:$P(^VA(200,XQII,0),U)) G US1
U0 R !,"Do you want to see the NEW PERSON file? NO// ",X:DTIME G:X'["Y"&(X'["y") U1 S X="?",DIC="^VA(200,",DIC(0)="Q" ;,DIC("S")="I $L($P(^(0),U,3))"
 D ^DIC K DIC
U1 R !,"Do you want to see the members of a Mail Group? NO// ",X:DTIME S:'$T X="N" Q:'(X["Y"!(X["y"))
U2 S XMDUZ=DUZ,DIC("S")="D:$P(^(0),U,2)=""PR"" CHK^XMA21",DIC="^XMB(3.8,",DIC(0)="AEQMZ" D ^DIC K DIC Q:Y<0  W !,"Members are:" S XQII=0
U3 S XQII=$O(^XMB(3.8,+Y,1,XQII)) G:+XQII'>0 U2 W !,?5 S X=^(XQII,0) W $S('X:X,'$D(^VA(200,X,0)):X,1:$P(^VA(200,X,0),U,1)) G U3
 Q
