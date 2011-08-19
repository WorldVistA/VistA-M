LRLABLDS ;DALOI/FHS/DRH - PRINT SINGLE LABELS ON DEMAND FOR FUTURE LAB COLLECT ;8/29/94 12:36
 ;;5.2;LAB SERVICE;**161,218**;Sep 27, 1994
EN ;
 N DIC,DIR,DIRUT,DTOUT,DTOUT,LRBATCH,LROK
 K ^TMP($J)
 S LRBATCH=0,LRPICK=2,LRSING=1
 S DIR(0)="NO^1:"_$O(^LRO(69,"C",""),-1)_":0",DIR("A")="Enter Order Number"
 S DIR("?")="Enter the order number for which you need a label"
 D ^DIR
 I $D(DIRUT) D CLEAN Q
 I '$D(^LRO(69,"C",Y)) W !?10,"Number does not exist",!,$C(7) G EN
 S LRORDN=Y
GET K DA
 S (LREND,LROK,LRSN)=0
 S LRODT=$O(^LRO(69,"C",LRORDN,""))
 F  S LRSN=$O(^LRO(69,"C",LRORDN,LRODT,LRSN)) Q:LRSN=""  D
 . S LRSN(0)=$G(^LRO(69,LRODT,1,LRSN,0)),LRSN(1)=$G(^LRO(69,LRODT,1,LRSN,1))
 . S DA=LRSN,DA(1)=LRODT,DIC="^LRO(69,"_DA(1)_",1,"
 . D EN^DIQ,CHK
 . I 'LREND S LROK=1
 I 'LROK G EN
 K DIR W !
 S DIR(0)="YO",DIR("A")="Is this the correct patient",DIR("B")="YES"
 D ^DIR
 I $D(DIRUT) D CLEAN Q
 I Y'=1 G EN
 K %ZIS S %ZIS="Q" D ^%ZIS
 I POP D CLEAN Q
 I $D(IO("Q")) D  G EN
 . S ZTRTN="QUE^LRLABLDS",ZTDESC="Print Future Collection Labels"
 . S ZTSAVE("LR*")=""
 . D ^%ZTLOAD,CLEAN
QUE ;
 U IO
 S (LREND,LROK,LRSN)=0
 F  S LRSN=$O(^LRO(69,"C",LRORDN,LRODT,LRSN)) Q:LRSN=""  D
 . S LRSN(0)=$G(^LRO(69,LRODT,1,LRSN,0)),LRSN(1)=$G(^LRO(69,LRODT,1,LRSN,1))
 . I '$D(ZTQUEUED) S LROK=1
 . E  D CHK S:'LREND LROK=1 Q:LREND
 . S LRDFN=+LRSN(0) D BLDTMP^LRLABLD0
 I LROK D ^LRLABELF
 Q:$D(ZTQUEUED)
 D CLEAN
 G EN
 ;
CHK ; Check order for collection type/status/date-time
 N LRMSG
 S LREND=0
 I '$L($P(LRSN(0),U,4)) S LREND=1,LRMSG="No Collection Type on Order"
 I 'LREND,'$P(LRSN(0),U,8) S LREND=1,LRMSG="No Est. Date/Time of Collection on Order"
 I 'LREND,$L($P(LRSN(1),U,4)),"CM"[$P(LRSN(1),U,4) S LREND=1,LRMSG="Collection status: "_$$EXTERNAL^DILFD(69.01,13,,$P(LRSN(1),U,4))
 I 'LREND,$P(LRSN(1),U) S LREND=1,LRMSG="Order already collected"
 I 'LREND D
 . N LRTEST,LROK
 . S LROK=0 ; Flag to indicate there are still tests on the order
 . S LRTEST=0
 . F  S LRTEST=$O(^LRO(69,LRODT,1,LRSN,2,LRTEST)) Q:'LRTEST  I '$P($G(^LRO(69,LRODT,1,LRSN,2,LRTEST,0)),U,11) S LROK=1 ; Found a 'good' test.
 . I 'LROK S LREND=1,LRMSG="No active tests on specimen"
 I LREND,'LRBATCH D  Q
 . I $D(ZTQUEUED),LRPICK=2 Q  ; Don't print error msg on label printer.
 . U IO(0)
 . W !,$C(7),"Can not print label for Order Number: ",$P($G(^LRO(69,LRODT,1,LRSN,.1),"Unknown"),U)
 . W !,?26,"Specimen #: ",LRSN
 . W !,?5,"Reason - ",LRMSG,!
 Q
 ;
CLEAN ;
 D END^LRLABELF
 K DA,DIC,A,DX
 Q
