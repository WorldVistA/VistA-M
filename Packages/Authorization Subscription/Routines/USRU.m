USRU ; SLC/PKR - Utility subroutines for USR ;1/24/00  11:03
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**3,12,13**;Jun 20, 1997
 ;======================================================================
 ;This routine is a direct copy from TIUU.
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
 ;
 ;======================================================================
 ; MA - CHECK INPUT TRANSFORM 8930.3 (.04) EFFECTIVE DATE > EXP DATE
VALID(Y) ; USES DA TO FIND RECORD(8930.3)
 ; Check to verify Expiration date is not less than Effective date
 I Y=-1 Q 0 ; If ^%DT returns a -1 value date is invalid. Do not Edit.
 I $P($G(^USR(8930.3,DA,0)),U,3)>Y D  Q 0
 . S X="IORVON;IORVOFF"
 . D ENDR^%ZISS
 . S A(1)=IORVON
 . S A(2)="Can not set Expiration date earlier than Start (Effective) date"
 . S A(3,"F")="!!"
 . S A(3)=IORVOFF
 . D EN^DDIOL(.A)
 Q 1
 ;======================================================================
 ; MA - CHECK INPUT TRANSFORM 8930.3 (.03) EFFECTIVE DATE < EXP DATE
VALID2(Y) ; USES DA TO FIND RECORD(8930.3)
 ; Check and verify Effective date is not greater than Expiration
 I Y=-1 Q 0 ; If ^%DT returns a -1 value date is invalid. Do not Edit.
 I $P($G(^USR(8930.3,DA,0)),U,4)=""  Q 1
 I $P($G(^USR(8930.3,DA,0)),U,4)<Y D  Q 0
 . S X="IORVON;IORVOFF"
 . D ENDR^%ZISS
 . S A(1)=IORVON
 . S A(2)="Can not set Start (Effective) date later than Expiration date"
 . S A(3,"F")="!!"
 . S A(3)=IORVOFF
 . D EN^DDIOL(.A)
 . K A
 Q 1
 ;======================================================================
STOP(PROMPT,SCROLL) ; Call DIR at bottom of screen
 N DIR,X,Y
 I $E(IOST)'="C" S Y="" G STOPX
 I +$G(SCROLL),(IOSL>($Y+5)) F  W ! Q:IOSL<($Y+6)
 S DIR(0)="FO^1:1",DIR("A")=$S($G(PROMPT)]"":PROMPT,1:"Press RETURN to continue or '^' to exit")
 S DIR("?")="Enter '^' to quit present action or '^^' to quit to menu"
 D ^DIR I $D(DIRUT),(Y="") K DIRUT
 S Y=$S(Y="^":0,Y="^^":0,$D(DTOUT):"",Y="":1,1:1_U_Y)
STOPX Q Y
