GMV18PST ;HOIFO/KAM-POST INSTALLATION FOR GMRV*5*18 ;5/16/06 1:35pm
 ;;5.0;GEN. MED. REC. - VITALS;**18**;Oct 31, 2002;Build 7
 ;
 ;
POST ; New private variables
 N GMV,GMVGUI,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating system parameters.")
 ; Set current client version
 S GMVGUI="5.0.18.1"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 .D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV GUI VERSION","VITALS.EXE:"_GMVGUI,1)
 D EN^XPAR("SYS","GMV GUI VERSION","VITALSMANAGER.EXE:"_GMVGUI,1)
 Q
