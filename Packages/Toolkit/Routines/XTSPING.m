XTSPING ;SFISC/RWF - PING SERVER ;8/11/92  15:02;10/20/92  3:49 PM
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;This server just sends back the message it receved.
A S XMSUB="PING reply to: "_XQSUB,XMY(XMFROM)="",XMTEXT="^XMB(3.9,"_XMZ_",2,"
 S XMDUZ="PING SERVER"
 N XMFROM,XMZ,XMREC,XMCHAN D ^XMD
 Q
