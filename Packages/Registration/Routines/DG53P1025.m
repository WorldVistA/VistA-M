DG53P1025 ;SLC/RM - Patch DG*5.3*1025 Post Install Utility Routine ; July 15,2020@11:27am
 ;;5.3;Registration;**1025**;Aug 13, 1993;Build 11
 ;
 ;
 ;ICR#   TYPE       REFERENCE TO
 ;-----  ----       ---------------------
 ;10141  Sup        XPDUTL
 ;10013  Sup        ENALL^DIK
 ;
 ; This POST install routine will re-index the ELIGIBILITY CHANGES #33.02
 ; multiple field .01 in the OTH ELIGIBILITY PATIENT file (#33)
 Q
 ;
EN ;Post install entry point
 ;
 I $D(^DGOTH(33,"F")) D  Q   ;don't re-index if "F" already exists
 . D BMES^XPDUTL(" The OTH ELIGIBILITY PATIENT file (#33) 'F' x-ref already exist.")
 . D BMES^XPDUTL(" No re-indexing necessary.")
 . D BMES^XPDUTL(" ")
 ;
 N DIK,DA,MES
 D BMES^XPDUTL(" Please be patient while I re-index ""F"" cross reference on OTH ELIGIBILITY")
 D BMES^XPDUTL(" PATIENT file (#33)")
 I +$P(^DGOTH(33,0),U,4)<1 D  Q
 . S MES(1)="  "
 . S MES(2)=" ------------------"
 . S MES(3)="  "
 . S MES(4)=" No records found in the OTH ELIGIBILITY PATIENT file (#33)"
 . S MES(5)="  "
 . S MES(6)=" Nothing to re-index."
 . S MES(7)="  "
 . S MES(8)="  "
 . D MES^XPDUTL(.MES)
 ;Only want to reindex the "F" x-ref
 S DIK(1)=".01^F"
 ;global root for Eligibility Changes multiple
 S DIK="^DGOTH(33,DA(1),2,"
 ;loop through OTH ELIGIBILITY PATIENT file and index entries
 F DA(1)=0:0 S DA(1)=$O(^DGOTH(33,DA(1))) Q:DA(1)'>0  D ENALL^DIK
 I $D(^DGOTH(33,"F")) D  Q
 . D BMES^XPDUTL(" The OTH ELIGIBILITY PATIENT file (#33) 'F' cross reference indexing was completed successfully.")
 Q
 ;
