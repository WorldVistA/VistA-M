LRARPW ;DALISC/CKA - PURGE WKLD DATA (64.1);2/1/95
 ;;5.2;LAB SERVICE;**59,162**;Sep 27, 1994
START ;
 ;FIND ACTIVE LAB ARCHIVAL ACTIVITY
 S LRART=64.1,LRAR=90,LRARC=0 S LRARC=$O(^LAB(95.11,"O",3,LRART,LRARC)) G:LRARC="" ERROR D FILE^LRARU G:'$D(LRARC) EXIT
 ;UPDATE ACTION IN PROGRESS FIELDS
 S LRAR=90 D MRK^LRARU1
MAKE ;Ask if backup tape made
 W !!!! S DIR(0)="Y",DIR("A")="Did you make a backup of the ARCHIVED WKLD DATA file (64.19999)" D ^DIR K DIR
 I $D(DIRUT) D COMP^LRARU1 G EXIT
 I 'Y W !!!!,$C(7),"Make a backup of the ARCHIVED WKLD DATA file before purging!" D COMP^LRARU1 G EXIT
CHECK ;Ask if checked backup tape
 W !!!! S DIR(0)="Y",DIR("A")="Did you check the backup of the ARCHIVED WKLD DATA file" D ^DIR K DIR
 I $D(DIRUT) D COMP^LRARU1 G EXIT
 I 'Y W !!!!,$C(7),"Check the backup before purging!" D COMP^LRARU1 G EXIT
OKAY ;Ask if okay to delete
 W !!!! S DIR(0)="Y",DIR("A")="Okay to delete WKLD DATA entries: " D ^DIR K DIR
 I $D(DIRUT)!('Y) W !!!!,"No purging done." D COMP^LRARU1 G EXIT
QUEUE ;queue purge
 S ZTRTN="DOIT^LRARPW",ZTSAVE("LR*")="",ZTDESC="PURGE ARCHIVED WKLD DATA",ZTIO="" D ^%ZTLOAD W:$D(ZTSK) !,"TASK #",ZTSK G EXIT
 ;
DOIT ;Deleting dates in 64.1
 S LRAVAR=0
 F LRAI=0:0 S LRAVAR=$O(^LAB(95.11,LRARC,"RESULT",64.111,LRAVAR)) Q:+LRAVAR'>0   D
 . S DA(2)=$P(LRAVAR,",",3),DA(1)=$P(LRAVAR,",",2),DA=$P(LRAVAR,","),DIK="^LRO(64.1,"_DA(2)_",1,"_DA(1)_",1," D ^DIK
 . I '$O(^LRO(64.1,DA(2),1,DA(1),1,0)) S DA=DA(1),DA(1)=DA(2),DIK="^LRO(64.1,"_DA(1)_",1," D ^DIK
END W !!!!,"DONE."
 D COMP^LRARU1
 I '$D(DIRUT) S LRAR=90 D UPDATE^LRARU1
 W !!,"I will now CLEAR out the Archived Workload Data global."
 S LRARX="" F LRARI=0:0 S LRARX=$O(^LAR(64.19999,LRARX)) Q:LRARX=""  K ^LAR(64.19999,LRARX)
 S ^LAR(64.19999,0)="ARCHIVED WKLD DATA^64.19999"
 W !!,">>> DONE <<<"
 K ^LAB(95.11,LRARC,"RESULT")
 S ZTREQ="@"
EXIT K DA,DIK,DIR,DIRUT,LRAVAR,LRAI,LRAIEN,LRAINST,LRAJ,LRAR,LRARC,LRARI,LRART,LRARX,Y
 D CLN^LRARU1
 Q
ERROR W !!,$C(7),"I cannot find an archival activity for file 64.1 with the right archival status."
 G EXIT
 Q
