XMCXT ;ISC-SF/GMB-View Transcripts ;04/17/2002  08:34
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/THM
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; LIST    XMLIST     (was LST^XMC2)
 Q
GET(XMFORCE) ; SEND & RECEIVE: Get # to store script in ^UTILITY/^%ZOSF(NODES)
 I $G(XMFORCE),'$G(XMC("AUDIT")) K XMC("AUDIT")
 Q:$D(XMC("AUDIT"))
 I '$P($G(^XMB(1,1,0)),U,14),'$G(XMFORCE) S XMC("AUDIT")=0 Q
 N X
 L +^TMP("XMC",0)
 S X=+$G(^TMP("XMC",0))+1#100
 S:X=0 X=1
 S (XMC("AUDIT"),^TMP("XMC",0))=X
 L -^TMP("XMC",0)
 K ^TMP("XMC",XMC("AUDIT"))
 Q
LIST ; List transmission transcripts
 N XMTEXT
 ;Transcript recording is controlled by field 8.3 in file 4.3.
 D BLD^DIALOG(42170,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 I '$O(^TMP("XMC","")) W !!,$C(7),$$EZBLD^DIALOG(42171) Q  ;No transcripts on file.
 N XMTID,XMABORT
 S XMABORT=0
 W !,$$EZBLD^DIALOG(42172),! ;10 lines of transcript will be displayed at a time.
 S XMTID=0
 F  S XMTID=$O(^TMP("XMC",XMTID)) Q:XMTID=""  D  Q:XMABORT
 . D SHOWTRAN(XMTID)
 . I '$O(^TMP("XMC",XMTID)) D  Q
 . . S XMABORT=1
 . . W !!,$C(7),$$EZBLD^DIALOG(42171.1) ;No more transcripts on file.
 . N DIR,X,Y
 . S DIR(0)="Y"
 . S DIR("A")=$$EZBLD^DIALOG(42173) ;Continue to the next transcript
 . S DIR("B")=$$EZBLD^DIALOG(39053) ;NO
 . D ^DIR I 'Y S XMABORT=1
 Q
SHOWTRAN(XMTID) ;
 N XMCNT,XMI,XMTREC,XMABORT
 S (XMCNT,XMI,XMABORT)=0
 F  S XMI=$O(^TMP("XMC",XMTID,XMI)) Q:'XMI  S XMTREC=^(XMI,0) D  Q:XMABORT
 . I XMCNT#10=0 D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 . S XMCNT=XMCNT+1
 . W !,XMTREC
 N DIR,X,Y
 S DIR(0)="Y"
 S DIR("A")=$$EZBLD^DIALOG(42174) ;Delete this transcript
 S DIR("B")=$$EZBLD^DIALOG(39053) ;NO
 D ^DIR I 'Y W !,$$EZBLD^DIALOG(42175) Q  ;Retained.
 K ^TMP("XMC",XMTID)
 W !,$$EZBLD^DIALOG(42176) ;Deleted.
 Q
 ; The following is not used
LISTCURR ;
 N XMI
 W !!,$$EZBLD^DIALOG(42177) ;The current transcript is:
 S XMI=0
 F  S XMI=$O(^TMP("XMC",XMC("AUDIT"),XMI)) Q:'XMI  W !,^(XMI,0)
 Q
