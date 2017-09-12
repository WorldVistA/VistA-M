ICD1810A ;ALB/MRY - ICD/DRG; 9/4/03 2:43pm
 ;;18.0;DRG Grouper;**10**;Oct 13,2000
 ;
 ; Taken from ICD182P with the exception of updates released
 ; in ICD184P.
 ;
EN ;- Post-Install entry point
 ;
 ; - Add DRGs to new Diagnosis codes
 D ADDDIAG^ICD1810P
 ;
 ; - Add DRGs to new Procedure codes
 D ADDPROC^ICD1810P
 ;
 ; - Add new DRGs
 D ADDDRG^ICD1810B ; taken from ICD185P1
 S ^DD(80.2,0,"VR")="21.0"
 ;
 ;- Inactivate/revise DRGS
 D DRGEDIT
 ;
 ;- DRG reclassification changes
 D EN^ICD1810C ; taken from ICD185P4
 ;
 ;- Weights & trims for FY 2004
 D BEGWT01
 ;
 Q
 ;
DRGEDIT ;- Edit DRG records (Description change)
 ; Invalid DRGs in FY 04:
 ;    DRG4: SPINAL PROCEDURES
 ;    DRG5: EXTRACRANIAL VASCULAR PROCEDURES
 ;    DRG231: LOCAL EXCISION & REMOVAL OF INT FIX DEVICES EXCEPT HIP & FEMUR
 ;    DRG400: LYMPHOMA & LEUKEMIA W MAJOR O.R. PROCEDURE
 ;    DRG514: CARDIAC DEFIBRILLATOR IMPLANT W/CARDIAC CATH
 ;
 N CNT,CNTI,DA,DIC,DIE,DR,DRG,I,ICDI,ICDIEN,ICDESC,NOVAL,X,Y
 S (CNT,CNTI)=0
 D BMES^XPDUTL(">>>  Revising DRG records in the DRG file (#80.2)...")
 F I=1:1 S DRG=$P($T(REVDRG+I),";;",2) Q:DRG="QUIT"  D
 . S DIC="^ICD(",DIC(0)="MX"
 . S X=$P(DRG,"^")
 . D ^DIC
 . I +Y>0 D
 .. S ICDESC=""
 .. F  S ICDESC=$O(^ICD(+Y,1,"B",ICDESC)) Q:ICDESC=""  S ICDIEN=+$O(^(ICDESC,0))
 .. S (ICDI,DA(1))=+Y,DA=ICDIEN
 .. S DIE=DIC_DA(1)_","_DA_","
 .. S DR=".01///^S X=$P(DRG,""^"",2)"
 .. D ^DIE
 .. D
 ... I $P(DRG,"^",3)="" Q
 ... S DIE=DIC
 ... S DA=ICDI
 ... S DR=".06///^S X=$P(DRG,""^"",3);5///^S X=$P(DRG,""^"",4)"
 ... D ^DIE
 .. S CNT=CNT+1
 .. D MES^XPDUTL("  Edited: "_$P(DRG,"^")_" to "_$P(DRG,"^",2))
 .. I $P(DRG,"^",5) D
 ... I $D(^ICD(ICDI,66,"B",$P(DRG,"^",5))) Q
 ... S DIE="^ICD("
 ... S DA=ICDI
 ... S DR="15///"_$P(DRG,"^",6)_";16///"_$P(DRG,"^",5)
 ... D ^DIE
 ... K DIC("DR")
 ... S DA(1)=+ICDI,DIC=DIC_DA(1)_",66,"
 ... S DIC(0)="L",DIC("P")=$P(^DD(80.2,66,0),"^",2)
 ... S DIC("DR")=".03///"_$P(DRG,"^",7)
 ... S X=$P(DRG,"^",5)
 ... K DO D FILE^DICN
 ... I +Y=-1 Q
 ... S CNTI=CNTI+1
 . E  D ERRMSG($P(DRG,"^"))
 ;
 ;- Total DRG records revised
 D MES^XPDUTL(">>>  ...completed.  "_CNT_" record(s) revised. "_CNTI_" record(s) made invalid.")
 D MES^XPDUTL("")
 Q
 ;
 ;
ERRMSG(VAR,IN) ;- Display error msg if DRG not found
 ;
 Q:VAR=""
 D BMES^XPDUTL(">>>  ERROR:  "_VAR_"  was not found and could not be "_$S(+$G(IN):"inactivated.",1:"revised."))
 D MES^XPDUTL("")
 Q
 ;
BEGWT01 ;- Entry point for wts & trims update for 2004
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J,PFYR
 D UPD01
 Q
 ;
 ;
UPD01 ;- Load FY 2004 into ICD DRG file (#80.2)
 S FYR=3040000
 D BMES^XPDUTL(">>>  Adding FY 2004 Weights & Trims...")
 Q:$D(^ICD(540,"FY",3040000,0))
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1810X),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1810Y),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD1810Z),";;",2,99) Q:$E(WT,1,3)="END"  D SETVAR,FY,MORE
 S ^ICD("AFY",3040000)=""
 D MES^XPDUTL(">>>  ...completed.")
 D MES^XPDUTL("")
 Q
 ;
 ;
FY ;- Set FY multiple with FYR stats
 S $P(^ICD(DRG,"FY",FYR,0),"^",1,4)=FYR_"^"_ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",9)=ICDLOS
 I '$D(^ICD(DRG,"FY",0)) S ^ICD(DRG,"FY",0)="^80.22^"_FYR_"^1" Q
 S ICDCNT="" F J=0:1 S ICDCNT=$O(^ICD(DRG,"FY",ICDCNT)) Q:ICDCNT=""
 S $P(^ICD(DRG,"FY",0),"^",3,4)=FYR_"^"_J
 Q
 ;
 ;
SETVAR ;- Set variables
 S DRG=$P(WT,"^"),ICDLOW=1,ICDLOS=$P(WT,"^",3),ICDHIGH=".0",ICDWWU=$P(WT,"^",2)
DRG I $E(DRG,1)=0 S DRG=$E(DRG,2,3) G DRG
 ; if HIGH-TRIM is .0 use last year's FY03 value.  If new DRG, use 99
 I ICDHIGH["." D
 .S ICDHIGH=$S(DRG>527:99,1:ICDHIGH) I ICDHIGH=99 Q
 .I $D(^ICD(DRG,"FY",3030000,0)) S ICDHIGH=$P(^(0),"^",4)
 I ICDWWU=0,ICDLOS=0 S (ICDLOW,ICDHIGH)=0
 Q
 ;
 ;
MORE ;- Set zero node with FY 2004 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 Q
 ;
REVDRG ;- Description edits
 ;;DRG492^CHEMOTHERAPY W ACUTE LEUKEMIA OR W USE OF HIGH DOSE CHEMOTHERAPY AGENT
 ;;DRG4^NO LONGER VALID^^^3031001^1^0
 ;;DRG5^NO LONGER VALID^^^3031001^1^0
 ;;DRG231^NO LONGER VALID^^^3031001^1^0
 ;;DRG400^NO LONGER VALID^^^3031001^1^0
 ;;DRG514^NO LONGER VALID^^^3031001^1^0
 ;;QUIT
