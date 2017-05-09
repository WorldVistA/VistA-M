RA5130P ;ALB/BJR - DELETE OLD AS AND AP X-REF ; 8/16/16 10:36am
 ;;5.0;Radiology/Nuclear Medicine;**130**;Mar 16, 1998;Build 3
 ;
 Q
EN ; Entry point
 ; Delete old ARS and ADT x-ref
 Q:$$PATCH^XPDUTL("RA*5.0*130")  ;Patch has already been installed
 N RAERR,RAERR1,RAMSG
 D DELIX^DDMOD(75.1,2,1,,,"RAERR") I $D(RAERR) D
 .D BMES^XPDUTL("An error has occured when attempting to delete the 'ADT' x-ref.")
 .I $D(RAERR("DIERR",1,"TEXT")) S RAMSG=0 F  S RAMSG=$O(RAERR("DIERR",1,"TEXT",RAMSG)) Q:'RAMSG  D
 ..D BMES^XPDUTL(RAERR("DIERR",1,"TEXT",RAMSG))
 .D BMES^XPDUTL("Please contact local site support.")
 D DELIX^DDMOD(75.1,5,1,,,"RAERR1") I $D(RAERR1) D
 .D BMES^XPDUTL("An error has occured when attempting to delete the 'ARS' x-ref.")
 .I $D(RAERR1("DIERR",1,"TEXT")) S RAMSG=0 F  S RAMSG=$O(RAERR1("DIERR",1,"TEXT",RAMSG)) Q:'RAMSG  D
 ..D BMES^XPDUTL(RAERR1("DIERR",1,"TEXT",RAMSG))
 .D BMES^XPDUTL("Please contact local site support.")
 Q
