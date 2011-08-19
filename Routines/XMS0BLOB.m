XMS0BLOB ;(WASH ISC)/CAP-Send BLOBs (other body parts) ;04/18/2002  07:52
 ;;8.0;MailMan;;Jun 28, 2002
 ;
 ;This routine sends BLOBS (Basic Large Objects), also known in the
 ;messaging world as 'Other Body Parts' of messages.
 ;It can do this only with MailMan systems after (not including)
 ;version 7.0.
 ;
 ;A second portion of this code will be able to send to TCP/IP-SMTP
 ;systems that conform to MIME (MEE-MEE), an extension of RFC-822 that
 ;MailMan will conform to when dealing with MIME compatible structures.
 ;
 ;See XMR0BLOB for documentation on MPDUs (Message Protocol Data Units)
 ;exchanged between sender and receiver.
 ;
 ;Get data on BLOB from Imaging files
 S XMSBLOBX=0
0 S XMSBLOBX=$O(^XMB(3.9,XMZ,2005,XMSBLOBX)) G Q:XMSBLOBX="" S Y=$G(^(XMSBLOBX,0)) G 0:Y=""
 S X=+Y,ER=0,Y=$G(^MAG(2005,X,0)) G 0:Y=""
 S XMSBLOBT=Y,XMSBLOBT("#")=X,XMSBLOBT("NAME")=$P(Y,U),XMSBLOBT("FILE")=$P(Y,U,2),XMSBLOBT("DATE")=$P(Y,U,9)
 S Y(0)="" F %=3,4,5 S X=$P(Y,U,%) I X S Y(0)=$G(^MAG(2005.2,X,0)) Q:$L(Y(0))
 G 0:'$L(Y(0)) ;BLOB can not be sent -- no known disk reference
 S XMSBLOBT("DISK")=$P(Y(0),U,2),DIC=2005.02,DIC(0)="NZ"
 S X=$P(XMSBLOBT,U,6) D ^DIC G 0:Y<1 S XMSBLOBT("TYPE")=$P(Y,U,2)
 ;
 ;Send MPDU (Message Protocol Data Unit), Directory to send to returned
 ;
 S XMSG="MESS BLOB: "_XMSBLOBT("FILE")_"^"_XMSBLOBT("NAME")_"^"_XMSBLOBT("TYPE")_"^"_XMSBLOBT("DATE")
1 X XMSEN Q:ER  X XMREC Q:ER  I +XMRG'=250 G 0:$E(XMRG)=4 K ^XMB(3.9,XMZ,1,"AQUEUE",XMINST) N XMA0 S XMA0=XMCI_U_XMINST_U_XMZ D ERRR S XMINST=$P(XMA0,U,2),XMBLOBER=1,XMCI=$P(XMA0,U),XMZ=$P(XMA0,U,3) Q
 ;
 ;Determine IP address to send BLOB to / Use domain file data if it exists
 S %=$P(XMRG,U,2),X=$P($G(^DIC(4.2,XMINST,"IP")),U),%=$S($L(X):X,$L(%):%,1:"")
 I %="" S XMSG="MESS BLOB: < BLOB(s) not sent - No FTP channel defined !!! >" X XMSEN G ERR
 S XMSBLOBT("IP")=%
 ;
 ;FTP file to remote site
 ;
 K XMSFTP S XMSFTP(1)=$P($G(^XMB(1,1,"FTP-GET")),U),XMSFTP(2)=$P(XMRG,U,5),XMSFTP(2,"F")=XMSBLOBT("FILE"),XMSFTP(3)=XMSBLOBT("IP"),XMSFTP("IMAGE-PTR")=XMSBLOBT("#")
 F I=6,7,8 S XMSFTP(I)=$P(XMRG,U,I)
 I '$L($G(XMSFTP(6))) S %=$G(^DIC(4.2,XMINST,3)) I $L(%) S XMSFTP(7)=$P(%,";"),XMSFTP(7.1)=$P(%,";",2)
 D ^XMSFTP K XMSFTP
 G 0
 ;
 ;Record error, set error flag to RESET message transmission,
 ;remove message from queue, send message to sender.
ERRR N ER,XMA0
ERR ;
 N I,XMTEXT,XMSEN,XMREC,XMRECIP,XMSITE,XMSUBJ,XMIEN,XMTO,XMINSTR
 S XMINSTR("FROM")=.5
 S XMSUBJ="TRANSMISSION ERROR (Non-Textual Body-Part Message [BLOB])"
 S XMTEXT(1)="Error (sending your Multi-Body-Part Message):"
 S XMTEXT(2)=" "
 S XMTEXT(3)="Subject: "_$P(XMR,U)
 S XMTEXT(4)=" "
 S XMTEXT(5)=XMSG
 S XMTEXT(6)=" "
 S XMTEXT(7)="The message was not sent.  It was removed from the transmission queue."
 S XMTEXT(8)="You should get this problem fixed and reforward this message"
 S XMSITE=$P(^DIC(4.2,XMINST,0),U)
 S XMTEXT(9)="to the recipients at "_XMSITE_":"
 S XMRECIP=":",I=9
 F  S XMRECIP=$O(^XMB(3.9,XMZ,1,"C",XMRECIP)) Q:XMRECIP=""  D
 . S XMIEN=""
 . F  S XMIEN=$O(^XMB(3.9,XMZ,1,"C",XMRECIP,XMIEN)) Q:XMIEN=""  D
 . . S XMREC=$G(^XMB(3.9,XMZ,1,XMIEN,0))
 . . Q:$P($P(XMREC,U,1),"@",2)'=XMSITE
 . . S I=I+1,XMTEXT(I)=$P(XMREC,U,1)
 . . S XMFWDBY=$P($G(^XMB(3.9,XMZ,1,XMIEN,"F")),U,2)
 . . S:XMFWDBY'="" XMTO(XMFWDBY)=""
 S:'$D(XMTO) XMTO($P(XMR,U,2))=""  ; Sender of the message
 D SENDMSG^XMXSEND(.5,XMSUBJ,"XMTEXT",XMTO,.XMINSTR)
 Q
 ;Clean up and quit
Q K XMSBLOBT,XMSBLOBX,DIC Q
 ;
TEST S XMSEN="Q",XMREC="S XMRG=250",XMZ=18067
 G XMS0BLOB
