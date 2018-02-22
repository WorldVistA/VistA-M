XVEMKY1 ;DJB/KRN**BS,TRMREAD,ECHO,EXIST,XY,$ZE ;2017-08-15  1:24 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; GT.M support by Brian Lord (c) 2005
 ; Mumps V1 support,EXIST tag changes by Sam Habiel (c) 2017
 ;
BS ;Backspace options
 I '$D(XVV("ID")) S XVV("BS")="SAME" Q
 S XVV("BS")=$G(^XVEMS("PARAM",XVV("ID"),"BS"))
 I XVV("BS")']"" S XVV("BS")="SAME"
 Q
 ;
ZE ;$ZE Error info
 I XVV("OS")=17!(XVV("OS")=19) S XVV("$ZE")="$ZSTATUS" Q
 I XVV("OS")=20 S XVV("$ZE")="$EC_"" - ""_$&%ERRMSG($TR($EC,"",""))" Q
 S XVV("$ZE")="$ZE"
 Q
 ;
TRMREAD ;Read terminators
 Q:$D(XVV("TRMON"))
 I $D(^%ZOSF("TRMON")) D  Q
 . S XVV("TRMON")=$G(^%ZOSF("TRMON"))
 . S XVV("TRMOFF")=$G(^%ZOSF("TRMOFF"))
 . S XVV("TRMRD")=$G(^%ZOSF("TRMRD"))
 ;
 ;-> DSM
 I XVV("OS")=2 D  Q
 . S XVV("TRMON")="U $I:(::::1572864::::$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31))"
 . S XVV("TRMOFF")="U $I:(:::::1572864:::$C(13,27))"
 . S XVV("TRMRD")="S Y=$ZB"
 ;
 ;-> MSM
 I XVV("OS")=8 D  Q
 . S XVV("TRMON")="U $I:(::::::::$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127))"
 . S XVV("TRMOFF")="U $I:(::::::::$C(13,27))"
 . S XVV("TRMRD")="S Y=$ZB"
 ;
 ;-> DTM
 I XVV("OS")=9 D  Q
 . S XVV("TRMON")="U $I:IXINTERP=2"
 . S XVV("TRMOFF")="U $I:IXINTERP=$S($I>99:1,1:0)"
 . S XVV("TRMRD")="S Y=$S('$ZIOS:$ZIOT,1:0)"
 ;
 ;-> DSM for OpenVMS
 I XVV("OS")=16 D  Q
 . S XVV("TRMON")="U $I:TERM=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127)"
 . S XVV("TRMOFF")="U $I:TERM="""""
 . S XVV("TRMRD")="S Y=$ZB"
 ;
 ;-> CACHE
 I XVV("OS")=18 D  Q
 . S XVV("TRMON")="U $I:("""":""+I+T"")"
 . S XVV("TRMOFF")="U $I:("""":""-I-T"":$C(13,27))"
 . S XVV("TRMRD")="S Y=$A($ZB),Y=$S(Y<32:Y,Y=127:Y,1:0)"
 ;
 ;-> GTM
 I XVV("OS")=17!(XVV("OS")=19) D  Q
 . S XVV("TRMON")="U $I:(TERMINATOR=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127))"
 . S XVV("TRMOFF")="U $I:(TERMINATOR="""")"
 . S XVV("TRMRD")="S Y=$A($ZB)"
 ;
 ;-> MV1
 I XVV("OS")=20 D  Q
 . N WID
 . S WID="""TERMINATOR=""_$C(0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127)"
 . S XVV("TRMON")="U $I:(""NOESCAPE"":""DELETE=NONE"":"_WID_")"
 . S WID="""TERMINATOR=""_$C(10,13,27)"
 . S XVV("TRMOFF")="U $I:(""ESCAPE"":""DELETE=BOTH"":"_WID_")"
 . S XVV("TRMRD")="S Y=$A($KEY)"
 ;
 ;-> Default
 S (XVV("TRMON"),XVV("TRMOFF"),XVV("TRMRD"))=""
 W !!,"I'm unable to set READ Terminators for your M system."
 W !,"Edit TRMREAD^XVEMKY1 and add code for your system."
 D PAUSE^XVEMKU(2)
 Q
 ;
ECHO ;Set up Echo On and Echo Off
 NEW CHK
 Q:$D(XVV("EON"))
 I $D(^%ZOSF("EON")),$D(^%ZOSF("EOFF")) S XVV("EON")=^%ZOSF("EON"),XVV("EOFF")=^%ZOSF("EOFF") D  Q
 . Q:XVV("OS")'=9
 . X "S CHK='$ZDEV(""ECHOA"")" Q:CHK
 . S XVV("EON")="U $I:ECHOA=1",XVV("EOFF")="U $I:ECHOA=0"
 ;
 ;-> DSM
 I XVV("OS")=2 D  Q
 . S XVV("EON")="U $I:(:::::1)",XVV("EOFF")="U $I:(::::1)"
 ;
 ;-> MSM
 I XVV("OS")=8 D  Q
 . S XVV("EON")="U $I:(:::::1)",XVV("EOFF")="U $I:(::::1)"
 ;
 ;-> DTM
 I XVV("OS")=9 D  Q
 . X "S CHK=$ZDEV(""ECHOA"")"
 . I CHK S XVV("EON")="U $I:ECHOA=1",XVV("EOFF")="U $I:ECHOA=0" Q
 . S (XVV("EON"),XVV("EOFF"))=""
 ;
 ;-> VAX DSM
 I XVV("OS")=16 D  Q
 . S XVV("EON")="U $I:ECHO"
 . S XVV("EOFF")="U $I:NOECHO"
 ;
 ;-> CACHE
 I XVV("OS")=18 D  Q
 . S XVV("EON")="U $I:("""":""-S"")"
 . S XVV("EOFF")="U $I:("""":""+S"")"
 . Q
 ;
 ;-> GTM
 I XVV("OS")=17!(XVV("OS")=19) D  Q
 . S XVV("EON")="U $I:(ECHO)"
 . S XVV("EOFF")="U $I:(NOECHO)"
 ;
 ;-> MUMPS V1
 I XVV("OS")=20 D  Q
 . S XVV("EON")="U $I:(""ECHO"")"
 . S XVV("EOFF")="U $I:(""NOECHO"")"
 ;-> Default
 S (XVV("EON"),XVV("EOFF"))="" D ECHOMSG,PAUSE^XVEMKU(2)
 Q
 ;
EXIST ;Set up XVVS("EXIST") to test existence of a routine.
 I XVV("OS")=2 S XVVS("EXIST")="I $D(^ (X))" Q
 I XVV("OS")=8 S XVVS("EXIST")="I $D(^ (X))" Q
 I XVV("OS")=9 S XVVS("EXIST")="I $ZRSTATUS(X)]""""" Q
 I XVV("OS")=16 S XVVS("EXIST")="I $D(^ (X))!$D(^!(X))" Q
 I XVV("OS")=18 S XVVS("EXIST")="I X?1(1""%"",1A).AN,$D(^$ROUTINE(X))" Q
 I XVV("OS")=17!(XVV("OS")=19) D  Q
 . S XVVS("EXIST")="I X]"""",$T(^@X)]"""""
 I XVV("OS")=20 S XVVS("EXIST")="I X]"""",$T(^@X)]""""" Q
 ;Default
 S XVVS("EXIST")="I @(""$T(^""_X_"")]"""""""""")"
 Q
 ;
XY ;Resetting $X & $Y
 Q:$D(XVVS("XY"))
 I $D(^%ZOSF("XY")) S XVVS("XY")=^%ZOSF("XY") Q:XVVS("XY")]""
 I XVV("OS")=2 S XVVS("XY")="U $I:(::::::DY*256+DX)" Q
 I XVV("OS")=8 S XVVS("XY")="U $I:(::::::DY*256+DX)" Q
 I XVV("OS")=9 S XVVS("XY")="W /C(DX,DY)" Q
 I XVV("OS")=16 S XVVS("XY")="U $I:(NOCURSOR,X=DX,Y=DY,CURSOR)" Q
 I XVV("OS")=18 S XVVS("XY")="S $X=DX,$Y=DY" Q
 I XVV("OS")=17!(XVV("OS")=19) S XVVS("XY")="S $X=DX,$Y=DY" Q
 I XVV("OS")=20 S XVVS("XY")="S $X=DX,$Y=DY" Q
 ;Default
 S XVVS("XY")="" D XYMSG,PAUSE^XVEMKU(2)
 Q
 ;
ECHOMSG ;Can't set ECHO ON/OFF
 W !!,"I'm unable to set ECHO ON/OFF for your M system."
 W !,"Edit ECHO^XVEMKY1 and add code for your system."
 Q
 ;
XYMSG ;Can't reset $X & $Y
 W !!,"I don't know how to reset $X & $Y on your M system. Edit XY^XVEMKY1"
 W !,"Edit XY^XVEMKY1 and add code for your system."
 Q
