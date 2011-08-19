MCWORKLD ;WISC/RMP-Workload reporting ;4/8/97  07:47
 ;;2.3;Medicine;**8**;09/13/1996
 ;Routine which delivers a Mail message to the
 ;specified Device(s) and Mailgroup(s) when a procedure
 ;with an assigned CPT code has been released with a signature
 ;
 N CNT,DEVICE,MAILGRP,ARRAY
 Q:$P($G(^MCAR(690.1,1,0)),U,7)'="Y"  ;Check Workload toggle
 Q:'($D(^MCAR(MCFILE,MCARGDA,0))#2)  ;Check o node for G.P. patch
 Q:$P($G(^MCAR(MCFILE,MCARGDA,"ES")),U,7)["S"  ;Don't send a message
 ;for a superceded record
 D TEXT(MCFILE,MCARGDA,.ARRAY) ;Check for completeness
 Q:'$D(ARRAY)
 ;Device/Mailgroup parameter loading
 I $D(^MCAR(690.1,1,1,0)) D
 .S CNT=0
 .F  S CNT=$O(^MCAR(690.1,1,2,CNT)) Q:CNT'?1N.N  D
 ..Q:'$D(^MCAR(690.1,1,2,CNT,0))
 ..N MCARCNT S MCARCNT=^MCAR(690.1,1,2,CNT,0)
 ..S DEVICE(CNT)=$P(^%ZIS(1,MCARCNT,0),U)
 ..Q
 .Q
 I $D(^MCAR(690.1,1,2,0)) D
 .S CNT=0
 .F  S CNT=$O(^MCAR(690.1,1,1,CNT)) Q:CNT'?1N.N  D
 ..Q:'$D(^MCAR(690.1,1,1,CNT,0))
 ..N MCARCNT S MCARCNT=^MCAR(690.1,1,1,CNT,0)
 ..S MAILGRP(CNT)=$P(^XMB(3.8,MCARCNT,0),U)
 ..Q
 .Q
 ;Q:($G(DEVICE(1))=0)&($G(MAILGRP(1))=0)
 Q:($D(DEVICE)=0)&($D(MAILGRP)=0)
 ; Mailman parameters
 S XMSUB="Completed Coded Medicine Procedure"
 S XMTEXT="ARRAY(",XMDUZ=DUZ,XMCHAN=""
 S CNT=0 F  S CNT=$O(DEVICE(CNT)) Q:CNT=""  S XMY("D."_DEVICE(CNT))=""
 S CNT=0 F  S CNT=$O(MAILGRP(CNT)) Q:CNT=""  S XMY("G."_MAILGRP(CNT))=""
 D ^XMD
 D KILL^XM
 Q
 ;
TEXT(MCFILE,MCARGDA,ARRAY) ;
 ;Report variables:
 ;DFN  -- Patient ID, pointer to the Patient file (2)
 ;PRID -- Provider ID, DUZ or pointer to the New Person file (200)
 ;PRNAME -- Provider Name
 ;PDATET -- Procedure Date/Time, DATE SIGNED
 ;CPT  -- CPT code, Code associated throught the Procedure Term file
 N PTMP,PRNAME,CPT,MCDATET,SSN
 K ARRAY
 S PRID=$P($G(^MCAR(MCFILE,MCARGDA,"ES")),U,4)
 S FMDT=$P($G(^MCAR(MCFILE,MCARGDA,"ES")),U,6),Y=FMDT
 S DFN=$$DFN(MCFILE,MCARGDA)
 S CPT=$$CPT(MCFILE,MCARGDA)
 I (PRID="")!(FMDT="")!(DFN="")!(CPT="") Q
 D DD^%DT S MCDATET=Y
 ; ------------------------
 ; SSN = Enternal Format of the patients SSN.
 ; ------------------------
 D DEM^VADPT S MCARNM=VADM(1),SSN=$P(VADM(2),U,2) D KVAR^VADPT
 S PTMP=$P(^VA(200,PRID,0),U),PRNAME=$P(PTMP,",",2)_" "_$P(PTMP,",")
 S ARRAY(1)="Patient:   "_MCARNM
 S ARRAY(2)="SSN:       "_SSN
 S ARRAY(3)="Procedure: "_CPT
 S ARRAY(4)="Date/Time: "_MCDATET
 S ARRAY(5)="Provider:  "_PRNAME
 Q
 ;
CPT(FILE,DA) ;
 N TEMP,IEN,CPT,PRO
 S CPT=""
 S MCARP=$O(^MCAR(697.2,"B",$$MCPRO(FILE,DA),0))
 S IEN=$O(^MCAR(694.8,"PS",MCARP,0))
 ;Q:IEN=""
 I IEN]"",$D(^MCAR(694.8,IEN,1,0)) S TEMP=0,PRO=$P($G(^MCAR(694.8,IEN,0)),U) D
 .F  Q:CPT?1N.N  S TEMP=$O(^MCAR(694.8,IEN,1,TEMP)) Q:TEMP'?1N.N  D
 ..I $P($P(^(TEMP,0),U),";",2)["ICPT(" S CPT=$P($P(^(0),U),";")
 ..Q
 .S CPT=PRO_" "_CPT  ;V2.3, E3R 8219, JCC, 5/13/96
 Q CPT
 ;
DFN(FILE,DA)  ;
 N TEMP
 ;S TEMP=$P(^DD(FILE,$$PATFLD(FILE,DA),0),U,4)
 S TEMP=$$GET1^DID(FILE,$$PATFLD(FILE,DA),"","GLOBAL SUBSCRIPT LOCATION")
 Q $P($G(^MCAR(FILE,MCARGDA,$P(TEMP,";"))),U,$P(TEMP,";",2))
 ;V2.3, FIX UNDEF, JCC, 5/21/96
PATFLD(FILE,DA) ;
 N TEMP
 S TEMP=$G(^MCAR(697.2,$O(^MCAR(697.2,"B",$$MCPRO(FILE,DA),0)),0))
 Q $P(TEMP,U,12)
MCPRO(MCFILE,MCARGDA) ;694(0;3),699(0;12),699.5(0;6)
 ;HAVE MULTIPLE FILE 697.2 ENTRIES
 I (MCFILE=694)!(MCFILE=699)!(MCFILE=699.5) Q $$MCP(MCFILE,MCARGDA)  ;V2.3, CHGED SECOND 699 TO 699.5, JCC, 6/17/96
 Q $P(^MCAR(697.2,$O(^MCAR(697.2,"C","MCAR("_MCFILE,0)),0),U)
MCP(MCFILE,MCARGDA) ;
 Q $P(^MCAR(697.2,$P($G(^MCAR(MCFILE,MCARGDA,$$NODE(MCFILE))),U,$$PIECE(MCFILE)),0),U)
NODE(MCFILE) ;
 Q $S(1:0) ;694&699&699.5 use the 0 node
PIECE(MCFILE) ;
 Q $S(MCFILE=694:3,MCFILE=699:12,MCFILE=699.5:6,1:0)
WLTOG ;Medicine Workload reporting Toggle
 ;S DIE=690.1,DA=1,DR="6//"_$S($P($G(^MCAR(690.1,1,0)),U,7)="Y":"N",1:"Y"),DIC(0)="E" D ^DIE K DIE,DIC,DA,DR Q
 D PARAM^MCU("6//"_$S($P($G(^MCAR(690.1,1,0)),U,7)="Y":"N",1:"Y"))
 Q
WLMGP ;Medicine Workload Mailgroup recipients
 ;S DIE=690.1,DA=1,DR=7,DIC(0)="E" D ^DIE K DIC,DIE,DA,DR Q
 D PARAM^MCU(7)
 Q
WLDEV ;Medicine Workload Print Device selection
 ;S DIE=690.1,DA=1,DR=8,DIC(0)="E" D ^DIE K DIC,DIE,DA,DR Q
 D PARAM^MCU(8)
 Q
