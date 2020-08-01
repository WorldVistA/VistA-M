ISIIMPL1 ;ISI GROUP/MLS -- LABS IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 93
 ;
 Q
LRZOE ;DALOI/CJS/FHS-LAB ORDER ENTRY AND ACCESSION ;12/6/06 17:45
 ;;5.2;LAB SERVICE;**100,121,201,221,263,286**;Sep 27, 1994
 K LRORIFN,LRNATURE,LREND,LRORDRR
 S LRLWC="WC"
 ;D EN^LRPARAM
 ;I $G(LREND) S LREND=0 Q
L5 ;
NEXT ;from LROE1
 K DIR
 I $D(LROESTAT) D:$P(LRPARAM,U,14) ^LRCAPV I $G(LREND) K LRLONG,LRPANEL Q
 S (LRODT,X,DT)=$$DT^XLFDT(),LRODT0=$$FMTE^XLFDT(DT,5)
 I '$D(^LRO(69,DT,1,0)) S ^LRO(69,DT,0)=DT,^LRO(69,DT,1,0)="^69.01PA^^",^LRO(69,"B",DT,DT)=""
 ; I $D(^LAB(69.9,1,"RO")),+$H'=+$P(^("RO"),U) D  ;;MLS
 ; . W $C(7),!,"ROLLOVER ",$S($P(^("RO"),U,2):"IS RUNNING.",1:"HAS NOT RUN.")," ACCESSIONING SHOULDN'T BE DONE NOW.",$C(7),! ;;MLS
 ; . S DIR("A")="  Are you sure you want to continue",DIR(0)="Y",DIR("B")="No" ;;MLS
 ; I $T D ^DIR G END:$D(DIRUT) I Y'=1 W !,"OK, try later." Q ;;MLS
 S X="T-7",%DT="" D ^%DT S LRTM7=+Y
 ;W @IOF
 K DIC,LRSND,LRSN
 S (LRORD,LRZORD)=$O(^TMP("LRVEHU",$J,0)) Q:'LRORD  ;; JFR
 S M9=0 ;W:0 @IOF S M9=0 G QUICK^LROE1:LRORD="" ;; MLS
 S:LRORD?.N LRORD=+LRORD IF LRORD'?.N S ISIRC="-1^Cannot locate order (ISIIMPL1)" Q  ;D QMSG G NEXT ;;MLS
 ; I '$D(^LRO(69,"C",LRORD)) W !!?10,"No order exist with that number ",$C(7),! G NEXT ;;MLS
 I '$D(^LRO(69,"C",LRORD)) G NEXT ;; MLS
 S (LRCHK,LRNONE)=1,(M9,LRODT)=0
 F  S LRODT=+$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D
 . S DA=0 F  S DA=$O(^LRO(69,"C",LRORD,LRODT,DA)) Q:DA<1  S LRCHK=LRCHK-1 S:LRNONE'=2 LRNONE=0 D LROE2
 I LRNONE=2 ; W !,"The order has already been",$S(LRCHK<1:" partially",1:"")," accessioned." H 1 ;;MLS
 I LRNONE=1 S ISIRC="-1^No order exists/was created (ISIIMPL1)." Q ;W !,"No order exists with that number." H 1 G NEXT ;;MLS
 I '$$GOT(LRORD,LRODT) G NEXT
 L +^LRO(69,"C",LRORD):1
 I '$T G NEXT ;; Try again ;; MLS
 ; I '$T W !?5,"Someone else is editing this Order",!!,$C(7) G NEXT ;;MLS
 K %DT
 S LRSTATUS="C",%DT("B")=""
 D TIME K %DT
 D:$G(LRCDT)<1 UNL69 G NEXT:LRCDT<1
 S LRTIM=+LRCDT
 ;S:'$P(^LRO(69,LRODT,1,LRSN,0),U,8) $P(^(0),U,8)=LRTIM
 S LRUN=$P(LRCDT,U,2) K LRCDT,LRSN
MORE ;I M9>1 K DIR S DIR("A")="Do you have the entire order",DIR(0)="Y" D ^DIR K DIR S:Y=1 M9=0 ;;MLS
 I M9>1 S M9=0 ;;MLS
 I $D(DIRUT) D UNL69 G NEXT
 S (LRODT,LRSND)=0
 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:LRODT<1  D
 . S LRSND=0
 . F  S LRSND=$O(^LRO(69,"C",LRORD,LRODT,LRSND)) Q:LRSND<1  D
 . . S LRSN(LRSND)=LRSND,LRSN=LRSND
 . . K LRAA D Q15^ISIIMPL4 K LRSN
 D TASK,UNL69
 Q
 ;
LROE2 ;
 I $D(^LRO(69,LRODT,1,DA,1)),$P(^(1),U,4)="C" S LRNONE=2,LRCHK=LRCHK+1
 K LRSN
 S (LRSN,LRSN(DA))=+DA
 I '$D(^LRO(69,LRODT,1,LRSN,0)) Q
 S M9=$G(M9)+1,LRZX=^LRO(69,LRODT,1,LRSN,0),LRDFN=+LRZX,LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX S LRWRDS=LRWRD ;W !,PNM,?30,SSN 
 ;W ?45,"Requesting location: ",$P(LRZX,U,7) S Y=$P(LRZX,U,5) D DD^LRX W !,"Date/Time Ordered: ",Y,?45,"By: ",$S($D(^VA(200,+$P(LRZX,U,2),0)):$P(^(0),U),1:"")
 S LRSVSN=LRSN D ORDER^ISIIMPL3 S LRSN=LRSVSN ; JFR 
 Q
 ;
 ;
QMSG ;W !,"Enter the order entry number assigned when the test was ordered."
 ;W:'$D(LRLONG) !,"If the test has not been ordered, type the RETURN key to order the test."
 ;W !,"To exit, type the ""^"" key and RETURN key."
 Q
 ;
 ;
YN ;R X:DTIME S:'$T DTOUT=1 Q:X=""!(X["N")!(X["Y") ;;MLS
 S X="Y" Q ;;MLS - when in doubt, say "YES"
 ;W !,"Answer 'Y' or 'N': " G YN
 ;
 ;
TIME ;from LROE1, LRORD1
 S %DT="ST" ;W !,"Collection Date@Time: ",$S($D(%DT("B")):%DT("B"),1:"NOW"),"//" R X:DTIME I '$T!(X="^") S LRCDT=-1 Q
 ;S:X="" X=$S($D(%DT("B")):%DT("B"),1:"N")
 S X=$G(^TMP("LRVEHU",$J,"COLL")) ; JFR   stuff collection time
 I X["@U",$P(X,"@U",2)="" S X=$P(X,"@U",1) D ^%DT G TIME:Y<1 S LRCDT=+Y_"^1" Q
 S:X="U" LRCDT=DT_"^1"
 I X'="U" D ^%DT D:X'["?" TIME1 G TIME:X["?" S LRCDT=+Y_"^" G TIME:Y'["."
 Q
 ;
TIME1 S X1=X,Y1=Y D TIME2 S X=X1,Y=Y1 K X1,Y1
 Q
 ;
TIME2 S X="N",%DT="ST" D ^%DT Q:Y1'>Y  S %=1 ;F  W !,"You have specified a collection time in the future.  Are you sure" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o."
 S:%'=1 X="?" S X1=X
 Q
 ;
 ;
TASK ;
 K LRLABLIO
 I $D(LRLABLIO),$D(LRLBL) S ZTRTN="ENT^LRLABLD",ZTDTH=$H,ZTDESC="LAB LABELS",ZTIO=LRLABLIO,ZTSAVE("LRLBL(")="" D ^%ZTLOAD
 K LRLBL
 I $D(LRCSQ),'$O(^XTMP("LRCAP",LRCSQ,DUZ,0)) K ^XTMP("LRCAP",LRCSQ,DUZ),LRCSQ
 I $D(LRCSQ),$P($G(^LRO(68,+LRAA,0)),U,16) D STD^LRCAPV
 D STOP^LRCAPV K LRCOM,LRSPCDSC,LRCCOM,LRTCOM
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
