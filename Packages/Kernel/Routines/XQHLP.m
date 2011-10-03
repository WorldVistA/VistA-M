XQHLP ;SEA/MJM - Menu Helper  ;07/21/09  11:37
 ;;8.0;KERNEL;**46,514**;Jul 10, 1995;Build 8
 ;
PAUSE R !!,"  **> Press 'RETURN' to continue, '^' to stop, or '?[option text]' for more",!?25,"help: ",XQL:DTIME D:XQL?1"?"1AN.ANP HELP S XQL=$S(XQL[U:-1,1:XQLN) W @IOF Q
 ;
PAUSE1 R !!,"  **> Press 'RETURN' to continue, '^' to stop: ",XQL:DTIME S XQL=$S(XQL[U:-1,1:XQLN) W @IOF Q
 ;
SHOW  F  S XQX=$O(^XUTL("XQO",XQDIC,XQX)) Q:XQX=U!(XQL<0)!(XQX="")  I $P(^(XQX),U,2) D
 .S XQHY=^(XQX)
 .D PRNT
 .Q  ;G SHOW
 Q
 ;
PRNT ;Print out the description of the option XQHY
 I '$L($P(XQHY,U,2))!'$D(^DIC(19,+XQHY,0)) Q
 I XQL<5 D PAUSE Q:XQL<0
 S XQHY0=^XUTL("XQO",XQDIC,"^",+XQHY) W !!,"'"_$P(XQHY0,U,3)_"'     Option name: ",$P(XQHY0,U,2) S XQL=XQL-2 S %=$P(XQHY0,U) I %]"" W "     Synonym: ",%
 I '$D(XQHLP),$P(XQHY0,U,8)'="" S %=$P($P(XQHY0,U,3)," "),%=$S($L(%)>3:%,1:$P($P(XQHY0,U,3)," ",1,2)) W !,"  **> Extended help available.  Type ","""","?"_%,""""," to see it." S XQL=XQL-1
 F XQNXTOP=0:0 S XQNXTOP=$O(^DIC(19,+XQHY,1,XQNXTOP)) Q:XQNXTOP=""  S XQA=^(XQNXTOP,0) W !?5,XQA S XQL=XQL-1 D PAUSE:'XQL
 Q
 ;
HELP ;Display a help screen
 N XQHY,XQX S XQHSV=XQY_U_XQDIC_U_XQY0,XQUR=$P(XQL,"?",2) D DIC^XQ71
 I XQY<0 W " ??",*7 S XQY=+XQHSV,XQDIC=$P(XQHSV,U,2),XQY0=$P(XQHSV,U,3,99) Q
 S XQH=$P(XQY0,U,7) I '$L(XQH) W !!,"**> Sorry, no help text available for this option." S XQY=+XQHSV,XQDIC=$P(XQHSV,U,2),XQY0=$P(XQHSV,U,3,99) Q
 D EN^XQH S XQY=+XQHSV,XQDIC=$P(XQHSV,U,2),XQY0=$P(XQHSV,U,3,99),XQL=0
 Q
 ;
EN ;Show descriptions from Option File Entry point from EN^XQ2
 ;S XQHSV=XQY_U_XQDIC_U_XQY0
 S XQX=0,(XQL,XQLN)=$S($D(IOSL):IOSL-2,1:22),XQSAV=XQDIC D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET D SHOW W !! G:XQL<0 OUT
 S DIR(0)="Y",DIR("A")="  Shall I show you your secondary menus too",DIR("B")="No" D ^DIR G:$D(DUOUT) OUT
 I Y W @IOF S XQDIC="U"_DUZ D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET S XQL=XQLN,XQX=0 W ?25,"**> Your secondary options <**",!! D SHOW W !!
 G:XQL<0 OUT
 S DIR(0)="Y",DIR("A")="  Would you like to see the Common Options",DIR("B")="No" D ^DIR G:$D(DUOUT) OUT
 I Y W @IOF S XQL=XQLN,XQX=0,XQDIC=$O(^DIC(19,"B","XUCOMMAND",0))
 I Y D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET W ?17,"**> The Common Options, options available to everyone <**",!! D SHOW
 ;
OUT ;Exit here
 W !!
 ;S:$D(XQSAV) XQDIC=XQSAV
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XQA,XQHSV,XQHY,XQHY0,XQNXTOP,XQL,XQLN,XQN,XQSAV,XQX,Y
 I $D(XQHLP) K XQHLP Q
 G M2^XQ
 ;
OPT ;Respond to a user entering "?Option_text"
 ;Enter with XQUR from XQ.  Find option, show help, return to XQ
 S XQHSV=XQY_U_XQDIC_U_XQY0
 S (XQL,XQLN)=$S($D(IOSL):IOSL-2,1:22)
 I XQUR["?" F  S XQUR=$P(XQUR,"?",2) Q:XQUR'["?"
 S XQHLP="" ;Set a flag so we know it isn't a jump
 D S^XQ75
 I XQY>0 D
 .W @IOF W !!!
 .S XQHY=XQY_U_XQY0
 .D PRNT,PAUSE1
 .I $P(XQY0,U,7)'="" D
 ..S XQH=$P(XQY0,U,7) D EN^XQH
 ..Q
 .Q
 S (XQY,XQDIC)=$P(XQHSV,U),XQY0=$P(XQHSV,U,3,99)
 G OUT
 Q
