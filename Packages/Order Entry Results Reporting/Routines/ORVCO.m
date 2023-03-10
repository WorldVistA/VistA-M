ORVCO ;SPFO/AJB - VISTA CUTOVER ;Feb 11, 2021@09:05:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;Dec 17, 1997;Build 17
 ;
 ; HOME^%ZIS        10086  ^DIC             10006   *^XLFDT          10103  *^XLFSHAN        6157
 ; *^%ZTLOAD        10063  ^DIK             10013   *^VADPT          10061  ^AUPNVSIT        2028
 ; $$TESTPAT^VADPT  3744   ^DIR             10026   ^UTILITY("VASD"  10061  *^XLFSTR         10104
 ; $$SETSTR^VALM1   10116  $$FIND1^DIC      2051    $$CRDD^TIUVCO    7179   *^%ZOSV          3883
 ; *^XGF            3173   *^VADPT          10061   $$EC^%ZOSV       10097  $$GET1^DIQ       2056
 ; *^XMD            10070  ^DPT             10035
 Q
EN(THREADS) ; Entre Nous
 N MODE S MODE="1" S THREADS=+$G(THREADS) G CONTINUE
TST(THREADS) ; Test for Echo
 I '$G(MODE) N MODE S MODE="0",THREADS=+$G(THREADS)
CONTINUE ; Counterparts
 N C,POP,X,Y D HOME^%ZIS,PREP^XGF
 N CRD,DFN,EXIT,INF,PFAC,PtName,RMD,TITLE,USR
 D SETUP S:+$G(DEVMODE) EXIT=1
 I $D(@INF) W !," This Job #",$J," is already running tasks.",! D PROMPT Q
 I '+$G(DUZ) W !," Your DUZ is not defined.  'We have assumed control...'",! G EXIT
 ; display intro text
 S:'+$G(DEVMODE) EXIT=$$DISP($S(CRD=1:"CREATE",1:"TEST")) G:'+EXIT EXIT
 S EXIT=$$FMR("YAO"," Do you wish to select a single patient? ",$S(+$G(DEVMODE):"NO",1:"YES"),"") G:EXIT=U EXIT
 I +EXIT S DFN=$$GPT,PtName=$P(DFN,U,2),DFN=+DFN G:DFN'>0 EXIT ; if no patient selected exit
 I '+$G(DFN) S $P(MODE,U,2)=$$FMR("YAO"," Do you wish to "_$S(+CRD:"create",1:"test")_" the Clinical Reminders cutover documents? ","NO","") G:$P(MODE,U,2)="" EXIT
 ; if patient selected...<voice of Emperor> Do it!
 I +$G(DFN) D ONE(DFN) G EXIT ; One (Patient) Little Victory
 ; All The World's A Stage
 I '$$FMR("YAO"," Continue for all patients? ",$S(+$G(DEVMODE):"YES",1:"NO"),"") G EXIT
 D SPAWN^ORVCODAEMON(THREADS) ; 'All this machinery making modern music can still be open hearted...'
 Q
EXIT ; Exit...Stage Left
 D CLEAN^XGF
 K ^XTMP("ORVCO",$J) ; 'Suddenly you were gone from all the lives you left your mark upon...'
 Q
ONE(DFN) ; 'A certain measure of innocence...'
 N $ETRAP,$ESTACK,TIME S $ETRAP="D ERR^ORVCO"
 W @IOF,$S(+CRD:" Creating documents for: ",1:" Initiating data test for: "),PtName,!
 F RMD=1,0 D  ; do both document types
 . N DA,DOCTXT
 . S @INF@("Start Time")=$H,@INF@("Single Patient")=1
 . S DOCTXT=0 D DTXT(.DOCTXT) ; The Main Monkey Business
 . ; quit here in test mode
 . I '+CRD S @INF@("Stop Time")=$H Q  ; 'Memory banks unloading, bytes breaking to bits...'
 . S DA=$$CREATE^TIUVCO(DFN,+TITLE($S(+RMD:"Reminders",1:"Summary")),.DOCTXT,USR)
 . I '+DA D  Q
 . . S @INF@("Errors")=$G(@INF@("Errors"))+1 ; 1001001
 . . S @INF@("Errors",@INF@("Errors"),+$G(DFN),PtName)=$P(DA,U,2) ; 100100
 . . S @INF@("Stop Time")=$H
 . S @INF@("Stop Time")=$H
 . W !," Document created:  ",$P(TITLE($S(+RMD:"Reminders",1:"Summary")),U,2)
 I '+CRD W !," Data test complete." I '$D(@INF@("Errors")) W "  No errors encountered.",! D TIME,PROMPT Q
 ; 'Handle with kid gloves...'
 I +$G(@INF@("Errors")) D  W !,$$CJ^XLFSTR("Please contact support for assistance in resolving the error"_$S(@INF@("Errors")>1:"s.",1:"."),80),! ; Show Don't Tell
 . N CNT W !!," Errors Encountered:" S CNT=0 F  S CNT=$O(@INF@("Errors",CNT)) Q:'+CNT  W ?22,@INF@("Errors",CNT,DFN,PtName),!
 W:'$D(@INF@("Errors")) ! D TIME,PROMPT
 Q
TIME ; 'Freeze this moment a little bit longer...'
 N DATA,DUR,GBL,STR S STR=" Clinical Reminder Evaluation: "
 S DUR("CPU")=@INF@(" Duration","Reminders [CPU]")/1000,DUR("SEC")=@INF@(" Duration","Reminders [SECS]"),DUR=DUR("CPU")+DUR("SEC"),DUR=$FN(DUR,"",3)
 S STR=$$SETSTR^VALM1(DUR,STR,32,$L(DUR)) W !,STR_$S(DUR'<1:"*",1:"")_" s"
 S GBL="^DPT",DATA=$P(@GBL@(0),U,4),DUR=DUR*DATA,DUR=$$CNVRT(DUR)
 W !!," Estimated time to process ",DATA," patients: ",DUR,!
 I (DUR("SEC")+DUR("CPU"))'<1 D
 . W !," * Desired evaluation time should be less than 1 second."
 . W !!,"   Use the 'CPRS Coversheet Time Test' option [PXRM CPRS TESTER] to discover"
 . W !,"   the slowest reminders and remove from your CPRS coversheet if possible.",!
 Q
CNVRT(SEC) ; 'We are the priests of the Temples of Syrinx...'
 Q:SEC'>60 $FN(SEC,"",2)_" sec"
 Q:SEC'>3600 (SEC\60)_" min "_$S($L($FN((SEC#60),"",0))'>1:"0"_$FN((SEC#60),"",0),1:$FN((SEC#60),"",0))_" sec"
 Q (SEC\3600)_" hr "_((SEC#3600)\60)_" min "_$S($L($FN(((SEC#3600)#60),"",0))'>1:"0"_$FN(((SEC#3600)#60),"",0),1:$FN(((SEC#3600)#60),"",0))_" sec"
SETUP ; Where's My Thing?
 S:'$D(DTIME) DTIME=$$DTIME^XUP($G(DUZ)) S:'$D(U) U="^" S:'$D(DT) DT=$$DT^XLFDT
 S INF=$NA(^XTMP("ORVCO",$J,"Info"))
 S CRD=+$G(MODE) ; create documents, default=0 [no]
 S PFAC=$P($$SITE^VASITE,U,2) ; primary facility
 ; duz^duz(2)^name^title
 S USR=$G(DUZ),$P(USR,U,2)=$G(DUZ(2)),$P(USR,U,3)=$$SIGNAME^TIULS($G(DUZ)),$P(USR,U,4)=$$SIGTITL^TIULS($G(DUZ))
 ; TITLE(<type>=ien^name
 S $P(TITLE("Reminders"),U,2)=$E("EHRM CUTOVER REMINDERS "_PFAC,1,60),$P(TITLE("Reminders"),U)=$$LU(8925.1,$P(TITLE("Reminders"),U,2),"X","I $P(^(0),U,4)=""DOC""")
 S $P(TITLE("Summary"),U,2)=$E("EHRM CUTOVER "_PFAC,1,60),$P(TITLE("Summary"),U)=$$LU(8925.1,$P(TITLE("Summary"),U,2),"X","I $P(^(0),U,4)=""DOC""")
 Q
DTXT(DOCTXT) ; do section to populate document text
 N LINE,SECT F LINE=1:1 S SECT=$P($T(DATA+LINE),";;",2) Q:SECT=""  D  ; go through all sections of DATA
 . I $P($P(SECT,";"),U)="DISCL" D @$P(SECT,";") Q  ; always do disclaimer for both types
 . I '+RMD,$P($P(SECT,";"),U)'="RMDRS" D @$P(SECT,";") Q  ; for regular document(s), don't execute RMDRS section
 . I +RMD,$P($P(SECT,";"),U)="RMDRS" D @$P(SECT,";") Q  ; for clinical reminders document(s), don't execute non-RMDRS section
 Q
ERR ; record error, reset error code
 S @INF@("Errors")=$G(@INF@("Errors"))+1
 S @INF@("Errors",@INF@("Errors"),+$G(DFN),$S($G(PtName)="":"<none>",1:PtName))=$$EC^%ZOSV
 S $ECODE=""
 Q
GPT() ; ask user for patient
 N %H,%I,DIC,DILOCKTM,DISYS,DTOUT,DUOUT,X,Y
 S DIC=2,DIC(0)="AEIMQ",DIC("A")=" Select PATIENT NAME: " W !,$G(IOCUON) D ^DIC
 Q Y
PROMPT ; 'Message transmitted, message received...'
 I $$FMR("EA"," Press <ENTER> to continue")
 Q
LU(FILE,NAME,FLAGS,SCREEN,INDEXES,IENS) ;
 N C,DILOCKTM,DISYS
 Q $$FIND1^DIC(FILE,$G(IENS),$G(FLAGS),$G(NAME),$G(INDEXES),$G(SCREEN),"ERR")
 ; 'Suddenly, you were gone from all the lives you left your mark upon...'
DELDOCS  ; delete all EHRM documents, dev use only in programmer mode
 N DOC,GBL,IEN,PFAC,SCR,X S GBL="^TIU(8925)"
 S DT=$$DT^XLFDT,PFAC=$P($$SITE^VASITE,U,2),SCR="I $P(^(0),U,4)=""DOC"""
 F DOC="EHRM CUTOVER","EHRM CUTOVER REMINDERS" D
 . S DOC=DOC_$S(PFAC'="":" "_PFAC,1:""),DOC=$$LU(8925.1,DOC,"X",SCR) Q:'+DOC
 . S IEN=0 F  S IEN=$O(@GBL@("B",DOC,IEN)) Q:'+IEN  D
 . . N DA,DIK S DA=IEN,DIK="^TIU(8925," D ^DIK
 Q
NUMDOCS ; number of documents existing
 N DOC,IEN,GBL,PFAC,SCR,X S GBL="^TIU(8925)"
 S DT=$$DT^XLFDT,PFAC=$P($$SITE^VASITE,U,2),SCR="I $P(^(0),U,4)=""DOC"""
 F DOC="EHRM CUTOVER","EHRM CUTOVER REMINDERS" D
 . S DOC=DOC_$S(PFAC'="":" "_PFAC,1:""),DOC=$$LU(8925.1,DOC,"X",SCR) Q:'+DOC
 . S IEN=0 F  S IEN=$O(@GBL@("B",DOC,IEN)) Q:'+IEN  S X(DOC)=$G(X(DOC))+1
 W ! S X=0 F  S X=$O(X(X)) Q:'+X  W !,X,?10,X(X)
 Q
DISP(OPT) ; display intro wall of text
 N DATA,I,PROD W:$D(IOF) @IOF S PROD=+$$PROD^XUPROD(1)
 F I=1:1 S DATA=$P($T(@OPT+I),";;",2) Q:DATA="EOM"  D
 . W !,DATA
 W !!," [TEST MODE: "_$S(+$G(CRD):"OFF]",1:"ON]"),?32,"Document(s) ",$S(+$G(CRD):"will",1:"will NOT")," be created."
 W !!," [PRODUCTION: "_$S(+PROD:"YES]",1:"NO]"),?32 W:'+PROD "NOT a " W:+PROD IOBON,IORVON W "Production environment.",IOBOFF,IORVOFF,!
 Q $$FMR("YAO"," Do you wish to continue? ",$S(+PROD:"NO",1:"YES"),"")
FMR(DIR,PRM,DEF,HLP,SCR) ; fileman reader
 N DILN,DILOCKTM,DISYS
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=DIR S:$G(PRM)'="" DIR("A")=PRM S:$G(DEF)'="" DIR("B")=DEF S:$G(SCR)'="" DIR("S")=SCR
 I $G(HLP)'="" S DIR("?")=HLP
 I $D(HLP) M DIR=HLP
 W $G(IOCUON) D ^DIR W $G(IOCUOFF)
 Q $S($D(DIROUT):U,$D(DIRUT):U,$D(DTOUT):U,$D(DUOUT):U,1:Y)
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
CREATE ;
 ;; VistA Cutover Document Create
 ;;
 ;; This option may be run for a single patient or all patients that have had an
 ;; inpatient, outpatient or clinic visit in the last 3 years.
 ;;
 ;; Single patient selection will automatically create both EHRM document titles
 ;;
 ;; Multiple patient selection will allow you to choose to create the standard
 ;; EHRM Cutover document or the EHRM Clinical Reminders Cutover document.
 ;;
 ;; Document creation for all patients will initiate a task that may take several
 ;; hours to complete.
 ;;
 ;; You will receive a detailed email message when the task has been completed.
 ;;EOM
TEST ;
 ;; TEST Mode will simulate creating one or more cutover documents.
 ;;
 ;; However, documents will NOT be created.
 ;;
 ;; This test may be run for a single patient or all patients that have had an
 ;; inpatient, outpatient or clinic visit in the last 3 years.
 ;;
 ;; If an error is encountered while running for all patients, you will receive
 ;; an email message with details of the error.
 ;;EOM
