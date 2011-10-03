GMRVXENV ;HIRMFO/RM-ENVIRONMENT CHECK FOR VITALS ;7/18/96
 ;;4.0;Vitals/Measurements;;Apr 25, 1997
EN1 ; environment check for the vitals package
 N GMRV
 S GMRV=+$$VERSION^XPDUTL("REGISTRATION") I GMRV<5.3 W !!,"PIMS (MAS) V5.3 OR GREATER IS REQUIRED - INSTALL ABORTED!" S XPDABORT=2 Q
 S GMRV=+$$VERSION^XPDUTL("GMRV") I GMRV>0,GMRV<3 W !!,"GEN. MED. REC. - VITALS V3.0 is required",!,"prior to the installation of V4.0 - INSTALL ABORTED!" S XPDABORT=2 Q
 I GMRV=3,+$$PATCH^XPDUTL("GMRV*3.0*3")=0 W !!,"GMRV*3*3 is required prior to the installation of v4.0 - Install aborted!" S XPDABORT=2 Q
 ;
 Q:+$$VERSION^XPDUTL("GMRV")'>0  ;quit if virgin install
 K GMRVIEN,GMRVERR
 ; how many V/M entries in Package File (#9.4)
 D FIND^DIC(9.4,"","","X","GMRV","","C","","","GMRVIEN","GMRVERR")
 ; quit if FileMan lookup errors out
 I +$G(GMRVERR("DIERR")) D  S GMRVSTOP=1 D KILL Q
 .K GMRVMSG
 .S GMRVMSG(1)="Error trying to lookup Vitals/Measurements in the PACKAGE (#9.4) file."
 .S GMRVMSG(2)="Halting."
 .D BMES^XPDUTL(.GMRVMSG)
 .Q
 ; delete duplicates
 ; keep GEN. MED. REC. - VITALS entry
 S GMRVSEQ=0
 F  S GMRVSEQ=$O(GMRVIEN("DILIST",1,GMRVSEQ)) Q:GMRVSEQ'>0  D
 . S GMRVNAME=$G(GMRVIEN("DILIST",1,GMRVSEQ)) Q:GMRVNAME=""
 . I GMRVNAME="GEN. MED. REC. - VITALS" Q
 . S DA=$G(GMRVIEN("DILIST",2,GMRVSEQ))
 . I DA S DIK="^DIC(9.4," D ^DIK
 . Q
KILL ;
 S:$G(GMRVSTOP) XPDABORT=2 ;don't install transport global/leave in ^XTMP
 K DA,DIK,GMRVERR,GMRVIEN,GMRVMSG,GMRVNAME,GMRVSEQ,X,Y
 Q
