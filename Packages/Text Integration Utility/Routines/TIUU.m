TIUU ; SLC/JER - Utility subroutines for Discharge Summary ;9/7/94  16:37
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997;
TITLE(X) ; Pads titles
 ; Recieves:    X=title to be padded
 N I,TITLE
 S TITLE="" F I=1:1:$L(X) S TITLE=TITLE_" "_$E(X,I)
 Q TITLE
JUSTIFY(X,JUST) ; Justifies Text
 ; Receives:    X=text to be justified
 ;           JUST="L" --> left, "C" --> center, "R" --> right,
 ;                "J" --> justified to WIDTH
 ;           WIDTH=justification width (when JUST="j"
 I "Cc"[JUST W ?((80-$L(X))/2),X
 I "Ll"[JUST W X,!!
 I "Rr"[JUST W ?(80-$L(X)),X
 Q
STOP(PROMPT,SCROLL) ; Call DIR at bottom of screen
 N DIR,X,Y
 I $E(IOST)'="C" S Y="" G STOPX
 I +$G(SCROLL),(IOSL>($Y+5)) F  W ! Q:IOSL<($Y+6)
 S DIR(0)="FO^1:1",DIR("A")=$S($G(PROMPT)]"":PROMPT,1:"Press RETURN to continue or '^' to exit")
 S DIR("?")="Enter '^' to quit present action or '^^' to quit to menu"
 D ^DIR I $D(DIRUT),(Y="") K DIRUT
 S Y=$S(Y="^":0,Y="^^":0,$D(DTOUT):"",Y="":1,1:1_U_Y)
STOPX Q Y
READ(TYPE,PROMPT,DEFAULT,HELP,SCREEN) ; Calls reader, returns response
 N DIR,X,Y
 S DIR(0)=TYPE
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 I $G(X)="@" S Y="@" G READX
 I Y]"",($L($G(Y),U)'=2) S Y=Y_U_$G(Y(0),Y)
READX Q Y
UPDATE ; Updates fields in review screen
 ; Receives: X=new value of field
 ;           FLD=name of field to be modified
 I $D(^TMP("TIUVIEW",$J,3,0)),+$G(TIUDA) D
 . S ^TMP("TIUVIEW",$J,3,0)=$$SETSTR^VALM1("SIG STATUS: "_$P($$STATUS^TIULC(TIUDA),U,2),$G(^TMP("TIUVIEW",$J,3,0)),38,41)
 Q
LISTREAD(TIULIST,ANSTYPE) ; Present list to user for selection of item(s)
 N TIUI,TIUL,TIUY S (TIUI,TIUY)=0
 S ANSTYPE=$S($G(ANSTYPE)]"":$G(ANSTYPE),1:"N")
 F  S TIUI=$O(TIULIST(TIUI)) Q:+TIUI'>0  D
 . W !,TIUI,?5,$P(TIULIST(TIUI),U,2) S TIUL=TIUI
 I +$G(TIUL) D
 . W !
 . S TIUY=$$READ(ANSTYPE_"A^1:"_TIUL,"Select "_$P(TIULIST,U)_": ")
 . I +TIUY S TIUY=$G(TIULIST(+TIUY))
 Q TIUY
