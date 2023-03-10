GMV43PST ;SLCIO/JLC - FIX PARAMETER SETTINGS ;10/29/20  16:26
 ;;5.0;GEN. MED. REC. - VITALS;**43**;Oct 31, 2002;Build 35
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
 N GMV,GMVDLL,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating system parameters.")
 ; Set current client version
 S GMVDLL="5.0.43.2"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV DLL VERSION")
 S GMV=0
 F  S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 . D EN^XPAR("SYS","GMV DLL VERSION",$P(GMVLST(GMV),"^",1),0)
 . Q
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 Q
