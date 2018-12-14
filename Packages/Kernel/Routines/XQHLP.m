XQHLP ;SEA/MJM - Menu Helper  ;Dec 13, 2018@10:06
 ;;8.0;KERNEL;**46,514,OSE/SMH**;Jul 10, 1995;Build 8
 ; Original Routine authored by US Department of Veteans Affairs and in Public Domain
 ; OSE/SMH changes to support VistA Intenationalization
 ; OSE/SMH modificiations (c) Sam Habiel 2018
 ; Look for OSE/SMH for specific modifications
 ; Licensed Under Apache 2.0
 ;
 ; OSE/SMH - l10n - PAUSE and PAUSE1
 ; was: PAUSE R !!,"  **> Press 'RETURN' to continue, '^' to stop, or '?[option text]' for more",!?25,"help: ",XQL:DTIME D:XQL?1"?"1AN.ANP HELP S XQL=$S(XQL[U:-1,1:XQLN) W @IOF Q
PAUSE ;
 N XQMSG D BLD^DIALOG(19003,,,"XQMSG") ; DIALOG: RETURN, ^, or ?[option text] for more help
 W !
 N I F I=0:0 S I=$O(XQMSG(I)) Q:'I  W !,XQMSG(I)
 R XQL:DTIME
 D:XQL?1"?"1AN.ANP HELP
 S XQL=$S(XQL[U:-1,1:XQLN)
 W @IOF
 QUIT
 ;
 ; was: PAUSE1 R !!,"  **> Press 'RETURN' to continue, '^' to stop: ",XQL:DTIME S XQL=$S(XQL[U:-1,1:XQLN) W @IOF Q
PAUSE1 ;
 N XQMSG D BLD^DIALOG(19004,,,"XQMSG") ; DIALOG: RETURN, ^ to stop
 W !
 N I F I=0:0 S I=$O(XQMSG(I)) Q:'I  W ! W:I=1 "  **> " W XQMSG(I)
 R XQL:DTIME
 S XQL=$S(XQL[U:-1,1:XQLN)
 W @IOF
 QUIT
 ; /OSE/SMH end
 ;
 ; OSE/SMH change below: Korean sorts after ^, so it was not being shown. Now it is shown.
SHOW  F  S XQX=$O(^XUTL("XQO",XQDIC,XQX)) Q:(XQL<0)!(XQX="")  I $D(^(XQX))#2,$P(^(XQX),U,2) D  ; OSE/SMH - new line
 .; SHOW used to be: F  S XQX=$O(^XUTL("XQO",XQDIC,XQX)) Q:XQX=U!(XQL<0)!(XQX="")  I $P(^(XQX),U,2) D  ; OSE/SMH - old line
 .S XQHY=^(XQX)
 .D PRNT
 .Q  ;G SHOW
 Q
 ;
PRNT ;Print out the description of the option XQHY
 I '$L($P(XQHY,U,2))!'$D(^DIC(19,+XQHY,0)) Q
 I XQL<5 D PAUSE Q:XQL<0
 S XQHY0=^XUTL("XQO",XQDIC,"^",+XQHY) W !!,"'"_$P(XQHY0,U,3)_"'     "_$$EZBLD^DIALOG(19005)_": ",$P(XQHY0,U,2) S XQL=XQL-2 S %=$P(XQHY0,U) I %]"" W "     "_$$EZBLD^DIALOG(19006)_": ",% ; OSE/SMH - DIALOGS: Option name, Synonym
 ; OSE/SMH - DIALOGS; write portion was: W !,"  **> Extended help available.  Type ","""","?"_%,""""," to see it." S XQL=XQL-1
 I '$D(XQHLP),$P(XQHY0,U,8)'="" S %=$P($P(XQHY0,U,3)," "),%=$S($L(%)>3:%,1:$P($P(XQHY0,U,3)," ",1,2)) W !,"  **> ",$$EZBLD^DIALOG(19007,%) S XQL=XQL-1
 F XQNXTOP=0:0 S XQNXTOP=$O(^DIC(19,+XQHY,1,XQNXTOP)) Q:XQNXTOP=""  S XQA=^(XQNXTOP,0) W !?5,XQA S XQL=XQL-1 D PAUSE:'XQL
 Q
 ;
HELP ;Display a help screen
 N XQHY,XQX S XQHSV=XQY_U_XQDIC_U_XQY0,XQUR=$P(XQL,"?",2) D DIC^XQ71
 I XQY<0 W " ??",*7 S XQY=+XQHSV,XQDIC=$P(XQHSV,U,2),XQY0=$P(XQHSV,U,3,99) Q
 S XQH=$P(XQY0,U,7) I '$L(XQH) W !!,"**> "_$$EZBLD^DIALOG(19008) S XQY=+XQHSV,XQDIC=$P(XQHSV,U,2),XQY0=$P(XQHSV,U,3,99) Q  ; OSE/SMH: DIALOG: Sorry, no help text available for this option.
 D EN^XQH S XQY=+XQHSV,XQDIC=$P(XQHSV,U,2),XQY0=$P(XQHSV,U,3,99),XQL=0
 Q  ;
EN ;Show descriptions from Option File Entry point from EN^XQ2
 ;S XQHSV=XQY_U_XQDIC_U_XQY0
 S XQX=0,(XQL,XQLN)=$S($D(IOSL):IOSL-2,1:22),XQSAV=XQDIC D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET D SHOW W !! G:XQL<0 OUT
 S DIR(0)="Y",DIR("A")="  "_$$EZBLD^DIALOG(19009),DIR("B")=$P($$EZBLD^DIALOG(7001),U,2) D ^DIR G:$D(DUOUT) OUT ;OSE/SMH: DIALOG: Shall I show you your secondary menus too/No
 I Y W @IOF S XQDIC="U"_DUZ D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET S XQL=XQLN,XQX=0 W ?25,"**> "_$$EZBLD^DIALOG(19010)_" <**",!! D SHOW W !! ; OSE/SMH: DIALOG sec
 G:XQL<0 OUT
 S DIR(0)="Y",DIR("A")="  "_$$EZBLD^DIALOG(19011),DIR("B")=$P($$EZBLD^DIALOG(7001),U,2) D ^DIR G:$D(DUOUT) OUT ;OSE/SMH: DIALOG: Would you like to see the Common Options/No
 I Y W @IOF S XQL=XQLN,XQX=0,XQDIC=$O(^DIC(19,"B","XUCOMMAND",0))
 I Y D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET W ?17,"**> "_$$EZBLD^DIALOG(19012)_" <**",!! D SHOW ; OSE/SMH: DIALOG: The Common Options, options available to everyone
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
