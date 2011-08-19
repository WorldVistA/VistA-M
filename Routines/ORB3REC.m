ORB3REC ; SLC/AEB - Notification Management Options for Recipients/Users ;4/30/01  09:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,85,105,173**;Dec 17, 1997
 ;
ERASE ;
 N ORBT S ORBT="Erase All of My Notifications"
 D TITLE(ORBT)
 I '$$GET^XPAR("ALL^USR.`"_DUZ,"ORB ERASE ALL",1,"Q") D  Q
 .W !,"You are not authorized to perform this function."
 W !!,"This option purges all your existing notifications",!!?20,"*** USE WITH CAUTION ***"
 W !!,$C(7),"Do you want to purge all notifications for recipient ",$P(^VA(200,DUZ,0),"^") S %=2 D YN^DICN D
 .I %=0 W !,"Enter 'YES' if you want to purge all existing notifications for this person.",!,"Do you want to purge all notifications for this recipient" S %=2 D YN^DICN
 Q:%'=1  W !!,"Purging notifications...",!
 K %
 D RECIPURG^XQALBUTL(DUZ)
 Q
PFLAG ;
 N ORBT,ENT,PAR,PIEN
 S ORBT="Enable/Disable My Notifications",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORB PROCESSING FLAG",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORBT) D PROC
 Q
 ;
FLGOB ;
 N ORBT,ENT,PAR,PIEN
 S ORBT="Set My Flagged Orders Bulletin",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORB FLAGGED ORDERS BULLETIN",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORBT) D PROC
 Q
 ;
USRNOTS ; List notifications a user could receive
 D USRNOTS^ORB3U2(DUZ)
 Q
 ;
TITLE(ORBT)  ;
 ; Center and write title
 S IOP=0 D ^%ZIS K IOP W @IOF
 W !,?(80-$L(ORBT)-1/2),ORBT
 Q
 ;
PROC ; Process Parameter Settings
 S ENT=DUZ_";VA(200," ;  Entity is the recipient/user
 W !,$$DASH($S($D(IOM):IOM-1,1:78))
 D EDIT^XPAREDIT(ENT,PAR)
 Q
DASH(N) ;extrinsic function returns N dashes
 N X
 S $P(X,"-",N+1)=""
 Q X
