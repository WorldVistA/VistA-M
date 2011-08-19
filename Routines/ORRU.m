ORRU ; SLC/JER - Scroll-mode Utility Subroutines ; 5-APR-2002 12:39:51
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**174**;Dec 17, 1997
STOP(PROMPT,SCROLL) ; Call DIR at bottom of screen
 N DIR,X,Y
 I $E(IOST)'="C" S Y="" G STOPX
 I +$G(SCROLL),(IOSL>($Y+5)) F  W ! Q:IOSL<($Y+6)
 S DIR(0)="FO^1:1"
 S DIR("A")=$S($G(PROMPT)]"":PROMPT,1:"Press RETURN to continue or '^' to exit")
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
LISTREAD(ORLIST,ANSTYPE) ; Present list to user for selection of item(s)
 N ORI,ORL,ORY S (ORI,ORY)=0
 S ANSTYPE=$S($G(ANSTYPE)]"":$G(ANSTYPE),1:"N")
 F  S ORI=$O(ORLIST(ORI)) Q:+ORI'>0  D
 . W !,ORI,?5,$P(ORLIST(ORI),U,2) S ORL=ORI
 I +$G(ORL) D
 . W !
 . S ORY=$$READ(ANSTYPE_"A^1:"_ORL,"Select "_$P(ORLIST,U)_": ")
 . I +ORY S ORY=$G(ORLIST(+ORY))
 Q ORY
