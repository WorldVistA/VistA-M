XMXSEC3 ;ISC-SF/GMB-Message security and restrictions (cont.) ;04/18/2002  08:01
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2733.
OPTWNO(XMORIGN8) ; Surrogate does not have 'write' privilege.
 D Q("A",37401.5) ; You need 'send' privilege to Answer a message.
 D Q("C",37403.5) ; You need 'send' privilege to Copy a message.
 D Q("E",37405.5) ; You need 'send' privilege to Edit a message.
 I XMORIGN8 D Q("IN",37409.5) ; You need 'send' privilege to toggle 'Information only'.
 E  D Q("IN",37409.1) ; Only the originator may toggle 'Information only'.
 D Q("W",37444.5) ; You need 'send' privilege to Write (send) a message.
 Q
Q(XMCD,XMDN) ;
 I $G(XMQDNUM) S XMOPT(XMCD,"?")=XMDN Q
 S XMOPT(XMCD,"?")=$$EZBLD^DIALOG(XMDN)
 Q
DOSHARE(XMDUZ,XMK,XMORIGN8,XMINSTR) ;
 N I,XMNO
 S XMNO=$S($G(XMQDNUM):37462,1:$$EZBLD^DIALOG(37462)) ; You may not do this in SHARED,MAIL.
 F I="A","E","IN","K","L","N","W","X" S XMOPT(I,"?")=XMNO
 Q:XMORIGN8
 D Q("C",37403.6) ; Only the originator may Copy a message in SHARED,MAIL.
 D Q("F",37406.6) ; Only the originator may Forward a message from SHARED,MAIL.
 I XMK,$S($D(^XUSEC("XMMGR",DUZ)):0,$D(^XMB(3.7,"AB",DUZ,.5)):0,1:1) D
 . N DIR,I
 . ; You must be the originator, hold the XMMGR key,
 . ; or be a POSTMASTER surrogate to do this in SHARED,MAIL.
 . I $G(XMQDNUM) D  Q
 . . F I="D","S","T","V" S XMOPT(I,"?")=37461
 . D BLD^DIALOG(37461,"","","DIR(""?"")")
 . F I="D","S","T","V" M XMOPT(I,"?")=DIR("?")
 Q
DOPOST ; You may not do this with messages in the transmit queues.
 N XMNO,I
 S XMNO=$S($G(XMQDNUM):37251,1:$$EZBLD^DIALOG(37251))
 F I="A","AA","B","C","E","IN","H","K","L","N","P","R","S","T","V","W","X" S XMOPT(I,"?")=XMNO
 K XMOPT("X"),XMOX("X",XMOX("O","X")),XMOX("O","X")
 D SET^XMXSEC2("X",37447,.XMOPT,.XMOX) ; Xmit Priority Toggle
 Q
