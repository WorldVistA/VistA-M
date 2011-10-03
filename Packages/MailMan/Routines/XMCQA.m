XMCQA ;ISC-SF/GMB-Transmit Queue Status Report (others) ;12/04/2002  13:44
 ;;8.0;MailMan;**8,10**;Jun 28, 2002
 ; Was (WASH ISC)/CAP/RM/AML
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ACTIVE  XMQACTIVE     (was GO^XMS5)
 ; ALL     XMQUEUED      (was ENT^XMS5)
 ;
ACTIVE ; Show queues actively transmitting.
 D EN^XUTMDEVQ("AZTLOOP^XMCQA",$$EZBLD^DIALOG(42110)) ; MailMan: Active Transmission Queues Report
 Q
AZTLOOP ;
 I $E($G(IOST),1,2)'="C-" D  Q
 . D AZTSK
 . I $D(ZTQUEUED) S ZTREQ="@"
 F  D  Q:'(Y!$D(DTOUT))
 . D AZTSK
 . W !
 . N DIR,X,DTIME
 . S DTIME=5
 . S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(42116) ; Refresh
 . S DIR("B")=$$EZBLD^DIALOG(39054) ; YES
 . ;Answer YES if you want the display refreshed.
 . ;Answer NO if you don't.
 . ;If you don't answer, the display will be refreshed every five seconds.
 . D BLD^DIALOG(42117,"","","DIR(""?"")")
 . D ^DIR
 Q
AZTSK ;
 N XMIEN,XMSITE,XMABORT,XMRPT,XMCNT,XMREC,XMSECS,XMQD
 S (XMABORT,XMCNT,XMCNT("QD"))=0
 ;Active Transmission Queues
 ;Domain         Queued  Device/Protocol      Message  Line      ZTSK Err    Rate
 D INIT(.XMRPT,42111,42112)
 S XMSITE=""
 F  S XMSITE=$O(^DIC(4.2,"B",XMSITE)) Q:XMSITE=""  D  Q:XMABORT
 . S XMIEN=0
 . F  S XMIEN=$O(^DIC(4.2,"B",XMSITE,XMIEN)) Q:'XMIEN  D  Q:XMABORT
 . . S XMREC=$P($G(^XMBS(4.2999,XMIEN,3)),U,1,7)
 . . Q:"^^^^^^"[XMREC
 . . S XMSECS=$$HDIFF^XLFDT($H,$P(XMREC,U),2)
 . . Q:XMSECS>599
 . . Q:$P(XMREC,U,1,6)?.P
 . . S XMQD=$$BMSGCT^XMXUTIL(.5,XMIEN+1000)
 . . I $Y+3+(XMSECS>180)>IOSL D  Q:XMABORT
 . . . D PAGE(.XMABORT) Q:XMABORT
 . . . D HDR(.XMRPT)
 . . W !,$$MELD^XMXUTIL1(XMSITE,XMQD,21)," "  ; domain, q'd msgs
 . . I XMSECS>180 D
 . . . W $E($P(XMREC,U,6),1,16)
 . . . W ?40,$$EZBLD^DIALOG(42113,XMSECS\60) ; == Appears Inactive - |1| Minutes
 . . E  D
 . . . I '$P(XMREC,U,2) D  Q
 . . . . W $E($P(XMREC,U,6),1,16)
 . . . . W ?44,$$EZBLD^DIALOG(42114) ; Connecting/Disconnecting
 . . . ; Device, Msg #, xmit line, ztsk, errors, xmit rate
 . . . W $$MELD^XMXUTIL1($P(XMREC,U,6),$P(XMREC,U,2),29),$J($P(XMREC,U,3),6),$J($P(XMREC,U,7),10),$J($P(XMREC,U,4),3),$J($P(XMREC,U,5),9)
 . . S XMCNT=XMCNT+1
 . . S XMCNT("QD")=XMCNT("QD")+XMQD
 Q:XMABORT
 I 'XMCNT W !,$$EZBLD^DIALOG(42115) Q  ; No queues actively transmitting
 ;I $Y+5>IOSL D  Q:XMABORT
 ;. D PAGE(.XMABORT) Q:XMABORT
 ;. D HDR(.XMRPT)
 ;W !!,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42103),XMCNT,27) ; Total Domains:
 ;W !,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42104),XMCNT("QD"),27) ; Total Queued:
 Q
INIT(XMRPT,XMTITLE,XMHDR) ;
 S XMRPT("PAGE")=0
 S XMRPT("DATE")=$$MMDT^XMXUTIL1($$NOW^XLFDT)
 S XMRPT("TITLE")=$S(+XMTITLE=XMTITLE:$$EZBLD^DIALOG(XMTITLE),1:XMTITLE)
 S XMRPT("HDR")=$S(+XMHDR=XMHDR:$$EZBLD^DIALOG(XMHDR),1:XMHDR)
 W:$E($G(IOST),1,2)="C-" @IOF
 D HDR(.XMRPT)
 Q
PAGE(XMABORT) ;
 I $E($G(IOST),1,2)="C-" D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 W @IOF
 Q
HDR(XMRPT) ;
 N XMPAGE
 S XMRPT("PAGE")=XMRPT("PAGE")+1
 W !,XMRPT("TITLE")
 W ?79-$L(XMRPT("DATE")),XMRPT("DATE")
 S XMPAGE=$$EZBLD^DIALOG(34542,$J(XMRPT("PAGE"),2))
 W !,^XMB("NETNAME"),?79-$L(XMPAGE),XMPAGE
 W !!,XMRPT("HDR"),!
 Q
ALL ; Show all queues which have messages, whether transmitting or not.
 D RESEQ
 D EN^XUTMDEVQ("QZTSK^XMCQA",$$EZBLD^DIALOG(42120)) ; MailMan: Transmission Queues with Messages Report
 Q
RESEQ ; Resequence the messages in the transmit queues.  This also has the
 ; effect of doing an integrity check on the queues.
 N XMK
 S XMK=999
 F  S XMK=$O(^XMB(3.7,.5,2,XMK)) Q:XMK'>0  Q:XMK>9999  I $O(^(XMK,1,0))  W:'$D(ZTQUEUED) "." D RSEQ^XMXBSKT(.5,XMK)
 Q
QZTSK ;
 N XMRPT,XMIEN,XMSITE,XMABORT,XMCNT,XMREC,XMQD
 S (XMABORT,XMCNT,XMCNT("QD"))=0
 ;Transmission Queues with Messages
 ;Domain                                   Queued    Physical Link
 D INIT(.XMRPT,42121,42122)
 S XMSITE=""
 F  S XMSITE=$O(^DIC(4.2,"B",XMSITE)) Q:XMSITE=""  D  Q:XMABORT
 . S XMIEN=0
 . F  S XMIEN=$O(^DIC(4.2,"B",XMSITE,XMIEN)) Q:'XMIEN  D  Q:XMABORT
 . . S XMQD=$$BMSGCT^XMXUTIL(.5,XMIEN+1000)
 . . Q:'XMQD
 . . S XMREC=^DIC(4.2,XMIEN,0)
 . . I $Y+3>IOSL D  Q:XMABORT
 . . . D PAGE(.XMABORT) Q:XMABORT
 . . . D HDR(.XMRPT)
 . . W !,$$MELD^XMXUTIL1($P(XMREC,U),XMQD,47),"    ",$P(XMREC,U,17)
 . . S XMCNT=XMCNT+1
 . . S XMCNT("QD")=XMCNT("QD")+XMQD
 Q:XMABORT
 I 'XMCNT W !,$$EZBLD^DIALOG(42123) Q  ; No messages queued
 I $Y+5>IOSL D  Q:XMABORT
 . D PAGE(.XMABORT) Q:XMABORT
 . D HDR(.XMRPT)
 W !!,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42103),XMCNT,27) ; Total Domains:
 W !,$$MELD^XMXUTIL1($$EZBLD^DIALOG(42104),XMCNT("QD"),27) ; Total Queued:
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
