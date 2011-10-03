LR7OU641 ;SLC/DCM/DALOI/FHS - RESULT NLT LINKING UTILITY SEMI-MANUAL ; 12/3/1997
 ;;5.2;LAB SERVICE;**153,201,278,280**;Sep 27, 1994
 ;
EN ;
64 ;User assigns links between 60 (64.1) and 64 (NLT)
 K DX S LREND=0 D LLIST S LREND=0
 I '$O(^LAB(60,"AE",0)) D  H 5
 . W !?5,"You have not yet ran the Semi-automatic Linking of RESULT NLT  option",!
 . W !?20,"[LR70 641-64 AUTO]",!
 . W !,"IT IS STRONGLY RECOMMENDED YOU RUN THE AUTOMATIC OPTION FIRST",!!
 W !,$$CJ^XLFSTR("This option will allow you to assign RESULT NLT Code to Atomic Lab Tests.",80)
 W !,$$CJ^XLFSTR("You must select any WKLD CODE ",80)
 W !,$$CJ^XLFSTR("Tests with the type of NEITHER or null will be skipped in the Auto Mode.",80)
 W !,$$CJ^XLFSTR("ONLY ATOMIC LAB TEST YIELDING RESULTS SHOULD BE ASSIGNED RESULT CODES.",80),!!
 K DIR S DIR("A")="Print list of both NLT and RESULT NLT CODES from LABORATORY TEST file",DIR(0)="Y",DIR("B")="No"
 D ^DIR K DIR G:$D(DIRUT) END I Y=1 D   G:$D(DIRUT)!(Y=0) END G START
 . D ^LRCAPD K DIR S DIR("A")="Ready to start RESULT NLT CODE linkage procedure ",DIR(0)="Y"
 . D ^DIR K DIR
MSG ;
 W ! K DIR S DIR("A")="Ready to proceed",DIR(0)="Y"
 D ^DIR K DIR G:$D(DIRUT)!(Y'=1) END
START W ! K DIR S DIR("A")="Select Linking Method ",DIR(0)="S^M:Manual;S:Semi-Auto",DIR("?")="Linking method description"
 W !!,$$CJ^XLFSTR(DIR("A"),80)
 F I=1:1 S LN=$P($T(TXT+I),";;",2) Q:LN="END"  S DIR("?",I)=LN W !,$$LJ^XLFSTR(LN,80)
 W !! K I,LN D ^DIR K DIR G:$D(DIRUT) END G:Y="M" SEL
LIST ;
 K DIR W !!?5,"Select a starting TEST NAME " R LRN:DTIME G:'$T!($E(LRN)="^") END
LK ;
 W ! S LRAUTO=0 S:$L(LRN)>1 LRN=$E(LRN,1,($L(LRN)-1))
LAB ;
 S LREND="" F  S LRN=$O(^LAB(60,"B",LRN)) Q:LRN=""!($G(LREND))  D
 . S LRIEN="" F  S LRIEN=+$O(^LAB(60,"B",LRN,LRIEN)) Q:LRIEN<1!($G(LREND))  D:'$G(^(LRIEN)) CHECK
 W:'$G(LREND) !!,$$CJ^XLFSTR("End of loop",80),!
 G END
 Q
CHECK ;
 Q:'$P(^LAB(60,LRIEN,0),";",2)
 K DIC Q:'$D(^LAB(60,LRIEN,0))#2!($P($G(^LAB(60,LRIEN,64)),U,2))!($G(LREND))
 S LRDATA=$P(^LAB(60,LRIEN,0),U),LRTY=$P(^(0),U,3) Q:LRTY=""!(LRTY="N")
 S X60=LRIEN D SELX
 Q
END ;
 K DIRUT,LRAUTO,LRDATA,LREND,LRANS,LRIEN,LRN,LRNLT,LRTY,N,X,X60,Y,Y64,ZTSAVE
 D END^LR7OU64
 Q
SEL ;
 S LRAUTO=1
 I $G(LREND),LRAUTO=1 G END
 W @IOF
 K DIC,DIR,DR,DA,DIE S DIC("A")="You may select any ATOMIC test in LABORATORY TEST FILE: "
 S DIC="^LAB(60,",DIC(0)="AEQZMN",DIC("S")="I $P(^(0),"";"",2)" D ^DIC K DIC G:Y<1 END
 S LRDATA=$P(Y(0),U),(LRIEN,X60)=+Y
SELX L +^LAB(60,LRIEN):2
 I '$T W !?4,"Locked by another user" Q:'LRAUTO  G:LRAUTO SEL
 I $P($G(^LAB(60,X60,64)),U,2),$D(^LAM(+$P(^(64),U,2),0)) S Y64=^(0) D
 . W !!?5,"Currently linked to [ ",$P(Y64,U)_" ]   "_$P(Y64,U,2),!!
 W !!,"Now select a RESULT NLT CODE for "_LRDATA,!
 K DIC,DIE,DR,DA
 S DA=LRIEN,(DIC,DIE)="^LAB(60,",DR=64.1
 D ^DIE
 L -^LAB(60,LRIEN)
 I $D(Y) S LREND=1 Q
 W !!?3,"IEN: [",DA,"] ",$P(^LAB(60,LRIEN,0),U),"  RESULT NLT CODE: ",$$GET1^DIQ(60,LRIEN_",",64.1,"")
 K DA,DIC,DIE,DR
 Q:'$G(LRAUTO)
 K DIR S DIR(0)="E" D ^DIR K DIR S:$D(DIRUT) LREND=1 Q:$G(LREND)
 G SEL
 ;
TXT ;;
 ;;           Linking RESULT NLT CODE methods description
 ;;
 ;;                    ONLY ATOMIC LAB TEST
 ;;      YIELDING A RESULT CAN BE LINKED TO RESULT NLT CODES.
 ;;
 ;;(S) You can use the semi automated method, which will provide a
 ;;alphabetical listing of LABORATORY TEST names. The system will prompt
 ;;you for those tests not already assigned a RESULT NLT CODE.
 ;;Tests with null TYPE or with the type of NEITHER are excluded.
 ;; 
 ;;(M) Using the Manual method, you are able to select ANY ATOMIC test
 ;;regardless of the type field in the LABORATORY TEST file,
 ;;and assign it a RESULT NLT CODE. If the test is already linked 
 ;;the system will display the code and allow you to change
 ;;the RESULT NLT CODE assigned. This method will allow you to
 ;;change linked LABORATORY TEST to another RESULT NLT CODE.
 ;;END
 Q
 ;
LLIST ;
 K DIR
 S DIR("A")="Would you like a list of Result NLT linked codes"
 S DIR(0)="S^0:No;1:ALL;2:Linked;3:Unlinked"
 D ^DIR
 Q:$D(DIRUT)!(Y=0)
 S LRANS=Y
 K %ZIS
 S %ZIS="Q" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTRTN,ZTSAVE
 . S ZTRTN="DQ^LR7OU641",ZTSAVE("LRANS")="",ZTDESC="List of Result NLT Linked Codes"
 . D ^%ZTLOAD W !,$S($G(ZTSK):"Task Number "_ZTSK,1:"Failed to Queue Job")
 . D ^%ZISC
 ;
DQ U IO I $D(ZTQUEUED) S ZTREQ="@"
 W !!?5,"Listing of ",$S(LRANS=1:"ALL",LRANS=2:"LINKED",1:"UNLINKED")," Laboratory Test   [ ",$$HTE^XLFDT($H)," ] ",!!
 S LRN=""  F  S LRN=$O(^LAB(60,"B",LRN)) Q:LRN=""!($G(LREND))  S LRIEN="" D
 . F  S LRIEN=+$O(^LAB(60,"B",LRN,LRIEN)) Q:LRIEN<0!($G(^(LRIEN)))!($G(LREND))  Q:'$D(^LAB(60,LRIEN,0))  S LRTY=$P(^(0),U,3) Q:LRTY=""  D
 . . I LRANS=1 D PRT Q
 . . I LRANS=2,$P($G(^LAB(60,LRIEN,64)),U,2) D PRT Q
 . . I LRANS=3,'$P($G(^LAB(60,LRIEN,64)),U,2) D PRT Q
 W !?20,"****  End of Print List  ****",!!!
 W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
PRT ;
 I $E(IOST,1,2)="C-",$Y>(IOSL-4) K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) LREND=1 Q:$G(LREND)  W @IOF
 W !?5,LRN,?45,"[ ",$S(LRTY="B":"BOTH",LRTY="N":"NEITHER",LRTY="O":"OUTPUT",1:"INPUT")," ]",!
 S LRNLT=$G(^LAB(60,LRIEN,64))
 I $D(^LAM(+$P(LRNLT,U),0)) W !,"National VA LAB CODE",?23,$P(^(0),U,2),"  ",$P(^(0),U)
 I $D(^LAM(+$P(LRNLT,U,2),0)) W !,"Result NLT Code",?23,$P(^(0),U,2),"  ",$P(^(0),U)
 W ! Q
