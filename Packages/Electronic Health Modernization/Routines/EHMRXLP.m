EHMRXLP ;PBM/RMS-Automating the D/C of Migrated VistA Rx's ; 8/5/25 12:35pm
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**8**;April 19, 2021;Build 38
 ;
 ;External Reference to ^DIC supported by DBIA #10006
 ;External Reference to $$EXTERNAL^DILFD supported by DBIA #2055
 ;External Reference to ^DIR supported by DBIA #10026
 ;External Reference to $$FMADD^XLFDT supported by DBIA #10103
 ;External References to ^XLFSTR supported by DBIA #10104
 ;External Reference to ^XMD supported by DBIA #10070
 ;External Reference to NODEV^XUTMDEVQ supported by DBIA #1519
 ;External Reference to ^PSRX supported by DBIA #7632
 Q
WELCOME ;Introduce the routine, collect emails for delivery, confirm
 ;user is ready to proceed.
 N EHMSTAT,XMY,%ZIS,ZTSAVE,EHMQUIT
 W @IOF
 W !!,$$CJ^XLFSTR("Automated D/C of Migrated VistA Prescriptions",IOM)
 W !,$$REPEAT^XLFSTR("-",IOM),!!
 W !,"This routine will discontinue any prescriptions with status of"
 W !,"ACTIVE, SUSPENDED, or HOLD and finishing date in the last year."
 W !!,"This job will be queued."
 W !!
 D EMAILS
 Q:$D(EHMQUIT)
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="Ready to proceed"
 D ^DIR
 Q:'+Y
 W !!!
 S ZTSAVE("*")=""
 D NODEV^XUTMDEVQ("LOOP^EHMRXLP","Auto-D/C Migrated Rx's",.ZTSAVE,.%ZIS)
 Q
EMAILS ;Collect recipient emails
 N DIC,DTOUT,DUOUT,X,Y
 S DIC=200
 S DIC(0)="AEMQ"
 S DIC("A")="Select a MailMan Recipient for the Completion Report: "
 S DIC("B")=DUZ
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S EHMQUIT=1 Q
 I Y S XMY(+Y)=""
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FO"
 S DIR("A")="Select an Outlook Recipient (optional) for the Completion Report"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S EHMQUIT=1 Q
 I Y]"" S XMY(Y)=""
 Q
LOOP ;Perform the loop, collect statistics
 N EHMRXSD,EHMRXOD,EHMRXIN,EHMSTA
 S EHMRXSD=$$FMADD^XLFDT(DT,-367)
 S EHMRXOD=EHMRXSD
 F  S EHMRXOD=$O(^PSRX("AFDT",EHMRXOD)) Q:'+EHMRXOD  D
 . S EHMRXIN=0
 . F  S EHMRXIN=$O(^PSRX("AFDT",EHMRXOD,EHMRXIN)) Q:'+EHMRXIN  D
 .. S EHMSTA=$G(^PSRX(EHMRXIN,"STA"))  I EHMSTA<10!(EHMSTA=16) D
 ... S EHMSTAT(EHMSTA)=$G(EHMSTAT(EHMSTA))+1
 ... D CAN^EHMPSRXDC(EHMRXIN)
 D REPORT
 Q
REPORT ;Generate the completion email with resulting stats output
 N EHMTEXT,XMSUB,XMTEXT
 S EHMTEXT(1)="Count of Prescriptions Processed for Auto-D/C by Status"
 S EHMTEXT(2)=" "
 S EHMSTA=""
 F  S EHMSTA=$O(EHMSTAT(EHMSTA)) Q:EHMSTA']""  D  ;
 . S EHMTEXT(EHMSTA+3)="Status: "_$$EXTERNAL^DILFD(52,100,"",EHMSTA)_"    Count: "_$G(EHMSTAT(EHMSTA))
 S XMSUB="Prescription Auto-D/C Task Completed"
 S XMTEXT="EHMTEXT("
 D ^XMD
 Q
