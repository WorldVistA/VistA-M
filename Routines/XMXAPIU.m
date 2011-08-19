XMXAPIU ;ISC-SF/GMB-APIs for users to use interactively ;03/26/2003  08:57
 ;;8.0;MailMan;**15**;Jun 28, 2002
 ; All entry points covered by DBIA 2774.
 ;
 ; The following are meant to be in an option's ROUTINE field.
 ; They expect that DUZ exists, and if the user is acting as a surrogate,
 ; that XMDUZ exists, too.  Otherwise, XMDUZ will be set to DUZ.
 ; If the XMV variables do not exist, INIT^XMVVITAE will be called.
 Q
READ ; Read/Manage messages in your Mailbox
 ; Needs XMDUZ
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 G MANAGE^XMJBM
 Q
READNEW ; Read new messages in your Mailbox
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 G NEW^XMJBN
 Q
SEND ; Send a message
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 G SEND^XMJMS
 Q
 ; The following are meant to be called from within a program.
 ; Output, common to the following:
 ; XMERR     If there's any errors, then XMERR is set to the number of
 ;           errors, otherwise XMERR is undefined.
 ;           ^TMP("XMERR",$J,error number,"TEXT",line number)=error text
SUBJ(XMSUBJ) ; Ask user for msg subject
 ; XMSUBJ    (in/out) Subject
 N XMABORT
 K XMERR,^TMP("XMERR",$J)
 S XMABORT=0
 D SUBJ^XMJMS(.XMSUBJ,.XMABORT) Q:'XMABORT
 D ERRSET^XMXUTIL($S(XMABORT=1:37000,1:37001)) ; up-arrow out / time out
 Q
TOWHOM(XMDUZ,XMZ,XMTYPE,XMINSTR) ; Ask user for msg addressees
 ; XMDUZ     User's DUZ
 ; XMZ       message number in ^XMB(3.9,
 ; XMTYPE
 ; XMINSTR
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D ITOWHOM^XMXPARM(.XMDUZ,.XMZ,.XMTYPE,.XMINSTR) Q:$D(XMERR)
 D ITOWHOM^XMXTO(XMDUZ,.XMZ,XMTYPE,.XMINSTR)
 Q
SHOWERR ; Print the errors to the screen.
 ; Displays the errors in ^TMP("XMERR",$J),
 ; and then kills XMERR and ^TMP("XMERR",$J).
 D SHOW^XMJERR
 Q
