LRJSMLU ;ALBOI/GTS - Lab VistA LRJ DATA SERVER UTILITY ;OCT 2, 2010
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
ADD(VALMCNT,MSG,LRBOLD) ; -- add line to build display
 SET VALMCNT=VALMCNT+1
 DO SET^VALM10(VALMCNT,MSG)
 IF $GET(LRBOLD) DO CNTRL^VALM10(VALMCNT,1,79,IOINHI,IOINORM)
 QUIT
 ;
STARTDTM(LRDEF) ; Prompt for Date and Time to schedule task
 ; Called from SCHDBCKG^LRJSML6
 ;
 ; Input:
 ;        LRDEF - Default Date/Time
 ;
 ; Output:
 ;        LROK^LRSTDTM^LRY where -
 ;        
 ;          LROK : 1 - User did not time out or enter ^ to exit
 ;                 0 - User timed out or entered ^ to exit
 ;
 ;          LRSTDTM : Fileman formatted Date/Time
 ;                        or
 ;                     Null when Date/Time not entered
 ;                     
 ;          LRY : Y returned from %DT
 ;         
 NEW LRY,LROK,LRSTDTM
 WRITE !!,"This is the date/time you want this option to be started by TaskMan.",!
 SET LRSTDTM=""
 SET LROK=1
 SET DIR(0)="FAO^^D BJITT^LRJSML6"
 SET DIR("A")="QUEUED TO RUN AT WHAT TIME: "
 SET:$G(LRDEF)'="" DIR("B")=LRDEF
 SET DIR("?")="^D ITTHELP^LRJSMLU(X)"
 DO ^DIR
 SET LRY=X
 SET:($D(DTOUT)!(X["^")!((Y']"")&(X'="@"))) LROK=0
 KILL DIR,X,Y,%DT
 SET %DT="FR"
 SET X=LRY
 DO ^%DT
 SET:Y>0 LRSTDTM=Y ;Date/Time to start background task
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT,%DT
 SET LROK=LROK_"^"_LRSTDTM_"^"_LRY
 QUIT LROK
 ;
ITTHELP(LRX) ; Display Help for Queued Start Time prompt
 IF LRX="?" DO
 .NEW DIR,X,Y,DTOUT,DIRUT,DUOUT
 .WRITE !,"Time must be at least 2 minutes in the future."
 .WRITE !,"Changing or deleting this date/time field will re-queue or un-queue the Option."
 .WRITE !
 .WRITE !,"     Examples of Valid Dates:"
 .WRITE !,"       JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057"
 .WRITE !,"       T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7,  etc."
 IF LRX="??" DO
 .NEW DIR,LRCONT
 .SET LRCONT=1
 .WRITE !,"Changing or deleting this date/time field will re-queue or un-queue the Option."
 .WRITE !!,"If this field has a value, the Task Manager will try to run this OPTION"
 .WRITE !,"on or after the date/time entered.  This field should NOT have a"
 .WRITE !,"value if the OPTION TYPE is MENU, INQUIRY, or EDIT, since it doesn't"
 .WRITE !,"make sense to start up automatically a process that requires user"
 .WRITE !,"terminal input."
 .WRITE !!,"     Examples of Valid Dates:"
 .WRITE !,"       JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057"
 .WRITE !,"       T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7,  etc."
 .WRITE !!,"     If the year is omitted, the computer uses CURRENT YEAR.  Two digit year"
 .WRITE !,"       assumes no more than 20 years in the future, or 80 years in the past.",!
 QUIT
 ;
BJITS ;input transform for background job re-sch freq
 ; Also called from SCHDBCKG^LRJSML6
 ;
 IF $$ENTCHK^LRJSML6(X) QUIT
 DO ITSHELP("?")
 KILL X
 QUIT
 ;
ITSHELP(LRX) ; Display Help for Schedule Freq prompt
 ; Also called from SCHDBCKG^LRJSML6
 ;
 IF LRX="?" DO
 .WRITE !,"FOR AUTOMATIC RE-QUEUING, ANSWER WITH INCREMENT OF HOURS, DAYS, OR MONTHS"
 .WRITE !,"  with codes from 2 - 15 characters."
 IF (LRX="?")!(LRX="??")!(LRX="???") DO
 .WRITE !,"Examples:"
 .WRITE !,"   120S = job will be re-run every two minutes"
 .WRITE !,"   1H = job will be rerun every hour"
 .WRITE !,"   7D = job will be re-run every week"
 .WRITE !,"   3M = job will be run once a quarter"
 IF LRX="??"!(LRX="???") DO
 .NEW DIR,LRCONT
 .SET LRCONT=1
 .WRITE !!,"This field has a value only if the OPTION is to be re-queued automatically"
 .WRITE !,"for a subsequent run every time it is run by the TaskManager."
 .WRITE !!,"Valid codes are:"
 .WRITE !,"       Every n seconds         nS"
 .WRITE !,"       Every n hours           nH"
 .WRITE !,"       Every n days            nD"
 .WRITE !,"       Every n months          nM"
 .WRITE !,"       Day of Week             day[@time]"
 .WRITE !,"       weekday                 D[@time]"
 .WRITE !,"       weekend day             E[@time] (saturday, sunday)"
 .WRITE !,"       Different days in month nM(sch...)"
 .WRITE !,"           sch:    dd[@time]       day of month ie: 15"
 .WRITE !,"                   nDay[@time]     day of week in month"
 .WRITE !,"                                   ie: 1W,3W  first and third wednesday"
 .WRITE !,"                   L               last",!
 .SET DIR(0)="E"
 .DO ^DIR
 .SET LRCONT=+Y
 .IF LRCONT DO
 ..WRITE !!,"       day:=   M       monday"
 ..WRITE !,"               T       tuesday"
 ..WRITE !,"               W       wednesday"
 ..WRITE !,"               R       thursday"
 ..WRITE !,"               F       friday"
 ..WRITE !,"               S       saturday"
 ..WRITE !,"               U       sunday"
 ..WRITE !!,"       Examples:"
 ..WRITE !,"               1M(1,15)        The first and 15th of the month."
 ..WRITE !,"               1M(L)           The last day of the month."
 ..WRITE !,"               1M(LS)          The last saturday of the month."
 ..WRITE !,"               D               Each weekday",!
 QUIT
 ;
HANGCHAR(LRCHAR) ; Display Hang Characters
 NEW LRBS,LRD,LRS
 SET:'$D(LRCHAR) LRCHAR=0
 SET LRD="- ]"
 SET LRS="\ ]"
 SET LRBS="/ ]"
 NEW LRRESET,LRY
 SET LRY=$Y
 DO IOXY^XGF(IOSL-1,75) ;IA #3173
 SET LRRESET=0
 SET:LRCHAR=0 LRCHAR=LRBS
 IF 'LRRESET,LRCHAR=LRD SET LRCHAR=LRS SET LRRESET=1
 IF 'LRRESET,LRCHAR=LRS SET LRCHAR=LRBS SET LRRESET=1
 IF 'LRRESET,LRCHAR=LRBS SET LRCHAR=LRD SET LRRESET=1
 WRITE LRCHAR
 IF 1 ;Needed for ^DIC screen calls
 Q
 ;
UUEN(STR) ; Uuencode string passed in.
 N J,K,LEN,LRI,LRX,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F LRI=1:3:LEN D
 . S LRX=$E(STR,LRI,LRI+2)
 . I $L(LRX)<3 S LRX=LRX_$E("   ",1,3-$L(LRX))
 . S S=$A(LRX,1)*256+$A(LRX,2)*256+$A(LRX,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
BLDNUM() ; -- returns the build number
 QUIT +$PIECE($PIECE($TEXT(LRJSMLU+1),";",7),"Build ",2)
 ;
VERNUM() ; -- returns the version number for this build
 QUIT +$PIECE($TEXT(LRJSMLU+1),";",3)
 ;
MGRCHK() ; -- does DUZ have LRJ HL TOOLS MGR key
 N LRSEC
 D OWNSKEY^XUSRB(.LRSEC,"LRJ HL TOOLS MGR")
 Q +$G(LRSEC(0))
