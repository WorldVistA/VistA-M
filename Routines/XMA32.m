XMA32 ;ISC-SF/GMB-Purge Messages by Date ;04/17/2002  07:20
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ENTER   XMPURGE-BY-DATE - Purge messages by local create date.
ENTER ;
 N XMABORT,XMPARM
 I $D(ZTQUEUED) S ZTREQ="@"
 S XMABORT=0
 D INIT(.XMPARM,.XMABORT) Q:XMABORT
 D SETUP(.XMPARM,.XMABORT) Q:XMABORT
 D PROCESS(.XMPARM)
 Q
INIT(XMPARM,XMABORT) ;
 N XMKEY,XMTEXT
 F XMKEY="XMMGR","XMSTAR" D  Q:XMABORT
 . Q:$D(^XUSEC(XMKEY,DUZ))
 . S XMABORT=1
 . ;You must hold the |1| key to run this option.
 . W !
 . D BLD^DIALOG(36400,XMKEY,"","XMTEXT","F")
 . D MSG^DIALOG("WE","","","","XMTEXT")
 Q:XMABORT
 N XMREC
 S XMREC=$G(^XMB(1,1,.18))
 S XMPARM("PDAYS")=$S($P(XMREC,U,1):$P(XMREC,U,1),1:730)
 I $D(ZTQUEUED),XMPARM("PDAYS")<365 S XMPARM("PDAYS")=730
 S XMPARM("GRACE")=+$P(XMREC,U,2)
 D AUDTPURG
 Q:$D(ZTQUEUED)
 W !
 D BLD^DIALOG(36401,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;This process REMOVES MESSAGES PERMANENTLY from the system.
 ;             ***** BE VERY CAREFUL *****
 I $D(^XMB(1,1,.1,0)) D LAST(.XMPARM)
 Q
LAST(XMPARM) ; Find the audit record for the last date purge
 N XMLIEN,XMREC,XMDIFF,XMTEXT,XMVAR
 S XMLIEN=":"
 F  S XMLIEN=$O(^XMB(1,1,.1,XMLIEN),-1) Q:'XMLIEN  Q:$P(^(XMLIEN,0),U,6)
 Q:'XMLIEN
 S XMREC=^XMB(1,1,.1,XMLIEN,0)
 D BLD^DIALOG($S($P(XMREC,U,6)["TEST":36402.1,1:36402),$$FMTE^XLFDT($P(XMREC,U),5),"","XMTEXT","F")
 ;This process was last run on |1| (in TEST mode).
 S XMDIFF=$$FMDIFF^XLFDT($P(XMREC,U,1),$P(XMREC,U,7),1) ; difference in days
 S XMVAR(1)=$$FMTE^XLFDT($P(XMREC,U,7),5),XMVAR(2)=XMDIFF
 W !
 D BLD^DIALOG(36403,.XMVAR,"","XMTEXT","FS")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;The PURGE DATE used was |1|.
 ;(Messages more than |2| days old were purged.)
 W !
 Q
AUDTPURG ; Kill off the earliest purge entries, so that only a certain # remain.
 N XMREC,XMCNT,DA,DIK,XMMAX
 S XMMAX=20
 S XMREC=$G(^XMB(1,1,.1,0))
 S XMCNT=$P(XMREC,U,4)
 Q:XMCNT'>XMMAX
 S DA=0
 F  S DA=$O(^XMB(1,1,.1,0)) Q:DA'>0  D  Q:XMCNT'>XMMAX
 . S XMCNT=XMCNT-1
 . S DA(1)=1,DIK="^XMB(1,1,.1,"
 . D ^DIK
 Q
SETUP(XMPARM,XMABORT) ;
 D PDATE(.XMPARM,.XMABORT)    Q:XMABORT  ; Purge date
 D TESTMODE(.XMPARM,.XMABORT) Q:XMABORT  ; Test mode?
 D GRACE(.XMPARM,.XMABORT)    Q:XMABORT  ; Grace days
 Q
PDATE(XMPARM,XMABORT) ;
 N DIR,X,Y,XMOK,XMOLDEST,XMCUTOFF,XMOLDP1,XMDIFF,XMVAR
 ; Find the oldest date.  Kill any bogus xrefs.
 F  S XMOLDEST=$O(^XMB(3.9,"C","")) Q:XMOLDEST?7N  K ^XMB(3.9,"C",XMOLDEST)
 S XMOLDP1=$$FMADD^XLFDT(XMOLDEST,1)
 I $D(ZTQUEUED) D  Q
 . S XMCUTOFF=$$FMADD^XLFDT(DT,XMPARM("GRACE")-XMPARM("PDAYS"))
 . I XMOLDP1>XMCUTOFF S XMABORT=1 Q  ; Abort if no messages that old.
 . S XMPARM("PDATE")=XMCUTOFF
 S XMCUTOFF=$$FMADD^XLFDT(DT,-XMPARM("PDAYS"))
 I XMOLDP1>XMCUTOFF S XMCUTOFF=XMOLDP1
 S XMOK=0
 F  D  Q:XMOK!XMABORT
 . S DIR(0)="D^"_XMOLDP1_":DT:E"
 . D BLD^DIALOG(36404,$$FMTE^XLFDT(XMOLDEST,5),"","DIR(""A"")")
 . ;The oldest message on the system is from |1|.
 . ;Purge all messages originating before
 . S DIR("B")=$$FMTE^XLFDT(XMCUTOFF,5)
 . D BLD^DIALOG(36405,"","","DIR(""?"")")
 . ;All messages whose 'local create date' is prior to the
 . ;'purge date' you enter will be deleted from the system,
 . ;except those which are in one of SHARED,MAIL's baskets,
 . ;OR in POSTMASTER's server baskets or remote transmit queues.
 . S DIR("??")="^N %DT S %DT=0 D HELP^%DTC"
 . D ^DIR I $D(DIRUT) S XMABORT=1 Q
 . S XMPARM("PDATE")=Y
 . I DT-Y>10000 S XMOK=1 Q
 . D ZIS^XM
 . ;The date you entered is less than 1 year ago.
 . W !!,$S($D(IORVON):IORVON,1:""),$S($D(IOBON):IOBON,1:""),$$EZBLD^DIALOG(36406),$S($D(IOBOFF):IOBOFF,1:""),$C(7),$S($D(IORVOFF):IORVOFF,1:"")
 . K DIR
 . S DIR(0)="Y"
 . S DIR("A")=$$EZBLD^DIALOG(36407) ; Are you sure about this date
 . S DIR("B")=$$EZBLD^DIALOG(39053) ; No
 . D ^DIR I $D(DIRUT) S XMABORT=1 Q
 . S XMOK=Y
 . K DIR
 Q:XMABORT
 S XMDIFF=$$FMDIFF^XLFDT(DT,XMPARM("PDATE"),1)
 I XMDIFF=XMPARM("PDAYS")!(XMDIFF<365)!(XMDIFF>9999) Q
 W !
 K DIR,X,Y
 S XMVAR(1)=XMDIFF,XMVAR(2)=XMPARM("PDAYS")
 S DIR(0)="Y"
 ;You have chosen to purge messages older than |1| days old,
 ;which is different from the current default of |2|.
 ;Do you want |1| to be the new default
 D BLD^DIALOG(36408,.XMVAR,"","DIR(""A"")")
 S DIR("B")=$$EZBLD^DIALOG(39053) ; No
 D BLD^DIALOG(36409,.XMVAR,"","DIR(""?"")")
 ;Answer YES if you want field 10.03, DATE PURGE CUTOFF DAYS,
 ;in file 4.3, MAILMAN SITE PARAMETERS, to be set to |1|.
 ;Answer NO if you want that field to remain |2|.
 ;You can also edit this field using option XMKSP."
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 I Y S $P(^XMB(1,1,.18),U,1)=XMDIFF
 S XMPARM("PDAYS")=XMDIFF
 Q
TESTMODE(XMPARM,XMABORT) ;
 I $D(ZTQUEUED) D  Q
 . S XMPARM("TEST")=0
 . S XMPARM("TYPE")=1
 W !
 N DIR,X,Y
 S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(36410) ; TEST mode
 S DIR("B")=$$EZBLD^DIALOG(39054) ; YES
 D BLD^DIALOG(36411,"","","DIR(""?"")")
 ;Test mode will not kill off messages.
 ;Test mode gives you a list of what would happen in 'real' mode.
 ;If you do not run in test mode, messages will be KILLED!
 ;Enter YES to run in 'test' mode; NO, 'real' mode.
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 S XMPARM("TEST")=Y
 S XMPARM("TYPE")=$S(XMPARM("TEST"):2,1:1)
 Q
GRACE(XMPARM,XMABORT) ;
 Q:$D(ZTQUEUED)
 N XMTEXT
 W !
 I XMPARM("TEST") D  Q
 . S XMPARM("GRACE")=0
 . D BLD^DIALOG(36412,"","","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . ;Since we are running in test mode, no warning bulletin will be sent.
 D BLD^DIALOG(36412.1,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;If you queue this purge to run 3 or more days from now, I will send
 ;a bulletin, XM DATE PURGE WARNING, to all users to warn them of the
 ;coming date purge and tell them how to identify all of the messages
 ;in their mailbox, which may be affected.
 Q
PROCESS(XMPARM) ;
 N ZTSAVE,ZTRTN,ZTDESC,ZTSK,XMHNOW
 S ZTSAVE("XMPARM*")=""
 S ZTDESC=$$EZBLD^DIALOG(36413) ;MailMan: MESSAGE PURGE by DATE
 S ZTRTN="ENT^XMA32A"
 I '$D(ZTQUEUED) D  Q:'$D(ZTSK)
 . S XMHNOW=$H
 . D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,,1)
 E  D
 . S ZTDTH=$$HADD^XLFDT(ZTDTH,XMPARM("GRACE"))
 . D ^%ZTLOAD
 I '$D(ZTQUEUED),$$HDIFF^XLFDT(ZTSK("D"),XMHNOW,1)<3 D  Q
 . N XMTEXT
 . W !
 . D BLD^DIALOG(36414,"","","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . ;Since you scheduled the date purge less than 3 days from now,
 . ;no warning bulletin has been sent.
 N XMP,XMINSTR
 S XMINSTR("VAPOR")=$$HTFM^XLFDT($$HADD^XLFDT(ZTSK("D"),,-1)) ; Vaporize 1 hr before purge
 S XMINSTR("FROM")=.5
 S XMP(1)=$$HTE^XLFDT(ZTSK("D"),5)
 S XMP(2)=$$FMTE^XLFDT($$FMADD^XLFDT(XMPARM("PDATE"),-1),5)
 S XMP(3)=$E("==========",1,$L(XMP(2)))
 D TASKBULL^XMXAPI(DUZ,"XM DATE PURGE WARNING",.XMP,,"*",.XMINSTR)
 Q:$D(ZTQUEUED)
 W !
 W $$EZBLD^DIALOG(36415) ;The warning bulletin has been sent.
 Q
