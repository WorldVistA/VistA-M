YTSCOREV ;SLC/KCM - Update scores with revision change ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**119,123**;Dec 30, 1994;Build 72
 ;
RESCORE ; background task to ensure all results recorded for administrations
 ; expects:  YSRSREV (revision identifier) to be passed in
 ;           examples: "0~1" for all instruments, "142~2" for one instrument
 ; quit if re-scoring has been completed
 I $$GET^XPAR("SYS","YS123 SCORING COMPLETE",YSRSREV,"Q") QUIT
 S ^XTMP("YTS-RESCORE",YSRSREV,"RUNNING")=1
 ; schedule task to continue tomorrow
 D QTASK(YSRSREV,$$HADD^XLFDT($H,1))
 ;
DIRECT ; enter here to run interactively without tasking
 ; expects:  YSRSREV (revision identifier) to be passed in
 ;
 ; ^XTMP("YTS-RESCORE",0)=T+90^DT^MH Ensure Scores Recorded
 ; ^XTMP("YTS-RESCORE",revId,"LAST")=IEN from last admin done
 ; ^XTMP("YTS-RESCORE",revId,"EVALUATED")=number of admins checked
 ; ^XTMP("YTS-RESCORE",revId,"RESCORED")=number of admins re-scored
 ; ^XTMP("YTS-RESCORE",revId,"ELAPSED")=seconds this session
 ; ^XTMP("YTS-RESCORE",revId,"TOTTIME")=total elapsed time
 ; ^XTMP("YTS-RESCORE",revId,"SESSIONS")=number of tasked scoring jobs completed
 ; ^XTMP("YTS-RESCORE",revId,"RUNNING")=true if re-scoring currently active
 ; ^XTMP("YTS-RESCORE",revId,"RESUME")=$H start ^ taskId
 ; ^XTMP("YTS-RESCORE","ERRORS")=count
 ; ^XTMP("YTS-RESCORE","ERRORS",#)=error text
 ; ^XTMP("YTS-RESCORE","STOP")=1  ;if the current session(s) should stop
 ;
 S ^XTMP("YTS-RESCORE",YSRSREV,"RUNNING")=1
 S ^XTMP("YTS-RESCORE",0)=$$FMADD^XLFDT(DT,90)_U_DT_U_"MH Save All Scores"
 N YS123HRS,YS123LIM,YS123ADM,YS123OUT,YS123CNT,YS123TS,YS123NEW
 S YS123HRS=$$GET^XPAR("ALL","YS123 TASK LIMIT HOURS",1,"Q")
 S:'YS123HRS YS123HRS=4
 S YS123TS=$H,YS123OUT=0                                  ; start, exit
 S YS123CNT=+$G(^XTMP("YTS-RESCORE",YSRSREV,"EVALUATED")) ; count
 S YS123LIM=$$FMADD^XLFDT($$NOW^XLFDT,0,YS123HRS,0,0)     ; time limit
 S YS123ADM=+$G(^XTMP("YTS-RESCORE",YSRSREV,"LAST"))      ; last completed
 F  S YS123ADM=$O(^YTT(601.84,YS123ADM)) D  Q:YS123OUT
 . ; no more administrations, re-scoring is done
 . I 'YS123ADM D  QUIT
 . . D EN^XPAR("SYS","YS123 SCORING COMPLETE",YSRSREV,"NOW")
 . . S YS123OUT=1
 . . S ^XTMP("YTS-RESCORE",YSRSREV,"ELAPSED")=$$HDIFF^XLFDT($H,YS123TS,2)
 . . S ^("TOTTIME")=$G(^XTMP("YTS-RESCORE",YSRSREV,"TOTTIME"))+$G(^("ELAPSED"))
 . . S ^XTMP("YTS-RESCORE",YSRSREV,"ELAPSED")=0
 . ; check every 10000 to see if this process has gone longer than limit
 . S YS123CNT=YS123CNT+1
 . I (YS123CNT#10000=0) D  QUIT:YS123OUT
 . . H 1 ; make sure this doesn't take too many the resources
 . . S ^XTMP("YTS-RESCORE",YSRSREV,"ELAPSED")=$$HDIFF^XLFDT($H,YS123TS,2)
 . . I $$NOW^XLFDT>YS123LIM S YS123OUT=1
 . . I $G(^XTMP("YTS-RESCORE","STOP")) S YS123OUT=1
 . . I YS123OUT D
 . . . S ^("TOTTIME")=$G(^XTMP("YTS-RESCORE",YSRSREV,"TOTTIME"))+$G(^("ELAPSED"))
 . . . S ^XTMP("YTS-RESCORE",YSRSREV,"ELAPSED")=0
 . . . S ^XTMP("YTS-RESCORE",YSRSREV,"LAST")=$O(^YTT(601.84,YS123ADM),-1)
 . ; check if scoring only one instrument and quit if not that instrument
 . I +YSRSREV,(+YSRSREV'=$P($G(^YTT(601.84,YS123ADM,0)),U,3)) QUIT
 . ; rescore this administration surrounded by error trap
 . S YS123NEW=$$SCOREONE(YS123ADM)
 . I YS123NEW S ^("RESCORED")=$G(^XTMP("YTS-RESCORE",YSRSREV,"RESCORED"))+1
 . S ^XTMP("YTS-RESCORE",YSRSREV,"LAST")=YS123ADM
 . S ^XTMP("YTS-RESCORE",YSRSREV,"EVALUATED")=YS123CNT
 I $D(ZTQUEUED) S ZTREQ="@"
 S ^("SESSIONS")=$G(^XTMP("YTS-RESCORE",YSRSREV,"SESSIONS"))+1
 S ^XTMP("YTS-RESCORE",YSRSREV,"RUNNING")=0
 Q
QTASK(YSRSREV,RESUME) ; Create background task for rescoring administrations
 ; YSRSREV: revision ID (for example: 0~1, 142~2)
 ;  RESUME: $H start time for task
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTIO=""
 S ZTRTN="RESCORE^YTSCOREV"
 S ZTDESC="Rescore MH Instrument Administrations"
 S ZTDTH=RESUME
 S ZTSAVE("YSRSREV")=""
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("Unsuccessful queue of re-scoring job.")
 S ^XTMP("YTS-RESCORE",0)=$$FMADD^XLFDT(DT,90)_U_DT_U_"MH Save All Scores"
 S ^XTMP("YTS-RESCORE",YSRSREV,"RESUME")=RESUME_U_$S($G(ZTSK):ZTSK,1:"Queuing Error")
 Q
 ;
 ; -- score a single administration with error handling
 ;
SCOREONE(YS123ADM) ; score one adminstration
 N $ES,$ET S $ET="D ERRHND^YTSCOREV"
 K ^TMP($J)
 N YSDATA,YS,IEN71,YSAD,YS123NEW
 S YS("AD")=YS123ADM,YS123NEW=0
 S IEN71=$P(^YTT(601.84,YS123ADM,0),U,3)
 ; old scores (in 601.2) will be skipped since we are iterating on 601.84
 I $P($G(^YTT(601.71,IEN71,8)),U,3)="Y" QUIT 0 ; also skip legacy scoring
 ; if complex instrument prior to patch 123, delete any results first
 I ($P($G(^YTT(601.71,IEN71,9)),U)="DLL"),'$P($G(^YTT(601.84,YS123ADM,0)),U,12) D DELRSLTS(YS123ADM)
 I $$DIFFREV(IEN71,YS123ADM) D
 . D LOADANSW^YTSCORE(.YSDATA,.YS)   ; .YSDATA recieves answers
 . D SCOREINS^YTSCORE(.YSDATA,IEN71) ; ^TMP($J,"YSCOR") and ^TMP($J,"YSG")
 . D UPDSCORE^YTSCORE(.YSDATA,.YS)   ; .YSDATA doesn't seem to do anything
 . S YS123NEW=1
 K ^TMP($J)
 Q YS123NEW
 ;
DIFFREV(IEN71,YS123ADM) ; return true if different revision
 N REVSCR71,REVSCR84
 S REVSCR71=$P($G(^YTT(601.71,IEN71,9)),U,3)
 S REVSCR84=$P($G(^YTT(601.84,YS123ADM,0)),U,12)
 Q (REVSCR71'=REVSCR84)
 ;
DELRSLTS(YS123ADM) ; delete the current results of an administration
 N IEN,RLST
 ; get the list of IEN's before deleting things from the xref used
 S IEN=0 F  S IEN=$O(^YTT(601.92,"AC",YS123ADM,IEN)) Q:'IEN  S RLST(IEN)=""
 S IEN=0 F  S IEN=$O(RLST(IEN)) Q:'IEN  D
 . I $P(^YTT(601.92,IEN,0),U,2)'=YS123ADM Q  ; double check the admin first
 . D FMDEL^YTXCHGU(601.92,IEN)               ; then delete
 Q
ERRHND ; Handle errors & clear stack
 ; Grab the error code
 N ERROR S ERROR=$$EC^%ZOSV
 ; Ignore errors when clearing the call stack
 I ERROR["ZTER" D UNWIND^%ZTER
 ; Make sure we don't loop if there is an error during processing of
 ; the error handler.
 N $ET S $ET="D ^%ZTER,UNWIND^%ZTER"
 ; Uncomment below to save error trap information for each re-score failure,
 ; but changing past data to fix errors is likey not desirable.  We do want to
 ; avoid filling the error trap.
 ; D ^%ZTER ; record re-score failure in error trap
 ; Record administration number and error in ^XTMP log
 S ^XTMP("YTS-RESCORE","ERRORS")=$G(^XTMP("YTS-RESCORE","ERRORS"))+1
 N ERRNUM S ERRNUM=^XTMP("YTS-RESCORE","ERRORS")
 S ^XTMP("YTS-RESCORE","ERRORS",ERRNUM)=$G(YS123ADM)_U_$H_U_ERROR
 ; clear the call stack
 D UNWIND^%ZTER
 Q
 ;
 ; -- display report of any current/recent re-scoring processes
 ;
MONLOOP ; monitor re-scoring loop
 D HOME^%ZIS
 N ACTION
 S ACTION="R" F  D  Q:"RB"'[ACTION
 . I ACTION="R" D SHOWPROG
 . I ACTION="B" D SHOWERRS
 . W ! S ACTION=$$GETCMD
 Q
SHOWPROG ; show progress of re-scoring process
 ; loop through revId's and show progress
 N REVID,TSTNAM,REVNUM,STS,EVAL,TOTL,SCRD,TIME,SESS
 S REVID=0 F  S REVID=$O(^XTMP("YTS-RESCORE",REVID)) Q:REVID'["~"  D
 . S TSTNAM=$S(+REVID=0:"all instruments",1:$P(^YTT(601.71,+REVID,0),U))
 . S REVNUM=$P(REVID,"~",2)
 . ;
 . S STS=""
 . I $$GET^XPAR("SYS","YS123 SCORING COMPLETE",REVID,"Q") S STS="complete" I 1
 . I '$L(STS) D
 . . I $G(^XTMP("YTS-RESCORE",REVID,"RUNNING")) S STS="running" Q
 . . N X S X=$G(^XTMP("YTS-RESCORE",REVID,"RESUME"))
 . . S STS="queued to run at "_$$HTE^XLFDT($P(X,U))_" (task #"_$P(X,U,2)_")"
 . ;
 . S TOTL=$P(^YTT(601.84,0),U,4)
 . S EVAL=$G(^XTMP("YTS-RESCORE",REVID,"EVALUATED"))
 . S SCRD=$G(^XTMP("YTS-RESCORE",REVID,"RESCORED"))
 . S SESS=$G(^XTMP("YTS-RESCORE",REVID,"SESSIONS"))
 . S TIME=$G(^XTMP("YTS-RESCORE",REVID,"TOTTIME"))+$G(^("ELAPSED"))
 . S TIME=$$SEC2HMS(TIME)
 . I $G(^XTMP("YTS-RESCORE",REVID,"RUNNING")) S SESS=SESS+1
 . ;
 . W !
 . W !,"Progress -- Rescore "_TSTNAM_" to revision "_REVNUM
 . W !,"             Current Status: "_STS
 . W !,"            Administrations: "_+EVAL_" evaluated of "_TOTL
 . W !,"            Total Re-scored: "_SCRD
 . W !,"               Elapsed Time: "_TIME_" (in "_SESS_" sessions)"
 ;
 W !!,"Errors Encountered: "_$G(^XTMP("YTS-RESCORE","ERRORS"),0),!
 Q
SHOWERRS ; browse the errors
 N I,X,ADM,TM,ERR
 K ^TMP("YTS123BR",$J)
 S I=0 F  S I=$O(^XTMP("YTS-RESCORE","ERRORS",I)) Q:'I  D
 . S X=^XTMP("YTS-RESCORE","ERRORS",I)
 . S ADM=$P(X,U,1),TM=$$HTE^XLFDT($P(X,U,2)),ERR=$P(X,U,3,99)
 . S ^TMP("YTS123BR",$J,I)=$J(ADM,8)_"  "_TM_"  "_ERR
 D BROWSE^DDBR($NA(^TMP("YTS123BR",$J)),"NR","YS*5.01*123 Re-scoring Errors")
 K ^TMP("YTS123BR",$J)
 Q
GETCMD() ; Get the next command
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SB^R:Refresh;B:Browse Errors;Q:Quit"
 S DIR("B")="Refresh"
 D ^DIR
 I $D(DIRUT)!$D(DIROUT) S Y="Q"
 Q Y
 ;
SEC2HMS(SS) ; return "#h #m #s" from seconds
 N HH,MM
 S HH=SS\3600,SS=SS-(HH*3600)
 S MM=SS\60,SS=SS-(MM*60)
 Q HH_"h "_MM_"m "_SS_"s"
 ;
LSTREV ; list revised instruments
 N IEN,ADM,TEST,CNT
 S CNT=0,IEN=0 F  S IEN=$O(^YTT(601.92,IEN)) Q:'IEN  D
 . I $D(^YTT(601.92,IEN,1))<10 Q
 . S ADM=$P(^YTT(601.92,IEN,0),U,2),CNT=CNT+1
 . S TEST=$P(^YTT(601.84,ADM,0),U,3)
 . W !,ADM,?10,$P(^YTT(601.71,TEST,0),U)
 . W ?22,$P(^YTT(601.92,IEN,0),U,3)
 . W ?47,"was ",$P(^YTT(601.92,IEN,1,1,0),U,3,6)
 . W ?62,"now ",$P(^YTT(601.92,IEN,0),U,4,7)
 W !!,"Admin Total: ",CNT
 Q
