SD53P750 ;ALB/DBE - PCMM CPRS HEADER ENABLE TLS ; 10/13/2020
 ;;5.3;Scheduling;**750**;Aug 13, 1993;Build 1
 ;
 Q
 ;
 ; Private ICR:
 ; #6171 - READ WRITE ACCESS TO WEB SERVER FILE
 ;
UPDATE ;update PCMM HWSC web server entries
 ;
 ;enable tls for both pcmm hwsc entries
 D ENABLTLS("PCMMR TEST")
 D ENABLTLS("PCMMR")
 ;
 ;disable pcmmr test hwsc entry in all environments
 D DISABLE("PCMMR TEST")
 ;
 ;disable pcmmr production entry in test environments only
 I '$$PROD^XUPROD D DISABLE("PCMMR")
 ;
 Q
 ;
ENABLTLS(SDSERVER) ;enable tls for hwsc server entry
 ;
 Q:$G(SDSERVER)=""
 N SDWSIEN,SDFDA,SDERR ;sdwsien=pcmm web server entry ien
 ;
 D BMES^XPDUTL(">>>Enabling SSL for the '"_SDSERVER_"' entry in the Web Server (#18.12) file...")
 ;
 S SDWSIEN=0 S SDWSIEN=$O(^XOB(18.12,"B",SDSERVER,SDWSIEN)) Q:'SDWSIEN  D  ;identify pcmm web server entry ien (no duplicates allowed)
  .I $P(^XOB(18.12,SDWSIEN,0),U,1)=SDSERVER D  ;verify correct name
  ..S SDFDA(18.12,SDWSIEN_",",3.01)=1 ;ssl enabled
  ..S SDFDA(18.12,SDWSIEN_",",3.02)="encrypt_only_tlsv12" ;ssl/tls configuration
  ..S SDFDA(18.12,SDWSIEN_",",3.03)=443 ;ssl port number
  ..K SDERR D FILE^DIE(,"SDFDA","SDERR")
  ..I '$D(SDERR) D MES^XPDUTL(" >>>...'"_SDSERVER_"' server entry (IEN #"_SDWSIEN_") successfully updated")
  ..I $D(SDERR) D MES^XPDUTL(" >>>...Error updating '"_SDSERVER_"' server entry (IEN #"_SDWSIEN_")") D
  ...D MES^XPDUTL(" ERROR: "_$G(SDERR("DIERR","1"))) ;print error code to help identify filing issue
  ...D MES^XPDUTL(" *** Please contact support for assistance. ***")
 K SDSERVER
 Q
 ;
DISABLE(SDSERVER) ;disable hwsc server entry
 ;
 Q:$G(SDSERVER)=""
 N SDWSIEN,SDFDA,SDERR ;sdwsien=pcmm web service entry ien
 ;
 D BMES^XPDUTL(">>>Disabling the '"_SDSERVER_"' entry in the Web Server (#18.12) file...")
 ;
 S SDWSIEN=0 S SDWSIEN=$O(^XOB(18.12,"B",SDSERVER,SDWSIEN)) Q:'SDWSIEN  D  ;identify pcmm web server entry ien (no duplicates allowed)
  .I $P(^XOB(18.12,SDWSIEN,0),U,1)=SDSERVER D  ;verify correct name
  ..S SDFDA(18.12,SDWSIEN_",",.06)=0 ;disable server
  ..K SDERR D FILE^DIE(,"SDFDA","SDERR")
  ..I '$D(SDERR) D MES^XPDUTL(" >>>...'"_SDSERVER_"' server entry (IEN #"_SDWSIEN_") successfully disabled")
  ..I $D(SDERR) D MES^XPDUTL(" >>>...Error updating '"_SDSERVER_"' server entry (IEN #"_SDWSIEN_")") D
  ...D MES^XPDUTL(" ERROR: "_$G(SDERR("DIERR","1"))) ;print error code to help identify filing issue
  ...D MES^XPDUTL(" *** Please contact support for assistance. ***")
 K SDSERVER
 Q
