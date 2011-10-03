XMA03 ;ISC-SF/GMB-Resequence messages API ;04/17/2002  07:08
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP/THM
 ;
 ; Entry points (DBIA 1150):
 ; $$REN  Resequence messages in a user's basket
 ;
REN(XMDUZ,XMK) ;API entry for Renumbering Mail Basket
 ; XMDUZ  User's DUZ
 ; XMK    Basket number
 N XMMSG
 D RSEQBSKT^XMXAPIB(XMDUZ,XMK,.XMMSG)
 Q $G(XMMSG)
