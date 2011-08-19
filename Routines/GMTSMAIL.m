GMTSMAIL ; SLC/JMH - HS mailman items ;01/25/2005 [1/27/05 9:01am]
 ;;2.7;Health Summary;**70**;Oct 20, 1995;Build 5
 ;read on ^XMB(3.8 field .01 covered by DBIA 10111
MAIL(MSG,OPTION) ;Call to notify on Scheduling Error return 
 N XMSUB,XMDUZ,XMZ,XMY,XMTEXT
 N GMTSMAIL,GMTSPARM
 S GMTSPARM=$O(^GMT(142.99,"B","HOSPITAL",0))
 S GMTSMAIL=$P($G(^GMT(142.99,$G(GMTSPARM),0)),U,6)
 Q:GMTSMAIL=""
 I $P(GMTSMAIL,";",2)="VA(200," S XMY(+GMTSMAIL)="" ;recipient
 I $P(GMTSMAIL,";",2)="XMB(3.8," S XMY("G."_$$GET1^DIQ(3.8,+GMTSMAIL_",",.01))="" ;mail group
 S XMSUB="Health Summary Report Aborted"
 S XMDUZ="Health Summary Package"
 D XMZ^XMA2 ;message stub
 S XMTEXT="XMTEXT"
 S XMTEXT(1)="The following task reported an error due to a problem when calling"
 S XMTEXT(2)="    the Scheduling package:"
 S XMTEXT(3)=""
 S XMTEXT(4)="    "_OPTION
 S XMTEXT(5)=""
 S XMTEXT(6)="Here is the error that was reported by the Scheduling package:"
 S XMTEXT(7)=""
 S XMTEXT(8)="    "_MSG
 S XMTEXT(9)=""
 S XMTEXT(10)="The task may have been aborted."
 D ENL^XMD
 D ENT1^XMD
 Q
