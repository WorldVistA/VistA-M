XTVRCRES ;ISC-SF/JLI - RESTORE ROUTINE BACK TO SELECTED VERSION -  BE SAVED UNDER ANOTHER NAME ;8/24/93  14:53
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;;
EN ;
 K ^TMP($J) S DIC("A")="Name of ROUTINE to be restored: ",DIC(0)="AEQM",DIC="^XTV(8991," D ^DIC K DIC G:Y'>0 EXIT S DA=+Y,XTROU=$P(Y,U,2),XTDA=DA D  D LOOP^XTVRC1 S DA=XTDA
 . S X="N",%DT="T" D ^%DT K %DT S XTVTIM=+Y
 R !,"Save RESTORED ROUTINE as: ",X:DTIME G:'$T!(X="")!(X["^") EXIT I $E(X)'?1A!($L(X)>8) W $C(7),"   ??",! G EN
 S XTROUA=X X ^%ZOSF("TEST") I $T W !?5,$C(7),"Must be a routine name not currently in use.",!! G EN
 S DIC="^XTV(8991,XTDA,1,",DA(1)=XTDA,DIC(0)="AEQ" D ^DIC K DIC Q:Y'>0  S DA=+Y
 S XTMAX=0 F I=0:0 S I=$O(^XTV(8991,XTDA,1,I)) Q:I'>0  S XTMAX=XTMAX+1,XTMAX(XTMAX)=I
 S %X="^XTV(8991,XTDA,1,XTMAX,1,",%Y="^TMP($J,""A""," D %XY^%RCR
 S XTDA1=DA F DA1=XTMAX-1:-1 Q:'$D(XTMAX(DA1))  S DA=XTMAX(DA1) Q:DA<XTDA1  K ^TMP($J,0) S %X="^TMP($J,""A"",",%Y="^TMP($J,0," D %XY^%RCR K ^TMP($J,"A") D A
 S X=XTROUA,DIE="^TMP($J,""A"",",XCN=0 X ^%ZOSF("SAVE")
 Q
 ;
A ;S X=XTROU,XCNP=0,DIF="^TMP($J,0," X ^%ZOSF("LOAD")
 F I=0:0 S I=$O(^XTV(8991,XTDA,1,DA,1,I)) Q:I'>0  I $D(^(I,"DEL")) S ^TMP($J,"A",I,0)=^("DEL")
 S K=0 F I=0:0 S I=$O(^XTV(8991,XTDA,1,DA,1,I)) Q:I'>0  S N1=0 K ^TMP($J,"I") F J=0:0 S J=$O(^XTV(8991,XTDA,1,DA,1,I,"INS",J)) D:J'>0  Q:J'>0  S N1=N1+1,^TMP($J,"I",N1,0)=^(J,0)
 . Q:N1'>0  S X=0 F M=K+1:1 Q:$O(^TMP($J,0,M-1))'>0  I $D(^TMP($J,0,M)) D  Q:X
 .. S X=1 F P=1:1:N1 I ^TMP($J,"I",P,0)'=^TMP($J,0,(M+P-1),0) S X=0 Q
 .. I X F P=1:1:N1 K ^TMP($J,0,(M+P-1))
 .. I X S K=M K ^TMP($J,"I")
 . I 'X W !!,K F P=1:1:N1 W !,^TMP($J,"I",P,0)
 S K=0 F I=1:1 I '$D(^XTV(8991,XTDA,1,DA,1,I,"DEL")) S K=$O(^TMP($J,0,K)) Q:K'>0  S X=^(K,0),^TMP($J,"A",I,0)=X
 Q
 ;
EXIT ;
 K %X,%Y,DA,DA1,DIC,DIE,I,J,K,M,N1,P,X,XCN,XTDA,XTDA1,XTMAX,XTROU,XTROUA,Y
