XMJERR ;ISC-SF/GMB-Error handling ;04/17/2002  09:54
 ;;8.0;MailMan;;Jun 28, 2002
ZSHOW ;
 N I,J,XMZ
 F I=1:1:XMERR D
 . W !
 . S XMZ=$G(^TMP("XMERR",$J,I,"XMZ"))
 . I XMZ D NOGOID^XMJMP2(XMZ,$G(^XMB(3.9,XMZ,0)))
 . S J=0
 . F  S J=$O(^TMP("XMERR",$J,I,"TEXT",J)) Q:'J  W !,^(J)
 W !
 K XMERR,^TMP("XMERR",$J)
 Q
SHOW ;
 N I,J
 W $C(7)
 F I=1:1:XMERR D
 . W !
 . S J=0
 . F  S J=$O(^TMP("XMERR",$J,I,"TEXT",J)) Q:'J  W !,^(J)
 K XMERR,^TMP("XMERR",$J)
 Q
