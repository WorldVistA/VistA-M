USRRULA ; SLC/JER - Rule Browser actions ;2/6/98  17:12
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**3,28,29**;Jun 20, 1997;Build 7
EDIT ; Edit an existing rule
 N DUP,REDIT,USRDA,USRI,DIROUT,USRCHNG,USRLST,USRRBLD,SAVEDATA
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S (USRCHNG,USRI)=0
 F  S USRI=$O(VALMY(USRI)) Q:+USRI'>0  D  Q:$D(DIROUT)
 . S USRDA=+$O(^TMP("USRRUL",$J,"INDEX",USRI,0)) Q:+USRDA'>0
 . W !!,"Editing #",+USRI,!
 . S SAVEDATA=$G(^USR(8930.1,USRDA,0))
 . D EDIT1
 . I +$G(USRCHNG) S USRLST=$S($L($G(USRLST)):$G(USRLST)_", ",1:"")_USRI
 I $G(DUP) D
 . S ^USR(8930.1,USRDA,0)=$G(SAVEDATA)
 . S VALMSG="** Item Not Edited - Duplicate of Another Rule **"
 W !,"Refreshing the list."
 I $L($G(USRLST)) D
 . S USRRBLD=$P($G(@VALMAR@(0)),U,1,4) D INIT^USRRUL,HDR^USRRUL
 K VALMY S VALMBCK="R"
 I $G(DUP) Q
 I '$G(REDIT) S VALMSG="** "_$S($L($G(USRLST)):"Item"_$S($L($G(USRLST),",")>1:"s ",1:" ")_$G(USRLST),1:"Nothing")_" Edited **"
 Q
EDIT1 ; Single record edit
 ; Receives USRDA
 N DA,DIE,DR
 I '+$G(USRDA) W !,"No Classes selected." H 2 S USRCHNG=0 Q
 S DIE="^USR(8930.1,",DA=USRDA,DR="[USR DEFINE AUTHORIZATIONS]"
 D FULL^VALM1,^DIE S USRCHNG=1
 I '$D(DA) W !!,"<Business Rule DELETED>" H 3 Q
 S XUSRQ=^USR(8930.1,+DA,0),REDIT=0
 I $P(XUSRQ,"^",1)=""!($P(XUSRQ,"^",2)="")!($P(XUSRQ,"^",3)="")!(($P(XUSRQ,"^",4)="")&($P(XUSRQ,"^",6)="")) D  Q
 . S ^USR(8930.1,USRDA,0)=$G(SAVEDATA)
 . S VALMSG="** Item Not Edited - Required Fields Missing **" S REDIT=1 Q
 I $P(XUSRQ,"^",5)'="" D
 . I $P(XUSRQ,"^",4)="" D  Q
 . . S ($P(XUSRQ,"^",5),$P(^USR(8930.1,+DA,0),"^",5))=""
 . . S VALMSG="**USER CLASS REQ with AND FLAG -AND FLAG Removed**" S REDIT=1 Q
 . I $P(XUSRQ,"^",6)="" D  Q
 . . S ($P(XUSRQ,"^",5),$P(^USR(8930.1,+DA,0),"^",5))=""
 . . S VALMSG="**USER ROLE REQ with AND FLAG -AND FLAG Removed**" S REDIT=1 Q
 S DUP=$$DUP
 Q
ADD ; Add a member to the class
 N DA,DR,DIC,DIK,DLAYGO,DUP,X,Y,USRRBLD,USRCNT,XUSRQ D FULL^VALM1
 W !,"Please Enter a New Business Rule:",!
 S (DIC,DLAYGO)=8930.1,DIC(0)="NL",X=$$DOCPICK
 Q:+X'>0
 S X=""""_"`"_+X_""""
 D ^DIC K DLAYGO Q:+Y'>0  S DA=+Y
 S DIE=8930.1,DR="[USR DEFINE AUTHORIZATIONS]"
 D ^DIE
 I '$D(DA) S VALMSG="<Business Rule DELETED>" Q
 S DIK="^USR(8930.1,"
 S XUSRQ=^USR(8930.1,+DA,0)
 I $P(XUSRQ,"^",1)=""!($P(XUSRQ,"^",2)="")!($P(XUSRQ,"^",3)="")!(($P(XUSRQ,"^",4)="")&($P(XUSRQ,"^",6)="")) D  Q
 . S VALMSG="** Item Deleted - Required Fields Missing **"
 . D ^DIK
 K DIK
 S DUP=$$DUP
 S USRCNT=+$P($G(@VALMAR@(0)),U,5)
 I +USRCNT D
 . I 'DUP D ADD^USRRUL(DA)
 . S $P(@VALMAR@(0),U,5)=+USRCNT D HDR^USRRUL I 1
 E  S USRRBLD=$P($G(@VALMAR@(0)),U,1,4) D INIT^USRRUL,HDR^USRRUL
 S USRCNT=+$P($G(@VALMAR@(0)),U,5)
 S $P(@VALMAR@("#"),":",2)=+USRCNT
 S USRCHNG=1,VALMBCK="R"
 I $G(DUP) D  Q
 . S DIK="^USR(8930.1,"
 . D ^DIK
 . K DIK
 . S VALMSG="** Item Deleted - Duplicate Rule **" Q
 S VALMSG="** Item "_+USRCNT_" Added **"
 Q
DOCPICK() ; Function to pick a document for which rule will be created
 N DIC,X,Y
 ; I +$G(^TMP("USRRUL",$J,0))
 S DIC=8925.1,DIC(0)="AEMQ",DIC("A")="Select DOCUMENT DEFINITION: "
 S DIC("S")="I +$$CANPICK^TIULP(+Y),$S($P($G(^TIU(8925.1,+Y,0)),U,4)=""CO"":0,$P($G(^TIU(8925.1,+Y,0)),U,4)=""O"":0,$P($G(^TIU(8925.1,+Y,0)),U)[""ADDENDUM"":0,1:1)"
 D ^DIC K DIC("S")
 Q Y
 ;
DUP() ; Function to determine if new or edited rule is a duplicate of an existing rule
 N DHIT,XDA,XDATA,DIK
 S (DHIT,XDA)=0 F  S XDA=$O(^USR(8930.1,XDA)) Q:XDA=""  Q:+XDA'>0  D  Q:DHIT
 . I XDA=+DA Q
 . S XDATA=$G(^USR(8930.1,XDA,0))
 . I $P($G(^USR(8930.1,+DA,0)),"^",1,4)=$P($G(XDATA),"^",1,4)&($P($G(^USR(8930.1,+DA,0)),"^",6)=$P($G(XDATA),"^",6)) D 
 . . I $P($G(^USR(8930.1,+DA,0)),"^",5)=$P($G(XDATA),"^",5) S DHIT=1 Q
 . . I $P($G(^USR(8930.1,+DA,0)),"^",5)="",$P($G(XDATA),"^",5)="!" S DHIT=1 Q
 . . I $P($G(^USR(8930.1,+DA,0)),"^",5)="!",$P($G(XDATA),"^",5)="" S DHIT=1 Q
 Q DHIT
 ;
DELETE ; Delete a member to the class
 N USRDA,USRCHNG,USRI,USRLST,DIE,X,Y,USRRBLD K DIROUT
 D FULL^VALM1
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S USRI=0
 F  S USRI=$O(VALMY(USRI)) Q:+USRI'>0  D  Q:$D(DIROUT)
 . S USRDA=+$O(^TMP("USRRUL",$J,"INDEX",USRI,0)) Q:+USRDA'>0
 . W !!,"Deleting #",+USRI,!
 . D DELETE1(USRDA)
 . S:+USRCHNG USRLST=$S(+$G(USRLST):USRLST_", ",1:"")_+USRI
 I +$G(USRLST) D
 . S USRRBLD=$P($G(@VALMAR@(0)),U,1,4) D INIT^USRRUL,HDR^USRRUL
 K VALMY S VALMBCK="R"
 S VALMSG="** "_$S($L($G(USRLST)):"Item"_$S($L($G(USRLST),",")>1:"s ",1:" ")_$G(USRLST),1:"Nothing")_" deleted **"
 Q
DELETE1(DA) ; Delete one member from a class
 N DIE,DR,USRI,USRULE D XLATE^USRAEDT(.USRULE,+DA)
 I $G(USRULE)']"" W !,"Record #",DA," NOT FOUND!" Q
 W !,"Removing the rule:",!
 F USRI=1:1:$L(USRULE,"|") W !,$P(USRULE,"|",USRI)
 W !
 I '$$READ^USRU("Y","Are you SURE","NO") S USRCHNG=0 W !,"Business Rule NOT Removed." Q
 W !,"Deleting Business Rule"
 S USRCHNG=1
 S DIK="^USR(8930.1," D ^DIK K DIK W "."
 Q
