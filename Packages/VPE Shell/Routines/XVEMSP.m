XVEMSP ;DJB/VSHL**System Parameters ;2019-05-29  1:42 PM
 ;;15.1;VICTORY PROG ENVIRONMENT;;Jun 19, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Enhancements to auto margin screen handling by David Wicksell (c) 2019
 ; Syntax highlighting support by David Wicksell (c) 2019
 ;
TOP ;Edit System Parameters
 NEW DOT,FLAGQ,I,LINE,OPT1,SYN,LIMIT
 D INIT
 S FLAGQ=0
 F  D DISPLAY,GETPARAM Q:FLAGQ
EX ;
 Q
GETPARAM ;Edit a Parameter
 R !?1,"Select NUMBER: ",OPT1:300 S:'$T OPT1="^" I "^"[OPT1 S FLAGQ=1 Q
 S SYN=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX"),"OFF")
 S LIMIT=$S(SYN="ON":9,1:8)
 I OPT1'?1.N!(OPT1<1)!(OPT1>LIMIT) W "  To edit a parameter, enter number of your choice." G GETPARAM
 I OPT1=1 D WARN
 I OPT1=2 D PROMPT
 I OPT1=3 D TIMEOUT
 I OPT1=4 D SAVE
 I OPT1=5 D BS
 I OPT1=6 D WIDTH
 I OPT1=7 D LENGTH
 I OPT1=8 D SYNTAX
 I OPT1=9,SYN="ON" D
 . NEW CONFQ,OPT2,CMD,ARG,TAG,FUNC,COM,PUNC,NUM,STR,ERR
 . S CONFQ=0
 . F  D SYNCONF,GETCONF Q:CONFQ
 Q
DISPLAY ;Display Parameters
 NEW HD
 S HD="V P E   S Y S T E M   P A R A M E T E R S"
 W @XVV("IOF"),!?(XVV("IOM")-$L(HD)\2),HD
 W !,$E(LINE,1,XVV("IOM")-1)
 NEW BS,KL,PR,TO,WIDTH,LENGTH,SYNTAX
 S KL=$G(^XVEMS("PARAM",XVV("ID"),"WARN")) S:KL']"" KL="NO"
 W !!?1,"1. Global Kill......... ",KL,?40,"Default answer to global kill warning"
 S PR=$G(^XVEMS("PARAM",XVV("ID"),"PROMPT")) S:PR']"" PR="INACTIVE"
 W !!?1,"2. Prompt.............. ",PR,?40,"ACTIVE Prompt includes UCI,VOL>>"
 S TO=$G(^XVEMS("PARAM",XVV("ID"),"TO")) S:TO'>0 TO=600
 W !!?1,"3. Time-out............ ",TO,?40,"Shell Time-out length in seconds"
 W !!?1,"4. SAVE Routine........ ",$G(^XVEMS("PARAM",XVV("ID"),"SAVE")),?40,"Routine that holds your saved QWIKs"
 S BS=$G(^XVEMS("PARAM",XVV("ID"),"BS")) S:BS']"" BS="SAME"
 W !!?1,"5. <DEL> & <BS> Keys... ",BS,?40,"<DELETE> different from <BACKSPACE>"
 S WIDTH=$G(^XVEMS("PARAM",XVV("ID"),"WIDTH")) S:'WIDTH WIDTH=$G(XVV("IOM"),80)
 W !!?1,"6. Screen Width........ ",WIDTH,?40,"Set screen width [0 for auto width]"
 S LENGTH=$G(^XVEMS("PARAM",XVV("ID"),"LENGTH")) S:'LENGTH LENGTH=$G(XVV("IOSL"),24)
 W !!?1,"7. Screen Length....... ",LENGTH,?40,"Set screen length [0 for auto length]"
 S SYNTAX=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX")) S:SYNTAX']"" SYNTAX="OFF"
 W !!?1,"8. Highlight Syntax.... ",SYNTAX,?40,"Set syntax highlighting mode"
 I SYNTAX="ON" W !!?1,"9. Configure Syntax.... >>>>>",?40,"Configure syntax region colors"
 W !!,$E(LINE,1,XVV("IOM")-1),!
 Q
 ;====================================================================
GETCONF ;Edit a Syntax Parameter
 R !?1,"Select NUMBER: ",OPT2:300 S:'$T OPT2="^" I "^"[OPT2 S CONFQ=1 Q
 I OPT2'?1.N!(OPT2<0)!(OPT2>9) W "  To edit a parameter, enter number of your choice." G GETCONF
 I OPT2=0 NEW SYN S SYN=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX"),"OFF") K ^("SYNTAX") S ^("SYNTAX")=SYN
 I OPT2=1 D CHGCOLOR("Command")
 I OPT2=2 D CHGCOLOR("Argument")
 I OPT2=3 D CHGCOLOR("Tag")
 I OPT2=4 D CHGCOLOR("Function")
 I OPT2=5 D CHGCOLOR("Comment")
 I OPT2=6 D CHGCOLOR("Punctuation")
 I OPT2=7 D CHGCOLOR("Number")
 I OPT2=8 D CHGCOLOR("String")
 I OPT2=9 D CHGCOLOR("Error")
 Q
SYNCONF ;Configure Syntax mappings
 NEW HD,XPOS
 S HD="V P E   S Y N T A X   C O N F I G U R A T I O N   [0 Resets All Regions]"
 W @XVV("IOF"),!?(XVV("IOM")-$L(HD)\2),HD
 W !,$E(LINE,1,XVV("IOM")-1)
 S CMD=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","COMMAND","FG"),"Yellow")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"1. Command Region..... " S XPOS=$X W $$CONTROL^XVEMSYN($S(CMD["/":CMD,1:CMD_"/")) S $X=XPOS W CMD S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for command regions"
 S ARG=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","ARGUMENT","FG"),"Magenta")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"2. Argument Region.... " S XPOS=$X W $$CONTROL^XVEMSYN($S(ARG["/":ARG,1:ARG_"/")) S $X=XPOS W ARG S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for argument regions"
 S TAG=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","TAG","FG"),"Magenta")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"3. Tag Region......... " S XPOS=$X W $$CONTROL^XVEMSYN($S(TAG["/":TAG,1:TAG_"/")) S $X=XPOS W TAG S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for tag regions"
 S FUNC=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","FUNCTION","FG"),"Cyan")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"4. Function Region.... " S XPOS=$X W $$CONTROL^XVEMSYN($S(FUNC["/":FUNC,1:FUNC_"/")) S $X=XPOS W FUNC S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for function regions"
 S COM=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","COMMENT","FG"),"Blue")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"5. Comment Region..... " S XPOS=$X W $$CONTROL^XVEMSYN($S(COM["/":COM,1:COM_"/")) S $X=XPOS W COM S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for comment regions"
 S PUNC=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","PUNCTUATION","FG"),"Green")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"6. Punctuation Region. " S XPOS=$X W $$CONTROL^XVEMSYN($S(PUNC["/":PUNC,1:PUNC_"/")) S $X=XPOS W PUNC S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for punctuation regions"
 S NUM=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","NUMBER","FG"),"Red")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"7. Number Region...... " S XPOS=$X W $$CONTROL^XVEMSYN($S(NUM["/":NUM,1:NUM_"/")) S $X=XPOS W NUM S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for number regions"
 S STR=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","STRING","FG"),"Red")_$S("Off"[$G(^("BG")):"",1:"/"_^("BG"))
 W !!?1,"8. String Region...... " S XPOS=$X W $$CONTROL^XVEMSYN($S(STR["/":STR,1:STR_"/")) S $X=XPOS W STR S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for string regions"
 S ERR=$G(^XVEMS("PARAM",XVV("ID"),"SYNTAX","ERROR","FG"),"White")_$S($G(^("BG"))="Off":"",$G(^("BG"))="":"/Red",1:"/"_^("BG"))
 W !!?1,"9. Error Region....... " S XPOS=$X W $$CONTROL^XVEMSYN($S(ERR["/":ERR,1:ERR_"/")) S $X=XPOS W ERR S XPOS=$X
 W $$CONTROL^XVEMSYN("DEF") S $X=XPOS W ?40,"Set colors for error regions"
 W !!,$E(LINE,1,XVV("IOM")-1),!
 Q
CHGCOLOR(REG) ;Change Syntax Colors for a Syntax Region
 NEW KEY,VK,COLOR,CHOICE,CHGQ,REGION,SYNFG,SYNBG,UCREG,YLINE
 S REGION("Command")="CMD",REGION("Argument")="ARG",REGION("Tag")="TAG"
 S REGION("Function")="FUNC",REGION("Comment")="COM",REGION("Punctuation")="PUNC"
 S REGION("Number")="NUM",REGION("String")="STR",REGION("Error")="ERR"
 S COLOR(1)="Black",COLOR(2)="Red",COLOR(3)="Green",COLOR(4)="Yellow",COLOR(5)="Blue"
 S COLOR(6)="Magenta",COLOR(7)="Cyan",COLOR(8)="White",COLOR(9)="Off",COLOR(10)="Default"
 S COLOR("Black")=1,COLOR("Red")=2,COLOR("Green")=3,COLOR("Yellow")=4,COLOR("Blue")=5
 S COLOR("Magenta")=6,COLOR("Cyan")=7,COLOR("White")=8,COLOR("Off")=9,COLOR("Default")=10
 S SYNFG=$P(@REGION(REG),"/",1),SYNBG=$P(@REGION(REG),"/",2) I SYNBG="" S SYNBG="Off"
 S UCREG=$$ALLCAPS^XVEMKU(REG)
 S CHGQ=0,YLINE=$Y+1
 I XVV("OS")=19!(XVV("OS")=17) U $I:NOWRAP
 E  I XVV("OS")=18 U $I:/NOXY=1
 F  D  Q:CHGQ
 . W $$CONTROL^XVEMSYN("MOV",YLINE) W @XVVS("BLANK_C_EOL")
 . S KEY=$$READ^XVEMKRN(" Use <TAB> or the arrow keys to change "_REG_" FOREGROUND color ["_SYNFG_"] ",1,0)
 . S VK=$G(XVV("K"))
 . I ",<AL>,<AU>,"[(","_VK_",") S CHOICE=COLOR(SYNFG) S:CHOICE=1 CHOICE=11 S CHOICE=CHOICE-1,SYNFG=COLOR(CHOICE) Q
 . I ",<AR>,<AD>,<TAB>,"[(","_VK_",") S CHOICE=COLOR(SYNFG) S:CHOICE=10 CHOICE=0 S CHOICE=CHOICE+1,SYNFG=COLOR(CHOICE) Q
 . I VK="<ESC>" S CHGQ=1 Q
 . I VK="<RET>" D  S CHGQ=1
 . . I $G(CHOICE)=10 K ^XVEMS("PARAM",XVV("ID"),"SYNTAX",UCREG,"FG")
 . . E  S ^XVEMS("PARAM",XVV("ID"),"SYNTAX",UCREG,"FG")=SYNFG
 S CHGQ=0
 F  D  Q:CHGQ
 . W $$CONTROL^XVEMSYN("MOV",YLINE) W @XVVS("BLANK_C_EOL")
 . S KEY=$$READ^XVEMKRN(" Use <TAB> or the arrow keys to change "_REG_" BACKGROUND color ["_SYNBG_"] ",1,0)
 . S VK=$G(XVV("K"))
 . I ",<AL>,<AU>,"[(","_VK_",") S CHOICE=COLOR(SYNBG) S:CHOICE=1 CHOICE=11 S CHOICE=CHOICE-1,SYNBG=COLOR(CHOICE) Q
 . I ",<AR>,<AD>,<TAB>,"[(","_VK_",") S CHOICE=COLOR(SYNBG) S:CHOICE=10 CHOICE=0 S CHOICE=CHOICE+1,SYNBG=COLOR(CHOICE) Q
 . I VK="<ESC>" S CHGQ=1 Q
 . I VK="<RET>" D  S CHGQ=1
 . . I $G(CHOICE)=10 K ^XVEMS("PARAM",XVV("ID"),"SYNTAX",UCREG,"BG")
 . . E  S ^XVEMS("PARAM",XVV("ID"),"SYNTAX",UCREG,"BG")=SYNBG
 I XVV("OS")=19!(XVV("OS")=17) U $I:WRAP
 E  I XVV("OS")=18 U $I:/NOXY=0
 Q
 ;====================================================================
WARN ;Default answer to "Global Kill" warning.
 S ^XVEMS("PARAM",XVV("ID"),"WARN")=$S($G(^XVEMS("PARAM",XVV("ID"),"WARN"))="YES":"NO",1:"YES")
 Q
 ;====================================================================
PROMPT ;Toggle on/off displaying UCI and Volume Set with ">>" prompt.
 I $D(^XVEMS("PARAM",XVV("ID"),"PROMPT")) KILL ^("PROMPT") Q
 S ^XVEMS("PARAM",XVV("ID"),"PROMPT")="UCI,VOL"
 Q
 ;====================================================================
TIMEOUT ;Number of seconds of inactivity when VShell will time-out.
 NEW TO,TODEF
 S TODEF=$G(^XVEMS("PARAM",XVV("ID"),"TO")) S:TODEF'>0 TODEF=600
TIMEOUT1 W !?1,"Enter TIME-OUT: ",TODEF,"// "
 R TO:300 S:'$T TO="^" S:TO="" TO=TODEF Q:TO["^"
 I TO'?1.N!(TO'>0) D  G TIMEOUT1
 . W !?1,"Enter number of seconds for VShell to time-out from inactivity. This time-out"
 . W !?1,"applies only to you. Other users will have there own time-out value. Enter"
 . W !?1,"'^' to quit."
 S ^XVEMS("PARAM",XVV("ID"),"TO")=TO,XVV("TIME")=TO
 Q
 ;====================================================================
SAVE ;Edit Save Routine
 NEW FLAGQ,RTN,TEMP S FLAGQ=0 D GETRTNS^XVEMSS
 Q
 ;====================================================================
BS ;Delete different from Backspace
 I $G(^XVEMS("PARAM",XVV("ID"),"BS"))'="DIFF" S ^("BS")="DIFF" Q
 S ^XVEMS("PARAM",XVV("ID"),"BS")="SAME"
 Q
 ;====================================================================
WIDTH ;Set screen width.
 NEW DEF,WIDTH
 S DEF=$G(^XVEMS("PARAM",XVV("ID"),"WIDTH"))
 S:'DEF DEF=$G(XVV("IOM"),80)
WIDTH1 W !?1,"Enter SCREEN WIDTH: "_DEF_"// "
 R WIDTH:300 S:'$T WIDTH="^" S:WIDTH="" WIDTH=DEF Q:"^"[WIDTH
 I WIDTH'?1.N!(WIDTH<0)!(WIDTH<80&(WIDTH>0)) D  G WIDTH1
 . W !?1,"Enter your screen width. (>=80 or 0)"
 I WIDTH=0 K ^XVEMS("PARAM",XVV("ID"),"WIDTH")
 E  S ^XVEMS("PARAM",XVV("ID"),"WIDTH")=WIDTH
 D IO^XVEMKY
 Q
 ;====================================================================
LENGTH ;Set screen length.
 NEW DEF,LEN
 S DEF=$G(^XVEMS("PARAM",XVV("ID"),"LENGTH"))
 S:'DEF DEF=$G(XVV("IOSL"),24)
LENGTH1 W !?1,"Enter SCREEN LENGTH: "_DEF_"// "
 R LEN:300 S:'$T LEN="^" S:LEN="" LEN=DEF Q:"^"[LEN
 I LEN'?1.N!(LEN<0)!(LEN<24&(LEN>0)) D  G LENGTH1
 . W !?1,"Enter your screen length. (>=24 or 0)"
 I LEN=0 K ^XVEMS("PARAM",XVV("ID"),"LENGTH")
 E  S ^XVEMS("PARAM",XVV("ID"),"LENGTH")=LEN
 D IO^XVEMKY
 Q
 ;====================================================================
SYNTAX ;Syntax Highlighting
 I $G(^XVEMS("PARAM",XVV("ID"),"SYNTAX"))'="ON" S ^("SYNTAX")="ON" Q
 S ^XVEMS("PARAM",XVV("ID"),"SYNTAX")="OFF"
 Q
 ;====================================================================
INIT ;
 S DOT="...............",$P(LINE,"=",220)=""
 D BLANK^XVEMKY3
 Q
