XMBBLOB ;(WASH ISC)/THM/RWF/CAP-Add BLOBs to Bulletin ;04/17/2002  07:41
 ;;8.0;MailMan;;Jun 28, 2002
 ;Multimedia Bulletin - Add BLOBs
MULTI(XMZ) ;Many BLOBs at a time
 N XMBBLOB
 F XMYBLOB=0:0 S XMYBLOB=$O(XMYBLOB(XMYBLOB)) Q:'XMYBLOB  S X=$$API^XMR0BLOB(XMZ,XMYBLOB(XMYBLOB)) I 'X D ERB(X) S XMBBLOB=$G(XMBBLOB)+1
 Q XMBBLOB
 ;If BLOB Error
ERB(%,%0,%1) N XMR,XMZ,XMY,XMTEXT,XMSUB,XMDUZ,XMDUN,XMBSAVE
 S %X="^TMP(""XMY"",$J,",%Y="^TMP(""XMBSAVE"",$J," D %XY^%RCR
 S %X="XMY(",%Y="^TMP(""XMBSAVE"",$J," D %XY^%RCR
 S XMDUZ="<MailMan Bulletin API>",XMSUB="BLOB NOT SENT",XMY(%)=""
 S XMTEXT="XMTEXT(",XMTEXT(1)="The Bulletin '"_$P(^XMB(3.9,%0,0),U)_"'"
 S XMTEXT(2)="was sent without non-textual body parts (BLOBS)."
 S XMTEXT(3)="The error returned from the imaging API was: "
 S XMTEXT(4)="     "_%1
 D ^XMD
 S %Y="^TMP(""XMY"",$J,",%X="^TMP(""XMBSAVE"",$J," D %XY^%RCR
 Q 1
