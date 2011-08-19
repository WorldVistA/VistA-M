BPSOSU8 ;BHAM ISC/FCS/DRS/FLS - utilities ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;*** Collection of FSI UTILITIES ***
 ;
 ;EOPQ(LINES,PARAM,Xcode) - Return 0 to continue, 1 to quit.
 ;PAUSE() Return 1 to continue, 0 to stop.
 ;ENDRPT()
 ;DEVICE(DEV,RTN,TITLE,MULTI) S up a device, 1 if successful, 0 not.
 ;HEADER(PROGRAM,TITLE1,TITLE2,RUNTIME,NOFF,UL) Procedure call
 ;CENTER
 ;UNDERLINE
 ;REPLICATE
 ;FMPAGE() Handle the screen or printer for an FM print report.
 ;PAGE0
 ;STANDBY
 ;======================================================================
EOPQ(LINESBOT,PARAM,EOPXCODE) ;EP -
 ; IN: LINESBOT = (optional) # of LINES from bottom (IOSL) before
 ;               determining what to do next.  I this is a CRT, we
 ;               will ask user whether to continue; for printers, just
 ;               continue.  DEFAULT=6
 ;     PARAM    = List of parameter codes (each may occur):
 ;                "M" - Will display "-- More --" at bottom.
 ;     EOPXCODE = xecutable code that will occur if this is the
 ;                end of the page (like, D HEADER^ROU).
 ;
 ; OUT: 0 if not end of page, OR if we're EOP but we're continuing;
 ;      1 if user wants to quit.
 ; May call this as DO in some cases (like a little trailer on report)
 ;
 N X,Y,%,DIR
 ;
 I '$G(IOSL) Q 0  ;if we don't know page length, then not at end
 S LINESBOT=$S($G(LINESBOT):LINESBOT,1:6)
 I ($Y+LINESBOT)<IOSL Q 0  ;not at end of page
 ; -- Okay, we're at end of page
 I $G(PARAM)["M" W !,?($S($G(IOM):IOM,1:80)-12),"-- More --"
 ;
 I '$$PAUSE Q 1  ;user wants out
 X $G(EOPXCODE)
 ;
 Q 0
 ;======================================================================
PAUSE() ;3/31/93
 ;END of screen... should we continue?
 ;I $E(IOST,1)'="C"
 I '$$TOSCREEN^BPSOSU5 Q 1
 K DIR
 S DIR(0)="E" D ^DIR
 Q Y  ;Y=1 to continue, 0 to quit.
 ;===================================================================
ENDRPT() ;EP - end of report.  Pause until user presses return (or timeout)
 I '$$TOSCREEN^BPSOSU5 W:$Y @IOF Q 1
 I $G(FLGSTOP) W !," <escape>"
 N DIR,X,Y
 S DIR(0)="E"
 S DIR("A")="  -- END OF REPORT --  (Press <ENTER> to return to menu)"
 D ^DIR
 Q Y
 ;===================================================================
DEVICE(DEV,RTN,TITLE,MULTI) ;EP
 ;Select an output device.
 ;No parameters are required.  DEV can be set alone, or if queuing
 ;  set to variables needed for queuing.
 ;   DEV   - DEFAULT device, "HOME" if undefined.
 ;   RTN   - Routine name if queuing is selected.
 ;   TITLE - Description for the task log if queuing is selected.
 ;   MULTI - I then ask NUMBER OF COPIES, which sets the variable
 ;           DCOPIES that the calling routine should use.
 ;Return 1 if successful, 0 if not.  Also returns DCOPIES to number of
 ;  copies if MULTI parameter is set.
 ;Examples: Q:'$$DEVICE^ABSBUU01("STANDARD")
 ;
 ;       Q:'$$DEVICE^ABSBUU01("PC;132;66","EN^WSHLC","CORRECTION LIST")
 ;       note: D ^%ZISC to close the device after printing is done.
 N I,Y,%ZIS,POP,ZTRTN,ZTIO,ZTDESC,ZTSAVE,ZTQUEUED,PAGE
 W !!
 S ZTSAVE("PAGE")=""
 I $D(RTN) S %ZIS="QM" ; Ask if queuing is allowed only if RTN is set.
 S %ZIS("A")="Send report to device: " ;PROMPT
 S %ZIS("B")=$S($D(DEV):DEV,1:"HOME") ;DEFAULT device
 D ^%ZIS ;Input/Output variables.
 I POP W "   try again later" S Y=0 G DEVQ  ;Device success flag
 S PAGE=0
 I '$D(IO("Q")) U IO S Y=1 G DEVQ ;Queuing not selected
 S ZTRTN=RTN ;Routine entry point for queuing.
 S ZTIO=ION ;Output device for queuing.
 S ZTDESC=$G(TITLE) ;Report title if queuing is selected.
 S ZTSAVE("*")="" ;All variables in memory for queuing.
 D ^%ZTLOAD ;Entry point for queuing.
 W !,$S($D(ZTQUEUED):"Request queued!",1:"Request cancelled!") ;flag
 S Y='$D(ZTQUEUED)
 D HOME^%ZIS ;S IO variables back to device = screen.
 U IO ;Use the currently open IO device
DEVQ I +$G(MULTI)>0 D  USE IO
 . USE $P
 . N Y
 . S DCOPIES=0
 . K DIR
 . S DIR(0)="NO^0:99999",DIR("A")="NUMBER OF COPIES TO OUTPUT"
 . S DIR("B")=1
 . D ^DIR K DIR
 . I +Y>0 S DCOPIES=Y
 . I Y["^" S DCOPIES=-1
 I $G(DCOPIES)<0 S Y=0
 Q Y
 ;===================================================================
HEADER(PROGRAM,TITLE1,TITLE2,RUNTIME,NOFF,UL) ;
 ; This PROCEDURE accepts the routine name and titles and prints out a 
 ; standard header with the run date and time,page and increments
 ; the page counter by 1.  Page is initialized in function DEVICE.
 ; W @IOF if (to SCREEN) OR (to PRINTER after page 1)
 ;    TITLE variable has special uses.  I the calling routine
 ; send-in the TITLE-array (by setting TITLE(1)="LINE 1", TITLE(n)=
 ; "LINE n of title", and then D HEADER^WSHUTL("ROUTINE",.TITLE),"."),
 ; then the entire array of TITLE will be used (and TITLE2 will be
 ; ignored).  You must send-in TITLE2="."
 ;    RUNTIME has been added so that all pages of the report can
 ; have the same date.time.  The calling report must send it in.
 ;    NOFF (optional) - if it exists, then do NOT issue a FormFeed.
 ; This is necessary for reports that are controlled as a FileMan
 ; template... since FM issues its own FF, this routine should not.
 ;    UL (opt) - is flag to print a 1-IOSL dashes after the header.
 ; DEFAULT is no-underline.  S UL to 1 to print the underline.
 ;
 ; Note: PAGE is assumed to exist even though it is not passed in
 N X,N
 S $Y=0,PAGE=$G(PAGE)
 I $E(IOST,1)="C"!($E(IOST,1)="P"&(PAGE>0)) I '$D(NOFF) W @IOF
 S PAGE=PAGE+1
 I $G(RUNTIME)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S RUNTIME=Y
 W !,"RUN DATE: ",RUNTIME
 W ?(IOM-10),"PAGE: ",$J(PAGE,3,0)
 I $D(PROGRAM),PROGRAM'="" W !,"PGM:  ",PROGRAM
 I $G(TITLE2)'="." DO
 . I $D(TITLE1) D WCENTER^BPSOSU9(TITLE1)
 . I $D(TITLE2) D WCENTER^BPSOSU9(TITLE2)
 I $G(TITLE2)="." DO
 . S N=""
 . F  S N=$O(TITLE1(N)) Q:N=""  D WCENTER^BPSOSU9($G(TITLE1(N)))
 I $G(UL)=1 D  ;print dashes across the page
 . W !
 . FOR I=1:1:$S($G(IOM)>0:IOM,1:80) W "-"
 W !
 Q
 ;===================================================================
FMPAGE ;at end of page
 I $$TOSCREEN^BPSOSU5 D  Q
 . D PRESSANY^BPSOSU5()
 I IOST["P-" W @IOF Q
 ; should we fall through to PAGE0?
 Q
 ;===================================================================
PAGE0 ; This checks the IO device and issues a pagefeed if $Y>0
 Q:'$G(IO)
 ;OPEN IO USE IO I $Y>0 USE IO W #
 U IO I $Y>0 U IO W #
 Q
 ;===================================================================
STANDBY ;  W a message to screen to "Please Wait"
 USE $P D WAIT^DICD USE +$G(IO)
 Q
 ;===================================================================
