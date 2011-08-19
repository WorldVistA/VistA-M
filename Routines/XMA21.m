XMA21 ;ISC-SF/GMB-Address lookup APIs ;07/17/2003  13:03
 ;;8.0;MailMan;**20**;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points (DBIA 10067):
 ; CHK   Check to see if a user is a member of a mail group.
 ; DES   Interactive addressing.  Set next default recipient.
 ; DEST  Interactive addressing.  Set first default recipient.
 ; INST  Non-interactive addressing. (Same as WHO)
 ; WHO   Non-interactive addressing.
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; DX    XMDXNAME - Test name resolution (interactive)
 ;
CHK ; Check to see if a user is a member of a mail group.
 ; Sets $T if member.
 ; Needs:
 ; XMDUZ  DUZ of the user
 ; Y      IEN of the mail group
 I $D(^XMB(3.8,Y,1,"B",XMDUZ)) Q
 Q
DX ;
 N XMINSTR,XMV,XMABORT
 D INITAPI^XMVVITAE
 S XMABORT=0
 D INIT^XMXADDR
 D TOWHOM^XMJMT(XMDUZ,$$EZBLD^DIALOG(34110),.XMINSTR,"",XMABORT) ;Send
 D CLEANUP^XMXADDR
 Q
DES ; Interactive addressing.  Set next default recipient.
 ; XMY is not killed upon entry.
 ; Needs:
 ; XMMG    Next default recipient
 ; See entry point TO for other needs and outputs associated with
 ; this entry point.
 D TO(.XMMG)
 Q
DEST ; Interactive addressing.  Set first default recipient.
 ; XMY is killed upon entry.
 ; Needs:
 ; XMDUN   First default recipient
 ; See entry point TO for other needs and outputs associated with
 ; this entry point.
 K XMY
 D TO(XMDUN)
 Q
TO(XMTO) ;
 ; Entry points DES and DEST also Need:
 ; XMDUZ   DUZ of user
 ; XMDF    if $D(XMDF) then do not restrict addressees
 ; Output:
 ; XMY(    Array of addressees:  XMY(addressee)=""
 ; XMOUT   if $D(XMOUT) user aborted addressing
 ; X       if X="^" user aborted addressing, else X=""
 N XMV,XMINSTR,XMABORT,XMDUN
 S XMABORT=0
 I XMDUZ'>0 N XMDUZ S XMDUZ=DUZ
 D INITAPI^XMVVITAE
 I $D(XMDF) S XMINSTR("ADDR FLAGS")="R" ; No addressee restrictions
 I $D(XMTO) S XMINSTR("TO PROMPT")=XMTO
 D INIT^XMXADDR
 D TOWHOM^XMJMT(XMDUZ,$$EZBLD^DIALOG(34110),.XMINSTR,"",.XMABORT) ;Send
 I XMABORT D  Q
 . S XMOUT=1,X=U
 . D CLEANUP^XMXADDR
 K XMOUT
 S X=""
 D SW
 I $D(XMINSTR("SELF BSKT")) S XMY(XMDUZ,0)=XMINSTR("SELF BSKT")
 I $D(XMINSTR("SHARE BSKT")) S XMY(.6,0)=XMINSTR("SHARE BSKT")
 I $D(XMINSTR("SHARE DATE")) S XMY(.6,"D")=XMINSTR("SHARE DATE")
 D CLEANUP^XMXADDR
 Q
SW ;
 N %X,%Y
 S %X="^TMP(""XMY"","_$J_",",%Y="XMY(" D %XY^%RCR
 Q
INST ; Non-interactive addressing (Just fall thru to WHO)
WHO ; Non-interactive addressing
 ; Needs:
 ; XMDUZ user's DUZ
 ; X     local or remote address
 ;       (-X will remove address)
 ; XMDF  if $D(XMDF) then do not restrict addressees
 ; XMLOC if $D(XMLOC), forces output of XMMG error message if error
 ; Output:
 ; XMY   address: XMY(address)=""
 ; Y     if Y=-1, then lookup has failed
 ;       = <DUZ^full name> if local addressee
 ;       = <domain ien^domain name> if remote addressee
 ; XMMG  contains error message if Y=-1
 ;       = "" if local addressee
 ;       = via domain message if remote addressee
 N XMV,XMINSTR,XMSTRIKE
 I XMDUZ'>0 N XMDUZ S XMDUZ=DUZ
 D INITAPI^XMVVITAE
 I $D(XMDF) S XMINSTR("ADDR FLAGS")="R" ; No addressee restrictions
 D INIT^XMXADDR
 I $E(X)="-" S XMSTRIKE=1,X=$E(X,2,99)
 K XMERR,^TMP("XMERR",$J)
 D CHKADDR^XMXADDR(XMDUZ,X,.XMINSTR,"",.Y)
 I $D(XMERR) D  Q
 . S XMMG=^TMP("XMERR",$J,1,"TEXT",1)
 . K XMERR,^TMP("XMERR",$J)
 . S Y=-1
 . I $D(XMLOC) W "  ",XMMG
 . D CLEANUP^XMXADDR
 I $G(XMSTRIKE) D  Q
 . N XMADDR
 . S X=Y
 . S XMADDR=""
 . F  S XMADDR=$O(^TMP("XMY",$J,XMADDR)) Q:XMADDR=""  K XMY(XMADDR)
 . S XMMG=""
 . D CLEANUP^XMXADDR
 I Y["@" D  Q
 . N XMIEN
 . S XMIEN=^TMP("XMY",$J,Y)  ; IEN
 . S XMY(Y)=XMIEN
 . S X=$P(Y,"@",2)
 . S Y=XMIEN_U_$P(^DIC(4.2,XMIEN,0),U,1)
 . S XMMG=$$EZBLD^DIALOG(39101,$P(Y,U,2)) ; via |1|
 . D CLEANUP^XMXADDR
 D SW
 I $E(X,1,2)="G." D
 . S X=$E(Y,3,99)
 . S Y=$O(^XMB(3.8,"B",X,0))_U_X  ; ien^mail group name
 E  I $L(X>2),".D.H.S."[("."_$E(X,1,2)) D
 . S X=$E(Y,3,99)
 . S Y=XMY(Y)_U_X  ; ien^full name
 E  D
 . S X=Y ; full name
 . S Y=$O(XMY(""))_U_Y  ; duz^full name
 S XMMG=""
 D CLEANUP^XMXADDR
 Q
