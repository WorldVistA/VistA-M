DG505P ;BIR/PTD-PATCH DG*5.3*505 PRE/POST INSTALLATION ROUTINE ;4/7/03
 ;;5.3;Registration;**505**;Aug 13, 1993
 ;
 ;Reference to ^DD supported by IA #4078
 ;
PRE ;pre-install to check consistency checker data elements
 I $$PATCH^XPDUTL("DG*5.3*505") Q  ;patch previously installed - don't abort post init
 N I
 F I=64:1:66 I $D(^DGIN(38.6,I,0)) D  H 2
 . D BMES^XPDUTL(" ** Internal entry number "_I_" already exists in file 38.6 - contact NVS **")
 . S XPDABORT=2
 Q
 ;
POST ;Post-init entry point
 D POST1,POST2
 Q
 ;
POST1 ;Update identifier code for MULTIPLE BIRTH INDICATOR (#994) field in PATIENT (#2) file
 D BMES^XPDUTL(" Updating the identifier code for the MULTIPLE BIRTH INDICATOR (#994) field.")
 S ^DD(2,0,"ID",994)="I $$GET1^DIQ(2,Y_"","",994,""I"")=""Y"" D EN^DDIOL($$GET1^DIQ(2,Y_"","",994),"""",""?$X+2"")"
 Q
 ;
POST2 ;post-init to add new inconsistent data elements
 N I
 F I=64:1:66 D
 .N MSGROOT,FDAWP,FDAROOT,IENROOT,IEN,X
 .D BMES^XPDUTL("Creating definition for INCONSISTENT DATA ELEMENT #"_I)
 .S IEN="+1,"
 .I I=64 D  ;POB CITY/STATE MISSING
 ..S FDAROOT(38.6,IEN,.01)="POB CITY/STATE MISSING"
 ..S FDAROOT(38.6,IEN,2)="PLACE OF BIRTH CITY OR STATE IS MISSING"
 ..S FDAROOT(38.6,IEN,50)="FDAWP"
 ..S FDAWP(1,0)="Inconsistency results if the Patient's Place of Birth City or"
 ..S FDAWP(2,0)="State have not been entered."
 .I I=65 D  ;MOTHER'S MAIDEN NAME MISSING
 ..S FDAROOT(38.6,IEN,.01)="MOTHER'S MAIDEN NAME MISSING"
 ..S FDAROOT(38.6,IEN,2)="MOTHER'S MAIDEN NAME MISSING"
 ..S FDAROOT(38.6,IEN,50)="FDAWP"
 ..S FDAWP(1,0)="Inconsistency results if the Mother's Maiden Name is not entered."
 .I I=66 D  ;PSEUDO SSN IN USE
 ..S FDAROOT(38.6,IEN,.01)="PSEUDO SSN IN USE"
 ..S FDAROOT(38.6,IEN,2)="PSEUDO SSN IN USE"
 ..S FDAROOT(38.6,IEN,50)="FDAWP"
 ..S FDAWP(1,0)="Inconsistency results if a Pseudo SSN has been entered."
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
