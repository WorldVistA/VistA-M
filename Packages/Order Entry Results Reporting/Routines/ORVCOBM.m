ORVCOBM ;SPFO/AJB - VISTA CUTOVER ;Feb 11, 2021@09:04:56
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;Dec 17, 1997;Build 17
 Q
 ; see ORVCO for list of ICRs/DBIAs
RESULTS ; process the results
 N X S X=0 F  S X=$O(RESULTS(X)) Q:'+X  D
 . S X(1)=$P(RESULTS(X,"DATA"),U)
 . S X(2)=$FN($P(RESULTS(X,"DATA"),U,2)/$P(RESULTS("Baseline"),U,2),"",2)
 . S X(3)=$FN(1-($P(RESULTS(X,"DATA"),U,3)/$P(RESULTS("Baseline"),U,3)),"",2)
 . S RESULTS("Score",X(1)*(X(2)*X(3)))=X
 N OPT S OPT=RESULTS("Score",$O(RESULTS("Score",""),-1)),OPT=(OPT-1)*5 K X ; set best thread result & clean x
 ; set optimal thread count in options
 F X="ORVCO TEST","ORVCO CREATE" D
 . S X(1)=$$LU^ORVCO(19,X) Q:'+X(1)
 . N ERR,FDA S FDA(19,X(1)_",",25)=$S(X["TEST":"TST^ORVCO("_OPT_")",1:"EN^ORVCO("_OPT_")")
 . D UPDATE^DIE("","FDA","",.ERR)
 Q
OUTPUT(BM,RESULTS) ;
 D SAY^XGF(0,72,$P($$HTE^XLFDT($H),"@",2))
 N INF,OUT,THREAD,THREADS,TOTAL
 ;
 S INF=$NA(^XTMP("ORVCOBM",$J))
 S TOTAL("FM Total")=@INF@("Total")
 S INF=$NA(^XTMP("ORVCOBM",$J,"BM",BM,"Info"))
 ;
 S THREAD=0 F  S THREAD=$O(@INF@(" Daemon",THREAD)) Q:'+THREAD  D
 . S THREAD(BM,"Processed")=$G(THREAD(BM,"Processed"))+@INF@(" Daemon",THREAD,"Processed") ; total processed of all threads
 . S THREAD(BM,"Elapsed")=$G(THREAD(BM,"Elapsed"))+@INF@(" Daemon",THREAD,"Elapsed") ; total elapsed time of all threads
 ;
 S THREADS=@INF@("Threads")
 S THREAD(BM,"Avg Thread Duration")=$FN(THREAD(BM,"Elapsed")/THREADS,"",2)
 S THREAD(BM,"Avg Thread Duration")=$S('+THREAD(BM,"Avg Thread Duration"):1,1:THREAD(BM,"Avg Thread Duration"))
 S THREAD(BM,"Patients per second")=$FN(THREAD(BM,"Processed")/THREAD(BM,"Avg Thread Duration"),"",2)
 S TOTAL("EST")=$$CNVRT^ORVCO(TOTAL("FM Total")/THREAD(BM,"Patients per second")) ; estimated time to completion
 ;
 S OUT=$$SETSTR^VALM1(BM,"",1,$L(BM)) ; Test #
 S OUT=$$SETSTR^VALM1(THREADS,OUT,10,4) ; # of Threads
 S OUT=$$SETSTR^VALM1(THREAD(BM,"Processed"),OUT,20,$L(THREAD(BM,"Processed"))) ; Patients Processed
 S OUT=$$SETSTR^VALM1(@INF@("Elapsed"),OUT,32,$L(@INF@("Elapsed"))) ; Total Elapsed Time
 S OUT=$$SETSTR^VALM1(THREAD(BM,"Avg Thread Duration"),OUT,42,$L(THREAD(BM,"Avg Thread Duration")))
 S OUT=$$SETSTR^VALM1(THREAD(BM,"Patients per second"),OUT,53,$L(THREAD(BM,"Patients per second")))
 S OUT=$$SETSTR^VALM1(TOTAL("EST"),OUT,81-$L(TOTAL("EST")),$L(TOTAL("EST")))
 D CLEAR^XGF(4+BM,4+BM,4+BM,70),SAY^XGF(3+BM,0,OUT) ; display results
 ;
 S RESULTS(BM,"DATA")=1 ;1-BM ; weighted score for # of threads
 S $P(RESULTS(BM,"DATA"),U,2)=THREAD(BM,"Patients per second") ; patients per second
 S $P(RESULTS(BM,"DATA"),U,3)=$FN(TOTAL("FM Total")/THREAD(BM,"Patients per second"),"",2) ; estimated time to completion in seconds
 S:BM=1 RESULTS("Baseline")=RESULTS(BM,"DATA")
 Q
EN(ITERATIONS) ;
 S ITERATIONS=$S(+$G(ITERATIONS):ITERATIONS-1,1:0)
 D HOME^%ZIS,PREP^XGF
 N BM,CNT,CRD,GBL,INF,MODE,NEXUS6,PFAC,RESULTS,RMD,THREAD,THREADS,TITLE,TOTAL,USR
 S MODE=0,RMD=0 ; do not do reminder benchmark due to coversheet time variation
 D SETUP^ORVCO ; initalize variables
 ; set gbl and inf specific for benchmark
 S GBL=$NA(^XTMP("ORVCOBM",$J," Patients")),GBL("DPT")="^DPT" K @GBL
 S INF=$NA(^XTMP("ORVCOBM",$J)) K @INF
 S @INF@("Total")=$P($G(@GBL("DPT")@(0)),U,4)
 S @INF@(0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"Data in use by ORVCOBM (Benchmark)." ; set the xtmp
 S NEXUS6=$$LU^ORVCO(811.5,"VA-NEXUS CLINIC IN LAST THREE YEARS") ; 'All those moments will be lost in time, like tears in the rain...'
 ; create the patient list
 W @IOF,"Finding patients for the benchmark..."
 N DFN S DFN=0 F  S DFN=$O(@GBL("DPT")@(DFN)) Q:'+DFN!($G(CNT("Patients"))'<10000)  D
 . I +$$BE^ORVCODAEMON(DFN) S CNT("Test Patients")=+$G(CNT("Test Patients"))+1 Q  ; quit if test patient
 . I '+$$VISIT^ORVCODAEMON(DFN,1096) S CNT("No Visits")=+$G(CNT("No Visits"))+1 Q  ; quit if no visit in last 1096 days
 . S @GBL@(DFN)=$P($G(@GBL("DPT")@(DFN,0)),U),CNT("Patients")=+$G(CNT("Patients"))+1 ; save patients and count them
 . D SAY^XGF(0,(41-$L(CNT("Patients"))),CNT("Patients")) ; display # searched
 D CLEAR^XGF(0,0,23,80),IOXY^XGF(0,0),HEADER ; clear screen, display header
 ; main loop for benchmark tests
 F BM=0:1:ITERATIONS D  ;S THREADS=2**BM D
 . S THREADS=$S(BM=0:1,1:BM*5)
 . S INF=$NA(^XTMP("ORVCOBM",$J,"BM",BM+1,"Info"))
 . S @INF@("Threads")=THREADS
 . S @INF@("Mode")=MODE,@INF@("PFAC")=PFAC,@INF@("Title")=$S(+$P(MODE,U,2):TITLE("Reminders"),1:TITLE("Summary")),@INF@("User")=USR
 . D TOTEM^ORVCODAEMON(INF) ; set patient list variables
 . N IEN D BLOCKS^ORVCODAEMON(.THREADS,TOTAL) ; establish patient block sizes
 . S THREAD=0,DFN="" F  S DFN=$O(IEN(DFN)) Q:DFN=""  D
 . . S @INF@("Start Time")=$H
 . . N DUR S DUR=30 ; duration of benchmark
 . . D TASK^ORVCODAEMON(GBL,INF,DFN,IEN(DFN),THREAD,DUR)
 . . S THREAD=THREAD+1
 . D SAY^XGF(5+BM,0,$$CJ^XLFSTR("Test "_(BM+1)_" of "_(ITERATIONS+1)_" in progress...",80))
 . F  Q:+$G(@INF@("Complete"))
 . K @INF@(" Duration")
 . D OUTPUT(BM+1,.RESULTS)
 W !!,$$CJ^XLFSTR("< Benchmark Testing Complete >",IOM)
 D RESULTS,IOXY^XGF(20,0),PROMPT,CLEAN^XGF
 K ^XTMP("ORVCOBM",$J) ; just clean everything
 Q
HEADER ;
 N DATA D SAY^XGF(0,33,"Benchmark Tool"),SAY^XGF(0,72,$P($$HTE^XLFDT($H),"@",2))
 D SAY^XGF(2,9,"# of")
 D SAY^XGF(2,19,"Patients")
 D SAY^XGF(2,31,"Total")
 D SAY^XGF(2,41,"Avg")
 D SAY^XGF(2,52,"Max")
 D SAY^XGF(2,68,"Est. Time to")
 S DATA=$$SETSTR^VALM1("Test","",1,4)
 S DATA=$$SETSTR^VALM1("Threads",DATA,10,7)
 S DATA=$$SETSTR^VALM1("Processed",DATA,20,9)
 S DATA=$$SETSTR^VALM1("Time",DATA,32,5)
 S DATA=$$SETSTR^VALM1("Thread",DATA,42,10)
 S DATA=$$SETSTR^VALM1("Pt/Sec",DATA,53,6)
 S DATA=$$SETSTR^VALM1("Completion",DATA,69,12)
 W !,IOUON,DATA,IOUOFF
 ;D SAY^XGF(16,0,"*  includes time to start and complete all threads.")
 ;D SAY^XGF(18,0,"** based on evaluating all total patients.")
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
DTXT(DOCTXT) ; do section to populate document text
 N LINE,SECT F LINE=1:1 S SECT=$P($T(DATA+LINE),";;",2) Q:SECT=""  D  ; go through all sections of DATA
 . I $P($P(SECT,";"),U)="DISCL" D @$P(SECT,";") Q  ; always do disclaimer for both types
 . I '+RMD,$P($P(SECT,";"),U)'="RMDRS" D @$P(SECT,";") Q  ; for regular document(s), don't execute RMDRS section
 . I +RMD,$P($P(SECT,";"),U)="RMDRS" D @$P(SECT,";") Q  ; for clinical reminders document(s), don't execute non-RMDRS section
 Q
DATA    ;
 ;;DISCL^ORVCODATA02(DFN);DISCLAIMER
 ;;DEMO^ORVCODATA01(DFN);DEMOGRAPHICS
 ;;SCDIS^ORVCODATA01(DFN);SERVICE CONNECTED/DISABILITY
 ;;PRF^ORVCODATA01(DFN);PATIENT RECORD FLAGS
 ;;PROBLST^ORVCODATA01(DFN);PROBLEM LIST
 ;;ORDERS^ORVCODATA01(DFN);OPEN ORDERS
 ;;MEDS^ORVCODATA01(DFN);ALL MEDICATIONS
 ;;ALLERGIES^ORVCODATA01(DFN);ALLERGIES
 ;;SKIN^ORVCODATA01(DFN);SKIN TEST
 ;;IMMUINE^ORVCODATA01(DFN);IMMUNIZATIONS
 ;;IMAG^ORVCODATA01(DFN);IMAGING
 ;;FUTURE^ORVCODATA01(DFN);FUTURE VISITS
 ;;PAST^ORVCODATA02(DFN);PAST VISITS
 ;;RMDRS^ORVCODATA02(DFN);REMINDERS
 ;;
 Q
