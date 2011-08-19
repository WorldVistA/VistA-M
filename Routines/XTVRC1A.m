XTVRC1A ;ISC-SF/JLI - SHOW SUMMARY OF ROUTINES MOST RECENTLY UPDATED ;12/8/93  14:52 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;;
ENTRY W ! K ^TMP($J) X ^%ZOSF("RSEL") Q:$O(^UTILITY($J,""))=""  S %X="^UTILITY($J,",%Y="^TMP($J," D %XY^%RCR K ^UTILITY($J)
 S DIR(0)="D",DIR("A")="List CHANGES since DATE" D ^DIR K DIR S XTVRDAT=+Y G:Y'>0 ENTRY
 S %ZIS="QM" D ^%ZIS Q:POP  I IO'=IO(0) S ZTRTN="DQENT^XTVRC1A",ZTIO=ION,ZTSAVE("^TMP($J,")="",ZTSAVE("XTVRDAT")="",ZTDESC="XTVRC1A-IDENTIFY ROUTINES RECENTLY LOGGED AS CHANGED" D ^%ZTLOAD G EXIT
 ;
DQENT ;
 S X="N",%DT="T" D ^%DT S XTVTIM=Y
 S XTROU="" F DA=0:0 S XTROU=$O(^TMP($J,XTROU)) Q:XTROU=""  D
 . S DA=$O(^XTV(8991,"B",XTROU,0)) I DA'>0 D LCHEK^XTVRC1 Q:'L  D LOOP^XTVRC1 S DA=$O(^XTV(8991,"B",XTROU,0)) Q:DA'>0
 . S XTVDA=DA D LOOP^XTVRC1 S DA=XTVDA
 . D DOIT W:'$D(ZTQUEUED) "."
FINISH U IO D OUTPUT D ^%ZISC
EXIT K %DT,%X,%Y,%ZIS,A,D,D1,DA,I,J,K,L,POP,X,X1,X11,X12,XS,XTROU,XTVDA,XTVRDAT,XTVRDATE,XTVTIM,XTVUT,Y,ZTDESC,ZTIO,ZTRTN,NAME,XTVR,Z,ZTSAVE
 Q
 ;
ALL ;
 S DIR(0)="D",DIR("A")="List CHANGES since DATE" D ^DIR K DIR S XTVRDAT=+Y G:Y'>0 EXIT
 W ! K ^TMP($J)
 S %ZIS="QM" D ^%ZIS Q:POP  I IO'=IO(0) S ZTRTN="DQALL^XTVRC1A",ZTSAVE("XTVRDAT")="",ZTIO=ION,ZTDESC="XTVRC1A-IDENTIFY ROUTINES RECENTLY LOGGED AS CHANGED" D ^%ZTLOAD G EXIT
 ;
DQALL ;
 K ^TMP($J)
 F DA=0:0 S DA=$O(^XTV(8991,DA)) Q:DA'>0  S XTROU=$P(^(DA,0),U) D DOIT W:'$D(ZTQUEUED) "."
 G FINISH
 Q
DOIT ;
 S K=0,X1=0,X11="",X12="",XS=" " F J=0:0 S J=$O(^XTV(8991,DA,1,J)) S:J'>0&(X1>0) ^TMP($J,XS,(9999999-X1),XTROU)=+X1,^(XTROU,1)=X11,^(2)=X12 Q:J'>0  D CHK S K=J
 Q
OUTPUT ;
 S XTVUT=0,D1=0,XTVRDATE=$E(XTVRDAT,4,5)_"/"_$E(XTVRDAT,6,7)_"/"_$E(XTVRDAT,2,3) W !!,"The following routines have been logged as NEW ROUTINES since ",XTVRDATE,!!
 S XTVR=0 F I=0:0 Q:XTVUT  S I=$O(^TMP($J," N",I)) Q:I'>0  S A="" F J=0:0 S A=$O(^TMP($J," N",I,A)) Q:A=""  S D=^(A),X11=^(A,1),X12=^(2) W:(D\1'=D1) ! S D1=D\1 D:A'=$P(X11," ") NAME D PRNT S XTVR=XTVR+1 Q:XTVUT
 W !!,$S(XTVR>0:XTVR,1:"No"),"  NEW routines were logged",!!,"The following routines have logged CHANGES since ",XTVRDATE,!!
 S XTVR=0 F I=0:0 Q:XTVUT  S I=$O(^TMP($J," ",I)) Q:I'>0  S A="" F J=0:0 S A=$O(^TMP($J," ",I,A)) Q:A=""  S D=^(A),X11=^(A,1),X12=^(2) Q:D<XTVRDAT  W:(D\1'=D1) ! S D1=D\1 D:A'=$P(X11," ") NAME D PRNT S XTVR=XTVR+1 Q:XTVUT
 W !!,$S(XTVR>0:XTVR,1:"No")," old routines were CHANGED",!!,"The following routines have NOT LOGGED CHANGES since ",XTVRDATE,!!
 S XTVR=0 F I=9999999-XTVRDAT:0 Q:XTVUT  S I=$O(^TMP($J," ",I)) Q:I'>0  S A="" F J=0:0 S A=$O(^TMP($J," ",I,A)) Q:A=""  S D=^(A),X11=^(A,1),X12=^(2) W:(D\1'=D1) ! S D1=D\1 D:A'=$P(X11," ") NAME D PRNT S XTVR=XTVR+1 Q:XTVUT
 W !!,$S(XTVR>0:XTVR,1:"No"),"  UNCHANGED routines were included",!!,"The following routines were previously LOGGED BUT NOT IN THE ACCOUNT",!,"Routines were searched for using 2 letter namespaces from routines",!,"originally specified.",!
 S NAME="" F  S NAME=$O(^TMP($J,NAME)) Q:NAME=""  S ^TMP($J," X",$E(NAME,1,2))=""
 S XTVR=0,NAME="" F  S NAME=$O(^TMP($J," X",NAME)) Q:NAME=""  D
 . I $D(^XTV(8991,"B",NAME)),'$D(^XTV($J,NAME)) S X=NAME X ^%ZOSF("TEST") I '$T S ^TMP($J," Y",NAME)=""
 . S X=NAME F  S X=$O(^XTV(8991,"B",X)) Q:X=""!($E(X,1,$L(NAME))'=NAME)  I '$D(^TMP($J,X)) X ^%ZOSF("TEST") I '$T S ^TMP($J," Y",X)=""
 S NAME="" F I=0:1 S NAME=$O(^TMP($J," Y",NAME)) Q:NAME=""  W:'(I#8) ! W ?((I#8)*10+1),NAME S XTVR=XTVR+1
 W !!,$S(XTVR>0:XTVR,1:"No"),"  DELETED routines identified using 2 letter namespaces input",!!
 Q
 ;
PRNT ;
 S D=D_$S(D'[".":".",1:"")_"0000" D:($Y+3>IOSL) PAGE Q:XTVUT  W !,A,?10,$E(D,4,5),"/",$E(D,6,7),"/",$E(D,2,3),"  ",$E(D,9,10),":",$E(D,11,12),"    ",$P(X11,";",3),?45," "_$P(X12,";",3,6)
 Q
 ;
CHK ;
 I J=1,+^XTV(8991,DA,1,J,0)'<XTVRDAT S XS=" N"
 S:$S('$D(^XTV(8991,DA,1,J,1,1,0)):0,^(0)="":0,1:1) X11=^(0) S:$S('$D(^XTV(8991,DA,1,J,1,2,0)):0,^(0)="":0,1:1) X12=^(0)
 I J>1,$O(^XTV(8991,DA,1,K,1,0))=2,$O(^(2))=3,$O(^(3))'>0,$O(^(2,0))="DEL",$O(^("DEL"))="",$O(^XTV(8991,DA,1,K,1,3,0))="INS",$O(^("INS",0))=1,$O(^(1))'>0 Q
 S X1=^XTV(8991,DA,1,J,0)
 Q
 ;
PAGE S XTVUT=0 I IOST["C-" R !?20,"Enter RETURN to continue... ",Z:DTIME I '$T!(Z[U) S XTVUT=1 Q
 W @IOF
 Q
 ;
NAME W !,A,?15,$P(X11," ")," is shown as name on first line"
 Q
