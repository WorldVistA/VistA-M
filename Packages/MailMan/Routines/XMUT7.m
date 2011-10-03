XMUT7 ;ISC-SF/GMB-Send Message to Forwarding Address ;04/17/2002  12:08
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points covered by DBIA 1132:
 ; ENT   Send bulletin to check forwarding address.
ENT(XMUSER) ; Send bulletin to check forwarding address.
 ; See DD for file 3.7, field 2
 ; XMUSER - DUZ of user, whose forwarding address we are checking.
 N XMPARM,XMINSTR,XMTO
 S XMINSTR("FROM")=.5
 S XMPARM(1)=$$NAME^XMXUTIL(XMUSER)
 S XMPARM(2)=$P(^XMB(3.7,XMUSER,0),U,2) Q:XMPARM(2)=""
 S XMTO(XMPARM(2))=""
 I '+$G(^XMB(1,1,"FORWARD")) S XMTO(.5)=""
 D TASKBULL^XMXBULL(.5,"XM FWD ADDRESS CHECK",.XMPARM,"",.XMTO,.XMINSTR)
 Q
