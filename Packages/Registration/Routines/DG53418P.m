DG53418P ;ALB/GRR(EDS) - Add new Intermediae Medicine - LTC Treating Specialty;1/21/02
 ;;5.3;Registration;**418**;Aug 13, 1993
 ;
 ;
EN ;Add Intermediate Medicine - LTC Treating Specialties to the SPECIALITY file (#42.4)
 N DGI,DGERR,DGSPEC,DGIFN,DGQUES
 S DGIFN=0
 F DGI=1:1 S DGSPEC=$P($T(TRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 .D TSPEC
 .S DGQUES=$P(DGSPEC,U,9)
 .D FAC
 .Q
EN2 N DGI,DGMO
 D BMES^XPDUTL("     Selected MAS MOVEMENT TYPES will now be renamed")
 F DGI=1:1 S DGMO=$P($T(MVED+DGI),";;",2) Q:DGMO="QUIT"  D
 .D MOVEMT ;Edit movement type names
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
 I $G(XPDQUES(DGQUES))'=1 D  Q
 .D BMES^XPDUTL("     Answered NO to install question.  Specialty will not be added to FACILITY")
 .D MES^XPDUTL("     TREATING SPECIALTY File (#45.7).")
 .Q
 I +DGIFN<0 D  Q
 .D BMES^XPDUTL("     Treating specialty not found in SPECIALTY File (#42.4).  Cannot")
 .D MES^XPDUTL("     be added to FACILITY TREATING SPECIALTY File (#45.7).")
 .Q
 I DGERR=1 D  Q
 .D BMES^XPDUTL("      Answered YES to install question.  SPECIALITY File (#42.4) does not")
 .D MES^XPDUTL("     contain the expected PTF Code #.  Cannot update FACILITY TREATING")
 .D MES^XPDUTL("     SPECIALTY File (#45.7).")
 .Q
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
 S X=3020101
 D ^DIC
 S DA=+Y
 I +Y=-1 D MES^XPDUTL("     Effective date not added.") Q
 D MES^XPDUTL("     Effective date added.")
 S DIE=DIC
 S DR=".02///Y"
 D ^DIE
 Q
MOVEMT ;Edit Mas Movement Type Names
 N DGFILE,DGIEN,DGON,DGNN,FDAROOT
 S DGFILE=405.2
 S DGON=$P(DGMO,"^",1) ;Old Name
 S DGNN=$P(DGMO,"^",2) ;New Name
 S DGIEN=$$FIND1^DIC(DGFILE,,"QX",DGNN)
 I DGIEN>0 Q  ;New name already in file
 S DGIEN=$$FIND1^DIC(DGFILE,,"QX",DGON) ;Old Name
 I DGIEN'>0 D  ;Didn't find it in file
 .D BMES^XPDUTL("     Mas Movement Type '"_DGON_"' not found!")
 .D MES^XPDUTL("     Contact the Help Desk.")
 I DGIEN>0 D  ;entry found
 .S FDAROOT(DGFILE,DGIEN_",",.01)=DGNN
 .D FILE^DIE("","FDAROOT")
 .D BMES^XPDUTL("'"_DGON_"' renamed '"_DGNN_"'")
 Q
TRSP ;PTF code^Speciality^Print Name^Service^Ask Psych^Billing Bedsection^CDR^^Ques#
 ;;95^INTERMEDIATE MEDICINE - LTC^IM - LTC^I^N^INTERMEDIATE CARE^1415^^POS1
 ;;QUIT
MVED ;Original Movement Name^New Movement Name
 ;;READMISSION TO NHCU/DOMICILIARY^READMISSION TO IMLTC/NHCU/DOMICILIARY
 ;;TO NHCU FROM HOSP^TO IMLTC/NHCU FROM HOSP
 ;;TO NHCU FROM DOM^TO IMLTC/NHCU FROM DOM
 ;;VA NHCU TO CNH^VA IMLTC/NHCU TO CNH
 ;;DISCHARGE FROM NHCU/DOM WHILE ASIH^DISCHARGE FROM IMLTC/NHCU/DOM WHILE ASIH
 ;;QUIT
 Q
