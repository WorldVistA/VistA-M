GMVXPST ;HOIFO/FT-POST INSTALLATION FOR VITALS ;10/28/02  12:33
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10141 - ^XPDUTL calls (supported)
 ; #2263  - ^XPAR calls   (supported)
 ;
 ; This post-installation:
 ; 1) deletes the data dictionary entries and data for File 120.5,
 ;    Fields 1.1 and 1.3
 ; 2) deletes the data dictionary entries and data for File 120.51,
 ;    Fields 2 and 6
 ; 3) updates the parameters for the required client version
 ; 4) deletes some bogus data dictionary nodes in FILE 120.5
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
 NEW GMV,GMVGUI,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating system parameters.")
 ; Set current client version
 S GMVGUI="5.0.0.0"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 .D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV GUI VERSION","VITALS.EXE:"_GMVGUI,1)
 D EN^XPAR("SYS","GMV GUI VERSION","VITALSMANAGER.EXE:"_GMVGUI,1)
 ; Set latest Vital Home Page
 D EN^XPAR("SYS","GMV WEBLINK",1,"http://vista.med.va.gov/ClinicalSpecialties/vitals/")
 ;
 ; Kill bogus DD nodes
 K ^DD(120.5,1,0)
 K ^DD(120.5,1,21,0)
 K ^DD(120.5,1,21,1,0)
 K ^DD(120.5,1,21,2,0)
 K ^DD(120.5,"B","SITE",1)
 K ^DD(120.5,"GL",1,0,1)
 K ^DD(120.5,"SB",120.505,1)
 ;
QUEUE ; Queue post-install
 N GMVMSG,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 I +$$VERSION^XPDUTL("GMRV")>4.9 Q  ;post-install was done before
 D BMES^XPDUTL("Will queue data cleanup as a background job.")
 S ZTDESC="V/M v5.0 Data Cleanup"
 S ZTRTN="EN^GMVXPST",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 S:ZTSK GMVMSG="Task #: "_ZTSK
 S:'ZTSK GMVMSG="Could not task the data cleanup."
 D MES^XPDUTL(GMVMSG)
 Q
EN ; Driver subroutine for post-installation
 S:$D(ZTQUEUED) ZTREQ="@"
 D DATA,DD
 Q
DD ; Delete obsolete data dictionary fields
 ; delete *SITE (#2) and *QUALITY (#6) from File 120.51
 N DA,DIK
 S DIK="^DD(120.51,"
 F DA=2,6 D
 .S DA(1)=DA
 .D ^DIK
 .Q
 ; delete *SITE (#1.1) and *QUALITY (#1.3) from File 120.5
 S DIK="^DD(120.5,"
 F DA=1.1,1.3 D
 .S DA(1)=DA
 .D ^DIK
 .Q
 Q
DATA ; Delete data from obsolete fields
 ; delete data from File 120.51, Fields 2 and 6
 N DA,DIE,DR,GMVNODE
 S DA=0
 F  S DA=$O(^GMRD(120.51,DA)) Q:'DA  D
 .S DIE="^GMRD(120.51,",DR="2///@;6///@"
 .D ^DIE
 .Q
 ; delete data from File 120.5, Fields 1.1 and 1.3
 S DA=0
 F  S DA=$O(^GMR(120.5,DA)) Q:'DA  D
 .S GMVNODE=$G(^GMR(120.5,DA,0))
 .I $P(GMVNODE,U,7)="",$P(GMVNODE,U,9)="" Q  ;no data to delete
 .S DIE="^GMR(120.5,",DR="1.1///@;1.3///@"
 .D ^DIE
 .Q
 Q
