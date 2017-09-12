GMV23PST ;HOIFO/FT-POST INSTALLATION FOR GMRV*5*23 ; 03/24/09 16:01
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; #2263  - XPAR calls                           (supported)
 ; #4835  - Add RPCS to OR CPRS GUI CHART option (private)
 ; #10141 - XPDUTL calls                         (supported)
 ;
EN ; Main entry point
 D XPAR,DLL,ADDRPC
 Q
XPAR ; Setup preliminary parameters. This subroutine is called during the
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
 S GMVGUI="5.0.23.8"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 .D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
 .Q
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV GUI VERSION","VITALS.EXE:"_GMVGUI,1)
 D EN^XPAR("SYS","GMV GUI VERSION","VITALSMANAGER.EXE:"_GMVGUI,1)
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
 .D EN^XPAR("SYS","GMV DLL VERSION",$P(GMVLST(GMV),"^",1),0)
 ; Add and/or activate current client versions
 S GMVDLL="GMV_VITALSVIEWENTER.DLL:v. 04/07/09 16:30" ;patch 23
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 S GMVDLL="GMV_VITALSVIEWENTER.DLL:v. 08/11/09 15:00" ;patch 23
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 Q
ADDRPC ; Add GMV RPC(s) to CPRS option
 N GMVDA,GMVDA1,GMVERR,GMVFDA,GMVIEN,GMVMSG,GMVNAME,GMVNODE,GMVTEST,GMVX
 K ^TMP($J),^TMP("GMV 23PST",$J)
 S GMVDA=$$FIND1^DIC(19,"","O","OR CPRS GUI CHART","B","","GMVERR")
 I 'GMVDA D  Q
 .S GMVMSG(1)="Cannot find the 'OR CPRS GUI CHART' option."
 .S GMVMSG(2)="Cannot add the RPC(s) needed. Please log a Remedy Ticket."
 .D EN^DDIOL(.GMVMSG,"","!?5")
 .Q
 ; Get list of existing RPC(s) for OR CPRS GUI CHART option
 D GETS^DIQ(19,GMVDA,"320*","I","^TMP($J)","GMVERR")
 S GMVX=""
 F  S GMVX=$O(^TMP($J,19.05,GMVX)) Q:GMVX=""  D
 .S GMVIEN=+$G(^TMP($J,19.05,GMVX,.01,"I"))
 .Q:'GMVIEN
 .S ^TMP("GMV 23PST",$J,GMVIEN)=""
 .Q
 K GMVERR,GMVX
 ; get GMV rpc(s) from table
 F GMVX=1:1 S GMVNODE=$T(RPCLIST+GMVX) Q:$P(GMVNODE,";",3)=""  D
 .S GMVNAME=$P(GMVNODE,";",3)
 .Q:GMVNAME=""
 .K GMVERR
 .S GMVDA1=$$FIND1^DIC(8994,"","O",GMVNAME,"B","","GMVERR")
 .Q:'GMVDA1
 .Q:$D(^TMP("GMV 23PST",$J,GMVDA1))  ;rpc is already there
 .K GMVERR,GMVFDA,GMVIEN
 .S GMVFDA(19.05,"+1,"_GMVDA_",",.01)=GMVDA1
 .D UPDATE^DIE("","GMVFDA","GMVIEN","GMVERR")
 .Q
 K ^TMP($J),^TMP("GMV 23PST",$J)
 Q
RPCLIST ; List of GMV RPC(s) to add to OR CPRS GUI CHART option 
 ;;GMV CLOSEST READING
 Q
