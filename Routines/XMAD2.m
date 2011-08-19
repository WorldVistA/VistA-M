XMAD2 ;ISC-SF/GMB-Basket lookup/create API ;04/17/2002  07:31
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points (DBIA 1147):
 ; BSKT   Lookup/create a basket, return its number
 ;
BSKT(XMKN,XMDUZ) ; Find or Create a basket / return its internal number
 ; Needs:
 ; XMKN    Basket-name
 ; XMDUZ   User's DUZ
 N XMK,XMER
 S XMK=$$FIND1^DIC(3.701,","_XMDUZ_",","X",XMKN)
 Q:XMK XMK
 D CRE8BSKT^XMXAPIB(XMDUZ,XMKN,.XMK)
 Q:'$D(XMERR) XMK
 S XMER=^TMP("XMERR",$J,1,"TEXT",1)
 K XMERR,^TMP("XMERR",$J)
 Q XMER
