PSO457P ;HEC/hrub - Post-Init for PSO*7*457 ;31 May 2019 14:27:27
 ;;7.0;OUTPATIENT PHARMACY;**457**;March 2019;Build 116
 ;
 Q
 ;
POST ; post-init entry point
 ;
 I $D(^DIR("A")) K ^DIR("A")  ; clean up any residue
 ;
 D  ; update ^XTMP storage if found
 . D BMES^XPDUTL("Checking for Clozapine Registry data in ^XTMP. "_$$FMTE^XLFDT($$NOW^XLFDT))
 . I '$D(^XTMP("PSJ CLOZ",0)) D BMES^XPDUTL("No Clozapine Registry data found in ^XTMP.  No action taken.") Q
 . D XTMPZRO^PSOCLOU D BMES^XPDUTL("Clozapine Registry data in ^XTMP updated.")
 ;
 Q
 ;
