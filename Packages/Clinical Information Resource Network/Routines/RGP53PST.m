RGP53PST ;BIR/PTD-RG*1*53 PATCH POST-INIT ROUTINE ;12/19/07
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**53**;30 Apr 99;Build 2
 ;
EN ;Delete the Primary View Reject Exceptions Query Global
 I $D(^XTMP("RGPVREJ")) D
 .K ^XTMP("RGPVREJ")
 .D BMES^XPDUTL(" Primary View Reject exception query global ^XTMP('RGPVREJ') deleted.")
 .D MES^XPDUTL(" This data will be placed in ^XTMP('RGPVREJ_ICN') in the future.")
 ;
 ;Delete the Primary View Display Query Global
 I $D(^XTMP("RGPVMPI")) D
 .K ^XTMP("RGPVMPI")
 .D BMES^XPDUTL(" Primary View Display query global ^XTMP('RGPVMPI') deleted.")
 .D MES^XPDUTL(" This data will be placed in ^XTMP('RGPVMPI_ICN') in the future.")
 D BMES^XPDUTL(" Post-install routine completed successfully.")
 Q
 ;
