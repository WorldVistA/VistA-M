IB20P529 ;ALB/SAB - POST-INSTALL IB*2.0*529 ;15-JUL-15
 ;;2.0;INTEGRATED BILLING;**529**;21-MAR-94;Build 49
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ;This will reindex 364.1 for the updated indexes
 ;
 D BMES^XPDUTL(" Post-install for IB*2.0*529 Starting.")
 ;
 D REINDX   ; Re-index the new FDATE array for 364.1,1.01
 ;
 D BMES^XPDUTL(" Post-install for IB*2.0*529 Complete.")
 ;
 Q
 ;
REINDX ;
 ;
 N DIK,DA
 ; index DATE FIRST SENT field in the EDI TRANSMISSION BATCH file
 D MES^XPDUTL("      >> Removing old ""FDATE"" xref for file 364.1 ...")
 K ^IBA(364.1,"FDATE") ; clear old index if it exists
 D MES^XPDUTL("      >> Rebuilding ""FDATE"" xref for file 364.1 ...")
 S DIK(1)="1.01^FDATE",DIK="^IBA(364.1," D ENALL^DIK
 D MES^XPDUTL("      >> Completed Rebuilding ""FDATE"" xref for file 364.1 ...")
 Q
 ;
