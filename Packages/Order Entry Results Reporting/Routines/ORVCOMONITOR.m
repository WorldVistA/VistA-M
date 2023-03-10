ORVCOMONITOR ;SPFO/AJB - VISTA CUTOVER ;Feb 11, 2021@09:04:23
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;DEC 17, 1997;Build 17
 Q
 ; see ORVCO for list of ICRs/DBIAs
EN  ;
 N ANS,BASE,POP,X,Y
 S BASE=4 D PREP^XGF,HEADER
 F  D  Q:ANS="Q"!(ANS=U)
 . N JOB
 . I '$$STATUS(.JOB) S JOB=0 D IOXY^XGF(BASE+JOB+1,1) W $$CJ^XLFSTR("< No Running Jobs >",80) D IOXY^XGF(14,0),PROMPT S ANS=U Q
 . S JOB=$O(JOB(""),-1) D IOXY^XGF(BASE+JOB+1,1)
 . N DIR S DIR="SAO^U:Update;S:Stop;Q:Quit"
 . S DIR("L")="<Enter> to refresh the screen or (S)top a running Job # or (Q)uit"
 . S ANS=$$FMR(.DIR,"Enter monitor action: ","UPDATE","^D MONHELP^ORVCOMONITOR") Q:ANS="Q"!(ANS=U)
 . I ANS="S" D
 . . D CLEAR^XGF(0,1,23,80),HEADER,STATUS(.JOB)
 . . N ANS,DIR S DIR="SAO^",DIR("L")="Enter a Job # from the following list: "
 . . S JOB=0 F  S JOB=$O(JOB(JOB)) Q:'+JOB  D
 . . . S $P(DIR,U,2)=$P(DIR,U,2)_JOB(JOB)_":"_JOB(JOB)_$S(+$O(JOB(JOB)):";",1:"")
 . . . S $P(DIR("L"),":",2)=$P(DIR("L"),":",2)_JOB(JOB)_$S(+$O(JOB(JOB)):", ",1:"")
 . . D IOXY^XGF(BASE+$O(JOB(""),-1)+1,1)
 . . S ANS=$$FMR(.DIR,"Enter a Job # from the list above: ","","^D JOBHELP^ORVCOMONITOR") Q:'+ANS
 . . D CLEAR^XGF(0,1,23,80),HEADER(1),STATUS(.JOB)
 . . W !!,"Asking Task Man to stop Job #: ",ANS
 . . N INF,TASK S INF=$NA(^XTMP("ORVCO",ANS,"Info"))
 . . S TASK=0 F  S TASK=$O(@INF@(TASK)) Q:'+TASK  D
 . . . I $$ASKSTOP^%ZTLOAD(TASK)
 . . D IOXY^XGF(14,0),PROMPT
 . D CLEAR^XGF(0,0,23,80),HEADER
 . I '$D(^XTMP("ORVCO")) S JOB=0 D IOXY^XGF(BASE+JOB+1,1) W $$CJ^XLFSTR("< No Running Jobs >",80) D IOXY^XGF(14,0),PROMPT S ANS=U Q
 D CLEAR^XGF(0,0,23,80),CLEAN^XGF
 Q
STATUS(JOB) ;
 N CNT S (CNT,JOB)=0 F  S JOB=$O(^XTMP("ORVCO",JOB)) Q:'+JOB  D
 . N DATA,INF,USER,MODE,TYPE,THREAD,START
 . S INF=$NA(^XTMP("ORVCO",JOB,"Info"))
 . I $D(@INF@("Single Patient")) Q
 . S CNT=+$G(CNT)+1,JOB(CNT)=JOB
 . I +$G(@INF@("Calculating")) D SAY^XGF((BASE+CNT),0,JOB),SAY^XGF((BASE+CNT),28,"< Evaluating Patients >") Q
 . S DATA=$$SETSTR^VALM1(JOB,"",1,8) ; job #
 . S DATA=$$SETSTR^VALM1($$GET1^DIQ(200,+@INF@("User"),.01),DATA,10,18) ; user
 . S DATA=$$SETSTR^VALM1($S(+@INF@("Mode"):"Create",1:"Test"),DATA,35,6) ; mode
 . S DATA=$$SETSTR^VALM1($S(+$P(@INF@("Mode"),U,2):"Reminders",1:"Summary"),DATA,43,9) ; type
 . S (THREAD("Active"),THREAD("Progress"),THREAD)=0 F  S THREAD=$O(@INF@(" Daemon",THREAD)) Q:'+THREAD  D
 . . S THREAD("Progress")=THREAD("Progress")+$G(@INF@(" Daemon",THREAD,"Progress"))
 . . I '$D(@INF@(" Daemon",THREAD,"Stop Time")) S THREAD("Active")=THREAD("Active")+1
 . S THREAD("Progress")=$E(THREAD("Progress")/@INF@("Patients"),1,3)*100 ; calculate completion %
 . S DATA=$$SETSTR^VALM1(THREAD("Progress")_"%",DATA,32-$L(THREAD("Progress")),3) ; completion
 . S THREAD=THREAD("Active")_$S(@INF@("Threads")>9:" of ",1:" of  ")_@INF@("Threads") ; calulate active threads
 . S DATA=$$SETSTR^VALM1(THREAD,DATA,61-$L(THREAD),8) ; threads
 . S DATA=$$SETSTR^VALM1($E($$HTE^XLFDT(@INF@("Start Time")),1,18),DATA,63,18) ; start time
 . D SAY^XGF((BASE+CNT),0,DATA)
 Q CNT
HEADER(PARAM)  ;
 N DATA D SAY^XGF(0,29,"Daemon* Monitoring Tool"),SAY^XGF(0,72,$P($$HTE^XLFDT($H),"@",2)),SAY^XGF(2,53,"Active")
 S DATA=$$SETSTR^VALM1("Job #","",1,7)
 S DATA=$$SETSTR^VALM1("User",DATA,10,4)
 S DATA=$$SETSTR^VALM1("Progress",DATA,25,8)
 S DATA=$$SETSTR^VALM1("Mode",DATA,35,4)
 S DATA=$$SETSTR^VALM1("Type",DATA,43,9)
 S DATA=$$SETSTR^VALM1("Threads",DATA,54,10)
 S DATA=$$SETSTR^VALM1("Start Date/Time",DATA,66,15)
 W !,IOUON,DATA,IOUOFF
 D:'+$G(PARAM) SAY^XGF(21,0,"* In multitasking computer operating systems, a daemon is a computer program")
 D:'+$G(PARAM) SAY^XGF(22,0,"  that runs as a background process rather than being under the direct control")
 D:'+$G(PARAM) SAY^XGF(23,0,"  of an interactive user.")
 Q
MONHELP ;
 W !,"The following actions are available: <Enter>, S, or Q"
 Q
JOBHELP ;
 W !,"Enter the desired Job # or ^ to exit."
 Q
FMR(DIR,PRM,DEF,HLP,SCR) ; fileman reader
 N DILN,DILOCKTM,DISYS
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=DIR S:$G(PRM)'="" DIR("A")=PRM S:$G(DEF)'="" DIR("B")=DEF S:$G(SCR)'="" DIR("S")=SCR
 I $G(HLP)'="" S DIR("?")=HLP
 I $D(HLP) M DIR=HLP
 W $G(IOCUON) D ^DIR W $G(IOCUOFF)
 Q $S($D(DIROUT):U,$D(DIRUT):U,$D(DTOUT):U,$D(DUOUT):U,1:Y)
PROMPT ; 'Message transmitted, message received...'
 I $$FMR("EA","Press <ENTER> to continue")
 Q
