ICD183P ;ALB/ESD/JAT - ICD/DRG; 11/15/01 9:07am ; 12/3/01 4:17pm
 ;;18.0;DRG Grouper;**3**;Oct 13,2000
 ;
 ;
EN ;- Pre-Install entry point
 ;
 ;- revise Diagnoses
 D CHGDIAG^ICD183P3
 ;
 ;  first need to create routines ICD183PA,B,C
 ;  from DRG Pricer file from Austin 
 ;  (see ICD182PA,B,C from 2001)
 ;
 ; - Weights & trims for FY 2002
 D BEGWT01
 ;
 Q
 ;
BEGWT01 ;- Entry point for wts & trims update for FY 2002
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J
 D UPD01
 Q
 ;
UPD01 ;- Load FY 2002 data into ICD DRG file (#80.2)
 S FYR=3020000
 D BMES^XPDUTL(">>>  Adding FY 2002 Weights & Trims...")
 Q:$D(^ICD(523,"FY",3020000,0))
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD183PA),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD183PB),";;",2,99) Q:I>200  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WEIGHTS+I^ICD183PC),";;",2,99) Q:$E(WT,1,3)="END"  D SETVAR,FY,MORE
 S ^ICD("AFY",3020000)=""
 D MES^XPDUTL(">>>  ...completed.")
 D MES^XPDUTL("")
 Q
 ;
FY ;- Set FY multiple with FYR stats
 S $P(^ICD(DRG,"FY",FYR,0),"^",1,4)=FYR_"^"_ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",9)=ICDLOS
 I '$D(^ICD(DRG,"FY",0)) S ^ICD(DRG,"FY",0)="^80.22^"_FYR_"^1" Q
 S ICDCNT="" F J=0:1 S ICDCNT=$O(^ICD(DRG,"FY",ICDCNT)) Q:ICDCNT=""
 S $P(^ICD(DRG,"FY",0),"^",3,4)=FYR_"^"_J
 Q
 ;
SETVAR ;- Set variables
 S DRG=$E(WT,1,3),ICDLOW=1,ICDLOS=$E(WT,12,14),ICDHIGH=$E(WT,16,17),ICDWWU=$E(WT,5,10)
DRG I $E(DRG,1)=0 S DRG=$E(DRG,2,3) G DRG
 S ICDLOS=$E(ICDLOS,1,2)_"."_$E(ICDLOS,3) I $E(ICDLOS,1)=0 S ICDLOS=$E(ICDLOS,2,4)
 I $E(ICDHIGH,1)=0 S ICDHIGH=$E(ICDHIGH,2)
 S ICDWWU=$E(ICDWWU,1,2)_"."_$E(ICDWWU,3,6) I $E(ICDWWU,1)=0 S ICDWWU=$E(ICDWWU,2,7)
 Q
 ;
MORE ;- Set zero node with FY 2002 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 Q
 ;
