XVEMRID ;DJB/VRR**INSERT - Programmer Call ;2017-08-15  1:56 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in EN (c) 2016 Sam Habiel
 ;
EN ;Insert programmer call into current program
 S ^TMP("VPE",$J)=$P(FLAGMENU,"^",1) ;...YND
 D SYMTAB^XVEMKST("C","VRR",VRRS) ;...Save/Clear symbol table
 D ENDSCR^XVEMKT2
 I '$D(^XVV(19200.113)) D  G EX ;...Quit if FM isn't in this UCI
 . W !,"I can't find the VPE files that support CALL..."
 . D PAUSE^XVEMKU(2,"P")
 I $G(^TMP("XVV","IR"_VRRS,$J,^TMP("VPE",$J)))=" <> <> <>" D  G EX
 . W !,"You may not insert a CALL while you are on the ' <> <> <>' line."
 . W !,"Move up one line."
 . D PAUSE^XVEMKU(2,"P")
 ;
 NEW %,CALL,CD
 N $ESTACK,$ETRAP S $ETRAP="D ERROR,UNWIND^XVEMSY"
 W !,"***INSERT PROGRAMMER CALL***"
 S FLAGQ=0
 D GETCALL G:FLAGQ EX
 D DELETE^XVEMRIE G:FLAGQ EX
 D DDS G:FLAGQ EX
 D CODE^XVEMRIE G:FLAGQ EX
 W @XVV("IOF")
 G:$$ASK^XVEMKU(" Insert this Call into your routine",1)'="Y" EX
 D INSERT
EX ;
 KILL ^TMP("VPE",$J)
 D SYMTAB^XVEMKST("R","VRR",VRRS) ;Restore symbol table
 X XVVS("RM0")
 Q
 ;====================================================================
GETCALL ;Get programmer call
 ; S $EC=",U-SIM-ERROR," ; only for testing
 NEW DA,DIC,X,Y
 S DIC="^XVV(19200.113,",DIC(0)="QEAM",DIC("A")="Select CALL: "
 S DIC("S")="I $P($G(^(0)),U,2)'=""n"""
 W ! D ^DIC I Y<0 S FLAGQ=1 Q
 S CALL=+Y
 Q
DDS ;Call ScreenMan
 NEW DA,DDSFILE,DDSPARM,DR,I
 S DDSFILE=19200.113,DR="[XVVM PGM CALL]",DA=CALL
 S DDSPARM="E" D ^DDS Q:'$G(DIERR)  S FLAGQ=1
 W !!,"Screenman couldn't load this form."
 S I=0
 F  S I=$O(^TMP("DIERR",$J,1,"TEXT",I)) Q:I'>0  W !,^(I)
 KILL ^TMP("DIERR",$J) D PAUSE^XVEMKU(2,"P")
 Q
INSERT ;Insert Call code into rtn
 NEW CNT,I,NUM,SUB,YND
 S YND=$G(^TMP("VPE",$J)) Q:YND'>0
 ;--> Get line number
 S NUM=$$LINENUM^XVEMRU(YND)+1
 ;--> Set YND to line number after wrapped lines
 F I=YND+1:1 Q:^TMP("XVV","IR"_VRRS,$J,I)[$C(30)  Q:^(I)=" <> <> <>"  S YND=YND+1
 S SUB=1 F CNT=1:1 Q:'$D(CD(CNT))  S CD=CD(CNT) D INSERT1 S NUM=NUM+1
 S ^XVEMS("E","SAVEVRR",$J,SUB)="" ;Mark clipboard ending point
 D PASTE^XVEMRP1
 Q
INSERT1 ;Build array of code to be inserted
 S ^XVEMS("E","SAVEVRR",$J,SUB)=NUM_$J("",9-$L(NUM))_$C(30)_$E(CD,1,XVV("IOM")-11)
 S SUB=SUB+1
 S CD=$E(CD,XVV("IOM")-10,9999)
 F  Q:CD']""  D  ;
 . S ^XVEMS("E","SAVEVRR",$J,SUB)=$J("",9)_$E(CD,1,XVV("IOM")-11)
 . S SUB=SUB+1
 . S CD=$E(CD,XVV("IOM")-10,9999)
 Q
 ;====================================================================
ERROR ;Error trap
 NEW ZE
 S @("ZE="_XVV("$ZE"))
 I ZE["<INRPT>" W !!?1,"....Interrupted.",!!
 E  D ERRMSG^XVEMKU1("VRR")
 D PAUSE^XVEMKU(2)
 G EX
 ;====================================================================
HELP(PC) ;Print param/variable help text in ScreenMan.
 ;PC=Global "Piece" where Parameter is located
 NEW I,PARAM,STRING
 Q:'$G(DDS)  Q:'$G(DA)  Q:'$G(PC)
 S PARAM=$P($G(^XVV(19200.113,DA,"P")),U,PC) Q:'PARAM
 F I=1:1 Q:'$D(^XVV(19200.114,PARAM,"WP",I,0))  S STRING(I)=^(0)
 Q:($D(STRING)<10)  D HLP^DDSUTL(.STRING)
 Q
DEFAULT(PC) ;Default value in ScreenMan. Set variable Y.
 ;PC=Global "Piece" where Parameter is located
 NEW DEFAULT,PARAM
 S Y=""
 Q:'$G(DDS)  Q:'$G(DA)  Q:'$G(PC)
 S PARAM=$P($G(^XVV(19200.113,DA,"P")),U,PC) Q:'PARAM
 S DEFAULT=$G(^XVV(19200.114,PARAM,"D")) Q:DEFAULT']""
 S Y=DEFAULT
 Q
 ;====================================================================
EDIT ;Add/Edit a Call. External calling point to build database.
 Q:'$D(^DD)!('$D(^DIC))  Q:'$D(^XVV(19200.113))
 NEW DA,DDSFILE,DDSPARM,DIC,DR,FLAGQ,I,X,Y
EDIT1 S FLAGQ=0 F  D  Q:FLAGQ
 . W @XVV("IOF"),!,"***ADD/EDIT A VPE PROGRAMMER CALL***"
 . S DIC="^XVV(19200.113,",DIC(0)="QEAML",DIC("A")="Select CALL: "
 . W ! D ^DIC I Y<0 S FLAGQ=1 Q
 . S DDSFILE=19200.113,DR="[XVVM PGM EDIT]",DA=+Y
 . S DDSPARM="E" D ^DDS Q:'$G(DIERR)
 . S FLAGQ=1
 . W !!?1,"Screenman couldn't load this form."
 . S I=0 F  S I=$O(^TMP("DIERR",$J,1,"TEXT",I)) Q:I'>0  W !?1,^(I)
 . KILL ^TMP("DIERR",$J)
 . D PAUSE^XVEMKU(2,"P")
 Q
