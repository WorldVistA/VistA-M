XQSMD ; SEA/MJM - Secure MenuMan Delegation ;7/3/91  08:39 ;6/4/92  12:53 PM
 ;;8.0;KERNEL;;Jul 10, 1995
EN1 S XQDOP=0 G INIT ;Entry point for adding options
EN2 S XQDOP=1 ;Entry point for removing options from users
INIT ;
 S U="^" K ^TMP($J) S ^TMP($J)="XQSMD" S (XQUF,XQT,XQPRO,XQDEL,XQHOLD(0))=0
 D ^XQDATE S XQDATE=%Y
 I $S('$D(IOM):1,IOM=0:1,'$D(IOSL):1,'$L(IOSL):1,'$D(IOF):1,1:0) S IOP="HOME" D ^%ZIS I POP W !!,"*** DEVICE ERROR ***",!,"-delegation software exiting-" G OUT
 I '$D(DTIME) S DTIME=$$DTIME^XUP(DUZ,IOS)
 ;
MGR ;Find out who's delegating here.
 S XQDUZ=^XUTL("XQ",$J,"DUZ") I DUZ'=+XQDUZ G H^XUS
 S XQMGR=$P(^VA(200,DUZ,0),U,1)
 I DUZ(0)="@"!($D(^XUSEC("XUMGR",DUZ))) S XQPRO=1,XQLEV=0
 S XQON0="" S:$D(^VA(200,DUZ,19))#2 XQON0=^(19) I 'XQPRO,('$L(XQON0)) W !,"You have not been given the authority to delegate options.  See your Site Manager." G OUT
 I 'XQPRO S XQLEV=0 S:$L(XQON0) XQLEV=$P(XQON0,U,3) S:'$L(XQLEV)!(XQLEV<1) XQLEV=1
 ;
USER ;Get the duz of the user being delegated to.
 K ^TMP($J,"OP"),^("ZN"),XQHOLD,XQLK,XQKEY S (XQK,XQT,XQHOLD(0),XQKEY(0))=0
 W !!,"Enter the name(s) of your delegate(s), one at a time"
NAME S XQUF=1 W !!," Name: " R XQ:DTIME S:'$T XQ=U G:XQ="" DONE G:XQ=U OUT I XQ="?" W !!,"Enter a name, a name preceded by a minus, a '^' to quit, or '??' for help." G NAME
 I XQ["??" S XQH="XQSMD-USER" D:XQ="??" EN^XQH D:XQ="???" LIST D:XQ="????" LSTFIL S XQH="XQSMD-MAIN" D:XQ="?????" EN^XQH G NAME
 I $E(XQ,1)="-" S XQDEL=1,XQ=$E(XQ,2,99)
 S X=XQ,DIC=200,DIC(0)="MEZ" D ^DIC I Y<0 W !!," ** No such person in the User File **" G NAME
 I +Y=+DUZ W !,"It is illogical to delegate to oneself." G NAME
 I '$D(^VA(200,+Y,.1)) W !,"Sorry, this person has no verify code node in the user file." G NAME
 I '$L($P(^VA(200,+Y,.1),U,2)) W !,"Sorry, this person is not an active user." G NAME
 I XQDEL S XQDEL=0 K XQHOLD(+Y) G NAME
 I 'XQPRO S XQLVL=9999 S:$D(^VA(200,+Y,19))#2 XQLVL=$P(^(19),U,3) I XQLVL'?1N.N!(+XQLVL<+XQLEV) W !,"Delegation level error. You can not modify the options of ",$P(Y,U,2) G NAME
 S XQNAM=$P(Y,U,2),XQHOLD(+Y)=XQNAM,XQT=XQT+1 G NAME
DONE S (XQN,XQUF)=0 I $O(XQHOLD(XQN))="" W !!,"Enter a delegate's name or '^' to quit." G NAME
 ;
 G ^XQSMD1
 Q
LSTFIL ;Show USER, OPTION, or user's delegated options in ^VA(200,DUZ,19.5)
 D LIST S X="?",DIC=$S(XQUF:200,XQPRO:19,1:"^VA(200,DUZ,19.5,"),DIC(0)="Q" D ^DIC K DIC
 Q
 ;
LIST ;List users and options selected so far.
 W @IOF S (XQT,XQM)=0,XQM=$O(XQHOLD(XQM)) I XQM="" W !!," No users selected yet." Q
 W !!,"For the following user(s):",!
 F XQI=1:1 W:'(XQT#2) ! W ?(XQT#2*35),XQI,". ",XQHOLD(XQM) S XQT=XQT+1,XQM=$O(XQHOLD(XQM)) Q:XQM=""
 W !!,"You will ",$S(XQDOP:"remove ",1:"delegate "),"the following options: ",!
 S XQT=0,XQN="",XQN=$O(^TMP($J,"ZN",XQN)) I XQN="" W !!,"No menu options selected yet" Q
 F XQI=0:0 D:$Y+3>IOSL WAIT Q:XQ=U  W !,XQN,"   ",$P(^TMP($J,"ZN",XQN),U,1) S XQN=$O(^(XQN)) Q:XQN=""
 W !!,$S(XQDOP:" Removed ",1:" Delegated "),"by ",XQMGR," on ",XQDATE,".",!
 Q
WAIT ;Skip to the head of the next page
 I 1 R:IOST["C-" !!,"Press RETURN to continue,'^' to quit...",XQ:DTIME S:'$T&(IOST["C-") XQ=U W @IOF
 Q
 ;
OUT K DIC,DIC(0),POP,XQ,XQAL,XQH,XQI,XQJ,XQK,XQL,XQM,XQN,XQT,XQD,XQDATE,XQDEL,XQDUZ,XQDT,XQLEV,XQLVL,XQLK,XQMG,XQMGR,XQNM,XQNAM,XQUF,XQPRO,XQSTART,XQEND,XQHOLD,XQKEY,XQON,XQON0,X,Y,XY,%,^TMP($J)
 Q
