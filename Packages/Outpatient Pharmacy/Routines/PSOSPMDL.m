PSOSPMDL ;BIRM/SJA - State Prescription Monitoring Program - Delete unexported batch ;09/20/20
 ;;7.0;OUTPATIENT PHARMACY;**625**;DEC 1997;Build 42
 ;
EN ; - entry point for the PSO SPMP1 DELETE BATCH protocol
 N %DT,DIR,DIRUT,X,DIC,DTOUT,DUOUT,Y
 N II,SELECT,BATCH,EXPORT
 D FULL^VALM1 W !
 ;
 I $G(^TMP("PSOSPML1",$J,1,0))["There are no export batches" W !!,"Nothing to be deleted!",$C(7) D ENTER G END
 K DIC W ! S DIR("A")="Select batch(es) to delete",DIR(0)="L^"_VALMBG_":"_VALMLST D ^DIR
 K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,?3,"Nothing selected to delete",! G END
 S SELECT=Y
 F II=1:1:$L(SELECT,",") Q:'$P(SELECT,",",II)  D
 . S BATCH=$G(^TMP("PSOSPML1",$J,$P(SELECT,",",II),"BAT")),EXPORT=$$GET1^DIQ(58.42,BATCH,9,"I")
 . I EXPORT W !!,"Batch #",BATCH," may not be deleted; it has been exported to the state.",$C(7) D ENTER:(II=($L(SELECT,",")-1)) Q
 . I 'EXPORT D DEL(BATCH)
 G BACK
 Q
 ;
DEL(BATCH) ; delete selected batch(es)
 K DIR,DIRUT,DTOUT
 W !! K DIR S DIR(0)="Y",DIR("B")="Y"
 S DIR("A",1)="This action cannot be recovered once complete."
 S DIR("A")="Are you sure you want to delete batch #"_BATCH_" (Y/N)"
 D ^DIR K DIR I Y'=1 W !,"No action taken for batch #",BATCH D ENTER Q
 S DA=BATCH,DIK="^PS(58.42," D ^DIK K DA,DIK W !,"Deleting batch #",BATCH," ...",! D ENTER
 Q
 ;
ENTER ;
 K DIR S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 Q
 ;
BACK ; go back to the list
 D INIT^PSOSPML1 I 'VALMCNT Q
 ;
END S VALMBCK="R"
 Q
