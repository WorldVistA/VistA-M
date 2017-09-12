ECX3P7PT ;ALB/JAP - PATCH ECX*3*7 Post-Init Rtn ; May 6, 1998
 ;;3.0;DSS EXTRACTS;**7**;Dec 22, 1997
 ;
POST ;Entry point
 N ECXDA
 D INTRO
 ;
 ;if new entries (iens>112) already added, display message and quit
 S ECXDA=$O(^ECX(728.441,999),-1)
 I $D(^ECX(728.441,113,0)),$P(^(0),U,1)="AAAA" D  Q
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" It appears that patch ECX*3*7 was previously installed.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" If you wish to repeat the installation of patch ECX*3*7,")
 .D MES^XPDUTL(" then run CLEAN^ECX3P7P1 first -- that will delete any")
 .D MES^XPDUTL(" entries from ECX*3*7 previously added.")
 .D MES^XPDUTL(" ")
 ;
 ;check contents of entry #113
 I ($D(^ECX(728.441,113,0))&($P($G(^(0)),U,1)'="AAAA"))!(ECXDA'=112) D  Q
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" It appears that you may have a problem with File #728.441.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" Perform a FileMan print of the entire file which shows")
 .D MES^XPDUTL(" the internal entry number and #.01 field of each record.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" Call Customer Support for further assistance.")
 .D MES^XPDUTL(" Have the FileMan printout at hand when you call.")
 .D MES^XPDUTL(" ")
 ;
 ;add new entries
 I '$D(^EC(728.441,113)),ECXDA=112 D ADD^ECX3P7P1
 Q
 ;
INTRO ; Message intro
 ;;   
 ;; The purpose of Patch ECX*3*7 is to add new entries to the
 ;; NATIONAL CLINIC File (#728.441).  A total of 158 new
 ;; entries will be made.
 ;;   
 ;;    
 ;;QUIT
 ;
 N TXTVAR
 F I=1:1 S TXTVAR=$P($T(INTRO+I),";;",2) Q:TXTVAR="QUIT"  DO
 .D MES^XPDUTL(TXTVAR)
 Q
