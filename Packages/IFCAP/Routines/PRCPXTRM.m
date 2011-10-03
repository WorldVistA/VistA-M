PRCPXTRM ;WISC/RFJ-user termination, add, build array, utilities    ; 11/6/06 8:46am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
TERMUSER(USERDUZ)  ;  remove user as inventory user from all inventory pts
 ;  called internally (not by prcp options)
 ; 'Do' block modified by PRC*5.1*98 to add ODI cleanup
 I '$D(^VA(200,+USERDUZ,0)) Q
 N INVPT
 S INVPT=0 F  S INVPT=$O(^PRCP(445,INVPT)) Q:'INVPT  D
 . I $D(^PRCP(445,INVPT,4,USERDUZ)) D KILLUSER(INVPT,USERDUZ)
 . I $D(^PRCP(445,INVPT,9,USERDUZ)) D DEL^PRCPAODI(INVPT,USERDUZ)
 Q
 ;
 ;
KILLUSER(INVPT,USERDUZ)      ;  remove user (userduz) from invpt
 I '$D(^PRCP(445,+INVPT,4,+USERDUZ)) Q
 N %,DA,DIC,DIK,X,Y
 S DIK="^PRCP(445,"_+INVPT_",4,",DA(1)=+INVPT,DA=+USERDUZ D ^DIK
 I '$O(^PRCP(445,INVPT,4,0)) D NOUSER(INVPT)
 Q
 ;
 ;
NOUSER(INVPT)        ;  send mailmsg to g.irm if invpt has no users
 N INVNAME,PRCPTEXT,XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ ; XMSUB,XMTEXT added with PRC*5.1*98
 S XMDUZ=.5,XMY("G.IRM")=""
 S INVNAME=$$INVNAME^PRCPUX1(INVPT)
 K PRCPTEXT
 S PRCPTEXT(1,0)="TO: G.IRM"
 S PRCPTEXT(2,0)="The inventory point "_INVNAME_" (#"_INVPT_") has NO authorized users"
 S PRCPTEXT(3,0)="(field #6 in file #445)."
 S PRCPTEXT(4,0)=" "
 S PRCPTEXT(5,0)="You can use the following mumps call to add users:"
 S PRCPTEXT(6,0)="  D ADDUSER^PRCPXTRM(INVPT,USERDUZ)"
 S PRCPTEXT(7,0)="        where INVPT is the internal inventory point number;"
 S PRCPTEXT(8,0)="              USERDUZ is the users DUZ."
 S PRCPTEXT(9,0)=" "
 S PRCPTEXT(10,0)="For example: D ADDUSER^PRCPXTRM("_INVPT_",100) would add user 100 to the"
 S PRCPTEXT(11,0)=INVNAME_" (#"_INVPT_") inventory point listed above."
 S PRCPTEXT(12,0)=" "
 S PRCPTEXT(13,0)="Once an inventory user is added, the inventory point may be inactivated"
 S PRCPTEXT(14,0)="if no longer used."
 S XMSUB="INVENTORY POINT HAS NO AUTHORIZED USERS",XMTEXT="PRCPTEXT(" D ^XMD
 Q
 ;
 ;
ADDUSER(INVPT,USERDUZ)   ;  add authorized users to invpt
 I '$D(^VA(200,+USERDUZ,0)) Q
 I '$D(^PRCP(445,+INVPT,0)) Q
 I $D(^PRCP(445,+INVPT,4,+USERDUZ,0)) Q
 N %,D0,DA,DD,DIC,DINUM,DLAYGO,PRCPPRIV,X,Y ; DINUM added PRC*5.1*98
 I '$D(^PRCP(445,+INVPT,4,0)) S ^PRCP(445,+INVPT,4,0)="^445.04P^^"
 S DIC="^PRCP(445,"_+INVPT_",4,",DIC(0)="L",DLAYGO=445,DA(1)=+INVPT,(X,DINUM)=+USERDUZ,PRCPPRIV=1
 D FILE^DICN
 Q
 ;
 ;
GETUSER(INVPT)     ;  build prcpxmy array of users
 ;  if user is manager, set prcpxmy(duz)=1 otherwise 0
 N %,X
 K PRCPXMY
 I '$D(^PRCP(445,+INVPT,4)) Q
 S %=$P(^PRCP(445,INVPT,0),"^",3),%="PRCP"_$TR(%,"WSP","W2")_" MGRKEY"
 S X=0 F  S X=$O(^PRCP(445,INVPT,4,X)) Q:'X  S PRCPXMY(X)=$S($$KEY^PRCPUREP(%,X):1,1:0)
 Q
 ;
 ;
INSTALL(SUBJECT,LINE2,TEXT)  ;  send install message to forum
 ; text = text to be included from line 10 and up
 N DIC,XCNP,XMDUZ,XMSUB,XMTEXT,XMZ
 S TEXT(1,0)=" ",TEXT(2,0)="Installation of IFCAP "_LINE2_" information message:",TEXT(3,0)="",TEXT(4,0)="              site: "_$G(^DD("SITE"))
 X ^%ZOSF("UCI") S TEXT(5,0)="            op sys: "_$P($G(^%ZOSF("OS")),"^"),TEXT(6,0)="               uci: "_Y,TEXT(7,0)="              user: "_$P($G(^VA(200,+DUZ,0)),"^")
 D NOW^%DTC S Y=% D DD^%DT S TEXT(8,0)="         date@time: "_Y,TEXT(9,0)=" "
 S XMDUZ=.5,XMY("G.IFCAP INSTALL@FORUM.VA.GOV")="",XMTEXT="TEXT(",XMSUB=SUBJECT
 D ^XMD
 Q
