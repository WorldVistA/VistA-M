DVBAP219 ;ALB/DBE - CAPRI REMOTE APPLICATION FILE UPDATE ; 3/9/2020
 ;;2.7;AMIE;**219**;Apr 10, 1995;Build 3
 ;
 ; Post-init routine updating CALLBACKSERVER (.03) field of
 ; the CAPRI entry in the REMOTE APPLICATION (#8994.5) file
 ;
 Q
 ;
EN ;routine entry point
 D UPDATE ;update capri callbackserver in remote application (#8994.5) file
 D BMES^XPDUTL("Update complete.")
 ;
 Q
 ;
UPDATE ;updating capri callbackserver entry
 ;
 N DVBAIEN,DVBAERR,DVBAFDA,DVBASUBF,DVBASUBI ;dvbasubf=subfile, dvbasubi=subfile entry ien
 ;
 D MES^XPDUTL(">>>Updating CAPRI entry in REMOTE APPLICATION (#8994.5) file...")
 ;
 S DVBAIEN=0 F  S DVBAIEN=$O(^XWB(8994.5,"B","CAPRI",DVBAIEN)) Q:'DVBAIEN  D  ;identify capri entry ien(s)
  .S DVBASUBI=0 F  S DVBASUBI=$O(^XWB(8994.5,DVBAIEN,1,"B","R",DVBASUBI)) Q:'DVBASUBI  D  ;only use rpc-broker ("R") subfile ien(s)
  ..I $P(^XWB(8994.5,DVBAIEN,1,DVBASUBI,0),U,3)="DOMAIN.EXT" D
  ...S DVBASUBF="8994.51" ;callbacktype subfile number
  ...S DVBAFDA(DVBASUBF,DVBASUBI_","_DVBAIEN_",",.03)="claims.domain.ext" ;fda format (subfile,subfile ien,parent file ien,field)
  ...K DVBAERR D FILE^DIE(,"DVBAFDA","DVBAERR")
  ...I '$D(DVBAERR) D BMES^XPDUTL("    >>>....CAPRI entry (IEN #"_DVBAIEN_") updated successfully")
  ...I $D(DVBAERR) D BMES^XPDUTL("    >>>....Error updating CAPRI entry (IEN #"_DVBAIEN_")") D
  ....D MES^XPDUTL("       ERROR: "_DVBAERR("DIERR","1")) ;print error code to help identify filing issue
  ....D BMES^XPDUTL("    *** Please contact support for assistance. ***")
 Q
