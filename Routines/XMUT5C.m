XMUT5C ;(WASH ISC)/CAP-Response Time Logger/Purge ;04/17/2002  11:59
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; GO     XMMGR-RESPONSE-TIME-COMPILER
 ; LOGON  XMMGR-RESPONSE-TIME-TOGGLER
 I '$D(ZTQUEUED) U IO(0) W !!,"Compiling Data..."
GO ;Entry for Tasked report
 ;
 S XMV=^%ZOSF("PROD"),(D,Z)=0
 ;
 ;Are there statistics to gather ?  Only gather statistics till T-1.
 ;
 ;Is there a date ?
Z S Z=$O(^%ZRTL(3,XMV,Z)) G Q:$H-Z'>0,Q:Z=""
 ;Is there Response Time data for MailMan ?
 S J=$O(^%ZRTL(3,XMV,Z,"XMA1-DEL/TERM",0)) D S:J
 ;
 ;Kill off Response time data for this date (stored in XMBX now)
 K ^%ZRTL(3,XMV,Z,"XMA1-DEL/TERM") G Z
 ;
 ;Gather 1 days' statistics
S S %H=Z D YMD^%DTC S (E,XMA)=X,S=0
 I '$D(ZTQUEUED) W !,"DATE="_$$FMTE^XLFDT($P(XMA,".",1),"2Z"),! S D=D+1
0 S XMA=$O(^XMBX(4.2998,"B",XMA)) I $S('XMA:1,XMA-E>.999:1,1:0) Q
 S %=$P(XMA,".",2),L=$E(%,1,2)*3600+($E(%,3,4)*60)+$E(%,5,6),(C,T)=0 D G
 S %=$O(^XMBX(4.2998,"B",XMA,0)),$P(^XMBX(4.2998,%,0),U,8)=$S(C>0:$FN(T/C,"",1),1:"")
 G 0
 ;
 ;Get response time out of %ZRTL
G S S=$O(^%ZRTL(3,XMV,Z,"XMA1-DEL/TERM",S)) Q:S=""  I S>L S S=L Q
 S %=^(S),C=C+1,T=S-$P($P(%,"^"),",",2)+T I '$D(ZTQUEUED),C#100=0 W "."
 G G
 ;
 ;Write totals and quit
Q I '$D(ZTQUEUED) W !!,?2,$S(D:D_" Dates Processed and Purged",1:"<<<< Nothing to process >>>>"),!
 K %,%H,%I,C,D,E,J,L,S,T,X,Y,Z,XMA,XMC,XMD,XMV
 Q
ZTSK S ZTRTN="GO^XMUT5C",ZTDTH=$S($D(ZTQUEUED):1,1:0)+$H_","_(3600*18),ZTDESC="Response Time accumulator for file 4.2998",ZTIO="" D ^%ZTLOAD
 Q
LOGON ;Turn ON response time logging
 S X="y" D LOG
 ;Schedule next task
 K ZTREQ S ZTIO="",ZTRTN="LOGOFF^XMUT5C",X=$P($H,",",2),ZTDESC="Turn OFF response Time Logging"
 K % I X<28800 S %=+$H_",29100"
 I X>57600 S %=$H+1_",29100"
 I $D(%) S ZTDTH=%
 E  S %=$H*86400+X+300,ZTDTH=%\86400_","_(%#86400)
 D ^%ZTLOAD S ZTREQ="@" Q
LOGOFF ;Turn OFF response time logging
 S X="n"
 ;Update Kernel Site Parameters LOG RESPONSE TIME FIELD
LOG L +^XTV(8989.3,1)
 S %=^%ZOSF("VOL"),%=$O(^XTV(8989.3,1,4,"B",%,0)),$P(^XTV(8989.3,1,4,%,0),U,6)=X
 L -^XTV(8989.3,1) K %,X S ZTREQ="@"
 Q
