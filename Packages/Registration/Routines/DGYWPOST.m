DGYWPOST ;ALB/MLI - Post-init for EDR clean-up patch DG*5.3*65 ; 14 Aug 95 [10/12/95 4:27pm]
 ;;5.3;Registration;**65**;Aug 13, 1993
 ;
 ; This routine will re-index the B and ABDC cross-references on the PIMS
 ; EDR EVENT file (#391.51).  It will also kick off the job to run a
 ; diagnostic check of the file.
 ;
EN ; post-init start
 D REINDEX
 D CENSUS
 D QUEUE^VAFEDRCU ; queue edr clean-up
 Q
 ;
 ;
REINDEX ; re-indexes B and ABDC cross-references
 W !!,">>> Re-indexing B and ABDC cross-references on file 391.51..."
 K ^VAT(391.51,"B"),^("ABDC") ; kill indexes
 S DIK="^VAT(391.51,",DIK(1)=".01^B^ABDC1" D ENALL^DIK ; reindexes B and ABDC
 W "Done",!!
 Q
 ;
 ;
CENSUS ; puts census PTFs into 391.51
 W !,">>> Placing census PTF records into PIMS EDR EVENT file..."
 N DGCOUNT,DGDATE,DGIEN,DA
 S DGCOUNT=0,DGDATE=2950900
 F  S DGDATE=$O(^DGP(45.83,"AP",DGDATE)) Q:'DGDATE  D
 . F DGIEN=0:0 S DGIEN=$O(^DGP(45.83,"AP",DGDATE,DGIEN)) Q:'DGIEN  D
 . . F DA=0:0 S DA=$O(^DGP(45.83,"AP",DGDATE,DGIEN,DA)) Q:'DA  D
 . . . I $P($G(^DGPT(DA,0)),"^",11)'=2 Q
 . . . S DGCOUNT=DGCOUNT+1 I '(DGCOUNT#30) W "."
 . . . D EN^VAFEDG
 Q
