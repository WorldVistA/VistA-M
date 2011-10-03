XQ5 ;SF/GFT,MJM,KLD - Menu edit utilities [XUEDITOPT] ;01/30/2008
 ;;8.0;KERNEL;**44,130,484**;Jul 10, 1995;Build 2
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ; Option & Input Template: XUEDITOPT
DIP ;
 K DIC S DIC=.4,DIC(0)="AEQMZ" I $D(^DIC(19,DA,63)),^(63)?1"[".E1"]" S DIC("B")=$E(^(63),2,$L(^(63))-1)
 S DUZ0=$S(DUZ(0)="@"!$D(^XUSEC("XUMGR",DUZ)):1,1:0) G:DUZ0 DIP1 S DIC("S")="I 1 Q:'$D(^DIC(+$P(^(0),U,4),0,""RD""))  F %=1:1:$L(^(""RD"")) I DUZ(0)[$E(^(""RD""),%) Q"
DIP1 ;
 D:$G(DUZ0) PRNT
 D ^DIC K DIC G:Y<0&(DUZ(0)'="@") Q G:Y<0&(DUZ0) Q1 S XQDIC=+$P(Y(0),U,4) G:XQDIC'>1 Q S XQ=$P(^DIC(XQDIC,0),U,1)_U_XQDIC,XQ(63)="["_$P(Y,U,2)_"]",XQ(60)=$P(^(0,"GL"),U,2),XQ(62)=0
BY ;
 D:$G(DUZ0) SORT
 K DIC S DIC=.401,DIC(0)="AEQMZ" I $D(^DIC(19,DA,64)),^(64)?1"[".E1"]" S DIC("B")=$E(^(64),2,$L(^(64))-1)
 S DIC("S")="I $P(^(0),U,4)=XQDIC" G:DUZ0 BY1 S DIC("S")=DIC("S")_" Q:'$D(^DIC(+$P(^(0),U,4),0,""RD""))  F %=1:1:$L(^(""RD"")) I DUZ(0)[$E(^(""RD""),%) Q"
BY1 ;
 D ^DIC K DIC G TEM:X="",Q:Y<0 S XQDIC=+$P(Y(0),U,4),XQ=$P(^DIC(XQDIC,0),U,1)_U_XQDIC,XQ(64)="["_$P(Y,U,2)_"]" G FR
TEM ;
 I +X=X,'$D(^DD(+$P(XQ,U,2),X,0)) W *7,"NO SUCH FIELD NUMBER" K X G BY
 S XQ(64)=X
FR K X S Y=$S($D(^DIC(19,DA,65)):^(65),1:"") W !,"START WITH: ",$S(Y]"":Y,1:"FIRST")_"// " R X:DTIME G:X=U Q S:X="" X=Y W:X="?" !?4,"ENTER IN 'FR' FORMAT" G:X="?" FR K:X="@" X,^DIC(19,DA,65) W:'$D(X) *7,"   DELETED!" S:$D(X) XQ(65)=X
TO K X S Y=$S($D(^DIC(19,DA,66)):^(66),1:"") W !,"GO TO: ",$S(Y]"":Y,1:"LAST")_"// " R X:DTIME G:X=U Q S:X="" X=Y W:X="?" !?4,"ENTER IN 'TO' FORMAT" G:X="?" TO K:X="@" X,^DIC(19,DA,66) W:'$D(X) *7,"   DELETED!" S:$D(X) XQ(66)=X
 D PUT G Q1
DIE ;
 S DUZ0=$S(DUZ(0)="@"!$D(^XUSEC("XUMGR",DUZ)):1,1:0)
 K DIC,XQ S DIC=.402,DIC(0)="AQEMZ" I $D(^DIC(19,DA,51)),^(51)?1"[".E1"]" S DIC("B")=$E(^(51),2,$L(^(51))-1)
 G:DUZ0 DIE1 S DIC("S")="I 1 Q:'$D(^DIC(+$P(^(0),U,4),0,""WR""))  F %=1:1:$L(^(""WR"")) I DUZ(0)[$E(^(""WR""),%) Q"
DIE1 ;
 D ^DIC K DIC G:Y<0&(DUZ(0)'="@") Q G:Y<0&(DUZ0) Q1 S XQDIC="",XQDIC=+$P(Y(0),U,4) G:'XQDIC Q S XQ(51)="["_$P(Y,U,2)_"]" D DIC S XQ(50)=XQ(30) D PUT G Q1
PUT S X=0 F  S X=$O(XQ(X)) Q:X'>0  S ^DIC(19,DA,X)=XQ(X)
 Q
 ;
Q W *7,!,"NO CHANGE MADE TO OPTION LOGIC"
Q1 K XQDIC,XQ,Y S DIC=DIE Q
 ;
DIC S XQ=$P(^DIC(XQDIC,0),U,1),XQ(30)=$P(^(0,"GL"),U,2)
 S XQ(31)=$G(^DIC(19,DA,31)) S:XQ(31)="" XQ(31)="AEMQ"
 I $D(^DIC(XQDIC,0,"LAYGO")),DUZ(0)'="@" S Y=$L(^("LAYGO")) I Y F %=1:1 I DUZ(0)[$E(^("LAYGO"),%) G A:%>Y Q
 W !,"WHEN USER SELECTS AN ENTRY IN THE '"_XQ_"' FILE,",!,"WILL ADDING A NEW ENTRY AT THAT TIME ('LAYGO') BE ALLOWED"
 S %=$S(XQ(31)["L":0,1:2) D YN^DICN
 I %=1 I XQ(31)'["L" S XQ(31)=XQ(31)_"L"
 I %=2 I XQ(31)["L" S XQ(31)=$TR(XQ(31),"L")
A Q
 ;
DIQ ;
 S DUZ0=$S(DUZ(0)="@"!$D(^XUSEC("XUMGR",DUZ)):1,1:0)
 K DIC,XQ S DIC=1,DIC(0)="AEQMZ",DIC("A")="INQUIRE TO WHAT FILE: "
 I $D(^DIC(19,DA,30)),^(30)["(",@("$D(^"_^(30)_"0))") S DIC("B")=+$P(^(0),U,2)
 G:DUZ0 DIQ1 S DIC("S")="I 1 Q:'$D(^(0,""RD""))  F %=1:1:$L(^(""RD"")) I DUZ(0)[$E(^(""RD""),%) Q"
DIQ1 ;
 D ^DIC K DIC G:Y<0 Q  S (XQ(80),XQ(30))=$P(^(0,"GL"),U,2)
 S XQ(31)=$G(^DIC(19,DA,31)) S:XQ(31)="" XQ(31)="AEMQ"
 D PUT G Q1
 ;
NAME ;
 I $E(X,1)="A"!($E(X,1)="Z") S %=1,%1="Local" Q
 F %=4:-1:2 G:$D(^DIC(9.4,"C",$E(X,1,%))) NAMEOK
 I 0
 Q
NAMEOK S %1=$O(^DIC(9.4,"C",$E(X,1,%),0)) S:%1="" %1=-1 S:$D(^DIC(9.4,%1,0)) %1=$P(^(0),U,1),XQPK=%1 I 1 Q
 ;
CHKNAME ;Called from the input transform of the .01 field of the Option File
 Q:$D(DIFROM)!($D(ZTQUEUED))  K XQPK
 I $D(DIC(0))#2,DIC(0)'["E" Q
 D NAME E  D EN^DDIOL("Not a known package or a local namespace.") Q
 D EN^DDIOL("  Located in the "_$E(X,1,%)_" ("_%1_") namespace.") Q
 ;
PRNT W !,?16,"*** IMPORTANT PLEASE READ ***",!
 W !,"By selecting a new Print/Sort Template below, your defaults will"
 W !,"be changed. Your defaults are currently set as follows (see below)."
 W !,"Should you desire to keep the defaults as they are, or to revise"
 W !,"one or more, enter an '^' up-arrow, without selecting a new"
 W !,"template name."
 W !!,?23,"Default Values",!,?23,"==============",!
 W !,?5,"DIC {DIP}: "_$$GET1^DIQ(19,DA,60)
 W ?40,"L.: "_$$GET1^DIQ(19,DA,62)
 W !,?5,"FLDS: "_$$GET1^DIQ(19,DA,63)
 W ?40,"BY: "_$$GET1^DIQ(19,DA,64)
 W !,?5,"FR: "_$$GET1^DIQ(19,DA,65)
 W ?40,"TO: "_$$GET1^DIQ(19,DA,66),!!
 Q
 ;
SORT W !,?16,"*** IMPORTANT PLEASE READ ***",!
 W !,"By selecting a new Sort Template below, your defaults will be"
 W !,"changed. Your defaults are currently set as follows (see below)."
 W !,"Should you desire to keep the defaults as they are, or to revise"
 W !,"one or more, enter an '^' up-arrow, without selecting a new Sort"
 W !,"Template."
 W !!,?23,"Default Values",!,?23,"==============",!
 W ?5,"BY: "_$$GET1^DIQ(19,DA,64)
 W !,?5,"FR: "_$$GET1^DIQ(19,DA,65)
 W ?40,"TO: "_$$GET1^DIQ(19,DA,66),!!
 Q
TEST W !,"Enter a name, and the computer will respond with the namespace to which",!,"that name belongs.  It does this by looking at the package file.",!!
T1 R !,"NAME: ",X:DTIME,"  " Q:X=""  D CHKNAME G T1
CLEAR ;Clear fields not used by this option.
 I "EMPRSOQ"[X X "F %="_$S("M"[X:"25,27:1:82","QO"[X:"25,31:1:82","RS"[X:"10,30:1:82","E"[X:"10,25,60:1:82","P"[X:"10,25,27:1:54,80:1:82")_" I $D(^DIC(19,DA,%)) D:%=10 CLEAR1 K ^DIC(19,DA,%)"
 I "AI"[X X "F %="_$S("A"[X:"10,25,30:1:82","I"[X:"10,25,36:1:62,64:1:73")_" I $D(^DIC(19,DA,%)) D:%=10 CLEAR1 K ^DIC(19,DA,%)"
 I "OQ"'[X F %=100,100.1,100.2 I $D(^DIC(19,DA,%)) K ^DIC(19,DA,%)
 Q
CLEAR1 S XQI=0 F  S XQI=$O(^DIC(19,DA,%,XQI)) Q:XQI'>0  S XQJ=$P(^(XQI,0),U) K ^DIC(19,"AD",$E(XQJ,1,30),DA,XQI)
 K XQI,XQJ
 Q
