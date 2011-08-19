LROE ;DALOI/CJS/FHS-LAB ORDER ENTRY AND ACCESSION ;8/11/97
 ;;5.2;LAB SERVICE;**100,121,201,221,263,286,360**;Sep 27, 1994;Build 1
 K LRORIFN,LRNATURE,LREND,LRORDRR
 S LRLWC="WC"
 D ^LRPARAM
 I $G(LREND) S LREND=0 Q
L5 ;
NEXT ;from LROE1
 K DIR
 I $D(LROESTAT) D:$P(LRPARAM,U,14) ^LRCAPV I $G(LREND) K LRLONG,LRPANEL Q
 S (LRODT,X,DT)=$$DT^XLFDT(),LRODT0=$$FMTE^XLFDT(DT,5)
 I '$D(^LRO(69,DT,1,0)) S ^LRO(69,DT,0)=DT,^LRO(69,DT,1,0)="^69.01PA^^",^LRO(69,"B",DT,DT)=""
 I $D(^LAB(69.9,1,"RO")),+$H'=+$P(^("RO"),U) D
 . W $C(7),!,"ROLLOVER ",$S($P(^("RO"),U,2):"IS RUNNING.",1:"HAS NOT RUN.")," ACCESSIONING SHOULDN'T BE DONE NOW.",$C(7),!
 . S DIR("A")="  Are you sure you want to continue",DIR(0)="Y",DIR("B")="No"
 I $T D ^DIR G END:$D(DIRUT) I Y'=1 W !,"OK, try later." Q
 S X="T-7",%DT="" D ^%DT S LRTM7=+Y
 ;W @IOF
 K DIC,LRSND,LRSN
 W !!,"Select Order number: " R LRORD:DTIME Q:LRORD["^"!(LRORD[".")!($D(LRLONG)&(LRORD=""))
 W @IOF S M9=0 G QUICK^LROE1:LRORD=""
 I $L(LRORD)>8 W !,"The order number entered is too long." H 1 G NEXT
 S:LRORD?.N LRORD=+LRORD IF LRORD'?.N D QMSG G NEXT
 I '$D(^LRO(69,"C",LRORD)) W !!?10,"No order exist with that number ",$C(7),! G NEXT
 S (LRCHK,LRNONE)=1,(M9,LRODT)=0
 F  S LRODT=+$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D
 . S DA=0 F  S DA=$O(^LRO(69,"C",LRORD,LRODT,DA)) Q:DA<1  S LRCHK=LRCHK-1 S:LRNONE'=2 LRNONE=0 D LROE2
 I DOD'="" S Y=DOD D DD^LRX W !,!,?5,@LRVIDO,"Patient ",PNM," died on: ",Y,@LRVIDOF W !
 I DOD'="" D  I Y=0!($D(DIRUT)) K DIRUT,DTOUT,DUOUT,Y D KVAR^LRX G NEXT
 . K Y
 . S DIR(0)="Y"
 . S DIR("A")="Do you wish to continue with this accession [Yes/No]"
 . S DIR("T")=120
 . D ^DIR K DIR
 I LRNONE=2,LRCHK<1 W !,"The order has already been partially accessioned." H 1
 I LRNONE=2,LRCHK>0 W !,"The order has already been accessioned." H 1 G NEXT
 I LRNONE=1 W !,"No order exists with that number." H 1 G NEXT
 I '$$GOT(LRORD,LRODT) G NEXT ;W !!,"All tests for this order have been canceled.",!,"Are you sure you want to accession it" S %=1 D YN^DICN I %'=1 G NEXT
 K DIR S DIR("A")="Is this the correct order",DIR(0)="Y"
 S DIR("B")="Yes"
 D ^DIR K DIR
 I $D(DIRUT)!(Y'=1) K LRSN G NEXT
 L +^LRO(69,"C",LRORD):1
 I '$T W !?5,"Someone else is editing this Order",!!,$C(7) G NEXT
 K %DT
 S LRSTATUS="C",%DT("B")=""
 D TIME K %DT
 D:$G(LRCDT)<1 UNL69 G NEXT:LRCDT<1
 S LRTIM=+LRCDT
 ;S:'$P(^LRO(69,LRODT,1,LRSN,0),U,8) $P(^(0),U,8)=LRTIM
 S LRUN=$P(LRCDT,U,2) K LRCDT,LRSN
MORE I M9>1 K DIR S DIR("A")="Do you have the entire order",DIR(0)="Y" D ^DIR K DIR S:Y=1 M9=0
 I $D(DIRUT) D UNL69 G NEXT
 S (LRODT,LRSND)=0
 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D
 . S LRSND=0
 . F  S LRSND=$O(^LRO(69,"C",LRORD,LRODT,LRSND)) Q:LRSND<1  D
 . . I $D(^LRO(69,LRODT,1,LRSND,1)),$P(^(1),U,4)="C" Q
 . . S LRSN(LRSND)=LRSND,LRSN=LRSND
 . . K LRAA D Q15^LROE2 K LRSN
 D TASK,UNL69
 G NEXT
 ;
 ;
LROE2 ;
 I $D(^LRO(69,LRODT,1,DA,1)),$P(^(1),U,4)="C" S LRNONE=2,LRCHK=LRCHK+1
 K LRSN
 S (LRSN,LRSN(DA))=+DA
 I '$D(^LRO(69,LRODT,1,LRSN,0)) Q
 S M9=$G(M9)+1,LRZX=^LRO(69,LRODT,1,LRSN,0),LRDFN=+LRZX,LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX W !,PNM,?30,SSN S LRWRDS=LRWRD
 W ?45,"Requesting location: ",$P(LRZX,U,7) S Y=$P(LRZX,U,5) D DD^LRX W !,"Date/Time Ordered: ",Y,?45,"By: ",$S($D(^VA(200,+$P(LRZX,U,2),0)):$P(^(0),U),1:"")
 S LRSVSN=LRSN D ORDER^LROS S LRSN=LRSVSN
 Q
 ;
 ;
QMSG W !,"Enter the order entry number assigned when the test was ordered."
 W:'$D(LRLONG) !,"If the test has not been ordered, type the RETURN key to order the test."
 W !,"To exit, type the ""^"" key and RETURN key."
 Q
 ;
 ;
YN R X:DTIME S:'$T DTOUT=1 Q:X=""!(X["N")!(X["Y")
 W !,"Answer 'Y' or 'N': " G YN
 ;
 ;
EN ;
LROEN S LRNCWL=1
 D LROE,END K LRNCWL
 Q
 ;
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
 S %DT="SET" W !,"Collection Date@Time: ",$S($D(%DT("B")):%DT("B"),1:"NOW"),"//" R X:DTIME I '$T!(X="^") S LRCDT=-1 Q
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
 I $D(LRLABLIO),$D(LRLBL) S ZTRTN="ENT^LRLABLD",ZTDTH=$H,ZTDESC="LAB LABELS",ZTIO=LRLABLIO,ZTSAVE("LRLBL(")="" D ^%ZTLOAD
 K LRLBL
 I $D(LRCSQ),'$O(^XTMP("LRCAP",LRCSQ,DUZ,0)) K ^XTMP("LRCAP",LRCSQ,DUZ),LRCSQ
 I $D(LRCSQ),$P($G(^LRO(68,+LRAA,0)),U,16) D STD^LRCAPV
 D STOP^LRCAPV K LRCOM,LRSPCDSC,LRCCOM,LRTCOM
 Q
 ;
 ;
END K DIR,DIRUT,GOT
 D ^LRORDK,LROEND^LRORDK,STOP^LRCAPV
 Q
 ;
 ;
GOT(ORD,ODT) ;See if all tests have been canceled
 N I,SN,ODT
 S (GOT,ODT,SN)=0
 F  S ODT=$O(^LRO(69,"C",ORD,ODT)) Q:ODT<1  D
 . S SN=0 F  S SN=$O(^LRO(69,"C",ORD,ODT,SN)) Q:SN<1!(GOT)  D
 . . Q:'$D(^LRO(69,ODT,1,SN,0))
 . . S I=0 F  S I=$O(^LRO(69,ODT,1,SN,2,I)) Q:I<1  I $D(^(I,0)),'$P(^(0),"^",11) S GOT=1 Q
 Q GOT
 ;
 ;
UNL69 ;
 L -^LRO(69,"C",+$G(LRORD))
 Q
