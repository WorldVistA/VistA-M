QAQAPGRP ;HISC/DAD-LOAD\UNLOAD APPLICATION GROUPS ;9/3/93  13:17
 ;;1.7;QM Integration Module;;07/25/1995
 K DIC S DIC="^DIC(9.4,",DIC(0)="AEMNQZ" D ^DIC K DIC G:Y'>0 EXIT S QAQANMSP=$P(Y(0),"^",2)
EN1 ; *** Package Entry Point
 ;
 ;  Requires:  QAQANMSP = Package namespace
 ;  Optional:  QAQAPROG = $TEXT routine (DO @QAQAPROG)
 ;                        Entry point to build list of default files
 ;                        in ^UTILITY($J,"QAQA",File#) = File_Name.
 ;                        Format: [TAG^]ROUTINE (TAG and ^ optional)
 ;
 G EXIT:$S($D(QAQANMSP)[0:1,QAQANMSP="":1,QAQANMSP'?.U:1,$L(QAQANMSP)+1\3-1:1,1:0) K ^UTILITY($J,"QAQA"),^UTILITY($J,"QAQA DEL")
 W !!,"Checking the ",QAQANMSP," application group"
 I $D(QAQAPROG)#2,QAQAPROG]"" S:QAQAPROG'["^" QAQAPROG="^"_QAQAPROG S X=$P(QAQAPROG,"^",2) X ^%ZOSF("TEST") I  D @QAQAPROG
 F QAFILE=0:0 S QAFILE=$O(^DIC("AC",QAQANMSP,QAFILE)) Q:QAFILE'>0  S ^UTILITY($J,"QAQA",QAFILE)=$P(^DIC(QAFILE,0),"^") W "."
ASK ;
 R !!,"Select FILE: ",X:DTIME S:'$T X="^" G EXIT:$E(X)="^",OK:X="" S QADELETE=($E(X)="-"),X=$S(QADELETE:$E(X,2,999),1:X) I $E(X)="?" D HELP G ASK
 S DIC="^DIC(",DIC(0)="EMNQZ",DIC("S")="I Y'<2" D ^DIC K DIC G:Y'>0 ASK S QAFILE=+Y,QAFILE(0)=$P(Y(0),"^")
 I QADELETE D
 . I $D(^UTILITY($J,"QAQA",QAFILE))[0 W " ??",*7 Q
 . S ^UTILITY($J,"QAQA DEL",QAFILE)=QAFILE(0)
 . K ^UTILITY($J,"QAQA",QAFILE)
 . Q
 E  S ^UTILITY($J,"QAQA",QAFILE)=QAFILE(0) K ^UTILITY($J,"QAQA DEL",QAFILE)
 G ASK
OK ;
 I $O(^UTILITY($J,"QAQA",0))'>0,$O(^UTILITY($J,"QAQA DEL",0))'>0 W !!?3,"*** No files selected !! ***",*7 G EXIT
 W !!,"Load / Unload application groups" S %=2 D YN^DICN G:(%=-1)!(%=2) EXIT I '% W !!?5,"Please answer Y(es) or N(o)" G OK
 W !!,"Loading:" I $O(^UTILITY($J,"QAQA",0)) D
 . F QAFILE=0:0 S QAFILE=$O(^UTILITY($J,"QAQA",QAFILE)) Q:QAFILE'>0  D
 .. K DD,DIC,DINUM,DO
 .. S:$D(^DIC(QAFILE,"%",0))[0 ^(0)="^1.005^^"
 .. S DA(1)=QAFILE,DIC="^DIC("_QAFILE_",""%"",",DIC(0)="L"
 .. S X=QAQANMSP D:$O(^DIC("AC",QAQANMSP,QAFILE,0))'>0 FILE^DICN
 .. W !?3,QAFILE,?15,^UTILITY($J,"QAQA",QAFILE)
 .. Q
 . Q
 E  W !?3,"*** None ***"
 W !!,"Unloading:" I $O(^UTILITY($J,"QAQA DEL",0)) D
 . F QAFILE=0:0 S QAFILE=$O(^UTILITY($J,"QAQA DEL",QAFILE)) Q:QAFILE'>0  D
 .. F QAQDA=0:0 S QAQDA=$O(^DIC("AC",QAQANMSP,QAFILE,QAQDA)) Q:QAQDA'>0  D
 ... S DA(1)=QAFILE,DIK="^DIC("_QAFILE_",""%"",",DA=QAQDA
 ... D ^DIK
 ... Q
 .. W !?3,QAFILE,?15,^UTILITY($J,"QAQA DEL",QAFILE)
 .. Q
 . Q
 E  W !?3,"*** None ***"
 W !!,"*** Finished ***",*7
EXIT ;
 K %,D,DA,DIC,DIE,DIK,DIR,DR,DZ,QA,QADELETE,QAFILE,QALINE,QALIST,QAQANMSP,QAQAPROG,X,Y,^UTILITY($J,"QAQA"),^UTILITY($J,"QAQA DEL")
 Q
HELP ;
 W !!," Enter a file name/number to add a file to the list",!," Enter a minus (-) file name/number to remove a file from the list"
 W !!,"Files selected for LOADING:" S QALIST="QAQA" D HLP
 W !!,"Files selected for UNLOADING:" S QALIST="QAQA DEL" D HLP
 Q:X'?1"??".E  K DIR S DIR(0)="E" W ! D ^DIR K DIR Q:Y'>0
 S DIC="^DIC(",DIC(0)="AEMNQ",DIC("S")="I Y'<2",D="B",DZ="??" D DQ^DICQ
 Q
HLP N X I $O(^UTILITY($J,QALIST,0)) D
 . S QALINE=$Y,Y=1
 . F QAFILE=0:0 S QAFILE=$O(^UTILITY($J,QALIST,QAFILE)) Q:(QAFILE'>0)!(Y'>0)  D
 .. W !?3,QAFILE,?15,^UTILITY($J,QALIST,QAFILE),?65
 .. W "(",$S($D(^DIC("AC",QAQANMSP,QAFILE)):"Loaded",1:"Not Loaded"),")"
 .. I $Y>(IOSL+QALINE-3) K DIR S DIR(0)="E",QALINE=$Y D ^DIR K DIR
 .. Q
 . Q
 E  W !?3,"*** None ***"
 Q
