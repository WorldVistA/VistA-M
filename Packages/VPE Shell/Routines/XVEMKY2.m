XVEMKY2 ;DJB/KRN**Screen Variables ;2017-08-15  1:32 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; GT.M support by Brian Lord (c) 2005
 ; Mumps V1 support,RIGHTMAR changes by Sam Habiel (c) 2017
 ;
 ;;X XVVS("CRSR"),XVVS("RM0"). All others are: W @()
SCRNVAR ;Screen Variables
 I $G(XVVS("RM0"))']"" D RIGHTMAR ;.........Right Margin
 I $G(XVVS("XY"))']"" D XY^XVEMKY1 ;.......Reset $X & $Y
 Q:$G(XVVS("CRSR"))]""  ;...................Position cursor
 D CRSRPOS S XVVS("CRSR")=XVVS("CRSR")_" "_XVVS("XY")
 Q
CRSRPOS ;Position cursor
 Q:$D(XVVS("CRSR"))
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),"XY")) S XVVS("CRSR")=^("XY") Q
 S XVVS("CRSR")="W $C(27)_""[""_(DY+1)_"";""_(DX+1)_""H"""
 Q
RIGHTMAR ;Right Margin
 I $D(XVVS("RM0")),$D(XVVS("RM80")) Q
 ;
 ;--> Default
 S (XVVS("RM0"),XVVS("RM80"))=""
 ;
 I XVV("OS")=8!(XVV("OS")=18) S XVVS("RM0")="U $I:0"
 ;I XVV("OS")=16 S XVVS("RM0")="U $I:WIDTH=0"
 I XVV("OS")=17!(XVV("OS")=19) S XVVS("RM0")="U $I:WIDTH=0"
 ;
 ; NB: MV1 has nothing to edit margins.
 NEW RM
 I $G(XVV("ID")) S RM=$G(^XVEMS("PARAM",XVV("ID"),"WIDTH"))
 I $G(RM)="" S RM=$G(XVV("IOM")) ; Automargin, if it's available at this point
 I $G(RM)="" S RM=80 ;Default
 I XVV("OS")=8!(XVV("OS")=18) S XVVS("RM80")="U $I:"_RM Q
 ;I XVV("OS")=16 S XVVS("RM80")="U $I:WIDTH="_RM Q
 I XVV("OS")=17!(XVV("OS")=19) S XVVS("RM80")="U $I:WIDTH="_RM Q
 Q
WRAP ;Wrap & no wrap
 I $D(XVVS("WRAP")),$D(XVVS("NOWRAP")) Q
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),15)),$P(^(15),"^",1)]"",$P(^(15),"^",2)]"" S XVVS("WRAP")=$P(^(15),"^",1),XVVS("NOWRAP")=$P(^(15),"^",2) Q
 S XVVS("WRAP")="$C(27)_""[?7h"""
 S XVVS("NOWRAP")="$C(27)_""[?7l"""
 Q
CRSRMOVE ;Cursor move
 I $D(XVVS("CU")),$D(XVVS("CD")),$D(XVVS("CR")),$D(XVVS("CL")) Q
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),8)),$P(^(8),"^",1,4)'["^^" NEW NODE8 S NODE8=^(8) D  Q
 . S XVVS("CU")=$P(NODE8,"^",1),XVVS("CD")=$P(NODE8,"^",2)
 . S XVVS("CR")=$P(NODE8,"^",3),XVVS("CL")=$P(NODE8,"^",4)
 S XVVS("CU")="$C(27)_""[1A""" ;Cursor up
 S XVVS("CD")="$C(27)_""[1B""" ;Cursor down
 S XVVS("CR")="$C(27)_""[1C""" ;Cursor right
 S XVVS("CL")="$C(27)_""[1D""" ;Cursor left
 Q
CRSROFF ;Cursor on/off
 I $D(XVVS("CON")),$D(XVVS("COFF")) Q
 S XVVS("CON")="$C(27)_""[?25h""" ;Cursor on
 S XVVS("COFF")="$C(27)_""[?25l""" ;Cursor off
 Q
CRSRSAVE ;Save Cursor/Restore Cursor
 I $D(XVVS("SC")),$D(XVVS("RC")) Q
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),14)),$P(^(14),"^",3)]"",$P(^(14),"^",4)]"" S XVVS("SC")=$P(^(14),"^",3),XVVS("RC")=$P(^(14),"^",4) Q
 S XVVS("SC")="$C(27)_7"
 S XVVS("RC")="$C(27)_8"
 Q
REVVID ;Reverse Video
 I $D(XVV("RON")),$D(XVV("ROFF")) Q
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),5)),$P(^(5),"^",4)]"",$P(^(5),"^",5)]"" S XVV("RON")=$P(^(5),"^",4),XVV("ROFF")=$P(^(5),"^",5) Q
 S XVV("RON")="$C(27)_""[7m""",XVV("ROFF")="$C(27)_""[0m"""
 Q
GRAPHICS ;Graphics On/Off
 I $D(XVVS("GON")),$D(XVVS("GOFF")) Q
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),"G1")),$D(^("G2")) S XVVS("GON")=^("G1"),XVVS("GOFF")=^("G0") Q
 S XVVS("GON")="$C(27)_""(0""",XVVS("GOFF")="$C(27)_""(B"""
 Q
SCROLL(TOP,BOTTOM) ;Set scroll region
 S:$G(TOP)'>0 TOP=1 S:$G(BOTTOM)'>0 BOTTOM=XVV("IOSL")
 W @("$C(27)_""["_TOP_";"_BOTTOM_"r""")
 Q
SCRL ;Scroll region variables
 S XVVS("INDEX")="$C(27)_""D""",XVVS("REVINDEX")="$C(27)_""M""" ;Index
 S XVVS("INSRT")="$C(27)_""[1L""" ;Insert 1 line
 Q
SCRNVAR1 ;Lesser Used Screen Variables
 S XVVS("CION")="$C(27)_""[4h""",XVVS("CIOFF")="$C(27)_""[4l""" ;Character insert
 Q
DTM ;Support for DataTree Mumps
 Q:XVV("OS")'=9  Q:$I=1
 Q:$G(^XVEMS("%",$J_$G(^XVEMS("SY")),"SHL"))'="RUN"
 X "S ^XVEMS(""%"",$J_$G(^XVEMS(""SY"")),""DTM"")=$ZDEV(""IXXLATE"")_""^""_$ZDEV(""WRAP"")"
 X "U $I:(IXXLATE=0)" ;X "U $I:(IXXLATE=0:WRAP=0)"
 Q
BRK ;Enable Control C
 I $D(^%ZOSF("BRK")) X ^%ZOSF("BRK") Q
 I XVV("OS")=16 U $I:CENABLE Q
 I XVV("OS")=17 U $I:(CENABLE) Q
 I XVV("OS")=18 U $I:("":"+B") Q
 I XVV("OS")=19 U $I:(CENABLE) Q
 I XVV("OS")=20 U $I:("CONTROLC") Q
 X "B 1"
 Q
NOBRK ;Disable Control C
 I $D(^%ZOSF("NBRK")) X ^%ZOSF("NBRK") Q
 I XVV("OS")=16 U $I:NOCENABLE Q
 I XVV("OS")=17 U $I:(NOCENABLE) Q
 I XVV("OS")=18 U $I:("":"-B") Q
 I XVV("OS")=19 U $I:(NOCENABLE) Q
 I XVV("OS")=20 U $I:("NOCONTROLC") Q
 X "B 0"
 Q
