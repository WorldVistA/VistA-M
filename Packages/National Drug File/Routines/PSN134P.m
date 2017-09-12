PSN134P ;BIR/DMA-find interactions that weren't sent ; 29 Mar 2007  11:39 AM
 ;;4.0; NATIONAL DRUG FILE;**134**; 30 Oct 98;Build 19
 ;
 ;Reads to the AUDIT file (#1.1), ^DIA, supported by DBIA #2602
 ;
 N HERE,LINE,PSN,PSN1,PSN2,PSN3,PSN4,PSNIIEN,PSNFLTY,XMDUZ,XMSUB,XMTEXT,XMY,Y
 S LINE=6 K HERE
 S PSNIIEN=$$KSP^XUPARAM("INST"),PSNFLTY=$$GET1^DIQ(4,PSNIIEN,.01)
 S PSN=$Q(^DIA(56,"C",3061026)) I $QS(PSN,2)'="C" S HERE(1,0)="There were no interactions created at "_PSNFLTY_" after 26 October 2006." G SEND
 S PSN=$QS(PSN,4) F  S PSN=$O(^DIA(56,PSN)) Q:'PSN  S PSN1=^(PSN,0) I $P(PSN1,"^",5)="A",PSN1>14999 Q
 I 'PSN S HERE(1,0)="There were no interactions created at "_PSNFLTY_" after 26 October 2006." G SEND
 S PSN1=+PSN1-1 F  S PSN1=$O(^PS(56,PSN1)) Q:'PSN1  S PSN2=^(PSN1,0),PSN3=$P(PSN2,"^"),PSN4=$P(PSN2,"^",4),$E(PSN3,70)=" "_$S(PSN4=1:"Crit",1:"Signif"),HERE(LINE,0)=PSN3,LINE=LINE+1
  I '$D(HERE) S HERE(1,0)="There were no interactions created at "_PSNFLTY_" after 26 October 2006." G SEND
 S HERE(1,0)="The following interactions were created at "_PSNFLTY_" after 26 October 2006.",HERE(2,0)=" ",HERE(3,0)="INTERACTION",$E(HERE(3,0),70)="SEVERITY",HERE(4,0)="===========",$E(HERE(4,0),70)="========",HERE(5,0)=" "
 ;
SEND ;
 S XMDUZ=DUZ K XMY
 X ^%ZOSF("UCI") S PSN=^%ZOSF("PROD") S:PSN'["," Y=$P(Y,",") I Y=PSN S XMY("G.NDF SUPPORT@ISCPNDF.FO-BIRM.DOMAIN.EXT")=""
 S XMY("G.NDF DATA@"_^XMB("NETNAME"))=""
 S PSN=0 F  S PSN=$O(^XUSEC("PSNMGR",PSN)) Q:'PSN  S XMY(PSN)=""
 I $D(DUZ) S XMY(DUZ)=""
 S XMSUB="Local Drug Interactions Added at "_PSNFLTY_" since 26 Oct 2006."
 S XMTEXT="HERE(" N DIFROM D ^XMD
QUIT K HERE,LINE,PSN,PSN1,PSN2,PSN3,PSN4,PSNIIEN,PSNFLTY,XMDUZ,XMSUB,XMTEXT,XMY,Y
