XMGAPI3 ;WASH ISC/REW/LH-Deliver Broadcast Msg & Mark for Vaporization ;04/17/2002  08:59
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ENT    XMR-BROADCAST-VA-WIDE
 ; ENT    XMYB-BROADCAST-VA-WIDE
ENT(XMTO) ; Meant to be invoked by a server.  Delivers a message
 ; either to all users or to a specific user.
 ; The message must have been sent by the POSTMASTER@FORUM.VA.GOV.
 ; The AUTOMATIC DELETE DATE for this message is set for each user
 ; to be in 7 days; 30 days if sent to a specific user.
 ; The message is made 'information only' and 'closed'.
 ; XMTO   *=to all users
 ;        DUZ=to only one person -- typically .6 to route to SHARED,MAIL
 ; Variables set in the server invoker:
 ; XQSOP  Server basket name
 ; XQMSG  Message number
 ; XMFROM Who sent the message
 N XMDUZ,XMKN
 S (XMDUZ,DUZ)=.5
 S XMKN="S."_XQSOP
 I $P(XMFROM,"@")'["POSTMASTER"!($P(XMFROM,"@",2)'["FORUM.") D
 . D ERR1(XMDUZ,XMKN,XMFROM)
 E  D
 . D SEND(XMDUZ,XMKN,XQMSG,XMTO,XMFROM)
 D CLEANUP(XMKN,XQMSG)
 Q
SEND(XMDUZ,XMKN,XMZ,XMTO,XMFROM) ;
 K XMERR,^TMP("XMERR",$J)
 D INIT^XMXADDR
 D CHKADDR^XMXADDR(XMDUZ,XMTO)
 I $D(XMERR) D  Q
 . D ERR2(XMDUZ,XMKN,XMTO,XMFROM)
 . K XMERR,^TMP("XMERR",$J)
 D FORCE(XMZ,$S(XMTO="*":7,1:30))
 D SEND^XMKP(XMDUZ,XMZ)
 Q
FORCE(DA,XMDAYS) ; Set Info Only, Closed statuses, and Purge date
 N DIE,DR
 S DIE=3.9,DR="1.95///y;1.97///y;1.6///"_$$FMADD^XLFDT(DT,XMDAYS)
 D ^DIE
 Q
CLEANUP(XMKN,XMZ) ; Successfully delivered message, so remove from Postmaster Server Basket
 D CLEANUP^XMXADDR
 D ZAPSERV^XMXMSGS1(XMKN,XMZ)
 Q
ERR1(XMDUZ,XMKN,XMFROM) ; Send message back to sender if not POSTMASTER@FORUM
 N A
 S A(1)="You may not send a message to the "_XMKN_" server."
 S A(2)="Only the Postmaster at FORUM.VA.GOV has this permission."
 D SENDMSG^XMXSEND(XMDUZ,"Sender of Message to Server Unacceptable","A",XMFROM)
 K XMERR,^TMP("XMERR",$J)
 Q
ERR2(XMDUZ,XMKN,XMTO,XMFROM) ; Send a message back to sender if single recipient is invalid
 N A,I,J
 S A(1)="Your message to the "_XMKN_" server was not accepted"
 S A(2)="because the lookup for the recipient specified ("_XMTO_")"
 S A(3)="failed, with the following message:"
 S J=3,I=0
 F  S I=$O(^TMP("XMERR",$J,XMERR,"TEXT",I)) Q:'I  S J=J+1,A(J)=^(I)
 D SENDMSG^XMXSEND(XMDUZ,"Server Recipient Unknown","A",XMFROM)
 K XMERR,^TMP("XMERR",$J)
 Q
