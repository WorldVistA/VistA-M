MDPOST23 ;HINES OIFO/DP/BJ - Post Installation Tasks;06 OCTOBER 2011
 ;;1.0;CLINICAL PROCEDURES;**23**;Apr 01, 2004;Build 281
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;  #2263        - CHG^XPAR                     Kernel                         (supported)
 ;
EN ; Post installation tasks to bring Legacy CP up to snuff
 ;
 N MDBUILD
 S MDBUILD=$P($P($T(+2),";",7)," ",2)
 ;
 ; Installing commands in the command file...
 D MES^XPDUTL(" Installing command file...")
 D NDEL^XPAR("SYS","MD COMMANDS")
 S MDCMD="" F  S MDCMD=$O(@XPDGREF@("MD COMMANDS",MDCMD)) Q:MDCMD=""  D
 .D MES^XPDUTL(" Installing command '"_MDCMD_"'...")
 .K MDTXT M MDTXT=@XPDGREF@("MD COMMANDS",MDCMD)
 .D EN^XPAR("SYS","MD COMMANDS",MDCMD,.MDTXT)
 ; Import the new data
 D IMPORT^MDTERM
 D POSTCHK^MDTERM ; Checks for inactive term issues
 D EN^XPAR("SYS","MD PARAMETERS","TERMINOLOGY_VERSION",MDBUILD)
 D EN^XPAR("SYS","MD PARAMETERS","TERMINOLOGY_DESCRIPTION","Installed with KIDS Build MD*1.0*23")
 ;
 ; Update MD PARAMETERS with new build numbers for executables.  Note: this is only
 ;  going to be for CP Flowsheets and CP Console.  We're not updating the CP Gateway
 ;  service as part of P23 at this time.
 ;
 F MDX="CPFLOWSHEETS","CPCONSOLE" D EN^XPAR("SYS","MD PARAMETERS","VERSION_"_MDX,"1.0.23."_MDBUILD)
 ;
 D MES^XPDUTL(" MD*1.0*23 Post Init complete")
 ;
 Q
 ;
