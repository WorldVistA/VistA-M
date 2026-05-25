ORAMP617 ;SLC/MWA - Post Installation Tasks ; Aug 22, 2025@12:47:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**617**;Dec 17, 1997;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ; #10141 - MES^XPDUTL Kernel (supported)
 ; #2263 - EN^XPAR Kernel (supported)
 ;
 Q
EN ;
 ; Installing commands in the command file...
 D MES^XPDUTL("OR*3.0*617 Post install starting....")
 ;
 D MES^XPDUTL("Updating parameters...")
 ; Update ORAM GUI VERSION with new build number for AntiCoagulate.exe.
 D EN^XPAR("SYS","ORAM GUI VERSION",,"1.0.617.4")
 D MES^XPDUTL("Parameters updated.")
 ;
 D MES^XPDUTL("OR*3.0*617 Post install complete")
 ;
 Q
