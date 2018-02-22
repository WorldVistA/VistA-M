XVEMSP ;DJB/VSHL**System Parameters [11/17/96 12:49pm];2017-08-16  10:32 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
TOP ;Edit System Parameters
 NEW DOT,FLAGQ,I,LINE,NUM
 D INIT
 S FLAGQ=0
 F  D DISPLAY,GETPARAM Q:FLAGQ
EX ;
 Q
GETPARAM ;Edit a Parameter
 R !?1,"Select NUMBER: ",NUM:300 S:'$T NUM="^" I "^"[NUM S FLAGQ=1 Q
 I NUM'?1.N!(NUM<1)!(NUM>7) W "  To edit a parameter, enter number of your choice." G GETPARAM
 I NUM=1 D WARN
 I NUM=2 D PROMPT
 I NUM=3 D TIMEOUT
 I NUM=4 D SAVE
 I NUM=5 D BS
 I NUM=6 D WIDTH
 I NUM=7 D LENGTH
 Q
DISPLAY ;Display Parameters
 NEW HD
 S HD="V P E   S Y S T E M   P A R A M E T E R S"
 W @XVV("IOF"),!?(XVV("IOM")-$L(HD)\2),HD
 W !,$E(LINE,1,XVV("IOM")-1)
 NEW BS,KL,PR,TO,WIDTH,LENGTH
 S KL=$G(^XVEMS("PARAM",XVV("ID"),"WARN")) S:KL']"" KL="NO"
 W !!?1,"1. Global Kill......... ",KL,?40,"Default answer to global kill warning"
 S PR=$G(^XVEMS("PARAM",XVV("ID"),"PROMPT")) S:PR']"" PR="INACTIVE"
 W !!?1,"2. Prompt.............. ",PR,?40,"ACTIVE Prompt includes UCI,VOL>>"
 S TO=$G(^XVEMS("PARAM",XVV("ID"),"TO")) S:TO'>0 TO=600
 W !!?1,"3. Time-out............ ",TO,?40,"Shell Time-out length in seconds"
 W !!?1,"4. SAVE Routine........ ",$G(^XVEMS("PARAM",XVV("ID"),"SAVE")),?40,"Routine that holds your saved QWIKs"
 S BS=$G(^XVEMS("PARAM",XVV("ID"),"BS")) S:BS']"" BS="SAME"
 W !!?1,"5. <DEL> & <BS> Keys... ",BS,?40,"<DELETE> different from <BACKSPACE>"
 S WIDTH=$G(^XVEMS("PARAM",XVV("ID"),"WIDTH")) S:'WIDTH WIDTH=80
 W !!?1,"6. Screen Width........ ",WIDTH,?40,"Set screen width"
 S LENGTH=$G(^XVEMS("PARAM",XVV("ID"),"LENGTH")) S:'LENGTH LENGTH=24
 W !!?1,"7. Screen Length....... ",LENGTH,?40,"Set screen length"
 W !!,$E(LINE,1,XVV("IOM")-1),!
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
 S:'DEF DEF=80
 D MSG
WIDTH1 W !?1,"Enter SCREEN WIDTH: "_DEF_"// "
 R WIDTH:300 S:'$T WIDTH="^" S:WIDTH="" WIDTH=DEF Q:"^"[WIDTH
 I WIDTH'?1.N!(WIDTH'>0) D  G WIDTH1
 . W !?1,"Enter your screen width."
 S ^XVEMS("PARAM",XVV("ID"),"WIDTH")=WIDTH
 Q
 ;====================================================================
LENGTH ;Set screen length.
 NEW DEF,LEN
 S DEF=$G(^XVEMS("PARAM",XVV("ID"),"LENGTH"))
 S:'DEF DEF=24
 D MSG
LENGTH1 W !?1,"Enter SCREEN LENGTH: "_DEF_"// "
 R LEN:300 S:'$T LEN="^" S:LEN="" LEN=DEF Q:"^"[LEN
 I LEN'?1.N!(LEN'>0) D  G LENGTH1
 . W !?1,"Enter your screen length."
 S ^XVEMS("PARAM",XVV("ID"),"LENGTH")=LEN
 Q
 ;====================================================================
MSG ;
 W !," You must exit and reenter the Shell for change to take effect."
 Q
INIT ;
 S DOT="...............",$P(LINE,"=",220)=""
 Q
