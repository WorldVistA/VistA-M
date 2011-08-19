DG53213P ;BP-CIOFO/KEITH - NPCDB patient demographics extraction utility ; 07 Dec 98 12:05 PM
 ;;5.3;Registration;**213**;AUG 13, 1993
 ;
NOQ ;Suppress option question
 S:$G(XPDENV)=1 XPDDIQ("XPZ1")=0 Q
 ;
RUN ;Exit if XTMP global exists
 N X F X=1:1:10 L ^XTMP("DG53213P",0):1 Q:$T
 I '$T D BMES^XPDUTL("Unable to lock global try later!") Q
 I $D(^XTMP("DG53213P",0)),$$ZQ() G LQ
 ;
BQ ;Queue extraction global build process
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,DGI,Y,%,%H,%I
 S ZTRTN="BUILD^DG53213P",ZTDESC="NPCDB patient demographics extraction"
 D NOW^%DTC S (DGQDT,ZTDTH)=XPDQUES("POS1"),ZTIO=""
 F DGI=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 I '$G(ZTSK) D BMES^XPDUTL("Unable to queue extraction, contact Customer Service for assistance!") G LQ
 S Y=DGQDT X ^DD("DD")
 N X1,X2,DGPDT K ^XTMP("DG53213P")
 S X1=DT,X2=30 D C^%DTC S DGPDT=X
 S ^XTMP("DG53213P",0)=DGPDT_U_DT_"^Patch DG*5.3*213 NPCDB patient demographics extraction global.  Created by user: "_DUZ
 S ^XTMP("DG53213P",1,"QUEUED")=DGQDT_U_ZTSK
 D BMES^XPDUTL("NPCDB patient demographics extraction queued for "_$P(Y,":",1,2))
 D BMES^XPDUTL("Task number: "_ZTSK)
LQ L -^XTMP("DG53213P")
 Q
 ;
ZQ() ;Determine if process is already queued
 N ZTSK S ZTSK=+$P($G(^XTMP("DG53213P",1,"QUEUED")),U,2) Q:'ZTSK 0
 D STAT^%ZTLOAD Q:'ZTSK(0) 0  Q:"0345"[ZTSK(1) 0
 D BMES^XPDUTL("Patient demographics extraction not queued--")
 D BMES^XPDUTL("It appears that this process is already in progress!")
 Q 1
 ;
BUILD ;Build XTMP global with list of records to send
 S (DGFS,DGOUT)=0 F DGI="COUNT","SENT" S ^XTMP("DG53213P",1,DGI)=0
 ;
 ;Get patient list
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN!DGOUT  D
 .I DFN#500=0 D STOP Q:DGOUT
 .I $L($P($G(^DPT(DFN,.1)),U)) D SET("CI") Q  ;Current inpatient
 .I $O(^DGPM("APTT3",DFN,""),-1)>2981001 D SET("DC") Q  ;Discharged this Fiscal Year
 .I $$OUTPTPR^SDUTL3(DFN) D SET("PC") Q  ;Assigned to PC provider
 .Q
 ;
 I DGOUT S DGFS=1 K ^XTMP("DG53213P",2) D REQUE("BUILD^DG53213P"),MSG Q
 ;
 S ^XTMP("DG53213P",1,"GROUP")=^XTMP("DG53213P",1,"COUNT")\7+1
 ;
SEND ;Send group of patient records to NPCDB
 S (DGOUT,DGFS)=0,DGGP=^XTMP("DG53213P",1,"GROUP")
 S (DGCT,DGERR,DFN)=0
 F  S DFN=$O(^XTMP("DG53213P",2,DFN)) Q:DGCT>DGGP!'DFN!DGOUT  D S1
 I 'DGOUT,DGCT<DGGP,$D(^XTMP("DG53213P",2)) G SEND
 S ^XTMP("DG53213P",1,"SENT")=^XTMP("DG53213P",1,"SENT")+DGCT
 I $$DONE() D MSG K ^XTMP("DG53213P") Q
 D REQUE("SEND^DG53213P"),MSG Q
 ;
REQUE(ZTRTN) ;Requeue for tomorrow's run
 ;Required input: ZTRTN=routine to queue
 N ZTDESC,ZTIO,X,Y,%,%H,%I,X1,X2,X
 S %H=ZTDTH D YX^%DTC S ZTDTH=X_%
 S ZTDESC="NPCDB patient demographics extraction"
 S X1=ZTDTH,X2=1 D C^%DTC S (DGQDT,ZTDTH)=X,ZTIO=""
 F DGI=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 I $G(ZTSK) S ^XTMP("DG53213P",1,"QUEUED")=DGQDT_U_ZTSK
 S:'$G(ZTSK) DGERR=1
 Q
 ;
MSG ;Send mail message
 N XMSUB,XMDUZ,XMDUN,XMTEXT,XMY,XMZ,DG,DA,DIE,DR
BMSG S XMSUB="NPCDB patient demographics extraction",DGERR=$G(DGERR,0)
 S (XMDUZ,XMDUN)="Patch DG*5.3*213"
 D M1 S XMTEXT="DG(",XMY(DUZ)="" D ^XMD
 ;
CLEAN K DGFS,DGOUT,DGQDT,DGERR,DGI,DFN,DGCT,DGGP,DGPV Q
 ;
M1 ;Message text
 S DGI=0 I '$$DONE() S Y=DGQDT X ^DD("DD")
 D TXT("          *** Status of NPCDB patient demographics extraction ***"),TXT(" ")
 I $$DONE(),'DGFS D TXT("              NPCDB patient demographics extraction completed!"),TXT(" ")
 I DGERR D TXT("Unable to queue NPCDB patient demographics extraction continuation--"),TXT("Please contact Customer Service for assistance!"),TXT(" ")
 D:'DGFS TXT("      Number of records found to send: "_^XTMP("DG53213P",1,"COUNT"))
 D:'DGFS TXT("Number of records that have been sent: "_^XTMP("DG53213P",1,"SENT"))
 D:DGFS TXT("Extraction process was requested to stop before building a complete list.")
 D:DGFS TXT("The partially built list was cleared, extraction will be restarted as follows:")
 D TXT(" ")
 I '$$DONE()!DGFS,'DGERR D
 .D:DGFS TXT("          NPCDB extraction queued for: "_Y)
 .D:'DGFS TXT("         Next transmission queued for: "_Y)
 .D TXT("                          Task number: "_ZTSK)
 .Q
 I $$DONE(),$D(^XTMP("DG53213P",4)) D
 .D TXT("Unable to send these records:")
 .S DFN=0 F  S DFN=$O(^XTMP("DG53213P",4)) Q:'DFN  D
 ..D TXT("IFN: "_DFN_"  NAME: "_$P($G(^DPT(DFN,0),"UNKNOWN"),U))
 ..Q
 .Q
 Q
 ;
TXT(DGT) ;Build message line
 ;Required input: DGT=line of text
 S DGI=DGI+1,DG(DGI)=DGT Q
 ;
DONE() ;Determine if extraction is finished
 Q '$D(^XTMP("DG53213P",2))
 ;
S1 ;Send a record
 I DGCT#100=0 D STOP Q:DGOUT
 S DGPV=$$PIVNW^VAFHPIVT(DFN,$$NOW^XLFDT(),4,DFN_";DPT(")
 I 'DGPV D  Q
 .S ^XTMP("DG53213P",2,DFN)=^XTMP("DG53213P",2,DFN)+1
 .Q:^XTMP("DG53213P",2,DFN)<3
 .S ^XTMP("DG53213P",4,DFN)=""
 .K ^XTMP("DG53213P",2,DFN) Q
 D XMITFLAG^VAFCDD01(,DGPV)
 S ^XTMP("DG53213P",3,DFN)=DGPV,DGCT=DGCT+1
 K ^XTMP("DG53213P",2,DFN)
 Q
 ;
SET(DGR) ;Set patient list node
 ;Required input: DGR=reason for inclusion
 S ^XTMP("DG53213P",2,DFN)=DGR
 S ^XTMP("DG53213P",1,"COUNT")=^XTMP("DG53213P",1,"COUNT")+1
 Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (DGOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
