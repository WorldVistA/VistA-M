SR47UTL ;BIR/ADM-PRE & POST INIT FOR SR*3*47 ; [ 03/05/96  2:00 PM ]
 ;;3.0; Surgery ;**47**;24 Jun 93
 Q
PRE ; preinit action for SR*3*47
 S ^SRO(136.5,7,1,0)="^^7^7^2951120^^",^SRO(136.5,7,1,5,0)="extubation after general anesthesia.  This may be diagnosed as congestive"
 S ^SRO(136.5,7,1,6,0)="heart failure, pulmonary edema and/or Adult Respiratory Distress Syndrome",^SRO(136.5,7,1,7,0)="(ARDS)."
 S ^SRO(136.5,15,1,3,0)="(including autologous) given up to 72 hours after the patient leaves the",^SRO(136.5,15,1,4,0)="operating room."
 S $P(^SRO(136.5,11,0),"^",2)=1 F I=7,16,17,21 S $P(^SRO(136.5,I,0),"^",3)=1
 I $D(^DD(130,0,"ID","WRITE")) K ^DD(130,0,"ID","WRITE")
 I $D(^DD(130,0,"ID",1)) K ^DD(130,0,"ID",1)
 Q
POST ; postinit action for SR*3*47
 ; update completed assessments with PIMS info
 S DFN=0 F  S DFN=$O(^SRF("ARS","N","C",DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","N","C",DFN,SRTN)) Q:'SRTN  D
 .I $P($G(^SRF(SRTN,"RA")),"^",6)'="Y" Q
 .S SR=$G(^SRF(SRTN,208)) S NOGO="" F I=10,14,15,16,17 S X=$P(SR,"^",I) I X'="" S NOGO=1 Q
 .I 'NOGO D ^SROAPIMS
TSK ; task install notification message
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") G END
 S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM") G END
QMSG ; queue install message to national database
 D NOW^%DTC S ZTDTH=$E(%,1,12),ZTRTN="MSG^SR47UTL",ZTDESC="Patch SR*3*47 Install Message",ZTIO="" D ^%ZTLOAD
END K DFN,NOGO,SR,SRD,SRDA,SRMSG,SRTN,SRX,SRY,SRZ,XMSUB,XMY,XMDUZ,XMTEXT
 Q
MSG ; send mail message to national database
 H 15 S SRD=^XMB("NETNAME"),X=0 F  S X=$O(^XPD(9.7,"B","SR*3.0*47",X)) Q:'X  S SRDA=X
 G:'$G(SRDA) END S Z=$G(^XPD(9.7,SRDA,1)),SRZ=$P(Z,"^"),SRY=$P(Z,"^",3),SRZ=$$FMTE^XLFDT(SRZ),SRY=$$FMTE^XLFDT(SRY)
 K SRMSG S SRMSG(1)="Patch SR*3*47 has been installed at "_SRD_"."
 S SRMSG(2)="Start time: "_SRZ,SRMSG(3)="End time: "_SRY
 S XMSUB="SR*3*47 Installed",XMDUZ=DUZ
 S XMY("G.SRCOSERV@ISC-CHICAGO.VA.GOV")=""
 S XMTEXT="SRMSG(" D ^XMD S ZTREQ="@"
 Q
