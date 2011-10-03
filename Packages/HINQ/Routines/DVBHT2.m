DVBHT2 ;ISC-ALBANY/PKE - HINQ alert parser ; 5/10/92 ; 2/19/03 2:49pm
 ;;4.0;HINQ;**12,20,26,43**;03/25/92
 ;
 ;primary admission only
EVENT Q:'$D(^UTILITY("DGPM",$J,1,DGPMDA))  Q:DGPMP'=""
 S DVBDIV=0
 I $P(^DVB(395,1,"HQ"),"^",13),$P(^DG(43,1,"GL"),"^",2) DO
 .S DVBDIV=$S($D(^DIC(42,+$P(DGPMA,"^",6),0)):+$P(^(0),"^",11),1:0)
 ;
 W:'$G(DGQUIET) !,"Entering a request in the HINQ suspense file..."
 S DVBNOWRT="" D EN^DVBHQUT
 W:'$G(DGQUIET) "completed."
 K DVBNOWRT,DVBDIV Q
 ;
 ;called from d1
IALERT Q:$D(DVBERR)  Q:$D(DVBNETER)  Q:$D(DVBABREV)  Q:'$D(DFN)  Q:'DFN
 Q:$P(^DVB(395.5,DFN,0),"^",6)  U IO(0) W !,"Checking alert data "
 S XQA(DUZ)="" D EN^DVBHT1 K XQA(DUZ) Q
 ;
 ;returns xqa(g.mailgroup or g.dvbhinq),y from hinq parameter file
MAILGP N ENT,LKV
 S ENT=$O(^DVB(395,0)) I ENT="" Q
 S Y=0
 F  S Y=$O(^DVB(395,ENT,"HQMG",Y)) Q:'Y  D
 .S LKV=$P(^DVB(395,ENT,"HQMG",Y,0),"^")
 .Q:(LKV="")
 .Q:('$D(^XMB(3.8,LKV)))
 .I $P(^XMB(3.8,LKV,0),"^")'="" S XQA("G."_$P(^XMB(3.8,LKV,0),"^"))=""
 I $D(XQA)'>9 S XQA("G.DVBHINQ")="",Y=$O(^XMB(3.8,"B","DVBHINQ",0))
 Q
 ;returns xqa(last) or duz requester in suspense file
REQUSR S Y=0 F  S Y=$O(^DVB(395.5,DFN,1,Y)) Q:'Y  I $D(^(Y,0)) DO
 .I $G(LAST)="" S LAST=Y Q
 .I $D(^DVB(395.5,DFN,1,LAST)),($P(^DVB(395.5,DFN,1,Y,0),"^",2)<$P(^DVB(395.5,DFN,1,LAST,0),"^",2)) Q
 .S LAST=Y
 I $D(LAST) S XQA(LAST)="" K LAST Q
 S XQA(DUZ)="" Q
 ;input y
USR I $O(XQA(0))'?1"G.".E Q
 Q:'Y  K DVBDUZ S DVBDUZ=0
 F  S DVBDUZ=$O(^XMB(3.8,+Y,1,"B",DVBDUZ)) Q:'DVBDUZ  S DVBDUZ(DVBDUZ)=""
 Q
 ;
QUE ;entry to queue with taskman from prog mode
 S ZTIO="",ZTRTN="START^DVBHT2",ZTDESC="Clear corrected HINQ alerts"
 D ^%ZTLOAD Q
 ;
 ;queable
START S DFN=0 I '$D(ZTQUEUED) W !?3,"Clearing corrected HINQ alerts",!
 D MAILGP,USR
 F  S DFN=$O(^DVB(395.5,"AC","N",DFN)) Q:'DFN  DO
 .I '$D(^DVB(395.5,DFN,0)) Q
 .D TEM^DVBHIQR I $D(DVBERCS) Q
 .D ACHK^DVBHT1
 .I '$D(DVBNOALR) Q
 .S DVBDUZ=0 F  S DVBDUZ=$O(DVBDUZ(DVBDUZ)) DO  Q:'DVBDUZ  ;do 1 always
 . .S XQAID="DVB,"_DFN,XQAKILL=0
 . .D DELETEA^XQALERT
 . .Q
 .I '$D(ZTQUEUED) W:$X>63 !," " W " ."
 I '$D(ZTQUEUED),$X=1 W !?3,"No alerts cleared..."
 D KILL^XUSCLEAN Q
