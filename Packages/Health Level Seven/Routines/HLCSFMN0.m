HLCSFMN0 ;ALB/JRP - INCOMING/OUTGOING FILER MONITOR;19-MAY-95 ;10/15/99  06:57
 ;;1.6;HEALTH LEVEL SEVEN;**15,57**;Oct 13, 1995
HEADER(FLRTYPE) ;Display column header
 ;INPUT  : FLRTYPE - Flag indicating type of filer header is for
 ;                   IN = Incoming filer (default)
 ;                   OUT = Outgoing filer
 ;         The following screen attributes:
 ;           IOELEOL, IOUON, IOUOFF
 ;OUTPUT : None
 ;NOTES  : Existance of IOUON & IOUOFF is assumed
 ;       : Header begins on current line (i.e. calling application
 ;         must put cursor at beginning of line)
 ;       : Cursor will be put at the beginning of line after header
 ;         when completed
 ;
 ;Check input
 N X S X=0 X ^%ZOSF("RM")
 ;Turn off terminal line wrap
 S FLRTYPE=$G(FLRTYPE)
 N WHTESPCE,DASHES
 ;Set whitespace between columns
 S WHTESPCE=$J(" ",3)
 ;Convert filer type to long format
 S FLRTYPE=$S(FLRTYPE="OUT":"Outgoing",1:"Incoming")
 ;Print column headers
 W "Task Number of ",WHTESPCE,"Asked"
 W IOELEOL,!
 W IOUON,FLRTYPE," Filer ",IOUOFF,WHTESPCE
 W IOUON,"To Stop",IOUOFF,WHTESPCE
 W IOUON,"Last Known Date/Time",IOUOFF,WHTESPCE
 W IOUON,"Time Difference",$J(" ",13),IOUOFF
 W IOELEOL,!
 ;Screen attributes have no value - print dashes
 I ((IOUON'="")&(IOUOFF'="")) S X=IOM X ^%ZOSF("RM") QUIT
 ;Turn terminal line wrap back on
 ;Set longest set of dashes used
 S DASHES=$TR($J(" ",28)," ","-")
 ;Print dashes
 W $E(DASHES,1,15),WHTESPCE,$E(DASHES,1,7),WHTESPCE
 W $E(DASHES,1,20),WHTESPCE,DASHES
 W IOELEOL,!
 S X=IOM X ^%ZOSF("RM")
 ;Turn terminal line wrap back on
 Q
PROMPT() ;Prompt user for action and execute the selected action
 ;INPUT  : INFILER(PtrSubEntry) = TaskNumber ^ Last$H ^ StopFlag ^
 ;                                Printable$H ^ ErrorMessage
 ;         OUTFILER(PtrSubEntry) = TaskNumber ^ Last$H ^ StopFlag ^
 ;                                 Printable$H ^ ErrorMessage
 ;           PtrSubEntry = Pointer to subentry in file 869.3
 ;           TaskNumber = Task number of filer
 ;           Last$H = Last known $H (field #.03 of subentry)
 ;           StopFlag = Whether or not filer has been asked to stop  
 ;                      (field #.02 of subentry)
 ;                        Yes - Filer has been asked to stop
 ;                        No - Filer has not been asked to stop
 ;                        Error - Task stopped due to error
 ;           Printable$H = Last$H in printable format
 ;           ErrorMessage = Printable error message - only used when
 ;                          task stopped due to error
 ;         INTOP = Pointer to first incoming filer in list to display
 ;         OUTTOP = Pointer to first outgoing filer in list to display
 ;         The following screen attributes
 ;            IOINORM, IOINHI, IOELEOL
 ;OUTPUT : 0 = User didn't choose to quit
 ;         1 = User choose to quit
 ;         INTOP & OUTTOP will be adjusted accordingly
 ;           NEXT action - INTOP & OUTTOP will be moved down 4 entries
 ;                         in the list.  If the end of a list is
 ;                         reached, INTOP/OUTTOP will be set to the
 ;                         last entry in the list.
 ;           BACKUP action - INTOP & OUTTOP will be moved up 4 entries
 ;                           in the list.  If the top of a list is
 ;                           reached, INTOP/OUTTOP will be set to the
 ;                           first entry in the list.
 ;           START actions - INTOP & OUTTOP will not be changed
 ;           STOP actions - INTOP & OUTTOP will not be changed
 ;           DELETE actions - INTOP & OUTTOP will not be changed
 ;NOTES  : Prompt will be displayed at current cursor position
 ;       : All input is assumed
 ;       : When the STOP action is choosen, the first filer in the
 ;         list of filers will be stopped
 ;
 ;Declare variables
 N ANS,ANS1,LOOP,TMP,ARRAYREF,TMPARR,NEWTOP
 ;Turn off terminal line wrap
 N X S X=0 X ^%ZOSF("RM")
 ;Display prompt
 W "(",IOINHI,"+I",IOINORM,") Start incoming filer  "
 W "(",IOINHI,"-I",IOINORM,") Stop incoming filer  "
 W "(",IOINHI,"*I",IOINORM,") Delete incoming filer"
 W IOELEOL,!
 W "(",IOINHI,"+O",IOINORM,") Start outgoing filer  "
 W "(",IOINHI,"-O",IOINORM,") Stop outgoing filer  "
 W "(",IOINHI,"*O",IOINORM,") Delete outgoing filer"
 W IOELEOL,!
 W " (",IOINHI,"N",IOINORM,") Next 4 lines in list  "
 W " (",IOINHI,"B",IOINORM,") Back 4 lines in list "
 W " (",IOINHI,"Q",IOINORM,") Quit"
 W IOELEOL,!
 W "Type selection: ",IOELEOL
 ;Get users response
 R ANS#1:5 Q:('$T) 0
 ;User hit <RET>
 Q:(ANS="") 0
 ;User choose to quit
 I ("Qq^"[ANS) D  Q 1
 .;Echo rest of response
 .W:(ANS="Q") "UIT"
 .W:(ANS="q") "uit"
 .W:(ANS="^") " QUIT"
 .H 1
 ;NEXT action
 I ("Nn"[ANS) D  Q 0
 .;Echo rest of response
 .W:(ANS="N") "EXT"
 .W:(ANS="n") "ext"
 .H 1
 .F ARRAYREF="INFILER","OUTFILER" D
 ..;Move down 4 entries in list
 ..S NEWTOP=$S(ARRAYREF="INFILER":INTOP,1:OUTTOP)
 ..F LOOP=1:1:4 S NEWTOP=+$O(@ARRAYREF@(NEWTOP)) Q:('NEWTOP)
 ..;Went past bottom of list - set to last entry in list
 ..I ('NEWTOP) S NEWTOP="" S NEWTOP=+$O(@ARRAYREF@(NEWTOP),-1)
 ..;Save new value into appropriate variable
 ..S:(ARRAYREF="INFILER") INTOP=NEWTOP
 ..S:(ARRAYREF="OUTFILER") OUTTOP=NEWTOP
 ;BACKUP action
 I ("Bb"[ANS) D  Q 0
 .;Echo rest of response
 .W:(ANS="B") "ACKUP"
 .W:(ANS="b") "ackup"
 .H 1
 .F ARRAYREF="INFILER","OUTFILER" D
 ..;Move up 4 entries in list
 ..S NEWTOP=$S(ARRAYREF="INFILER":INTOP,1:OUTTOP)
 ..F LOOP=1:1:4 S NEWTOP=+$O(@ARRAYREF@(NEWTOP),-1) Q:('NEWTOP)
 ..;Went past top of list - set to first entry in list
 ..I ('NEWTOP) S NEWTOP="" S NEWTOP=+$O(@ARRAYREF@(NEWTOP))
 ..;Save new value into appropriate variable
 ..S:(ARRAYREF="INFILER") INTOP=NEWTOP
 ..S:(ARRAYREF="OUTFILER") OUTTOP=NEWTOP
 ;START/STOP/DELETE action
 I ("+-*"[ANS) D  Q 0
 .;Remember action
 .S ANS1=ANS
 .;Get type of filer
 .R ANS#1:3 Q:('$T)
 .;Invalid response
 .S ANS=$TR(ANS,"io","IO")
 .Q:("IO"'[ANS)
 .;Echo complete selection
 .W "  ",$S(ANS1="+":"START",ANS1="-":"STOP",1:"DELETE")," "
 .W $S(ANS="O":"OUTGOING",1:"INCOMING")," FILER"
 .H 1
 .;START action
 .I (ANS1="+") D  Q
 ..;Start incoming filer
 ..I (ANS="I") S TMP=$$TASKFLR^HLCS1("IN")
 ..;Start outgoing filer
 ..I (ANS="O") S TMP=$$TASKFLR^HLCS1("OUT")
 .;STOP action
 .I (ANS1="-") D  Q
 ..S ARRAYREF=$S(ANS="I":"INFILER",1:"OUTFILER")
 ..;Get first filer in list that hasn't been asked to stop
 ..S TMP=0
 ..F  S TMP=+$O(@ARRAYREF@(TMP)) Q:('TMP)  Q:($P(@ARRAYREF@(TMP),"^",3)="No")
 ..;No filer to stop
 ..Q:('TMP)
 ..;Stop incoming filer
 ..I (ANS="I") D STOPFLR^HLCSUTL1(TMP,"IN")
 ..;Stop outgoing filer
 ..I (ANS="O") D STOPFLR^HLCSUTL1(TMP,"OUT")
 .;DELETE action
 .S ARRAYREF=$S(ANS="I":"INFILER",1:"OUTFILER")
 .;Find all tasks that have stopped due to error
 .K TMPARR
 .S LOOP=0
 .F  S LOOP=+$O(@ARRAYREF@(LOOP)) Q:('LOOP)  D
 ..;Make sure task stopped due to error
 ..S TMP=@ARRAYREF@(LOOP)
 ..Q:($P(TMP,"^",3)'="Error")
 ..;Get task number
 ..S TMP=+TMP
 ..;Store by task number
 ..S TMPARR(TMP)=LOOP
 .;No selection required
 .Q:('$O(TMPARR("")))
 .;Make selection - autoselects on single entry
 .S TMP=$$SELECT^HLCSFMN2("TMPARR","filer task number")
 .;Delete selection
 .I (TMP>0) D
 ..;Delete incoming filer
 ..I (ANS="I") D DELFLR^HLCSUTL1(TMPARR(TMP),"IN")
 ..;Delete outgoing filer
 ..I (ANS="O") D DELFLR^HLCSUTL1(TMPARR(TMP),"OUT")
 .;Whitespace - needed for screen refreshing
 .W !!!!!
 ;Invalid response
 Q 0
