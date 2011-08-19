XMJMSA ;ISC-SF/GMB-Send Anonymous User Suggestion Message ;04/17/2002  10:12
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMANON (ISC-WASH/CAP)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; SEND    XMSUGGESTION
 ; This routine allows a user to send an anonymous message to the
 ; SUGGESTION BOX basket of SHARED,MAIL.  If this basket doesn't exist,
 ; it will be created.
 ;
 ; MailMan masks (does not record) the actual identity of the sender.
 ;
 ; To use it, put the XMSUGGESTION option onto the appropriate menu.
 ; To stop a particular person from using it, put a 'Reverse/negative
 ; Lock' onto the XMSUGGESTION option and assign that key to the
 ; person you do not want to be able to use it.
SEND ;
 N XMSUBJ,XMABORT,XMFINISH,XMDIR,XMY,XMOPT,XMOX
 D SET^XMXSEC2("ES",37305,.XMOPT,.XMOX) ; Edit Subject
 D SET^XMXSEC2("ET",37306,.XMOPT,.XMOX) ; Edit Text
 D SET^XMXSEC2("T",37334,.XMOPT,.XMOX) ; Transmit now
 S XMDIR("A")=$$EZBLD^DIALOG(34067) ; Select Message option:
 S XMDIR("B")=XMOX("O","T")_":"_XMOPT("T") ; Transmit now
 S XMDIR("??")="@" ; no help screen
 S XMABORT=0
 ;D WARNING(.XMABORT) Q:XMABORT
 D ES Q:XMABORT  ; Edit the subject
 K ^TMP("XM",$J)
 D ET Q:XMABORT  ; Edit the text
 S XMFINISH=0
 F  D  Q:XMFINISH!XMABORT
 . D XMDIR^XMJDIR(.XMDIR,.XMOPT,.XMOX,.XMY,.XMABORT) Q:XMABORT
 . D @XMY
 K ^TMP("XM",$J)
 Q
ES ;
 D SUBJ^XMJMS(.XMSUBJ,.XMABORT)
 Q
ET ; Edit text
 N DIC
 S DWPK=1,DWLW=75,DIC="^TMP(""XM"",$J,"
 S DIWESUB=XMSUBJ
 D EN^DIWE
 I '$O(^TMP("XM",$J,0)) S XMABORT=1 Q
 Q
T ; Transmit the message
 N XMDUZ,DUZ,XMINSTR,XMZ
 S XMFINISH=1,(XMDUZ,DUZ)=.6
 S XMINSTR("FROM")=$$EZBLD^DIALOG(34665) ; Anonymous
 S XMINSTR("SHARE DATE")="3991231"
 S XMINSTR("SHARE BSKT")=$$EZBLD^DIALOG(34666) ; SUGGESTION BOX
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMZ,1) Q:XMZ<1
 W $$EZBLD^DIALOG(34217,XMZ) ; Sending [|1|]...
 D MOVEBODY^XMXSEND(XMZ,"^TMP(""XM"",$J)")
 D ADDRNSND^XMXSEND(XMDUZ,XMZ,XMDUZ,.XMINSTR)
 W !,$$EZBLD^DIALOG(34213) ;  Sent
 Q
WARNING(XMABORT) ;
 ;                 * * * * *  ATTENTION  * * * * *
 ;      Anonymous messages may or may not be totally anonymous.
 ;                Please check with your local IRM
 ; to find out if your facility has methods in place to identify you.
 N XMTEXT
 W @IOF
 D BLD^DIALOG(34667,"","","XMTEXT","F")
 D MSG^DIALOG("WM","",79,"","XMTEXT")
 W !!
 D PAGE^XMXUTIL(.XMABORT)
 Q
