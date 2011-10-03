XMCQ ;ISC-SF/GMB-Transmit Queue Status Report ;12/04/2002  13:43
 ;;8.0;MailMan;**10**;Jun 28, 2002
 ; Was (WASH ISC)/THM
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; STATUS   XMQDISP     (was ENTER^XMS5A)
 ; SHOWQ    XMQSHOW     (was QUEUE^XMC4)
STATUS ;
 D RESEQ^XMCQA
 D EN^XUTMDEVQ("QZTLOOP^XMCQ",$$EZBLD^DIALOG(42135)) ; MailMan: Transmission Queue Status Report
 Q
QZTLOOP ;
 I $E($G(IOST),1,2)'="C-" D  Q
 . D QZTSK
 . I $D(ZTQUEUED) S ZTREQ="@"
 F  D  Q:'(Y!$D(DTOUT))
 . D QZTSK
 . W !
 . N DIR,X,DTIME
 . S DTIME=5
 . S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(42116) ; Refresh
 . S DIR("B")=$$EZBLD^DIALOG(39054) ; YES
 . ;Answer YES if you want the display refreshed.
 . ;Answer NO if you don't.
 . ;If you don't answer, the display will be refreshed every five seconds
 . D BLD^DIALOG(42117,"","","DIR(""?"")")
 . D ^DIR
 Q
QZTSK ;
 N XMRPT,XMNAME,XMIEN,XMREC,XMQD,XMCNT,XMABORT,XMTSK,XMDT,XMTM
 ;Transmission Queue Status
 ;Domain         Queued Device/Protocol       Message S/R Time   Line Err    Rate
 D INIT^XMCQA(.XMRPT,42136,42137)
 S (XMABORT,XMCNT)=0
 S XMNAME=""
 F  S XMNAME=$O(^DIC(4.2,"B",XMNAME)) Q:XMNAME=""  D  Q:XMABORT
 . S XMIEN=0
 . F  S XMIEN=$O(^DIC(4.2,"B",XMNAME,XMIEN)) Q:'XMIEN  D  Q:XMABORT
 . . S XMREC=$G(^XMBS(4.2999,XMIEN,3))
 . . S XMTSK=$$TSKEXIST^XMKPR(XMIEN,$P(XMREC,U,7))
 . . I +XMREC,$$HDIFF^XLFDT($H,$P(XMREC,U,1),2)>180 S XMREC=""
 . . S XMQD=$$BMSGCT^XMXUTIL(.5,XMIEN+1000)
 . . I 'XMQD,'XMTSK,'XMREC Q
 . . I $Y+3>IOSL D  Q:XMABORT
 . . . D PAGE^XMCQA(.XMABORT) Q:XMABORT
 . . . D HDR^XMCQA(.XMRPT)
 . . S XMCNT=XMCNT+1
 . . W !,$$MELD^XMXUTIL1(XMNAME,XMQD,21) ; domain, queued
 . . I +XMREC D  Q
 . . . S XMDT=$P($$HTE^XLFDT($P(XMREC,U,1),"2Z"),":",1,2)
 . . . S XMTM=$P(XMDT,"@",2)
 . . . ; device, msg #, R/S, time, line, errors, rate
 . . . W " ",$$MELD^XMXUTIL1($P(XMREC,U,6),$P(XMREC,U,2),29),"  ",$J($P(XMREC,U,8),1)," ",XMTM,$J($P(XMREC,U,3),7),$J($P(XMREC,U,4),3),$J($P(XMREC,U,5),9)
 . . I 'XMTSK D  Q
 . . . W ?26,$$EZBLD^DIALOG(42138,$P($G(^DIC(4.2,XMIEN,0)),U,2)) ; No task scheduled, FLAGS=|1|
 . . I XMTSK[U D  Q
 . . . N XMPARM ; Task |1| scheduled for |2|
 . . . S XMPARM(1)=$P(XMTSK,U),XMPARM(2)=$P($$HTE^XLFDT($P(XMTSK,U,2),"2Z"),":",1,2)
 . . . W ?26,$$EZBLD^DIALOG(42139,.XMPARM)
 . . W ?26,$$EZBLD^DIALOG(42140,XMTSK) ; Task |1| just started
 I 'XMCNT W !,$$EZBLD^DIALOG(42141) ; No messages queued or in active transmission.
 Q
SHOWQ ; Display messages in queue
 N XMDUZ,XMINST,XMSITE,XMABORT
 D CHECK^XMVVITAE
 S XMABORT=0 ; Choose queue w/msgs
 D ASKINST^XMCXU(.XMINST,.XMSITE,.XMABORT,"M") Q:XMABORT
 I DUZ=.5 D LIST^XMJMLR(.5,XMINST+1000,XMSITE,1,.XMABORT) Q
 I $D(^XUSEC("XMNOPRIV",DUZ))!'$D(^XMB(3.7,"AB",DUZ,.5)) D  Q
 . ; not a postmaster surrogate, so look only - no touch!
 . D LIST^XMJML(.5,XMINST+1000,XMSITE,"",1)
 S XMDUZ=.5
 D OTHER^XMVVITAE
 D LIST^XMJMLR(XMDUZ,XMINST+1000,XMSITE,1,.XMABORT)
 D SELF^XMVVITAE
 Q
