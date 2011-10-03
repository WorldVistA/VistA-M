XQSMD1 ; SEA/MJM - Secure MenuMan Delegation (cont.); 5/18/88  2:16 PM ;9/13/96  09:23
 ;;8.0;KERNEL;**47**;Jul 10, 1995
 ;
 S XQK=0
GETOP ;Get options to add to (or remove from XQDOP) users.
 W !!,"Enter options you wish to ",$S(XQDOP:"REMOVE FROM",1:"DELEGATE TO")," these users"
ASK W !!,$S(XQDOP:"Remove",1:"Add")," option(s): " R XQ:DTIME S:'$T XQ=U G:XQ=U OUT G:XQ="" ^XQSMD2 I XQ="?" W !!,"Enter an option name, an option preceded by a minus, '^' to quit, or '??' for help." G ASK
 I XQ["??" S XQH="XQSMD-OPTION" D:XQ="??" EN^XQH D:XQ="???" LIST D:XQ="????" LSTFIL S XQH="XQSMD-MAIN" D:XQ="?????" EN^XQH G ASK
 S XQDEL=0 I $E(XQ,1)="-" S XQDEL=1,XQ=$E(XQ,2,99)
 I XQ="*",XQDOP G REMOV
 I XQ="*",'XQDEL S XQSTART=1,XQEND="ZZZZZ" D FIND G ASK
 I XQ="*",XQDEL K ^TMP($J,"OP"),^TMP($J,"ZN") W !," All options removed.  Start again or '^' to quit. " G ASK
 I XQ?.E1"*" S XQSTART=$E(XQ,1,$L(XQ)-1),XQEND=XQSTART_$C(127) D FIND G ASK
 ;
 ;Get a range of options allowing for name with hyphens in them
 I XQ?1E.E1"-"1E.E S XQRNG=0 D  G:'XQRNG ASK
 .S X=XQ,DIC=19,DIC(0)="MEZ" D ^DIC S:Y'<0 XQ=$P(Y,U,2) I Y>0 S XQRNG=1 Q
 .W ! S DIR("A")="Do mean the options from "_$P(XQ,"-")_" to "_$P(XQ,"-",2)_"? (Y/N)",DIR("B")="YES",DIR(0)="Y" D ^DIR I Y S (XQN,XQSTART)=$P(XQ,"-",1),XQEND=$P(XQ,"-",2) D FIND
  .Q
  ;
  I XQ'?1E.E1"-"1E.E S X=XQ,DIC=19,DIC(0)="MEZ" D ^DIC S:Y'<0 XQ=$P(Y,U,2) I Y<0 W !," ??",*7 G ASK
 ;I XQ?1E.E1"-"1E.E W !?10,"Do mean the options from ",$P(XQ,"-")," to ",$P(XQ,"-",2) S DIR(0)="Y" D ^DIR I Y S XQSTART=$P(XQ,"-",1),XQEND=$P(XQ,"-",2) D FIND G ASK
 S X=XQ,DIC=19,DIC(0)="MEZ" D ^DIC S:Y'<0 XQ=$P(Y,U,2) I Y<0 W !," ??",*7 G ASK
 I 'XQDEL,$P(Y(0),U,13)["n" W !,*7,"This option is not delegable." G ASK
 I XQDEL K ^TMP($J,"OP",+Y),^TMP($J,"ZN",XQ) G ASK
 S ^TMP($J,"OP",+Y)="",^TMP($J,"ZN",XQ)=$P(Y(0),U,2,99) G ASK
 ;
FIND ;Find first routine in wildcard list
 S XQN="" S:$L(XQSTART)>2 XQN=$E(XQSTART,1,$L(XQSTART)-1) F XQI=0:0 S XQN=$O(^DIC(19,"B",XQN)) Q:XQN=""!($E(XQN,1,$L(XQSTART))=XQSTART)
 I XQN="" W !," No such options." G ASK
FINDR S XQSTART=XQN,XQON=$O(^DIC(19,"B",XQN,0)),XQON0=^DIC(19,+XQON,0)
 I XQDEL D DELET Q
 ;
GET ;Get the options selected and put them in ^UTILITY.
 S XQN=XQSTART S:$P(XQON0,U,13)'["n" ^TMP($J,"OP",+XQON)="",^TMP($J,"ZN",XQN)=$P(XQON0,U,2,99),XQK=XQK+1 S DIC=19,DIC(0)="MZ"
NEXT F XQI=0:0 Q:XQN=XQEND  S XQN=$O(^DIC(19,"B",XQN)) Q:XQN=""!(XQN]XQEND)  S XQON=$O(^DIC(19,"B",XQN,0)),XQON0=^DIC(19,+XQON,0) I $P(XQON0,U,13)'["n" S ^TMP($J,"OP",+XQON)="",^TMP($J,"ZN",XQN)=$P(XQON0,U,2,99),XQK=XQK+1
 Q
 ;
DELET S XQN=XQSTART,XQDEL=0 F XQI=0:0 K ^TMP($J,"OP",+XQON),^TMP($J,"ZN",XQN) S XQN=$O(^DIC(19,"B",XQN)),XQX=XQK-1 Q:XQN=""!(XQN]XQEND)  S XQON=$O(^DIC(19,"B",XQN,0))
 Q
 ;
REMOV R !!,"Remove all options previously delegated to all users in your list? ",XQ:DTIME S:'$T XQ=U G:XQ[U OUT I XQ["N"!(XQ["n") W !!,"OK, you may continue building a list of options to remove." G ASK
 I XQ'["Y"&(XQ'["y") W !!,"Please answer 'Y' or 'N'" G REMOV
 S ZTRTN="DELM^XQSMD31",ZTDTH=$H,ZTIO="",ZTDESC="Remove previously delegated options.",ZTSAVE("XQHOLD(")="" D ^%ZTLOAD
 W !!,"Your request has been queued, task # ",ZTSK G OUT
 Q
LSTFIL ;Show USER, OPTION, or user's delegated options in ^VA(200,DUZ,19.5)
 D LIST S X="?",DIC=$S(XQUF:3,XQPRO:19,1:"^VA(200,DUZ,19.5,"),DIC(0)="Q" D ^DIC K DIC
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
 ;
WAIT ;Skip to the head of the next page
 I 1 S XQ="" R:IOST["C-" !!,"Press RETURN to continue, or '^' to quit.",XQ:DTIME S:'$T XQ=U W @IOF
 Q
 ;
OUT K DIC,DIC(0),POP,XQ,XQAL,XQH,XQI,XQJ,XQK,XQL,XQM,XQN,XQT,XQD,XQDATE,XQDEL,XQDUZ,XQDT,XQLEV,XQLK,XQMG,XQMGR,XQNM,XQNAM,XQUF,XQPRO,XQRNG,XQSTART,XQEND,XQHOLD,XQKEY,XQON,XQON0,X,Y,XY,%,^TMP($J),ZTSK
 Q
