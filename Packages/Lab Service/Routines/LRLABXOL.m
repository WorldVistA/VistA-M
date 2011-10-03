LRLABXOL ;RVAMC/PLS/DALISC/FHS - REPRINT ACCESSION LABELS FOR ENTIRE ORDER ; 5/19/93  07:40
 ;;5.2;LAB SERVICE;**11,121,161**;Sep 27, 1994
 ; Will print all the required labels for a entire order.
EN K ZTSK
 D IOCHK^LRLABXT G END:'$D(LRLABLIO)
 D PSET^LRLABLD
 S LRHDR="Select Order Number: "
1 U IO(0)
 W !!,LRHDR R LRORD:DTIME G:'$T END G:(LRORD="")!(LRORD="^") END I LRORD?.AP!(LRORD<1) W !,"Enter a whole number for the order number." G 1
 S LRORD=+LRORD
 S LRODT=$O(^LRO(69,"C",LRORD,0))
 I +LRODT<1 W "  ORDER NUMBER NOT FOUND" G 1
 I '$$GOT^LROE(LRORD,LRODT) W !!,"All tests for this order have been canceled." H 1 G 1
 I $D(LRLABLIO("Q")) D  G END
 . S ZTIO=LRLABLIO,ZTRTN="QUE^LRLABXOL",ZTDESC="LAB ORDER LABELS",ZTSAVE("LR*")=""
 . D ^%ZTLOAD
 . W !,"Labels have been tasked to print ",!
 D QUE
 K LRORD
 U IO(0) W !?10,"Label(s) Printed",! S LRHDR="Another Order Number: "
 G 1
 ;
QUE ;
 S LRODT=0
 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D 2,PRINT
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
2 ;
 S LRSN=0
 F  S LRSN=+$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:LRSN<1  D SQ
 Q
 ;
SQ ; Search for accession numbers and build LRORD array 'ORD #(SEQ #,ACC AREA,ACC DATE, ACC #)=""'
 Q:'$D(^LRO(69,LRODT,1,LRSN,2,0))
 S SEQ=0
 F  S SEQ=+$O(^LRO(69,LRODT,1,LRSN,2,SEQ)) Q:SEQ<1  D
 . S X=$G(^LRO(69,LRODT,1,LRSN,2,SEQ,0)),LRAD=$P(X,U,3),LRAA=$P(X,U,4),LRAN=$P(X,U,5)
 . I LRAA,LRAD,LRAN S LRORD(LRSN,LRAA,LRAD,LRAN)=""
 Q
 ;
PRINT ; Loop thru array and print labels.
 U IO
 S LRAA=""
 F  S LRX=$Q(LRORD) Q:LRX=""  Q:$QS(LRX,0)'="LRORD"  D
 . S LRSN=$QS(LRX,1)
 . I LRAA'=$QS(LRX,2) S LRAA=$QS(LRX,2) D LBLTYP^LRLABLD
 . S LRAD=$QS(LRX,3),LRAN=$QS(LRX,4)
 . K LRORD(LRSN,LRAA,LRAD,LRAN)
 . N LRORD,LRX
 . D PRINT^LRLABXT
 Q
 ;
END ;
 K LRHDR,LRORD,SEQ,ZTSK
 D K^LRLABXT
 Q
