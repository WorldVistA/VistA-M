LR7OU64 ;SLC/DCM/FHS/DALISC - RESULT CODE NLT LINKING UTILITY AUTO ; 12/3/1997
 ;;5.2;LAB SERVICE;**153,201**;Sep 27, 1994
EN ;
 ;Find matches between file 64 and 60
 D MSG
LIST ;
 K DIR S DIR("A")="Would you like a list of RESULT NLT CODES from LABORATORY TEST file",DIR(0)="Y",DIR("B")="No"
 D ^DIR G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) END I Y=1 D   G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))!(Y=0) END G LK
 . D LST K DIR S DIR("A")="Ready to start linkage procedure ",DIR(0)="Y"
 . D ^DIR
 W ! K DIR S DIR("A")="Ready to proceed",DIR(0)="Y"
 D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIROUT))!(Y'=1) END
LK W !!,$$CJ^XLFSTR("Do you want to automatically link entries when there is an exact match",80)
 W !,$$CJ^XLFSTR("on the NAME in both files",80) S %=2 D YN^DICN G:%=-1 END
 I %=0 W !!,$$CJ^XLFSTR("Answer YES to automatically link the entries, or NO to be prompted for each",80) G LK
 S AUTO=$S(%=1:1,1:0)
LAB ;
 W:$G(AUTO) !?5,"Press Return to Stop Auto Update",!
 S (END,LRN)="" F  S LRN=$O(^LAB(60,"B",LRN)) Q:LRN=""!($G(END))  D
 . S LRIEN="" F  S LRIEN=+$O(^LAB(60,"B",LRN,LRIEN)) Q:LRIEN<1!($G(END))  I '$G(^(LRIEN)) D CHECK
 W:'$G(END) !!,$$CJ^XLFSTR("End of loop",80),!
 G END
 Q
CHECK ;
 S LRMIEN=0
 Q:'$D(^LAB(60,LRIEN,0))#2!('$P(^(0),";",2))!($P($G(^LAB(60,LRIEN,64)),U,2))!($G(END))
 S LRDATA=$P(^LAB(60,LRIEN,0),U),LRTY=$P(^(0),U,3) Q:LRTY=""!(LRTY="N")
 S LRNU=$$UP^XLFSTR(LRN),X=+$O(^LAM("D",LRNU,0)) I $D(^LAM(X,0)),^(0)'["~" S LRMIEN=X
 D:'LRMIEN 64 Q:'LRMIEN!($G(END))
 Q:'$D(^LAM(LRMIEN,0))#2  S LRCODE=$P(^(0),U,2) Q:'LRCODE!($D(^LAB(60,"AE",LRCODE)))
 Q:'$D(^LAM(LRMIEN,0))  S LRMNAME=$P(^(0),U)
 W !!,"60 = ",LRDATA,!,"64 = ",LRMNAME_"   "_LRCODE
 D LINK(LRIEN,LRMIEN,AUTO)
 Q
64 ;Look for NATIONAL VA LAB CODE
 S LRMIEN=0,I=+$P($G(^LAB(60,LRIEN,64)),U,2) I $D(^LAM(I,0)),^(0)'["~" S LRMIEN=I
 Q:'LRMIEN
 W !,$C(7),?5,"Did not find a exact name match for Lab Test "_LRDATA,!
 K DIR
 W !," Want to use the ["_$P(^LAM(LRMIEN,0),U)_"] NATIONAL VA LAB CODE instead?"
 K DIR S DIR(0)="Y" D ^DIR S:Y'=1 LRMIEN=0 Q
 Q
LINK(X60,X641,DOIT) ;Link the 2 files
 S LRDATA="`"_X60 I DOIT S %=1 G L2
L1 W !?5,"Link the two entries" S %=2 D YN^DICN Q:%=2  I %=-1 S END=1 Q
 I $G(DTOUT) S END=1 Q
 I %=0 W !,"Enter Yes to link the entries, No to leave it alone." G L1
L2 K DIE,DA,DR,DIC S DIE="^LAB(60,",DA=X60,DR="64.1///`"_X641,DLAYGO=60 D ^DIE K DLAYGO
 I $P($G(^LAB(60,X60,64)),U,2) W !?32,"o----LINKED----o",! D  Q
 . R X:1 I $T W !?20,"User terminated update",!,$C(7) S END=1
 W !!?15,"***************** NOT LINKED ***************",!
 W !!?5,"Press Return to continue" R X:DTIME S:$G(DTOUT)!($E(X)=U) END=1
 Q
END ;
 Q:$G(LRDBUG)
 K %,AUTO,DA,DIC,DIE,DIR,DOIT,DR,END,LRDATA,LRIEN,LRMIEN,LRN,LRNU
 K LRSUF,LRTY,X,X60,X64,Y,LRMNAME,D1,D0,DLAYGO,I,LRCODE,END
 K FLG,XXX,ZZ,ZZ1,X,Y,Y64,DLAYGO,DX,S
 Q
LST ;
 K ^TMP("LR",$J),DIC I $O(^LAB(60,"AE",0))="" W !,"Nothing in X-Ref to Print.",!! Q
 W !!,$$CJ^XLFSTR("I will produce a list of ",80)
 W !,$$CJ^XLFSTR("NATIONAL VA Code / Result NLT codes from LABORATORY TEST file",80),!
 K %ZIS S %ZIS="QN",%ZIS("A")="Printer Name " D ^%ZIS G:POP CLEAN
 I IO'=IO(0)!($D(IO("Q"))) S ZTRTN="DQ^LR7OU64",ZTIO=ION,ZTDESC="PRINT NLT CODES FROM ^LAB(60 " W !!?10,"Report Queued to "_ION,! D ^%ZTLOAD,^%ZISC G CLEAN
DQ K ^TMP("LR",$J),DX S:$D(ZTQUEUED) ZTREQ="@"
 W !!,$$CJ^XLFSTR("List of NATIONAL VA Code / Result NLT codes from LABORATORY TEST file",80),!!
 W ?6,$$NOW^XLFDT,!
 S LRNLT="" F  S LRNLT=$O(^LAB(60,"AE",LRNLT)) Q:LRNLT=""  D
 . S LRLAB=0 F  S LRLAB=$O(^LAB(60,"AE",LRNLT,LRLAB)) Q:LRLAB<1  D
 . . S ^TMP("LR",$J,$P(^LAB(60,LRLAB,0),U),LRNLT)=LRLAB
 S DIC="^LAB(60,"
 S NODE="^TMP(""LR"","_$J_")" F  S NODE=$Q(@NODE) Q:$QS(NODE,2)'=$J  D
 . S DA=@NODE,DR=64 W !,"Test Name: ",$P(^LAB(60,DA,0),U)
 . D EN^LRDIQ S:$E(IOST,1,2)="P-" S=0
CLEAN K DIC,DA,NODE,LRNLT,LRLAB,DR,DX,S,^TMP("LR",$J)
 Q
MSG W !,$$CJ^XLFSTR("This option will Auto Link NLT RESULT CODE to Laboratory test file (#60).",80)
 W !,$$CJ^XLFSTR("NLT RESULT CODE is used by the LEDI software to identify",80)
 W !,$$CJ^XLFSTR("test results returned by Host Laboratories.",80)
 W !,$$CJ^XLFSTR("ONLY GENERIC NLT CODES CAN BE LINKED TO LAB TEST ",80),!!
 W !,$$CJ^XLFSTR("Only ATOMIC lab tests can have an NLT RESUTL CODE.",80),!
 Q
