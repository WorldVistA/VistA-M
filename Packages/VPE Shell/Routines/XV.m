XV ; OSEHRA/SMH,V4W/DLW - Entry point for VPE ;Aug 26, 2019@15:20
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
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
 ;
 ;
 ;
 ;
UPGRADE ; [Public] Upgrade VPE from a previous version
 ; Don't upgrade while running
 I $G(XVVSHL)="RUN" D  QUIT
 . W $C(7),!?2,"Please exit the VShell before running UPGRADE^XV.",!
 ;
 ; Save Old User Data
 K ^TMP($J)
 N %
 F %="QU","ID","PARAM","CLH" M ^TMP($J,"XV",%)=^XVEMS(%)
 S %=""
 ;
 ; Delete VPE global (can't use straight kill due to global protection)
 F  S %=$O(^XVEMS(%)) Q:%=""  K ^(%)
 ;
 ; Delete DD only for Fileman files that have end user data
 I $D(^DD) D
 . D DT^DICRW
 . N XVF,DIU
 . F XVF=19200.11,19200.111,19200.112 S DIU="^XVV("_XVF_",",DIU(0)="EST" D EN^DIU2
 . ;
 . ; Delete Reference Fileman files data and dd
 . F XVF=19200.113,19200.114 S DIU="^XVV("_XVF_",",DIU(0)="DSET" D EN^DIU2
 ;
 ; Rebuild all of VPE
 D ^XVEMBLD,^XVVMINIT:$D(^DD)
 ;
 ; Restore old data
 F %="QU","ID","PARAM","CLH" M ^XVEMS(%)=^TMP($J,"XV",%)
 K ^TMP($J)
 QUIT
 ;
RESET ; [Public] Reset VPE to its pristine state
 I $G(XVVSHL)="RUN" D  QUIT
 . W $C(7),!?2,"Please exit the VShell before running RESET^XV.",!
 ;
 ; Delete DD and Data for all VPE files
 ; Delete Reference Fileman files data and dd
 I $D(^DD) D
 . N DIQUIET S DIQUIET=1
 . D DT^DICRW
 . N XVF,DIU
 . F XVF=19200.11,19200.111,19200.112,19200.113,19200.114 S DIU="^XVV("_XVF_",",DIU(0)="DST" D EN^DIU2
 ;
 ; Delete VPE global (can't use straight kill due to global protection)
 N % S %="" F  S %=$O(^XVEMS(%)) Q:%=""  K ^(%)
 QUIT
