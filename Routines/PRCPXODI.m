PRCPXODI ;WOIFO/CC-purge On-Demand Audit Activity ; 11/30/06 4:04pm
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Called from PRCPXALL where STOPDATE and PRCP("I") are set up
 ; PRCP("I") is the ien of the inventory point being cleaned
 ; STOPDATE is the oldest date for which activity is to be kept
 ;
 ; NOTE:  This program purges the On-Demand Audit records from each
 ;        item in the inventory point.  Although the program is
 ;        designed to purge any record older than the date indicated
 ;        in STOPDATE, it is also designed to retain the three most
 ;        recent audit records, regardless of how old they are.
 ;
DQ N D,DA,DIC,DIK,ITEMDA,PRCPAUDT,PRCPCNT,PRCPSTOP,X
 ; loop through for each item
 S ITEMDA=0
 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:+ITEMDA'>0  D
 . N X,PRCPKEEP
 . I $D(SCAN) W !,"ITEM # ",ITEMDA
 . S X=$O(^PRCP(445,PRCP("I"),1,ITEMDA,10,0)) Q:X=""  ; no audits on file
 . S X=$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,10,X,0)),"^",1) ; date of audit
 . I $D(SCAN) W !,"OLDEST AUDIT DATE: ",X
 . I X'<STOPDATE Q  ; earliest audit is within retention period
 . ;
 . ; Item has entries that could be purged, save 3 most recent entries
 . S PRCPAUDT="A",PRCPCNT=0,PRCPSTOP=0
 . ; Find 3 oldest entries then proceed to next section
 . F  S PRCPAUDT=$O(^PRCP(445,PRCP("I"),1,ITEMDA,10,PRCPAUDT),-1) Q:'+PRCPAUDT  D  Q:PRCPCNT=3
 . . S PRCPCNT=PRCPCNT+1 I $D(SCAN) W !,"FOUND:",PRCPCNT
 . . I PRCPCNT<4 S PRCPKEEP(PRCPAUDT)=PRCPCNT Q  ; keep three most recent audit records
 . . Q
 . ;
 . I PRCPCNT<3 Q  ; only 2 records exists and all must be kept
 . ; Loop through all audit records on file, starting with the oldest
 . ; Continue processing until the audit date of a record follows the stop date or processing hits one of the 3 most recent records.
 . S PRCPAUDT=0
 . F  S PRCPAUDT=$O(^PRCP(445,PRCP("I"),1,ITEMDA,10,PRCPAUDT)) Q:'+PRCPAUDT  D  I PRCPSTOP Q
 . . S X=$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,10,PRCPAUDT,0)),"^",1) ; get date of audit record
 . . I $D(SCAN) W !,"AUDIT DATE: ",X,"   STOPDATE:",STOPDATE
 . . I X'<STOPDATE!$D(PRCPKEEP(PRCPAUDT)) S PRCPSTOP=1 Q  ; no more to purge
 . . I $D(SCAN) W !,X," WILL BE PURGED" Q
 . . S DIK="^PRCP(445,"_PRCP("I")_",1,"_ITEMDA_",10,",DA(1)=ITEMDA,DA(2)=PRCP("I"),DA=PRCPAUDT D ^DIK K DIK,DA
 ;
 Q
 ;
TEST ; RUN WITHOUT DELETING AND WITH SCAN ON
 N SCAN
 S SCAN=1
 S STOPDATE=3060625
 ;S STOPDATE=3061125
 S PRCP("I")=9
 D DQ
 Q
