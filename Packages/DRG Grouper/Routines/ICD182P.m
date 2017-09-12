ICD182P ;ALB/ESD/JAT - ICD/DRG; 6/22/01 2:43pm ; 9/19/01 2:55pm
 ;;18.0;DRG Grouper;**2**;Oct 13,2000
 ;
 ;
EN ;- Post-Install entry point
 ;
 ; - Add new DRGs
 D ADDDRG^ICD182P1
 S ^DD(80.2,0,"VR")="19.0"
 ;
 ;- Add new Diagnoses
 D ADDDIAG^ICD182P2
 S ^DD(80,0,"VR")="19.0"
 ;
 ;- Add new Procedures
 D ADDPROC^ICD182P1
 S ^DD(80.1,0,"VR")="19.0"
 ;
 ;- Inactivate/revise Diagnoses
 D CHGDIAG^ICD182P3
 ;
 ;- Inactivate/revise Procedures
 D CHGPROC^ICD182P3
 ;
 ;- Inactivate/revise DRGS
 D DRGEDIT
 ;
 ;- DRG reclassification changes
 D EN^ICD182P4
 ;
 ; - Weights & trims for FY 2001
 D BEGWT01
 ;
 ;- Update Diagnoses w/complications/comorbidities
 D EN^ICD182P5
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
BEGWT01 ;- Entry point for wts & trims update for 2001
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J
 D UPD01
 Q
 ;
 ;
UPD01 ;- Load FY 2001 into ICD DRG file (#80.2)
 S FYR=3010000
 D BMES^XPDUTL(">>>  Adding FY 2001 Weights & Trims...")
 Q:$D(^ICD(511,"FY",3010000,0))
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD182PA),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD182PB),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD182PC),";;",2,99) Q:$E(WT,1,3)="END"  D SETVAR,FY,MORE
 S ^ICD("AFY",3010000)=""
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
 Q
 ;
 ;
MORE ;- Set zero node with FY 2001 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 Q
 ;
 ;
REVDRG ;- Description edits
 ;;DRG116^OTHER CARDIAC PACEMAKER IMPLANTATION
 ;;DRG497^SPINAL FUSION EXCEPT CERVICAL W CC
 ;;DRG498^SPINAL FUSION EXCEPT CERVICAL W/O CC
 ;;DRG112^NO LONGER VALID
 ;;DRG434^NO LONGER VALID
 ;;DRG435^NO LONGER VALID
 ;;DRG436^NO LONGER VALID
 ;;DRG437^NO LONGER VALID
 ;;QUIT
 ;
 ;
