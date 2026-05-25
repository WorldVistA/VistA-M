IBJPI3 ;AITC/CKB - INSURANCE VERIFICATION SITE PARAMETERS SCREEN ACTIONS ; 30-OCT-2024
 ;;2.0;INTEGRATED BILLING;**806**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;
 Q
 ;
BUFDUP ;-- IBJP IIV BUFFER DUPLICATE (BC) - IB*806/CKB
 N DA,DR,DIE,DIC,X,Y
 ;
 D FULL^VALM1
 W @IOF,!,"Buffer Cleanup",!
 S DR="[IBCN BU BUFFER CLEANUP]"
 S DIE="^IBE(350.9,",DA=1
 D ^DIE K DA,DR,DIE,DIC,X,Y
 ;
 D INIT^IBJPI S VALMBCK="R"
 Q
 ;
 ;-----------------------------------------------------------------------------
 ;
BUFCLN(IBRUN,IBQUAL,IBNUM) ; Clean up Buffer of Duplicate entries -IB*806/CKB
 ; called from IBCNINS - eInsurance Nightly Process
 ;    IBRUN = Run buffer cleanup = 1 / Do not run buffer cleanup = 0
 ;   IBQUAL = "A" - ALL / "N" - Number of buffer entries
 ;    IBNUM = (QUAL=A) = "" / (QUAL=N) = # of buffer entries
 ;
 N IBA,IBDUZ,IBERR,IBXTMPNM,ZTDESC
 ;
 ; Get Proxy User
 S IBDUZ=+$$FIND1^DIC(200,,"MX","IB,BUFFER CLEANUP")
 I IBDUZ="" Q  ; if the Proxy User doesn't exist do not continue
 I IBRUN="" Q
 I $G(IBQUAL)'="" S IBQUAL=$$UP^XLFSTR(IBQUAL)
 I $G(IBQUAL)'="" I "A/N/"'[IBQUAL Q
 I $G(IBQUAL)="N",$G(IBNUM)="" Q
 ;
 S IBXTMPNM="IBJPI3_CLEANUP_BUFFER_DUPLICATES"
 S ZTDESC="IB eInsurance Duplicate Buffer Cleanup"
 ; if not running cleanup, don't task up - run to the screen
 I IBRUN=0 D BUFREJ G BUFCLNX
 ;
 S IBERR=$$TASKIN("Duplicate Buffer Cleanup",$G(IBDUZ),"IBMSG",IBRUN,IBQUAL,IBNUM)
 ;
BUFCLNX ; Exit Clean up Buffer
 Q
 ;
BUFREJ ; Identify duplicate buffer entries and indicate the entries 
 ; to be Rejected
 ;
 ;  IBRUN = Run buffer cleanup = 1 / Do not run buffer cleanup = 0
 ; IBQUAL = "A" - ALL / "N" - Number of buffer entries
 ;  IBNUM =  A = "" / N = # of buffer entries
 ;
 N FILE,FIELDS,IBARY,IBBUFDA,IBCNDT,IBCNT
 K ^TMP($J,"IBCNINS"),^TMP("REJECT",$J)
 ;
 I '$$FIND1^DIC(200,,"MX","IB,BUFFER CLEANUP") Q    ;if the Proxy User doesn't exist do not continue
 ; *** CHANGE USER if running in the BACKGROUND
 I $G(IBDUZ) N DUZ S DUZ=IBDUZ
 Q:'DUZ
 ;
 ; Only run the cleanup if the BUFFER CLEANUP ENABLED field set to 'YES' or '1', if not Quit
 ;  ** don't check if running the "what if" IBRUN=0
 I IBRUN'=0 I $$GET1^DIQ(350.9,"1,",54.03)'="YES" G BUFREJEX   ;Buffer Cleanup switch not enabled
 ;
 S IBCNT=0 ;initialize count
 S FILE=355.33
 S FIELDS=".04;20.01;60.01;90.02;90.03"
 ;   Only Reject entries prior to Today - ($P(IBCNDT,".")=DT)
 S IBCNDT=0 F  S IBCNDT=$O(^IBA(355.33,"AEST","E",IBCNDT)) Q:('IBCNDT)!($P(IBCNDT,".")=DT)  D
 . S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AEST","E",IBCNDT,IBBUFDA)) Q:'IBBUFDA  D
 . . N IBDT,IBGRP,IBINS,IBPATNM,IBSTAT,IBSUBID,IENS
 . . S IENS=IBBUFDA_","
 . . S IBDT=$$GET1^DIQ(FILE,IENS,.01,"I")
 . . I (IBDT="")!('$D(^IBA(355.33,IBBUFDA,0))) Q    ; bad record, quit
 . . K IBARY
 . . D GETS^DIQ(FILE,IENS,FIELDS,"EI","IBARY")
 . . S IBSTAT=IBARY(FILE,IENS,.04,"I")
 . . I IBSTAT'="E" Q    ; only checking entries with an ENTERED status, quit
 . . S IBPATNM=IBARY(FILE,IENS,60.01,"E")
 . . S IBINS=IBARY(FILE,IENS,20.01,"E") I IBINS="" S IBINS="NONE"
 . . S IBGRP=IBARY(FILE,IENS,90.02,"E") I IBGRP="" S IBGRP="NONE"
 . . S IBSUBID=IBARY(FILE,IENS,90.03,"E") I IBSUBID="" S IBSUBID="NONE"
 . . ; Remove any non-alpha numeric characters
 . . I IBSUBID'="" S IBSUBID=$$STRIP^IBCNEDE3(IBSUBID)
 . . ; There is already an entry in our array, check to see if it's a duplicate
 . . I $D(^TMP($J,"IBCNINS",IBPATNM,IBINS,IBGRP,IBSUBID)) D
 . . . N IBPCT
 . . . ;Add duplicate entry, store in array to be Rejected 
 . . . S ^TMP("REJECT",$J,IBPATNM,IBBUFDA)=IBINS_U_IBGRP_U_IBSUBID
 . . . S IBPCT=$G(^TMP("REJECT",$J,IBPATNM)),IBPCT=IBPCT+1
 . . . S ^TMP("REJECT",$J,IBPATNM)=IBPCT
 . . ; Store in array of buffer entries
 . . S ^TMP($J,"IBCNINS",IBPATNM,IBINS,IBGRP,IBSUBID,IBBUFDA)=""
 ;
 D REJECT
 ; Only store the BUFFER CLEANUP LAST RUN if the cleanup was actually run (IBRUN=1)
 I IBRUN=0 G BUFREJEX
 ;
 ; Update the BUFFER CLEANUP LAST RUN field #54.04 
 N DA,DIE,DR
 S DIE="^IBE(350.9,",DA=1,DR="54.04///NOW" D ^DIE
 ;
BUFREJEX ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J,"IBCNINS"),^TMP("REJECT",$J)
 Q
 ;
REJECT ; Reject OR create a list of entries that would be rejected
 ; loop through ^TMP("REJECT",$J,[patient name],[buffer ien])
 N BIEN,GRP,HDR,IBOK,IBRTN,IBSUPRES,INS,PATNAM,REC,REJCNT,SUBID
 S (IBOK,REJCNT)=0,IBRTN="IBJPI3"
 ;
 ; If IBRUN=0 write Header for the list of entries that would ("what if") be rejected
 I IBRUN=0 W !,"Duplicate Buffer Entries Cleanup",! D  W !
 . S HDR="Patient Name"_U_"Buffer IEN"_U_"Insurance Company"_U_"Group Number"_U_"Subscriber ID"
 . W !,HDR,! N I F I=1:1:$L(HDR) W "="
 ;
 S PATNAM="" F  S PATNAM=$O(^TMP("REJECT",$J,PATNAM)) Q:PATNAM=""  D
 . S BIEN="" F  S BIEN=$O(^TMP("REJECT",$J,PATNAM,BIEN)) Q:'BIEN!(BIEN="")  D
 . . S REC=^TMP("REJECT",$J,PATNAM,BIEN)
 . . S INS=$P(REC,U),GRP=$P(REC,U,2),SUBID=$P(REC,U,3)
 . . ;DO NOT reject Buffer entries with an ASSOCIATED IMAGE (#355.33,.19)
 . . I $$GET1^DIQ(355.33,BIEN_",",.19,"I")=1 Q
 . . ;create list of entries that would be rejected
 . . S REJCNT=REJCNT+1
 . . I IBRUN=0,$G(IBQUAL)="N" I REJCNT>$G(IBNUM) Q
 . . I IBRUN=0 S IBOK=1 W PATNAM,U,BIEN,U,INS,U,$S(GRP="NONE":"",1:GRP),U,$S(SUBID="NONE":"",1:SUBID),!
 . . ;Reject duplicate entries
 . . I IBRUN=1 S IBBUFDA=BIEN D
 . . . L +^IBA(355.33,IBBUFDA):15 I '$T Q
 . . . D REJECT^IBCNBAR(IBBUFDA,IBRTN)
 . . . L -^IBA(355.33,IBBUFDA)
 . . . Q
 . . Q
 ;
 I IBRUN=0,IBOK=0 W "** NONE **",!
 Q
 ;
TASKIN(IBSB,IBDUZ,IBRET,IBRUN,IBQUAL,IBNUM) ; Task Duplicate Buffer Cleanup 
 ;INPUT:
 ;   IBSB - message subject
 ;  IBDUZ - user DUZ to use - IB,BUFFER CLEANUP
 ;  IBRET - message return array to calling entity passed in as "VARIABLE"
 ;  IBRUN - Run buffer cleanup = 1 / Do not run buffer cleanup = 0
 ; IBQUAL - "A" - ALL / "N" - Number of patients
 ;  IBNUM - (IBQUAL=A) = "" / (IBQUAL=N) = # of patients
 ;
 N IBA,IBB,MSG,RMSG,ZTDTH,ZTIO,ZTQUEUED,ZTRTN,ZTSAVE
 ;
 S IBSB=$G(IBSB)
 S IBDUZ=$G(IBDUZ) S:IBDUZ="" IBDUZ=$G(DUZ)
 S IBRET=$G(IBRET) I IBRET="" Q "1^Need return array"
 K @IBRET
 S IBRET="IBMSG"    ; IBRET - message return array to calling entity passed in as "VARIABLE"
 ;
 ;  ZTDTH = TODAY AT 10:00 PM
 S ZTDTH=$P($$NOW^XLFDT(),"."),ZTDTH=$$FMADD^XLFDT(ZTDTH,,22)
 S ZTIO=""
 S ZTQUEUED=1
 S ZTRTN="BUFREJ^IBJPI3"
 S ZTSAVE("IBDUZ")="",ZTSAVE("IBSB")="",ZTSAVE("IBXTMPNM")=""
 S ZTSAVE("IBRUN")="",ZTSAVE("IBQUAL")="",ZTSAVE("IBNUM")=""
 ;
 S @IBRET@(0)=1
 S RMSG(0)="",MSG=$$TASK(ZTDTH,ZTDESC,ZTRTN,ZTIO,.RMSG)
 S @IBRET@(1)=MSG
 I RMSG(0) D  ;< multi line message to avoid wrap
 . S IBA=0 F  S IBA=$O(RMSG(IBA)) Q:'IBA  S IBB=$G(RMSG(IBA)) I IBB'="" S @IBRET@(IBA+1)=IBB,@IBRET@(0)=@IBRET@(0)+1
 ;
TSKCLNQ ;
 Q ""
 ;
TASK(ZTDTH,ZTDESC,ZTRTN,ZTIO,RMSG) ;bypass for queued task
 N %DT,GTASKS,IBAA,IDT,MSG,NOW,TIME,TSK,XDT,Y,ZTSK
 ;
 S (IDT,Y)=ZTDTH D DD^%DT S XDT=Y    ; XDT is TODAY+1@2000 reformatted to a readable date.
 ;
 ;Check if task already scheduled for date/time
 S RMSG(0)=0
 S MSG=$$CHKTSK
 I +MSG S MSG=$P(MSG,U,2,999) Q MSG
 ; 
 ;Schedule the task
 S TSK=$$SCHED(IDT,ZTIO)
 ;
 ;Check for scheduling problem
 I $G(TSK)="" S MSG=" Task Could Not Be Scheduled" Q MSG
 ;
 ;Send successful schedule message
 S MSG="Task: "_$P($G(TSK),U)_" Duplicate Buffer Cleanup is scheduled for "_XDT    ;TIME
 Q MSG
 ;
SCHED(ZTDTH,ZTIO) ;
 N ZTSK,IBDT
 D ^%ZTLOAD
 I $G(ZTSK)="" Q ""
 S IBDT=$$HTFM^XLFDT(ZTSK("D"))
 ; 90000 represents 10pm in $harlog seconds
 Q ZTSK_U_IBDT_U_$S($P(ZTSK("D"),",",2)=90000:1,1:0)
 ;
CHKTSK() ;Check if task already scheduled for date/time
 N GTASKS,MSGA,TSK,ZTSK
 ;
 K GTASKS
 D DESC^%ZTLOAD(ZTDESC,"GTASKS")
 S TSK="",MSGA=0
 S TSK=$O(GTASKS(TSK))
 I TSK'=""  D  Q MSGA
 . S ZTSK=TSK D ISQED^%ZTLOAD
 . S MSGA="1^Task #"_+ZTSK_" is already scheduled to run on "_$$HTE^XLFDT(ZTSK("D"),1)_" "
 Q MSGA
