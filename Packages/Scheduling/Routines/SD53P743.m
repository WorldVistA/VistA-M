SD53P743 ;ALB/DRP - Post Install ; Feb 10,2020
 ;;5.3;Scheduling;**743**;Aug 13, 1993;Build 2
 ;
 ; The following ICR's grant access to Non-SD applications.
 ; IVA (VIA) is releasing this patch in concordance with the
 ; VSE Development team.
 ; SDEC APPSLOTS (ICR #7071)
 ; SDEC APPADD (ICR #7059)
 ; SDEC APPDEL (ICR #7065)
 ; SDEC CHECKIN (ICR #7067)
 ; SDEC CHECKOUT (ICR #7069)
 ; SDEC CANCKOUT (ICR #7073)
 ; SDEC NOSHOW (ICR #7075)
 ; SDEC CRSCHED (ICR #7077)
 ; SDEC FAPPTGET (ICR #7081)
 Q
 ;
SETAPP ;Check RPC, Set App proxy allowed flag
 N SDRPC,SDERR,SDIEN
 K FDA
 D BMES^XPDUTL("SD*5.3*743 Post-Install starts...")
 F SDI=1:1 S SDRPC=$P($T(RPC+SDI),";;",2) Q:SDRPC="STOP"  D
 . ;Return IEN if OK to run, 0 otherwise.
 . S SDIEN=$O(^XWB(8994,"B",SDRPC,0))
 . I +$G(SDIEN)'>0 D BMES^XPDUTL("       >> ... Unable to set APP PROXY ENABLED flag for "_SDRPC_" in Remote Procedure Not found")
 .S FDA(8994,SDIEN_",",.11)=1 ;S APPROXY ALLOWED TO YES
 .S DIC(0)="" ;Needed in call to XUA4A7
 .D FILE^DIE("I","FDA","IENS")
 .I $D(^TMP("DIERR",$J,1,"TEXT",1)) D
 ..S SDERR=^TMP("DIERR",$J,1,"TEXT",1)
 ..D MES^XPDUTL("        >> ... "_$G(SDERR("DIERR",1,"TEXT",1))_".")
 ..D MES^XPDUTL("        >> ... Please contact IVA(VIA) support for assistance...")
 ..K ^TMP("DIERR",$J)
 ..Q
 .Q
 D MES^XPDUTL("SD*5.3*743 Post-Install is complete."),MES^XPDUTL("")
 K %H,%I,DIC,X,Y
 Q
 ;
RPC ;List of RPCs to update
 ;;SDEC APPSLOTS
 ;;SDEC APPADD
 ;;SDEC APPDEL
 ;;SDEC CHECKIN
 ;;SDEC CHECKOUT
 ;;SDEC CANCKOUT
 ;;SDEC NOSHOW
 ;;SDEC CRSCHED
 ;;SDEC FAPPTGET
 ;;STOP
 Q
 ;
TEST ; Check flags for install test. Before and After.
 N SDRPC,SDI 
 F SDI=1:1 D  Q:SDRPC="STOP"
 . S SDRPC=$P("SDEC APPSLOTS^SDEC APPADD^SDEC APPDEL^SDEC CHECKIN^SDEC CHECKOUT^SDEC CANCKOUT^SDEC NOSHOW^SDEC CRSCHED^SDEC FAPPTGET^STOP","^",SDI)
 . W:SDRPC'="STOP" !,SDRPC,"=",$P($G(^XWB(8994,$O(^XWB(8994,"B",SDRPC,0)),0)),"^",11)
 .Q
 Q
 ;
