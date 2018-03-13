GMV36PST ;HIOFO/FT - FIX PARAMETER SETTINGS ;8/29/17 1:00pm
 ;;5.0;GEN. MED. REC. - VITALS;**36**;Oct 31, 2002;Build 3
 Q
 ; This routine uses the following IAs:
 ; 2263 - ^XPAR                  (supported)
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
 N GMV,GMVGUI,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating system parameters.")
 ; Set current client version
 S GMVGUI="5.0.36.2"
 S GMVMGUI="5.0.36.1"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 . D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
 .Q
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV GUI VERSION","VITALS.EXE:"_GMVGUI,1)
 D EN^XPAR("SYS","GMV GUI VERSION","VITALSMANAGER.EXE:"_GMVMGUI,1)
 Q
