DVBA23P ;ALB/SEK CLEANUP POST-INS DVBA*2.7*23 ;10/02/98
 ;;2.7;AMIE;**23**;Apr 10, 1995
 ;
 ;This routine will be run as post-installation for patch DVBA*2.7*23.
 ;This cleanup will delete entries in the IVM PATIENT file (#301.5)
 ;pointing to non-existing or non-veteran entries in the PATIENT file
 ;(#2).  Corresponding entries in the IVM TRANSMISSION LOG file (#301.6)
 ;will also be deleted.
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DVBIEN","EN^DVBA23P",0)
 S %=$$NEWCP^XPDUTL("DVBCTR5")
 S %=$$NEWCP^XPDUTL("DVBCTR6")
 Q
 ;
EN ;begin processing
 ;
 ;go through the IVM PATIENT file finding entries pointing to non-
 ;existing or non-veteran entries in the PATIENT file.
 N DVBIEN,DVBCTR5,DVBCTR6
 ;
 D BMES^XPDUTL("  >> starting cleanup of IVM PATIENT and IVM TRANSMISSION LOG files")
 ;
 ;get value from checkpoints, previous run
 S DVBIEN=+$$PARCP^XPDUTL("DVBIEN")
 S DVBCTR5=+$$PARCP^XPDUTL("DVBCTR5")
 S DVBCTR6=+$$PARCP^XPDUTL("DVBCTR6")
 ;
 D LOOP
 D BMES^XPDUTL("    "_DVBCTR5_" entries deleted from IVM PATIENT file")
 D MES^XPDUTL("    "_DVBCTR6_" entries deleted from IVM TRANSMISSION LOG file")
 D BMES^XPDUTL("  >> cleanup done")
 Q
 ;
LOOP ;
 N %,DA,DIK,DVBIVMT,DFN,VAEL,VAERR
 F  S DVBIEN=$O(^IVM(301.5,DVBIEN)) Q:'DVBIEN  D
 .S DFN=+$G(^IVM(301.5,DVBIEN,0)) Q:'DFN
 .D ELIG^VADPT Q:VAEL(4)
 .S DVBIVMT=0
 .F  S DVBIVMT=$O(^IVM(301.6,"B",DVBIEN,DVBIVMT)) Q:'DVBIVMT  D
 ..S DA=DVBIVMT,DIK="^IVM(301.6," D ^DIK
 ..S DVBCTR6=DVBCTR6+1
 ..S %=$$UPCP^XPDUTL("DVBCTR6",DVBCTR6)
 .S DA=DVBIEN,DIK="^IVM(301.5," D ^DIK
 .S DVBCTR5=DVBCTR5+1
 .S %=$$UPCP^XPDUTL("DVBCTR5",DVBCTR5)
 .Q
 S %=$$UPCP^XPDUTL("DVBIEN",DVBIEN)
 Q
