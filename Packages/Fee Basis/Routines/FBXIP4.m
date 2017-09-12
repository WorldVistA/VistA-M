FBXIP4 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;6/21/1999
 ;;3.5;FEE BASIS;**4**;JAN 30, 1995
 Q
 ;
PR ; pre-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 F FBX="PRG" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP4")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 F FBX="MOD" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP4")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
PRG ; Purge Old RBRVS Fee Schedules (pre-install)
 N DA,DIK,ENC,FBDEL,FBMT,FBYR,FBYRC
 ;
 S FBYRC=1997 ; ***earliest year that will be retained
 ;
 ; determine if there is any data prior to year FBYRC
 D BMES^XPDUTL("  Looking for old (before "_FBYRC_") RBRVS fee schedules to purge...")
 S DA=$O(^FB(162.99,"B","MEDICINE",0))
 S FBDEL=0,FBYR=""
 I DA>0 D
 . F  S FBYR=$O(^FB(162.99,DA,"CY","B",FBYR)) Q:FBYR=""!(FBYR'<FBYRC)  D
 . . D MES^XPDUTL("    RBRVS fee schedule for "_FBYR_" was found.")
 . . S FBDEL=1
 I 'FBDEL D MES^XPDUTL("    No old RBRVS fee schedules were found.") Q
 ;
 D MES^XPDUTL("  Purging old data")
 ;
 ; delete 162.96 data (GPCI) prior to year FBYRC
 ; init variables
 S FBC("TOT")=$P($G(^FB(162.96,0)),U,4) ; total # of entries to process
 I FBC("TOT")=0 S FBC("TOT")=1 ; avoid divide by zero error
 S FBC("ENT")=0 ; count of evaluated entries
 S XPDIDTOT=FBC("TOT") ; set total for status bar
 S FBC("UPD")=5  ; initial % required to update status bar
 D MES^XPDUTL("    from file 162.96...")
 K DA S DA(1)=0 F  S DA(1)=$O(^FB(162.96,DA(1))) Q:'DA(1)  D
 . S FBC("ENT")=FBC("ENT")+1
 . S FBC("%")=FBC("ENT")*100/FBC("TOT") ; calculate % complete
 . ; check if status bar should be updated
 . I FBC("%")>FBC("UPD") D
 . . D UPDATE^XPDID(FBC("ENT")) ; update status bar
 . . S FBC("UPD")=FBC("UPD")+5 ; increase update criteria by 5%
 . S DA=0 F  S DA=$O(^FB(162.96,DA(1),"CY",DA)) Q:'DA  D
 . . S FBYR=$P($G(^FB(162.96,DA(1),"CY",DA,0)),U)
 . . I FBYR<FBYRC S DIK="^FB(162.96,"_DA(1)_",""CY""," D ^DIK
 ;
 ; init variables
 S FBC("TOT")=$P($G(^FB(162.97,0)),U,4) ; total # of entries to process
 I FBC("TOT")=0 S FBC("TOT")=1 ; avoid divide by zero error
 S FBC("ENT")=0 ; count of evaluated entries
 S XPDIDTOT=FBC("TOT") ; set total for status bar
 S FBC("UPD")=5  ; initial % required to update status bar
 D MES^XPDUTL("    from file 162.97...")
 ; delete 162.97 data (CPT RVU) prior to year FBYRC
 K DA S DA(1)=0 F  S DA(1)=$O(^FB(162.97,DA(1))) Q:'DA(1)  D
 . S FBC("ENT")=FBC("ENT")+1
 . S FBC("%")=FBC("ENT")*100/FBC("TOT") ; calculate % complete
 . ; check if status bar should be updated
 . I FBC("%")>FBC("UPD") D
 . . D UPDATE^XPDID(FBC("ENT")) ; update status bar
 . . S FBC("UPD")=FBC("UPD")+5 ; increase update criteria by 5%
 . S DA=0 F  S DA=$O(^FB(162.97,DA(1),"CY",DA)) Q:'DA  D
 . . S FBYR=$P($G(^FB(162.97,DA(1),"CY",DA,0)),U)
 . . I FBYR<FBYRC S DIK="^FB(162.97,"_DA(1)_",""CY""," D ^DIK
 ;
 ; delete 162.98 data (MOD LEVEL TABLE) prior to year FBYRC
 D MES^XPDUTL("    from file 162.98...")
 K DA S DIK="^FB(162.98,",FBMT=""
 F  S FBMT=$O(^FB(162.98,"B",FBMT)) Q:FBMT=""!($P(FBMT,"-")'<FBYRC)  D
 . S DA=0 F  S DA=$O(^FB(162.98,"B",FBMT,DA)) Q:'DA  D ^DIK
 ;
 ; delete 162.99 data (CONVERSION FACTOR) prior to year FBYRC
 D MES^XPDUTL("    from file 162.99...")
 K DA S DA(1)=0 F  S DA(1)=$O(^FB(162.99,DA(1))) Q:'DA(1)  D
 . S DA=0 F  S DA=$O(^FB(162.99,DA(1),"CY",DA)) Q:'DA  D
 . . S FBYR=$P($G(^FB(162.99,DA(1),"CY",DA,0)),U)
 . . I FBYR<FBYRC S DIK="^FB(162.99,"_DA(1)_",""CY""," D ^DIK
 ;
 D MES^XPDUTL("  Purge completed.")
 Q
 ;
MOD ; Move CPT Modifier data (post-install)
 ;
 ; If field 39 not CPT MODIFER then already done
 I $$GET1^DID(162.03,39,"","LABEL")'="CPT MODIFIER" D  Q
 . D BMES^XPDUTL("  CPT MODIFIER data already moved. Skipping step.")
 ;
 ; loop through file 162 - move data from 39 into new multiple
 D BMES^XPDUTL("  Moving CPT MODIFIER data in file 162...")
 ; init variables
 S FBC("TOT")=$P($G(^FBAAC(0)),U,4) ; total # of patients to process
 I FBC("TOT")=0 S FBC("TOT")=1 ; avoid divide by zero error
 S FBC("PAT")=0 ; count of evaluated patients
 S FBC("MOD")=0 ; count of modifiers moved
 S XPDIDTOT=FBC("TOT") ; set total for status bar
 S FBC("UPD")=5  ; initial % required to update status bar
 ; loop thru patients
 S FBD0=0 F  S FBD0=$O(^FBAAC(FBD0)) Q:'FBD0  D
 . S FBC("PAT")=FBC("PAT")+1
 . S FBC("%")=FBC("PAT")*100/FBC("TOT") ; calculate % complete
 . ; check if status bar should be updated
 . I FBC("%")>FBC("UPD") D
 . . D UPDATE^XPDID(FBC("PAT")) ; update status bar
 . . S FBC("UPD")=FBC("UPD")+5 ; increase update criteria by 5%
 . ; loop thru vendors
 . S FBD1=0 F  S FBD1=$O(^FBAAC(FBD0,1,FBD1)) Q:'FBD1  D
 . . ; loop thru initial treatment date
 . . S FBD2=0 F  S FBD2=$O(^FBAAC(FBD0,1,FBD1,1,FBD2)) Q:'FBD2  D
 . . . ; loop thru service provided
 . . . S FBD3=0
 . . . F  S FBD3=$O(^FBAAC(FBD0,1,FBD1,1,FBD2,1,FBD3)) Q:'FBD3  D
 . . . . ; get single valued modifier
 . . . . S FBMOD=$P($G(^FBAAC(FBD0,1,FBD1,1,FBD2,1,FBD3,2)),U,7)
 . . . . Q:'FBMOD  ; nothing to move
 . . . . Q:$O(^FBAAC(FBD0,1,FBD1,1,FBD2,1,FBD3,"M",0))  ; unexpected
 . . . . ; put modifier in multiple field
 . . . . S ^FBAAC(FBD0,1,FBD1,1,FBD2,1,FBD3,"M",0)="^162.06P^1^1"
 . . . . S ^FBAAC(FBD0,1,FBD1,1,FBD2,1,FBD3,"M",1,0)=FBMOD
 . . . . S ^FBAAC(FBD0,1,FBD1,1,FBD2,1,FBD3,"M","B",FBMOD,1)=""
 . . . . ; delete modifier from old location
 . . . . S $P(^FBAAC(FBD0,1,FBD1,1,FBD2,1,FBD3,2),U,7)=""
 . . . . S FBC("MOD")=FBC("MOD")+1
 ;
 ; delete field 39 from data dictionary
 S DIK="^DD(162.03,",DA=39,DA(1)=162.03 D ^DIK
 ;
 ; report results
 D MES^XPDUTL("    "_FBC("PAT")_" FEE BASIS PATIENTs were evaluated.")
 D MES^XPDUTL("    "_FBC("MOD")_" CPT Modifiers were moved.")
 Q
 ;
VPC ; Add Vendor Participation Codes (post-install)
 ; NOTE: This section will not be performed by patch FB*3.5*4 and
 ; label has been VPC removed from the post-install call backs.
 Q  ; quit statement added to prevent execution of code
 N FBFDA,FBFDAIEN,FBI,FBX,FBY0
 D BMES^XPDUTL("  Adding new participation codes...")
 F FBI=1:1 S FBX=$P($T(VPCT+FBI),";",3) Q:$P(FBX,U)=""  D
 . S FBY0=$G(^FBAA(161.81,$P(FBX,U),0))
 . I $P(FBY0,U)]"",$P(FBY0,U)=$P(FBX,U,2) Q  ; already there
 . I $P(FBY0,U)]"",$P(FBY0,U)'=$P(FBX,U,2) D  Q  ; unexpected value
 . . D MES^XPDUTL("    Error adding "_$P(FBX,U,2)_" ("_$P(FBX,U,3)_")")
 . . D MES^XPDUTL("    because local '"_$P(FBY0,U)_"' is in it's place.")
 . S FBFDA(161.81,"+"_$P(FBX,U)_",",.01)=$P(FBX,U,2)
 . S FBFDA(161.81,"+"_$P(FBX,U)_",",1)=$P(FBX,U,3)
 . S FBFDAIEN($P(FBX,U))=$P(FBX,U)
 I $D(FBFDA) D UPDATE^DIE("E","FBFDA","FBFDAIEN") D MSG^DIALOG()
 Q
VPCT ;;Participation Code Data (internal entry number^#.01 field^#1 field)
 ;;15^PHYSICAL/OCCUPATIONAL THERAPIST^15;
 ;;16^PHYSICIAN ASSISTANT^16;
 ;;17^NURSE PRACTITIONER^17;
 ;;18^CLINICAL NURSE SPECIALIST^18;
 ;;19^CERTIFIED REGISTERED NURSE ANESTHETIST^19;
 ;;20^NURSE MIDWIFE^20;
 ;;21^CLINICAL PSYCHOLOGIST^21;
 ;;22^CLINICAL SOCIAL WORKER^22;
 ;;; end of vendor participation codes
 ;FBXIP4
