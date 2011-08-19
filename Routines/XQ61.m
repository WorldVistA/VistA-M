XQ61 ;SEA/AMF,MJM - BULK EDITORSHIP ASSIGNMENT ;9/28/92  16:21;5/13/93  11:44 AM
 ;;8.0;KERNEL;;Jul 10, 1995
EN1 S XQAL=1 G INIT ; ENTRY POINT FOR ASSIGNMENT OF EDITORS
EN2 S XQAL=0 ;        ENTRY POINT FOR DE-ASSIGNMENT OF EDITORS
INIT ;
 K XQHELP,XQEDTR S (XQHELP(0),XQEDTR(0))=0
 ;
HELP ;Get the list of help frames in question
 W !!,$S($O(XQHELP(0))>0:"Another",1:"Select")," help frame: " R X:DTIME S:'$T X=U G:X[U OUT
 I '$L(X) G:($O(XQHELP(0))="") OUT G EDITOR
 I X["?" S XQH="XQHELP-ASSIGNEDITOR-H" D:X="?" EN^XQH D:X="??" LSTHELP D:X="???" ^XQ62 G HELP
 S XQM=0 S:"-'"[$E(X,1) X=$E(X,2,999),XQM=1
 S DIC=9.2,DIC(0)="EZ",DIC("S")="I (DUZ(0)=""@"")!($D(^XUSEC(""XUMGR"",DUZ)))!($D(^DIC(9.2,""AC"",DUZ,Y)))" D ^DIC K DIC I Y<0 W " ??",*7 G HELP
 I XQM W $S($D(XQHELP(+Y)):"  Deleted",1:$C(7)_" ??  Help frame not on list") K XQHELP(+Y) G HELP
 S XQHELP(+Y)="" G HELP
 ;
EDITOR ;Get the names of the users involved
 W !!,$S($O(XQEDTR(0))>0:"Another editor: ",1:"Editor of help frame: ") R X:DTIME S:'$T X=U G:X[U OUT
 I '$L(X) G:($O(XQEDTR(0))>0) OK W " ??",*7,!,"You have not yet selected any editors." G EDITOR
 I X["?" S XQH="XQHELP-ASSIGNEDITOR-U" D:X="?" EN^XQH D:X="??" LSTEDT D:X="???" ^XQ62 G EDITOR
 S XQM=0 S:"'-"[$E(X,1) X=$E(X,2,999),XQM=1
 I $E(X,1,2)'="G." S DIC=200,DIC(0)="EMZ",DIC("S")="I $L($P(^(0),U,3))" D ^DIC K DIC W:(Y<0) " ??",*7 G:Y<0 EDITOR S XQI=+Y D EACH G EDITOR
 S X=$E(X,3,999),XMDUZ=DUZ,DIC="^XMB(3.8,",DIC("S")="D:$P(^(0),U,2)=""PR"" CHK^XMA21",DIC(0)="EMZ" D ^DIC K DIC I Y<0 W " ??",*7 G EDITOR
 S XQJ=0 F  S XQJ=$O(^XMB(3.8,+Y,1,XQJ)) Q:XQJ'>0  S XQI=+^(XQJ,0) W !,$P(^VA(200,XQI,0),U,1) D EACH
 G EDITOR
EACH I XQM W $S($D(XQEDTR(XQI)):"  Deleted",1:$C(7)_" ??  Editor not on list") K XQEDTR(XQI) Q
 S XQEDTR(XQI)=""
 Q
 ;
OK ;Show the list of help frams and users and get the OK to proceed
 D LSTHELP,LSTEDT
OK1 R !!,"Do you wish to proceed? YES// ",X:DTIME S:'$T X=U G:X=U OUT G:(X["N"!(X["n")) HELP I X["?" W !!,"'Y' means ",$S(XQAL:"assign",1:"remove")," the editor(s), 'N' means edit help frame or editor lists." G OK1
 S:'$L(X) X="Y" I '(X["Y"!(X["y")) W *7," ??",!?10,"Please enter 'Y' or 'N', '^' to quit or '?' for help." G OK1
 ;
ACT ;Do the deed
 S DIE=9.2,DA=0,DR(2,9.24)=.01 F  S DA=$O(XQHELP(DA)) Q:DA'>0  W !!,$P(^DIC(9.2,DA,0),U,1)," being ",$S(XQAL:"assigned to:",1:"taken away from:") D ACT1
 ;
 G OUT
ACT1 ;
 S XQJ=IOM\26,XQM=0 F  S XQM=$O(XQEDTR(XQM)) Q:XQM=""  D ACT2
 Q
ACT2 ;
 S XQNM=$P(^VA(200,XQM,0),U,1) W !?5,XQNM G:'XQAL ACT3
 I $D(^DIC(9.2,"AD",XQM,DA)) W ?30,"User already is editor of help frame - no action taken" Q
 S DR="7///"_XQNM D ^DIE Q
ACT3 I '$D(^DIC(9.2,"AD",XQM,DA)) W ?30,"User isn't editor of help frame no action taken" Q
 S DR="7///"_XQNM,DR(2,9.24)=".01///@" D ^DIE Q
 Q
 ;
LSTHELP ;Show the list of help frams concerned
 I $O(XQHELP(0))="" W !!,"You have not yet selected any help frames." Q
 W !!,"You've selected the following help frames: ",! S XQJ=0,XQI=IOM\15 F XQK=0:1 S XQJ=$O(XQHELP(XQJ)) Q:XQJ'>0  W:'(XQK#XQI) ! W ?(XQK#XQI*15),$P(^DIC(9.2,XQJ,0),U,1)
 Q
 ;
LSTEDT ;Show the list of editors selected so far
 I $O(XQEDTR(0))'>0 W !!,"You have not yet selected any editors." Q
 W !!,"You've selected the following editors: ",! S XQJ=0,XQI=IOM\26 F XQK=0:1 S XQJ=$O(XQEDTR(XQJ)) Q:XQJ'>0  W:'(XQK#XQI) ! W ?(XQK#XQI*26),$P(^VA(200,XQJ,0),U,1)
 Q
 ;
OUT ;Clean up and quit
 K DA,DIC,DIE,DR,X,Y,XQAL,XQHELP,XQEDTR,XQH,XQI,XQJ,XQK,XQM,XQNM
 Q
