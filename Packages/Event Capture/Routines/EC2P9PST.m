EC2P9PST ;ALB/GTS/JAP - PATCH EC*2.0*9 Post-Init Rtn ; Feb 13, 1997
 ;;2.0; EVENT CAPTURE ;**9**;8 May 96
 ;
POST ;Entry point
 D INTRO
 ;
 ;if new entries (iens>489) already added, display message and quit
 I $D(^EC(725,490,0)) D  Q
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" It appears that patch EC*2*9 was previously installed.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" If you wish to repeat the installation of patch EC*2*9,")
 .D MES^XPDUTL(" then run CLEAN^EC725CH3 first -- that will delete any")
 .D MES^XPDUTL(" entries from EC*2*9 previously added.")
 .D MES^XPDUTL(" ")
 ;
 ;add new entries
 I '$D(^EC(725,490)) D ADD^EC725CH3
 Q
 ;
INTRO ; Message intro
 ;;   
 ;; The purpose of Patch EC*2*9 is to add new entries to the
 ;; EC NATIONAL PROCEDURE File (#725).  A total of 433 new
 ;; entries will be made.
 ;;   
 ;;    
 ;;QUIT
 ;
 N TXTVAR
 F I=1:1 S TXTVAR=$P($T(INTRO+I),";;",2) Q:TXTVAR="QUIT"  DO
 .D MES^XPDUTL(TXTVAR)
 Q
