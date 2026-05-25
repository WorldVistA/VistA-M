XMVSM ;BAY/JML - MailMan Read-Only Calls for the VistA System Monitor;7/1/2025
 ;;8.0;MailMan;**54**;6/28/2002;Build 2
 ;
 ; This routine provides read-only callables to populate the VSM Operational Dashboard
 ;
XMLIST(XMARR) ; Adapted from QZTSK^XMCQA
 N XMSITE,XMIEN,XMLINK,XMQD,XMQD1,XMDOM,XMMCNT,XMDCNT,DUZ,U
 S DUZ=.5,U="^"
 S (XMMCNT,XMDCNT)=0
 S XMSITE=""
 F  S XMSITE=$O(^DIC(4.2,"B",XMSITE)) Q:XMSITE=""  D
 .S XMIEN=0
 .F  S XMIEN=$O(^DIC(4.2,"B",XMSITE,XMIEN)) Q:'XMIEN  D
 ..S XMQD=+$P($G(^XMB(3.7,.5,2,XMIEN+1000,1,0)),"^",4)
 ..Q:'XMQD
 ..S XMDOM=$P($G(^DIC(4.2,XMIEN,0)),U)
 ..S XMLINK=$P($G(^DIC(4.2,XMIEN,0)),U,17)
 ..S XMARR("DOMAINS",XMDOM)=XMQD_"^"_XMLINK
 ..S XMDCNT=XMDCNT+1
 ..S XMMCNT=XMMCNT+XMQD
 S XMARR("TOTDOMS")=XMDCNT
 S XMARR("TMQUED")=XMMCNT
 Q
