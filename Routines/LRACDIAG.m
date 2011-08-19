LRACDIAG ;SLC/DCM - DIAGNOSTIC REPORT FOR LAB REPORTS FILE (64.5) ;2/19/91  10:09 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;
 S:'$D(U) U="^" S LRCKW=1
QUE S %ZIS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^LRACDIAG",ZTDESC="Cumulative diagnostics",ZTSAVE("U")="",ZTSAVE("DT")="",ZTSAVE("LRCKW")="" D ^%ZTLOAD K ZTSK G END
 D ENT W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC
 Q
ENT ;from LRCKF
 U IO K ^TMP($J),LR S A=0 W !!,?10,"Diagnostic Report for LAB REPORTS FILE (64.5)" I $O(^LAB(64.5,1,2,0))<1,LRCKW W !!,"SUPERVISOR'S SUMMARY REPORT field not defined",?68,">>WARNING<<"
 I $D(^LAB(64.5,"AC",0)) W !!,"The ""AC"" x-ref indicates that the Lab Reports file may contain tests",!?3,"that do not have data names (cosmic).  Remove test and re-cross-",!?3,"reference the ""AC"" index.",?70,">>FATAL<<"
 I $O(^LAB(64.5,1,3,0))<1 W !!,"REPORT NAME field not defined",?70,">>FATAL<<"
 F I=0:0 S A=$O(^LAB(64.5,1,3,A)) Q:A<1  I $D(^(A,0))#2 S LRST(A)=$P(^(0),U,2),LREN(A)=$P(^(0),U,3) I LREN(A)'=LRST(A) D
 . W:LREN(A)']LRST(A) !!,"ENDING LOCATION does not follow STARTING LOCATION",?70,">>FATAL<<" D DEV
MAJ S DA(3)=1,DA(2)=0 F  S DA(2)=$O(^LAB(64.5,1,1,DA(2))) Q:DA(2)<1  S LRMAJ=$P(^(DA(2),0),U,1),LROFMT="" W !!,LRMAJ D MIN
END K ^TMP($J),LRMAJ,LRMIN,LRTS,LRTST,LRSB,LRSITE,LR,LRCKW,LREN,LRFMT,LROFMT,LRST,I,J,K,DA
 W !! W:$E(IOST,1,2)="P-" @IOF
 Q
DEV W:'$D(^LAB(64.5,1,3,A,.1))#2 !,"No device defined for report name: ",$P(^LAB(64.5,1,3,A,0),U),?70,">>FATAL<<"
 Q
MIN S J=0 F  S J=$O(^LAB(64.5,1,1,DA(2),1,J)) Q:J<1  I $D(^(J,0))#2 S DA(1)=J,X=^(0),LRMIN=$P(X,U,1),LRSITE=$P(X,U,2),LRFMT=$P(X,U,3) S:'$L(LROFMT) LROFMT=LRFMT W !?3,LRMIN D TST
 Q
TST I LROFMT="V",LRFMT="H" W:'$D(LR) !?5,"Horizontal formats cannot be added after a vertical format.",?70,">>FATAL<<"
 S K=0 F  S K=$O(^LAB(64.5,1,1,DA(2),1,J,1,K)) Q:K<1  I $D(^(K,0))#2 S DA=K,X=^(0),LRTST=$P(X,U,3),LRTS=$P(X,U,1),LRSB=+$P($P(X,U,5),";",2),X=$P(X,U,1) D CHK,XREF
 Q
CHK I 'LRSB W:'$D(LR) !?5,LRTST," of the ",LRMIN," minor header of the ",LRMAJ,!?5," major header is not an atomic test (no data name).",?70,">>FATAL<<"
 I $D(^TMP($J,LRSITE,LRTS)) W:'$D(LR) !?5,LRTST," with ",$S($D(^LAB(61,LRSITE,0)):$P(^(0),U,1),1:"")," specimen already exists on another minor header.",?70,">>FATAL<<"
 E  S:'$D(LR) ^TMP($J,LRSITE,LRTS)=""
 Q
XREF G:$D(LR) XREF1 I '$D(^LAB(64.5,"AR",$P(^LAB(64.5,DA(3),1,DA(2),1,DA(1),0),"^",2),$P(^(1,DA,0),"^",1))) W !?5,"""AR"" x-ref does not exist for ",LRTST,?70,">>FATAL<<"
 I '$D(^LAB(64.5,"A",DA(3),DA(2),DA(1),DA)) W !?5,"""A"" x-ref does not exist for ",LRTST,?70,">>FATAL<<" Q
 I $D(^LAB(60,LRTS,1,LRSITE,0)),^LAB(64.5,"A",DA(3),DA(2),DA(1),DA)'=^LAB(60,LRTS,1,LRSITE,0) W !?5,"""A"" x-ref for ",LRTST," is 'out-of-date' with file 60.",?70,">>FATAL<<"
 I '$D(^LAB(64.5,"AC",+$P($P(^LAB(64.5,DA(3),1,DA(2),1,DA(1),1,DA,0),"^",5),";",2),DA(3),DA(2),DA(1),DA)) W !?5,"""AC"" x-ref does not exist for ",LRTST,?70,">>FATAL<<"
 Q
XREF1 I $D(LR(1)) X ^DD(64.53,.01,1,6,1) W "."
 I $D(LR(2)) X ^DD(64.53,4,1,1,1) W "."
 I $D(LR(3)) X ^DD(64.53,.01,1,5,1) W "."
 Q
EN S:'$D(U) U="^" S:'$D(DTIME) DTIME=300
 W:$D(LR(1)) !,"Mumps ""A"" index of the LAB TEST subfield",!?4,"(contains reference ranges, units, etc. from file 60)"
 W:$D(LR(2)) !,"Mumps ""AC"" index of the LAB TEST LOCATION subfield",!?4,"(atomic test x-ref.)" W:$D(LR(3)) !,"Mumps ""AR"" index of the LAB TEST subfield",!?4,"(site/specimen x-ref.)"
 W !!,"ARE YOU SURE" S %=2 D YN^DICN G END:%<1!(%=2)
 K:$D(LR(1)) ^LAB(64.5,"A") K:$D(LR(2)) ^LAB(64.5,"AC") K:$D(LR(3)) ^LAB(64.5,"AR")
 D MAJ
 G END
DQ U IO S:$D(ZTQUEUED) ZTREQ="@" D ENT D ^%ZISC Q
