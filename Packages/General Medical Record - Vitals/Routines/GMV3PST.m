GMV3PST ;HOIFO/FT-POST INSTALLATION FOR GMRV*5*3 ;5/17/05  08:56
 ;;5.0;GEN. MED. REC. - VITALS;**3**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #2263  - ^XPAR calls   (supported)
 ; #4835  - Add RPCS to OR CPRS GUI CHART option (private)
 ; #10141 - ^XPDUTL calls (supported)
 ;
 ; This routine supports the following IAs:
 ; #4833 - ADDRPCS     (private)
 ;
 ; This post-installation:
 ; Updates the parameters for the required client version.
 ; Adds GMV RPCS to the 'OR CPRS GUI CHART' list of RPCs
 ;
EN ; Main entry point
 D XPAR,ADDRPCS,DLL
 Q
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
 S GMVGUI="5.0.3.19"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 .D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
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
 S GMVDLL="GMV_VITALSVIEWENTER.DLL:v. 01/20/06 09:08" ;T17
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 S GMVDLL="GMV_VITALSVIEWENTER.DLL:v. 02/15/06 15:55" ;T18
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 S GMVDLL="GMV_VITALSVIEWENTER.DLL:v. 03/14/06 16:35" ;released version (19)
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 Q
ADDRPCS ; Add GMV RPCs to CPRS option
 N GMVDA,GMVDA1,GMVERR,GMVFDA,GMVIEN,GMVMSG,GMVNAME,GMVNODE,GMVTEST,GMVX
 K ^TMP($J),^TMP("GMV 3PST",$J)
 S GMVDA=$$FIND1^DIC(19,"","O","OR CPRS GUI CHART","B","","GMVERR")
 I 'GMVDA D  Q
 .S GMVMSG(1)="Cannot find the 'OR CPRS GUI CHART' option."
 .S GMVMSG(2)="Cannot add the RPCs needed. Please log a Remedy Ticket."
 .D EN^DDIOL(.GMVMSG,"","!?5")
 .Q
 ; Get list of existing RPCs for OR CPRS GUI CHART option
 D GETS^DIQ(19,GMVDA,"320*","I","^TMP($J)","GMVERR")
 S GMVX=""
 F  S GMVX=$O(^TMP($J,19.05,GMVX)) Q:GMVX=""  D
 .S GMVIEN=+$G(^TMP($J,19.05,GMVX,.01,"I"))
 .Q:'GMVIEN
 .S ^TMP("GMV 3PST",$J,GMVIEN)=""
 .Q
 K GMVERR,GMVX
 ; get GMV rpcs from table
 F GMVX=1:1 S GMVNODE=$T(RPCLIST+GMVX) Q:$P(GMVNODE,";",3)=""  D
 .S GMVNAME=$P(GMVNODE,";",3)
 .Q:GMVNAME=""
 .K GMVERR
 .S GMVDA1=$$FIND1^DIC(8994,"","O",GMVNAME,"B","","GMVERR")
 .Q:'GMVDA1
 .Q:$D(^TMP("GMV 3PST",$J,GMVDA1))  ;rpc is already there
 .K GMVERR,GMVFDA,GMVIEN
 .S GMVFDA(19.05,"+1,"_GMVDA_",",.01)=GMVDA1
 .D UPDATE^DIE("","GMVFDA","GMVIEN","GMVERR")
 .Q
 K ^TMP($J),^TMP("GMV 3PST",$J)
 Q
RPCLIST ; List of GMV RPCs to add to OR CPRS GUI CHART option 
 ;;GMV ADD VM
 ;;GMV CONVERT DATE
 ;;GMV GET CATEGORY IEN
 ;;GMV GET CURRENT TIME
 ;;GMV GET VITAL TYPE IEN
 ;;GMV LATEST VM
 ;;GMV MANAGER
 ;;GMV PARAMETER
 ;;GMV USER
 ;;GMV VITALS/CAT/QUAL
 ;;GMV V/M ALLDATA
 ;;GMV EXTRACT REC
 ;;GMV MARK ERROR
 ;;GMV ALLERGY
 ;;GMV DLL VERSION
 ;;GMV LOCATION SELECT
 ;;;
