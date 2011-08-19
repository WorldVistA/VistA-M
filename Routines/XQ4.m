XQ4 ;SF/GFT,SEA/JLI - Menu Diagram with entry/exit actions ;3/19/91  10:07 ;5/13/93  11:15 AM
 ;;8.0;KERNEL;;Jul 10, 1995
 S:'$D(XQ4) XQ4=0 W !! D INIT
 K DIC R "Select USER (U.xxxxx) or OPTION (O.xxxxx) name: ",X:DTIME G:'$T OUT I "O."=$E(X,1,2)!("o."=$E(X,1,2)) S X=$E(X,3,99),DIC=19,DIC(0)="QEMZ",FL="OP" G:X=""!(X["^") OUT D ^DIC G:Y'>0 XQ4 S D0=+Y G OPT
 I "U."=$E(X,1,2)!("u."=$E(X,1,2)) S X=$E(X,3,99),DIC=200,DIC(0)="QEMZ",DIC("S")="I $D(^(201)),^(201)",FL="US" G:X=""!(X["^") OUT D ^DIC G:Y'>0 XQ4 S D0=+Y,MQ=$P(Y(0),U,1),Y=+^VA(200,D0,201) I $D(^DIC(19,Y,0)) D E^XQ41 G:'FL QPU D GO G OUT
 S DIC=200,DIC(0)="QEMZ",DIC("S")="I $D(^(201)),^(201)",FL="US" G:X=""!(X["^") OUT
RQUE S XQX=X D ^DIC I Y>0 R "   OK (Y/N) ? ",XQI:DTIME I '$T!("Yy"[$E(XQI,1)) K XQX S D0=+Y,MQ=$P(Y(0),U,1),Y=+^VA(200,D0,201) I $D(^DIC(19,Y,0)) D E^XQ41 G:'FL QPU D GO G OUT
 S X=XQX,DIC=19,DIC(0)="QEMZ" W !,?5,X K XQX,DIC("S") D ^DIC S FL="OP",D0=+Y I Y'>0 G XQ4
OPT I $P(Y(0),U,4)'="M" W !,*7,"This is not a menu option and therefore cannot be diagrammed.",! G XQ4
 D:Y>0 E^XQ41 G:'FL QPU G OUT
 ;
OP ;Entry point for queued job to diagram menu for OPTION selection
 D INIT S Y=D0 D E^XQ41:$D(^DIC(19,Y,0)) D GO G OUT
US ;Entry point for queued job to diagram menu for USER selection
 D INIT Q:'$D(^VA(200,D0,201))  S XQDUZ=D0,Y=+^(201) Q:'$D(^DIC(19,Y,0))  D E^XQ41,GO G OUT
 ;
GO K X,XQV,DIC U IO S W=IOM\M-10,%="" S:W>33 W=33
 I W<10 D ^%ZISC W !,*7,"This menu contains too many levels to be diagrammed using this margin width." G XQ4
 W @IOF S X=^TMP($J,"XQM",1,0) W !,$P(X,U,3)," (",$P(X,U,2),")"
 I XQ4'<0 W:$P(X,U,4)]"" !,"**UNAVAILABLE**" W:$P(X,U,7)]"" !,"**LOCKED: ",$P(X,U,7),"**" W:XQ4>0&$D(^TMP($J,"XQM",1,0,.1)) !,"**ENTRY ACTION:",!,^(.1) W:XQ4>0&$D(^(.2)) !,"**EXIT  ACTION:",!,^(.2)
 W !,"|",!,"|" K ^TMP($J,"XQM",1,0)
 S XQFLAG="" F XQL=1:1 Q:'$D(^TMP($J,"XQM",XQL))  Q:XQFLAG=U  S XQT=M,L=1 K Z D ^XQ41
 I $D(IOST)#2,$E(IOST,1)="P" W #
 D OUT
Q Q
 ;
INIT K ^TMP($J,"XQM"),^TMP($J,"XQ1"),X,IOP,XQDUZ,XQDIC S L=0,XQL=1,X(0)=0,M=1
 Q
QPU ;
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN=FL_"^XQ4",ZTSAVE("D0")="",ZTSAVE("XQ4")="",ZTDESC="DIAGRAM MENUS" D ^%ZTLOAD K ZTSK G XQ4
 D:IO["" GO
 ;
OUT K ^TMP($J,"XQM"),^TMP($J,"XQ1"),X,X1,X2,FL,IOP,XQDUZ,XQDIC,DIC
 D ^%ZISC
 K C,D,D0,L,M,MQ,POP,W,XQ4,XQB,XQBN,XQFLAG,XQI,XQJ,XQL,XQN,XQP,XQT,XQV,Y,Z
 I $D(ZTSK) K ^%ZTSK(ZTSK)
 Q
 ;
ABBREV ; Entry point for abbreviated (names only) display
 S XQ4=-1
 G XQ4
 ;
NORMAL ; Entry point for regular (names, locks, etc.) display
 S XQ4=0
 G XQ4
 ;
FULL ; Entry point for full listings (includes actions)
 S XQ4=1
 G XQ4
