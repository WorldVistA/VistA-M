PRCPSSQA ;WISC/CC-Enter/edit privileged secondary IP users ;04/01
V ;;5.1;IFCAP;**24**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
AC ;I 'application coordinator W "You do not have access to this option" Q
 I '$$KEY^PRCPUREP("PRCPAQOH",DUZ) D EN^DDIOL("You are not authorized to give staff access to replace quantities.") Q
 ;
 N D,D0,D1,DA,DIC,DIDEL,DIE,DIK,DLAYGO,DQ,DR,INVPT,PRCF,PRCPPRIV,USER,X,Y,%
 ; ask site
 S %=0 F I="FY","PARAM","PER","QTR","SITE" I '+$G(PRC(I)) S %=1 Q
 I % S PRCF("X")="S" D ^PRCFSITE I '+$G(PRC("SITE")) K PRC,PRCP Q
 ;
 ; ask inventory point
 I '$D(PRCP("DPTYPE")) S PRCP("DPTYPE")="S"
 S DIC="^PRCP(445,",DIC(0)="AEQMOZ"
 S DIC("S")="I +^(0)=PRC(""SITE"")"
 S DIC("S")=DIC("S")_",PRCP(""DPTYPE"")[$P(^PRCP(445,+Y,0),U,3)"
 S DIC("A")="Select Secondary Inventory Point: "
 S D="C",PRCPPRIV=1
 D IX^DIC K PRCPPRIV,DIC
 I Y<0 K PRC,PRCP Q
 S INVPT=Y Q:'$G(INVPT)
 I PRCP("DPTYPE")'="S" Q
 I '$D(^PRCP(445,+INVPT,0)) Q
 I $P($G(^PRCP(445,+INVPT,5)),"^",1)']"" D EN^DDIOL("This secondary is not linked to a supply station") Q
 ;
 L +^PRCP(445,+INVPT,8):3 I $T=0 D EN^DDIOL("The authorized user file is busy.  Please try again later.") Q
 ;
 ; purge inappropriate users
 S USER=0
 F  S USER=$O(^PRCP(445,+INVPT,8,USER)) Q:'+USER  D
 . S X=USER D CHK(+INVPT,.X) I X="" D
 . . D EN^DDIOL("Removing "_$P(^VA(200,USER,0),"^")_".....")
 . . S DIK="^PRCP(445,"_+INVPT_",8,",DA(1)=+INVPT,DA=+USER D ^DIK K DIK
 . . W "User DELETED !"
 ;
USERS ;  ask users
 I '$D(^PRCP(445,+INVPT,0)) D EN^DDIOL("This inventory point is not on file") Q
 I '$D(^PRCP(445,+INVPT,8,0)) S ^(0)="^445.026P^^"
 S DIC(0)="AEMQO"
 S DA=+INVPT,(DIC,DIE)="^PRCP(445,",DIDEL=445,DR=26,PRCPPRIV=1
 D ^DIE K PRCPPRIV,DIC,DIE
 Q
 ;
 ;
 ; invoked from this routine and input transform of .01 field in file 445.026
CHK(INVPT,USER) ; verify user has proper qualifications
 ;  INVPT   is the ien to file 445 (Inventory Point)
 ;  USER    is the ien to file 200
 ;
 I $P($G(^VA(200,USER,0)),"^",11),$P(^(0),"^",11)<DT D EN^DDIOL("You cannot ADD a terminated user.") S USER="" Q
 I '$D(^PRCP(445,INVPT,4,USER)) D EN^DDIOL("User has no access to this inventory point.  Contact the manager.") S USER="" Q
 I '$$KEY^PRCPUREP("PRCP2 MGRKEY",USER) S USER="" D EN^DDIOL("User needs the PRCP2 MGRKEY.") Q
 I '$$KEY^PRCPUREP("PRCPSSQOH",USER) S USER="" D EN^DDIOL("User needs the PRCPSSQOH key.") Q
 ;
EXIT L -^PRCP(445,+INVPT,8)
 Q
