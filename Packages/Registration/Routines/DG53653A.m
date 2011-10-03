DG53653A ;ALB/TDM,CKN - Patch DG*5.3*653 Post-Install Utility Routine ; 10/24/06 11:39am
 ;;5.3;Registration;**653**;AUG 13, 1993;Build 2
 Q
 ;
EN N DIE,DA,DR
 D MOD386          ;Edit file 38.6 entries
 D EP^DG53653U     ;Add file 38.6 entries
 D DELXREF         ;Remove cross references
 D HECMSG          ;Send Message to HEC Legacy
 Q
 ;
MOD386 ; Update entry in INCONSISTENT DATA ELEMENTS file (#38.6)
 N ERR
 F RULE=4,7,9,11,13,15,16,19,24,29,30,31,34,60,72,74,75,76,78,81,83,85,86 D
 . D BMES^XPDUTL("Modifying entry #"_RULE_" in 38.6 file.")
 . S DIE=38.6,DA=$$FIND1^DIC(DIE,"","X",RULE)
 . I 'DA D MES^XPDUTL("    *** Entry not found! ***") Q
 . S DR="6////1" D ^DIE
 . D MES^XPDUTL("    *** Update Complete ***")
 D BMES^XPDUTL("")
 Q
 ;
DELXREF ;Delete x-ref and indexes
 N ZINDX
 D BMES^XPDUTL(">>> Deleting ADELBAI index from PATIENT File #2")
 D DELIXN^DDMOD(2,"ADELBAI")
 Q
HECMSG ; Send message to HEC Legacy that install is complete.
 N SITE,STATN,PRODFLG,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),U,3)
 S PRODFLG=$$GET1^DIQ(869.3,"1,",.03,"I")="P"
 S XMDUZ="EVC I1 Install"
 S XMSUB=XMDUZ_" - "_STATN_" (DG*5.3*653)"
 S:PRODFLG XMY("S.IVMB*2*860 MESSAGE@IVM.MED.VA.GOV")=""
 S:'PRODFLG XMY(DUZ)=""
 S XMTEXT="MSG("
 S $P(MSG(1),U)="IVMB*2*860"
 S $P(MSG(1),U,2)=STATN
 S $P(MSG(1),U,3)="DG*5.3*653 "_$$FMTE^XLFDT($$NOW^XLFDT(),"5D")
 S $P(MSG(1),U,4)=PRODFLG
 D ^XMD
 D BMES^XPDUTL("    *** Install Message Sent to HEC Legacy ***")
 Q
