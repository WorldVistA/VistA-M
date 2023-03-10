DG531087P ;ALB/KUM - DG*5.3*1087 POST-INSTALL ;Nov 15, 2022@14:36
 ;;5.3;Registration;**1087**;Aug 13, 1993;Build 2
 ;
 ; This routine will upload the 2023 Means Test Thresholds and
 ; Maximum Annual Pension Rates into the MAS PARAMETERS file (#43)
 ; and the PARAMETERS file (#8989.5).
 ;
 ;ICRs
 ; Reference to BMES^XPDUTL,MES^XPDUTL in ICR #10141
 ; Reference to ^DIK,IX1^DIK in ICR #10013
 ; Reference to FILE^DICN in ICR #10009
 ; Reference to FILE^DIE in ICR #2053
 ; Reference to EN^XPAR in ICR #2263
 ;
 Q
 ;
EN ; Entry point for post-install
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1087 post-install routine...")
 D MT
 D MAPR
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL(">>> Patch DG*5.3*1087 Post-install complete.")
 Q
 ;
MT ; Update Means Test Thresholds
 N DA,DIK,DIC,DINUM,DGI,X,Y,DGX,DGREC,DGIENS,DGMESS,DGFDA,DGERR
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("    Means Test Thresholds for 2023 calendar year (2022 income year) being ")
 D MES^XPDUTL("    installed in MAS PARAMETERS (#43) file.")
 I $D(^DG(43,1,"MT",3230000)) D
 .D BMES^XPDUTL(">>> Entry exists for calendar year 2023, entry being deleted")
 .D MES^XPDUTL("    and replaced with nationally released thresholds.")
 .S DIK="^DG(43,1,""MT"",",DA=3230000,DA(1)=1
 .D ^DIK,IX1^DIK
 .K DA,DIK
 K DO
 S DIC="^DG(43,1,""MT"","
 S DIC(0)="L"
 S DA(1)=1
 S (DINUM,X)=3230000
 D FILE^DICN
 ;
 I +Y'=3230000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 2023 thresholds.  ")
 . D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("     for assistance.")
 ;
 D MES^XPDUTL("")
 S DGREC=1
 S DGIENS=+Y_","_DGREC_","
 F DGI=1:1 S DGX=$P($T(DATA+DGI),";;",2) Q:DGX="QUIT"  D
 . S DGFDA(43.03,DGIENS,+DGX)=$P(DGX,"^",2)
 . S DGMESS(DGI)="   "_$P(DGX,"^",3)_" set to $"_$FN($P(DGX,"^",2),",")_"."
 D FILE^DIE(,"DGFDA","DGERR")
 I $D(DGERR) D
 . D BMES^XPDUTL("   ...Problem encountered adding 2023 thresholds.  ")
 . D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("     for assistance.")
 I '$D(DGERR) D BMES^XPDUTL(.DGMESS)
 Q
 ;
MAPR ; Update Maximum Annual Pension Rates
 ;
 D BMES^XPDUTL(">>> Setting Maximum Annual Pension Rate Parameters in PARAMETER (#8989.5) file.")
 ;
 ;set MAPR rate parameter to 5(%)
 D SETPARM("DGMT MAPR GLOBAL RATE",2022,"5")
 ;
 ;set MAPR max values
 D SETPARM("DGMT MAPR 0 DEPENDENTS",2022,"16037")
 D SETPARM("DGMT MAPR 1 DEPENDENTS",2022,"21001")
 D SETPARM("DGMT MAPR N DEPENDENTS",2022,"2743")
 Q
 ;
SETPARM(DGPARM,DGINST,DGVALU) ;set PACKAGE entity parameters
 ;
 ;  Input:
 ;    DGPARM - PARAMETER DEFINITION name
 ;    DGINST - parameter instance
 ;    DGVALU - parameter value
 ;
 ;  Output:
 ;    None
 ;
 N DGERR
 ;
 D EN^XPAR("PKG",DGPARM,DGINST,DGVALU,.DGERR)
 I $G(DGERR) D  Q
 .D MES^XPDUTL("   "_DGPARM_" parameter, instance "_DGINST_", FAILED! ("_DGVALU_")")
 .D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 .D MES^XPDUTL("     for assistance.")
 ;
 I '$G(DGERR) D
 .I DGPARM="DGMT MAPR GLOBAL RATE" D
 ..D MES^XPDUTL("   "_DGPARM_" parameter, instance "_DGINST_", set to "_DGVALU_"%.")
 .I DGPARM'="DGMT MAPR GLOBAL RATE" D
 ..D MES^XPDUTL("   "_DGPARM_" parameter, instance "_DGINST_", set to $"_$FN(DGVALU,",")_".")
 Q
 ;
DATA ; lines to update the MEANS TEST DATA (#43.03) multiple in MAS PARAMETERS (#43) file
 ;;2^39849^MT COPAY EXEMPT VET INCOME
 ;;3^7969^MT COPAY EXEMPT 1ST DEP INCOME
 ;;4^2743^MT COPAY EXEMPT INCOME PER DEP
 ;;8^80000^THRESHOLD PROPERTY
 ;;17^13850^CHILD INCOME EXCLUSION
 ;;QUIT
 Q
 ;
