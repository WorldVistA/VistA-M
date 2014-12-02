LRJSML5 ;ALB/GTS - Lab Vista Hospital Location Pre-Patch Utilities;02/22/2010 14:51:41
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
INIT ;* init variables and list array
 ;Called from Protocol: LRJ SYS MAP HL SCHED AUDIT RPT DISP
 ;
 ; This API will show the HLCMS Audit Rpt Task schedule
 ;
 NEW LRFROM,LRTO
 SET (LRFROM,LRTO)=""
 DO GETDATE^LRJSML8(.LRFROM,.LRTO)
 D KILL
 IF (+LRFROM=0)!(+LRTO=0) DO
 .SET LRFROM=$P($G(^TMP("LRJ SYS USER MANAGER - DATES",$JOB)),"^")
 .SET LRTO=$P($G(^TMP("LRJ SYS USER MANAGER - DATES",$JOB)),"^",2)
 SET ^TMP("LRJ SYS USER MANAGER - DATES",$JOB)=LRFROM_"^"_LRTO
 D CREATRPT
 D HDR
 D REFRESH
 QUIT
 ;
REFRESH ;* refresh display
 D MSG^LRJSML
 SET VALMBCK="R"
 SET VALMBG=1
 QUIT
 ;
CREATRPT ;Create array of Hospital Location changes between selected dates
 N LRSCHED
 D OPTSTAT^XUTMOPT("LRJ SYS MAP HL TASKMAN RPT",.LRSCHED)
 D BLDREC(.LRSCHED) ;Create outarray
 Q
 ;
BLDREC(LRSCHED) ;Build Listman Output for background task
 ; INPUT:
 ;    LRSCHED : Schedule information about option
 ;              format -
 ;              task number^scheduled time^reschedule freq^special queuing flag
 ;
 NEW X,PCE,LROPTDAT
 DO KILL^VALM10()
 SET VALMCNT=0
 SET X=" Hospital Location Audit task schedule"
 DO ADD^LRJSMLU(.VALMCNT,X)
 DO CNTRL^VALM10(VALMCNT,2,$LENGTH(X)-1,IOUON,IOUOFF_IOINORM)
 D ADD^LRJSMLU(.VALMCNT," ")
 SET X="                    OPTION: LRJ SYS MAP HL TASKMAN RPT"
 D ADD^LRJSMLU(.VALMCNT,X)
 IF +$G(LRSCHED(1))=0 DO
 .SET X="                   TASK ID: Not Scheduled"
 .DO ADD^LRJSMLU(.VALMCNT,X)
 .SET X="QUEUED TO RUN AT WHAT TIME: Not Scheduled"
 .DO ADD^LRJSMLU(.VALMCNT,X)
 .SET X="    RESCHEDULING FREQUENCY: Not Scheduled"
 .DO ADD^LRJSMLU(.VALMCNT,X)
 ;
 IF +$G(LRSCHED(1))'=0 DO
 .SET PCE=0
 .FOR PCE=1:1:3 SET LROPTDAT=$P(LRSCHED(1),"^",PCE)  DO
 ..SET:PCE=1 X="                   TASK ID: "_$S(LROPTDAT'="":LROPTDAT,1:"Not Scheduled")
 ..IF PCE=2 DO
 ...NEW LROUTDT,Y
 ...SET Y=LROPTDAT
 ...DO DD^%DT
 ...SET LROUTDT=Y
 ...SET X="QUEUED TO RUN AT WHAT TIME: "_$S(LROUTDT'="":LROUTDT,1:"Not Scheduled")
 ..SET:PCE=3 X="    RESCHEDULING FREQUENCY: "_$S(LROPTDAT'="":LROPTDAT,1:"Not Scheduled")
 ..DO ADD^LRJSMLU(.VALMCNT,X)
 D ADD^LRJSMLU(.VALMCNT," ")
 D ADD^LRJSMLU(.VALMCNT," ")
 D ADD^LRJSMLU(.VALMCNT," ")
 D ADD^LRJSMLU(.VALMCNT," ")
 SET LROPTDAT=""
 SET LROPTDAT=$$GET^XPAR("SYS","LRJ HL LAST END DATE",1,"Q")
 SET X="Hospital Location Audit Automated Reporting begin Date: "_$S(LROPTDAT'="":$$FMTE^XLFDT(LROPTDAT),1:"Not indicated")
 DO ADD^LRJSMLU(.VALMCNT,X)
 QUIT
KILL ; -- kill off display data array
 KILL ^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 QUIT
 ;
HDR ; -- header code
 SET VALMHDR(1)="           LAB Hospital Location Change Audit Task Option Schedule"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^LRJSMLU()_"     Build: "_$$BLDNUM^LRJSMLU()
 Q
