XV ; OSEHRA/SMH,FWS/DLW - Entry point for VPE ;2017-08-16  12:10 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; (c) David Wicksell 2010
 ; (c) Sam Habiel 2010-2016
 ;
 ; Original VPE by David Bolduc
 ; Refactored VPE by David Wicksell and Sam Habiel
 ; Architecture of new VPE initially done by Rick Marshall
 ;
 N FLAGQ S FLAGQ=0 ;quit flag
 ;
 ; Temporary Error Trap when setting up VPE
 N $ETRAP S $ETRAP="W ""Error Occurred during Set-up."",! G ERROR^XVEMSY"
 ;
 I $D(XVSIMERR) S $EC=",U-SIM-ERROR," ; Simulated Error for testing
 ;
 N XVV  ; stores VPE settings in subscripts; see XVSS
 ;
NOUSER ; Ask for DUZ if not there
 I '$G(DUZ) S DUZ=0 D  I DUZ<0 K DUZ QUIT
 . I ($D(^DD))&$D(^VA(200)) D
 . . N DIC,X,Y,DLAYGO,DINUM,DIDEL,DTOUT,DUOUT
 . . D DT^DICRW
 . . S DIC="^VA(200,",DIC(0)="QEAZ",D="B"
 . . D IX^DIC
 . . S DUZ=$P(Y,"^")
 . . Q:DUZ<0
 I ('$D(U))!('$D(DTIME))!('$D(DT)) D
 . ;Set up VPE environment if FM is installed or a minimal environment if not
 . I ($D(^DD))&($D(^DIC)) D DT^DICRW
 . I ('$D(^DD))!('$D(^DIC)) S U="^",DTIME=9999,DT=3160000
 D ^XVEMSY ; init lots of stuff
 ;
 Q:FLAGQ
 KILL FLAGQ
 ;
BLD ; Build ^XVEMS if it doesn't exist
 I '$D(^XVEMS("QS")) D ^XVEMBLD
 I '$D(^XVEMS("QS")) W !!,"VPE Quiks and Help are not loaded",! QUIT
 ;
FM ; Build VPE Fileman Files
 I $D(^DD),'$D(^DD(19200.11)) D ^XVVMINIT
 ;
RUN ; Run VPE
 D ^XVSS ; Save symbol table, init XVV
 N XVVSHC S XVVSHC="" ; Shell input
 N XVVSHL S XVVSHL="RUN" ; Shell state
 D ^XVSA ; main loop
 I XVVSHC=U D ^XVSK ; kill temp space when user halts out
 W !
 QUIT  ; <--- XV
