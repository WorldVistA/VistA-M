DG53176P ;ALB/MM - Add new Observation Treating Specialities;3/17/98
 ;;5.3;Registration;**176**;Aug 13, 1993
 ;
 ;
EN ;Add Observation Treating Specialties to the SPECIALITY file (#42.4)
 N DGI,DGERR,DGSPEC,DGIFN,DGQUES
 S DGIFN=0
 F DGI=1:1 S DGSPEC=$P($T(TRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 .D TSPEC
 .S DGQUES=$P(DGSPEC,U,9)
 .D FAC
 .Q
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
 S X=2980505
 D ^DIC
 S DA=+Y
 I +Y=-1 D MES^XPDUTL("     Effective date not added.") Q
 D MES^XPDUTL("     Effective date added.")
 S DIE=DIC
 S DR=".02///Y"
 D ^DIE
 Q
TRSP ;PTF code^Speciality^Print Name^Service^Ask Psych^Billing Bedsection^CDR^^Ques#
 ;;24^MEDICAL OBSERVATION^MED OBSERVATION^M^N^GENERAL MEDICAL CARE^1110^^POS1
 ;;65^SURGICAL OBSERVATION^SUR OBSERVATION^S^N^SURGICAL CARE^1210^^POS2
 ;;94^PSYCHIATRIC OBSERVATION^PSY OBSERVATION^P^Y^PSYCHIATRIC CARE^1310^^POS3
 ;;18^NEUROLOGY OBSERVATION^NEU OBSERVATION^NE^N^NEUROLOGY^1111^^POS4
 ;;36^BLIND REHAB OBSERVATION^BR OBSERVATION^B^N^BLIND REHABILITATION^1115^^POS5
 ;;23^SPINAL CORD INJURY OBSERVATION^SCI OBSERVATION^SCI^N^SPINAL CORD INJURY CARE^1116^^POS6
 ;;41^REHAB MEDICINE OBSERVATION^RM OBSERVATION^R^N^REHABILITATION MEDICINE^1113^^POS7
 ;;QUIT
 Q
