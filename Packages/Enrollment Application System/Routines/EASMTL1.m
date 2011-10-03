EASMTL1 ;MIN/TCM ALB/SCK/AEG/PHH - AUTOMATED MEANS TEST LETTER - PATIENT SEARCH ; 07/2/01
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,12,20,54**;MAR 15,2001
 ; Conversion from class III software
 ;
QUEUE ; Main entry point for tasked (background) letter search
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZDATE
 ;
 S ZTRTN="EN^EASMTL1"
 S ZTDESC="AUTOMATED MT LETTERS GENERATOR"
 S (ZTDTH,ZDATE)=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
SETDT(EASRUN) ;
 ; Input
 ;    EASRUN   - Default start date for processing
 ;
 ; Output
 ;    1 - Ok
 ;    0 - Quit
 ;    EASRUN - Accepted start date for processing
 ;
 N DIR,DIRUT,RSLT
 ;
 S DIR("A",1)="The prior processing date is not available.  A default date"
 S DIR("A",2)="of "_$$FMTE^XLFDT(EASRUN)_" will be used."
 S DIR("A")="Ok to continue? "
 S DIR(0)="YAO",DIR("B")="YES"
 D ^DIR K DIR
 I $D(DIRUT) Q 0
 Q:Y Y
 ;
 S DIR(0)="DAO^:DT:EX",DIR("B")=$$FMTE^XLFDT(EASRUN)
 S DIR("?")="^D HELP^%DTC"
 S DIR("A",1)=""
 S DIR("A")="Select new start date: "
 D ^DIR K DIR
 I $D(DIRUT) Q 0
 S EASRUN=Y
 Q 1
 ;
EN ; Main entry point for processing
 N EASLAST,X,EASLST,EASABRT,EASN,EAS6CNT,EAS3CNT,EAS0CNT,EASDT,EASDTFLG,EADT,MSG,EASX
 ;
 ; Get last processing date, default to TODAY - 30 if date not available
 S EASX=$$GET1^DIQ(713,1,2,"I")
 S EADT=$$DT^XLFDT
 ; If letter search has already been run for TODAY, quit
 I EASX=EADT D  Q
 . I '$D(ZTQUEUED) D
 . . W !!,$CHAR(7),">> The Means Test Letter search has been run for today.",!
 . . D PAUSE^EASMTUTL
 ;
 I EASX S EASLAST=$$FMADD^XLFDT(EASX,1)
 I '$G(EASX) D  Q:$G(EASABRT)
 . S EASLAST=$$FMADD^XLFDT(DT,-30)
 . I '$D(ZTQUEUED) S:'$$SETDT(.EASLAST) EASABRT=1
 ;
 ; Check lock on parameter file, one process at a time, quit if locked
 I '$$LOCK^EASMTUTL(1) D  Q
 . I $D(ZTQUEUED) D  Q
 . . D ALERT^EASMTUTL("Auto MT Letters: This process is already running, "_$$FMTE^XLFDT(EADT,"2D"))
 . W !!,$CHAR(7),"This process is already running, please try again later"
 . D PAUSE^EASMTUTL
 ;
 D BLDLST(EASLAST,EADT)    ; Build processing date list
 D PROCESS                 ; Process dates
 S EASX=$$LOCK^EASMTUTL(0)
 D UPDPARAM(EADT)
 D STATS(EASLAST,.EAS6CNT,EADT)
 ;
 I $D(ZTQUEUED) D
 . S MSG="Auto-Letters Search completed: "_$$FMTE^XLFDT($$NOW^XLFDT)
 . D ALERT^EASMTUTL(MSG)
 Q
 ;
BLDLST(FRDT,TODT) ; Build processing date list
 ; Input
 ;   FRDT - Beginning date for processing list
 ;   TODT - Ending date for processing list
 ;
 N EASN
 ;
 S EASN=FRDT,EASLST(FRDT)="",EASLST(TODT)=""
 F  S EASN=$$FMADD^XLFDT(EASN,1) Q:EASN>TODT  S EASLST(EASN)=""
 Q
 ;
PROCESS ;  Get anniversary and threshold dates
 N EASPRCDT
 ;
 S (EAS0CNT,EAS3CNT,EAS6CNT)=0
 ; Calculate Anniverary date and 60/30/0 dates based on the Anniverary date
 S EASPRCDT=0 ; Begin loop through processing dates
 F  S EASPRCDT=$O(EASLST(EASPRCDT)) Q:EASPRCDT'>0  D  Q:$G(ZTSTOP)  ; Quit if stop request
 . K EASDT
 . I '$D(ZTQUEUED) W !?5,">> Processing date  "_$$FMTE^XLFDT(EASPRCDT)_"  in progress <<",!
 . ; Anniversary date is processing date minus one year plus sixty days
 . ;
 . S EASDT("ANV")=$$FMADD^XLFDT($$SUBLEAP^EASMTUTL(EASPRCDT),60) ; Anv date: 1 Year - 60 days
 . S EASDT("60")=$$FMADD^XLFDT(EASDT("ANV"),(365-60)) ; Define 60 day letter print date
 . S EASDT("30")=$$FMADD^XLFDT(EASDT("ANV"),(365-30)) ; Define 30 day letter print date
 . S EASDT("0")=$$FMADD^XLFDT(EASDT("ANV"),365) ; Define 0 day letter print date
 . ;
 . ; Call the threshold date search
 . D EN60^EASMTL2
 . ; Check for stop request if queued
 . I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1
 Q
 ;
UPDPARAM(EASDT) ; Update the EAS Parameter file, #713
 ; Input
 ;   EASDT - Today's date
 ;
 N DIE,DA,DR
 ;
 S DIE="^EAS(713,",DA=1,DR="2////^S X=EASDT"
 S:'$D(ZTQUEUED) DR=DR_";3////^S X=DUZ;4////^S X=EASDT"
 D ^DIE K DIE
 Q
 ;
STATS(EASLAST,EAS6CNT,EASDT) ;Gather and print statistics
 ; Input
 ;    EASLAST  - Last date processed (Beginning date)
 ;    EAS6CNT  - Array of 60 day letters
 ;    EASDT    - Ending date of processing
 ;
 N MSG,EASD,LINE,TOT,XMSUB,XMY,XMTEXT,XMDUZ,ZDCD
 ;
 ; EAS*1*12 modification
 S ZDCD=$S($$VERSION^XPDUTL("IVMC"):0,1:60)
 ; ** 
 ; EAS*1*20 modification
 I $G(ZDCD)'>0,$G(DT)>3021014 S ZDCD=60
 ;
 S MSG(.1)="Automated Means Test Letter Generator Statistics"
 S MSG(.2)="------------------------------------------------"
 S MSG(.3)=""
 S MSG(.4)="Beginning Processing Date: "_$$FMTE^XLFDT(EASLAST)
 S MSG(.5)="Ending Processing Date:    "_$$FMTE^XLFDT(EASDT)
 S MSG(.6)=""
 S MSG(11)="  "_ZDCD_"-day Letters: "_EAS6CNT
 S MSG(16)=""
 S LINE=18
 ;
 S LINE=LINE+1
 S MSG(LINE)=ZDCD_" Day Letter Totals:    "
 S EASD=0
 F  S EASD=$O(EAS6CNT(EASD)) Q:'EASD  D
 . I +$G(EAS6CNT(EASD)) D
 . . S LINE=LINE+1
 . . S MSG(LINE)="  "_$$FMTE^XLFDT(EASD)_" : "_EAS6CNT(EASD)
 ;
 S XMSUB="AUTO MT LETTER RESULTS - "_$$FMTE^XLFDT(EASDT)
 S XMTEXT="MSG("
 S XMY("G.EAS MTLETTERS")=""
 S XMDUZ="AUTOMATED MT LETTERS"
 D ^XMD
 Q
