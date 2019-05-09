GMV38PST ;HIOFO/FT - FIX PARAMETER SETTINGS ; 10/30/18 2:46pm
 ;;5.0;GEN. MED. REC. - VITALS;**38**;Oct 31, 2002;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; This routine uses the following IAs:
 ; #10141 - MES^XPDUTL Kernel      (supported)
 ; #2263  - ^XPAR                  (supported)
 ; 
EN ; main entry point 
 D XPAR
 Q
XPAR ; Update the GUI version parameters. This subroutine is called during the
 ; KIDS installation process.
 ;
 ; Variables:
 ;  GMV:    [Private] Scratch
 ;  GMVGUI: [Private] Current version of GUI being installed
 ;  GMVLST: [Private] Scratch List
 ;
 ; NEW private variables
 N GMV,GMVGUI,GMVMGUI,GMVDLL,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating system parameters.")
 ; Set current client version
 S GMVGUI="5.0.38.3"
 S GMVMGUI="5.0.38.3"
 S GMVDLL="5.0.38.3"
 ; Deactivate all previous versions of the Standalone and Manager from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 . D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
 . Q
 ; Deactivate all previous versions of the DLL from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV DLL VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 . D EN^XPAR("SYS","GMV DLL VERSION",$P(GMVLST(GMV),"^",1),0)
 .Q
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV GUI VERSION","VITALS.EXE:"_GMVGUI,1)
 D EN^XPAR("SYS","GMV GUI VERSION","VITALSMANAGER.EXE:"_GMVMGUI,1)
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
