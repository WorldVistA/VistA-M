XVEMKYB ;DJB/KRN**Manual version of ^XVEMKY2 Variables ;2017-08-16  12:12 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
BLANK1 ;Blank - cursor to end-of-screen
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),5)),$P(^(5),"^",7)]"" W @($P(^(5),"^",7)) Q
 W $C(27)_"[J"
 Q
BLANK2 ;Blank - top-of-screen to cursor
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),13)),$P(^(13),"^",1)]"" W @($P(^(13),"^",1)) Q
 W $C(27)_"[1J"
 Q
BLANK3 ;Blank - cursor to end-of-line
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),5)),$P(^(5),"^",6)]"" W @($P(^(5),"^",6)) Q
 W $C(27)_"[K"
 Q
BLANK4 ;Blank - start-of-line to cursor
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),13)),$P(^(13),"^",3)]"" W @($P(^(13),"^",3)) Q
 W $C(27)_"[1K"
 Q
RIGHTMAR(MAR) ;Right Margin
 S:$G(MAR)'>0 MAR=0 X "I XVV(""OS"")=8 U $I:MAR"
 Q
WRAP(WHICH) ;Wrap & no wrap. WHICH=ON/OFF.
 S WHICH=$$ALLCAPS^XVEMKU(WHICH) Q:",ON,OFF,"'[(","_WHICH_",")
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),15)),$P(^(15),"^",1)]"",$P(^(15),"^",2)]"" D  Q
 . I WHICH="OFF" W @($P(^(15),"^",2)) Q
 . W @($P(^(15),"^",1))
 I WHICH="OFF" W $C(27)_"[?7l" Q
 W $C(27)_"[?7h"
 Q
CRSRPOS(DX,DY) ;Position cursor to coordinates DX & DY. Default is 0,0
 S:$G(DX)'>0 DX=0 S:$G(DY)'>0 DY=0
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),"XY")) X ^("XY") Q
 W $C(27)_"["_(DY+1)_";"_(DX+1)_"H"
 Q
CRSRMOVE(DIR) ;Cursor move up/down/right/left. DIR=U/D/R/L
 S DIR=$$ALLCAPS^XVEMKU(DIR) Q:",U,D,R,L,"'[(","_DIR_",")
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),8)),$P(^(8),"^",1,4)'["^^" D  Q
 . NEW I,NODE8,VAR S NODE8=^(8),VAR="U^D^R^L"
 . F I=1:1:4 I DIR=$P(VAR,"^",I) W @($P(NODE8,"^",I)) Q
 I DIR="U" W $C(27)_"[1A" Q
 I DIR="D" W $C(27)_"[1B" Q
 I DIR="R" W $C(27)_"[1C" Q
 I DIR="L" W $C(27)_"[1D"
 Q
CRSROFF(WHICH) ;Cursor on/off. WHICH=ON/OFF
 S WHICH=$$ALLCAPS^XVEMKU(WHICH) Q:",ON,OFF,"'[(","_WHICH_",")
 I WHICH="ON" W $C(27)_"[?25h" Q
 I WHICH="OFF" W $C(27)_"[?25l"
 Q
CRSRSAVE(WHICH) ;Cursor Save/Restore. WHICH=S/R
 S WHICH=$$ALLCAPS^XVEMKU(WHICH) Q:",R,S,"'[(","_WHICH_",")
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),14)),$P(^(14),"^",3)]"",$P(^(14),"^",4)]"" D  Q
 . I WHICH="R" W @($P(^(14),"^",4)) Q
 . I WHICH="S" W @($P(^(14),"^",3))
 I WHICH="R" W $C(27)_8 Q
 I WHICH="S" W $C(27)_7
 Q
REVVID(WHICH) ;Reverse Video. WHICH=ON/OFF
 S WHICH=$$ALLCAPS^XVEMKU(WHICH) Q:",ON,OFF,"'[(","_WHICH_",")
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),5)),$P(^(5),"^",4)]"",$P(^(5),"^",5)]"" D  Q
 . I WHICH="ON" W @($P(^(5),"^",4)) Q
 . I WHICH="OFF" W @($P(^(5),"^",5))
 I WHICH="ON" W $C(27)_"[7m" Q
 I WHICH="OFF" W $C(27)_"[0m"
 Q
GRAPHICS(WHICH) ;Graphics On/Off. WHICH=ON/OFF
 S WHICH=$$ALLCAPS^XVEMKU(WHICH) Q:",ON,OFF,"'[(","_WHICH_",")
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),"G1")),$D(^("G2")) S XVVS("GON")=^("G1"),XVVS("GOFF")=^("G0") Q
 I WHICH="ON" X @(^("G1")) Q
 I WHICH="OFF" X @(^("G0"))
 I WHICH="ON" W $C(27)_"(0" Q
 I WHICH="OFF" W $C(27)_"(B"
 Q
CHARI(WHICH) ;Character Insert. WHICH=ON/OFF
 S WHICH=$$ALLCAPS^XVEMKU(WHICH) Q:",ON,OFF,"'[(","_WHICH_",")
 I WHICH="ON" W $C(27)_"[4h" Q
 I WHICH="OFF" W $C(27)_"[4l"
 Q
HELP ;Help text
 W @XVV("IOF"),!?1,"xxxx^XVEMKYB()"
 W !?1,"BLANK1....:           :Blank cursor to end-of-screen"
 W !?1,"BLANK2....:           :Blank top-of-screen to cursor"
 W !?1,"BLANK3....:           :Blank cursor to end-of-line"
 W !?1,"BLANK4....:           :Blank start-of-line to cursor"
 W !?1,"RIGHTMAR..: MAR       :Right margin"
 W !?1,"WRAP......: ON/OFF    ;Wrap/nowrap"
 W !?1,"CRSRPOS...: DX/DY     ;Curor position"
 W !?1,"CRSRMOVE..: U/D/R/L   ;Cursor move"
 W !?1,"CRSROFF...: ON/OFF    ;Cursor on/off"
 W !?1,"CRSRSAVE..: S/R       ;Cursor save/restore"
 W !?1,"REVVID....: ON/OFF    ;Reverse video"
 W !?1,"GRAPHICS..: ON/OFF    ;Graphics on/off"
 W !?1,"CHARI.....: ON/OFF    ;Character insert"
 W ! Q
