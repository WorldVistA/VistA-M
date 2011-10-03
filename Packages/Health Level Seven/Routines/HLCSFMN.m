HLCSFMN ;ALB/JRP - INCOMING/OUTGOING FILER MONITOR;19-MAY-95 ;06/25/97  15:03
 ;;1.6;HEALTH LEVEL SEVEN;**15,30**;Oct 13, 1995
MONITOR ;Main entry point
 ;Declare variables
 N INFILER,OUTFILER,INCOUNT,OUTCOUNT,INTOP,OUTTOP,STOP
 N X S X=0 X ^%ZOSF("RM")
 ; Turn off terminal line wrap
 S (INTOP,OUTTOP)=0
 ;Get screen attributes used
 D GETATTR^HLCSFMN1
 ;Initial clear screen
 W @IOF
 ;Continually display updated information until user chooses to quit
 F  S STOP=0 D  Q:(STOP)
 .;Get incoming filer information
 .S INCOUNT=$$GETINFO^HLCSFMN1("IN","INFILER")
 .;Set pointer to top of filer lists - if needed
 .S:('INTOP) INTOP=+$O(INFILER(""))
 .;Get outgoing filer information
 .S OUTCOUNT=$$GETINFO^HLCSFMN1("OUT","OUTFILER")
 .;Set pointer to top of filer lists - if needed
 .S:('OUTTOP) OUTTOP=+$O(OUTFILER(""))
 .;Display incoming filer information
 .D DISPLAY("IN","INFILER",INCOUNT,INTOP)
 .;Display outgoing filer information
 .D DISPLAY("OUT","OUTFILER",OUTCOUNT,OUTTOP)
 .;Prompt/execute action
 .S STOP=$$PROMPT^HLCSFMN0()
 ;Delete screen attributes
 S X=IOM X ^%ZOSF("RM")
 ; Turn terminal line wrap back on
 D KILL^%ZISS
 Q
DISPLAY(FLRTYPE,ARRAY,COUNT,PTRTOP) ;Display filer information
 ;INPUT  : FLRTYPE - Flag indicating type of filer header is for
 ;                   IN = Incoming filer (default)
 ;                   OUT = Outgoing filer
 ;         ARRAY - Array containing filer information (full global ref)
 ;           ARRAY(PtrSubEntry) = TaskNumber ^ Last$H ^ StopFlag ^
 ;                                Printable$H ^ ErrorMessage
 ;             PtrSubEntry = Pointer to subentry in file 869.3
 ;             TaskNumber = Task number of filer
 ;             Last$H = Last known $H (field #.03 of subentry)
 ;             StopFlag = Whether or not filer has been asked to stop
 ;                        (field #.02 of subentry)
 ;                          Yes - Filer has been asked to stop
 ;                          No - Filer has not been asked to stop
 ;                          Error - Task stopped due to error
 ;             Printable$H = Last$H in printable format
 ;             ErrorMessage = Printable error message - only used when
 ;                            task stopped due to error
 ;         COUNT - Number of filers running
 ;                 Defaults to 0
 ;         PTRTOP - Pointer to first filer in list to display
 ;                  Defaults to 0
 ;         The following screen attributes
 ;            IOINORM, IOINHI, IOUON, IOUOFF, IOBON, IOBOFF
 ;            IORVON, IORVOFF, IOF, IOHOME, IOELEOL
 ;OUTPUT : None
 ;
 ;Check input
 S FLRTYPE=$G(FLRTYPE)
 S:(FLRTYPE'="OUT") FLRTYPE="IN"
 Q:($G(ARRAY)="")
 S COUNT=+$G(COUNT)
 S PTRTOP=+$G(PTRTOP)
 ;Declare variables
 N PTRSUB,LOOP,FLRINFO,LASTDH,ASK2STOP,TASKNUM,ERRMSG
 N DAY,TIME,HOUR,MIN,SEC,PASTTOL,BLANKS,FLRDH,TMP
 S BLANKS=$J(" ",20)
 ;Incoming filer is at top of screen
 I (FLRTYPE="IN") D
 .;Check for IOHOME & IOELEOL - used to keep from clearing screen
 .W:((IOHOME'="")&(IOELEOL'="")) IOHOME
 .;IOHOME & IOELEOL can't be used - clear screen
 .W:((IOHOME="")!(IOELEOL="")) @IOF
 .W IOELEOL,!
 ;Display filer information
 D HEADER^HLCSFMN0(FLRTYPE)
 I ('COUNT) D  Q
 .;No filers running
 .W IOBON,IOINHI,"** No "
 .W $S(FLRTYPE="OUT":"outgoing",1:"incoming")
 .W " filers are running **",IOBOFF,IOINORM
 .W IOELEOL,!,IOELEOL,!,IOELEOL,!,IOELEOL,!
 .;Whitespace between display areas - use less if dashes where used
 .; in header
 .W:((IOUON'="")&(IOUOFF'="")) IOELEOL,!,IOELEOL,!
 .W:((IOUON="")!(IOUOFF="")) IOELEOL,!
 ;Loop through filers (print no more than 4)
 ;  Back up one entry in list so that pointer to top entry is
 ;  first entry displayed
 S PTRSUB=+$O(@ARRAY@(PTRTOP),-1)
 F LOOP=1:1:4 S PTRSUB=+$O(@ARRAY@(PTRSUB)) Q:('PTRSUB)  D
 .;Get info from array
 .S FLRINFO=@ARRAY@(PTRSUB)
 .;Get task number
 .S TASKNUM=$P(FLRINFO,"^",1)
 .;Get last known $H
 .S FLRDH=$P(FLRINFO,"^",2)
 .;Get asked to stop flag
 .S ASK2STOP=$P(FLRINFO,"^",3)
 .;Get printable last known $H
 .S LASTDH=$P(FLRINFO,"^",4)
 .;Get error message
 .S ERRMSG=$P(FLRINFO,"^",5)
 .;Calculate time difference
 .S TMP=$$DIFFDH^HLCSFMN1(FLRDH,$H)
 .S DAY=+TMP
 .S TIME=$P(TMP,"^",2)
 .S HOUR=$P(TIME,":",1)
 .S MIN=$P(TIME,":",2)
 .S SEC=$P(TIME,":",3)
 .;Last known $H not set yet
 .I (FLRDH="") D
 ..S LASTDH="--------- @ --:--:--"
 ..S DAY="-"
 ..S (HOUR,MIN,SEC)="--"
 .;Print information
 .; Print task number
 .W TASKNUM,$E(BLANKS,1,(15-$L(TASKNUM)+3))
 .;Print stop flag
 .W ASK2STOP,$E(BLANKS,1,(7-$L(ASK2STOP)+3))
 .;Problem with task - error message defined
 .I (ERRMSG'="") D  Q
 ..;Not an error with task - don't use special attributes
 ..I (ASK2STOP'="Error") W ERRMSG,IOELEOL,! Q
 ..W IOELEOL S DX=0,DY=$Y X ^%ZOSF("XY") W IOINHI,IOBON,ERRMSG,IOBOFF,IOINORM,!
 .;Task still running - determine if time difference is within
 .; tolerance level
 .S PASTTOL=0
 .S:((DAY)!(HOUR)!(MIN>9)) PASTTOL=1
 .;Bold on (if outside tolerance level)
 .W:(PASTTOL) IOINHI
 .;Print last known $H
 .W LASTDH,$E(BLANKS,1,3)
 .;Print time lapse
 .W IOELEOL S DX=0,DY=$Y X ^%ZOSF("XY") W DAY," Day  ",HOUR," Hr  ",MIN," Min  ",SEC," Sec",!
 .;Bold off (if outside tolerance level)
 .W:(PASTTOL) IOINORM
 ;End of list reached
 I ((LOOP'=4)!('PTRSUB)) D
 .W IORVON,"[End of list - total of ",COUNT,"]",IORVOFF,IOELEOL,!
 .F TMP=1:1:(4-LOOP) W IOELEOL,!
 ;Whitespace between display areas - use less if dashes where used
 ; in header
 W:((IOUON'="")&(IOUOFF'="")) IOELEOL,!,IOELEOL,!
 W:((IOUON="")!(IOUOFF="")) IOELEOL,!
 Q
