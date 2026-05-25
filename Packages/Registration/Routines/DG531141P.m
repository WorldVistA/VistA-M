DG531141P ;ALB/SJD - DG*5.3*1141 POST-INSTALL ;Jan 06, 2025@14:36
 ;;5.3;Registration;**1141**;Jan 06, 2025;Build 1
 ;
 ; This routine will upload a correction to the 2025 (2024 income Year) 
 ; Maximum Annual Pension Rate (MAPR) zero dependent entry 
 ; into the PARAMETERS file (#8989.5).
 ;
 ;ICRs
 ; Reference to BMES^XPDUTL,MES^XPDUTL in ICR #10141
 ; Reference to EN^XPAR in ICR #2263
 ;
 Q
 ;
EN ; Entry point for post-install
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1141 Post-install routine...")
 D MAPR
 D BMES^XPDUTL(">>> Patch DG*5.3*1141 Post-install complete.")
 Q  ;;EN
 ;
MAPR ; Update Maximum Annual Pension Rate
 ;
 D BMES^XPDUTL(">>> Updating Maximum Annual Pension Rate Parameter in PARAMETERS (#8989.5)")
 D MES^XPDUTL("    file for calendar year 2025 (income year 2024).")
 ;
 ;Set the correct MAPR 0 dependent max value of $16,965
 D SETPARM("DGMT MAPR 0 DEPENDENTS",2024,"16965")
 Q  ;;MAPR
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
 ; Call to EN^XPAR to set the correct (#8989.5) parameter
 D EN^XPAR("PKG",DGPARM,DGINST,DGVALU,.DGERR)
 I $G(DGERR) D  Q
 .D BMES^XPDUTL("   "_DGPARM_" parameter, instance "_DGINST_", FAILED! ("_DGVALU_")")
 .D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 .D MES^XPDUTL("     for assistance.")
 ;
 I '$G(DGERR) D
 .D BMES^XPDUTL("   "_DGPARM_" parameter, instance "_DGINST_", set to $"_$FN(DGVALU,",")_".")
 Q  ;;SETPARM
