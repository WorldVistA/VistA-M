XQSMD21 ; SEA/MJM,JLI - Secure Menu delegation (Part IV) ;11/20/91  10:33 ;5/15/91  3:01 PM
 ;;8.0;KERNEL;;Jul 10, 1995
 Q
 ;
KEYS ;Allocate or remove keys needed for these options.
 W !!,"Some of these options are locked. Do you want to ",$S(XQDOP:"remove ",1:"issue "),"keys now? Y/N " R XQ:DTIME S:'$T XQ=U G:XQ[U OUT Q:XQ["N"!(XQ["n")
 S XQH="XQSMD-KEYS" D:XQ["?" EN^XQH I '(XQ["Y"!(XQ["y")) W *7,!,"Enter 'Y' or 'N'" G KEYS
 S XQAL=$S(XQDOP:0,1:1),XQDA=0 D OK^XQ6A ;Do the bulk key distribution software
 Q
 ;
SHOW ;Show a user's delegated options
 S U="^" I $S('$D(IOM):1,IOM=0:1,'$D(IOSL):1,'$L(IOSL):1,'$D(IOF):1,'$L(IOF):1,1:0) S IOP="HOME" D ^%ZIS I POP W !!,"**** DEVICE ERROR ****",!,"IOM, IOSL, or IOF not set properly",!,"Delegation software exiting." K POP G OUT
 S DIC=200,DIC(0)="AEMQZ" D ^DIC Q:Y<0  S XQ=+Y I '$D(^VA(200,XQ,19))!('$D(^(19.5,0))) W !!,Y(0,0)," has no delegated options." K DIC,XQ Q
 S XQM=^VA(200,XQ,19),XQD=$P(XQM,U,2),XQL=$P(XQM,U,3),XQM=+XQM,%=XQD,XQD=$S($E(%,4)=0:$E(%,5),1:$E(%,4,5))_"/"_$S($E(%,6)=0:$E(%,7),1:$E(%,6,7))_"/"_$E(%,2,3) K %
 S XQNM=$S(XQM=+XQM&(XQM>0):$P(^VA(200,XQM,0),U,1),1:"person unknown")
 W @(IOF),!!,Y(0,0)," a delegate of: ",XQNM," on ",XQD," at level ",XQL
 S XQN=0 F XQI=1:1 S XQN=$O(^VA(200,XQ,19.5,"B",XQN)) Q:XQN=""  I $D(^DIC(19,XQN,0)) S XQ0=^(0),^TMP($J,"XQSMD",$P(XQ0,U,1))=$P(XQ0,U,2)_U_^VA(200,XQ,19.5,XQN,0)
 W !!,"OPTION (INTERNAL #)",?25,"MENU TEXT",?65,"DELEGATED (DUZ)",!
 S XQN=0,XQ=""
 F XQI=1:1 D:$Y+2>IOSL WAIT Q:XQ=U  S XQN=$O(^TMP($J,"XQSMD",XQN)) Q:XQN=""  S XQ0=^(XQN),%=$P(XQ0,U,4),XQD=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3) W !,$E(XQN,1,27)," (",$P(XQ0,U,2),")",?25,$P(XQ0,U,1),?65,XQD," (",$P(XQ0,U,3),")"
 G OUT
 ;
WAIT ;Skip to top of next page
 I 1 S XQ="" R:IOST["C-" !?26,"Press RETURN to continue, '^' to halt...",XQ:DTIME S:'$T XQ=U W @IOF
 Q
 ;
OUT K C,DIC,DIK,DA,DISYS,DINUM,POP,XQ,XQD,XQH,XQI,XQJ,XQK,XQL,XQM,XQN,XQNM,XQT,XQON,XQON0,XQAL,XQDATE,XQDEL,XQDT,XQDUZ,XQLEV,XQLK,XQMG,XQMGR,XQNAM,XQNGO,XQUF,XQPRO,XQSTART,XQEND,XQHOLD,XQKEY,X,Y,XY,%,^TMP($J)
 K IOP,XQ0
 Q
