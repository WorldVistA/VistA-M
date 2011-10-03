XUSMGR ;SF-ISC/STAFF - SECURITY UTILITIES ROUTINE ; 7/15/03 7:03am
 ;;8.0;KERNEL;**263,258,314**;Jul 10, 1995
 W !!,"Use the MENU system",!! Q
X1 ;Old intro test edit
 N DIE,DA,DR
 W !!,"Please use menu option 'Inrtoductory text edit'" H 4 ;Sign-on intro text.
 S DIE="^XTV(8989.3,",DA=1,DR=240 D ^DIE Q
 ;
X6 ;Clear Terminal
 N %ZIS
 S %ZIS="QN" D ^%ZIS G:POP EX6 I '$D(^DISV("XU",IOS)) W !!,$C(7),"Terminal does not need to be cleared!!!",! G X6
 K ^DISV("XU",IOS),%ZIS W !,"Terminal has been CLEARED!!",!
EX6 D HOME^%ZIS Q
 ;
X8 ;Release user
 N DIC,DIR,J,X,Y,FDA,IEN,X1,X2,X3
X8A W !!,"This will clear the user from the list of currently sign-on users."
 W !,"And/or release from invalid sign on lock."
 S DIC="^VA(200,",DIC(0)="AEMQ" D ^DIC S IEN=+Y G:Y<1 EX8
 S (X1,X2,X3)=0
 I $P($G(^VA(200,IEN,1.1)),"^",3) S X1=1
 I $P($G(^VA(200,IEN,1.1)),"^",5) S X2=1
 I $D(^XUSEC(0,"CUR",IEN)) S X3=1
 I '(X1+X2+X3) D  G X8
 . W !!,$C(7),"User is not currently recorded as being signed on the system!!!",!
 ;Show user info
 W !,"User: ",$P(Y,U,2)," is listed with the following connections."
 S J=0 F  S J=$O(^XUSEC(0,"CUR",IEN,J)) Q:J'>0  D
 . I '$D(^XUSEC(0,J,0)) K ^XUSEC(0,"CUR",IEN,J) Q
 . S X=^XUSEC(0,J,0)
 . W !,"Connected: ",$$FMTE^XLFDT(J,"1"),?39," Device: ",$P(X,U,2)
 . W !,?2,"   Node: ",$P(X,U,10),?39,"     IP: ",$S($L($P(X,U,11)):$P(X,U,11),1:$P(X,U,12))
 . Q
 I $P(^VA(200,IEN,1.1),U,5) W !,"Locked out until ",$$FMTE^XLFDT($P(^VA(200,IEN,1.1),U,5))," because of too many invalid attempts."
 ;
 S DIR(0)="Y",DIR("A")="Release this user",DIR("B")="Yes" D ^DIR
 I 'Y G X8A
 S $P(^VA(200,IEN,1.1),"^",3)=0,$P(^VA(200,IEN,1.1),U,5)="" ;Clear flag,Lockout time
 S J=0 F  S J=$O(^XUSEC(0,"CUR",IEN,J)) Q:J'>0  D
 . S FDA(3.081,J_",",3)=$$NOW^XLFDT,FDA(3.081,J_",",16)=1 D UPDATE^DIE("","FDA")
 W !,"User is RELEASED!!",!
EX8 Q
 ;
SCPURG ;Purge sign-on log
 S XUDT=$$HTFM^XLFDT($H-30) I $O(^XUSEC(0,0))'>0 G SCEXIT
 S DIK="^XUSEC(0," F DA=0:0 S DA=$O(^XUSEC(0,DA)) Q:(DA'>0)!(DA>XUDT)  D ^DIK
SCEXIT K DIK,DA,XUDT,X1,X2 Q
IXKEY ;Re-Index the New Person file Key sub-file
 N DA,DIK,ACT
 W:'$D(ZTQUEUED) !,"Starting"
 ;we only want to reindex the "AC" x-ref
 S DIK(1)=".01^AC"
 ;loop through New Person file and index entries
 F DA(1)=0:0 S DA(1)=$O(^VA(200,DA(1))) Q:DA(1)'>0  D
 .;skip inactive person 
 .;Q:$P($G(^VA(200,DA(1),0)),"^",11)
 .S ACT=+$$ACTIVE^XUSER(DA(1))
 .I ACT'=1 Q
 .;global root for multiple
 .S DIK="^VA(200,DA(1),51,"
 .;reindex
 .D ENALL^DIK W:'(DA(1)#50) "."
 .;
 W:'$D(ZTQUEUED) !,"Done"
 ;
 ;the old codes
 ;W:'$D(ZTQUEUED) !,"Starting "
 ;S DIK="^VA(200,DA(1),51,",DIK(1)=".01^1^2^3^4"
 ;F DA(1)=0:0 S DA(1)=$O(^VA(200,DA(1))) Q:DA(1)'>0  D ENALL^DIK W:'(DA(1)#50) "."
 ;W:'$D(ZTQUEUED) !,"Done"
 Q
