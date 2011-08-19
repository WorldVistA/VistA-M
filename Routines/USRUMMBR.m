USRUMMBR ; SLC/JER,MA - User Class Membership by User actions ;2/2/10
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**2,3,5,6,7,8,14,16,33**;Jun 20, 1997;Build 7
 ; 14 Feb 00 MA - Added check for 0 USRDA in DELETE
 ; 19 Jun 00 MA - Added check for inactive class when adding user.
EDIT ; Edit user's class membership
 ;N USRDA,USRDATA,USREXPND,USRI,USRSTAT,DIROUT,USRCHNG,USRLST
 N USRDA,USRDATA,USRI,DIROUT,USRCHNG,USRLST
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S (USRCHNG,USRI)=0
 F  S USRI=$O(VALMY(USRI)) Q:+USRI'>0  D  Q:$D(DIROUT)
 . S USRDATA=$G(^TMP("USRUSERIDX",$J,USRI))
 . W !!,"Editing #",+USRDATA,!
 . S USRDA=+$P(USRDATA,U,2) D EDIT1
 . I +$G(USRCHNG) S USRLST=$S($L($G(USRLST)):$G(USRLST)_", ",1:"")_USRI
 . I $D(USRDATA) D UPDATE^USRUM(USRDATA)
 W !,"Refreshing the list."
 S VALMSG="** "_$S($L($G(USRLST)):"Item"_$S($L($G(USRLST),",")>1:"s ",1:" ")_$G(USRLST),1:"Nothing")_" Edited **"
 K VALMY S VALMBCK="R"
 Q
EDIT1 ; Single record edit
 ; Receives USRDA
 N DA,DIE,DR
 I '+$G(USRDA) W !,"No Member selected." H 2 S USRCHNG=0 Q
 S DIE="^USR(8930.3,",DA=USRDA,DR="[USR MEMBERSHIP EDIT]"
 D FULL^VALM1,^DIE S USRCHNG=1
 Q
ADD ; Add a membership to selected classes for current user
 N CLASSADD,DIC,DLAYGO,FDA,MSG,X,Y
 N I2N,FDA,FDAIEN,MSG
 ;N USRCLASS,USRCREAT,USRUSER,USRCNT,USRQUIT
 N USRCLASS,USRUSER,USRCNT,USRQUIT
 D FULL^VALM1
 I $$ISTERM^USRLM(USRDUZ) D  Q  ;USRDUZ is newed and set in USRULST
 . W !,"You cannot add class memberships, this user is terminated!"
 . H 2
 S USRCNT=0
 F  D  Q:+$G(USRQUIT)
 . W !
 . S DIC=8930,DIC(0)="AEMQ"
 . S DIC("A")="Select "_$S(USRCNT'>0:"",1:"Another ")_"USER CLASS: "
 . D ^DIC I +Y'>0 S USRQUIT=1 Q
 . ;
 . I $P(^USR(8930,+Y,0),"^",3)=0 D  Q
 .. W !,"You may not add a user to a inactive USER CLASS !!!"
 .. I $$READ^USRU("FAO","Press return to continue")
 .. S USRQUIT=1
 . S USRCLASS=+Y
 . S DIC=200,DIC(0)="NMX",X="`"_USRDUZ
 .;Make sure the user is not already a member of this class.
 . I $$ISAWM^USRLM(USRDUZ,USRCLASS) S USRQUIT=1 Q
 . K FDA,FDAIEN,MSG
 . S CLASSADD=0
 . S I2N="+1,"
 . S FDA(8930.3,I2N,.01)=USRDUZ
 . S FDA(8930.3,I2N,.02)=USRCLASS
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . I +$G(FDAIEN(1))>0 D
 .. S CLASSADD=1
 .. S DA=+FDAIEN(1),DIE=8930.3,DIE("NO^")="BACK"
 .. S DR=".03;.04" D ^DIE
 .. I $D(Y) D
 ... S DIK=DIC D ^DIK K DIK
 ... S CLASSADD=0
 . I 'CLASSADD D  Q
 .. W !,"Error adding ",$$CLNAME^USRLM(+$P($G(^USR(8930.3,+DA,0)),U,2),1)
 . E  S USRCNT=USRCNT+1
 W !,"Rebuilding membership list."
 D BUILD^USRULST(USRDUZ)
 I USRCNT>0 D
 . S USRUSER=$$SIGNAME^USRLS(+$G(USRDUZ))
 . S VALMSG="** "_USRUSER_" added to "_USRCNT_" classes **"
 S VALMCNT=+$G(@VALMAR@(0))
 S VALMBCK="R"
 Q
DELETE ; Delete a member of the class
 N DIE,X,Y,USRCLASS D FULL^VALM1
 N USRCLASS,USRDA,USRCHNG,USRDATA,USRI,USRLST,DIROUT
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S USRI=0
 F  S USRI=$O(VALMY(USRI)) Q:+USRI'>0  D  Q:$D(DIROUT)
 . S USRDATA=$G(^TMP("USRUSERIDX",$J,USRI))
 . ;02/14/00 Been having trouble with USRDA=0
 . ;possible bad x-ref.  Will check for USRDA=0
 . ;Changed USRLM to check for valid 0 node for x-ref AUC
 . S USRDA=+$P(USRDATA,U,2) Q:USRDA=0  D DELETE1(USRDA)
 . S:+$G(USRCHNG) USRLST=$S(+$G(USRLST):USRLST_", ",1:"")_+USRDATA
 . I $D(USRDATA) D UPDATE^USRUM(USRDATA)
 W !,"Rebuilding the list."
 S USRCLASS=+$G(^TMP("USRU",$J,0))
 D BUILD^USRULST(USRDUZ)
 S VALMCNT=+$G(@VALMAR@(0))
 K VALMY S VALMBCK="R"
 S VALMSG="** "_$S($L($G(USRLST)):"Item"_$S($L($G(USRLST),",")>1:"s ",1:" ")_$G(USRLST),1:"Nothing")_" removed **"
 Q
DELETE1(DA) ; Delete one member from a class
 N DIE,DR,USER,CLASS,USRMEM0 S USRMEM0=$G(^USR(8930.3,+DA,0))
 I USRMEM0']"" W !,"Record #",DA," NOT FOUND!" H 2 D MAILMSG Q
 ;S USER=$P($G(^VA(200,+USRMEM0,0)),U)
 ;S USER=$$GET1^DIQ(200,+USRMEM0,.01) ; ICR 10060
 S USER=$$PERSNAME^USRLM1(+USRMEM0)
 S CLASS=$P($G(^USR(8930,+$P(USRMEM0,U,2),0)),U)
 W !,"Removing ",USER," from ",CLASS
 I '$$READ^USRU("Y","Are you SURE","NO") S USRCHNG=0 W !,USER," NOT Removed from ",CLASS,"." H 2 Q
 S USRCHNG=1
 S DIK="^USR(8930.3," D ^DIK W "."
 Q
MAILMSG ; This section will mail an error message to DUZ
 ;W "  A mail message is being sent to ",$P($G(^VA(200,DUZ,0)),"^",1) H 1
 W "  A mail message is being sent to ",$$GET1^DIQ(200,USER,.01) H 1
 N XMY,XMSUB,USRTEXT,XMTEXT,XMDUZ
 S XMDUZ=0.5
 S XMY(DUZ)=""
 S XMSUB="ERROR MESSAGE FROM AUTHORIZED/SUBSCRIPTION (USRUMMBR)"
 S USRTEXT(1)="This message is being generated due to a bad x-ref (AUC)"
 S USRTEXT(2)="in ^USR(8930.3) pointing to a IEN on the 0 node that"
 S USRTEXT(3)="does not exist."
 S USRTEXT(4)=""
 S USRTEXT(5)="Please forward this message to your IRM representative"
 S USRTEXT(6)="asking them to verify the Global ^USR(8930.3) x-ref"
 S USRTEXT(7)="on AUC & ACU."
 S USRTEXT(8)=""
 S USRTEXT(9)="IRM will need to verify that the x-ref AUC & ACU for"
 S USRTEXT(10)=$$GET1^DIQ(200,USRDUZ,.01)_" is pointing to a valid 0 node."
 S USRTEXT(11)=""
 S USRTEXT(12)="DO NOT CONTINUE WITH THIS USER UNTIL IRM VERIFIES!!"
 S USRTEXT(13)=""
 S USRTEXT(14)="IRM please check ^USR(8930.3,""AUC"","_USRDUZ_") to"
 S USRTEXT(15)="verify it is pointing to a valid 0 node IEN."
 S USRTEXT(16)="Also do the same for x-ref ACU"
 S XMTEXT="USRTEXT("
 D ^XMD
 Q
