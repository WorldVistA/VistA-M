DG53174P ;ALB/SCK - DG*5.3*174 POST-INSTALL; 4/6/98
 ;;5.3;Registration;**174**;Aug 13, 1993
 ;
EN ; This routine will delete the FISCAL YEAR SUBFILE, #40.803, of the
 ; MEDICAL CENTER DIVISION File, #40.8.  This sub file has been marked
 ; for deletion
 ;
 D BMES^XPDUTL("The FISCAL YEAR SUB-FIELD, Field #20, of the MEDICAL CENTER DIVISION")
 D MES^XPDUTL("File, #40.8, has been marked for deletion.  This patch, as part of the")
 D MES^XPDUTL("Year 2000 renovations, will delete this subfile, #40.803, and any data")
 D MES^XPDUTL("and associated templates")
 ;
 D DELDD
 D BMES^XPDUTL(">>> Deletion of sub-file complete.")
 Q
 ;
DELDD ;
 N DIU
 S DIU=40.803,DIU(0)="DST" D EN^DIU2 K DIU
 Q
