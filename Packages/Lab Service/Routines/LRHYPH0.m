LRHYPH0 ;DALOI/HOAK - HOWDY ORDER NUMBER SELECTOR PRIME ;8/28/2005
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ;
 ;
 K LRORIFN,LRNATURE,LREND,LRORDRR
 S LRLWC="WC"
 D ^LRPARAM
 I $G(LREND) S LREND=0 Q
L5 ;
NEXT ;
 K DIR
 I $D(LROESTAT) D:$P(LRPARAM,U,14) ^LRCAPV I $G(LREND) K LRLONG,LRPANEL Q
 S (LRODT,X,DT)=$$DT^XLFDT(),LRODT0=$$FMTE^XLFDT(DT,5)
 I $D(^LAB(69.9,1,"RO")),+$H'=+$P(^("RO"),U) D
 . W $C(7),!,"ROLLOVER ",$S($P(^("RO"),U,2):"IS RUNNING.",1:"HAS NOT RUN.")," ACCESSIONING SHOULDN'T BE DONE NOW.",$C(7),!
 . S DIR("A")="  Are you sure you want to continue",DIR(0)="Y",DIR("B")="No"
 I $T D ^DIR G END:$D(DIRUT) I Y'=1 W !,"OK, try later." Q
 S X="T-7",%DT="" D ^%DT S LRTM7=+Y
 K DIC,LRSND,LRSN
 W !!,"Select Order number: " R LRORD:DTIME W ! Q:LRORD["^"!(LRORD[".")!($D(LRLONG)&(LRORD=""))
PAST ; HOWDY IN HERE
 W @IOF S M9=0 G QUICK^LROE1:LRORD=""
 S:LRORD?.N LRORD=+LRORD IF LRORD'?.N D QMSG QUIT
 I '$D(^LRO(69,"C",LRORD)) W !!?10,"No order exist with that number ",$C(7),! QUIT
 S (LRCHK,LRNONE)=1,(M9,LRODT)=0
 F  S LRODT=+$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D
 . S DA=0 F  S DA=$O(^LRO(69,"C",LRORD,LRODT,DA)) Q:DA<1  S LRCHK=LRCHK-1 S:LRNONE'=2 LRNONE=0 D LROE2
 I LRNONE=2 W !,"The order has already been",$S(LRCHK<1:" partially",1:"")," accessioned." H 1
 I LRNONE=1 W !,"No order exists with that number." H 1 QUIT
 I '$$GOT(LRORD,LRODT) QUIT
 K DIR S DIR("A")="Is this the correct order",DIR(0)="Y"
 S DIR("B")="Yes"
 K DIR S Y=1
 I $D(DIRUT)!(Y'=1) K LRSN QUIT
 L +^LRO(69,"C",LRORD):$G(DILOCKTM,3)
 I '$T W !?5,"Someone else is editing this Order",!!,$C(7) QUIT
 K %DT
 S LRSTATUS="",%DT("B")=""
 D TIME K %DT
 D:$G(LRCDT)<1 UNL69 QUIT:LRCDT<1
 S LRTIM=+LRCDT
 S LRUN=$P(LRCDT,U,2) K LRCDT,LRSN
MORE ;
 S M9=0
 S (LRODT,LRSND)=0
 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D
 . S LRSND=0
 . F  S LRSND=$O(^LRO(69,"C",LRORD,LRODT,LRSND)) Q:LRSND<1  D
 . . S LRSN(LRSND)=LRSND,LRSN=LRSND
 . . K LRAA D Q15^LRHYPH2 K LRSN
 D TASK,UNL69
 QUIT
 ;
 ;
LROE2 ;
 I $D(^LRO(69,LRODT,1,DA,1)),$P(^(1),U,4)="" S LRNONE=2,LRCHK=LRCHK+1
 K LRSN
 S (LRSN,LRSN(DA))=+DA
 I '$D(^LRO(69,LRODT,1,LRSN,0)) Q
 S M9=$G(M9)+1,LR3X=^LRO(69,LRODT,1,LRSN,0),LRDFN=+LR3X,LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX
 Q
 ;
 ;
QMSG W !,"Enter the order entry number assigned when the test was ordered."
 W:'$D(LRLONG) !,"If the test has not been ordered, type the RETURN key to order the test."
 W !,"To exit, type the ""^"" key and RETURN key."
 Q
 ;
 ;
YN R X:DTIME W ! S:'$T DTOUT=1 Q:X=""!(X["N")!(X["Y")
 W !,"Answer 'Y' or 'N': " G YN
 ;
 ;
EN ;
LROEN S LRNCWL=1
 D LROE,END K LRNCWL
 Q
 ;
LROE ;
 QUIT
 ;
EN01 ; ENTER ORDER # THEN ENTER DATA
STAT ;
 D ^LRPARAM
 I '$D(LRLABKY) W !!?10,"You do not have the proper security Keys",! Q
 ;
 ; Select peforming laboratory
 S X=$$SELPL^LRVERA(DUZ(2))
 I X<1 D END Q
 I X'=DUZ(2) N LRPL S LRPL=X
 ;
 S LRLONG="",LRPANEL=0,LROESTAT=""
 S %H=$H-60 D YMD^LRX S LRTM60=9999999-X
 D LROE K LRTM60,LRLONG,LREND,LROESTAT
 D END
 Q
 ;
 ;
TIME ;from LROE1, LRORD1
 D NOW^%DTC S LRCDT=% QUIT  ;STUFFED FOR HOWDY
 S %DT="SET" W !,"Collection Date@Time: ",$S($D(%DT("B")):%DT("B"),1:"NOW"),"//" R X:DTIME W ! I '$T!(X="^") S LRCDT=-1 Q
 S:X="" X=$S($D(%DT("B")):%DT("B"),1:"N")
 W:X["?" !!,"You may enter ""T@U"" or just ""U"", for Today at Unknown time",!!
 I X["@U",$P(X,"@U",2)="" S X=$P(X,"@U",1) D ^%DT G TIME:Y<1 S LRCDT=+Y_"^1" Q
 S:X="U" LRCDT=DT_"^1"
 I X'="U" D ^%DT D:X'["?" TIME1 G TIME:X["?" S LRCDT=+Y_"^" G TIME:Y'["."
 Q
 ;
TIME1 S X1=X,Y1=Y D TIME2 S X=X1,Y=Y1 K X1,Y1
 Q
 ;
TIME2 S X="N",%DT="ST" D ^%DT Q:Y1'>Y  F  W !,"You have specified a collection time in the future.  Are you sure" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o."
 S:%'=1 X="?" S X1=X
 Q
 ;
 ;
TASK ;
 ; If traditional Howdy is used this is where labels print-control passes to GT549
 ; If alternative Howdy is used label printing is delayed.
 I $G(^%ZIS(1,LRDEV,0))'["NUL" G T549
 N LRAD S LRAD=0
 N LRX,LRY
 D NOW^%DTC
 S LR3T=%
 S LRX=0
 F  S LRX=$O(LRLBL(LRX)) Q:+LRX'>0  D
 .  S LRY=0
 .  F  S LRY=$O(LRLBL(LRX,LRY)) Q:+LRY'>0  D
 ..  I $P(^LRO(68,LRX,0),U,3)="M" S LRAD=$E(DT,1,5)_"00"
 ..  I $P(^LRO(68,LRX,0),U,3)="Y" S LRAD=$E(DT,1,3)_"0000"
 ..  I '$G(LRAD) S LRAD=DT
 ..  S LRUID=$P($G(^LRO(68,LRX,1,LRAD,1,LRY,.3)),U) I $L(LRUID)<10 D
 ...  S $P(LRLBL(LRX,LRY),U,7)=LRORD
 ...  S LRUID=$P($G(^LRO(68,LRX,1,LRAD,1,LRY,.3)),U)
 ..  S ^XTMP("LRHY LABELS",LRDFN,LR3T,LRUID)=LRLBL(LRX,LRY)
 ..  K LRAD
 I $G(^%ZIS(1,LRDEV,0))["NUL" QUIT
 ;
T549 ; ADDED FOR PPOC APPROACH
 S LRCE=LRORD
 S LRX=0
 F  S LRX=$O(LRLBL(LRX)) Q:+LRX'>0  D
 .  S LRY=0
 .  F  S LRY=$O(LRLBL(LRX,LRY)) Q:+LRY'>0  D
 ..  S $P(LRLBL(LRX,LRY),U,7)=LRCE
 S ZTSAVE("L*")=""
 I $D(LRLABLIO) S ZTRTN="ENT^LRLABLD",ZTDTH=$H,ZTDESC="LAB LABELS",ZTIO=LRLABLIO,ZTSAVE("LRLBL(")="" S:$D(ZTQUEUED) ZTREQ="@" D ^%ZTLOAD
 K LRLBL
 I $D(LRCSQ),$P($G(^LRO(68,+LRAA,0)),U,16) D STD^LRCAPV
 D STOP^LRCAPV K LRCOM,LRSPCDSC,LRCCOM,LRTCOM
 Q
 ;
 ;
END K DIR,DIRUT,LRHYGOT
 D ^LRORDK,LROEND^LRORDK,STOP^LRCAPV
 Q
 ;
 ;
GOT(ORD,ODT) ;See if all tests have been canceled
 N LRHYI,SN,ODT
 S (LRHYGOT,ODT,SN)=0
 F  S ODT=$O(^LRO(69,"C",ORD,ODT)) Q:ODT<1  D
 . S SN=0 F  S SN=$O(^LRO(69,"C",ORD,ODT,SN)) Q:SN<1!(LRHYGOT)  D
 . . Q:'$D(^LRO(69,ODT,1,SN,0))
 . . S LRHYI=0 F  S LRHYI=$O(^LRO(69,ODT,1,SN,2,LRHYI)) Q:LRHYI<1  I $D(^(LRHYI,0)),'$P(^(0),"^",11) S LRHYGOT=1 Q
 Q LRHYGOT
 ;
 ;
UNL69 ;
 L -^LRO(69,"C",+$G(LRORD))
 Q
BCE ;
 S LRCE=$G(LRORD)
 Q:'$D(LRLABLIO)
 S ZTSAVE("L*")=""
 S ZTRTN="ENT^LRLABLD",ZTDTH=$H,ZTDESC="LAB LABELS"
 S ZTIO=LRLABLIO
 S LRDEV=LRLABLIO
 S IO=LRDEV S ZTSAVE("IO*")=""
 S ZTIO=$P(^%ZIS(1,+LRDEV,0),U)
 D ^%ZTLOAD
 K LRLBL
 I $D(LRCSQ),$P($G(^LRO(68,+LRAA,0)),U,16) D STD^LRCAPV
 D STOP^LRCAPV K LRCOM,LRSPCDSC,LRCCOM,LRTCOM
