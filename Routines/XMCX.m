XMCX ;ISC-SF/GMB-Play a Script / Queue Transmit Task ;12/04/2002  13:45
 ;;8.0;MailMan;**6,10**;Jun 28, 2002
 ; Was (WASH ISC)/THM
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; PLAY    XMSCRIPTPLAY     (was GO^XMC11)
 ; Q1      XMSTARTQUE       (was Q^XMC2)
 ; QALL    XMSTARTQUE-ALL   (was REQUE^XMS5)
 Q
PLAY ; Play a script
 N XM,XMB,XMC,XMINST,XMSITE,XMIO,XMHOST,XMABORT
 K XMTLER
 S XM="D",XMABORT=0
 D ASKINST^XMCXU(.XMINST,.XMSITE,.XMABORT) Q:XMABORT
 D CHKTSK^XMCXU(XMINST,2,.XMABORT) Q:XMABORT
 D ASKSCR^XMCXU(XMINST,XMSITE,.XMB,.XMABORT) Q:XMABORT
 S XMIO=$P(XMB("SCR REC"),U,5)
AGAIN ;
 D ENT^XMC1
 I ER=25!($G(XMHOST)="NO-IP") D  G:'XMABORT AGAIN
 . N XMTEXT,XMIPSAVE
 . I '$$USEDNS^XMKPR1 D  Q
 . . S XMABORT=1
 . . ;DNS is not activated at this site, so you'll have to figure
 . . ;out the correct IP address yourself.
 . . D BLD^DIALOG(42263,"","","XMTEXT","F")
 . . D MSG^DIALOG("WM","","","","XMTEXT")
 . ;Let's see what we can do...
 . ;We've tried these: |1|
 . D BLD^DIALOG(42264,XMB("IP TRIED"),"","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . S XMB("TRIES")=XMB("TRIES")+1
 . S XMIPSAVE=XMB("IP TRIED"),XMC("PLAY")=1
 . D NEXTIP^XMKPR1(XMSITE,.XMB) K XMC("PLAY")
 . I XMIPSAVE=XMB("IP TRIED") D  Q
 . . S XMABORT=1
 . . ;The DNS did not return any other addresses to try.  Sorry!
 . . D BLD^DIALOG(42265,"","","XMTEXT","F")
 . . D MSG^DIALOG("WM","","","","XMTEXT")
 . W !,$$EZBLD^DIALOG(42266,$P(XMB("SCR REC"),U,6)) ;Now, let's try: |1|
 . K ER,XMER
 I 'XMABORT,'ER S XMC("PLAY")=1 D CHKSETIP^XMTDR(XMINST,XMSITE,.XMB)
 D KL^XMC
 Q
Q1 ; Trigger a queue for transmission
 N XMB,XMINST,XMSITE,XMTSK,XMABORT
 S XMABORT=0 ; pick a queue w/msgs
 D ASKINST^XMCXU(.XMINST,.XMSITE,.XMABORT,"M") Q:XMABORT
 D CHKTSK^XMCXU(XMINST,1,.XMABORT) Q:XMABORT
 D ASKSCR^XMCXU(XMINST,XMSITE,.XMB,.XMABORT) Q:XMABORT
 D QUEUE(XMINST,XMSITE,.XMB)
 Q
TASK ;
QALL ;
 N XMDUZ,XMK,XMIEN,XMSITE
 S:$D(ZTQUEUED) ZTREQ="@"
 D RESEQ^XMCQA
 K ^TMP("XM",$J)
 S XMK=1000
 F  S XMK=$O(^XMB(3.7,.5,2,XMK)) Q:'XMK  Q:XMK>9999  D
 . Q:'$$BMSGCT^XMXUTIL(.5,XMK)
 . W:'$D(ZTQUEUED) "."
 . S XMIEN=XMK-1000
 . S:'$$TSKEXIST^XMKPR(XMIEN) ^TMP("XM",$J,$P(^DIC(4.2,XMIEN,0),U))=XMIEN
 I '$D(^TMP("XM",$J)) D  Q
 . W:'$D(ZTQUEUED) !!,$$EZBLD^DIALOG(42125) ;All queues with messages have tasks.
 I '$D(ZTQUEUED) D  Q:'$D(^TMP("XM",$J))
 . W:$E($G(IOST),1,2)="C-" @IOF
 . W !,$$EZBLD^DIALOG(42126),! ;These queues with messages have no tasks:
 . S XMSITE=""
 . F  S XMSITE=$O(^TMP("XM",$J,XMSITE)) Q:XMSITE=""  D
 . . I $Y+3>IOSL D
 . . . D WAIT^XMXUTIL
 . . . W @IOF
 . . S XMIEN=^TMP("XM",$J,XMSITE)
 . . W !,$E(XMSITE,1,37)
 . . Q:$P(^DIC(4.2,XMIEN,0),U,2)["S"
 . . W ?40,$$EZBLD^DIALOG(42127) ;No Send Flag - Will not task
 . . K ^TMP("XM",$J,XMSITE)
 . Q:'$D(^TMP("XM",$J))
 . N DIR
 . S DIR(0)="YO"
 . S DIR("A")=$$EZBLD^DIALOG(42128) ;Requeue the missing tasks
 . S DIR("B")=$$EZBLD^DIALOG(39053) ;No
 . D BLD^DIALOG(42129,"","","DIR(""?"")") ;Answer YES to create tasks to transmit these queues.
 . D ^DIR Q:Y
 . W !!,$$EZBLD^DIALOG(42130) ;Tasks not requeued.
 . K ^TMP("XM",$J)
 S XMSITE=""
 F  S XMSITE=$O(^TMP("XM",$J,XMSITE)) Q:XMSITE=""  D
 . S XMIEN=^TMP("XM",$J,XMSITE)
 . I $$UP^XLFSTR($P(^DIC(4.2,XMIEN,0),U,2))'["S" D  Q
 . . W:'$D(ZTQUEUED) !,$E(XMSITE,1,37),?40,$$EZBLD^DIALOG(42127) ;No Send Flag - Will not task
 . D QUEUE(XMIEN,XMSITE)
 W:'$D(ZTQUEUED) !,$$EZBLD^DIALOG(42132) ;Finished.
 K ^TMP("XM",$J)
 Q
QUEUE(XMINST,XMSITE,XMB,XMWHEN,XMTSK) ;
 D QUEUE^XMKPR(XMINST,XMSITE,.XMB,.XMWHEN,.XMTSK) Q:$D(ZTQUEUED)
 W !,$E(XMSITE,1,37),?40,$$EZBLD^DIALOG($S($D(XMTSK):42131,1:39311),$G(XMTSK)) ;Task |1| queued / Task creation failed
 Q
