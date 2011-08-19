XQSMDCPY ;ISC-SF/JLI - COPY ONE USER (PRIM & SEC MENUS, KEYS, FILES) TO ANOTHER USER ;01/23/96  11:18
 ;;8.0;KERNEL;**19**;Jul 10, 1995
 S XQBOSS=0 I $D(^XUSEC("XUMGR",DUZ)) S XQBOSS=1
 I 'XQBOSS W !!,?5,"Note: You must have been delegated these options and",!,?11,"keys to transfer them from user to user.",!
 ;I 'XQBOSS,$O(^VA(200,DUZ,19.5,0))'>0 W !!,$C(7),"No Menus have been delegated to you to use this option",!,"If there are questions see your site manager's staff." Q
 W !! S DIC("A")="Select the user to be COPIED FROM: ",DIC=200,DIC(0)="AQEM" D ^DIC Q:Y'>0  S XQUSR1=+Y
 S XQUSRPM=+$G(^VA(200,XQUSR1,201)) I XQUSRPM="" S XQUSRPM=0 W !,"The doner user has no primary meny."
 I 'XQBOSS,XQUSRPM>0,'$D(^VA(200,DUZ,19.5,"B",XQUSRPM)) W !,$C(7),"You are not able to give out this user's primary menu ",$P(^DIC(19,XQUSRPM,0),U) S XQUSRPM=0
 S XQUSEC(0)="" F I=0:0 S I=$O(^VA(200,XQUSR1,203,I)) Q:I'>0  S X=^(I,0),XQUSEC(+X)=$P(X,U,2) I 'XQBOSS,'$D(^VA(200,DUZ,19.5,"B",+X)) W !,$C(7),"Skipping secondary menu ",$P(^DIC(19,+X,0),U) K XQUSEC(+X)
 ;I XQUSRPM'>0,$O(XQUSEC(0))'>0 W !!,$C(7),"No Primary or Secondary Menus to copy -- quitting.",!! G EXIT
 S XQUSEK(0)="" F I=0:0 S I=$O(^VA(200,XQUSR1,51,I)) Q:I'>0  S X=+^(I,0) I $D(^DIC(19,+X,0)) S XQUSEK(X)=X I 'XQBOSS,'$D(^VA(200,DUZ,52,"B",X)) W !,$C(7),"Not authorized to give ",$P(^DIC(19.1,X,0),U)," key -- skipping" K XQUSEK(X)
 ;
 ;Get recipient user
 ;
 S DIC("A")="Select a USER to be COPIED TO: ",DIC="^VA(200,",DIC(0)="AEMQ"
 F XQI=0:0 D ^DIC Q:Y'>0  S XUSR(+Y)="",DIC("A")="Select ANOTHER USER: "
 K DIC
 ;
 G:$O(XUSR(0))'>0 EXIT
 R !!,"Do you want to QUEUE this job ?  Y// ",X:DTIME Q:'$T!(X[U)  S:X="" X="Y" I "Yy"[$E(X) D TSK G EXIT
 ;
DQ ;
 F XQI=0:0 S XQI=$O(XUSR(XQI)) Q:XQI'>0  D COPY1
EXIT ;
 K %,D,D0,DA,DI,DISYS,DIC,DIE,DR,X,XQBOSS,XQI,XQJ,XQUSEK,XQUSR1,XUSR,XQUSEC,XQUSRPM,Y
 Q
 ;
COPY1 I XQUSRPM>0 S DIE=200,DA=XQI,DR="201///"_$P(^DIC(19,XQUSRPM,0),U) D ^DIE
 S:'$D(^VA(200,XQI,203,0)) ^(0)="^200.03P" S DLAYGO=200
 F XQJ=0:0 S XQJ=$O(XQUSEC(XQJ)) Q:XQJ'>0  S DIC="^VA(200,"_XQI_",203,",DA(1)=XQI,DIC("P")=200.03,X=$P(^DIC(19,XQJ,0),U),DIC(0)="ML" D ^DIC I Y>0,'$P(Y,U,3),XQUSEC(XQJ)'="" S DIE=DIC,DIE("P")=200.03,DA=+Y,DR="2///"_XQUSEC(XQJ)_";" D ^DIE
 S:'$D(^VA(200,XQI,51,0)) ^(0)="^200.051P^"
 S (DA,DA(1))=XQI F XQJ=0:0 S XQJ=$O(XQUSEK(XQJ)) Q:XQJ'>0  S DIC="^VA(200,"_XQI_",51,",DIC("P")=200.051,DIC(0)="ML",X=$P(^DIC(19.1,XQUSEK(XQJ),0),U) D ^DIC
 K DLAYGO
 Q
 ;
TSK S ZTRTN="DQ^XQSMDCPY",ZTIO="",ZTSAVE("XUSR(")="",ZTDESC="XQSMD Copy User",ZTSAVE("XQUSRPM")="",ZTSAVE("XQUSEC(")="",ZTSAVE("XQUSEK(")="" D ^%ZTLOAD
 Q
