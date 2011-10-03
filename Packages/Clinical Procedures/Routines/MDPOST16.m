MDPOST16 ;HINES OIFO/DP - Post Installation Tasks;02 Mar 2008
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  # 2263       - XPAR calls                   TOOLKIT                        (supported)
 ;  # 4447       - POSTKID^VDEFVU               VDEF             (controlled subscription)
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;
EN ; Post installation tasks to bring Legacy CP up to snuff
 ;
 N MDTMP,MDTASK,MDX,MDCMD,MDTXT,MDVER,MDBUILD
 S MDBUILD=$P($P($T(+2),";",7)," ",2)
 ;
 ; Import the new data
 ; 
 D IMPORT
 ;
 ; Remove obsolete parameters of where updates are located
 ; 
 D MES^XPDUTL(" Removing obsolete parameters ...")
 D EN^XPAR("SYS","MD PARAMETERS","UPDATE_MASTER","@")
 D EN^XPAR("SYS","MD PARAMETERS","UPDATE_FRAMEWORK","@")
 D EN^XPAR("SYS","MD PARAMETERS","UPDATE_SOURCE","@")
 ;
 ; Remove old, unused routines. BLJ 17 March 2010
 N X F X="MDCORE","MDCPST" X ^%ZOSF("DEL")
 K X
 ;
 ; Update the queued jobs list
 ;
 ; load all pars into MDTASK() and then remove the XPAR copy of each TASK_*
 ;
 D MES^XPDUTL(" Updating queued job settings ...")
 D GETLST^XPAR(.MDTMP,"SYS","MD PARAMETERS","Q")
 F MDX=0:0 S MDX=$O(MDTMP(MDX)) Q:'MDX  D:MDTMP(MDX)?1"TASK_".E
 .S MDTASK($P(MDTMP(MDX),"^",1))=$P(MDTMP(MDX),"^",2)
 .D EN^XPAR("SYS","MD PARAMETERS",$P(MDTMP(MDX),"^",1),"@")
 ;
 ; Now rebuild the ones that we want to keep
 ;
 F X="TASK_CLIO_CLEANUP","TASK_CP_CLEANUP","TASK_HL7_CLEANUP" D
 .S MDTASK(X)=$G(MDTASK(X),"0;;;0")
 ;
 S $P(MDTASK("TASK_CLIO_CLEANUP"),";",2)="CliO Cleanup"
 S $P(MDTASK("TASK_CLIO_CLEANUP"),";",3)="CLIO MDCPURG"
 ;
 S $P(MDTASK("TASK_CP_CLEANUP"),";",2)="CP Cleanup"
 S $P(MDTASK("TASK_CP_CLEANUP"),";",3)="CP MDCPURG"
 ;
 S $P(MDTASK("TASK_HL7_CLEANUP"),";",2)="HL7 Cleanup"
 S $P(MDTASK("TASK_HL7_CLEANUP"),";",3)="HL7 MDCPURG"
 ;
 ; Save them back to XPAR
 ;
 F MDX="TASK_CLIO_CLEANUP","TASK_CP_CLEANUP","TASK_HL7_CLEANUP" D
 .D EN^XPAR("SYS","MD PARAMETERS",MDX,MDTASK(MDX))
 .D MES^XPDUTL(" Task '"_MDX_"' updated...")
 ;
 ; Set the required build numbers for the applications (1.0.16.BUILD)
 ;
 F MDX="CPFLOWSHEETS","CPCONSOLE","CPGATEWAYSERVICE" D
 .D EN^XPAR("SYS","MD PARAMETERS","VERSION_"_MDX,"1.0.16."_MDBUILD)
 ;
 ; Update the CP DEFINITION File with GUIDS and Active Status
 D MES^XPDUTL(" Updating CP Definition File...")
 N MDX,MDY,MDFDA,MDIEN,MDFILE
 F MDX=0:0 S MDX=$O(^MDS(702.01,MDX)) Q:'MDX  D
 .I $P($G(^MDS(702.01,MDX,"ID")),U)'?1"{"8UN1"-"4UN1"-"4UN1"-"4UN1"-"12UN1"}" D
 ..F  D GETGUID^MDCLIO1(.MDY) Q:'$D(^MDS(702.01,"PK",MDY))
 ..S MDFDA(702.01,MDX_",",.13)=MDY
 .S MDFDA(702.01,MDX_",",.09)=1
 .D FILE^DIE("","MDFDA")
 ;
 ; Clear cache settings to force new build 
 D EN^XPAR("SYS","MD PARAMETERS","TERMINOLOGY_CACHE_SETTINGS","@")
 D MES^XPDUTL(" Terminology Caching disabled, use CP Console to rebuild.")
 ;
 ; Update the CP INSTRUMENT File with GUIDS and Active Status
 D MES^XPDUTL(" Updating CP Instrument File...")
 F MDX=0:0 S MDX=$O(^MDS(702.09,MDX)) Q:'MDX  D
 .I $P($G(^MDS(702.09,MDX,"ID")),U)'?1"{"8UN1"-"4UN1"-"4UN1"-"4UN1"-"12UN1"}" D
 ..F  D GETGUID^MDCLIO1(.MDY) Q:'$D(^MDS(702.09,"PK",MDY))
 ..S MDFDA(702.09,MDX_",",.1)=MDY
 .S MDFDA(702.09,MDX_",",.09)=1
 .D FILE^DIE("","MDFDA")
 ;
 ; Add any needed VDEF entries
 ;
 ; IA 4447.
 ;
 ; Event subtypes:
 ;   CPAN - CLIO Admit/Visit Notification (A01)
 ;   CPCAN - CLIO Cancel Admit Notice (A11)
 ;   CPCDE - CLIO Cancel Discharge (A13)
 ;   CPCT - CLIO Cancel Transfer (A12)
 ;   CPDE - CLIO Discharge/End Visit (A03)
 ;   CPTP - CLIO Transfer a Patient (A02)
 ;   CPUPI - CLIO Update Patient Info (A08)
 ;
 ; Message/Event types - Protocols - Extraction Program
 ;   ADT/A01 - MDC CPAN VS   - MDCA01
 ;   ADT/A02 - MDC CPTP VS   - MDCA02
 ;   ADT/A03 - MDC CPDE VS   - MDCA03
 ;   ADT/A08 - MDC CPUPI VS  - MDCA08
 ;   ADT/A11 - MDC CPCAN VS  - MDCA11
 ;   ADT/A12 - MDC CPCT VS   - MDCA12
 ;   ADT/A13 - MDC CPCDE VS  - MDCA13
 ;
 D POSTKID^VDEFVU("ADT","A01","CPAN","MDC CPAN VS","CLINICAL PROCEDURES","MDCA01","CLIO Admit/Visit Notification (A01)","CLIO Admit/Visit Notification (A01)")
 D POSTKID^VDEFVU("ADT","A02","CPTP","MDC CPTP VS","CLINICAL PROCEDURES","MDCA02","CLIO Transfer a Patient (A02)","CLIO Transfer a Patient (A02)")
 D POSTKID^VDEFVU("ADT","A03","CPDE","MDC CPDE VS","CLINICAL PROCEDURES","MDCA03","CLIO Discharge/End Visit (A03)","CLIO Discharge/End Visit (A03)")
 D POSTKID^VDEFVU("ADT","A08","CPUPI","MDC CPUPI VS","CLINICAL PROCEDURES","MDCA08","CLIO Update Patient Info (A08)","CLIO Update Patient Info (A08)")
 D POSTKID^VDEFVU("ADT","A11","CPCAN","MDC CPCAN VS","CLINICAL PROCEDURES","MDCA11","CLIO Cancel Admit Notice (A11)","CLIO Cancel Admit Notice (A11)")
 D POSTKID^VDEFVU("ADT","A12","CPCT","MDC CPCT VS","CLINICAL PROCEDURES","MDCA12","CLIO Cancel Transfer (A12)","CLIO Cancel Transfer (A12)")
 D POSTKID^VDEFVU("ADT","A13","CPCDE","MDC CPCDE VS","CLINICAL PROCEDURES","MDCA13","CLIO Cancel Discharge (A13)","CLIO Cancel Discharge (A13)")
 ;
 D MES^XPDUTL(" New VDEF events filed, remember to activate those needed for this installation")
 ;
 D POSTCHK^MDTERM ; Checks for inactive term issues
 ;
 ; Delete previous CPManager compatability entries in XPAR.
 N MDAPVSNS,MDAPPVSN S MDAPPVSN=0
 D GETLST^XPAR(.MDAPVSNS,"SYS","MD VERSION CHK","Q")
 F  S MDAPPVSN=$O(MDAPVSNS(MDAPPVSN)) Q:'MDAPPVSN  D
 .I $P(MDAPVSNS(MDAPPVSN),U)["CPMANAGER.EXE" D EN^XPAR("SYS","MD VERSION CHK",$P(MDAPVSNS(MDAPPVSN),U,1),"@")
 ;
 D MES^XPDUTL(" MD*1.0*16 Post Init complete")
 Q
 ;
IMPORT ; Post installation of items with pointers beyond .01 field.
 ;
 ; Install a new command set from KIDS global
 ;
 D MES^XPDUTL(" Installing command file...")
 D NDEL^XPAR("SYS","MD COMMANDS")
 S MDCMD="" F  S MDCMD=$O(@XPDGREF@("MD COMMANDS",MDCMD)) Q:MDCMD=""  D
 .D MES^XPDUTL(" Installing command '"_MDCMD_"'...")
 .K MDTXT M MDTXT=@XPDGREF@("MD COMMANDS",MDCMD)
 .D EN^XPAR("SYS","MD COMMANDS",MDCMD,.MDTXT)
 ;
 ; Import the CDM data from the transport global
 ; 
 D MES^XPDUTL(" Importing a new Dictionary and Clinical Data Model.")
 N MD,DA,DIK,MDCMD,MDD,MDA,MDIEN,MDFDA,MDIENS,MDFLD
 ;
 ; First we purge the existing CDM just in case the pre-init didn't get it blown away
 F MD=704.103,704.104,704.105,704.106,704.107,704.108,704.109 D:$$VFILE^DILFD(MD)
 .S DIK=$$ROOT^DILFD(MD) F DA=0:0 S DA=$O(@(DIK_"DA)")) Q:'DA  D ^DIK
 ;
 ; Next we deactivate all the terms already here so only the new ones coming in are active
 I $O(^MDC(704.101,0)) D MES^XPDUTL(" Deactivating existing terms.")
 F MDIEN=0:0 S MDIEN=$O(^MDC(704.101,MDIEN)) Q:'MDIEN  D
 .S MDFDA(704.101,MDIEN_",",.09)=0 D FILE^DIE("","MDFDA")
 ;
 ; Now install the new one
 D MES^XPDUTL(" Installing new terminology.")
 K ^TMP($J,"MDFDA") S MDIEN=0
 F X=0:0 S X=$O(@XPDGREF@("CDM",X)) Q:'X  D
 .S Y=@XPDGREF@("CDM",X)
 .S MDD=+$P(Y,";",1)
 .S MDIENS=+$P(Y,";",2)
 .S MDFLD=+$P(Y,";",3)
 .S ^TMP($J,"MDFDA",MDD,MDIENS,MDFLD)=$P(Y,U,2,250)
 F MDD=0:0 S MDD=$O(^TMP($J,"MDFDA",MDD)) Q:'MDD  D
 .F MDA=0:0 S MDA=$O(^TMP($J,"MDFDA",MDD,MDA)) Q:'MDA  D
 ..K MDFDA
 ..S MDIENS="+1"
 ..S:MDD=704.101 MDIENS=$$GETIENS(^TMP($J,"MDFDA",MDD,MDA,.01))
 ..M MDFDA(MDD,MDIENS_",")=^TMP($J,"MDFDA",MDD,MDA)
 ..D UPDATE^DIE("EK","MDFDA",,"MDMSG")
 ..I $D(MDMSG) D MES^XPDUTL(MDMSG("DIERR",1,"TEXT",1))
 ..K MDMSG,MDFDA
 ;
 ; Update the check sums
 F MDD=704.101,704.102,704.103,704.104,704.105,704.106,704.107,704.108,704.109 D
 .D MES^XPDUTL(" Storing check sum for file "_$$GET1^DID(MDD,"","","NAME")_"...")
 .D VRRV(MDD,"MD*1.0*16",MDBUILD)
 ;
 D EN^XPAR("SYS","MD PARAMETERS","TERMINOLOGY_VERSION",MDBUILD)
 D EN^XPAR("SYS","MD PARAMETERS","TERMINOLOGY_DESCRIPTION","Installed with KIDS Build MD*1.0*16")
 ;
 D MES^XPDUTL(" New Clinical Data Model for Terminology has been installed.")
 Q
 ;
GETIENS(MDID) ; Finds the correct IEN in the SITES TERM file
 I $D(^MDC(704.101,"PK",MDID)) Q +$O(^MDC(704.101,"PK",MDID,0))
 ; No match in "PK" index, add it!
 I 'MDIENS S MDIENS="+1" D MES^XPDUTL("    Term '"_^TMP($J,"MDFDA",MDD,MDA,.01)_"' ("_^(.02)_") will be added...")
 Q MDIENS
 ;
VRRV(MDFILE,MDFRAME,MDVER) ; Tag the package revision data for a file
 D PRD^DILFD(MDFILE,MDFRAME_";b"_MDBUILD_";"_$$CHKSUM^MDTERM(MDFILE))
 Q
 ;
