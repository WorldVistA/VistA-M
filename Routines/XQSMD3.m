XQSMD3 ; SEA/MJM - Secure MenuMan Delegation utilities; 12/11/07
 ;;8.0;KERNEL;**64,475**;Jul 10, 1995;Build 8
INIT S U="^",XQNGO=1,XQLEV="" S (XQDOP,XQDEL,XQPRO)=0 S:DUZ(0)="@"!($D(^XUSEC("XUMGR",DUZ))) XQPRO=1
 I $S('$D(IOM):1,IOM=0:1,'$D(IOSL):1,'$L(IOSL):1,'$D(IOF):1,'$L(IOF):1,'$D(IO):1,1:0) S IOP="HOME" D ^%ZIS I POP W !!,"*** DEVICE ERROR ***",!,?5,"-exiting-" G OUT
 S:'$D(DTIME)#2 DTIME=60
 S %DT="",X="T" D ^%DT S XQDT=Y X ^DD("DD") S XQDATE=Y K %DT
 S DIC=200,DIC(0)="FMNZ",X="`"_DUZ D ^DIC K DIC G:+Y<0 OUT S XQMGR=$P(Y(0,0),",",2)_" "_$P(Y(0,0),",",1)
 S:XQPRO XQLEV=0 S:'$L(XQLEV)&($D(^VA(200,DUZ,19))#2) XQLEV=$P(^(19),U,3) W:'$L(XQLEV) !,"Level problem. No action permitted." G:'$L(XQLEV) OUT
 ;
USER1 ;Find the user who's delegated options will be transfered.
 R !!,"Please enter the user currently holding the options :",XQ:DTIME S:'$T XQ=U G:XQ=U OUT I '$L(XQ)!(XQ="?") W !!,"Enter delegate's name,'^' to quit,'??' for User list, or '???' for help.",! G USER1
 I XQ="??" S X="?",DIC=200,DIC(0)="Q" D ^DIC K DIC G USER1
 I XQ="???" S XQH="XQSMD-REPLICATE" D EN^XQH G USER1
 S X=XQ,DIC(0)="QMENZ",DIC=200 D ^DIC I +Y<1 W !!,"Not a know user.  Try again or enter a '^' to quit." G USER1
 I '$D(^VA(200,+Y,19.5,0))!($O(^(0))="") W !!,Y(0,0)," has not been delegated any menu options to transfer." G USER1
 S XQPERX="^VA(200,"_+Y_",19.5,",XQU1=$P(Y(0,0),",",2)_" "_$P(Y(0,0),",",1),XQU1Y=+Y
 S XQU1L=$P($G(^VA(200,+XQU1Y,19)),U,3) I XQLEV>XQU1L W !!,"You may not, in this case, remove the options of ",XQU1 S XQDEL=0 G USER2
 ;
RPLC W !!,"Should ALL delegated options be removed from ",XQU1,!,"   after they have been transferred? N// " R XQ:DTIME S:'$T XQ=U G:XQ=U OUT S:'$L(XQ) XQ="N" I XQ="?" W !!,"Please enter 'Y' or 'N', '^' to quit, or '??' for help.",! G RPLC
 I XQ="??" S XQH="XQSMD-REMOVE" D EN^XQH G RPLC
 I "YyNn"'[XQ W !,"Please answer 'Y' or 'N' " G RPLC
 S:XQ["Y"!(XQ["y") XQDEL=1
 ;
USER2 ;Get the name of the person to whom these options will be transfered
 W !!,"Please enter the user who will get the same options as ",XQU1,!,"   now has: " R XQ:DTIME S:'$T XQ=U G:XQ=U OUT I XQ="?"!('$L(XQ)) W !!,"Enter User's name,'^' to quit,'??' for User list, or '???'for help.",! G USER2
 I XQ="??" S DIC=200,X="?",DIC(0)="Q" D ^DIC K DIC G USER2
 I XQ="???" S XQH="XQSMD-REPLACEMENT" D EN^XQH G USER2
 S X=XQ,DIC=200,DIC(0)="EFMQZ" D ^DIC I +Y<1 W !!,"Sorry, this person is not in the User File.  Try again or enter '^' to quit." G USER2
 I $D(^VA(200,+Y,0)),'$L($P($G(^(.1)),U,2)) W !!,"Sorry, this person is not a current user.  Try again or enter '^' to quit." G USER2
 S XQHOLD(+Y)=Y(0,0),XQU2=$P(Y(0,0),",",2)_" "_$P(Y(0,0),",",1)
 I +XQU1Y=+Y W !!,"Sorry, this is illogical: it's the same person!" G USER2
 I +Y=+DUZ W !!,"Sorry, you can't be your own delegate." G OUT
 ;
ASK ;See if we all understand eachother.
 W !!!,"You want to assign the options currently held by ",XQU1,!,?5,"to ",XQU2
 W:XQDEL " and remove them from ",XQU1
 W !!,"Is this correct? Y/N " R XQ:DTIME S:'$T XQ=U G:XQ=U OUT G:XQ["N"!(XQ["n") INIT S XQH="XQSMD-OK" I XQ["?" D EN^XQH G ASK
 I XQ'["Y"&(XQ'["y") W !!,*7,"Please answer 'Y' or 'N'." G ASK
 I XQDEL W !!,"Request to remove delegated options from ",XQU1," will be queued. "
 ;
 G ^XQSMD31
 ;
OUT K DIC,DIK,DA,DISYS,DINUM,POP,XQ,XQD,XQH,XQI,XQJ,XQK,XQL,XQM,XQN,XQT,XQON,XQON0,XQAL,XQDATE,XQDEL,XQDT,XQDUZ,XQLEV,XQLK,XQMG,XQMGR,XQNAM,XQNGO,XQUF,XQPRO,XQSTART,XQEND,XQHOLD,XQKEY,X,Y,XY,%,^TMP($J),XQDOP,C
 Q
