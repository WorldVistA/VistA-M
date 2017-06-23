SR3189P ;ALB/BJR - DELETE OLD ADT AND ARS X-REF ; 8/15/16 3:36pm
 ;;3.0;Surgery;**189**;24 Jun 93;Build 3
 ;
 Q
EN ; Entry point
 ; Delete old ARS and ADT x-ref
 Q:$$PATCH^XPDUTL("SR*3.0*189")  ;Patch has already been installed
 N SRERR,SRERR1,SRMSG
 D DELIX^DDMOD(130,.09,2,,,"SRERR") I $D(SRERR) D
 .D BMES^XPDUTL("An error has occured when attempting to delete the 'ADT' x-ref.")
 .I $D(SRERR("DIERR",1,"TEXT")) S SRMSG=0 F  S SRMSG=$O(SRERR("DIERR",1,"TEXT",SRMSG)) Q:'SRMSG  D
 ..D BMES^XPDUTL(SRERR("DIERR",1,"TEXT",SRMSG))
 .D BMES^XPDUTL("Please contact local site support.")
 D DELIX^DDMOD(130,235,1,,,"SRERR1") I $D(SRERR1) D
 .D BMES^XPDUTL("An error has occured when attempting to delete the 'ARS' x-ref.")
 .I $D(SRERR1("DIERR",1,"TEXT")) S SRMSG=0 F  S SRMSG=$O(SRERR1("DIERR",1,"TEXT",SRMSG)) Q:'SRMSG  D
 ..D BMES^XPDUTL(SRERR1("DIERR",1,"TEXT",SRMSG))
 .D BMES^XPDUTL("Please contact local site support.")
 Q
