ICD18PT ;ALB/ESD - DRG V16 POST-INSTALL ; 10/23/00 11:57am
 ;;18.0;DRG Grouper;;Oct 20, 2000
 ;
 ;
 ;  This routine may be re-run.
 ;
EN ;- Post-Install entry point
 ;
 ;- Remove dup "B" xrefs from Description multiple
 ;D REMXREF
 ;
 ;- Revise DRGs/new descriptions, or changed to Inactie
 ;D DRGEDIT
 ;
 ;- Weights & trims for FY 97
 ;D BEGWT
 ;
 ;- Display reminder msg
 D BMES^XPDUTL(">>>  IMPORTANT:  Please restore your ICD9 and ICD0 global files from  <<<")
 D MES^XPDUTL(">>>              ICD9_18.GBL and ICD0_18.GBL at this time.        <<<")
 Q
 ;
 ;
REMXREF ;- Remove dup "B" xref on Description multiple and reindex
 ;
 N DA,DIK,I,ICDIEN
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>>  Correcting duplicate ""B"" cross-ref entries in the Description")
 D MES^XPDUTL("     multiple of the DRG file (#80.2)...")
 F I=1:1 S ICDIEN=$P($T(REMXDRG+I),";;",2) Q:ICDIEN="QUIT"  D
 . K ^ICD(ICDIEN,1,"B")
 . S DA(1)=ICDIEN,DA=1
 . S DIK="^ICD("_DA(1)_",1,"
 . S DIK(1)=".01^B"
 . D EN1^DIK
 D MES^XPDUTL(">>>  ...completed.")
 D MES^XPDUTL("")
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
BEGWT ;- Entry point for wts & trims update for 97
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J
 D UPD97
 Q
 ;
 ;
UPD97 ;- Load FY 97 WWU into ICD DRG file (#80.2)
 S FYR=2970000
 D BMES^XPDUTL(">>>  Adding FY 97 Weights & Trims...")
 F I=1:1 S WT=$P($T(WW97+I^ICD16P97),";;",2,99) Q:'WT  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WW97+I^ICD1697A),";;",2,99) Q:'WT  D SETVAR,FY,MORE
 S ^ICD("AFY",2970000)=""
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
 S DRG=+WT,ICDLOW=$P(WT,"^",2),ICDLOS=$P(WT,"^",3),ICDHIGH=$P(WT,"^",4),ICDWWU=$P(WT,"^",5)
 Q
 ;
 ;
MORE ;- Set zero node with FY 97 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 D FY
 Q
 ;
 ;
REVDRG ;- Description edits
 ;;DRG104^CARDIAC VALVE & OTH MAJ CARDIOTHORACIC PROC W CARD CATH
 ;;DRG105^CARDIAC VALVE & OTH MAJ CARDIOTHORACIC PROC W/O CARD CATH
 ;;DRG106^CORONARY BYPASS WITH PTCA^1^5
 ;;DRG107^CORONARY BYPASS W CARDIAC CATH^1^5
 ;;DRG109^CORONARY BYPASS W/O CARDIAC CATH^1^5
 ;;DRG115^PERM PACE IMPLNT W AMI,HRT FAIL OR SHOCK OR AICD LEAD OR GEN PROC
 ;;DRG116^OTH PERM CARDIAC PACEMAKER IMPLANT OR PTCA W CORONARY ART STENT
 ;;DRG121^CIRCULATORY DISORDERS W AMI & MAJOR COMP DISCH ALIVE
 ;;DRG122^CIRCULATORY DISORDERS W AMI W/O MAJOR COMP DISCH ALIVE
 ;;DRG406^MYELOPROLIF DISORD OR POORLY DIFF NEOPL W MAJ O.R.PROC W CC
 ;;DRG407^MYELOPROLIF DISORD OR POORLY DIFF NEOPL W MAJ O.R.PROC W/O CC
 ;;DRG485^LIMB REATTACHMENT, HIP AND FEMUR PROC FOR MULTIPLE SIGNIFICANT TR
 ;;DRG214^NO LONGER VALID
 ;;DRG215^NO LONGER VALID
 ;;DRG221^NO LONGER VALID
 ;;DRG222^NO LONGER VALID
 ;;DRG456^NO LONGER VALID
 ;;DRG457^NO LONGER VALID
 ;;DRG458^NO LONGER VALID
 ;;DRG459^NO LONGER VALID
 ;;DRG460^NO LONGER VALID
 ;;DRG472^NO LONGER VALID
 ;;QUIT
 ;
 ;
REMXDRG ;- DRG dup "B" xref IENs
 ;;11
 ;;48
 ;;53
 ;;54
 ;;89
 ;;90
 ;;91
 ;;104
 ;;105
 ;;116
 ;;193
 ;;194
 ;;195
 ;;196
 ;;197
 ;;198
 ;;384
 ;;410
 ;;444
 ;;445
 ;;446
 ;;461
 ;;477
 ;;482
 ;;483
 ;;485
 ;;486
 ;;488
 ;;490
 ;;QUIT
