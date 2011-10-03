XMCP ;ISC-SF/GMB-Poll Domains ;08/29/2002  13:12
 ;;8.0;MailMan;**4**;Jun 28, 2002
 ; Was (WASH ISC)/CAP/RM/AML/THM
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; POLL   XMPOLL     (was POLL^XMS1 and TSKPOLR^XMS5B)
 ;
 ; This option may be SCHEDULED.
 ; It goes through a list of domains whose FLAGS field contains P,
 ; meaning that the domains are to be "polled", that they should be
 ; contacted whether or not there are messages in their queues.
 ; If no messages are in the queues, the script for the poll domain
 ; will be 'played' anyway, and the TURN command executed to pull in
 ; any messages which may be waiting to be transmitted to this domain.
 ;
POLL ; Process domains on poll list.
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("XM",$J)
 I $$GOTTASKS W:'$D(ZTQUEUED) !!,$$EZBLD^DIALOG(42150) Q  ;All domains have tasks.
 I $$XMITOK D TASKXMIT
 K ^TMP("XM",$J)
 Q
GOTTASKS() ; Does every poll site have a task?
 N XMTSK,XMINST,XMSITE,XMPARM
 S XMINST=0
 F  S XMINST=$O(^DIC(4.2,"AC","P",XMINST)) Q:'XMINST  D
 . W:'$D(ZTQUEUED) "."
 . S XMSITE=$P(^DIC(4.2,XMINST,0),U)
 . S XMTSK=$$GETTSK^XMKPR(XMINST)
 . I XMTSK,'$$TSKEXIST^XMKPR(XMINST,XMTSK) S ^TMP("XM",$J,XMSITE)=XMINST Q
 . Q:$D(ZTQUEUED)
 . S XMPARM(1)=XMTSK,XMPARM(2)=XMSITE
 . W !,$$EZBLD^DIALOG(42151,.XMPARM) ;Task |1| is already scheduled for domain |2|
 Q '$D(^TMP("XM",$J))
XMITOK() ; Ask whether eligible queues should be transmitted.
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,XMSITE
 I $D(ZTQUEUED) Q 1
 W @IOF,$$EZBLD^DIALOG(42152) ;These domains lack tasks:
 S XMSITE=""
 F  S XMSITE=$O(^TMP("XM",$J,XMSITE)) Q:XMSITE=""  D
 . I $Y+4>IOSL D
 . . D WAIT^XMXUTIL
 . . W @IOF
 . W !?5,XMSITE
 S DIR(0)="YO"
 S DIR("A")=$$EZBLD^DIALOG(42128) ;Requeue the missing tasks
 S DIR("B")=$$EZBLD^DIALOG(39053) ;NO
 S DIR("?")=$$EZBLD^DIALOG(42153) ;Answer YES to transmit these domains.
 D ^DIR
 I 'Y W !!,$$EZBLD^DIALOG(42130) ;Tasks not requeued.
 Q Y
TASKXMIT ;
 ; Task off transmission jobs
 N XMINST,XMSITE,XMPOLL
 I '$D(ZTQUEUED) W !
 S XMSITE="",XMPOLL=1
 F  S XMSITE=$O(^TMP("XM",$J,XMSITE)) Q:XMSITE=""  S XMINST=^(XMSITE) D
 . D QUEUE^XMCX(XMINST,XMSITE)
 W:'$D(ZTQUEUED) !,$$EZBLD^DIALOG(42132) ; Finished.
 Q
