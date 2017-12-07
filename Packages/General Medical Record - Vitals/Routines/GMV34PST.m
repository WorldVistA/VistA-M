GMV34PST ;SLCIO/JLC - FIX PARAMETER SETTINGS ; 04/13/15 03:30pm
 ;;5.0;GEN. MED. REC. - VITALS;**34**;Oct 31, 2002;Build 30
 Q
 ; This routine uses the following IAs:
 ; 2263 - ^XPAR                  (supported)
 ; 
EN ; main entry point 
 D DLL
 Q
DLL ;
 ; Variables:
 ;  GMV:    [Private] Scratch
 ;  GMVDLL: [Private] Current version of DLL being installed
 ;  GMVLST: [Private] Scratch List
 ;
 ; New private variables
 N GMV,GMVDLL,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating DLL parameter.")
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV DLL VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 . D EN^XPAR("SYS","GMV DLL VERSION",$P(GMVLST(GMV),"^",1),0)
 ; Add and/or activate current client versions
 S GMVDLL="5.0.34.5" ;patch 34
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 Q
