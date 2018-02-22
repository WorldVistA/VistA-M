XVEMKY ;DJB/KRN**Kernel - Basic Init ; 9/12/17 3:16pm
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; IO,AUTOMARG by Sam Habiel (c) 2016
 ; SET Mumps V1 support by Sam Habiel (c) 2017
 ;
INIT ;Initialize variables
 D TIME
 S U="^"
 S $P(XVVLINE,"-",212)=""
 S $P(XVVLINE1,"=",212)=""
 S $P(XVVLINE2,". ",106)=""
 D IO
 S XVVSIZE=(XVV("IOSL")-6)
 S XVVIOST=$S($G(IOST)]"":IOST,1:"C-VT100")
 Q
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TIME ;Set timeout length
 Q:$G(XVV("TIME"))>0
 I $G(XVV("ID"))>0,$G(^XVEMS("PARAM",XVV("ID"),"TO"))>0 S XVV("TIME")=^("TO") Q
 S XVV("TIME")=$S($D(DTIME):DTIME,1:300)
 Q
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IO ;Form Feed, Margin, Sheet Length
 ; I $G(IOF)]"",$G(IOSL)]"",$G(IOM)]"" D  D PARAM Q
 ; . S XVV("IOF")=IOF,XVV("IOSL")=IOSL,XVV("IOM")=IOM
 I $D(^%ZIS(1)) D KERN I 1
 E  D NOKERN
 I '$D(%ut) D
 . N XVAUTOMARG S XVAUTOMARG=$$AUTOMARG()
 . I XVAUTOMARG S IOM=$P(XVAUTOMARG,U),IOSL=$P(XVAUTOMARG,U,2) S XVV("IOSL")=IOSL,XVV("IOM")=IOM
 D PARAM
 Q
 ;
PARAM ;Adjust screen length/width to ..PARAM settings
 I $G(XVV("ID"))>0 D  ;
 . S:$D(^XVEMS("PARAM",XVV("ID"),"WIDTH")) XVV("IOM")=^("WIDTH")
 . S:$D(^XVEMS("PARAM",XVV("ID"),"LENGTH")) XVV("IOSL")=^("LENGTH")
 S XVVSIZE=XVV("IOSL")-$S(XVV("IOSL")>6:6,1:"")
 Q
 ;
KERN ;VA KERNEL
 D HOME^%ZIS
 S XVV("IOSL")=IOSL
 S XVV("IOF")=IOF
 S XVV("IOM")=IOM
 Q
 ;
NOKERN ;No VA KERNEL
 S XVV("IOSL")=$G(IOSL,24)
 S XVV("IOF")="#,$C(27),""[2J"",$C(27),""[H"""
 S XVV("IOM")=$G(IOM,80)
 Q
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OS ;Get Operating System
 ;This subroutine returns FLAGQ=1 if XVV("OS") cannot be set.
 S FLAGQ=0 D  Q:FLAGQ
 . I $D(^%ZOSF("OS")) S XVV("OS")=+$P(^("OS"),"^",2) Q:XVV("OS")>0
 . I $D(^DD("OS")) S XVV("OS")=+^("OS") Q:XVV("OS")>0
 . I $D(^XVEMS("OS")) S XVV("OS")=+^("OS") Q:XVV("OS")>0
 . D SET
 I XVV("OS")=9 D  Q
 . X "I $I=1,$ZDEV(""VT"")=0 S FLAGQ=1 D DTMHELP" Q
 Q
 ;
SET ;Get MUMPS System
 NEW NUM
 S NUM=8
 I '$D(^XVEMS) D  S FLAGQ=1 Q
 . W $C(7),!!,"Sorry, this software requires that you have either the VA KERNEL,"
 . W !,"FileMan, or the VPE Shell on your system.",!
 NEW X
 W !!,"I need to know what type of Mumps system you are running."
 W !,"Select from the following choices. Selecting a system other"
 W !,"than the one you are running, will cause errors or"
 W !,"unpredictable behavior. DO SET^XVEMKY again to correct."
 W !!,"1. MSM",!,"2. DTM",!,"3. DSM",!,"4. VAX DSM",!,"5. CACHE",!,"6. GT.M (VMS)",!,"7. GT.M (Unix)",!,"8. MV1"
 W !
SET1 R !,"Enter number: ",X:300 S:'$T X="^"
 I "^"[X W ! S FLAGQ=1 Q
 I X'?1N!(X<1)!(X>NUM) D  G SET1
 . W "   Enter a number from 1 to "_NUM
 S X=$S(X=1:8,X=2:9,X=3:2,X=4:16,X=5:18,X=6:17,X=7:19,X=8:20,1:"")
 I X']"" Q
 I $D(^XVEMS) S (^XVEMS("OS"),XVV("OS"))=X
 I $D(^XVEMS("E")) S (^XVEMS("E","OS"),XVV("OS"))=X
 Q
 ;
DTMHELP ;DataTree users on console device must be in VT220 emulation.
 W !!,"============================================================================="
 W $C(7),!!?2,"If you are using DataTree Mumps on the console device, you must enable"
 W !?2,"the VT220 emulation features. You may set the VT device parameter as"
 W !?2,"follows:"
 W !!?10,"USE 1:VT=1   ;to enable",!?10,"USE 1:VT=0   ;to disable"
 W !!?2,"The $ZDEV(""VT"") variable returns the current value of the VT parameter."
 W !!?2,"If you have the DEVICE and TERMINAL TYPE files from the VA KERNEL on your"
 W !?2,"system, go into the DEVICE file and edit the device whose $I field equals"
 W !?2,"1, and enter ""VT=1"" in the USE PARAMETER field."
 W !!,"=============================================================================",!
 Q
AUTOMARG() ;RETURNS IOM^IOSL IF IT CAN and resets terminal to those dimensions; GT.M, Cache, MV1
 ; Stolen from George Timson's %ZIS3.
 ; I +$SY=50 QUIT "132^46" ; <--TEMP
 I $D(^%ZOSF("RM")) N X S X=0 X ^%ZOSF("RM")
 N %I,%T,ESC,DIM S %I=$I,%T=$T D
 . ; resize terminal to match actual dimensions
 . S ESC=$C(27)
 . I +$SY=0 U $P:(:"+S+I":"R")
 . I +$SY=47 U $P:(TERM="R":NOECHO)
 . I +$SY=50 U $P:("NOESCAPE":"NOECHO":"TERMINATOR=R")
 . W ESC,"7",ESC,"[r",ESC,"[999;999H",ESC,"[6n"
 . R DIM:1 E  Q
 . W ESC,"8"
 . I +$SY=0 I DIM?.APC U $P:("") Q
 . I +$SY=47 I DIM?.APC U $P:(TERM="":ECHO) Q
 . I +$SY=50 I DIM?.APC U $P:("ECHO":"ESCAPE":"TERMINATOR="_$C(10,13,27)) Q
 . I $L($G(DIM)) S DIM=+$P(DIM,";",2)_"^"_+$P(DIM,"[",2)
 . I +$SY=0 U $P:(+DIM:"")
 . I +$SY=47 U $P:(TERM="":ECHO:WIDTH=+$P(DIM,";",2):LENGTH=+$P(DIM,"[",2))
 . I +$SY=50 U $P:("ECHO":"ESCAPE":"TERMINATOR="_$C(10,13,27))
 ; restore state
 U %I I %T
 Q:$Q $S($G(DIM):DIM,1:"") Q
