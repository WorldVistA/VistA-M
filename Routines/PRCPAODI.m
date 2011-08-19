PRCPAODI ;WOIFO/CC-enter/edit On-Demand users ; 2/8/07 4:15pm
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
ENT ;
 I '$$KEY^PRCPUREP("PRCPODI",DUZ) D EN^DDIOL("You are not authorized to make managers On-Demand Users.") Q
 ;
 N %,D,DIC,PRCF,PRCP,PRCPIN,PRCPINPT,PRCPMAN,PRCPNAME,X,Y
 ;
 ; Prompt for user
USER S DIC="^VA(200,",DIC(0)="AEQMOZ",DIC("A")="INVENTORY POINT MANAGER: ",D="B"
 D IX^DIC
 K DIC,D I Y<0 Q
 S PRCPMAN=+Y
 L +^PRCPAODI(PRCPMAN):0 I $T=0 D EN^DDIOL(">>File in Use.  Please try again later.") W ! G USER
 ;
 ; Verify user is active
 S X=$$GET1^DIQ(200,PRCPMAN_",","9.2","I") ; termination date
 I X,X'>DT D EN^DDIOL(">>This user has been terminated and cannot be selected.") W ! D EXIT G USER
 ; Verify user has primary and/or secondary manager key
 S PRCPMAN(1)=0,PRCPMAN(2)=0
 S PRCPMAN(1)=$$KEY^PRCPUREP("PRCP MGRKEY",PRCPMAN)
 S PRCPMAN(2)=$$KEY^PRCPUREP("PRCP2 MGRKEY",PRCPMAN)
 I 'PRCPMAN(1),'PRCPMAN(2),'$O(^PRCP(445,"AJ",PRCPMAN,"")) D EN^DDIOL(">>User must be a manager of a Primary or Secondary Inventory Point") W ! D EXIT G USER
 ;
 ; Display ODI access to primary points
 S PRCPNAME=$$GET1^DIQ(200,PRCPMAN_",",".01")
 W ! D CHKPM
 ;
 ; Prompt for Site
 S %=0 F I="FY","PARAM","PER","QTR","SITE" S %=1 Q
 I % S PRCF("X")="S" D ^PRCFSITE I '$G(PRC("SITE")) K PRC,PRCP G EXIT
 ;
 ; Prompt for inventory point
IP S DIC="^PRCP(445,",DIC(0)="AEQMOZ"
 S DIC("S")="I +^(0)=PRC(""SITE"")"
 S DIC("A")="SELECT INVENTORY POINT: "
 S D="C",PRCPPRIV=1
 D IX^DIC K PRCPPRIV,D,DIC
 I Y<0  G EXIT
 S PRCP("I")=Y Q:'$G(PRCP("I"))
 S PRCPINPT=$P(PRCP("I"),"^",2)
 S PRCP("DPTYPE")=$P(^PRCP(445,+PRCP("I"),0),U,3)
 I PRCP("DPTYPE")="W" D EN^DDIOL("  >>The warehouse has no On-Demand items - needs no On-Demand User.") W ! G IP
 ;
 D INIT(+PRCP("I"))
 ;
 ;Process Users that don't qualify
 I 'PRCPMAN(3) D  D:PRCP("DPTYPE")="P" CHKDP G IP
 . D EN^DDIOL(">>"_PRCPNAME_" is not a "_PRCPMAN(3)_" of this inventory point")
 . ; if user is not in node 9, give message - not added
 . I 'PRCPIN D EN^DDIOL("  and therefore cannot be an On-Demand User") W !
 . ; delete if user is set up in node 9 - show 'deleted'
 . I PRCPIN D  Q
 . . D DEL(+PRCP("I"),PRCPIN) ; Delete entry
 . . D EN^DDIOL(">>Removed as On-Demand User for: "_PRCPINPT) W !
 ;
 ; If user is already On-Demand, ask if they should be removed???
 I PRCPIN D  G IP
 . D ASK(2,+PRCP("I"),PRCPMAN)
 . I PRCP("DPTYPE")="P" D CHKDP
 ;
 ; Ask if user should be added to IP's list of On-Demand users
 D ASK(1,+PRCP("I"),PRCPMAN)
 I PRCP("DPTYPE")="P" D CHKDP
 G IP
 ;
 Q
 ;
 ; Does user qualify?
INIT(PRCPINP) ;PRCPINP=inventory point being checked
 S PRCPMAN(3)=1 ; assume user is OK
 ; Verify user has manager key for type of IP selected
 I PRCP("DPTYPE")="P",'PRCPMAN(1) S PRCPMAN(3)="manager"
 I PRCP("DPTYPE")="S",'PRCPMAN(2) S PRCPMAN(3)="manager"
 ; Verify user is a user of that IP
 I '$D(^PRCP(445,+PRCPINP,4,PRCPMAN)) D
 . I PRCPMAN(3)=1 S PRCPMAN(3)="user" Q
 . S PRCPMAN(3)="manager nor user"
 ;
 ; set flag if user is already in list
 S PRCPIN=""
 S PRCPIN=$O(^PRCP(445,+PRCPINP,9,"B",PRCPMAN,PRCPIN))
 Q
 ;
DEL(PRCPINP,PRCPUSER) ; delete On-Demand authorization
 ; also called from PRCPXTRM for user termination from VISTA
 ;
 ; PRCPINP    inventory point from which user is being removed
 ; PRCPUSER   ien of user in the list
 ;
 N DA,DIK
 S DIK="^PRCP(445,"_PRCPINP_",9,",DA(1)=+PRCPINP,DA=+PRCPUSER D ^DIK
 Q
 ;
ADD(PRCPINP,PRCPUSER) ; Add user to On-Demand Users
 ;
 ; PRCPINP
 ; PRCPUSER
 ;
 ; save user in On-Demand Users list
 N PRCPIEN,PRCPARRY,PRCPREC
 S PRCPREC(1)=+PRCPMAN ; dinumed file
 S PRCPIEN="+1,"_+PRCPINP_","
 S PRCPARRY(445.027,PRCPIEN,.01)=+PRCPMAN
 D UPDATE^DIE("","PRCPARRY","PRCPREC")
 Q
 ;
 ; Find all distribution points
CHKDP N PRCPIN,PRCPIP,PRCPDA,PRCPDX,PRCPNM,FLAG,X
 D EN^DDIOL("Checking distribution points for "_PRCPINPT_"...") W !
 S PRCPIP=0,FLAG=1
 S PRCP("DPTYPE")="S"
 F  S PRCPIP=$O(^PRCP(445,+PRCP("I"),2,PRCPIP)) Q:'+PRCPIP  D
 . S PRCPNM=$$INVNAME^PRCPUX1(PRCPIP),X=$P(PRCPNM,"-",2,99)
 . I $E(X,1,12)="***INACTIVE_" Q  ; IP not active
 . I $P($G(^PRCP(445,PRCPIP,0)),"^",3)'="S" Q
 . S FLAG=0 D INIT(PRCPIP)
 . I 'PRCPMAN(3) D  Q
 . . I PRCPIN S PRCPDX(PRCPIP)=1_"^"_PRCPNM_"^"_PRCPIN Q
 . S PRCPDA(PRCPIP)=1_"^"_PRCPNM_"^"_PRCPIN
 ;
 I FLAG=1 D EN^DDIOL("There are no distribution points on this primary") W ! Q
 ;
 ; check for IPs where the user is On-Demand
 I $O(PRCPDA("")) D
 . N PRCPD,X S PRCPD=""
 . D EN^DDIOL(PRCPNAME_" is a User and Manager on the following Inventory Points:") W !
 . F  S PRCPD=$O(PRCPDA(PRCPD)) Q:'PRCPD  D
 . . S X=$P(PRCPDA(PRCPD),"^",2)
 . . S X=X_$E("                                   ",$L(X),35)
 . . S X=X_$S($P(PRCPDA(PRCPD),"^",3):"On-Demand User",1:"Not On-Demand User")
 . . D EN^DDIOL(X)
 . W !
 ;
 I $O(PRCPDX("")) D REMOVE(.PRCPDX)
 ;
 I '$O(PRCPDA("")),'$O(PRCPDX("")) D  W !
 . I PRCPMAN(2)'=1 D EN^DDIOL(PRCPNAME_" is not a manager of any distribution point") Q
 . D EN^DDIOL(PRCPNAME_" is not a user of the distribution points found")
 ;
ASK(PRCPOPT,PRCPIPT,PRCPUSER) ; Should user's authorization be removed?
 ;
 ; PRCPOPT    1 if add , 2 if delete
 ; PRCPIPT    Inventory Point ien
 ; PRCPUSER   DUZ of User
 ;
 N CNT,DIR,DIRUT,DIROUT,DTOUT,DUOUT,I,X,PRCPDP
 S CNT=1,PRCPDP="",X=""
 S DIR(0)="Y"
 S DIR("A")="Add as an On-Demand User"
 I PRCPOPT=2 S DIR("A")="Remove as an On-Demand User"
 D ^DIR K DIR
 I Y=0!$D(DTOUT)!$D(DUOUT) S X="  <<not added>>" S:PRCPOPT=2 X="  <<not removed>>" D EN^DDIOL(X) W ! Q
 ; IF YES, LOOP THROUGH AND DELETE USER FROM ALL
 I Y=1 D
 . I PRCPOPT=2 D
 . . D DEL(PRCPIPT,PRCPIN)
 . . D EN^DDIOL("  <<Removed>>") W !
 . I PRCPOPT=1 D
 . . D ADD(PRCPIPT,PRCPUSER)
 . . I $D(^TMP("DIERR",$J)) D EN^DDIOL("  <<Unable to Add - possible system problems>>") W ! Q
 . . D EN^DDIOL("  <<Added>>") W !
 Q
 ;
REMOVE(PRCPDX) ; Auto remove ODI authorization
 I $O(PRCPDX("")) D
 . N PRCPD,X S PRCPD=""
 . D EN^DDIOL("On-Demand Access was removed from the following:") W !
 . F  S PRCPD=$O(PRCPDX(PRCPD)) Q:'PRCPD  D
 . . D DEL(PRCPD,$P(PRCPDX(PRCPD),"^",3))
 . . S X=$P(PRCPDX(PRCPD),"^",2) D EN^DDIOL(X)
 . W !
 Q
 ;
CHKPM ; DISPLAY IPs User can access
 N PRCPIN,PRCPIP,FLAG,PRCPDX,PRCPNM
 S PRCPIP="",FLAG="",PRCP("DPTYPE")="P"
 F  S PRCPIP=$O(^PRCP(445,"AC","P",PRCPIP)) Q:'PRCPIP  D
 . I '$O(^PRCP(445,PRCPIP,9,"B",PRCPMAN,"")) Q
 . D INIT(PRCPIP)
 . S PRCPNM=$$INVNAME^PRCPUX1(PRCPIP),X=$P(PRCPNM,"-",2,99)
 . I $E(X,1,12)="***INACTIVE_" Q  ; IP not active
 . I 'PRCPMAN(3) D  Q
 . . I PRCPIN S PRCPDX(PRCPIP)=1_"^"_PRCPNM_"^"_PRCPIN Q
 . I 'FLAG S FLAG=1 D EN^DDIOL(PRCPNAME_" is an On-Demand User in these Primary Inventory Points:")
 . D EN^DDIOL(PRCPNM)
 I $O(PRCPDX("")) W ! D REMOVE(.PRCPDX)
 I 'FLAG D EN^DDIOL(">>"_PRCPNAME_" is not an On-Demand User in any Primary Inventory Point")
 W !
 Q
 ;
EXIT L -^PRCPAODI(PRCPMAN)
 Q
