DG1074P ;MNTVBB/RS - TREATING SPECIALTIES UPDATE ; 1/12/2022 11:10am
 ;;5.3;Registration;**1074**;Aug 13, 1993;Build 4
 ;
 Q
EN ;Add Treating Specialties to the SPECIALTY file (#42.4)
 N DGI,DGERR,DGSPEC,DGIFN,DGQUES
 S DGIFN=0
 ;add new treating specialties
 F DGI=1:1 S DGSPEC=$P($T(TRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 .D TSPEC
 .S DGQUES=$P(DGSPEC,U,9)
 .D FAC
 .Q
 Q
TSPEC ;Add treating specialty to SPECIALTY File (#42.4)
 D BMES^XPDUTL(">>>"_$P(DGSPEC,U,2)_">>>")
 N DA,DGFILE,DGMULT,DIC,DIE,DGDA1,DINUM,DLAYGO,DR,X,Y
 S DIC="^DIC(42.4,"
 S DIC(0)="LX"
 S DINUM=$P(DGSPEC,U)
 S X=$P(DGSPEC,U,2)
 S DLAYGO=42.4
 D ^DIC
 S (DGIFN,DGDA1)=DGSPEC
 I +DGIFN=-1 D  Q
 .D MES^XPDUTL("     Entry not added to SPECIALTY File (#42.4).  No further updating will occur.")
 .D MES^XPDUTL("     Please contact Customer Service for assistance.")
 .Q
 D MES^XPDUTL("     Entry added to SPECIALTY File (#42.4).")
 D MES^XPDUTL("     Updating SPECIALTY File fields.")
 S DIE=DIC
 S DR=".01///"_$P(DGSPEC,U,2)_";1///"_$P(DGSPEC,U,3)_";3///"_$P(DGSPEC,U,4)_";4///"_$P(DGSPEC,U,5)_";5///"_$P(DGSPEC,U,6)_";6///"_$P(DGSPEC,U,7)_";7///"_$P(DGSPEC,U,10)
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
 S X=3221001
 D ^DIC
 S DA=+Y
 I +Y=-1 D MES^XPDUTL("     Effective date not added.") Q
 D MES^XPDUTL("     Effective date added.")
 S DIE=DIC
 S DR=".02///Y"
 D ^DIE
 Q
TRSP ;PTF CODE^SPECIALTY^PRINT NAME^SERVICE^ASK PSYCH^BILLING BEDSECTION^CDR/MPCR^^QUES#^AUSTIN PTF CODE
 ;;113^SPINAL CORD INJURY LTC CENTER^SCI LTC CENTER^SPINAL CORD INJURY^N^SPINAL CORD INJURY CARE^1116^^^1O
 ;;QUIT
