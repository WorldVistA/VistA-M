HLEVUTI2 ;O-OIFO/LJA - Event Monitor UTILITIES ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; This routine is used to queue M code tasks that automatically
 ; requeue themselves (within limits.)
 ;
INIT ;
 N A7UOK
 D HEADER,EX
 F  Q:(+$Y+3)>IOSL  W !
 QUIT:$$BTE^HLCSMON("Press RETURN to continue, or '^' to exit... ")  ;->
 ;
CTRL ;
 D HEADER
 W !
 D M
 D ASK I 'A7UOK QUIT  ;->
 D XEC
 D BT QUIT:'A7UOK  ;->
 G CTRL ;->
 ;
BT ;
 W !
 S A7UOK=0
 N DIR
 S DIR(0)="EA",DIR("A")="Press RETURN to continue, or '^' to exit... "
 D ^DIR
 QUIT:+Y'=1  ;->
 S A7UOK=1
 QUIT
 ;
HEADER ;
 W @IOF,$$CJ^XLFSTR("M Code Requeue Utility",IOM)
 W !,$$REPEAT^XLFSTR("=",80)
 QUIT
 ;
M KILL A7UMENU F I=1:1 S T=$T(M+I) QUIT:T'[";;"  S T=$P(T,";;",2,99),A7UMENU(I)=$P(T,"~",2,99) W !,$J(I,2),". ",$P(T,"~")
 ;;Start M code jobs~D START
 ;;Show M code job runs~D SHOW
 QUIT
 ;
ASK ;
 W !
 S A7UOK=0
 N DIR
 S DIR(0)="NO^1:"_(+I-1),DIR("A")="Select option"
 D ^DIR
 QUIT:'$D(A7UMENU(+Y))  ;->
 S A7UOPT=+Y
 S A7UOK=1
 QUIT
 ;
XEC ;
 S X=A7UMENU(+A7UOPT) X X
 QUIT
 ;
 ;==================================================================
 ;
SHOW ; Show M code job "runs"...
 N C2,C3,C4,C5,X,XTMP,Y
 ;
 I $O(^XTMP("HLEVREQ"))'["HLEVREQ" D  QUIT  ;->
 .  W !!,"No M Code API run data exists..."
 .  W !
 ;
 S C2=14,C3=28,C4=41,C5=59
 W !,"Task#",?C2,"Start",?C3,"Finish",?C4,"|"
 W ?(C4+2),"Next task#",?C5,"Queue time"
 W !,$$REPEAT^XLFSTR("=",C4),"|",$$REPEAT^XLFSTR("=",IOM-$X)
 ;
 S XTMP="HLEVREQ"
 F  S XTMP=$O(^XTMP(XTMP)) Q:$E(XTMP,1,7)'="HLEVREQ"  D
 .  D SXTMPT(XTMP)
 ;
 ;
 S C2=14,C3=28,C4=41,C5=59
 W !!,"Task#",?C2,"Start",?C3,"Finish",?C4,"M API"
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 S XTMP="HLEVREQ"
 F  S XTMP=$O(^XTMP(XTMP)) Q:$E(XTMP,1,7)'="HLEVREQ"  D
 .  D SXTMPM(XTMP)
 ;
 Q
 ;
SXTMPM(XTMP) ; Show individual XTMP entry...
 ; C2 to C5 -- req
 N I,XTMP0
 S XTMP0=$G(^XTMP(XTMP,0)) QUIT:XTMP0']""  ;->
 W !
 D P(4,C2),P(2,C3),P(7,C4)
 W $P(XTMP0,U,8,9),"  "
 S XTMP0=$P(XTMP0,U,8,9) QUIT:XTMP0']""  ;->
 S XTMP0=$P($T(@XTMP0)," ",2,999) QUIT:XTMP0']""  ;->
 I $E(XTMP0)=";",$E(XTMP0,1,2)'=";;" S XTMP0=$E(XTMP0,2,999)
 X "F I=1:1:$L(XTMP0) Q:$E(XTMP0,I)'="" """ S XTMP0=$E(XTMP0,I,999)
 W $E(XTMP0,1,IOM-$X)
 Q
 ;
SXTMPT(XTMP) ; Show individual XTMP entry...
 ; C2 to C5 -- req
 N XTMP0
 S XTMP0=$G(^XTMP(XTMP,0)) QUIT:XTMP0']""  ;->
 W !
 D P(4,C2),P(2,C3),P(7,C4)
 W "| "
 D P(5,C5),P(6,IOM)
 Q
 ;
P(PCE,COL) ; Print value and "tab" over to COL...
 ; XTMP0 -- req
 N DATA
 S DATA=$P(XTMP0,U,PCE)
 I DATA?7N1"."1.N S DATA=$$SDT^HLEVX001(DATA)
 W DATA,?COL
 Q
 ;
 ;==================================================================
 ;
START ;
 N MREQ,MRTN,MTIME,ZTSK
 ;
 W !
 S MRTN=$$FTMRTN QUIT:MRTN']""  ;->
 W !
 S MTIME=$$TIME QUIT:'MTIME  ;->
 W !
 S MREQ=$$REQNO QUIT:MREQ'>0  ;->
 ;
 W !
 I '$$YN^HLCSRPT4("OK to queue job") D  QUIT  ;->
 .  W "  job not started..."
 ;
 S ZTSK=$$NEWJOB($$NOW^XLFDT)
 W !!,"Queued to task# ",ZTSK,"..."
 ;
 QUIT
 ;
 ;
NEWJOB(TIME) ; Start job...
 ; MREQ,MRTN,MTIME -- req
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTIO="",ZTDTH=TIME,ZTDESC="HLEVUTI2-Queued Jobs"
 S ZTRTN="QUEUE^HLEVUTI2"
 S ZTSAVE("MREQ")="",ZTSAVE("MRTN")="",ZTSAVE("MTIME")=""
 S ZTSAVE("HLRUNS*")=""
 D ^%ZTLOAD
 QUIT ZTSK
 ;
QUEUE ; Queue point for the starting of all queued HLEVUTI2 jobs...
 ; MREQ,MRTN,MTIME -- req
 N I,NEWJOB,NOW,TASKNO,XTMP
 ;
 S ZTREQ="@",NOW=$$NOW^XLFDT,TASKNO=ZTSK
 ;
 ; Store run's ZTSK in HLRUNS...
 S HLRUNS=$G(HLRUNS)+1,HLRUNS(+ZTSK)=NOW
 I HLRUNS>30 S I=0 F  S I=$O(HLRUNS(I)) KILL HLRUNS(I) ; No STORE errors!
 ;
 S XTMP="HLEVREQ-"_ZTSK
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(MTIME,1)_U_NOW_U_"Event Monitor HLEVUTI2 Requeue"_U_ZTSK_"^^^^"_MRTN
 ;
 ; Piece 1 = Vaporization date/time
 ; Piece 2 = NOW
 ; Piece 3 = Description
 ; Piece 4 = Current task#
 ; Piece 5 = Next task number or END OF QUEUING
 ; Piece 6 = Next queue time
 ; Piece 7 = M code API finish time
 ; Piece 8 = Tag
 ; Piece 9 = Routine
 ;
 ; Calculate time for next queued job...
 S NEXTIME=$$FMADD^XLFDT(NOW,"","",MREQ)
 ;
 ; If next queue time is not greater, then queue next job...
 I NEXTIME<MTIME D
 .  S NEWJOB=$$NEWJOB(NEXTIME)
 .  S $P(^XTMP(XTMP,0),U,5,6)=NEWJOB_U_NEXTIME
 ;
 ; Run the M code...
 D @MRTN
 ;
 ; M code finish time...
 S NOW=$$NOW^XLFDT,$P(^XTMP(XTMP,0),U,7)=NOW,$P(HLRUNS(ZTSK),U,2)=NOW
 ;
 ; If next queue time < then end time quit (for new job already que'd)
 QUIT:NEXTIME<MTIME  ;->
 ;
 S $P(^XTMP(XTMP,0),U,5)="END OF QUEUING"
 D MAIL
 ;
 Q
 ;
TEST ; Call here to test M code
 D SAVE("Line of text saved by SAVE(TXT).")
 Q
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This utility runs M code in a background job on a repetitive basis up to the
 ;;date/time you specify.  To use this utility you must supply the following:
 ;;
 ;; * M code API (tag~routine.)
 ;; * Requeue frequency (in minutes.)
 ;; * Time to stop all requeues (up to 7 days in future.)
 ;;
 ;;As soon as the background job starts, the following actions occur:
 ;;
 ;; * The time for the next "run" of the 'M code API' is calculated using the
 ;;   'requeue frequency.'  
 ;; * If the new run time is not past the 'time to stop all requeues', a new
 ;;   future job is queued.
 ;; * The M code API is called.  (This occurs even when no future jobs are
 ;;   queued.
 QUIT
 ;
FTMRTN() ;
 N ANS,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="F^3:17",DIR("A")="Enter TAG~ROUTINE"
 W !,"Enter the M code API to be called by background jobs.  Enter it in the format"
 W !,"'TAG~ROUTINE'.  (Use the tilde (~) character in place of the up-arrow.)"
 W !
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 S ANS=$TR(Y,"~",U)
 S X="D "_ANS D ^DIM QUIT:'$D(X) "" ;->
 Q ANS
 ;
TIME() ;
 N ANS,DIR,DIRUT,DTOUT,DUOUT,NOW,X,Y
 S NOW=$$NOW^XLFDT
 S DIR(0)="DA^"_NOW_":"_$$FMADD^XLFDT(NOW,7)_":AEFRS"
 S DIR("A")="Enter STOP TIME: "
 S DIR("?")="Enter a future date/time up to "_$$FMTE^XLFDT($$FMADD^XLFDT(NOW,7))_"..."
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(NOW,1))
 W !,"New jobs will be requeued until the date/time you enter now.  You cannot queue"
 W !,"jobs past seven days in the future."
 W !
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 S ANS=Y
 I ANS'>NOW D  QUIT "" ;->
 .  W !!,"Date/time you enter must not be in the past..."
 Q ANS
 ;
REQNO() ;
 N ANS,DIR,DIRUT,DTOUT,DUOUT,NOW,X,Y
 S DIR(0)="N^10:1440",DIR("A")="Enter REQUEUE FREQUENCY (min)"
 W !,"New jobs will be requeued for the number of 'requeue frequency' minutes"
 W !,"in the future you specify now."
 W !
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 Q Y
 ;
MAIL ; All queues are done.  Mail notification to DUZ...
 N NO,TEXT,XMDUZ,XMSUB,XMTEXT,XMZ
 S XMDUZ=.5,XMSUB="M Code Requeue Utility"
 S XMTEXT="^TMP("_$J_",""HLMAILMSG"","
 KILL ^TMP($J,"HLMAILMSG")
 S NO=0
 D MAILADD("The queuing of jobs to "_$TR($G(MRTN),"~",U)_" has finished.  #"_$G(HLRUNS)_" jobs were queued.")
 ;
 I HLRUNS<31 D
 .  N DATA,LN,TASK,TXT
 .  S LN=$$REPEAT^XLFSTR(" ",74)
 .  D MAILADD("")
 .  D MAILADD("Task#         Start        Finish")
 .  D MAILADD($$REPEAT^XLFSTR("-",74))
 .  S TASK=0
 .  F  S TASK=$O(HLRUNS(TASK)) Q:'TASK  D
 .  .  S DATA=HLRUNS(TASK)
 .  .  S TXT=$E(TASK_LN,1,14) ; Task#
 .  .  S TXT=TXT_$E($$SDT^HLEVX001(+DATA)_LN,1,13) ; Start time
 .  .  S TXT=TXT_$E($$SDT^HLEVX001($P(DATA,U,2))_LN,1,13) ; End time
 .  .  I $D(^XTMP("HLEVREQ-"_TASK,"T")) D
 .  .  .  S TXT=TXT_"Data in ^XTMP(""HLEVREQ-"_TASK_""",""T"")"
 .  .  D MAILADD(TXT)
 ;
 S XMY(DUZ)=""
 D ^XMD
 I '$D(ZTQUEUED) W !!,"Mail message #",$G(XMZ),"..."
 KILL ^TMP($J,"HLMAILMSG")
 ;
 Q
 ;
MAILADD(T) S NO=$G(NO)+1,^TMP($J,"HLMAILMSG",NO)=T
 Q
 ;
 ;==================================================================
 ;
SAVE(TXT) ; Save one line of text into ^XTMP
 ; XTMP -- req
 N NO
 QUIT:$G(XTMP)']""  ;->
 QUIT:$G(^XTMP(XTMP,0))']""  ;->
 S NO=$O(^XTMP(XTMP,"T",":"),-1)+1
 S ^XTMP(XTMP,"T",+NO)=$G(TXT)
 Q
 ;
KILLALL ; Kill **ALL** run data for all jobs!!!!  (BE CARFUL)
 N DATA,XTMP
 ;
 I $O(^XTMP("HLEVREQ-"))'["HLEVREQ-" D  QUIT  ;->
 .  W !!,"No data exists... "
 .  W !
 ;
 W !!,"Existing M code job run data..."
 ;
 W !
 S XTMP="HLEVREQ-"
 F  S XTMP=$O(^XTMP(XTMP)) Q:$E(XTMP,1,8)'="HLEVREQ-"  D
 .  S DATA=$G(^XTMP(XTMP,0)) Q:DATA']""  ;->
 .  W !,"Started: ",$$SDT^HLEVX001($P(DATA,U,2))
 .  W $S($P(DATA,U,7)']"":"    Job still running!!",1:"   finished: "_$$SDT^HLEVX001(+$P(DATA,U,7)))
 .  W "     ",$P(DATA,U,8,9),"..."
 ;
 W !
 I '$$YN^HLCSRPT4("OK to delete ALL M Code requeue data","No") D  QUIT  ;->
 .  W "  nothing deleted..."
 ;
 W !
 S XTMP="HLEVREQ-"
 F  S XTMP=$O(^XTMP(XTMP)) Q:$E(XTMP,1,8)'="HLEVREQ-"  D
 .  W !,"Killing ^XTMP(",XTMP,")..."
 .  D KILLXTMP(XTMP)
 ;
 W !
 S X=$$BTE^HLCSMON("Press RETURN to exit... ")
 ;
 Q
 ;
KILLXTMP(XTMP) ; Kill one XTMP entry... (Pass TASK or full reference)
 I XTMP=+XTMP S XTMP="HLEVREQ-"_XTMP
 KILL ^XTMP(XTMP)
 Q
 ;
EOR ;HLEVUTI2 - Event Monitor UTILITIES ;5/16/03 14:42
