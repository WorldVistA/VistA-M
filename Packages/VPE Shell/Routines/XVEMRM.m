XVEMRM ;DJB/VRR**Menu Bar ;2017-08-15  4:23 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EN ;Because of FndTag/LctStrng, I need to be able to change the lines
 ;displayed when exiting back to edit mode. FLAGMENU allows this.
 NEW FLAGMENU
 S FLAGMENU=YND_"^"_XVVT("TOP")_"^"_YCUR_"^"_XCUR
 ;-> Do PAGE and then set scroll variables to new values.
 D PAGE
 S YND=$P(FLAGMENU,"^",1)
 S XVVT("TOP")=$P(FLAGMENU,"^",2)
 S YCUR=$P(FLAGMENU,"^",3)
 Q
 ;
PAGE ;Get users response
 NEW KEY,XCHAR,XCUR,YCUR,YND,CD,CDHLD
PAGE1 S DX=0,DY=XVVT("S2")+1 X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL")
 S DX=8 X XVVS("CRSR")
 W "[  ]  <RET>=Quit  R=Rtn  F=FndTg  L=LctStrg  G=Goto  ?=Help  M=More..."
 S DX=0 X XVVS("CRSR")
 W @XVV("RON"),"Select:",@XVV("ROFF")
 S DX=9 X XVVS("CRSR")
PAGE2 S KEY=$$READ^XVEMKRN(),KEY=$$ALLCAPS^XVEMKU(KEY)
 Q:KEY="^"
 Q:",<ESC>,<F1E>,<F1Q>,<RET>,<TO>,"[(","_XVV("K")_",")
 ;-> No editing if using the Rtn Reader
 I ",J,LC,SV,"[(","_KEY_","),$G(FLAGVPE)'["EDIT" D  Q
 . S (XCUR,YCUR)=0 D MSG^XVEMRUM(5)
 I ",?,ASC,FMC,I,RS,SV,VEDD,VGL,"[(","_KEY_",") D MODULES Q
 I XVV("K")="<ESCH>" D MODULES Q
 I KEY="CALL" D ^XVEMRID Q  ;.............Insert programmer call
 I KEY="F" D TAG^XVEMRMS Q
 I KEY="L" D LOCATE Q
 I KEY="G" D GOTO^XVEMRM1 Q
 I KEY="J" D JOIN^XVEMREJ Q
 I KEY="JC" D JOINA^XVEMREJ Q
 I KEY="LC" D ^XVEMRM2 Q
 I KEY="M" D MORE^XVEMRM1 G PAGE1
 I KEY="P" D PARAM^XVEMRM1 Q
 I KEY="PUR" D PUR Q
 I KEY="R" D ROUTINE Q
 I KEY="S" D SIZE Q
 W $C(7)
 G PAGE1
 ;
ROUTINE ;Branch to a routine
 D SYMTAB^XVEMKST("C","VRR",VRRS) ;.......Save/Clear symbol table
 D ENDSCR^XVEMKT2
 ;-> MSM NT needs this or no form feed occurs
 I $G(^%ZOSF("OS"))["MSM for Windows NT" H 1
 W !?1,"***BRANCH TO A ROUTINE***",!
 D START^XVEMR
 D SYMTAB^XVEMKST("R","VRR",VRRS) ;.......Restore symbol table
 Q
 ;
LOCATE ;Locate String
 NEW HELP,PROMPT,TXT
 S PROMPT=" STRING"
 S HELP="   Enter text & I'll search for matching string."
 S TXT=$$GETTEXT^XVEMRM2(PROMPT,HELP) Q:TXT']""
 ;S VRRFIND=TXT_$C(127)_KEY,YND=$P(FLAGMENU,"^",1)
 S VRRFIND=TXT
 S YND=$P(FLAGMENU,"^",1)
 D LCTSTRG^XVEMRM1(TXT)
 Q
 ;
LOCATE1 ;Called by <ESC>N (Find Next) in EDIT mode
 NEW FLAGMENU,TXT
 S VRRFIND=$G(VRRFIND)
 S TXT=$P(VRRFIND,$C(127),1)
 Q:TXT']""
 S FLAGMENU=YND_"^"_XVVT("TOP")_"^"_YCUR_"^"_XCUR
 D LCTSTRG^XVEMRM1(TXT)
 S YND=$P(FLAGMENU,"^",1)
 S XVVT("TOP")=$P(FLAGMENU,"^",2)
 S YCUR=$P(FLAGMENU,"^",3)
 Q
 ;
MODULES ;VGL,VEDD
 D ENDSCR^XVEMKT2
 I KEY="?"!(XVV("K")="<ESCH>") D HELP^XVEMKT("VRR1") Q
 I KEY="ASC",$G(XVVSHL)="RUN" D ASCII^XVEMST,PAUSE^XVEMKC(1) Q
 I KEY="FMC",$G(XVVSHL)="RUN" D ^XVEMSF Q
 I KEY="I" D INDEX^XVEMRMG Q  ;....................Run %INDEX
 I KEY="RS" D  D RSE^XVEMRY Q
 . W !?1,"***SEARCH ROUTINE(S)***"
 I KEY="SV" S FLAGQ=1 D SAVE^XVEMRMS S FLAGQ=0 Q  ;Save on the fly
 I KEY="VEDD" D  D VEDD^XVEMRY Q
 . W !?1,"***ELECTRONIC DATA DICTIONARY***",!
 I KEY="VGL" D  D VGL^XVEMRY Q
 . W !?1,"***GLOBAL LISTER***"
 Q
 ;
SIZE ;Display size of routine
 NEW NAM,XX,Y
 S DX=0,DY=XVVT("S2")+1 X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL")
 I '$D(^%ZOSF("SIZE")) D  R XX:50 Q
 . W "  Global node ^%ZOSF(""SIZE"") must be available.."
 I '$D(^TMP("XVV","VRR",$J,VRRS,"NAME")) D  R XX:50 Q
 . W "  Routine name unknown.."
 S (NAM,Y)=^("NAME") X "ZL @Y X ^%ZOSF(""SIZE"")"
 W "  ^",NAM,".....Routine size = ",Y R XX:50
 Q
 ;
PUR ;Purge clipboard
 NEW TMP
 D ENDSCR^XVEMKT2
 W !?1,"*** WARNING ***"
 W !!?1,"This option will purge the clipboard. If anyone is currently using the"
 W !?1,"editor and has saved lines to the clipboard, these lines will be lost."
 W ! S TMP=$$YN^XVEMKU1(" Shall I continue? ",1)
 I TMP=1 KILL ^XVEMS("E","SAVEVRR")
 W !!?1,"Clipboard",$S(TMP'=1:" not",1:"")," purged.."
 D PAUSE^XVEMKC(2)
 Q
 ;
REDRAW ;Redraw screen
 NEW DX,DY,I,TMP
 D SCROLL^XVEMKT2(1)
 S DY=XVVT("S1")-2
 F I=XVVT("TOP"):1:(XVVT("BOT")-1) D  ;
 . S DX=0,DY=DY+1 X XVVS("CRSR")
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I))
 . W $P(TMP,$C(30),1)
 . W $P(TMP,$C(30),2,99)
 Q
