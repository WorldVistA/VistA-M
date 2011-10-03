FBFHLP ;WOIFO/SAB-FPPS MESSAGE PURGE ;9/9/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;
 W !,"When an invoice is transmitted to FPPS via the HL7 package, a copy of the HL7"
 W !,"message text is saved in the FPPS QUEUED INVOICES (#163.5) file."
 W !!,"This option purges the message text for invoices transmitted prior to a"
 W !,"specified date.  Messages that have not been accepted by the VistA Interface"
 W !,"Engine will not be purged unless there is a later message for the same"
 W !,"invoice number that has been accepted.",!
 ;
 ; ask date
 S DIR(0)="D^:"_$$FMADD^XLFDT(DT,-30)_":EX"
 S DIR("A")="Purge text of messages transmitted prior to"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-60),2)
 S DIR("?",1)="The purge date must be at least 30 days ago."
 S DIR("?")="This response must be a date. Enter '^' to quit."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDTP=Y
 ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^FBFHLP",ZTDESC="FB FPPS Message Text Purge"
 . F FBX="FBDTP" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry
 U IO
 ;
PURGE ; Start Purge
 S FBPG=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL S FBDL="",$P(FBDL,"-",IOM)=""
 ;
 ; build page header text for selection criteria
 S FBHDT(1)="  For Messages Transmitted Prior To "_$$FMTE^XLFDT(FBDTP)
 ;
 D HD
 ;
 S FBQUIT=0
 ;
 ; initialize counters
 S FBC=0 ; count of messages processed
 S FBC("PRG")=0 ; count of message text purged
 ;
 W !,"Starting Purge..."
 ;
 ; loop thru entries by MESSAGE DATE/TIME x-ref by date
 S FBDT=0
 F  S FBDT=$O(^FBHL(163.5,"AMD",FBDT)) Q:FBDT=""!($P(FBDT,".")>FBDTP)  D  Q:FBQUIT
 . S FBDA=0 F  S FBDA=$O(^FBHL(163.5,"AMD",FBDT,FBDA)) Q:'FBDA  D  Q:FBQUIT
 . . S FBC=FBC+1 ; increment count of records processed
 . . ; if tasked then check for stop request
 . . I $D(ZTQUEUED),FBC\1000,$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 . . Q:$O(^FBHL(163.5,FBDA,1,0))'>0  ; quit if no data in message text
 . . ;
 . . ; check if OK to purge
 . . S FBPRG=0 ; init as NO
 . . S FBY=$G(^FBHL(163.5,FBDA,0))
 . . I $P(FBY,U,8)="A" S FBPRG=1 ; was accepted
 . . I 'FBPRG D
 . . . ; check if last entry for invoice was accepted
 . . . N FBLDA
 . . . S FBLDA=$$LAST^FBFHLU($P(FBY,U))
 . . . I FBLDA,FBLDA'=FBDA,$P($G(^FBHL(163.5,FBLDA,0)),U,8)="A" S FBPRG=1
 . . ;
 . . ; if OK then purge
 . . I FBPRG D WP^DIE(163.5,FBDA_",",7,"","@") S FBC("PRG")=FBC("PRG")+1
 ;
 I 'FBQUIT W !,"Purge Completed."
 ;
 W !!,"The message text was purged from ",FBC("PRG")," entr",$S(FBC("PRG")=1:"y",1:"ies")," in file 163.5."
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 ;
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K FBC,FBDA,FBDL,FBDT,FBDTP,FBDTR,FBHDT,FBPG,FBPRG,FBQUIT,FBX,FBY
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,J,POP,X,Y
 Q
 ;
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"FPPS Message Text Purge",?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W !,FBDL
 Q
 ;
 ;FBFHLP
