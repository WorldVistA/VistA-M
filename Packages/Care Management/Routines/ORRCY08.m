ORRCY08 ;SLC/TEJ - POST INSTALL FOR PATCH 8 ; October 19, 2015 07:05:56
 ;;1.0;CARE MANAGEMENT;**8**;Jul 15, 2003;Build 7
 ;
 ; IA- #10156  Ref- ^DIC(19,  Status- Supported (KERNEL)
 ;     #5005        ^XHDX             Private   (HEALTHEVET DESKTOP)
 ;
 ;****************************************
 ;
 Q
POST ; Maintain CARE MANAGEMENT versioning (1.8.0)
 ; Change MENU TEXT  to reflect new version
 K OPT,ORRCVER,ORRCDB,FDAIEN,FDA
 S ORRCVER="Care Management Dashboard 1.8.0"
 S OPT="ORRCMC DASHBOARD"
 D FIND^DIC(19,"",1,"X",OPT,1,,,,"ORRCDB")
 S FDAIEN(1)=ORRCDB("DILIST","2",1)
 S FDA(8,19,FDAIEN(1)_",",1)=ORRCVER
 ;UPDATE^DIE(flags,fda_root,ien_root,msg_root)
 L +^DIC(19,FDAIEN(1)):DILOCKTM I $T D UPDATE^DIE("","FDA(8)","FDAIEN") L -^DIC(19,FDAIEN(1))
 D CLEAN^DILF
 K FDAIEN,OPT,ORRCDB,FDA
 K ORRCOPT,ORRCNULL S ORRCOPT(1)="ORRCMC DASHBOARD",ORRCNULL(1)="" D VERSRV^XHDX(.ORRCNULL,.ORRCOPT)
 W:$P(ORRCNULL(1),"^",2)=$P(ORRCVER,"Care Management Dashboard ",2) !,"Care Management Dashboard 1.8.0",!
 K ORRCOPT,ORRCNULL,ORRCVER
 Q
 ;
