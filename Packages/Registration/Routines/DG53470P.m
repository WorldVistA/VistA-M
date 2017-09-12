DG53470P ;ALB/EW;PRE/POST INIT FOR PATCH 470;8/19/2002
 ;;5.3;Registration;**470**;Aug 13, 1993
 ;
PRE ;Pre-Install
 ;
 I $D(^DGIN(38.6,61,0)) D  H 2
 . D BMES^XPDUTL("Internal entry number 61 already exist in file 38.6")
 . S XPDABORT=2
 I $D(^DGIN(38.6,62,0)) D  H 2
 . D BMES^XPDUTL("Internal entry number 62 already exist in file 38.6")
 . S XPDABORT=2
 Q
POST ;Post-Install
 F I=61,62 D
 .N MSGROOT,FDAWP,FDAROOT,IENROOT,IEN,X
 .D BMES^XPDUTL("Creating definition for INCONSISTENT DATA ELEMENT #"_I)
 .S IEN="+1,"
 .I I=61 D  ;Missing Phone Number
 ..S FDAROOT(38.6,IEN,.01)="MISSING PHONE NUMBER DATA"
 ..S FDAROOT(38.6,IEN,2)="PHONE NUMBER INFORMATION INCOMPLETE"
 ..S FDAROOT(38.6,IEN,50)="FDAWP"
 ..S FDAWP(1,0)="Inconsistency results if the Patient's Residence Phone number and Work"
 ..S FDAWP(2,0)="Phone number have not been entered."
 .I I=62 D  ;Emergency Contact
 ..S FDAROOT(38.6,IEN,.01)="EMERGENCY CONTACT NAME MISSING"
 ..S FDAROOT(38.6,IEN,2)="EMERGENCY CONTACT NAME MISSING"
 ..S FDAROOT(38.6,IEN,50)="FDAWP"
 ..S FDAWP(1,0)="Inconsistency results if the emergency contact name is not entered."
 .S FDAROOT(38.6,IEN,3)="NO KEY REQUIRED"
 .S FDAROOT(38.6,IEN,4)="NO"
 .S FDAROOT(38.6,IEN,5)="CHECK"
 .S IENROOT(1)=I
 .D UPDATE^DIE("E","FDAROOT","IENROOT","MSGROOT")
 .I $D(MSGROOT("DIERR")) D
 ..N ERR,LN,LN2
 ..S (ERR,LN2)=0
 ..F  S ERR=+$O(MSGROOT("DIERR",ERR)) Q:'ERR  D
 ...S LN=0
 ...F  S LN=+$O(MSGROOT("DIERR",ERR,"TEXT",LN)) Q:'LN  D
 ....S LN2=LN2+1
 ....S X(LN2)=MSGROOT("DIERR",ERR,"TEXT",LN)
 ..D BMES^XPDUTL(.X)
 Q
