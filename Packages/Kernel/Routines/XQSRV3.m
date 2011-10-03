XQSRV3 ;SEA/MJM - Server to Mailman utilities; [5/16/02 12:48pm]
 ;;8.0;KERNEL;**231,235**;Jul 10, 1995
 ;
HERE ;Find the name of this place
 ;N U,%,XMFROM,XMSUB,XMTEXT,XQDATE,XQER1,XQHERE,XQI,XQMB,XQMB6
 ;N XQMSG,XQN,XQSND,XQSOP,XQSRV5,XQSUB,XQMS,XMY,XQSTXT
 S U="^",%=$P(^XTV(8989.3,1,0),U,1)
 I $D(^DIC(4.2,%,0)) S XQHERE=$P(^(0),U,1) S:'$L(XQHERE) XQHERE="Domain Unknown"
 E  S XQHERE="Domain Unknown"
 ;
SETUP ;Set up return mail message parameters
 I $D(XMFROM),XMFROM=+XMFROM,$D(^VA(200,XMFROM,0)) S XQSND=$P(^(0),U)
 S XMSUB="Server Request Reply From "_XQHERE
 S XQMS(.5)="           "_XQDATE
 S XQMS(1)=" "
 S XQMS(2)="Sender: "_XMFROM
 S XQMS(3)="Option name: "_XQSOP
 S XQMS(4)="Subject: "_XQSUB
 S XQMS(5)="Message #: "_XQMSG
 S XQMS(6)=" "
 S:'$D(XQSRV5) XQMS(7)=$S($L(XQER1)>3:"Error reported: "_XQMB6,$L(XQMB6)>3:"Warning: "_XQMB6,1:"No errors reported by the Menu System.")
 S XQMS(8)=" "
 I $D(XQSTXT) S XQN="" F XQI=10:1 S XQN=$O(XQSTXT(XQN)) Q:XQN=""  S XQMS(XQI)=XQSTXT(XQN)
 S XMTEXT="XQMS(",XMY(XMFROM)=""
 D ^XMD
 Q
 ;
NOUSER ;Come here if there is no legitimate user through Bulletin
 S XMY(.5)="",XMTEXT="XQMS("
 S XQMS(0)="               *** WARNING ***"
 S XQMS(1)="  "
 S XQMS(2)="A server option request was received from "_XMFROM
 S XQMS(3)="for a background job on your system on "_XQDATE_"."
 S XQMS(4)="The request was for option "_XQSOP
 S XQMS(5)="Mail message #: "_XQMSG
 S XQMS(6)="  "
 S XQMS(7)="No active user could be identified through the bulletin "_XQMB
 S XQMS(8)="Please insure that a mailgroup of active users is entered for"
 S XQMS(9)="this bulletin.  The security of your system may be compromised!"
 S XQMS(10)="  "
 S XQMS(11)="Other comments/errors: "_XQMB6
 I $D(XQSTXT) S XQN="" F XQI=15:1 S XQN=$O(XQSTXT(XQN)) Q:XQN=""  S XQMS(XQI)=XQSTXT(XQN)
 D ^XMD
 Q
