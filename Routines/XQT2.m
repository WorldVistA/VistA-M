XQT2 ;SEA/Luke - Define a path template ;06/07/99  11:23
 ;;8.0;KERNEL;**37**;Jul 10, 1995
 S U="^",XQTSV=XQY_U_XQDIC_U_XQY0
EN ;Entry point for Create a Template Option.
 N %,XQTBK1,XQCOM,XQMNTMP,XQI,XQOPN,XQVN,XQSL,XQTF,XQTF1,XQTT,XQTREE,XQTREN
 S U="^",(XQI,XQOPN,XQMNTMP,XQVN,XQTREN,XQTF,XQTF1)=0,XQTT="",(XQDIC,XQY)=+^XUTL("XQ",$J,"XQM"),XQY0=^DIC(19,XQDIC,0),XQUR=""
 S XQCOM=$O(^DIC(19,"B","XUCOMMAND",0))
 S XQLIST(XQOPN)=XQDIC_U_XQY_U_XQY0,XQOPN=XQOPN+1,XQVN=XQVN+1
 S XQTREN=1,XQTREE(XQTREN)=XQDIC
 S XQAA="Choose one of the "_$P(XQY0,U,2)_" Options: "
 ;
 I '$D(IOF),'$D(IOSL) D HOME^%ZIS
 ;
 D SET
 ;
INF W @IOF,"Do you want some brief instructions? [Y/N] N// " R XQUR:DTIME S:'$T XQUR=U G:XQUR=U OUT S:XQUR="" XQUR="N" I XQUR["?" W !?3,"Answer 'Y' if you want some instructions, 'N' if you don't." G INF
 I "Yy"[XQUR S XQH="XQTCREATE" D EN^XQH
 ;
ASK ;Show user the choices and get the next option, if any
 W @IOF,?18,"CREATING A MENU TEMPLATE",!!?5,"Choose an option, type RETURN to back up one level,",!?5,"'+' to store the completed template, or '^' to quit.",! D LIST^XQ2
 ;
RD1 W !!,?5,XQAA R XQUR:DTIME S:'$T XQUR=U G:XQUR=U OUT G:XQUR="+" STORE
 I XQUR["^" W *7,!?3,"Sorry, no jumping." G RD1
 I XQUR="?" W !?3,"Enter an option, '+' to store the template,",!?3,"'??' for more help, or '^' to forget the whole thing." G RD1
 I XQUR["??" S XQUR="??" S XQTSAV=XQDIC D EN^XQ2 S XQDIC=XQTSAV G RD1
 I XQUR="" D BACK S XQDIC=+XQY G ASK
 S XQSAVE=XQDIC
 D DIC^XQ71
 ;
 ;
 I XQY<0 S XQTSV=XQDIC,XQDIC="U"_DUZ D DIC^XQ71 ;Search secondaries
 I XQY<0 S XQDIC=XQCOM D DIC^XQ71 ;Search XUCOMMAND
 I XQY<0 S XQDIC=XQTSV W " ??",*7 H 2 G ASK
 ;
 ;Disallow servers or broker-type options
 I XQY>0,"SB"[$P(XQY0,U,4) D
 .W " ??",*7
 .S XQY=+XQLIST(XQOPN-1),XQY0=$P(XQLIST(XQOPN-1),U,3,99),XQDIC=XQY
 .S XQTSB=""
 .H 2
 .Q
 I $D(XQTSB) K XQTSB G ASK
 ;
CHK W !!,$P(XQY0,U,2),"     ","(",$P(XQY0,U,1),")  This one? [Y/N] Y// " R %:DTIME S:%="" %="Y" W:(%["?")!("YyNn"'[%) *7,!!,"Please answer 'Y' or 'N'" G:(%["?")!("yYnN"'[%) CHK G:"Yy"'[% ASK
 S XQLIST(XQOPN)=XQY_U_XQDIC_U_XQY0,XQLIST(XQOPN,0)="Entry Action",XQOPN=XQOPN+1,XQVN=XQOPN
 S XQTT=XQTT_$S(XQTF:";",1:"")_XQY,XQTF=1
 ;
 I "MQ"'[$P(XQY0,U,4) D  K XQTBK1 G ASK
 .S XQTBK1=""
 .S XQLIST(XQOPN-1,1)="Exit Action"
 .D BACK
 .S XQDIC=+XQY
 .D SET
 .Q
 ;
 I "MQ"[$P(XQY0,U,4) D  G ASK
 .S XQDIC=+XQY
 .D SET
 .S XQAA="Choose one of the "_$P(XQY0,U,2)_" Options: "
 .Q
 Q
 ;
STORE ;Continued in the program ^XQT3
 I XQOPN=1 W !!,"A menu template that contains only your log-on menu?  Sorry, that's not",!?5,*7,"allowed.  Use '^^' to return to your log-on menu instead." G OUT
 G ^XQT3
 ;
OUT ;Clean up and quit
 I $D(XQTSV) S XQY=+XQTSV,XQDIC=$P(XQTSV,U,2),XQY0=$P(XQTSV,U,3,99)
 I '$D(XQTSV) S XQY=^(^XUTL("XQ",$J,"T")),XQDIC=$P($P(XQY,U),+XQY,2),XQY0=$P(XQY,U,2,99),XQY=+XQY
 K XQTSV
 ;
 ;Come here on a restart
O1 K D0,DA,DI,DIC,DQ,DR,XQA,XQAA,XQDR,XQH,XQH1,XQH2,XQI,XQJ,XQK,XQOPN,XQLIST,XQLK,XQN,XQNM,XQOO,XQRD,XQRL,XQSAV,XQSN,XQTSV,XQTF,XQTF1,XQTM,XQTRPT,XQTT,XQTXT,XQUR
 K XQT,XQT1,XQTSAV,XQSAVE,XQFLAG,XQL,XQLN
 Q
 ;
BACK ;Back up to last menu-type option and put it on the stack
 N %,XQFLG
 S XQFLG=0
 S:"MQ"[$P(XQY0,U,4) XQFLAG=1
 ;
 I XQOPN<2!(+XQLIST(0)=+XQLIST(XQOPN-1)) D
 .S XQY=+XQLIST(0),XQDIC=$P(XQLIST(0),U,2)
 .S XQFLG=1
 .W !!,*7,"You can't back up any further!",!!,"Press return to continue...." R %:30
 .Q
 Q:XQFLG
 ;
 S XQT1=$P(XQLIST(XQOPN-1),U,2)
 F XQJ=0:1:XQOPN-1 Q:XQT1=+XQLIST(XQJ)
 ;
 I XQJ=(XQOPN-1) D
 .S XQT1=+XQLIST(XQOPN-1)
 .F XQJ=1:1:$L(XQTT,";") S %=$P(XQTT,";",XQJ) Q:%=XQT1
 .S XQJ=XQJ-1
 .Q
 ;
 F XQI=XQJ:-1:0 Q:'XQI  Q:"MQ"[$P(XQLIST(XQI),U,6)
 I XQI<1 S XQLIST(XQOPN-1,1)="Exit Action",XQLIST(XQOPN)=XQLIST(0),(XQDIC,XQY)=+XQLIST(0),XQY0=$P(XQLIST(0),U,3,99),XQOPN=XQOPN+1,XQAA="Choose one of the "_$P(XQY0,U,2)_" Options: " Q
 S XQLIST(XQOPN-1,1)="Exit Action"
 S %=XQLIST(XQI),XQY=+%,XQDIC=$P(%,U,2),XQY0=$P(%,U,3,99)
 S XQLIST(XQOPN)=XQY_U_XQDIC_U_XQY0,XQOPN=XQOPN+1,XQVN=XQVN-1
 ;
 ;Drop down one more menu
 S XQJ=XQI
 F XQI=XQJ:-1:0 Q:'XQI  Q:"MQ"[$P(XQLIST(XQI),U,6)
 I XQI<1 S XQLIST(XQOPN-1,1)="Exit Action",XQLIST(XQOPN)=XQLIST(0),(XQDIC,XQY)=+XQLIST(0),XQY0=$P(XQLIST(0),U,3,99),XQOPN=XQOPN+1,XQAA="Choose one of the "_$P(XQY0,U,2)_" Options: "
 S %=XQLIST(XQI),XQY=+%,XQDIC=$P(%,U,2),XQY0=$P(%,U,3,99)
 ;S XQDIC=XQY
 I "MQ"[$P(XQY0,U,4) S XQAA="Choose one of the "_$P(XQY0,U,2)_" Options: "
 Q
 ;
SET ;Rebuild display nodes if neccissary
 L +^XUTL("XQO",XQDIC):5 D:$S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET L -^XUTL("XQO",XQDIC)
 Q
