XMDIRRCV ;(WASH ISC)/CWU-Receive Email Directory ;04/18/2002  07:32
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; RECEIVE  XMMGR-DIRECTORY-RECV
RECEIVE ;
 S XMA=0
 ;
 ;Get pointer to domain data is coming from
 S %=$P($P($P(^XMB(3.9,XMZ,0),U,2),"@",2),">")
 S XMDIR1A("CODE")=$S(%="":^XMB("NETNAME"),1:%)
 N DIK S DA=0,DIK="^XMD(4.2997,"
 F  S DA=$O(^XMD(4.2997,"E",XMDIR1A("CODE"),DA)) Q:+DA'=DA  D ^DIK
 ;
 ;Begin main loop
 ;
A ;X XMREC
 ;I $D(XMER) G Q:XMER<0
 ;S XMA=XMA+1
 ;S XMTXT(XMA)=XMRG
 ;G A
Q ; SET UP FOR RECEIVING EMAIL DIRECTORY
 N %,%1,%5,%6
 S XMDIR1=$E(DT,1,5)-200
 S %=.999999
 F  S %=$O(^XMB(3.9,XMZ,2,%)) Q:%=""  S %1=$G(^XMB(3.9,XMZ,2,%,0)) D
 . Q:%1=""
 . S X("LN")=$P(%1,U),X("FN")=$P(%1,U,2),X("RN")=$P(%1,U,3),X("MC")=$P(%1,U,4),X("EMC")=$P(%1,U,5),X("L")=$P(%1,U,6),X("NET")=$P(%1,U,7)
 . Q:X("LN")=""
 . I $D(^XMD(4.2997,"B",X("LN"))) S %5="" F  S %5=$O(^XMD(4.2997,"B",X("LN"),%5)) Q:%5=""  I $D(^XMD(4.2997,%5,0)) S %6=^XMD(4.2997,%5,0) Q:X("NET")=$P(%6,U,7)
 . D FILE^XMDIR1A(.X)
 ;
 ;FINISH UP
 ;
 ;Set up for call to MailMan programmer interface
 S XMTEXT="XMTXT(",^TMP("XMY",$J,.5)=""
 S XMTXT(XMA+1)=" "
 S XMTXT(XMA+2)="This message arrived through a server routine."
 ;
 ;Call MailMan programmer interface
 D ^XMD
 D ZAPSERV^XMXMSGS1("S."_XQSOP,XQMSG)
 Q
