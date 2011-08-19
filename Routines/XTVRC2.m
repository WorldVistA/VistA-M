XTVRC2 ; JLI/SF-ISC.SEATTLE ** PRODUCE LISTING OF CHANGE HISTORY FOR ROUTINE ;12/7/93  15:20
 ;;7.3;TOOLKIT;;Apr 25, 1995
 W !!,"This routine lists the changes in program code that have been noted.",!!
RSEL U IO(0) W !!,"Select the routine(s) which you want changes listed for:",!
 K ^TMP($J) X ^%ZOSF("RSEL") G:$O(^UTILITY($J,""))="" KILL S %X="^UTILITY($J,",%Y="^TMP($J," D %XY^%RCR K ^UTILITY($J)
 R "Show changes back to DATE",!?5,"(none if number of changes is to be specified): ",X:DTIME Q:'$T  S:X="" X=0,Y=0 S %DT="QE" D:X'=0 ^%DT K %DT S XTVDAT=+Y I XTVDAT>0 S X=10000 G A2
A1 R !!,"Show changes for how many past versions (or ALL): 1// ",X:DTIME Q:'$T!(X[U)  S:X="" X=1 S:"Aa"[$E(X) X=10000 I +X'=X!(X'>0) W:X'["?" $C(7),"  ??" W !,"Enter a number indicating the number of past versions you want to see changes",! G A1
A2 S XTVNV=X
 S %ZIS="QM" D ^%ZIS G:POP KILL I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^XTVRC2",ZTIO=ION,ZTDESC="Routine Changes",ZTSAVE("^TMP($J,")="",ZTSAVE("XTVDAT")="",ZTSAVE("XTVNV")="" D ^%ZTLOAD K ZTRTN,ZTIO,ZTDESC,ZTSAVE G KILL
 ;
DQ ;
 S X="N",%DT="T" D ^%DT S XTVTIM=Y
 U IO S DIR(0)="E",XTVNAM="" F XTVA=0:0 S XTVNAM=$O(^TMP($J,XTVNAM)) Q:XTVNAM=""  D ONE Q:$D(DIRUT)
 G:$D(DIRUT) KILL I $D(^TMP($J," NEW")) W !!,"The following routines ARE NEW to the file (no prior version to compare):",!!  S XTVNAM="" F XTVI=0:0 S XTVNAM=$O(^TMP($J," NEW",XTVNAM)) Q:XTVNAM=""  W:XTVI#7 ! W $J(XTVNAM,10)
 I $D(^TMP($J," NO CHANGE")) W !!,"The following routines showed no change in the specified number of versions:",!! S XTVNAM="" F XTVI=0:0 S XTVNAM=$O(^TMP($J," NO CHANGE",XTVNAM)) Q:XTVNAM=""  W:XTVI#7 ! W $J(XTVNAM,10)
 W !
 I '$D(ZTQUEUED) D ^%ZISC G RSEL
 U IO W:IOST'["C-" @IOF
KILL D ^%ZISC
 K XTVA,XTVC,XTVD,XTVDAT,XTVDAT1,XTVI,XTVJ,XTVK,XTVL,XTVNV,XTVNAM,ZTRTN,ZTSAVE,ZTIO,X,Y,M,DA,POP,DIRUT,DIR
 Q
 ;
ONE ;
 S DA=$O(^XTV(8991,"B",XTVNAM,0)) S XTROU=XTVNAM I DA'>0 D LCHEK^XTVRC1 Q:'L  D LOOP^XTVRC1 S DA=$O(^XTV(8991,"B",XTVNAM,0)) Q:DA'>0  S ^TMP($J," NEW",XTVNAM)="" Q
 S XTVDA=DA D LOOP^XTVRC1 S DA=XTVDA ; MAKE SURE WE HAVE INCLUDED THE CURRENT VERSION
 S XTVJ=0 F XTVL=0:0 S XTVL=$O(^XTV(8991,DA,1,XTVL)) Q:XTVL'>0  S XTVJ=XTVL
 S XTVC=0,XTVDAT1=+^XTV(8991,DA,1,XTVJ,0) F XTVL=XTVJ-1:-1 Q:XTVDAT1'>XTVDAT  Q:XTVL'>0!(XTVL'>(XTVJ-XTVNV-1))  I $D(^XTV(8991,DA,1,XTVL)) S XTVDATX=XTVDAT1,XTVDAT1=+^(XTVL,0) I XTVDATX>XTVDAT D LIST Q:$D(DIRUT)
 I XTVC'>0 S ^TMP($J," NO CHANGE",XTVNAM)=""
 Q
 ;
LIST ;
 I $O(^XTV(8991,DA,1,XTVL,1,0))=2,$O(^(2,0))="DEL",$O(^XTV(8991,DA,1,XTVL,1,2))=3,$O(^(3,0))="INS",$O(^XTV(8991,DA,1,XTVL,1,3))="" Q
 D:(6>(IOSL-$Y)) DIX Q:$D(DIRUT)
 S %=XTVDATX_"00000",XTVDATX=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)_"  "_$E(%,9,10)_":"_$E(%,11,12),XTVC=XTVC+1 W !!,XTVNAM,"  changes in code ",XTVJ-XTVL," version",$S(XTVJ-XTVL>1:"s",1:"")," back  (recorded ",XTVDATX,")" K %
 S XTVD=0,XTVI=0 F XTVK=0:0 S XTVK=$O(^XTV(8991,DA,1,XTVL,1,XTVK)) Q:XTVK'>0  D:$D(^(XTVK,"DEL"))&(XTVD<XTVK) DELETE D:(XTVI<XTVK)&$D(^XTV(8991,DA,1,XTVL,1,XTVK,"INS")) INSERT Q:$D(DIRUT)
 Q
 ;
DELETE ;
 I $D(^XTV(8991,DA,1,XTVL,1,XTVK+1,"INS",1)),'$D(^(2)) D CHANGE Q
 D:(4>(IOSL-$Y)) DIX Q:$D(DIRUT)  W !!?4,"original line ",XTVK," deleted. code was:",!,^XTV(8991,DA,1,XTVL,1,XTVK,"DEL")
 S XTVD=XTVK
 Q
 ;
INSERT ;
 D:(5>(IOSL-$Y)) DIX Q:$D(DIRUT)  W !!?4,"new line",$S($D(^XTV(8991,DA,1,XTVL,1,XTVK,"INS",2)):"s",1:"")," inserted **BEFORE** original line ",XTVK-1
 F M=0:0 S M=$O(^XTV(8991,DA,1,XTVL,1,XTVK,"INS",M)) Q:M'>0  D:(2>(IOSL-$Y)) DIX Q:$D(DIRUT)  W !,^(M,0)
 S XTVI=XTVK
 Q
 ;
CHANGE ;
 S X=^XTV(8991,DA,1,XTVL,1,XTVK,"DEL"),Y=^XTV(8991,DA,1,XTVL,1,XTVK+1,"INS",1,0)
 S N1=0 F M=1:1:$L(X) I $E(X,M)'=$E(Y,M) S N1=M Q
 S N2X=$L(X)+1,N2Y=$L(Y)+1,N2M=N2X I N2Y<N2X S N2M=N2Y
 F M=0:0 S N2X=N2X-1,N2Y=N2Y-1 Q:N2X'>0!(N2Y'>0)  I $E(X,N2X)'=$E(Y,N2Y) Q
 I N1=0 S N1=$S($L(X)<$L(Y):$L(X)+1,1:$L(Y)+1)
 D:(6>(IOSL-$Y)) DIX Q:$D(DIRUT)  W !!?4,"line ",XTVK," replaced:"
 W !,$E(X,$S(N1>5:N1-6,1:1),N2X+6),!?4,"with:"
 W !,$E(Y,$S(N1>5:N1-6,1:1),N2Y+6)
 S XTVD=XTVK,XTVI=XTVK+1
 Q
 ;
DIX N X,Y I '$D(ZTQUEUED),IOST["C-" D ^DIR Q:$D(DIRUT)
 W @IOF
 Q
