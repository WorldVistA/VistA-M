SR70UTL ;BIR/ADM - POST-INSTALL FOR SR*3*70 ; [ 10/15/97  8:45 AM ]
 ;;3.0; Surgery ;**70**;24 Jun 93
 Q
POST ; post-install action for SR*3*70
 ; task install notification message
 N SRD S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM")!(SRD["TST.")!(SRD["TEST")!(SRD["UTL.")!(SRD["TRAIN") Q
QUEUE ; queue install message
 D NOW^%DTC S ZTDTH=$E(%,1,12),ZTRTN="MSG^SR70UTL",ZTDESC="Patch SR*3*70 Install Message",ZTIO="" D ^%ZTLOAD
 Q
MSG ; send mail message to national database
 S SRD=^XMB("NETNAME")
 K SRMSG S SRMSG(1)="Patch SR*3*70 has been installed at "_SRD_"."
 S XMSUB="SR*3*70 Installed",XMDUZ=DUZ
 S XMY("G.SR-INSTALL@ISC-BIRM.DOMAIN.EXT")=""
 S XMTEXT="SRMSG(" D ^XMD
QR S (SRFLG,SRT)=1 D NOW^%DTC S SRNOW=$E(%,1,12)
 ; queue quarterly report for 1st quarter of FY97
 S SRSTART=2961001,SREND=2961231 D TSK
 ; queue quarterly report for 2nd quarter of FY97
 S SRSTART=2970101,SREND=2970331 D TSK
 ; queue quarterly report for 3rd quarter of FY97
 S SRSTART=2970401,SREND=2970630 D TSK
 ; queue quarterly report for 4th quarter of FY97 if already transmitted
 I $P(^SRO(133,$O(^SRO(133,0)),0),"^",18)>19973 S SRSTART=2970701,SREND=2970930 D TSK
END S ZTREQ="@"
 Q
TSK S ZTDTH=SRNOW,ZTIO="",ZTDESC="Surgery Quarterly Report",(ZTSAVE("SRSTART"),ZTSAVE("SREND"),ZTSAVE("SRFLG"),ZTSAVE("SRT"))="",ZTRTN="EN^SROQT" D ^%ZTLOAD
 Q
