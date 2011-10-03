HLCSFMN1 ;ALB/JRP - UTILITIES FOR FILER MONITOR;18-MAY-95
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
GETINFO(FLRTYPE,OUTARR) ;Get filer information
 ;INPUT  : FLRTYPE - Flag indicating type of filer to get info on
 ;                   IN = Incoming filer (default)
 ;                   OUT = Outgoing filer
 ;         OUTARR - Array to put filer information into (full global ref)
 ;OUTPUT : X - Number of outgoing filers running
 ;         OUTARR(PtrSubEntry) = TaskNumber ^ Last$H ^ StopFlag ^
 ;                               Printable$H ^ ErrorMessage
 ;           PtrSubEntry = Pointer to subentry in file 869.3
 ;           TaskNumber = Task number of filer
 ;           Last$H = Last known $H (field #.03 of subentry)
 ;           StopFlag = Whether or not filer has been asked to stop
 ;                      (field #.02 of subentry)
 ;                      Yes - Filer has been asked to stop
 ;                      No - Filer has not been asked to stop
 ;                      Error - Task stopped due to error
 ;           Printable$H = Last$H in printable format
 ;           ErrorMessage = Printable error message - only used when
 ;                          task stopped due to error
 ;NOTES  : OUTARR() will be initialized (KILLed) on entry
 ;
 ;Check input
 Q:($G(OUTARR)="") 0
 S FLRTYPE=$G(FLRTYPE)
 S:(FLRTYPE'="OUT") FLRTYPE="IN"
 ;Declare variables
 N PTRSUB,FLRINFO,FLRDH,PRTDH,STOPFLAG,COUNT,ZTSK,TMP
 ;Get filer data
 K @OUTARR
 D GETFLRS^HLCSUTL2(FLRTYPE,OUTARR)
 ;Count number of filers
 S PTRSUB=""
 F COUNT=0:1 S PTRSUB=+$O(@OUTARR@(PTRSUB)) Q:('PTRSUB)  D
 .;Convert data
 .S FLRINFO=@OUTARR@(PTRSUB)
 .;Convert stop flag to printable format
 .S STOPFLAG=+$P(FLRINFO,"^",3)
 .S $P(FLRINFO,"^",3)=$S(STOPFLAG:"Yes",1:"No")
 .;Convert $H to printable format
 .S FLRDH=$P(FLRINFO,"^",2)
 .S PRTDH=""
 .S:(FLRDH'="") PRTDH=$$DH4PRT(FLRDH)
 .S $P(FLRINFO,"^",4)=PRTDH
 .;Get task's status
 .K ZTSK
 .S ZTSK=+FLRINFO
 .D STAT^%ZTLOAD
 .;Problem with task
 .I (ZTSK(1)'=2) D
 ..;Determine error message
 ..S TMP=$S(FLRTYPE="OUT":"Outgoing ",1:"Incoming ")
 ..;Task no longer defined
 ..S:(ZTSK(1)=0) TMP="** "_TMP_"filer is no longer defined **"
 ..;Task hasn't started yet
 ..S:(ZTSK(1)=1) TMP=TMP_"filer has not started yet"
 ..;Task finished
 ..S:(ZTSK(1)=3) TMP=TMP_"filer stopped but didn't delete itself"
 ..;Task not scheduled
 ..S:(ZTSK(1)=4) TMP="** "_TMP_"filer has not been [re]scheduled **"
 ..;Task errored out
 ..S:(ZTSK(1)=5) TMP="** "_TMP_"filer has stopped due to error **"
 ..;Store error message
 ..S $P(FLRINFO,"^",5)=TMP
 ..;Use 'Error' for stop flag - don't change if filer hasn't started yet
 ..S:(ZTSK(1)'=1) $P(FLRINFO,"^",3)="Error"
 .;Store converted data
 .S @OUTARR@(PTRSUB)=FLRINFO
 ;Return info
 Q COUNT
DIFFDH(DH1,DH2) ;DETERMINE DIFFERENCES BETWEEN TWO VALUES OF $H
 ;INPUT  : DH1 - Beginning $H (defaults to current $H)
 ;         DH2 - Ending $H (defaults to current $H)
 ;OUTPUT : Days ^ Time
 ;           Days = Number of days between DH1 & DH2
 ;           Time = Rest of time between DH1 & DH2 => HH:MM:SS
 ;NOTES  : Difference calculated by subtracting DH1 from DH2
 ;
 ;Check input
 S DH1=$G(DH1)
 S:(DH1="") DH1=$H
 S DH2=$G(DH2)
 S:(DH2="") DH2=$H
 ;Declare variables
 N DAY1,DAY2,DAYDIF,TIME1,TIME2,TIMEDIF,NEGATE,%
 ;Break out day & seconds from $H
 S DAY1=+$P(DH1,",",1)
 S DAY2=+$P(DH2,",",1)
 S TIME1=+$P(DH1,",",2)
 S TIME2=+$P(DH2,",",2)
 ;Make sure DH2 is after DH1
 S NEGATE=0
 I ((DAY1>DAY2)!((DAY1=DAY2)&(TIME1>TIME2))) D
 .;Switch date/time
 .S NEGATE=DAY2
 .S DAY2=DAY1
 .S DAY1=NEGATE
 .S NEGATE=TIME2
 .S TIME2=TIME1
 .S TIME1=NEGATE
 .;Negate answer when done
 .S NEGATE=1
 ;Determine day difference
 S DAYDIF=DAY2-DAY1
 ;Determine time difference
 ;Same day - just subtract time
 S:('DAYDIF) TIMEDIF=TIME2-TIME1
 ;Different day - special case exists
 I (DAYDIF) D
 .;Seconds not different by 24 hours
 .I (TIME2<TIME1) D  Q
 ..;Convert one day from difference to seconds
 ..S DAYDIF=DAYDIF-1
 ..;Add to ending time
 ..S TIME2=TIME2+86400
 ..;Subtract times
 ..S TIMEDIF=TIME2-TIME1
 .;Seconds different by 24 hours
 .S TIMEDIF=TIME2-TIME1
 ;Convert seconds to time
 S %=TIMEDIF
 D S^%DTC
 S %=%_"000000"
 S TIMEDIF=$E(%,2,3)_":"_$E(%,4,5)_":"_$E(%,6,7)
 ;Negate results (if needed)
 I (NEGATE) D
 .S DAYDIF=0-DAYDIF
 .;Don't negate 00:00:00
 .F %=1:1:4 Q:($P(TIMEDIF,":",%))
 .S:(%'=4) TIMEDIF="-"_TIMEDIF
 Q DAYDIF_"^"_TIMEDIF
DH4PRT(DH) ;CONVERT $H TO PRINTABLE FORMAT
 ;INPUT  : DH - $H (defaults to current $H)
 ;OUTPUT : Printable format of $H => DD-MMM-YY @ HH:MM:SS
 ;
 ;Check input
 S DH=$G(DH)
 S:(DH="") DH=$H
 ;Declare variables
 N %H,Y,X,%,CNVDATE,CNVTIME
 ;Convert $H to external format
 S %H=DH
 D YX^%DTC
 ;Convert to print format
 S CNVDATE=$P(Y,"@",1)
 S %=%_"000000"
 S CNVTIME=$E(%,2,3)_":"_$E(%,4,5)_":"_$E(%,6,7)
 S Y=$E(X,6,7)_"-"_$P(CNVDATE," ",1)_"-"_$E(X,2,3)_" @ "_CNVTIME
 Q Y
GETATTR ;GET SCREEN ATTRIBUTES USED BY MONITOR
 ;INPUT  : IOST(0) - Terminal type [as set by entry into DHCP]
 ;OUTPUT : The following screen attributes will be defined
 ;           IOINORM - Normal intensity
 ;           IOINHI  - High Intensity (bold)
 ;           IOUON   - Underline on
 ;           IOUOFF  - Underline off
 ;           IOBON   - Blink on
 ;           IOBOFF  - Blink off
 ;           IORVON  - Reverse video on
 ;           IORVOFF - Reverse video off
 ;           IOHOME - Move cursor to home
 ;           IOELEOL - Erase from cursor to end of line
 ;
 ;NOTES  : If IOST(0) is not defined, a call to HOME^%ZIS will be made
 ;
 ;Check for IOST(0)
 D:('$D(IOST(0))) HOME^%ZIS
 ;Declare variables
 N X
 ;Get screen attributes
 S X="IOINORM;IOINHI;IOUON;IOUOFF;IOBON;IOBOFF;IORVON;IORVOFF;IOHOME;IOELEOL"
 D ENDR^%ZISS
 Q
