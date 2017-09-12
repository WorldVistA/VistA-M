DG53489P ;ALB/EW;BPFO/MM -PRE/POST INIT FOR DG*5.3*489 ;3/10/2003
 ;;5.3;Registration;**489**;Aug 13, 1993
 ;
 ;The post initialization routine for DG*5.3*489  adds a new 
 ;inconsistent data element to the Inconsistent Data Element 
 ;(#38.6) file with internal entry number 63.
 ;
POST ;Post-Install
 N MSGROOT,FDAWP,FDAROOT,IENROOT,IEN,X
 D BMES^XPDUTL("Creating definition for Conf. Address Data Incomplete - entry #63")
 D MES^XPDUTL("in INCONSISTENT DATA ELEMENT (#38.6) file.")
 I $D(^DGIN(38.6,63,0)) D  Q
 . D BMES^XPDUTL("Internal entry number 63 already exist in file 38.6.")
 . D MES^XPDUTL("Cannot add Conf. Address Data Incomplete element.")
 S IEN="+1,"
 S FDAROOT(38.6,IEN,.01)="CONF. ADDRESS DATA INCOMPLETE"
 S FDAROOT(38.6,IEN,2)="'CONFIDENTIAL ADDRESS' INFORMATION INCOMPLETE"
 S FDAROOT(38.6,IEN,50)="FDAWP"
 S FDAWP(1,0)="Inconsistency results if a record with an active confidential"
 S FDAWP(2,0)="address does not contain the first line of the street address,"
 S FDAWP(3,0)="city, state, and zip code for the confidential address."
 S FDAROOT(38.6,IEN,3)="NO KEY REQUIRED"
 S FDAROOT(38.6,IEN,4)="NO"
 S FDAROOT(38.6,IEN,5)="CHECK"
 S IENROOT(1)=63
 D UPDATE^DIE("E","FDAROOT","IENROOT","MSGROOT")
 I $D(MSGROOT("DIERR")) D
 .N ERR,LN,LN2
 .S (ERR,LN2)=0
 .F  S ERR=+$O(MSGROOT("DIERR",ERR)) Q:'ERR  D
 ..S LN=0
 ..F  S LN=+$O(MSGROOT("DIERR",ERR,"TEXT",LN)) Q:'LN  D
 ...S LN2=LN2+1
 ...S X(LN2)=MSGROOT("DIERR",ERR,"TEXT",LN)
 ..D BMES^XPDUTL(.X)
 Q
