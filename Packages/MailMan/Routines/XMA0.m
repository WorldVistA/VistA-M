XMA0 ;ISC-SF/GMB-Print Message APIs ;04/17/2002  07:08
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP/THM
 ;
 ; Entry points (DBIA 1230):
 ; ENTPRT  Print a message (interactive)
 ; HDR     Print a message (headerless)
 ; PR2     Print a message
 ;
ENTPRT ; Print a message (interactive)
 ; Needs:
 ; DUZ
 ; XMZ  Message number
 ; XMK  Basket number
 N XMV
 D INITAPI^XMVVITAE
 D PRINT^XMJMP(XMDUZ,XMK,XMZ)
 Q
HDR ; Print a message (headerless)
 ; Needs:
 ; DUZ
 ; XMK    basket number
 ; XMZ    message number
 ; IO     output device
 ; Optional:
 ; XMDUZ
 ; $P(XMTYPE,";",6) response from which to start printing
 D PRINTIT(0,$G(XMTYPE))
 Q
PR2 ; Print a message
 ; Needs:
 ; DUZ
 ; XMK    basket number
 ; XMZ    message number
 ; IO     output device
 ; Optional:
 ; XMDUZ
 ; $P(XMTYPE,";",6) response from which to start printing
 D PRINTIT(1,$G(XMTYPE))
 Q
PRINTIT(XMPRTHDR,XMTYPE) ;
 N XMV,XMWHICH
 Q:XMTYPE=U
 D INITAPI^XMVVITAE
 S XMWHICH=+$P(XMTYPE,";",6)_"-"  ; print from
 D PRTMSG^XMJMP(XMDUZ,XMK,XMZ,XMWHICH,0,XMPRTHDR)
 Q
