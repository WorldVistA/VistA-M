FSCNMS ;SLC/STAFF NOIS Notification Mail Send ;1/13/98  13:55
 ;;1.1;NOIS;;Sep 06, 1998
 ;
MAIL(XMSUB) ; from FSCLMPNN
 Q:'$D(XMSUB)  I XMSUB[U S XMSUB=$$REPLACE^FSCRU(XMSUB,U,"~U~")
 N CNT,DIR,LINE,XMTEXT,XMY,Y K DIR,XMY,XMZ,^TMP("FSC MAIL",$J),^TMP("FSC TEXT",$J)
 S DIR(0)="YAO",DIR("A")="Do you want to load the list document into the message? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to load the display into the message."
 S DIR("?",2)="Enter NO to just send a message without the display."
 S DIR("?",3)="When loading the display into the message, you can later edit the message"
 S DIR("?",4)="before sending.  Be aware that displays may have edited information."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 D
 .I Y D  Q
 ..S ^TMP("FSC MAIL",$J,1,0)=" "
 ..S ^TMP("FSC MAIL",$J,2,0)="     *** NOIS INFORMATION ***"
 ..S CNT=2 I $G(FSCCALLS)="EVALUES" S ^TMP("FSC MAIL",$J,3,0)=$G(VALMHDR(1)),CNT=3
 ..S LINE=0 F  S LINE=$O(@VALMAR@(LINE)) Q:LINE<1  S CNT=CNT+1,^TMP("FSC MAIL",$J,CNT,0)=^(LINE,0)
 ..D EDITWP^FSCEU("^TMP(""FSC MAIL"",$J)","You may edit this message.")
 .D WP^FSCEU("MAIL","Enter your mail message.")
 S XMTEXT=""
 I $O(^TMP("FSC MAIL",$J,0)) S XMTEXT="^TMP(""FSC MAIL"",$J,"
 I $O(^TMP("FSC TEXT",$J,"MAIL",0)) S XMTEXT="^TMP(""FSC TEXT"",$J,""MAIL"","
 I '$L(XMTEXT) Q
 D EN^XM W !,"This message will be sent to you." S XMY(DUZ)="" D DES^XMA21
 I '$D(XMY) Q
 N DIR,Y K DIR
 S DIR(0)="YAO",DIR("A")="Send notification message: ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to send this message."
 S DIR("?",2)="Enter NO or '^' to exit without sending the message, '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y'=1 Q
 D ^XMD I $G(XMZ) W !,"Message #",XMZ," sent." H 2
 D KILL^XM K ^TMP("FSC MAIL",$J),^TMP("FSC TEXT",$J)
 Q
