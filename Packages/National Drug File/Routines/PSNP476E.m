PSNP476E ;BIR/PWC - Environment check for VA PRODUCT FILE ;08/03/16
 ;;4.0;NATIONAL DRUG FILE;**476**; 30 Oct 98;Build 26
 ;
 ; This routine will delete the REDUCED COPAY fields that might exist
 ; at field #45 in the VA PRODUCT FILE #50.68.
 ; FMCT project replaced the non-used, but released fields for 
 ; REDUCED COPAY and added COPAY TIER. When sending the updated DD files,
 ; sites that have REDUCED COPAY installed will have an issue with new fields
 ; being defined. This routine will take care of that problem.
 Q
 ;
EN ;
 D BMES^XPDUTL("Removing old unused fields to be replaced")
 S DIU=50.6845,DIU(0)="S" D EN^DIU2 K DIU
 D BMES^XPDUTL("Process complete for removal of old data fields")
 Q
