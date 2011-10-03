LRLNCNLT ;DALOI/FHS-PRINT LAB TEST W/O RESULT NLT CODE ;1-OCT-1998
 ;;5.2;LAB SERVICE;**215,278**;Sep 27,1994
EN ;
 W @IOF,!! S LREND=0
 W $$CJ^XLFSTR("This option will print tests and their RESULT NLT CODES",IOM)
 W !,$$CJ^XLFSTR("assigned. Result NLT codes are required for LEDI and LOINC",IOM)
 W !,$$CJ^XLFSTR("Mapping software to function properly.",IOM)
 W !,$$CJ^XLFSTR("You may use the option 'Link Result NLT Manual' to make necessary changes.",IOM)
ASK ;
 K DIR S DIR(0)="S^0:All Lab Tests;1:Lab Tests with Result NLT Codes;2:Lab Tests without Result NLT Codes"
 S DIR("?")="All will print Lab Tests with and w/o result NLT codes tests"
 D ^DIR K DIR
 G END:$S($G(DIRUT):1,$G(DUOUT):1,$G(DTOUT):1,1:0)
 S LRSEL=Y
 K %ZIS S %ZIS="Q" D ^%ZIS
 G END:POP
 I IO'=IO(0) S ZTRTN="DQ^LRLNCNLT",ZTIO=ION,ZTDESC="Print Lab Tests and Result Codes",ZTSAVE("LRSEL")="" D ^%ZTLOAD I $D(ZTSK)'[0 W !!?5," Tasked to Print on : ",ION G END
 W @IOF D DQ G END
 Q
DQ ;
 N DIR,LREND
 S:$D(ZTQUEUED) ZTREQ="@" S LRPDT=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S (LRPAGE,LRCNT,LREND)=0
 D HDR
 S LRNODE="^LAB(60,""B"",0)",LRCNT=0
 F  S LRNODE=$Q(@LRNODE) Q:$QS(LRNODE,2)'="B"  Q:$G(LREND)  D
 . Q:$G(@LRNODE)!($G(LREND))
 . S LRIEN=$QS(LRNODE,4),LRNAME=$QS(LRNODE,3),LRC=$P($G(^LAB(60,LRIEN,64)),U,2)
 . S LRX=$G(^LAB(60,+$G(LRIEN),0)) Q:$P(LRX,U,3)=""
 . Q:"BO"'[$P(LRX,U,3)
 . I $G(LRSEL)=2,LRC Q
 . I $G(LRSEL)=1,'LRC Q
 . S LRCNT=$G(LRCNT)+1
 . D TOF Q:$G(LREND)
 . W !,$$RJ^XLFSTR(LRIEN,5),?8,LRNAME
 . I $G(LRC) D NLTPRT(LRC)
 Q
NLTPRT(LRC) ;
 D TOF Q:LREND
 N LRSPEC
 I '$D(^LAM(LRC,0))#2 W !?15," **** Corrupt DATABASE ****" Q
 W !?5,"[ ",$P(^LAM(LRC,0),U,2),?18,$P(^(0),U)," ]",!
 S LRSPEC=0 F  S LRSPEC=$O(^LAB(60,LRIEN,1,LRSPEC)) Q:LRSPEC<1!($G(LREND))  D
 . S LRX=+$G(^LAB(60,LRIEN,1,LRSPEC,95.3)) Q:'LRX
 . I $Y>(IOSL-4) D TOF1 Q:$G(LREND)  W !,$$RJ^XLFSTR(LRIEN,5),?8,LRNAME
 . W !?10,"Specimen [ ",$P($G(^LAB(61,LRSPEC,0)),U),"]  Mapped to LOINC CODE"
 . W !,$G(^LAB(95.3,LRX,80)),!
 Q
END ;
 I $G(LRCNT) W !?20,"Total Printed Tests: ",LRCNT,!
 I $E(IOST)="P-" W @IOF
 D ^%ZISC
 K DIR,DIRUT,DUOUT,LRC,LRCNT,LREND,LRIEN,LRNAME,LRNODE,LRPAGE
 K LRPDT,LRSEL,LRX,POP,ZTIO,ZTDESC,ZTRTN,ZTSAVE
 ;
 Q
TOF ;
 Q:$Y<(IOSL-3)
TOF1 I $E(IOST,1,2)="C-" D  Q:$G(LREND)
 . S DIR(0)="E" D ^DIR
 . S:$S($G(DIRUT):1,$G(DUOUT):1,1:0) LREND=1
HDR ;
 I $G(LRPAGE) W @IOF
 S LRPAGE=$G(LRPAGE)+1 W !,?5,LRPDT,?60,"Page: ",LRPAGE
 W !,$$CJ^XLFSTR("Alphabetical Listing of CH Subscripted Lab Tests",IOM)
 I $G(LRSEL)=1 W !,$$CJ^XLFSTR("That have RESULT NLT CODES assigned",IOM),!
 I $G(LRSEL)=2 W !,$$CJ^XLFSTR("That do not have RESULT NLT CODES assigned",IOM),!
 W !,"  IEN     Lab Test Name " I $G(LRSEL)=2 W ! Q
 W !,"      NLT #        Result NLT Code Name ",!
 Q
