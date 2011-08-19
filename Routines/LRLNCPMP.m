LRLNCPMP ;DALOI/FHS - PRINT LAB TESTS MAPPED/NOT MAPPED TO LOINC CODES ;1-OCT-1998
 ;;5.2;LAB SERVICE;**215,232,278,303**;Sep 27,1994
EN ;
 W @IOF K LRMAP,LREND
 W !,$$CJ^XLFSTR("This option prints a list of the LABORATORY TESTS from the LABORATORY TEST FILE.",IOM)
 W !,$$CJ^XLFSTR("You will be prompted to print lab tests that are",IOM)
 W !,$$CJ^XLFSTR("mapped/not mapped to a LOINC code.",IOM)
 W !,$$CJ^XLFSTR("Inactive(Type:Neither) lab tests are not reported.",IOM)
WHICH ;
 W !!!,"Print lab tests that are mapped/not mapped to a LOINC code."
 K DIR,LRMAP
 S DIR("?")="Select 1 for mapped, 0 for not mapped or 2 for Individual"
 S DIR(0)="SO^0:Not Mapped;1:Mapped test;2:Individual Mapped Test"
 D ^DIR K DIR
 I Y=""!($D(DIRUT)) D EXIT Q
 S LRMAP=Y
 D:+Y=2 SING G:$G(LREND) EXIT
 K %ZIS S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D QUE Q
 ;
 U IO
 D START,^%ZISC
 Q
 ;
 ;
SING ; Select individual lab test for report
 I LRMAP=2 D
 . K LRMAP
 . S LREND=0,LRMAP=2
 . W !,$$CJ^XLFSTR("You can only select test that have been mapped.",IOM)
 . W !,$$CJ^XLFSTR("You can a quick list of mapped tests by entering '?'.",IOM)
 . W !,$$CJ^XLFSTR("Then enter 'Yes' you want a complete list.",IOM),!
 . K DIR,X,Y
 . S DIR(0)="PO^60:EZNMQ"
 . S DIR("S")="I $S($D(^LAM(""AL"",+Y)):1,$D(^LAM(""AM"",+Y)):1,1:0)"
 . S DIR("?")="You must select a Mapped LABORATORY TEST"
 . F  D ^DIR Q:Y<1!($D(DIRUT))  S LRMAP(+Y)=Y
 . I '$O(LRMAP(0)) W !!?5,"Nothing Selected" S LREND=1
 Q
QUE ;
 S ZTRTN="START^LRLNCPMP"
 S ZTDESC="LAB TESTS MAP REPORT",ZTSAVE("LRMAP*")=""
 D ^%ZTLOAD
 I $D(ZTSK)'[0 W !,"REQUEST QUEUED ",ION
 D HOME^%ZIS
 K IO("Q")
 Q
 ;
 ;
START ; Begins report
 N LINE,LOINCDTA,LOINCDTB,LOINCTAS,LRAA,LRAA1,LRPNTA,LRPNTB,LRSUB
 S LINE=0
 D INI
 I LRMAP'=2 D EN1
 I LRMAP=2 D
 . S LRIEN=0
 . F  S LRIEN=$O(LRMAP(LRIEN)) Q:LRIEN<1  S LRNODE=$G(^LAB(60,LRIEN,0)) D YMAP
 D YMAPPRT,EXIT
 Q
 ;
 ;
EN1 ; Print mapped or not mapped lab tests if there is a data name 
 S LRTEST=""
 S LRTST="^LAB(60,""B"",0)"
 F  S LRTST=$Q(@LRTST) Q:$QS(LRTST,2)'="B"  D  Q:$G(LREND)
 . Q:$G(@LRTST)
 . S LRIEN=$QS(LRTST,4)
 . Q:'$D(^LAB(60,LRIEN,0))#2  S LRNODE=^(0)
 . I $S($P(LRNODE,U,3)="":1,$P(LRNODE,U,3)="N":1,'$P($P(LRNODE,U,5),";",2):1,1:0) Q
 . N LRNLT
 . S LRNLT=+$P($G(^LAB(60,LRIEN,64)),U,2)
 . I 'LRMAP,$S(('$D(^LAM("AL",LRIEN))&('$D(^LAM("AM",LRIEN)))):1,1:0) D NMAP
 . I LRMAP,$S($D(^LAM("AL",LRIEN)):1,$D(^LAM("AM",LRIEN)):1,1:0) D YMAP
 Q
 ;
 ;
YMAPPRT I $D(^TMP($J,"LRDATA")) D
 . S LRPRT=0
 . F  S LRPRT=$O(^TMP($J,"LRDATA",LRPRT)) Q:LRPRT=""  D  Q:$G(LREND)
 .. I $Y+4>IOSL D HDR Q:$G(LREND)
 .. W !,^TMP($J,"LRDATA",LRPRT)
 Q
 ;
 ;
NMAP ;
 I $Y+4>IOSL D HDR Q:$G(LREND)
 S LRTESTN=$P(LRNODE,U)
 W !,?1,LRTESTN
 S LRNLT=$P($G(^LAB(60,LRIEN,64)),U,2)
 I LRNLT D
 . N LROUT
 . D GETS^DIQ(64,LRNLT_",",".01;1","E","LROUT")
 . W !?5,$G(LROUT(64,LRNLT_",",1,"E")),?18,$G(LROUT(64,LRNLT_",",.01,"E"))
 W !
 Q
 ;
 ;
YMAP ;
 S LINE=$G(LINE)+1
 S ^TMP($J,"LRDATA",LINE)="LAB TEST :  "_$P(LRNODE,U),LINE=LINE+1
 S LRSUB="LOCAL REPORT"
 N LRA,LRNLTX
 S LRNLT=0
 F  S LRNLT=$O(^LAM("AM",LRIEN,LRNLT)) Q:LRNLT=""  I '$D(LRNLTX(LRNLT)) D
 . S LRA=LRNLT,LRNLTX(LRNLT)=1
 . D LOINCLA^LRSRVR1
 S LRNLT=0
 F  S LRNLT=$O(^LAM("AL",LRIEN,LRNLT)) Q:LRNLT=""  I '$D(LRNLTX(LRNLT)) D
 . S LRA=LRNLT,LRNLTX(LRNLT)=1
 . D LOINCLA^LRSRVR1
 S LINE=$G(LINE)+1,^TMP($J,"LRDATA",LINE)="-------------------"
 S LINE=LINE+1,^TMP($J,"LRDATA",LINE)="",LINE=LINE+1
 Q
 ;
 ;
INI ; Initialize variables
 K ^TMP($J,"LRDATA")
 S (LREND,LRPAGE)=0,$P(LRLINE,"=",(IOM-1))=""
 S LRPDT=$$HTE^XLFDT($H,"MZ")
 ;
HDR ; Print heading
 I LRPAGE,$E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R N:DTIME S LREND='$T!(N="^") Q:LREND
 S LRPAGE=LRPAGE+1
 W @IOF,!?16,"LAB TESTS"_$S(LRMAP=2:" Individual Mapped",LRMAP=1:" Mapped",LRMAP'=1:" NOT Mapped",1:0)_" TO LOINC CODES"
 W !?5,LRPDT,?(IOM-15)," Page ",$J(LRPAGE,3)
 I 'LRMAP W !,?5,"LAB TEST"
 I 'LRMAP W !,?10,"RESULT NLT"
 W !,LRLINE,!
 Q
 ;
 ;
EXIT I $E(IOST,1,2)="P-" W @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 Q:$G(LRDBUG)
 K DIR,DIRUT,LREND,LRPAGE,I,J,LRA,LRLOC,LRIEN,LRPREV,ZTIO,ZTDESC,ZTRTN
 K LRMAP,LRSPEC,LRTEST,LRTESTN,LRLOINC,LRPDT,LRLINE,LRX,DUOUT,ZTSAVE
 K LRNLT,LRNLTN,LRNODE,LRPRT,LRSPECN,LRTST,N,Y,POP,ZTSK,ZTQUEUED,ZTREQ
 K ^TMP($J,"LRDATA")
 Q
