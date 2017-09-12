SR50UTL ;BIR/ADM - Utility Routine for SR*3*50 ; [ 09/22/98  3:27 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
ENV ;environmental check for SR*3*50 to confirm that SR*3*41 is installed
 I '$$PATCH^XPDUTL("SR*3.0*41") D BMES^XPDUTL("Patch SR*3*41 must be installed before installing this patch!") S XPDQUIT=2
 Q
POST ;post-install process for SR*3*50
 ;re-transmit Quarterly Reports for FY98
 N SRD,SREND,SRFLG,SRNOW,SRSTART,SRT
 S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM")!(SRD["TST.")!(SRD["TEST")!(SRD["UTL.")!(SRD["TRAIN")!(SRD["DEMO.") Q
 S (SRFLG,SRT)=1 D NOW^%DTC S SRNOW=$E(%,1,12)
 S SRSTART=2971001,SREND=2971231 D TSK ; first quarter
 S SRSTART=2980101,SREND=2980331 D TSK ; second quarter
 I DT>2980813 S SRSTART=2980401,SREND=2980630 D TSK ; third quarter
 I DT>2981113 S SRSTART=2980701,SREND=2980930 D TSK ; fourth quarter
 S ZTDTH=SRNOW,ZTIO="",ZTDESC="Lock All Eligible Surgery Cases",ZTRTN="ALL^SROLOCK" D ^%ZTLOAD
 Q
TSK S ZTDTH=SRNOW,ZTIO="",ZTDESC="Surgery Quarterly Report",(ZTSAVE("SRSTART"),ZTSAVE("SREND"),ZTSAVE("SRFLG"),ZTSAVE("SRT"))="",ZTRTN="EN^SROQT" D ^%ZTLOAD
 Q
