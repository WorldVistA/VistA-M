EAS155P1 ;;ALB/SCK - MT LETTERS BAD POINTERS CLEAN UP ;07/22/2004
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**55**;MAR 15,2001
 ;
 ; This routine was initally run as the post-install for patch EAS*1*55
 ; Running this routine from programmer mode will initiate another
 ; reporting cycle.  You should not run this routine unless advised
 ; by customer support.
 Q
 ;
EN ; Entry point from programmer mode
 N MSG,XCNT,DIR,X,Y,DIRUT
 ;
 F XCNT=1:1 S LINE=$P($T(TEXT+XCNT),";;",2) Q:LINE="$$END"  S MSG(XCNT)=LINE
 W @IOF
 S XCNT=0 F  S XCNT=$O(MSG(XCNT)) Q:'XCNT  W !?3,MSG(XCNT)
 W !
 I '$$CHKPREV Q
 ;
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Continue with scan"
 S DIR("?")="Press ENTER to continue, enter ""NO"" to exit."
 D ^DIR K DIR
 I Y D QUE  Q
 W !?3,"Exiting scan..."
 Q
 ;
QUE ;
 K ZTRTN,ZTDESC,ZTSAVE
 S ZTRTN="BLD^EAS155P1"
 S ZTDESC="EAS MT LTR BAD PTR SCAN"
 S ZTSAVE("DUZ")=""
 S ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 D
 . W:'$G(EASQ) !!?3,"Scan canceled"
 E  D
 . I $G(EASQ) D BMES^XPDUTL("Scan Queued: "_ZTSK)
 . E  W !!?3,"Scan Queued: "_ZTSK
 Q
 ;
BLD ; Entry point scan and cleanup.  Do not call directly, call from the EN entry point.
 D SCAN,CLNUP,ALERT
 S ^XTMP("EASBADPTRS",0,"END")=$H
 Q
 ;
POST ; Post Install entry point.  This entry point is intended to be called from the KIDS build.
 N MSG,XCNT,EASQ
 ;
 F XCNT=1:1 S LINE=$P($T(TEXT+XCNT),";;",2) Q:LINE="$$END"  D
 . S MSG(XCNT)=LINE
 D MES^XPDUTL(.MSG)
 S EASQ=1 D QUE
 Q
 ;
SCAN ; Begin scanning for any bad pointers in the MT Letter Files
 N EAIEN
 ;
 K ^XTMP("EASBADPTRS")
 S ^XTMP("EASBADPTRS",0)=$$FMADD^XLFDT($$DT^XLFDT,30)_U_$$DT^XLFDT_U_"EAS MT LETTERS BAD POINTERS SCAN"
 S ^XTMP("EASBADPTRS",0,"START")=$H,^XTMP("EASBADPTRS",0,"DUZ")=DUZ
 S EAIEN=0
 F  S EAIEN=$O(^EAS(713.2,"AC",0,EAIEN)) Q:'EAIEN  D
 . I $$GET1^DIQ(713.2,EAIEN,2)']"" S ^XTMP("EASBADPTRS",EAIEN)=""
 S ^XTMP("EASBADPTRS",0,"SCAN COMPLETE")=$H
 Q
 ;
CLNUP ; Disable letters in MT Letter Status file with suspicious pointers
 ; Do not delete, but flag as "bad"
 N EAIEN,EAFDA,ERR,DIE,DA,DR
 ;
 S EAIEN=0
 F  S EAIEN=$O(^XTMP("EASBADPTRS",EAIEN)) Q:'EAIEN  D
 . S DIE="^EAS(713.2,",DA=EAIEN
 . S DR="4///YES;5///TODAY;6////.5;7///LETTER DISABLED, BAD POINTERS?;9///NO;12///NO;18///NO"
 . D ^DIE K DIE,DR,DA
 ;
 S ^XTMP("EASBADPTRS",0,"CLEANUP COMPLETE")=$H
 Q
 ;
ALERT ; Send an alert to user that the scan has completed.
 K XQA,XQAMSG,XQAOPT,XQAROU,XQAID,XQDATA,XQAFLAG
 ;
 S XQA(DUZ)="",XQAID="EAS",XQAROU="REPORT^EAS155P1"
 S XQAMSG="EAS MT LTRs Bad Pointers Scan Complete, Print Report"
 D SETUP^XQALERT
 Q
 ;
REPORT ; Print Bad Pointers Report setup
 K ZTSAVE S ZTSAVE("DUZ")=""
 D EN^XUTMDEVQ("P^EAS155P1","Print EAS Bad Pointers Report",.ZTSAVE)
 Q
 ;
P ; Print report
 N LINE,EAIEN,PAGE,EAX,DFN
 ;
 S (PAGE,EAIEN)=0
 D HDR
 F  S EAIEN=$O(^XTMP("EASBADPTRS",EAIEN)) Q:'EAIEN  D  Q:$G(EASABRT)
 . S LINE=""
 . S LINE=$$SETSTR^VALM1(EAIEN,"",20,15)
 . S EAX=$$GET1^DIQ(713.2,EAIEN,2,"I")
 . S LINE=$$SETSTR^VALM1(EAX,LINE,40,15)
 . S DFN=$$GET1^DIQ(713.1,EAX,.01,"I")
 . S LINE=$$SETSTR^VALM1(DFN,LINE,60,15)
 . W !,LINE
 . I $Y+5>IOSL D  Q:$G(EASABRT)
 . . I $E(IOST,1,2)="C-" D  Q:$G(EASABRT)
 . . . S DIR(0)="E" D ^DIR K DIR
 . . . I 'Y S EASABRT=1 Q
 . . D HDR
 Q
 ;
HDR ; PRINT REPORT HEADER
 N LINE,DDASH,TEXT,TEXT1
 ;
 S PAGE=PAGE+1
 W:$E(IOST,1,2)="C-" @IOF
 W "Results of Possible Bad Pointers Report for EAS MT Letters"
 S TEXT="Date Scan Run: "_$$HTE^XLFDT(^XTMP("EASBADPTRS",0,"END"))
 S TEXT1="Run by: "_$$GET1^DIQ(200,^XTMP("EASBADPTRS",0,"DUZ"),.01)
 S SPACE=(IOM-($L(TEXT)+$L(TEXT1)))
 S $P(LINE," ",SPACE-2)=""
 W !,TEXT,LINE,TEXT1
 ;
 S TEXT="Print Date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S TEXT1="Page: "_PAGE
 S SPACE=(IOM-($L(TEXT)+$L(TEXT1)))
 S $P(LINE," ",SPACE-2)=""
 W !,TEXT,LINE,TEXT1,!
 ;
 S $P(DDASH,"=",IOM-10)=""
 S LINE=$$SETSTR^VALM1("File IEN's","",5,12)
 S LINE=$$SETSTR^VALM1("713.2",LINE,20,5)
 S LINE=$$SETSTR^VALM1("713.1",LINE,40,5)
 S LINE=$$SETSTR^VALM1("DFN",LINE,60,5)
 W !,LINE
 W !?5,DDASH
 Q
 ;
CHKPREV() ; Check for a previous scan in XTMP
 N RSLT,EASDUZ
 ;
 S RSLT=1
 I $D(^XTMP("EASBADPTRS")) D
 . I '$D(^XTMP("EASBADPTRS",0,"END")) D
 . . W !?3,$CHAR(7),"The EAS MT LTRs Bad Pointer scan is currently running."
 . . S EASDUZ=$G(^XTMP("EASBADPTRS",0,"DUZ"))
 . . I EASDUZ>0 W !?3,"started by ",$$GET1^DIQ(200,EASDUZ,.01)
 . . I $D(^XTMP("EASBADPTRS",0,"START")) W " on ",$$HTE^XLFDT(^XTMP("EASBADPTRS",0,"START"))
 . . S RSLT=0
 . E  D
 . . W !?3,"Data from a previous scan exists.  "
 . . I $D(^XTMP("EASBADPTRS",0,"END")) W "Last Run: ",$$HTE^XLFDT(^XTMP("EASBADPTRS",0,"END"))
 . . W !?3,"Answering ""YES"" will cause this data to be erased and a new"
 . . W !?3,"scan started!",!
 Q $G(RSLT)
 ;
TEXT ;
 ;;Running this routine will scan the EAS MT PATIENT STATUS File (#713.1)
 ;;and the EAS MT LETTER STATUS File (#713.2) for any bad pointers
 ;;linking to the PATIENT File (#2).  This routine WILL NOT clean up
 ;;these pointers, but will flag the appropriate MT Letter entry as
 ;;'MT RETURNED' and enter a comment of 'Bad Pointer'.  Your local 
 ;;IRM may take additional cleanup actions.
 ;;
 ;;Data from this scan will be retained in the ^XTMP("EASBADPTRS") 
 ;;global for 30 days.  You may run REPORT^EAS155P1 at a programmer 
 ;;prompt to re-print a formatted report.  You will be alerted when the 
 ;;scan is complete. 
 ;;$$END
 Q
