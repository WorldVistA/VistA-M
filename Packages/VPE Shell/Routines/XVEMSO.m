XVEMSO ;DJB/VSHL**Run Kernel Menu Option ;2017-08-16  10:32 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Error traps removed by Sam Habiel. No new code by Sam Habiel.
 ;
KERNEL(OPT) ;Calls KERNEL ^XQ
 ;OPT=Name/number of entry in OPTION file (#19)
 D SETUP G:OPT']"" EX
 NEW %H,%I,A,DIC,I1,X,Y,Z
 NEW XQAA,XQABOLD,XQABTST,XQCH,XQCY,XQDIC,XQI,XQJ,XQJMP,XQK,XQM,XQNOHALT,XQPSM,XQN,XQPSM,XQSAV,XQSV,XQT,XQTT,XQUR,XQUSER,XQV,XQVOL,XQY,XQYY,XQY0,XQZ,XUD,XUDEV,XUVOL
 S (XQY,XQM)=OPT,XQNOHALT=1 W ! D ^XQ W !
 G EX
OPTION(OPT) ;Uses code taken from KERNEL's ^XQ1
 ;OPT=Name/number of entry in OPTION file (#19)
 D SETUP G:OPT']"" EX D CHECK G:OPT']"" EX
 NEW D0,DIASKHD,D,DA,DI,DIC,DICS,DIE,DPP,DQ,DR,DW
 NEW %,%X,%Y,C,FLDS,I,LIST,NUM,Q,VAR,X,Y,Z
 W !,$P(^DIC(19,OPT,0),U,2) D @($P(^(0),U,4)_"^XVEMSO1") W !
EX ;
 Q
SETUP ;Setup variable OPT
 S U="^",OPT=$G(OPT)
 I '$D(^XUSEC) D  S OPT="" Q
 . W $C(7),!?2,"Kernel not available in this UCI.",!
 I $G(DUZ)'>0 D  I $G(DUZ)="" S OPT="" Q
 . S ^TMP("XVV",$J)=OPT D ID^XVEMKU
 . S OPT=^TMP("XVV",$J) KILL ^($J)
 S:$E(OPT)="""" OPT=$E(OPT,2,99) S:$E($L(OPT))="""" OPT=$E(OPT,1,$L(OPT)-1)
 I OPT="" D GETOPT Q:OPT=""  ;No parameter passed
 I +OPT'=OPT D GETNUM I OPT="" D  Q  ;OPT equals Option name.
 . W !?2,"No such option."
 I '$D(^DIC(19,OPT,0)) D  S OPT="" Q
 . W $C(7),!?2,"No such Option."
 I $P(^(0),U,4)']"" D  S OPT="" Q
 . W !?1,"Option TYPE field is blank."
 Q
GETOPT ;Select a menu option to run
 W !!,"Get Kernel Option.."
 S DIC="^DIC(19,",DIC(0)="QEAM" D ^DIC Q:Y<0  S OPT=+Y
 Q
GETNUM ;Get Option's internal entry number
 S X=OPT,DIC="^DIC(19,",DIC(0)="QEM" D ^DIC I Y<0 S OPT="" Q
 S OPT=+Y
 Q
CHECK ;Don't allow Menu type option
 Q:"A,E,I,P,R"[$P(^DIC(19,OPT,0),U,4)  S OPT=""
 W $C(7),!!?1,"You may only run the following KERNEL option types:"
 W !!?10,"ACTION",!?10,"EDIT",!?10,"INQUIRE"
 W !?10,"PRINT",!?10,"ROUTINE"
 Q
