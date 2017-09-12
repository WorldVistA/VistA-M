DG53683P ;ALB/DHH - Add NURSING HOME TREATING SPECIALTIES ; 11/01/05
 ;;5.3;Registration;**683**;Nov 1, 2005
 ;base program: DG53176P
 ;
EN ;Add Treating Specialties to the SPECIALITY file (#42.4)
 N DGI,DGERR,DGSPEC,DGIFN,DGQUES
 S DGIFN=0
 F DGI=1:1 S DGSPEC=$P($T(TRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 .D TSPEC
 .S DGQUES=$P(DGSPEC,U,9)
 .D FAC
 .Q
 D EDIT
 D INACT80,INACT
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
 S DR="1///"_$P(DGSPEC,U,3)_";3///"_$P(DGSPEC,U,4)_";4///"_$P(DGSPEC,U,5)_";5///"_$P(DGSPEC,U,6)_";6///"_$P(DGSPEC,U,7)
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
 S X=3060701
 D ^DIC
 S DA=+Y
 I +Y=-1 D MES^XPDUTL("     Effective date not added.") Q
 D MES^XPDUTL("     Effective date added.")
 S DIE=DIC
 S DR=".02///Y"
 D ^DIE
 Q
INACT80 ;inactivate code 80
 N DA,DIE,DR,X
 S DIC="^DIC(42.4,80,""E"","
 S DA(1)=80
 S DIC(0)="LX"
 S DIC("P")=$P(^DD(42.4,10,0),"^",2)
 S X=3060802
 D ^DIC
 S DA=+Y
 D BMES^XPDUTL("  ")
 D BMES^XPDUTL("  ")
 D BMES^XPDUTL("  ")
 I +Y=-1 D BMES^XPDUTL(">>>Inactive date not added to 80-NHCU in the Specialty file.") Q
 D BMES^XPDUTL(">>>Inactive date added to 80-NHCU in the Specialty file.<<<")
 S DIE=DIC
 S DR=".02///N"
 D ^DIE
 ;
 ; -- check for NHCU 80 in the Facility Treating Specialty File (45.7
 ;    add inactivation date of 8/2/2006
 ;
 D BMES^XPDUTL("  ")
 D MES^XPDUTL("     FACILITY TREATING SPECIALTY FILE being checked to see if any entries are")
 D MES^XPDUTL("     pointing to 80-NHCU.  If so, they will be inactivated.>>>")
 N DAA F DAA=0:0 S DAA=$O(^DIC(45.7,"ASPEC",80,DAA)) Q:'DAA  D
 . N DIE,DR,TS,X S TS=""
 .S TS=$P($G(^DIC(45.7,DAA,0)),"^")
 .S DIC="^DIC(45.7,"_DAA_",""E"","
 .S DA(1)=DAA
 .S DIC(0)="LX"
 .S X=3060802
 .D ^DIC
 .S DA=+Y
 .I +Y=-1 D BMES^XPDUTL("     Inactive date not added to "_TS_" in the Facility Treating Specialty file.") Q
 . D BMES^XPDUTL("     Inactive date added to "_TS_" in the Facility Treating Specialty file.")
 .S DIE=DIC
 .S DR=".02///N"
 .D ^DIE
 Q
INACT ;inactivate mental health codes
 N DA,DIE,DR,X,MHCD
 F MHCD=70,71,76,77,75,90,84 D
 . S DIC="^DIC(42.4,"_MHCD_",""E"","
 . S DA(1)=MHCD
 . S DIC(0)="LX"
 . S DIC("P")=$P(^DD(42.4,10,0),"^",2)
 . S X=3060701
 . D ^DIC
 . S DA=+Y
 . I +Y=-1 D BMES^XPDUTL(">>>Inactive date not added to MH code "_MHCD_" in the Specialty file.") Q
 . D BMES^XPDUTL(">>>Inactive date added to MH code "_MHCD_" in the Specialty file.<<<")
 . S DIE=DIC
 . S DR=".02///N"
 . D ^DIE
 . ;
 . ;check for MH CODES in the Facility Treating Specialty File (45.7
 . ;add inactivation date of 7/1/2006
 . ;
 . D BMES^XPDUTL("  ")
 . D MES^XPDUTL("     FACILITY TREATING SPECIALTY FILE being checked to see if any entries are")
 . D MES^XPDUTL("     pointing to "_MHCD_".  If so, they will be inactivated.>>>")
 .N DAA F DAA=0:0 S DAA=$O(^DIC(45.7,"ASPEC",MHCD,DAA)) Q:'DAA  D
 .. N DIE,DR,TS,X S TS=""
 ..S TS=$P($G(^DIC(45.7,DAA,0)),"^")
 ..S DIC="^DIC(45.7,"_DAA_",""E"","
 ..S DA(1)=DAA
 ..S DIC(0)="LX"
 ..S X=3060701
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
TRSP ;PTF code^Speciality^Print Name^Service^Ask Psych^Billing Bedsection^CDR^^Ques#
 ;;64^NH SHORT STAY REHABILITATION^NH SS REHAB^NH^N^NURSING HOME CARE^1430^^
 ;;66^NH SHORT STAY RESTORATIVE^NH SS RESTOR^NH^N^NURSING HOME CARE^1430^^
 ;;67^NH SHORT STAY MAINTENANCE^NH SS MAINT^NH^N^NURSING HOME CARE^1430^^
 ;;68^NH SHORT STAY PSYCHIATRIC CARE^NH SS PSYCH^NH^N^NURSING HOME CARE^1430^^
 ;;69^NH SHORT STAY DEMENTIA CARE^NH SS DEMENTIA^NH^N^NURSING HOME CARE^1430^^
 ;;42^NH LONG STAY DEMENTIA CARE^NH LS DEMENTIA^NH^N^NURSING HOME CARE^1410^^
 ;;43^NH LONG STAY SKILLED NURSING^NH LS SKILL NUR^NH^N^NURSING HOME CARE^1410^^
 ;;44^NH LONG STAY MAINTENANCE CARE^NH LS MAINT^NH^N^NURSING HOME CARE^1410^^
 ;;45^NH LONG STAY PSYCHIATRIC CARE^NH LS PSYCH^NH^N^NURSING HOME CARE^1410^^
 ;;46^NH LONG STAY SPINAL CORD INJ^NH LS SPINAL^NH^N^NURSING HOME CARE^1410^^
 ;;47^NH RESPITE CARE (NHCU)^NH RC-NHCU^NH^N^^1430^^
 ;;QUIT
 ;
ETRSP ;;PTF code^Speciality^Print Name^Service^Ask Psych^Billing Bedsection^CDR
 ;;83^RESPITE CARE (MEDICINE)^RC-MEDICINE^RESPITE CARE^N^^1110^^
 ;;95^NH SHORT STAY SKILLED NURSING^NH SS SKILL^NH^N^NURSING HOME CARE^1430^^
 ;;96^NH HOSPICE^NH HOSPICE^NH^N^NURSING HOME CARE^1425^^
 ;;81^NH GEM NURSING HOME CARE^NH GEM NHC^NH^N^NURSING HOME CARE^1420^^
 ;;QUIT
 Q
