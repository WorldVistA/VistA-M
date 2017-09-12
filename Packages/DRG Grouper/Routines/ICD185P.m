ICD185P ;ALB/MRY - ICD/DRG; 10/17/02 2:43pm
 ;;18.0;DRG Grouper;**5**;Oct 13,2000
 ;
 ; Taken from ICD182P with the exception of updates released
 ; in ICD184P.
 ;
EN ;- Post-Install entry point
 ;
 ; - Add new DRGs
 D ADDDRG^ICD185P1
 S ^DD(80.2,0,"VR")="20.0"
 ;
 ;- Inactivate/revise DRGS
 D DRGEDIT
 ;
 ;- DRG reclassification changes
 D EN^ICD185P4
 ;
 ; - Weights & trims for FY 2002
 D BEGWT01
 ;
 ;- Update Diagnoses w/complications/comorbidities
 D EN^ICD185P5
 ;
 Q
 ;
 ;
DRGEDIT ;- Edit DRG records (Description change)
 ;
 N CNT,DA,DIC,DIE,DR,DRG,I,ICDI,ICDIEN,ICDESC,NOVAL,X,Y
 S CNT=0
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
 . E  D ERRMSG($P(DRG,"^"))
 ;
 ;- Total DRG records revised
 D MES^XPDUTL(">>>  ...completed.  "_CNT_" record(s) revised.")
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
 ;
BEGWT01 ;- Entry point for wts & trims update for 2003
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J,PFYR
 D UPD01
 Q
 ;
 ;
UPD01 ;- Load FY 2003 into ICD DRG file (#80.2)
 S FYR=3030000
 D BMES^XPDUTL(">>>  Adding FY 2003 Weights & Trims...")
 Q:$D(^ICD(527,"FY",3030000,0))
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD185PA),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD185PB),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD185PC),";;",2,99) Q:$E(WT,1,3)="END"  D SETVAR,FY,MORE
 S ^ICD("AFY",3030000)=""
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
 S DRG=$E(WT,1,3),ICDLOW=1,ICDLOS=$E(WT,12,14),ICDHIGH=$E(WT,16,17),ICDWWU=$E(WT,5,10)
DRG I $E(DRG,1)=0 S DRG=$E(DRG,2,3) G DRG
 S ICDLOS=$E(ICDLOS,1,2)_"."_$E(ICDLOS,3) I $E(ICDLOS,1)=0 S ICDLOS=$E(ICDLOS,2,4)
 I $E(ICDHIGH,1)=0 S ICDHIGH=$E(ICDHIGH,2)
 S ICDWWU=$E(ICDWWU,1,2)_"."_$E(ICDWWU,3,6) I $E(ICDWWU,1)=0 S ICDWWU=$E(ICDWWU,2,7)
 ; if HIGH-TRIM is .0 use last year's FY02 value.  If new DRG, use 99
 I ICDHIGH["." D
 .S ICDHIGH=$S(DRG=524!(DRG=525)!(DRG=526)!(DRG=527):99,1:ICDHIGH) I ICDHIGH=99 Q
 .I $D(^ICD(DRG,"FY",3020000,0)) S ICDHIGH=$P(^(0),"^",4)
 Q
 ;
 ;
MORE ;- Set zero node with FY 2002 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 Q
 ;
 ;
REVDRG ;- Description edits
 ;;DRG1^CRANIOTOMY AGE>17 W CC
 ;;DRG2^CRANIOTOMY AGE>17 W/O CC
 ;;DRG14^INTRACRANIAL HEMORRHAGE & STROKE W INFARCT
 ;;DRG15^NONSPECIFIC CVA & PRECEREBRAL OCCLUSION W/O INFARCT
 ;;DRG483^TRACH W MECH VENT 96+ HRS OR PDX EXCEPT FACE,MOUTH & NECK DIAG
 ;;QUIT
 ;
 ;
