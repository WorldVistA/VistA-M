GMV1PST ;HOIFO/FT-POST INSTALLATION FOR GMRV*5*1 ;10/8/03  14:01
 ;;5.0;GEN. MED. REC. - VITALS;**1**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10141 - ^XPDUTL calls (supported)
 ; #2263  - ^XPAR calls   (supported)
 ;
 ; This post-installation:
 ; Updates the parameters for the required client version
 ;
XPAR ; Setup preliminary parameters
 ; This submodule is called during the KIDS installation
 ; process.
 ;
 ; Variables:
 ;  GMV:    [Private] Scratch
 ;  GMVGUI: [Private] Current version of GUI being installed
 ;  GMVLST: [Private] Scratch List
 ;
 ; New private variables
 N GMV,GMVGUI,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating system parameters.")
 ; Set current client version
 S GMVGUI="5.0.1.0"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 .D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV GUI VERSION","VITALS.EXE:"_GMVGUI,1)
 D EN^XPAR("SYS","GMV GUI VERSION","VITALSMANAGER.EXE:"_GMVGUI,1)
 Q
