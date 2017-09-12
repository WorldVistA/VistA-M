ICD15PT ;ABR/ALB - POST-INIT FOR DRG 15 ; 5 JAN 1998
 ;;15.0;DRG Grouper;;Feb 23, 1998
 ;
 ;  This routine updates the FY entries in the DRG file (#80.2) to
 ;  make them Y2K compatible.  All 2-digit FYs have been changed to the 
 ;  FileMan 3-digit entry (e.g. '91' becomes '291')
 ;
 ;  The Break-even nodes were similarly corrected, with the 3-digit
 ;  FY preceding the 1-4 quarter indicator.
 ;  E.g. - '871' becomes '2871' for 1st quarter, 1987.
 ;
 ;  Reference routines are added for the new DRGs that were added
 ;  to the DRG file as part of patch ICD*14*2 - DRGs 496-503.
 ;
 ;  BEGST adds the 1995 and 1996
 ;  Weights & Trims to the DRG file.
 ;
 ;  This routine may be re-run.
 ;
EN ; POST-INSTALL ENTRY POINT
 D DRGREF
 D DRGFIELD ; delete starred field 8 from DRG file
 D FYUPD
 D BEGWT
 D BMES^XPDUTL("*** Please restore your ICD9 and ICD0 global files from ***")
 D MES^XPDUTL("*** ICD9_15.GBL and ICD0_15.GBL at this time.   ***")
 Q
DRGREF ; add routine reference to new DRGs
 N DRG
 F DRG=496:1:503 S ^ICD(DRG,"MC1")="ICDTLB6"
 Q
DRGFIELD ; delete starred field from DRG file
 N DIK,DA,I
 D BMES^XPDUTL(">>> Deleting obsolete MUMPS CODE field from DRG file.")
 S DIK="^DD(80.2,",DA=8,DA(1)=80.2
 D ^DIK
 ;  kill old data from deleted field
 D BMES^XPDUTL(">>> Deleting data from obsolete MUMPS CODE field")
 F I=0:0 S I=$O(^ICD(I)) Q:'I  K ^ICD(I,"MC")
 Q
FYUPD ; change FY for weights & trims, break-evens to FM format
 S U="^"
 N DRG,FY
 D BMES^XPDUTL(">> Updating FY nodes for Year 2000 compatibility.")
 F DRG=0:0 S DRG=$O(^ICD(DRG)) Q:'DRG  D
 . I $D(^ICD(DRG,"FY")) D WTUP(DRG) ; update wts/trims nodes
 . I $D(^ICD(DRG,"BE")) D BEUP(DRG) ; update break-even nodes
 F FY=0:0 S FY=$O(^ICD("AFY",FY)) Q:'FY!(FY>500)  D
 . N X,Y,%DT S X=FY D ^%DT
 . S ^ICD("AFY",Y)="" K ^(FY)
 Q
WTUP(DRG) ; change wts/trims FY to FM FY references
 N FY,FMFY
 F FY=0:0 S FY=$O(^ICD(DRG,"FY",FY)) Q:'FY!(FY>500)  D
 . S FMFY=$S(FY>500:FY,1:(FY+200)_"0000")
 . S ^ICD(DRG,"FY",FMFY,0)=FMFY_U_$P(^ICD(DRG,"FY",FY,0),U,2,99)
 . I FY'=FMFY K ^ICD(DRG,"FY",FY)
 S:$G(FMFY) $P(^ICD(DRG,"FY",0),U,3)=FMFY
 Q
BEUP(DRG) ;change break-even FY to FM FY references
 N BE,FMBE
 F BE=0:0 S BE=$O(^ICD(DRG,"BE",BE)) Q:'BE!(BE>10000)  D
 . S FMBE=$S(BE>10000:BE,1:BE+19000)
 . S X=$G(^ICD(DRG,"BE",BE,0)) I X]"" S ^ICD(DRG,"BE",FMBE,0)=FMBE_U_$P(X,U,2,99)
 . I $D(^ICD(DRG,"BE",BE,"S")) D SERVICE
 . I BE'=FMBE K ^ICD(DRG,"BE",BE)
 S:$G(FMBE) $P(^ICD(DRG,"BE",0),U,3)=FMBE
 Q
SERVICE ; update services for break-evens
 N SVC,X
 S X=$G(^ICD(DRG,"BE",BE,"S",0)) I X]"" S ^ICD(DRG,"BE",FMBE,"S",0)=X
 I $O(^ICD(DRG,"BE",BE,"S",0)) F SVC=1:1:5 S X=$G(^ICD(DRG,"BE",BE,"S",SVC,0)) I X S ^ICD(DRG,"BE",FMBE,"S",SVC,0)=X
 Q
 ;
BEGWT ;  entry point for wts & trims update for 95
 N DRG,FYR,ICDLOW,ICDHIGH,ICDLOS,ICDWWU,ICDCNT,WT,I,J
 D UPD95
 D UPD96
 Q
UPD95 ;  load fy 95 wwu into ICD DRG file (80.2)
 S FYR=2950000
 D MES^XPDUTL(">> Adding FY 95 Weights & Trims.")
 F I=1:1 S WT=$P($T(WW95+I^ICD15P95),";;",2,99) Q:'WT  D SETVAR,FY
 F I=1:1 S WT=$P($T(WW95+I^ICD1595A),";;",2,99) Q:'WT  D SETVAR,FY
 S ^ICD("AFY",2950000)=""
 Q
UPD96 ;  load fy 96 wwu into ICD DRG file (80.2)
 S FYR=2960000
 D MES^XPDUTL(">> Adding FY 96 Weights & Trims.")
 F I=1:1 S WT=$P($T(WW96+I^ICD15P96),";;",2,99) Q:'WT  D SETVAR,FY,MORE
 F I=1:1 S WT=$P($T(WW96+I^ICD1596A),";;",2,99) Q:'WT  D SETVAR,FY,MORE
 S ^ICD("AFY",2960000)=""
 Q
FY ;set fy multiple with FYR stats
 S $P(^ICD(DRG,"FY",FYR,0),"^",1,4)=FYR_"^"_ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",9)=ICDLOS
 I '$D(^ICD(DRG,"FY",0)) S ^ICD(DRG,"FY",0)="^80.22^"_FYR_"^1" Q
 S ICDCNT="" F J=0:1 S ICDCNT=$O(^ICD(DRG,"FY",ICDCNT)) Q:ICDCNT=""
 S $P(^ICD(DRG,"FY",0),"^",3,4)=FYR_"^"_J
 Q
SETVAR ; SET VARIABLES
 S DRG=+WT,ICDLOW=$P(WT,U,2),ICDLOS=$P(WT,U,3),ICDHIGH=$P(WT,U,4),ICDWWU=$P(WT,U,5)
 Q
MORE ;set 0 node with FY 96 stats
 S $P(^ICD(DRG,0),"^",2,4)=ICDWWU_"^"_ICDLOW_"^"_ICDHIGH,$P(^(0),"^",8)=ICDLOS
 D FY
 Q
