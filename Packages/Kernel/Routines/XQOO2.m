XQOO2 ;LUKE/SEATTLE - Out Of Order Manager Utilities ;06/16/95  14:40
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
SETS(XQI) ;Show the sets of options in ^XTMP return # in XQI
EN ;Option entry doesn't care about XQI
 N XQ,XQD,XQF,XQFLG,XQM,XQO,XQOO,XQU
 S (XQD,XQU)="",XQ=0
 I $O(^XTMP("XQOO",0))="" W !,"There are no defined option sets currently listed in ^XTMP." Q
 F XQI=1:1 S XQ=$O(^XTMP("XQOO",XQ)) Q:XQ=""  D
 .I '$D(^XTMP("XQOO",XQ,0))#2 D
 ..W !,XQI_".",?5,"Option set named '",XQ,"' Unknown creator or date of creation!"
 ..W !?5,*7,"Warning: Incomplete option set named '",XQ,"' with no zeroth node."
 ..S XQFLG=""
 ..Q
 .I $D(XQFLG) K XQFLG Q
 .S XQMESS=$P(^XTMP("XQOO",XQ,0),U),XQD=$P(^(0),U,2),XQU=$P(^(0),U,3)
 .W !!,XQI_".",?5,"Option set named '",XQ,"' created on ",XQD," by ",XQU
 .I $O(^XTMP("XQOO",XQ,0))'="" D
 ..S XQF=$O(^XTMP("XQOO",XQ,0)),XQO=$O(^XTMP("XQOO",XQ,XQF,0))
 ..S XQM=$P(^XTMP("XQOO",XQ,0),U),XQOO=""
 ..I XQF=19,$D(^DIC(19,XQO,0)) S XQOO=$P(^DIC(19,XQO,0),U,3)
 ..E  S:$D(^ORD(101,XQO,0)) XQOO=$P(^ORD(101,XQO,0),U,3)
 ..I XQOO=XQM W !?5,XQ,"'s options/protocols appear to be Out-Of-Order."
 ..E  W !?5,XQ,"'s options/protocols do not appear to be marked Out-Of-Order."
 ..Q
 .Q
 W !
 S XQI=XQI-1
 Q
 ;
BXREF(XQSTART,XQEND) ;List from XQSTART to XQEND in the "B" cross reference.
 N %,XQI,XQN
 S:'$D(IOSL)#2 IOSL=24
 I $L(XQSTART)>1 S %=$E(XQSTART,1,$L(XQSTART)-1)_$C($A($E(XQSTART,$L(XQSTART)))-1)_"z"
 E  S %=XQSTART
 W @IOF,"This range includes the following options:",!
 F XQI=1:1 Q:%=XQEND  S %=$O(^DIC(19,"B",%)) Q:%=""!($E(%,1,$L(XQEND))]XQEND)  S XQN=$O(^(%,0)) W !,%,"   ",$P(^DIC(19,XQN,0),U,2) D:XQI#(IOSL-3)=0 PAUSE I $D(XQUPAR) K XQUPAR G OUT
 D:XQI#(IOSL-3)'=0 PAUSE
 W @IOF,"And the following protocols:",!
 W !!,XQSTART,"  ",XQEND
 S %=XQSTART
 F XQI=1:1 Q:%=XQEND  S %=$O(^ORD(101,"B",%)) Q:%=""!($E(%,1,$L(XQEND))]XQEND)  S XQN=$O(^(%,0)) W !,%,"   ",$P(^ORD(101,XQN,0),U,2) D:XQI#(IOSL-3)=0 PAUSE I $D(XQUPAR) K XQUPAR Q
 Q
 ;
RANGE(XQS,XQE,XQR) ;Get a range of Options from XQS(tart) to XQE(nd)
 ;
 S DIR(0)="Y",DIR("A")="List all options in the Option File",DIR("B")="No" D ^DIR G:$D(DIRUT) OUT1 I Y S XQS="z",XQE="ZZZZZZZZ",XQR=1 G OUT
XQS R !?5,"From: ",XQS:DTIME S:'$T XQS=U G:XQS=U OUT1
 I XQS="?"!($L(XQS)>30)!(XQS=+XQS)!(XQS="") W *7,!?10,"Enter a partial option name, e.g., ""XQ"", or ""^"" to quit." G XQS
XQE R !?5,"To: ",XQE:DTIME S:'$T XQE=U G:XQE=U OUT1
 I XQE="?" W !,"Enter a partial option name, e.g. ""SD"", or ""^"" to quit." G XQE
 I XQE']XQS W *7,"The ending value preceeds the starting value." G XQS
OUT ;Normal exit
 S XQR=1
 K DIR
 Q
OUT1 ;Failure exit
 S (XQR,XQS,XQE)=0
 K DIR
 Q
 ;
PAUSE ;Hold screen
 N XQ
 R !!,"Hit RETURN to continue, or type ""^"" to quit: ",XQ:DTIME
 I XQ=U S XQUPAR="" Q
 E  W !
 Q
