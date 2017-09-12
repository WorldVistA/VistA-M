SR71UTL ;BIR/ADM - Post-install for SR*3*71 ; [ 08/06/97  11:16 AM ]
 ;;3.0; Surgery ;**71**;24 Jun 93
 Q
PRE ; pre-install action for SR*3*71
 I $G(^SRO(139.2,1,0))'="HEMOGLOBIN" D
 .S DA=1,DIK="^SRO(139.2," D ^DIK
 .S ^SRO(139.2,1,0)="HEMOGLOBIN"
 .S ^SRO(139.2,1,2)="70"
 .S DIK="^SRO(139.2,",DIK(1)=".01" D ENALL^DIK K DIK
 Q
POST ; post-install action for SR*3*71
 ; task install notification message
 N SRD,SRNOW X ^%ZOSF("UCI") I $P(Y,",")'=$P(^%ZOSF("PROD"),",") Q
 S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM")!(SRD["TST.")!(SRD["TEST")!(SRD["UTL.") Q
QUEUE ; queue install message
 D NOW^%DTC S (SRNOW,ZTDTH)=$E(%,1,12),ZTRTN="MSG^SR71UTL",ZTDESC="Patch SR*3*71 Install Message",ZTIO="",ZTSAVE("SRNOW")=SRNOW D ^%ZTLOAD
 Q
MSG ; send mail message to national database
 S SRD=^XMB("NETNAME")
 K SRMSG S SRMSG(1)="Patch SR*3*71 has been installed at "_SRD_"."
 S XMSUB="SR*3*71 Installed",XMDUZ=DUZ
 S XMY("G.SR-INSTALL@ISC-BIRM.DOMAIN.EXT")=""
 S XMTEXT="SRMSG(" D ^XMD
END S ZTREQ="@"
 Q
