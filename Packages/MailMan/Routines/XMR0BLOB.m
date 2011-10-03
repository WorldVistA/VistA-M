XMR0BLOB ;(WASH ISC)/CAP-BLOB Receive ;09/15/97  09:28
 ;;8.0;MailMan;;Jun 28, 2002
 ;
 ;This routine receives BLOBS (Basic Large OBjects), also known in the
 ;messaging world as 'Other Body Parts' of messages.
 ;It can do this only with Mailman systems after (not including)
 ;version 7.0.
 ;
 ;A later capability is planned to receive TCP/IP-SMTP messaes that
 ;conform to MIME (MEE-MEE), an extension to RFC-822 that MailMan will
 ;conform to.
 ;
 ;Message Protocol Data Unit (MPDU) received in X (from XMR0A) contains:
 ;
 ;file_name^BLOB_name^BLOB_type^Origin Date
 ;(Eg.  X="XIMAGE.756^XRAY2-ulna^STLL IMAGE^2930430
 ;API entry requires Path, Netmail entry automatically defaults it
 ;
 ;Returns: 250 Okay file_path
 ;
BLOB(X) ;Receive BLOB
 ;
 ;Reject BLOBs
 I '$D(^DD(2005)) S XMSG="555 Reject - Imaging not installed at "_^XMB("NETNAME"),ER=1 X XMSEN G Q
 ;Cannot recieve BLOB without REGISTERED SUBDIRECTORY in DOMAIN file
 F  Q:$E(X)'=" "  S X=$E(X,2,999)
 ;
 S %=$G(^DIC(4.2,XMINST,"FTP/DIR"))
 ;FTP DIRECTORY (File 4.2, Field 6.7) -- Sub-directory for a domain
 ;
 ;Receive message into Kernel Site Parameter DISK/VOL (7.7) entry
 S Y=$G(^XMB(1,1,"DISK/VOL"))
 I %_Y="",'$L($P($G(^XMB(1,1,"FTPRCVDISK")),U)) S XMSG="550 Reject - No DISK/VOL or DOMAIN Directory defined in Kernel Site Parameters at "_^XMB("NETNAME") X XMSEN G Q
 S XMR0BLOB("DISK")=Y_$S(%="":"",1:$S($L(Y,"\")>1:"",1:"\"))_%
 ;
 S XMR0BLOB("FILE")=$P(X,U),XMR0BLOB("NAME")=$P(X,U,2),XMR0BLOB("TYPE")=$P(X,U,3),XMR0BLOB("FTP")=Y,XMR0BLOB("DATE")=$P(X,U,4)
 ;
 ;
FILE K DIC
 ;First make sure pointer fields exist in pointed at files
 ;Network Location
 ;Is it there ?
 S X=$P($G(^XMB(1,1,"FTPNETLOC")),U),X=$S($L(X):X,1:"MAG1"),DIC=2005.2,DIC(0)="XF" D ^DIC
 ;If not there set it up
 I Y<0 D FILE^DICN
 S XMR0BLOB("DISK")=Y
 ;
 ;(TYPE)
 ;Is it there ?
 K DIC S DIC=2005.02,DIC(0)="FX",X=XMR0BLOB("TYPE") D ^DIC
 ;If not there set it up
 I Y<0 D FILE^DICN
 S XMRBLOB("TYPE")=+Y
 ;
 ;Is it already in the file ?
 S X=XMR0BLOB("NAME"),DIC="^MAG(2005,",DIC(0)="FO" D ^DIC I +Y>0 S XMSG="442 File previously exists",X=$$2005(Y) X XMSEN G Q
 ;
 ;Finally it's time to stuff the entry in the master file
 ;Sends: FTP Address^ ^ ^ ^ Path ^ Username ^ Password ^ Physical Disk
 ;EG. 250 Okay^1.2.0.1^^^image\subdir^USERNAME^PASSWORD^_nfa0:
 S XMSG="250 Okay ^"_$G(^XMB(1,1,"FTP-RCV"))_"^^^"_$G(^("DISK/VOL"))_U_$G(^("FTPUSER"))_U_$G(^("FTPPWD"))_U_$P($G(^("FTPRCVDISK")),U)
 X XMSEN G Q:ER
 S DIC="^MAG(2005,",DIC(0)="FI",X=XMR0BLOB("NAME") D FILE^DICN
 S DIE="^MAG(2005,",DR="2///"_+XMR0BLOB("DISK")_";1///"_XMR0BLOB("FILE")_";3///"_XMR0BLOB("TYPE")_$S($L(XMR0BLOB("DATE")):";14///"_XMR0BLOB("DATE"),1:""),DA=+Y
 D ^DIE S X=$$2005(DA)
Q K DO,DD,DIC,DO,DD,DA,XMR0BLOB
 Q
2005(X) ;Add to Message BLOB list
 N XMFDA
 S XMFDA(3.92005,"?+1,"_$G(XMZIENS,XMZ_","),.01)=X
 D UPDATE^DIE("","XMFDA")
 Q 1
API(X) ;BLOB (XMD,XMB)
 N %,I,XMMG,XMR0BLOB,XMSEN,XMSG,XMREC
 F %=1:1:5 S XMR0BLOB($P("FILE^TYPE^NAME^DATE^DISK",U,I))=$P(X,U,I)
 D FILE
 Q $S(+XMSG=250:1,+XMSG=440:1,1:0)
