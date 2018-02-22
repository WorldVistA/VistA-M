XVEMSU2 ;DJB/VSHL**Utilities - ZPrint,ZRemove,Version ;2017-08-16  10:44 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Extensive changes throughout by Sam Habiel (c) 2016.
 ;
ZPRINT ;ZP System QWIK to print a routine
 I $G(%1)']"" D ZPMSG Q
 D RTN^XVEMKT(%1)
 Q
ZPMSG ;No parameter passed
 W $C(7),!!,"..ZP will print a routine to your screen in scrolling mode. Pass the name"
 W !,"of the routine you want to print, as a parameter."
 W !!,"Example: ..ZP %ZIS     Print routine ^%ZIS",!
 Q
 ;====================================================================
ZREMOVE() ;Delete a routine
 I $G(%1)']"" D ZRMSG Q
 NEW CHK,I,TMP
 S CHK=0 F I=1:1:9 S TMP="%"_I I $G(@TMP)]"",@TMP["^" S CHK=1
 I CHK W $C(7),!,"..ZR parameters should not contain ""^"".",! Q
 I $$YN^XVEMKU1("OK TO DELETE? ",2)'=1 Q
 DO REMOVE
 Q
ZRMSG ;
 W $C(7),!!,"..ZR will delete from 1 to 9 routines. You pass the names of the routines"
 W !,"to be deleted, as parameters."
 W !!,"Ex 1: ..ZR RTN1             Delete routine ^RTN1"
 W !!,"Ex 2: ..ZR RTN1 RTN2 RTN3   Delete routines ^RTN1,^RTN2, & ^RTN3.",!
 Q
 ;====================================================================
VERSION ;VShell Version Information
 D:'$D(XVV("RON")) REVVID^XVEMKY2
 W !?3,@XVV("RON")
 W " VPE version ",$P($T(+2),";",3)," "
 W @XVV("ROFF"),!
 Q
 ;
REMOVE ; Shared entry point for removing the routines.
 NEW I,X
 F I=1:1:9 S X=@("%"_I) Q:X']""  D
 . I XVV("OS")=19!(XVV("OS")=17) D ZRGUX(X)  ; GTM/UNIX,VAX only
 . E  I XVV("OS")=20 K ^$ROUTINE(X)
 . E  D ZRDSM(X)
 . W !?2,X," Removed..."
 QUIT
ZRDSM(RN) ; ZREMOVE DSM and friends
 X "ZR  ZS @X"
 QUIT
ZRGUX(RN) ; ZREMOVE GT.M/Unix
 ; Input: Routine Name by Value
 ; Output: None
LOOPGTM ; Loop entry point
 N %ZR ; Output from GT.M %RSEL
 N %S,%O ; Source directory, object directory 
 ; 
 ; NB: For future works, %RSEL support * syntax to get a bunch of routines
 D SILENT^%RSEL(RN,"SRC") S %S=$G(%ZR(RN)) ; Source Directory
 D SILENT^%RSEL(RN,"OBJ") S %O=$G(%ZR(RN)) ; Object Directory
 ;
 I '$L(%S)&('$L(%O)) QUIT
 ;
 S RN=$TR(RN,"%","_") ; change % to _ in routine name
 ;
 N $ET,$ES S $ET="Q:$ES  S $EC="""" Q" ; In case somebody else deletes this; we don't crash
 ;
 I $L(%S) D  ; If source routine present?
 . O %S_RN_".m":(readonly):0
 . E  Q
 . C %S_RN_".m":(delete)
 ;
 I $L(%O) D  ; If object code present?
 . O %O_RN_".o":(readonly):0
 . E  Q
 . C %O_RN_".o":(delete)
 G LOOPGTM
