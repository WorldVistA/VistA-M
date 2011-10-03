XMA1C ;ISC-SF/GMB-Server Basket APIs ;04/17/2002  07:10
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/ACC/IHS
 ;
 ; Entry points (DBIA 10072):
 ; REMSBMSG  Remove a message from a server basket
 ; SETSB     Put a message in a server basket
 ;
SETSB ; Put a message in a server basket
 ; (Create mail basket for server under postmaster as needed)
 ; In:
 ; XMXX  Server Name (full name, starting with 'S.')
 ; XMZ   Message Number
 ;Messages to server are saved in a mail basket of the
 ;Postmaster much like transmission queues.  But while
 ;Domain queues point at the domain file (domain#+1000),
 ;Server baskets point at the option file (option#+10000).
 D PUTSERV^XMXMSGS1(XMXX,XMZ)
 Q
REMSBMSG ; Remove a message from a server basket
 ; In:
 ; XMSER  Server Name (full name, starting with 'S.')
 ; XMZ    Message number
 D ZAPSERV^XMXMSGS1(XMSER,XMZ)
 K XMKD,XMZ,XMDUZ,XMK,XMSER
 Q
