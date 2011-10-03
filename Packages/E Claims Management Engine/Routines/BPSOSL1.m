BPSOSL1 ;BHAM ISC/FCS/DRS/DLF - log file printing ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;  Two entry points:
 ;    PRINTLOG to print the log file, given the LOG
 ;    PRINTDAT(type,start,end) prints all log files of the given
 ;      type in the given date range.  It prompts for missing parameters.
 ;
 ; PRINTDAT - Display Communication Log
 ; Input
 ;   TYPE  - Type of Communication Log.  If not specified, prompt
 ;   START - Start Date.  If not specified, prompt
 ;   END   - End Date.  If not specified, use START
PRINTDAT(TYPE,START,END) ;
 I '$D(TYPE) S TYPE=$$GETTYPE Q:'TYPE
 W !
 I $D(START) D
 . I '$D(END) S END=START
 E  D  Q:'START
 . S START=$$GETDATES,END=$P(START,U,2),START=$P(START,U)
 N POP D ^%ZIS Q:$G(POP)
 N FORDATE,STOP
 S FORDATE=START,STOP=0
 F  D  Q:FORDATE>END!STOP
 . N SLOT,EXISTS
 . S SLOT=FORDATE+(TYPE/10),EXISTS=$$EXISTS(SLOT)
 . I EXISTS D PRINTLOG(SLOT,.STOP)
 . I 'EXISTS  W "There is no log file ",SLOT,! H .25
 . S FORDATE=$$TADD^BPSOSUD(FORDATE,1) ; add one day
 D ^%ZISC
 Q
 ;
GETDATES() ; Return start^end
 N PROMPT1 S PROMPT1="Starting date: "
 N PROMPT2 S PROMPT2="  Ending date: "
 N DEF1,DEF2 S (DEF1,DEF2)=DT
 Q $$DTR^BPSOSU1(PROMPT1,PROMPT2,DEF1,DEF2,"")
 ;
 ; Currently, we only have one communication log, which is .5=winnowing
 ;   so we will return that.  Kept old code that allowed a selection in
 ;   case we add other logs again
GETTYPE() ; Return log type
 Q 5
 N PROMPT S PROMPT="Which log file? "
 N DEF S DEF=5
 N MODE S MODE="V"
 N MENU S MENU="5:Winnowing;"
 Q $$SET^BPSOSU3(PROMPT,DEF,1,MODE,MENU)
 ;
 ; PRINTLOG - Print a log
 ; Input
 ;   SLOT - Log to display
 ;   STOP - If user quit from the display
PRINTLOG(SLOT,STOP) ; EP - Above and BPSOS6M
 ;
 ; Validate parameters
 I '$G(SLOT) Q
 ;
 ; Initialize variables
 N IEN,LEN,UPDT,SEQ,UPDT,TEXT
 N PREVDATE,PREVTIME,EXDTTM
 ;
 ; Set IEN for the slot.  If it does not exist, display message and quit
 S IEN=$$EXISTS(SLOT)
 I 'IEN W "Nothing in SLOT=",SLOT,! Q
 ;
 ; Do the Header
 I $Y D HDR
 ;
 ; Loop through text and display
 S (PREVDATE,PREVTIME)="",STOP=0,LEN=$S($G(IOM):IOM,1:80)-10-1
 S UPDT="" F  S UPDT=$O(^BPS(9002313.12,IEN,10,"B",UPDT)) Q:UPDT=""  D  Q:STOP
 . S SEQ="" F  S SEQ=$O(^BPS(9002313.12,IEN,10,"B",UPDT,SEQ)) Q:SEQ=""  D  Q:STOP
 .. S TEXT=$P($G(^BPS(9002313.12,IEN,10,SEQ,1)),U,1)
 .. S EXDTTM=$$FMTE^XLFDT(UPDT,1)
 .. I PREVDATE'=$P(UPDT,".",1) D
 ... S PREVDATE=$P(UPDT,".",1)
 ... W !,$P(EXDTTM,"@",1),!
 .. I $P(UPDT,".",2)'=PREVTIME D
 ... S PREVTIME=$P(UPDT,".",2)
 ... W $P(EXDTTM,"@",2)
 .. N I F I=1:LEN:$L(TEXT) D  Q:STOP
 ... I I>1 W ?6,"..."
 ... W ?10,$E(TEXT,I,I+LEN-1),!
 ... D EOP
 Q
 ;
EOP ; end of page handling
 ; set STOP if the user wants to get out
 S STOP=$$EOPQ^BPSOSU8(2,,"D HDR^"_$T(+0))
 Q
 ;
HDR W @IOF,"Log file #",SLOT,!
 Q
 ;
 ; Get internal number for the slot
EXISTS(SLOT) ; EP - Above and BPSOS6M
 I $G(SLOT)="" Q ""
 Q $O(^BPS(9002313.12,"B",SLOT,""))
 ;
