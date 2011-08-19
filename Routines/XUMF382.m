XUMF382 ;ISS/RAM - post-install routine ;04/15/02
 ;;8.0;KERNEL;**382**;Jul 10, 1995
 ;
POST ; -- post init
 ;
 N X
 S X=$$ATTREM()
 ;
 Q
 ;
ATTREM() ;Attach Remote Members to XUMF ERROR Mail Group
 N XUMFERRF,XUMFFDA,XUMFGIEN,XUMFGNM,XUMFLNE,XUMFMSG,XUMFRNM,XUMFTXT
 K XUMMSG
 D BMES^XPDUTL("Attaching Remote Members to XUMF Mail Groups")
 F XUMFLNE=1:1 S XUMFTXT=$P($T(REMMEM+XUMFLNE),";;",2) Q:XUMFTXT="END"!($G(XUMFERRF))  D
 . S XUMFGNM=$P(XUMFTXT,"^",1)
 . S XUMFGIEN=$$FIND1^DIC(3.8,"","X",XUMFGNM,"","","")
 . S XUMFRNM=$P(XUMFTXT,"^",2)
 . ;If Mail Group not found, error
 . I XUMFGIEN'>0 D
 . . S XUMMSG(1)="**"
 . . S XUMMSG(2)="** Mail Group "_XUMFGNM_" not found"
 . . D MES^XPDUTL(.XUMMSG) K XUMMSG
 . . S XUMFERRF=1
 . ELSE  D
 . . ;Attach Remote Member to Mail Group
 . . N XUMFFDA,XUMFIEN,XUMFMSG
 . . S XUMFFDA(3.812,"?+2,"_XUMFGIEN_",",.01)=XUMFRNM
 . . D UPDATE^DIE("","XUMFFDA","XUMFIEN","XUMFMSG")
 . . ;Check for error
 . . I $D(XUMFMSG("DIERR")) D
 . . . S XUMMSG(1)="**"
 . . . S XUMMSG(2)="** Unable to attach "_XUMFRNM_" to "_XUMFGNM
 . . . D MES^XPDUTL(.XUMMSG) K XUMMSG
 . . . S XUMFERRF=1
 . . ELSE  D
 . . . S XUMMSG(1)=" "
 . . . S XUMMSG(2)=".."_XUMFRNM_$S($G(XUMFIEN(2,0))="?":" already",1:"")_" attached to "_XUMFGNM
 . . . D MES^XPDUTL(.XUMMSG) K XUMMSG
 ;Check for error
 I $G(XUMFERRF) D
 . S XUMMSG(1)="** Post-installation will be halted"
 . S XUMMSG(2)="**"
 . D MES^XPDUTL(.XUMMSG) K XUMMSG
 Q +$S($G(XUMFERRF):0,1:1)
 ;
REMMEM ;Mail Group Name^Remote Member
 ;;XUMF ERROR^G.XUMF ERROR@FORUM.VA.GOV
 ;;XUMF ERROR^G.HDIS ERRORS@FORUM.VA.GOV
 ;;XUMF ERROR^G.HDIS ERT NOTIFICATION@FORUM.VA.GOV
 ;;END
