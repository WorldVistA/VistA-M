XMKPL ;ISC-SF/GMB-Manage the local mail posting process ;04/17/2002  10:54
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMADGO1,^XMADGO (ISC-WASH/CAP)
 ; Entry points (not covered by DBIA):
 ; CHECK   Check the local processes.
 ;         If they haven't been deliberately STOP'd,
 ;         and if they are not running,
 ;         then task them.
 ; STATUS  Get status of local processes.
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; STOP    XMMGR-STOP-BACKGROUND-FILER  - Stop the local processes.
 ; START   XMMGR-START-BACKGROUND-FILER - Start the local processes.
 ;
CHECK ; Task Background Filer processes if any missing
 Q:$P(^XMB(1,1,0),U,16)  ; Quit if 'background filer stop flag' set.
 N XMPROC,XMSTATUS
 D STATUS(.XMSTATUS)
 Q:'$D(XMSTATUS)
 S XMPROC=""
 F  S XMPROC=$O(XMSTATUS(XMPROC)) Q:XMPROC=""  D QUEUE(XMPROC)
 Q
STATUS(XMSTATUS) ;Check status of background filer
 N XMPROC,XMLOCK
 F XMPROC="Mover","Tickler" D
 . S XMLOCK="POST_"_XMPROC
 . L +^XMBPOST(XMLOCK):0 E  Q
 . S XMSTATUS(XMPROC)=$$EZBLD^DIALOG($S(XMPROC="Mover":36224.1,1:36224.2)) ; The Mover/Tickler is not running!
 . L -^XMBPOST(XMLOCK)
 Q
QUEUE(XMPROC) ;Start Queue processors
 N XMHANG,ZTRTN,ZTDESC,ZTSAVE,X,ZTSK,ZTQUEUED,ZTCPU,ZTDTH,ZTIO
 S XMHANG=$$HANG
 S ZTDESC=$$EZBLD^DIALOG($S(XMPROC="Mover":36227,1:36228)) ; MailMan: Background Filer (Mover/Tickler)
 S ZTSAVE("XMHANG")=""
 S ZTRTN=$S(XMPROC="Mover":"GO^XMKPLQ",1:"GO^XMTDT")
 I $D(^XMB(1,1,0)) S X=$P(^(0),U,12) I X'="" S ZTCPU=$P(X,",",2)
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
HANG() ; Get Hangtime for delivery modules
 N X
 S X=$P($G(^XMB(1,1,0)),U,13)
 Q $S(X:X,1:5)
STOP ; Stop Background mail delivery processes
 N DIR,Y,DIRUT
 S DIR(0)="Y"
 D BLD^DIALOG(36229,"","","DIR(""A"")")
 ;Are you sure you want the Background Filers to stop delivering mail
 S DIR("B")=$$EZBLD^DIALOG(39053) ; No
 D ^DIR Q:'Y
 S $P(^XMB(1,1,0),U,16)=1  ; Set 'background filer stop flag'
 W:'$D(ZTQUEUED) !!,$C(7),$$EZBLD^DIALOG(36229.1) ; << Background Filers will stop soon. >>
 Q
START ; Start the local processes (usually after they had been STOP'd).
 S $P(^XMB(1,1,0),U,16)=""  ; Reset 'background filer stop flag'
 D CHECK
 W:'$D(ZTQUEUED) !!,$C(7),$$EZBLD^DIALOG(36229.2) ; << Background Filers will start soon. >>
 Q
