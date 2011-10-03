SD53P491 ;ALB/ESW - SD*5.3*491 POST INIT; Oct 04, 2006 ; 10/23/06 5:40pm  ; Compiled June 17, 2008 10:41:32
 ;;5.3;SCHEDULING;**491**;AUG 13, 1993;Build 53
 ;Remove trigger - field .01 in the SD WL CLINIC LOCATION file (# 409.32)
 ;Verify setup of Billable Appointment type: ein=11 - SC
 ;Update encounters with Appointment Type matching the SC set up on the encounter level
 ;Update file 409.32 and 409.3 with proper institution set up
 ;Retransmission of updated encounters has been disabled
 Q
 ;
POST ;
 N SDA
 S SDA(1)="",SDA(2)="    SD*5.3*491 Post-Install .....",SDA(3)="" D ATADDQ
 N SDA
 S SDA(1)="",SDA(2)=" Deleting cross-reference definition - trigger of the CLINIC field"
 S SDA(3)=" in the SD WL CLINIC LOCATION file (# 409.32)",SDA(4)=""
 D DELIX^DDMOD(409.32,.01,2,"K") D ATADDQ
 ;
 D ATADD ; Verify Billable Appointment Type: ien=11
 ;  ^IBE(352.1,11,0)=11^11^2880101^0^1^1
 S SDA(1)="",SDA(2)="  SD*5.3*491 SC Billable Appointment Type error checking is complete",SDA(3)="" D ATADDQ
 N SDA
 S SDA(1)="",SDA(2)="Starting Appointment Type verification for Outpatient Encounter file entries",SDA(3)="with encounter-level Service Connection for encounter entries created",SDA(4)="Jan 20, 2006 or later",SDA(5)="" D ATADDQ
 ;
 D CHKSC
 N SDA
 S SDA(1)="",SDA(2)="Appointment Type correction to file 409.68 and to sub-file 2.98 finished.",SDA(3)="" D ATADDQ
 ;
 N SDA
 S SDA(1)="",SDA(2)="Checking file 409.32 and 409.3 for valid national institutions, and pointers",SDA(3)="that don't match institutions of the Medical Center Division of their related",SDA(4)="Hospital Location",SDA(5)="" D ATADDQ
 N INERROR,SDWLSC,SDX,CNT S INERROR=""
 S SDX(1)="Checking file 409.32 and 409.3 for valid national institutions, and pointers"
 S SDX(2)="that don't match institutions of the Medical Center Division of their related"
 S SDX(3)="Hospital Location"
 S SDX(4)="",CNT=4 S SDWLSC=0 F  S SDWLSC=$O(^SDWL(409.32,SDWLSC)) Q:'SDWLSC  D UPDINS(SDWLSC,.CNT,.INERROR)
 D MSGG(.SDX)
 Q:INERROR
 N DIK S DIK="SDWL(409.32," D IXALL^DIK
 N SDA
 S SDA(1)="",SDA(2)="Verification and update of files 409.32 and 409.3",SDA(3)=" with proper institution finished.",SDA(4)="",SDA(5)="   SD*5.3*491 Post-Install finished...."
 D ATADDQ
 Q
 ;
ATADD ; New Billable Appointment Type (352.1) to correspond to the New 'SERVICE CONNECTED' Appointment Type (409.1)
 N DD,DO,DLAYGO,DINUM,DIC,DIE,DA,DR,X,Y,SDA,IBFOUND,SDATFN,IBNUM,SDAT,IBFN
 S SDA(1)="      >> Verifying 'Service Connected' Billable Appointment Type (#352.1)"
 S (SDATFN,IBNUM)=11,SDAT="SERVICE CONNECTED"
 S IBFOUND=$G(^IBE(352.1,SDATFN,0)) ; new IA confirmed to be created
 I IBFOUND="11^11^2880101^0^1^1" D  D ATADDQ Q
 .D MSG("    Done.  Billable Appointment Type Service Connected is set up properly")
 D MSG(" "),MSG("* ERROR IN CONFIGURATION OF ENTRY IEN=11 IN FILE 352.1 *")
 D MSG("IT IS MANDATORY THAT YOU CREATE AN INTEGRATED BILLING REMEDY TICKET"),MSG("Entry 11 should be configured for the SERVICE CONNECTED appointment type.")
 D MSG(" --------------------------") D ATADDQ
 Q 
ATADDQ D MES^XPDUTL(.SDA) K SDA
 Q
CHKSC ;Match SC encounter value with proper Appointment Type.
 ; look for encounters only
 N SCE,CNT,CNTA S CNT=0,CNTA=0
 ;SCE - EIN of Outpatient Encounter
 K ^XTMP("SD53P491-"_$J),^XTMP("SD53P491AP-"_$J)
 S ^XTMP("SD53P491-"_$J,0)=$$FMADD^XLFDT(""_DT_"",7)_U_DT
 S ^XTMP("SD53P491AP-"_$J,0)=$$FMADD^XLFDT(""_DT_"",7)_U_DT
 S SCE=0
 F  S SCE=$O(^SCE(SCE)) Q:SCE'>0  I $P($G(^SCE(SCE,"USER")),U,4)>3060120  D
 .N STR,SDSCV,SDT,SDVST,DFN,SDAPDF,SDVSCL S STR=$G(^SCE(SCE,0))
 .S DFN=$P(STR,U,2),SDT=+STR,SDVSCL=$P(STR,U,4)
 .S SDVST=$P($G(STR),U,5)
 .Q:'SDVST  Q:'$D(^AUPNVSIT(SDVST,800))
 .S SDSCV=$$GET1^DIQ(9000010,SDVST_",",80001,"I") ;SC flag in Visit file
 .Q:SDSCV=""  ;do not proceed if SC not determined
 .S SDAPDF=$$GET1^DIQ(44,SDVSCL_",",2507,"I") ;default appt type
 .I SDAPDF'="" S SDAPDPT=SDAPDF ; set to default if exists for this clinic
 .E  S SDAPDPT=9 ; set to regular
 .N UPDAP I SDSCV S UPDAP=11
 .E  S UPDAP=SDAPDPT
 .N SDR D APPT(DFN,SDT,SCE,UPDAP,.SDR)
 .I $P(^SCE(SCE,0),U,10)=11 D  ; change only if original appt type was SC
 ..Q:SDSCV
 ..M ^XTMP("SD53P491-"_$J,DFN,SDT,SCE)=^SCE(SCE,0) S CNT=CNT+1
 ..S $P(^SCE(SCE,0),U,10)=SDAPDPT
 ..;I 'SDR D RETR(SCE)
 .E  D
 ..Q:'SDSCV
 ..; change only if original appt type was SC
 ..M ^XTMP("SD53P491-"_$J,DFN,SDT,SCE)=^SCE(SCE,0) S CNT=CNT+1
 ..S $P(^SCE(SCE,0),U,10)=11
 ..;I 'SDR D RETR(SCE)
 .D CRST(SDVST,SDSCV,SDAPDPT,.CNT)
 N SDA
 S SDA(1)="",SDA(2)="  "_CNT_" OUTPATIENT ENCOUNTER entry(ies) updated with an Appointment Type."
 S SDA(3)="  "_CNTA_" APPOINTMENT Multiple entry(ies) in the PATIENT file updated"
 S SDA(4)="       "_"with an Appointment Type."
 S SDA(5)=""
 D ATADDQ
 Q
APPT(DFN,SDT,SCE,UPDAP,SDR) ;update appointment multiple in Patient file
 N STR S STR=$G(^DPT(DFN,"S",SDT,0))
 S SDR=0
 I $P(STR,U,20)'=SCE Q
 I $P(STR,U,16)'=UPDAP D
 .M ^XTMP("SD53P491AP-"_$J,DFN,SDT,SCE)=STR
 .S $P(^DPT(DFN,"S",SDT,0),U,16)=UPDAP
 .S CNTA=CNTA+1,SDR=1
 .;I SDR D RETR(SCE)
 Q
RETR(SCE) ; mark encounter for retransmission
 N SDXM
 S SDXM=$$FINDXMIT^SCDXFU01(SCE)
 D STREEVNT^SCDXFU01(SDXM,2)
 D XMITFLAG^SCDXFU01(SDXM)
 Q
MSG(X) ;
 N SDX S SDX=$O(SDA(999999),-1) S:'SDX SDX=1 S SDX=SDX+1
 S SDA(SDX)=$G(X)
 Q
CRST(SDVST,SDSCV,SDAPDPT,CNT) ;check for credit stop encounter for each scanned encounter
 N SDVSTS,SDE S SDE="" S SDVSTS=$O(^AUPNVSIT("AD",SDVST,"")) ; only one child visit
 I SDVSTS>0 S SDE=$O(^SCE("AVSIT",SDVSTS,""))
 Q:'SDE
 I SDSCV D
 .I $P(^SCE(SDE,0),U,10)'=11 D
 ..M ^XTMP("SD53P491-"_$J,DFN,SDT,SDE,1)=^SCE(SDE,0) S CNT=CNT+1
 ..S $P(^SCE(SDE,0),U,10)=11
 ..;D RETR(SDE)
 I 'SDSCV D
 .I $P(^SCE(SDE,0),U,10)=11 D
 ..M ^XTMP("SD53P491-"_$J,DFN,SDT,SDE,1)=^SCE(SDE,0) S CNT=CNT+1
 ..S $P(^SCE(SDE,0),U,10)=SDAPDPT
 ..;D RETR(SDE)
 Q
UPDINS(SDWLSC,CNT,INERROR) ; update 409.32 and the related entries in 409.3
 N SDWLINS S SDWLINS=$$GET1^DIQ(409.32,SDWLSC_",",.02,"I") ; current set up IN 409.32
 ;check set up in file 44
 ;get clinic
 N CL,CLN S CL=$$GET1^DIQ(409.32,SDWLSC_",",.01,"I"),CLN=$$GET1^DIQ(44,CL_",",.01)
 N STR,SDWMES S SDWMES="",STR=$$CLIN^SDWLPE(CL)
 S SDWMES=SDWMES_$P(STR,U,6)
 I $P(STR,U,5)="L" S CNT=CNT+1 S (SDWMES,SDX(CNT))=SDWMES_" - Local Institution assigned to clinic. "
 I SDWMES'="" D  Q
 .S CNT=CNT+1,SDX(CNT)=" ** Invalid configuration of Clinic "_CLN_" ("_CL_")"_": **"
 .W !!,SDX(CNT)
 .S CNT=CNT+1,SDX(CNT)=SDWMES
 .W !,SDX(CNT)
 .S CNT=CNT+1,SDX(CNT)="YOU MUST UPDATE THIS FILE 44 ENTRY'S DIVISION OR ITS MEDICAL CENTER DIVISION'S"
 .W !,SDX(CNT)
 .S CNT=CNT+1,SDX(CNT)="INSTITUTION FILE POINTER."
 .W !,SDX(CNT)
 .S CNT=CNT+1,SDX(CNT)=""
 .S:INERROR="" INERROR=1 Q
 I +STR'=SDWLINS D
 .S CNT=CNT+1,SDX(CNT)="The Medical Center Division for file 44 Clinic "_CLN_" ("_CL_")"
 .W !!,SDX(CNT)
 .S CNT=CNT+1,SDX(CNT)="has a different Institution  than the file 409.32 entry for EWL."
 .W !,SDX(CNT)
 .N SDI,SDI1 S SDI=$$GET1^DIQ(4,SDWLINS_",",.01),SDI1=$$GET1^DIQ(4,SDWLINS_",",99)
 .S CNT=CNT+1,SDX(CNT)="EWL Clinic INSTITUTION: "_SDI_" - "_SDI1
 .W !,SDX(CNT)
 .S CNT=CNT+1,SDX(CNT)="Clinic INSTITUTION: "_$P(STR,U,3)_" - "_$P(STR,U,2)
 .W !,SDX(CNT)
 .N DIE,DR,DA S DR=".02////^S X=+STR",DIE="^SDWL(409.32,",DA=SDWLSC
 .L +^SDWL(409.32,DA):0 I '$T S CNT=CNT+1,SDX(CNT)="Entry locked; Run SD WAIT LIST CLEANUP later" W !?5,SDX(CNT) Q
 .D ^DIE L -^SDWL(409.32,DA)
 .S CNT=CNT+1,SDX(CNT)="Updated EWL Clinic to match."
 .W !,SDX(CNT),!
 .S CNT=CNT+1,SDX(CNT)=""
 .;loop to update EWL entries in FILE 409.3 if any
 .N SCL,DA,DR,CNT1 S SCL="",CNT1=0 F  S SCL=$O(^SDWL(409.3,"SC",CL,SCL)) Q:SCL'>0  D
 ..I '$D(^SDWL(409.3,SCL,0)) K ^SDWL(409.3,"SC",CL,SCL) Q
 ..S DR="2////^S X=+STR",DIE="^SDWL(409.3,",DA=SCL
 ..L +^SDWL(409.3,SCL):0 I '$T S CNT=CNT+1,SDX(CNT)="Entry locked; Run SD WAIT LIST CLEANUP later" W !?5,SDX(CNT),! Q
 ..D ^DIE L -^SDWL(409.3,SCL) S CNT1=CNT1+1
 .I CNT1>0 W !,CNT1_" wait list entry(ies) for "_CLN_" clinic updated in SD WAIT LIST file #409.3." S CNT=CNT+1,SDX(CNT)=""
 N DA I $$GET1^DIQ(409.32,SDWLSC_",",3,"I")="" I $$GET1^DIQ(409.32,SDWLSC_",",1,"I")'>0 D
 .S DA=SDWLSC L +^SDWL(409.32,SDWLSC):0 I '$T S CNT=CNT+1,SDX(CNT)="Entry locked; Run SD WAIT LIST CLEANUP later" W !?5,SDX(CNT) Q
 .S DR="1////^S X=DT;2////^S X=DUZ",DIE="^SDWL(409.32," ;enter activation date and user
 .D ^DIE L -^SDWL(409.32,SDWLSC)
 .S CNT=CNT+1,SDX(CNT)="EWL Clinic entry for "_CLN_" updated with today's activation date."
 .W !,SDX(CNT)
 .S CNT=CNT+1,SDX(CNT)=""
 Q
MSGG(SDX) ;send message
 N SDAMX,XMSUB,XMY,XMTEXT,XMDUZ,DIFROM
 S XMSUB="PATCH SD*5.3*491 POST-INSTALL: UPDATE FILES 409.3 and 409.32"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMY(DUZ)=""
 S XMTEXT="SDX("
 S CNT=$O(SDX(""),-1)
 S CNT=CNT+1,SDX(CNT)=""
 S CNT=CNT+1,SDX(CNT)="SD WL CLINIC LOCATION file update is finished."
 W !!,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="Open EWL entries in the SD WAIT LIST file have also been updated."
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="If invalid/local Institution pointers were indicated above for"
 W !!,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="Hospital Location file #44, correct the DIVISION on those clinics"
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="and/or the INSTITUTION FILE POINTER of the Medical Center Division"
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="that the clinic points to, then run option SD WAIT LIST CLEANUP"
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="which will update institutions in EWL files 409.32 and 409.3."
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)=""
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="NOTE: SD WAIT LIST CLEANUP must be run any time corrections are made to"
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="a Hospital Location file #44 entry's DIVISION or to an INSTITUTION FILE POINTER"
 W !,SDX(CNT)
 S CNT=CNT+1,SDX(CNT)="in the Medical Center division file #40.8."
 W !,SDX(CNT)
 D ^XMD
