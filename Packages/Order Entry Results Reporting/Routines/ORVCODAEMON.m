ORVCODAEMON ;SPFO/AJB - VISTA CUTOVER ;Feb 19, 2021@09:28:36
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;Dec 17, 1997;Build 17
 Q
 ; see ORVCO for list of ICRs/DBIAs
SPAWN(THREADS) ; spawn daemon tasks
 W @IOF
 N IEN,INF,GBL,NEXUS6,THREAD,TOTAL
 S ^XTMP("ORVCO",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"Data for VistA Cutover event." ; set the main xtmp
 S GBL("DPT")="^DPT",GBL=$NA(^XTMP("ORVCO",$J," Patients")) K @GBL ; 'This was something more...'
 S INF=$NA(^XTMP("ORVCO",$J,"Info")) K @INF ; 'But he's a lot more afraid of your lying...'
 D NEUROTICA(.GBL,INF) ; @Roll the Bones
 S THREADS=$S(THREADS>99:99,'+THREADS:1,1:THREADS),@INF@("Threads")=$S(+THREADS:THREADS,1:1) ; set the threads, max threads=99
 W " Evaluating patients...",?32,"of ",TOTAL("FM")
 ; 'You can do a lot in a lifetime if you don't burn out too fast...'
 N CNT,DFN S (CNT("Patients"),DFN)=0 F  S DFN=$O(@GBL("DPT")@(DFN)) Q:'+DFN  D
 . S CNT("Actual")=+$G(CNT("Actual"))+1 ; count all actual patients
 . D SAY^XGF(0,(31-$L(CNT("Actual"))),CNT("Actual")) ; display # searched
 . I +$$BE(DFN) S CNT("Test Patients")=+$G(CNT("Test Patients"))+1 Q  ; Tyrell patient?
 . I '+$$VISIT(DFN,1096) S CNT("No Visits")=+$G(CNT("No Visits"))+1 Q  ; quit if no visit in last 1096 days
 . S @GBL@(DFN)=$P($G(@GBL("DPT")@(DFN,0)),U),CNT("Patients")=+$G(CNT("Patients"))+1 ; save patients and count them
 I +$P(MODE,U,2) D
 . W !!?1,CNT("Patients")," patients ",$S('+CRD:"will be tested for the EHRM Cutover.",1:"may have documents created for the EHRM Cutover.")
 . W !!?1,"Patients must have a primary care visit in the last 3 years for reminders"
 . W !?1,"documents.",!
 W:'+$P(MODE,U,2) !!?1,CNT("Patients")," patients ",$S('+CRD:"will be tested for the EHRM Cutover.",1:"will have documents created for the EHRM Cutover."),!
 S EXIT=$$FMR^ORVCO("YAO"," Ready to continue? ","YES","") G:'+EXIT EXIT^ORVCO  W "  Excellent.",!!," Use the Monitor/Stop Cutover Jobs option to track or stop the progress."
 D TOTEM(INF) ; @Test for Echo
 D BLOCKS(.THREADS,TOTAL) ; establish the blocks of patients
 S THREAD=0,DFN="" F  S DFN=$O(IEN(DFN)) Q:DFN=""  D
 . D TASK(GBL,INF,DFN,IEN(DFN),THREAD,0) ; hard coded 0 for NOT benchmark
 . S THREAD=THREAD+1
 W ! D PROMPT^ORVCO,CLEAN^XGF
 Q
DAEMON(GBL,INF,IEN,BROOD,THREAD,BMARK) ; create background tasks, non-interactive
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ORVCO" ; error trap
 S ZTREQ="@" ; delete thread from TaskMan if complete ok
 N CNT,CRD,DFN,PFAC,RMD,Title,TIME,TOTAL,USR
 L +@INF@("Started Threads"):5
 S @INF@("Started Threads")=@INF@("Started Threads")+1
 L -@INF@("Started Threads"):5
 S @INF@(" Daemon",THREAD,"Start Time")=$H ; 'Summer's going fast, nights growing colder...'
 ; set everything from xtmp
 S CRD=@INF@("Mode"),RMD=$P(CRD,U,2),CRD=+CRD,PFAC=@INF@("PFAC"),Title=@INF@("Title"),TOTAL=@INF@("Patients"),USR=@INF@("User"),CNT("No Primary Care")=0
 ; set count interval based on reminders or summary document
 S CNT("Interval")=$FN(TOTAL*$S(+RMD:.01,1:.02),"",0),CNT("Interval")=$S(+CNT("Interval"):CNT("Interval"),1:1)
 I +BMARK S TIME=$P($H,",",2)+BMARK ; duration of the benchmark
 ; 'Where would you rather be?
 S CNT("Processed")=0,DFN=IEN F  S DFN=$O(@GBL@(DFN)) Q:'+DFN  D  Q:CNT("Processed")=BROOD  I +BMARK Q:$P($H,",",2)'<TIME
 . ; count each patient
 . S CNT("Processed")=CNT("Processed")+1
 . ; check if TaskMan has asked to stop at each interval, quit if yes
 . I '(CNT("Processed")#CNT("Interval")),+$$S^%ZTLOAD D  Q
 . . S (@INF@("Stopped by TaskMan"),@INF@(" Daemon",THREAD,"Stopped"))=1
 . . S @INF@(" Daemon",THREAD,"Processed")=CNT("Processed")
 . . S CNT("Processed")=BROOD,ZTSTOP=1
 . ; if reminders, help the tortoise
 . I +RMD,'+$$NEXUS6(DFN,NEXUS6) S CNT("No Primary Care")=+$G(CNT("No Primary Care"))+1,@INF@(" Daemon",THREAD,"Progress")=CNT("Processed") Q
 . N PtName S PtName=@GBL@(DFN),PtName=$S(+$L(PtName):PtName,1:"<name unknown>")
 . N DOCTXT S DOCTXT=0 D DTXT(.DOCTXT) ; get document text
 . ; track progress at the interval or if benchmarking
 . I '(CNT("Processed")#CNT("Interval"))!(+BMARK) S @INF@(" Daemon",THREAD,"Progress")=CNT("Processed")
 . Q:'+CRD  ; quit here test mode
 . N DA S DA=$$CREATE^TIUVCO(DFN,+Title,.DOCTXT,USR) I '+DA D  Q  ; create document
 . . S @INF@("Errors")=@INF@("Errors")+1,@INF@("Errors",@INF@("Errors"),+$G(DFN),PtName)=$P(DA,U,2)
 . S CNT("Documents")=$G(CNT("Documents"))+1
 S:'$D(ZTSTOP) (@INF@(" Daemon",THREAD,"Processed"),@INF@(" Daemon",THREAD,"Progress"))=CNT("Processed")
 S @INF@(" Daemon",THREAD,"Documents")=+$G(CNT("Documents"))
 S @INF@(" Daemon",THREAD,"No Primary Care")=+$G(CNT("No Primary Care"))
 L +@INF@("Stop Count"):5
 S @INF@("Stop Count")=$G(@INF@("Stop Count"))+1
 L -@INF@("Stop Count"):5
 S @INF@(" Daemon",THREAD,"Stop Time")=$H
 S @INF@(" Daemon",THREAD,"Elapsed")=$$HDIFF^XLFDT(@INF@(" Daemon",THREAD,"Stop Time"),@INF@(" Daemon",THREAD,"Start Time"),2)
 S @INF@(" Daemon",THREAD,"Start Time")=$$HTE^XLFDT(@INF@(" Daemon",THREAD,"Start Time"))
 S @INF@(" Daemon",THREAD,"Stop Time")=$$HTE^XLFDT(@INF@(" Daemon",THREAD,"Stop Time"))
 I @INF@("Stop Count")=$S(+$G(ZTSTOP):@INF@("Started Threads"),1:@INF@("Threads")) D
 . S @INF@("Stop Time")=$H
 . S @INF@("Elapsed")=$$HDIFF^XLFDT(@INF@("Stop Time"),@INF@("Start Time"),2)
 . S @INF@("Start Time")=$$HTE^XLFDT(@INF@("Start Time"))
 . S @INF@("Stop Time")=$$HTE^XLFDT(@INF@("Stop Time"))
 . S THREAD=0 F  S THREAD=$O(@INF@(" Daemon",THREAD)) Q:'+THREAD  D
 . . S @INF@("Processed")=+$G(@INF@("Processed"))+$G(@INF@(" Daemon",THREAD,"Processed"))
 . . S @INF@("Documents")=+$G(@INF@("Documents"))+$G(@INF@(" Daemon",THREAD,"Documents"))
 . . S @INF@("No Primary Care")=+$G(@INF@("No Primary Care"))+$G(@INF@(" Daemon",THREAD,"No Primary Care"))
 . S @INF@("Patients")=@INF@("Patients")-$G(@INF@("No Primary Care"))
 . ; send completion info and clean up
 . S @INF@("Complete")=1
 . D:'+$G(BMARK) THEGARDEN^ORVCOEND ; the end
 Q
NEUROTICA(GBL,INF) ; 'You just don't get it...what it is, well you're not really sure...'
 S @INF@("Calculating")=1
 S NEXUS6=$$LU^ORVCO(811.5,"VA-NEXUS CLINIC IN LAST THREE YEARS") ; 'All those moments will be lost in time, like tears in the rain...'
 S TOTAL("FM")=$P($G(@GBL("DPT")@(0)),U,4),@INF@("FM Total")=TOTAL("FM") ; patient total reported by FileMan (not always accurate)
 Q
TOTEM(INF) ; 'I believe that what I'm feeling changes how the world appears...'
 S @INF@("Actual")=$G(CNT("Actual"))
 S @INF@("No Visits")=+$G(CNT("No Visits"))
 S @INF@("Test Patients")=+$G(CNT("Test Patients"))
 S (TOTAL,@INF@("Patients"))=$G(CNT("Patients")) ; total # of patients that meet criteria
 S @INF@("Errors")=0,@INF@("Mode")=MODE,@INF@("Start Time")=$H,@INF@("User")=USR
 S @INF@("PFAC")=PFAC
 S @INF@("Title")=$S(+$P(MODE,U,2):TITLE("Reminders"),1:TITLE("Summary"))
 S:$D(CNT("No Primary Care")) @INF@("No Primary Care")=CNT("No Primary Care")
 S (@INF@("Started Threads"),@INF@("Calculating"))=0
 Q
BLOCKS(THREADS,TOTAL) ;
 N BLOCKS,CNT,DFN,THREAD
 S BLOCKS=TOTAL\THREADS I '+BLOCKS D  ; when you ask for more threads than there are patients to evaluate
 . S BLOCKS=1,THREADS=TOTAL,@INF@("Threads")=TOTAL
 S (CNT,DFN)=0 F THREAD=0:1:THREADS D
 . ; begin patient record loop, quits at block size or if cnt=0 continues through entire global (last block)
 . F  S DFN=$O(@GBL@(DFN)) Q:'+DFN  D  I THREAD'=THREADS Q:CNT=$S(+BLOCKS:BLOCKS,1:CNT)
 . . S CNT=CNT+1
 . S CNT=0 ; reset block count
 . I +DFN D  Q
 . . I THREAD=0 D  Q:THREADS=1  ; if starting thread (starts at 0 dfn) at increments, quits if total requested threads=1
 . . . S IEN(0)=$S(THREAD=(THREADS-1):0,+BLOCKS:BLOCKS,1:1) ; if last thread, set block size to 0
 . . . S THREAD=THREAD+1
 . . S IEN(DFN)=$S(THREAD=(THREADS-1):0,+BLOCKS:BLOCKS,1:1)
 Q
TASK(GBL,INF,IEN,BROOD,THREAD,BMARK) ; background task, non-interactive
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK S THREAD=THREAD+1
 S ZTDESC="daemon "_THREAD_" (non-interactive)" ; description
 S ZTDTH=$H,ZTIO="" ; dt/time, device
 S (ZTSAVE("NEXUS6"),ZTSAVE("GBL"),ZTSAVE("INF"),ZTSAVE("IEN"),ZTSAVE("BROOD"),ZTSAVE("THREAD"),ZTSAVE("BMARK"))="" ; 'I'll be around, if you don't let me down...'
 S ZTRTN="DAEMON^ORVCODAEMON(GBL,INF,IEN,BROOD,THREAD,BMARK)"
 D ^%ZTLOAD S @INF@(ZTSK)=""
 Q
BE(DFN) ; The Body Electric? aka Am I a Test Patient?
 N GBL,NODE S GBL="^DPT" I $D(@GBL@("ATEST",DFN)) Q 1
 S NODE=$G(@GBL@(DFN,0)) Q:'+$P(NODE,U,3) 1 ; no DOB
 Q:+$P(NODE,U,21) 1 ; test patient indicator
 Q:$E($P(NODE,U,9),1,5)="00000" 1
 ; activate this line after testing Puget Sound
 ;Q:$E($P(NODE,U),1,2)="ZZ" 1_U_"Last name starts with ZZ"
 Q 0
NEXUS6(DFN,TERMIEN) ; N6MAA10816 - Primary care visit in last 3 years?
 ; input IEN of reminder term:  VA-NEXUS CLINIC IN LAST THREE YEARS
 I '+TERMIEN Q 1  ; default to yes if term is missing
 N FIEVAL,FINDPA,ROU,TERMARR
 S ROU="TERM^PXRMLDR(TERMIEN,.TERMARR)" D @ROU
 S $P(FINDPA(0),U,14)=1
 S ROU="IEVALTER^PXRMTERM(DFN,.FINDPA,.TERMARR,1,.FIEVAL)" D @ROU
 Q $G(FIEVAL(1))
VISIT(DFN,X) ; DBIA #2028 returns if patient has visit in X days
 N GBL,LASTV S:'+$G(DT) DT=$$DT^XLFDT S GBL="^AUPNVSIT"
 S LASTV="",LASTV=$O(@GBL@("C",DFN,LASTV),-1) ; VISIT FILE #9000010
 S:+LASTV LASTV=$P($G(@GBL@(LASTV,0),-1),U),LASTV=$$FMDIFF^XLFDT(DT,LASTV) Q:LASTV'>X 1
 ; check outpatient encounter
 S GBL="^SCE(""ADFN"")",LASTV="",LASTV=$O(@GBL@(DFN,LASTV),-1) Q:'+LASTV 0  ; file #409.68
 S LASTV=$$FMDIFF^XLFDT(DT,LASTV) Q:LASTV'>X 1
 Q 0
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
