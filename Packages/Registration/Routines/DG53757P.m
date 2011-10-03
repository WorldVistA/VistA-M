DG53757P ;ALB/MRY - Add/Rename SURGICAL SPECIALTIES ; 6/4/07 11:05am
 ;;5.3;Registration;**757**;Aug 13, 1993;Build 5
 ;
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your Programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 Q
 ;
ABRT ;Abort transport, but leave in ^XTMP
 S XPDABORT=2 Q
 ;
PRE ;pre-init
 ;kill off ^DD(45.01,3 field, refresh field found in Build
 ;inorder to remove SCREEN
 S DIK="^DD(45.01,",DA=3,DA(1)=45.01
 D ^DIK
 Q
 ;
POST ;post-init
 N DGI,DGSPEC
 D BMES^XPDUTL("Updating Surgical Specialty (#45.3) File.....")
 F DGI=1:1 S DGSPEC=$P($T(SURGSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 . D SURGTS
 Q
 ;
SURGTS ;Add/Rename to new surgical specialties
 D BMES^XPDUTL(">>>"_$P(DGSPEC,U,3)_">>>")
 ;if oldcode exists and newcode exits, then error.
 I $D(^DIC(45.3,"B",$P(DGSPEC,U))),$D(^DIC(45.3,"B",$P(DGSPEC,U,2))) D ERROR Q
 ;if no oldcode, then add newcode.
 I '$D(^DIC(45.3,"B",$P(DGSPEC,U))) D ADD
 ;if oldcode exists, then edit oldcode to newcode.
 I $D(^DIC(45.3,"B",$P(DGSPEC,U))) D EDIT
 Q
 ;
ERROR ;
 D MES^XPDUTL("    Entry not added to SURGICAL SPECIALTY File (#45.3).  No further updating will occur.")
 D MES^XPDUTL("    Please contact Customer Service for assistance.")
 Q
 ;
ADD ;add surgical specialty code
 N DIC,DIE,DGDA1,DLAYGO,DR,X,Y
 S DIC="^DIC(45.3,"
 S DIC(0)="LX"
 S X=$P(DGSPEC,U,2)
 S DLAYGO=45.3
 D ^DIC
 S DGDA1=Y
 I +DGDA1=-1 D  Q
 .D MES^XPDUTL("     Entry not added to SURGICAL SPECIALTY File (#45.3).  No furher updating will occur.")
 .D MES^XPDUTL("     Please contact Customer Service for assistance.")
 .Q
 I $P(DGDA1,U,3)'=1&($P(Y,U,2)'=$P(DGSPEC,U,2)) D  Q
 .D MES^XPDUTL("     Entry exists in SURGICAL SPECIALTY File (#45.3), but with a different PTF Code #.")
 .D MES^XPDUTL("     No further updating will occur.  Please review entry.")
 .Q 
 D MES^XPDUTL("     Entry "_$S($P(DGDA1,U,3)=1:"added to",1:"exists in")_" SURGICAL SPECIALTY File (#45.3).")
 D MES^XPDUTL("     Updating SURGICAL SPECIALTY File fields.")
 S DIE=DIC
 S DR=".01///"_$P(DGSPEC,U,2)_";1///"_$P(DGSPEC,U,3)
 S DA=+DGDA1
 D ^DIE
 Q
 ;
EDIT ;rename oldcode to newcode
 N DA,DIE,DR
 S DIE="^DIC(45.3,"
 S DIC(0)="X"
 S DA=$O(^DIC(45.3,"B",$P(DGSPEC,U),""))
 I +DA D
 .S DR=".01///"_$P(DGSPEC,U,2)
 .D ^DIE
 .D MES^XPDUTL("    Entry's code "_$P(DGSPEC,U)_" renamed to code "_$P(DGSPEC,U,2))
 .D MES^XPDUTL("    Updating SURGICAL SPECIALTY File fields.")
 Q
SURGSP ;;OldCode^NewCode^Specialty
 ;;500^48^CARDIAC SURGERY
 ;;501^49^TRANSPLANTATION
 ;;502^78^ANESTHESIOLOGY
 ;;QUIT
