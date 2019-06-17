DG53P813 ;ALB/JRC - FY10 TREATING SPECIALTIES ; 3/12/07 7:21am
 ;;5.3;Registration;**813**;Aug 13, 1993;Build 23
 ;
 Q
EN ;Add Treating Specialties to the SPECIALITY file (#42.4)
 N DGI,DGERR,DGSPEC,DGIFN,DGQUES
 S DGIFN=0
 ;add new treating specialties
 F DGI=1:1 S DGSPEC=$P($T(TRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 .D TSPEC
 .S DGQUES=$P(DGSPEC,U,9)
 .D FAC
 .Q
 ;edit existing treating specialties
 D EDIT
 ;inactivate existing treating specialties
 D INACT
 ;edit existing surgical specialties
 ;D EDIT^DG53813R
 Q
TSPEC ;Add treating specialty to SPECIALTY File (#42.4)
 D BMES^XPDUTL(">>>"_$P(DGSPEC,U,2)_">>>")
 N DA,DGFILE,DGMULT,DIC,DIE,DGDA1,DINUM,DLAYGO,DR,X,Y
 S DGERR=0
 S DIC="^DIC(42.4,"
 S DIC(0)="LX"
 S DINUM=$P(DGSPEC,U)
 S X=$P(DGSPEC,U,2)
 S DLAYGO=42.4
 D ^DIC
 S (DGIFN,DGDA1)=Y
 I +DGIFN=-1 D  Q
 .D MES^XPDUTL("     Entry not added to SPECIALTY File (#42.4).  No further updating will occur.")
 .D MES^XPDUTL("     Please contact Customer Service for assistance.")
 .Q
 I $P(DGIFN,U,3)'=1&(+DGIFN'=$P(DGSPEC,U)) D  Q
 .D MES^XPDUTL("     Entry exists in SPECIALTY File (#42.4), but with a different PTF Code #.")
 .D MES^XPDUTL("     No further updating will occur.  Please review entry.")
 .S DGERR=1
 .Q 
 D MES^XPDUTL("     Entry "_$S($P(DGIFN,U,3)=1:"added to",1:"exists in")_" SPECIALTY File (#42.4).")
 D MES^XPDUTL("     Updating SPECIALTY File fields.")
 S DIE=DIC
 S DR="1///"_$P(DGSPEC,U,3)_";3///"_$P(DGSPEC,U,4)_";4///"_$P(DGSPEC,U,5)_";5///"_$P(DGSPEC,U,6)_";6///"_$P(DGSPEC,U,7)_";7///"_$P(DGSPEC,U,10)
 S DA=+DGIFN
 D ^DIE
 S DGFILE=42.4
 S DGMULT=10
 S DIC="^DIC(42.4,"_+DGIFN_",""E"","
 D MULT
 Q
FAC ;Add treating specialty to Facility Treating Specialty file (#45.7)
 N DA,DGFILE,DGMULT,DIC,DIE,DLAYGO,DR,X,Y
 S DIC="^DIC(45.7,"
 S DIC(0)="LXZ"
 S DLAYGO=45.7
 S X=$P(DGSPEC,U,2)
 D ^DIC
 S DGDA1=Y
 I +DGDA1=-1 D BMES^XPDUTL("     Entry not added to FACILITY TREATING SPECIALTY File(#45.7).") Q
 I $P(DGDA1,U,3)'=1&($P(Y(0),U,2)'=$P(DGSPEC,U)) D  Q
 .D BMES^XPDUTL("     Entry exists in FACILITY TREATING SPECIALTY File (#45.7), but with")
 .D MES^XPDUTL("     a different PTF Code #.  No further updating will occur.")
 .D MES^XPDUTL("     Please review entry.")
 .Q
 D BMES^XPDUTL("     Entry "_$S($P(DGDA1,U,3)=1:"added to",1:"exists in")_" FACILITY TREATING SPECIALTY File (#45.7).")
 D MES^XPDUTL("     Updating SPECIALTY field...")
 S DIE=DIC
 S DA=+DGDA1
 S DR="1////"_$P(DGSPEC,U)
 D ^DIE
 S DGFILE=45.7
 S DGMULT=100
 S DIC="^DIC(45.7,"_+DGDA1_",""E"","
 D MULT
 Q
MULT ;Add Effective Date
 N DA,DIE,DR
 S DA(1)=+DGDA1
 S DIC(0)="LX"
 S DIC("P")=$P(^DD(DGFILE,DGMULT,0),"^",2)
 S X=3091001
 D ^DIC
 S DA=+Y
 I +Y=-1 D MES^XPDUTL("     Effective date not added.") Q
 D MES^XPDUTL("     Effective date added.")
 S DIE=DIC
 S DR=".02///Y"
 D ^DIE
 Q
INACT ;inactivate treating specialties
 N DA,DIE,DR,X,DGTSP
 F DGTSP=28,29,38 D
 . S DIC="^DIC(42.4,"_DGTSP_",""E"","
 . S DA(1)=DGTSP
 . S DIC(0)="LX"
 . S DIC("P")=$P(^DD(42.4,10,0),"^",2)
 . S X=3091001
 . D ^DIC
 . S DA=+Y
 . I +Y=-1 D BMES^XPDUTL(">>>Inactive date not added to TS code "_DGTSP_" in the Specialty file.<<<") Q
 . D BMES^XPDUTL(">>>Inactive date added to TS code "_DGTSP_" in the Specialty file.<<<")
 . S DIE=DIC
 . S DR=".02///N"
 . D ^DIE
 . ;check for CODES in the Facility Treating Specialty File (45.7
 . ;add inactivation date of 10/1/2009
 . D BMES^XPDUTL("  ")
 . D MES^XPDUTL("     FACILITY TREATING SPECIALTY FILE being checked to see if any entries are")
 . D MES^XPDUTL("     pointing to "_DGTSP_".  If so, they will be inactivated.>>>")
 .N DAA F DAA=0:0 S DAA=$O(^DIC(45.7,"ASPEC",DGTSP,DAA)) Q:'DAA  D
 .. N DIE,DR,TS,X S TS=""
 ..S TS=$P($G(^DIC(45.7,DAA,0)),"^")
 ..S DIC="^DIC(45.7,"_DAA_",""E"","
 ..S DA(1)=DAA
 ..S DIC(0)="LX"
 ..S X=3091001
 ..D ^DIC
 ..S DA=+Y
 ..I +Y=-1 D BMES^XPDUTL("     Inactive date not added to "_TS_"in the Facility Treating Specialty file.") Q
 ..D BMES^XPDUTL("     Inactive date added to "_TS_" in the Facility Treating Specialty file.<<<")
 ..S DIE=DIC
 ..S DR=".02///N"
 ..D ^DIE
 Q
EDIT ;Edit treating specialties
 ;
 N DS,DIE,DR,DGI
 S DIE="^DIC(42.4,"
 S DIC(0)="LX"
 F DGI=1:1 S DGSPEC=$P($T(ETRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 . S DGERR=0
 . S DA=$P(DGSPEC,U)
 . S DR=".01///"_$P(DGSPEC,U,2)_";1///"_$P(DGSPEC,U,3)_";3///"_$P(DGSPEC,U,4)_";4///"_$P(DGSPEC,U,5)_";5///"_$P(DGSPEC,U,6)_";6///"_$P(DGSPEC,U,7)
 . D ^DIE
 . D BMES^XPDUTL("  ")
 . D BMES^XPDUTL("  ")
 . D BMES^XPDUTL(">>>"_$P(DGSPEC,U)_" code updated to "_$P(DGSPEC,U,2)_" in the Specialty file.>>>")
 N DS,DIE,DR,DGI,DGII,DGSP,CNT,DGSPEC,DGSPEC1
 S DIE="^DIC(45.7,"
 S DIC(0)="LX"
 F DGI=1:1 S DGSPEC=$P($T(ETRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 . S DGERR=0
 . S DGSP=$P(DGSPEC,U)
 . S CNT=0,DGSPEC1=0 F DGII=0:0 S DGSPEC1=$O(^DIC(45.7,"ASPEC",DGSP,DGSPEC1)) Q:'DGSPEC1  S CNT=CNT+1 D
 .. I CNT=1 D
 ... I $$ACTIVE^DGACT(45.7,DGSPEC1)'=1 S CNT=0 Q
 ... S DA=DGSPEC1,DR=".01///"_$P(DGSPEC,U,2)_";99///@"
 ... D BMES^XPDUTL("     "_$P(^DIC(45.7,DGSPEC1,0),U)_" name has been changed to "_$P(DGSPEC,U,2)_" in the Facility Treating Specialty file.")
 ... D ^DIE
 .. E  D
 ... S TS=""
 ... S TS=$P($G(^DIC(45.7,DGSPEC1,0)),"^")
 ... D BMES^XPDUTL("     Please review Facility Treating Specialty "_TS_".  The entry name may need changing or entry may need inactivating since more than one entry points to "_$P(DGSPEC,U,2)_" in the Specialty file.<<<")
 Q
TRSP ;PTF CODE^SPECIALTY^PRINT NAME^SERVICE^ASK PSYCH^BILLING BEDSECTION^CDR/MPCR^^QUES#^AUSTIN PTF CODE
 ;;105^HOSPICE FOR ACUTE CARE^^MEDICINE^N^GENERAL MEDICAL CARE^1110^^^1F
 ;;106^VASCULAR^^SURGERY^N^SURGICAL CARE^1210^^^1G
 ;;107^MEDICAL STEP DOWN^^MEDICINE^N^GENERAL MEDICAL CARE^1110^^^1H
 ;;108^ED OBSERVATION^^MEDICINE^N^GENERAL MEDICAL CARE^1150^^^1J
 ;;QUIT
ETRSP ;;PTF CODE^SPECIALTY^PRINT NAME^SERVICE^ASK PSYCH^BILLING BEDSECTION^CDR/MPCR
 ;;18^NEUROLOGY OBSERVATION^^MEDICINE^NO^NEUROLOGY^1151^^
 ;;23^SPINAL CORD INJURY OBSERVATION^^SPINAL CORD INJURY^NO^SPINAL CORD INJURY CARE^1156^^
 ;;24^MEDICAL OBSERVATION^^MEDICINE^NO^GENERAL MEDICAL CARE^1150^^
 ;;36^BLIND REHAB OBSERVATION^^REHAB MEDICINE^NO^BLIND REHABILITATION^1155^^
 ;;41^REHAB MEDICINE OBSERVATION^^REHAB MEDICINE^NO^REHABILITATION MEDICINE^1153^^
 ;;65^SURGICAL OBSERVATION^^SURGERY^NO^SURGICAL CARE^1250^^
 ;;94^PSYCHIATRIC OBSERVATION^^PSYCHIATRY^YES^PSYCHIATRIC CARE^1350^^
 ;;QUIT
 Q
