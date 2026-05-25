XUXTADPRT1 ;ESL/JAC/CM - UTL Printing subroutines & extrinsics #1 ; 06/26/2020@9:30
 ;;8.0;KERNEL;**807**;Oct 16, 2024;Build 56;
 ;
 ;
 ; External API'S
 ;
 ; XUXTAD API's
GXDATE(AXUXTADDATE,AXUXTADTIME,AXUXTADSECS,AXUXTADFORMAT) Q $$DATE^XUXTADDT1($G(AXUXTADDATE),$G(AXUXTADTIME),$G(AXUXTADSECS),$G(AXUXTADFORMAT))
DIERR(AXUXTADWIDTH,AXUXTADLFTMAR,AXUXTADMSGROOT,AXUXTADFRMRTN,AXUXTADNOPAUSE) D DIERR^XUXTADDILG($G(AXUXTADWIDTH),$G(AXUXTADLFTMAR),$G(AXUXTADMSGROOT),$G(AXUXTADFRMRTN),$G(AXUXTADNOPAUSE)) Q 
 ; Helper Functions/API's
FMDATE() Q $$DT^XLFDT
FMNOW() Q $$NOW^XLFDT
CNVDT D ^%DT Q
TOLW(AP) X ^%ZOSF($G(AP))
FMDIFF(ATIMEEND,ATIMEBEG,ADS) Q $$FMDIFF^XLFDT($G(ATIMEEND),$G(ATIMEBEG),$G(ADS))
GETS(ADIQGR,ADA,ADR,ADIQGPARM,ADIQGTA,ADIQGERRA,ADIQGIPAR) D GETS^DIQ($G(ADIQGR),$G(ADA),$G(ADR),$G(ADIQGPARM),$G(ADIQGTA),$G(ADIQGERRA),$G(ADIQGIPAR)) Q
 ;
 ;-- Integration Control Registrations
 ; Reference to ^%DT in ICR #10003
 ; Reference to GETS^DIQ in ICR #2056
 ; Reference to ^%ZOSF("RM" in ICR #10096  All nodes exported by Kernel are useable.
 ; Reference to $$FMDIFF^XLFDT in ICR #10103
 ; Reference to $$NOW^XLFDT in ICR #10103
 ;
CENTER(XUXTADTEXT,XUXTADLF,XUXTADRM,XUXTADRVIDEO) ;
 ; Line feed, then write heading (or any text) centered.  Optionally
 ; display the text in reverse video.
 ;
 ;-- Input:
 ;   XUXTADTEXT.. ; Required ; Text to be centered
 ;   XUXTADLF.... ; Optional ; Number of line feeds issued before writing
 ;                         the centered text  (defaults to 1)
 ;   XUXTADRM.....; Right Margin (defaults to IOM)
 ;   XUXTADRVIDEO ; 0 for normal display (default is 0)
 ;              1 to display text in reverse video
 ;-- Output:
 ;   No output variables will be returned.
 ;-- Intended use:
 ;   This API call allows the developer to center text messages
 ;   displayed to the user.  You can optionally control the number
 ;   of line feeds that are issued ...
 ; Example calls:
 ;   D CENTER^XUXTADPRT1("ANYTEXT") ;.. 1 line feed, center text
 ;   D CENTER^XUXTADPRT1("ANYTEXT",2) ; 2 lines before centered text
 ;   D CENTER^XUXTADPRT1("ANYTEXT",2,IOM,1) ;Display text w/reverse video
 ;
 NEW XUXTADCNTLF ; Count of line feeds
 Q:$G(XUXTADTEXT)=""
 S XUXTADLF=$G(XUXTADLF,1)
 S XUXTADRM=$G(XUXTADRM,IOM)
 S XUXTADRVIDEO=$G(XUXTADRVIDEO,0)
 I XUXTADLF>0 F XUXTADCNTLF=1:1:XUXTADLF W !
 W ?(XUXTADRM-$L(XUXTADTEXT))\2
 D:XUXTADRVIDEO REVVIDEO("ON")
 W XUXTADTEXT
 D:XUXTADRVIDEO REVVIDEO("OFF")
 Q  ; CENTER
 ;
CONTINUE(XUXTADLF,XUXTADTYPE) ; Variations of Press <ENTER> to continue.
 ;
 ;-- Input:
 ;   XUXTADLF.. ; Optional
 ;            Number of linefeeds before message (defaults to 2)
 ;   XUXTADTYPE ; Optional
 ;            R ; Press <ENTER> to continue:
 ;            Q ; Press <ENTER> to continue, '^' to quit:
 ;-- Output (can only be set to 1 when XUXTADTYPE="Q"):
 ;   XUXTADQUIT ; 1 if user enters '^'
 ;            0 if user to continue
 ;-- Intended use:
 ;   The purpose of this API is to allow the developer to pause output
 ;   to a video display terminal, give the user a chance to view what
 ;   has been previously displayed, and then allowing the user to
 ;   Press <Enter> to continue, or allow them to '^' to terminate the
 ;   display.
 ;
 ; Example calls:
 ;   D CONTINUE^XUXTADPRT1(2,"R")
 ;   D CONTINUE^XUXTADPRT1(2,"Q") Q:XUXTADQUIT  ; Quit on '^' from user
 ;
 NEW XUXTADCNT,XUXTADREAD,XUXTADDTIME
 Q:$E($G(IOST),1,2)'="C-"
 S XUXTADLF=$G(XUXTADLF,2) ; Default to two line feeds
 S XUXTADDTIME=$S($G(DTIME)>0:DTIME,1:300)
 S:$G(XUXTADTYPE)="" XUXTADTYPE="R"
 ;
 F XUXTADCNT=1:1:+$G(XUXTADLF) W !
 ;
 I XUXTADTYPE="R" D  Q
 . W "Press <ENTER> to continue: "
 . R XUXTADREAD:XUXTADDTIME
 ;
 I XUXTADTYPE="Q" D  Q
 . SET XUXTADQUIT=0 ; Initialize output status flag to successful
 . W "Press <ENTER> to continue, '^' to quit: "
 . R XUXTADREAD:XUXTADDTIME
 . S:'$T XUXTADREAD="^" I XUXTADREAD["^" SET XUXTADQUIT=1 ; User entered '^', quit
 Q:XUXTADQUIT
 Q  ; CONTINUE
 ;
INITPRT ; Initialize printed report variables
 ;-- Input:
 ;   IOM ; (right margin) system variable is expected to be defined
 ;-- Output: - It is *YOUR* responsibility to clean these up after use if not
 ; New the following to start with fresh print variables.
 ;   XUXTADCNT   ; 0 ; Used to count records or transactions
 ;   XUXTADDT    ; Report begin date and time in mm/dd/yy hh:mm format
 ;   XUXTADFLAG1 ; 1 ; First time execution flag, initialized to 1
 ;   XUXTADLINED ; A line of dashes ("-") used for formatting reports
 ;   XUXTADLINEE ; A line of equal signs ("=") used for formatting reports
 ;   XUXTADLINEP ; A line of periods (".") used for formatting reports
 ;   XUXTADLINEU ; A line of underscore characters ("_") used for
 ;             formatting reports
 ;   XUXTADPG    ; 0 ; Page number variable, initialized to zero
 ;   XUXTADQUIT  ; 0 ; Quit flag, initialized to zero
 ; Example:
 ;   ; Start with fresh print variables.
 ;   D INITPRT^XUXTADPRT1 ; Initialize nine standard report variables.
 ;
 ; Count, Page Number, and Quit Flag
 SET (XUXTADCNT,XUXTADPG,XUXTADQUIT)=0
 ;
 SET XUXTADDT=$$GXDATE($$FMNOW(),1,0,1) ; mm/dd/yy hh:mm
 SET $P(XUXTADLINED,"-",IOM+1)="" ;.............. Line of dashes
 SET $P(XUXTADLINEE,"=",IOM+1)="" ;.............. Line of equal signs
 SET $P(XUXTADLINEP,".",IOM+1)="" ;.............. Line of periods
 SET $P(XUXTADLINEU,"_",IOM+1)="" ;.............. Line of underscores
 SET XUXTADFLAG1=1 ;............................. 1st_time_flag
 Q  ; INITPRT
 ;
LINEWRAP(XUXTADVALUE) ; Turn line wrapping off or on ; Used for data extraction
 ;-- Input:
 ;   XUXTADVALUE ; Required ; ON or OFF
 ;   IOM.... ; Required ; Right margin (used when VALUE is ON)
 ;-- Output:
 ;   No output variables will be returned.
 ;-- Intended use:
 ;   The purpose of this call is to provide the developer with a
 ;   simple switch for turning line wrap on or off when they are
 ;   writing file capture routines.  It does this by setting the right
 ;   margin, variable IOM, to zero and executing the ^%ZOSF("RM") call
 ;   to turn off line wrapping.  This will prevent an undesired
 ;   carriage return and line feed.  Then you reset the right margin
 ;   to the original IOM variable when you are finished to restore the
 ;   carriage return and line feeding.
 ; Example call:
 ;   D LINEWRAP^XUXTADPRT1("OFF") ; To avoid line wrap during capture
 ;   ; Write code for data extract here (Example: Import in MS Excel)
 ;   D LINEWRAP^XUXTADPRT1("ON") ;. To reset line wrap after completion
 ;
 NEW X
 ;
 S X=$S(XUXTADVALUE="ON":IOM,1:0) ; 0=Turns wrapping off
 X TOLW("RM") ; Turn wrapping off or reset right margin/turn wrap on
 Q  ; LINEWRAP
 ;
NODATA(XUXTADLF) ; Use for printouts when no data is in ^TMP global
 ;-- Input:
 ;   XUXTADLF ; Optional ; Integer value representing the number of
 ;                     line feeds to issue.
 ;-- Output:
 ;   No output variables will be returned.
 ;-- Intended use:
 ;   This API is typically used when there were no database records
 ;   matching the users input criteria, to let the user know that no
 ;   data was found for their requested criteria.
 ; Example use:
 ;   I '$D(^TMP("XUXTAD",$J)) D  Q  ; If no data in ^TMP(global)
 ;   . D PRINTHD ;............... Print report header
 ;   . D NODATA^XUXTADPRT1 ;........ Display "No data found"
 ;
 ;-- Input:
 ;   XUXTADLF ; Optional ; Number of line feeds (defaults to 2)
 ;
 S XUXTADLF=$G(XUXTADLF,2)
 D CENTER("No data was found for the requested input criteria.",XUXTADLF)
 D CONTINUE(2,"R")
 Q  ; NODATA
 ;
PAGEBRK(XUXTADRTN,XUXTADPG,XUXTADCHKSL,XUXTADNEWPG) ; Generic page break logic
 ;-- Input:
 ;   XUXTADRTN   ; Required ; Name of calling print routine;usually $T(+0)
 ;   XUXTADPG    ; Required ; Represents the page number
 ;   XUXTADCHKSL ; Optional ; 1 will check IOSL for page break
 ;                        0 will ignore the page break check
 ;   XUXTADNEWPG ; Optional ; If 1 forces a page break
 ;-- Output:
 ;   XUXTADQUIT  ; Set to 1 if user enters a '^'.
 ;-- Intended use:
 ;   * Optionally handle check to see if it time for a page break
 ;     using the XUXTADCHKSL input parameter.
 ;   * Automatically handles incrementing of the XUXTADPG (page number)
 ;     variable.  Note: The page number is passed as the second
 ;     parameter and must be passed by reference (see examples below).
 ;   * Optionally force a page break, for example when starting to
 ;     list statistics for a new Division, using the XUXTADNEWPG input
 ;     parameter.
 ; Assumptions:
 ;   * The calling print routine has a label called PRINTHD, which
 ;     is a subroutine for printing the report headers and any column
 ;     headers that may be needed.
 ; Example uses:
 ; 1.; Add the following line before writing a new line
 ;   ;     to check for page break and if appropriate print report
 ;   ;     headers after form feed and page number increment
 ;   D PAGEBRK^XUXTADPRT1($T(+0),.XUXTADPG) Q:XUXTADQUIT
 ;
 ; 2.; Add the following line to force a page break and print the
 ;   ;     report header.  Use this line at the beginning of printing
 ;   ;     your report for producing your first page (with headers).
 ;   D PAGEBRK^XUXTADPRT1($T(+0),.XUXTADPG,0,1) Q:XUXTADQUIT
 ;
 S XUXTADNEWPG=$G(XUXTADNEWPG,0) ;.... Default, does NOT force a page break
 S XUXTADCHKSL=$G(XUXTADCHKSL,1) ;.... Default, check for page break
 I XUXTADCHKSL,$Y'>(IOSL-5) Q  ;.. If it's not time for a page break, quit
 ;
 ; Press <ENTER> to continue or '^' to quit
 ;
 I XUXTADPG D CONTINUE(2,"Q") Q:XUXTADQUIT  ;. Quit on user '^'
 I XUXTADPG!XUXTADNEWPG!($E(IOST)="C") W @IOF ;Issue form feed
 S XUXTADPG=XUXTADPG+1 ;...................... Increment page number
 ;
 D @("PRINTHD^"_XUXTADRTN) ; --> Print report header from calling routine <--
 Q  ; PAGEBRK
 ;
PROCTIME(XUXTADTIMEBEG,XUXTADTIMEEND) ; Display the amount of processing time for the rpt
 ;-- Input:
 ;   XUXTADTIMEBEG ; Required ; Begin date & time (internal FM format)
 ;   XUXTADTIMEEND ; Optional ; End   date & time (internal FM format)
 ;-- Output:
 ;   No output variables will be returned.
 ;-- Intended use:
 ;   To provide the developer with an easy way to display the amount
 ;   of execution time that took place during routine processing, or
 ;   during a FileMan print utility.
 ; Example calls:
 ;   1. D PROCTIME^XUXTADPRT1(XUXTADDTBEG) ;Optional XUXTADTIMEEND defaults to $$NOW^XLFDT()
 ;   2. D PROCTIME^XUXTADPRT1(XUXTADDTBEG,XUXTADDTEND) ;Begin & End date/times passed
 ;   3. Example for use in a D EN1^DIP1 (FM print utility) call:
 ;      PROCTIME  ;
 ;             D PROCTIME^XUXTADPRT1
 ;             Q
 ;             ;Now the EN1^DIP1 portion, a programmer hook at the end
 ;             S DIOEND="D PROCTIME^"_$T(+0)_"("_$$NOW^XLFDT()_")"
 ;             ... the rest of your input variable for EN1^DIP
 ;             D EN1^DIP
 ; Example output:
 ;    PROCESSING TIME:  MINS: 1  XUXTADSECS: 2  (04/23/13 13:42)
 ;
 NEW %,XUXTADDAYS,XUXTADDIFF,XUXTADHRS,XUXTADMINS,XUXTADSECS
 NEW %DT,A1,DDH,DTOUT,DUOUT,X,Y
 ;
 S XUXTADTIMEEND=$G(XUXTADTIMEEND,$$FMNOW())
 ;
 ; If  XUXTADTIMEBEG and/or XUXTADTIMEEND are not valid FM internal dates
 ;     quit without displaying anything
 ; Else
 ;     Calculate the processing time, store in XUXTADDIFF variable
 ;     using internal FM format.
 ;
 S %DT="ST"
 S X=XUXTADTIMEBEG
 KILL Y D CNVDT I Y=-1!($P(XUXTADTIMEBEG,".")'?7N) Q
 S X=XUXTADTIMEEND
 KILL Y D CNVDT I Y=-1!($P(XUXTADTIMEEND,".")'?7N) Q
 ;
 S XUXTADDIFF=$$FMDIFF(XUXTADTIMEEND,XUXTADTIMEBEG,3) ; Returns: DD HH:MM:SS
 ;
 ; Convert processing time to external format and display results
 ;
 S XUXTADDAYS=$P(XUXTADDIFF," ")
 S XUXTADHRS=$P($P(XUXTADDIFF," ",2),":")
 S XUXTADMINS=$P($P(XUXTADDIFF," ",2),":",2)
 S XUXTADSECS=$P($P(XUXTADDIFF," ",2),":",3)
 S:XUXTADSECS="" XUXTADSECS=1
 W !!," PROCESSING TIME:"
 W:XUXTADDAYS " DAYS: ",XUXTADDAYS
 W:XUXTADHRS "  HOURS: ",XUXTADHRS
 W:XUXTADMINS "  MINS: ",XUXTADMINS
 W:XUXTADSECS "  SECS: ",XUXTADSECS
 ;
 W "  (",$$GXDATE($$FMNOW(),1),")" ; Display end time
 Q  ; PROCTIME
 ;
REVVIDEO(XUXTADVALUE) ; Turn REVERSE VIDEO on or off depending upon ENVALUE
 ;-- Input:
 ;   VALUE   ; Required ; Should be a value of 'ON' or 'OFF'
 ;   IOST(0) ; Required ; IEN of the current device terminal type
 ;-- Output:
 ;   No output variables will be returned.
 ; Example calls:
 ;   D REVVIDEO^XUXTADPRT1("ON")
 ;   ; Write 'text' and/or variable(s) here
 ;   D REVVIDEO^XUXTADPRT1("OFF")
 ;
 NEW DIERR,XUXTADIENS,XUXTADQUIT,XUXTADTT,XUXTADRVDOFF,XUXTADRVDON
 ;
 S XUXTADIENS=+$G(IOST(0))_"," Q:$P(XUXTADIENS,",")'>0
 D GETS(3.2,XUXTADIENS,"14;15","E","XUXTADTT")
 D DIERR(60,5,"XUXTADERROR","REVVIDEO^"_$T(+0)) Q:XUXTADQUIT
 S XUXTADRVDON=XUXTADTT(3.2,XUXTADIENS,14,"E")
 S XUXTADRVDOFF=XUXTADTT(3.2,XUXTADIENS,15,"E")
 ;
 I XUXTADVALUE="ON",XUXTADRVDON]"" W @(XUXTADRVDON) Q
 I XUXTADVALUE="OFF",XUXTADRVDOFF]"" W @(XUXTADRVDOFF) Q
 Q  ; REVVIDEO
 ;
 ;XUXTADPRT1 ;ESL/JAC/cm - UTL Printing subroutines & extrinsics #1 ; 06/26/2020  09:30
