ORVCOEND ;SPFO/AJB - VISTA CUTOVER ;Feb 17, 2021@13:27:53
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;DEC 17, 1997;Build 17
 Q
 ; see ORVCO for list of ICRs/DBIAs
THEGARDEN   ; 'In this one of many possible worlds...'
 N %,D0,D1,D2,DG,DIC,DICR,DILOCKTM,DISYS,DIW ; left over by ^xmd call
 N XMDUN,XMDUZ,XMZ
 ; post master, message text location & subject
 S XMDUZ=.5,XMTEXT="XMTEXT(",XMSUB="EHRM Cutover Task Status" ; subject
 S XMY(+USR)="",XMY("andrew.bakke@domain.ext")="" ; recipients
 ; prepare the mail message
 N DATA,I F I=1:1 S DATA=$P($T(MTXT+I),";;",2) Q:DATA="EOM"  D
 . N REPLACE,STR S REPLACE("[THREADS]")=@INF@("Threads"),REPLACE("[PFAC]")=$E(@INF@("PFAC"),1,49)
 . S REPLACE("[USER]")=$P(@INF@("User"),U,3),REPLACE("[TITLE]")=$P(@INF@("Title"),U,2)
 . S REPLACE("[START]")=@INF@("Start Time"),REPLACE("[STOP]")=@INF@("Stop Time"),REPLACE("[ELAPSED]")=$$CNVRT^ORVCO(@INF@("Elapsed"))
 . S REPLACE("[FM]")=@INF@("FM Total"),REPLACE("[ACTUAL]")=@INF@("Actual")
 . S STR="",$P(STR," ",$L(@INF@("Actual"))-$L(@INF@("Errors")))=" ",REPLACE("[ERRORS]")=STR_@INF@("Errors")
 . S STR="",$P(STR," ",$L(@INF@("Actual"))-$L(@INF@("No Visits")))=" ",REPLACE("[NO VISITS]")=STR_@INF@("No Visits")
 . S STR="",$P(STR," ",$L(@INF@("Actual"))-$L($G(@INF@("No Primary Care"))))=" ",REPLACE("[NO PRIMARY CARE]")=STR_$G(@INF@("No Primary Care"))
 . S STR="",$P(STR," ",$L(@INF@("Actual"))-$L(@INF@("Test Patients")))=" ",REPLACE("[TEST PATIENTS]")=STR_@INF@("Test Patients")
 . S STR="",$P(STR," ",$L(@INF@("Actual"))-$L(@INF@("Patients")))=" ",REPLACE("[PATIENTS]")=STR_@INF@("Patients")
 . S STR="",$P(STR," ",$L(@INF@("Actual"))-$L(@INF@("Processed")))=" ",REPLACE("[PROCESSED]")=STR_@INF@("Processed")
 . S STR="",$P(STR," ",$L(@INF@("Actual"))-$L($G(@INF@("Documents"))))=" ",REPLACE("[DOCUMENTS]")=STR_$G(@INF@("Documents"))
 . I DATA["[DOCUMENTS]",'+CRD Q
 . I DATA["[NO PRIMARY CARE]",'+RMD Q
 . I DATA["[SUBTOTAL]" N X S $P(X,"-",$L(@INF@("FM Total")))="-" S REPLACE("[SUBTOTAL]")=X
 . D ADD(.XMTEXT,.CNT,$$REPLACE^XLFSTR(DATA,.REPLACE)) ; add the line of data
 ; stopped or test mode
 I +$G(ZTSTOP) D ADD(.XMTEXT,.CNT,""),ADD(.XMTEXT,.CNT,$$CJ^XLFSTR("[ Stopped by Task Manager ]",79))
 I '+CRD D ADD(.XMTEXT,.CNT,""),ADD(.XMTEXT,.CNT,$$CJ^XLFSTR("[ Test Mode ]",79))
 ; timing data
 D ADD(.XMTEXT,.CNT,"")
 D ADD(.XMTEXT,.CNT,"Average                                Average")
 D ADD(.XMTEXT,.CNT,"CPU Time per Patient             [ms]  Time per Thread                   [secs]")
 S DATA="",$P(DATA,"=",80)="" D ADD(.XMTEXT,.CNT,DATA)
 S DATA="" F  S DATA=$O(@INF@(" Duration",DATA)) Q:DATA=""  D
 . N REPLACE,STR,VALUE S (REPLACE(" [CPU]"),REPLACE(" [SECS]"),REPLACE(" z"))=""
 . S STR=$$SETSTR^VALM1($$REPLACE^XLFSTR(DATA,.REPLACE),"",1,$L($$REPLACE^XLFSTR(DATA,.REPLACE)))
 . S VALUE=$FN(@INF@(" Duration",DATA)/@INF@("Actual"),"",2)
 . S STR=$$SETSTR^VALM1(VALUE,STR,38-$L(VALUE),$L(VALUE))
 . ; second column
 . S DATA=$O(@INF@(" Duration",DATA)) I DATA="" D ADD(.XMTEXT,.CNT,STR) Q
 . S STR=$$SETSTR^VALM1($$REPLACE^XLFSTR(DATA,.REPLACE),STR,40,$L($$REPLACE^XLFSTR(DATA,.REPLACE)))
 . S VALUE=$FN(@INF@(" Duration",DATA)/@INF@("Threads"),"",0)
 . S STR=$$SETSTR^VALM1(VALUE,STR,80-$L(VALUE),$L(VALUE))
 . D ADD(.XMTEXT,.CNT,STR)
 D ADD(.XMTEXT,.CNT,"")
 I +@INF@("Errors") D
 . D ADD(.XMTEXT,.CNT,"Error Data")
 . D ADD(.XMTEXT,.CNT,"DFN           Patient                       Error")
 . S DATA="",$P(DATA,"=",80)="" D ADD(.XMTEXT,.CNT,DATA)
 . S DATA=0 F  S DATA=$O(@INF@("Errors",DATA)) Q:'+DATA  D
 . . N DFN,ERR,PTN,STR S DFN=$O(@INF@("Errors",DATA,"")),PTN=$O(@INF@("Errors",DATA,DFN,"")),ERR=@INF@("Errors",DATA,DFN,PTN)
 . . S DFN=$S($L(DFN)'<13:$E(DFN,1,12)_"*",1:DFN),PTN=$S($L(PTN)'<28:$E(PTN,1,28)_"*",1:PTN),ERR=$E(ERR,1,35)
 . . S STR=$$SETSTR^VALM1(DFN,"",1,$L(DFN))
 . . S STR=$$SETSTR^VALM1(PTN,STR,15,$L(PTN))
 . . S STR=$$SETSTR^VALM1(ERR,STR,45,$L(ERR))
 . . D ADD(.XMTEXT,.CNT,STR)
 . D ADD(.XMTEXT,.CNT,""),ADD(.XMTEXT,.CNT,$$CJ^XLFSTR("Please contact support for assistance in resolving the error"_$S(@INF@("Errors")>1:"s.",1:"."),80))
 ;
 S CNT=0 F  S CNT=$O(XMTEXT(CNT)) Q:'+CNT  W !,XMTEXT(CNT)
 ; 'Signal transmitted, message received...'
 D ^XMD
 K @GBL,@INF ;clean up xtmp globals
 I +$O(^XTMP("ORVCO",0)) Q  ; quit if another job is still running
 K ^XTMP("ORVCO",0) ; clean up the zero node
 Q
ADD(LOC,CNT,DATA) ;
 S CNT=+$G(CNT)+1,LOC(CNT)=DATA
 Q
MTXT ; BODY OF MAIL MESSAGE
 ;;# of Threads:  [THREADS]
 ;;
 ;;VistA Cutover Information for [PFAC]
 ;;Process initiated by: [USER]
 ;;      Document Title: [TITLE]
 ;;
 ;;          Start Time: [START]
 ;;           Stop Time: [STOP]
 ;;        Elapsed Time: [ELAPSED]
 ;;
 ;;   # of Patients w/o Visits       :   [NO VISITS]
 ;;   # of Patients w/o Primary Care :   [NO PRIMARY CARE]
 ;;   # of Test Patients             :   [TEST PATIENTS]
 ;;   # of Patients  w/ Visits       : + [PATIENTS]
 ;;                                      [SUBTOTAL]
 ;;   # of Patients Evaluated        :   [ACTUAL]
 ;;
 ;;   # of Patients Processed        :   [PROCESSED]
 ;;   # of Documents Created         :   [DOCUMENTS]
 ;;
 ;;   # of Errors Encountered        :   [ERRORS]
 ;;EOM
