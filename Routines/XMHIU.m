XMHIU ;ISC-SF/GMB-User Info ;04/17/2002  09:52
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces UHELP^XMA7 (ISC-WASH/RJ/THM/CAP)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; HELP      XMHELPUSER - Get user info
HELP ; User Info
 N DIC,Y,D,XMHDUZ
 D CHECK^XMVVITAE
 S DIC=200,DIC(0)="AEQMZN",DIC("A")=$$EZBLD^DIALOG(38009) ;User name:
 S DIC("S")="I $S('$D(^VA(200,Y,0)):0,Y<1:1,$L($P(^(0),U,3)):1,1:0)"
 S DIC("W")="D USERINFO^XMXADDR1(Y)"
 S D="B^BB^C^D" ; name^alias^initial^nickname
 F  W ! D MIX^DIC1 Q:Y<0  D
 . S XMHDUZ=+Y
 . W @IOF,$$NAME^XMXUTIL(XMHDUZ,1)
 . D DISPUSER(XMHDUZ)
 . S DIC("W")="D USERINFO^XMXADDR1(Y)"
 Q
DISPUSER(XMUSER) ;
 N XMABORT
 S XMABORT=0
 D GENERAL(XMUSER,.XMABORT) Q:XMABORT  ; General info
 D GROUPS(XMUSER,.XMABORT) Q:XMABORT   ; Groups in which this user is a member
 D SURRBEU(XMUSER,.XMABORT) Q:XMABORT  ; Surrogates who may be this user
 D UBESURR(XMUSER,.XMABORT)            ; Users for whom this user may be surrogate
 Q
GENERAL(XMUSER,XMABORT) ;
 N X,XMREC
 I '$D(^XMB(3.7,XMUSER)) W !,$$EZBLD^DIALOG(38010) Q  ;No Mailbox for this user!
 S XMREC=$G(^XMB(3.7,XMUSER,0))
 Q:XMREC=""&'$D(^XMB(3.8,"AB",XMUSER))
 S X=$G(^XMB(3.7,XMUSER,"B")) W:$L(X) !,$$EZBLD^DIALOG(38011),X ;Current Banner:
 S X=$P($G(^XMB(3.7,XMUSER,"L")),U) W:$L(X) !,$$EZBLD^DIALOG(38012),X ;Last used MailMan:
 S X=$P(XMREC,U,6) I X D
 . N XMPARM S XMPARM(1)=X,XMPARM(2)=+$P(^XMB(3.7,XMUSER,2,1,0),U,2)
 . W !,$$EZBLD^DIALOG(38019,.XMPARM) ;NEW messages: |1| (|2| in the IN basket)
 S X=$P(XMREC,U,2) I $L(X) W !,$$EZBLD^DIALOG(38004),X,$$EZBLD^DIALOG($S($P(XMREC,U,8):38005,1:38006)) ; Forwarding Address: / Local Delivery is ON / OFF
 S XMREC=$G(^VA(200,XMUSER,.13))
 S X=$P(XMREC,U,2) I X'="" W !!,$$EZBLD^DIALOG(38013),X ;Office phone:
 S X=$P(XMREC,U,6) I X'="" W !,$$EZBLD^DIALOG(38014),X ;Fax:
 S X=$P(XMREC,U,7) I X'="" W !,$$EZBLD^DIALOG(38015),X ;Voice pager:
 S X=$P(XMREC,U,8) I X'="" W !,$$EZBLD^DIALOG(38016),X ;Digital pager:
 S X=$P(XMREC,U,3) I X'="" W !,$$EZBLD^DIALOG(38017),X ;Add'l phone:
 S X=$P(XMREC,U,4) I X'="" W !,$$EZBLD^DIALOG(38017),X ;Add'l phone:
 S XMREC=$G(^VA(200,XMUSER,.11),"^^")
 I $P(^XMB(1,1,0),U,10),$P(XMREC,U,1,3)'="^^" D  ; Don't show address unless site OKs it.
 . W !!,$$EZBLD^DIALOG(38018) ;Address:
 . F X=1:1:3 I $P(XMREC,U,X)'="" W !,"  ",$P(XMREC,U,X)
 . S X=$P(XMREC,U,4) I X'="" W !,"  ",X
 . S X=$P(XMREC,U,5) I X W ", ",$P($G(^DIC(5,X,0)),U,2)
 . S X=$P(XMREC,U,6) I X'="" W "  ",X
 I $D(^XMB(3.7,XMUSER,1,0)) D  Q:XMABORT
 . N XMI,XMLINE
 . I $Y+5>IOSL D PAGE(.XMABORT) Q:XMABORT
 . W !!,$$EZBLD^DIALOG(38050) ;Introduction:
 . S XMI=0
 . F  S XMI=$O(^XMB(3.7,XMUSER,1,XMI)) Q:XMI'>0  S XMLINE=^(XMI,0) D  Q:XMABORT
 . . I $Y+4>IOSL D PAGE(.XMABORT) Q:XMABORT
 . . W !,"  ",XMLINE
 Q
GROUPS(XMUSER,XMABORT) ;
 N XMGIEN,XMREC,XMTYPE
 Q:'$D(^XMB(3.8,"AB",XMUSER))
 I $Y+6>IOSL D PAGE(.XMABORT) Q:XMABORT
 W !!,$$EZBLD^DIALOG(38040) ;Mail Groups:
 S XMGIEN=""
 F  S XMGIEN=$O(^XMB(3.8,"AB",XMUSER,XMGIEN)) Q:XMGIEN=""  D  Q:XMABORT
 . S XMREC=$G(^XMB(3.8,XMGIEN,0)) Q:XMREC=""
 . S XMTYPE=$P(XMREC,U,2)
 . ; Don't show private group membership, unless user is a member, too.
 . I XMTYPE="PR",'$D(^XMB(3.8,"AB",DUZ,XMGIEN)) Q
 . I $Y+4>IOSL D PAGE(.XMABORT) Q:XMABORT
 . W !?2,$P(XMREC,U)
 . W:$G(^XMB(3.8,XMGIEN,3))=XMUSER $$EZBLD^DIALOG(38041) ;(Organizer)
 . W ?45,$$EZBLD^DIALOG($S(XMTYPE="PR":38042,1:38043)) ;(Private) / (Public)
 Q
SURRBEU(XMUSER,XMABORT) ; List surrogates for this user
 N XMSIEN
 Q:'$O(^XMB(3.7,XMUSER,9,0))
 I $Y+6>IOSL D PAGE(.XMABORT) Q:XMABORT
 W !!,$$EZBLD^DIALOG(38044) ;This user's surrogates are:
 S XMSIEN=0
 F  S XMSIEN=$O(^XMB(3.7,XMUSER,9,XMSIEN)) Q:XMSIEN=""  D  Q:XMABORT
 . D DISPSURR(2,XMUSER,XMSIEN,.XMABORT)
 Q
UBESURR(XMSURR,XMABORT) ; List users for whom this user may act as surrogate
 N XMUSER,XMSIEN
 Q:'$O(^XMB(3.7,"AB",XMSURR,0))
 I $Y+6>IOSL D PAGE(.XMABORT) Q:XMABORT
 W !!,$$EZBLD^DIALOG(38045) ;This user may act as a surrogate for:
 S XMUSER=""
 F  S XMUSER=$O(^XMB(3.7,"AB",XMSURR,XMUSER)) Q:XMUSER=""  D  Q:XMABORT
 . S XMSIEN=$O(^XMB(3.7,"AB",XMSURR,XMUSER,""))
 . D DISPSURR(1,XMUSER,XMSIEN,.XMABORT)
 Q
DISPSURR(XMFLAG,XMUSER,XMSIEN,XMABORT) ;
 N XMPRIV,XMREC,XMNIEN
 I $Y+4>IOSL D PAGE(.XMABORT) Q:XMABORT
 S XMREC=$S(XMUSER=.6:".6^y^y",1:$G(^XMB(3.7,XMUSER,9,XMSIEN,0)))
 S XMNIEN=$S(XMFLAG=1:XMUSER,1:$P(XMREC,U,1))
 Q:'XMNIEN  Q:'$D(^VA(200,XMNIEN,0))
 W !,?2,$$NAME^XMXUTIL(XMNIEN)
 S XMPRIV=$P(XMREC,U,2,3)
 I XMPRIV'["y" W ?45,$$EZBLD^DIALOG(38046) Q  ;No Privileges
 I $L(XMPRIV,"y")>2 W ?45,$$EZBLD^DIALOG(38047) Q  ;Read and Write Privileges
 W ?45,$$EZBLD^DIALOG($S($P(XMPRIV,U)["y":38048,1:38049)) ;Read Privilege / Write Privilege
 Q
PAGE(XMABORT) ;
 D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 W @IOF
 Q
