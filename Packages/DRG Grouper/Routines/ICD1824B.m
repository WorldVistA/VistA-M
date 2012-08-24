ICD1824B ;ALB/ESD/JAT - FY 2007 UPDATE; 6/22/01 2:43pm ; 6/29/05 3:30pm
 ;;18.0;DRG Grouper;**24**;Oct 13,2000;Build 5
 ; - UPD01: Update weights & ALOS for FY 2007 for all DRGs
 ; - UPD02: update 80.272 multiple with new table routines for FY 2007 for most DRGs
 ; - INACTDRG: inactivate certain DRGs
 ; - DRGTITLE: update title of certain DRGs       
 Q
 ;
UPDTDRG ;
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J
 N ICDREF,ICDDRG,ICDFDA,IEN
 ;D UPD01 - (waiting on CMS - must update each entry in ICD1824X,Y,Z
 D UPD02
 Q
 ;
 ;
UPD01 ;- Load FY 2007 weights & ALOS into DRG file (#80.2)
 S FYR=3070000
 D BMES^XPDUTL(">>>  Adding FY 2007 Weights & ALOS to all DRGs...")
 ; check if already done in case patch being re-installed
 Q:$D(^ICD(579,"FY",3070000,0))
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1824X),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1824Y),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1824Z),";;",2,99) Q:$E(WT,1,4)="EXIT"  D SETVAR,FY,MORE
 S ^ICD("AFY",3070000)=""
 D MES^XPDUTL(">>>  ...completed.")
 D MES^XPDUTL("")
 Q
 ;
 ;
FY ;- Set FY multiple with FYR stats
 ; check if already done in case patch being re-installed
 I $D(^ICD(DRG,"FY",FYR,0)) Q
 S $P(^ICD(DRG,"FY",FYR,0),"^",1,4)=FYR_"^"_ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",9)=ICDLOS
 I '$D(^ICD(DRG,"FY",0)) S ^ICD(DRG,"FY",0)="^80.22D^"_FYR_"^1" Q
 S ICDCNT="" F J=0:1 S ICDCNT=$O(^ICD(DRG,"FY",ICDCNT)) Q:ICDCNT=""
 S $P(^ICD(DRG,"FY",0),"^",3,4)=FYR_"^"_J
 Q
 ;
 ;
SETVAR ;- Set variables
 S DRG=$P(WT,U),ICDLOW=1,ICDHIGH=99,ICDWWU=$P(WT,U,2),ICDLOS=$P(WT,U,3)
DRG S ICDLOW=$P(^ICD(DRG,"FY",3060000,0),U,3),ICDHIGH=$P(^ICD(DRG,"FY",3060000,0),U,4)
 Q
 ;
 ;
MORE ;- Set zero node with FY 2007 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 Q
 ;
UPD02 ; create new entries for FY 2007 versioning
 S DRG=0
 F  S DRG=$O(^ICD(DRG)) Q:'DRG  D
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD(DRG,2,"B",3061001))
 .;one-time code because not done in FY2006
 .I DRG<57&($D(^ICD(DRG,2,"B",3041001))) D
 ..S ICDREF="ICDTLB1B"
 ..S ICDFDA(80.2,"?1,",.01)="`"_DRG
 ..S ICDFDA(80.271,"+2,?1,",.01)=3051001
 ..S ICDFDA(80.271,"+2,?1,",1)=ICDREF
 ..D UPDATE^DIE("","ICDFDA") K ICDFDA
 .;end of one-time code
 .; it's also already done if DRG new this year 
 .Q:DRG>559&($D(^ICD(DRG,2)))
 .S (ICDDRG,ICDREF)=""
 .S ICDDRG=$P($G(^ICD(DRG,0)),U,1)
 .;"A"= FY 2005 "B"=FY 2006 "C"=FY 2007, etc.
 .S IEN=0,IEN=$O(^ICD(DRG,2,"B",3051001,IEN))
 .I IEN S ICDREF=$P(^ICD(DRG,2,IEN,0),U,3),ICDREF=$E(ICDREF,1,7)_"C"
 .;Create FY 2007 reference table entries used for FY 2007
 .I ICDDRG'="",ICDREF'="" D
 ..S ICDFDA(80.2,"?1,",.01)="`"_DRG
 ..S ICDFDA(80.271,"+2,?1,",.01)=3061001
 ..S ICDFDA(80.271,"+2,?1,",1)=ICDREF
 ..D UPDATE^DIE("","ICDFDA")
 Q
 ;
INACTDRG ;
 N LINE,X,ICDDRG,DESC,DA,DIE,DR,MDC,SURG,ICDFDA
 D BMES^XPDUTL(">>> Inactivating 8 DRGs...")
 F LINE=1:1 S X=$T(INAC+LINE) S ICDDRG=$P(X,";;",2) Q:ICDDRG="EXIT"  D
 .S DESC="NO LONGER VALID"
 .S DA(1)=$P(ICDDRG,U)
 .S DA=1
 .S DIE="^ICD("_DA(1)_",1,"
 .S DR=".01///^S X=DESC"
 .D ^DIE
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD($P(ICDDRG,U),66,"B",3061001))
 .; add entry to 80.266
 .S MDC=$P(ICDDRG,U,2)
 .S SURG=$P(ICDDRG,U,3)
 .S ICDDRG=$P(ICDDRG,U)
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.266,"+2,?1,",.01)=3061001
 .S ICDFDA(80.266,"+2,?1,",.03)=0
 .S ICDFDA(80.266,"+2,?1,",.05)=MDC
 .S ICDFDA(80.266,"+2,?1,",.06)=SURG
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .; add entry to 80.268 and 80.2681 
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"+2,?1,",.01)=3061001
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"?2,?1,",.01)=3061001
 .S ICDFDA(80.2681,"+3,?2,?1,",.01)=DESC
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 Q
 ;
INAC ;
 ;;20^1^
 ;;24^1^
 ;;25^1^
 ;;475^4^1
 ;;148^6^1
 ;;154^6^1
 ;;415^18^1
 ;;416^18^1
 ;;EXIT
DRGTITLE ; modify titles of DRGs
 N LINE,X,ICDDRG,DESC,DA,DIE,DR,ICDFDA
 F LINE=1:1 S X=$T(TITLE+LINE) S ICDDRG=$P(X,";;",2) Q:ICDDRG="EXIT"  D
 .S DESC=$P(ICDDRG,U,2)
 .S DA(1)=$P(ICDDRG,U)
 .S DA=1
 .S DIE="^ICD("_DA(1)_",1,"
 .S DR=".01///^S X=DESC"
 .D ^DIE
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD($P(ICDDRG,U),68,"B",3061001))
 .; add entry to 80.268 and 80.2681
 .S ICDDRG=$P(ICDDRG,U)
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"+2,?1,",.01)=3061001
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"?2,?1,",.01)=3061001
 .S ICDFDA(80.2681,"+3,?2,?1,",.01)=DESC
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 Q
TITLE ;
 ;;303^KIDNEY AND URETER PROCEDURES FOR NEOPLASM
 ;;304^KIDNEY AND URETER PROCEDURES FOR NON-NEOPLASM WITH CC
 ;;305^KIDNEY AND URETER PROCEDURES FOR NON-NEOPLASM WITHOUT CC
 ;;543^CRANIOTOMY W/MAJOR DEVICE IMPLANT OR ACUTE COMPLEX CNS PDX
 ;;EXIT
