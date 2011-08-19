XMKPR ;ISC-SF/GMB-Post, remote ;10/09/2002  09:40
 ;;8.0;MailMan;**5,6**;Jun 28, 2002
 ; Replaces ^XMBPOST and the first part of ^XMS1 (ISC-WASH/THM/RWF/CAP)
 ; Schedule a task to deliver remote
REMOTE(XMZ,XMINST) ; For addresses containing "@"
 N XMSITE,XMREC,XMPOLL
 S XMREC=^DIC(4.2,XMINST,0)
 S XMSITE=$P(XMREC,U)
 D PUTMSG^XMXMSGS2(.5,XMINST+1000,XMSITE,XMZ)
 Q:$P(XMREC,U,2)'["S"  ; S means to start task immediately
 D:'$$TSKEXIST(XMINST) QUEUE(XMINST,XMSITE)
 Q
TSKEXIST(XMINST,XMTSK) ;Is Task scheduled ? (0=no,ZTSK^$H=pending,ZTSK=running)
 ; Note: ZTSK does not exist when 'playing a script', or for an incoming
 ; transmission.
 S:'$G(XMTSK) XMTSK=$$GETTSK(XMINST)
 Q:'XMTSK 0
 I $D(ZTQUEUED),$G(ZTSK)=XMTSK Q ZTSK
 N ZTSK
 S ZTSK=XMTSK
 D STAT^%ZTLOAD
 Q:ZTSK(1)=0 0  ; "Undefined"
 I ZTSK(1)=1 D  Q ZTSK_U_ZTSK("D")  ; "Active: Pending"
 . D ISQED^%ZTLOAD ; ZTSK("D")=$H when scheduled
 I ZTSK(1)=2 Q ZTSK  ; "Active: Running"
 ;I ZTSK(1)=2 N %1 D  L -^DIC(4.2,+$G(XMINST),"XMNETSEND") Q %1
 ;. ; "Active: Running" - This check isn't reliable,
 ;. ; because the lock is not set for incoming, only for outgoing.
 ;. L +^DIC(4.2,+$G(XMINST),"XMNETSEND"):2 ; Is it really running?
 ;. I $T D KILLTSK(XMINST,ZTSK) S %1=0 Q  ; Nope
 ;. S %1=ZTSK  ; Yep
 Q:ZTSK(1)=3 0  ; "Inactive: Finished"
 I ZTSK(1)=4 D KILLTSK(XMINST,ZTSK) Q 0  ; "Inactive: Available"
 I ZTSK(1)=5 D KILLTSK(XMINST,ZTSK) Q 0  ; "Interrupted"
 Q
GETTSK(XMINST) ;
 L +^XMBS(4.2999,XMINST,3):0 L -^XMBS(4.2999,XMINST,3) ; ensure latest
 Q $P($G(^XMBS(4.2999,XMINST,3)),U,7)
KILLTSK(XMINST,ZTSK) ;
 D KILL^%ZTLOAD
 S $P(^XMBS(4.2999,XMINST,3),U,7)=""
 S $P(^XMBS(4.2999,XMINST,4),U,2)=$$NOW^XLFDT
 Q
QUEUE(XMINST,XMSITE,XMB,ZTDTH,ZTSK) ;
 ; Was ENQ^XMS1 used by ^XMC2,^XMS5,^XMS5B ***
 ; in:
 ; XMINST domain IEN in domain file
 ; XMSITE domain name
 ; XMB    (optional) script choice (default: highest priority script)
 ; ZTDTH  (optional) task start time (default: now)
 ; out:
 ; ZTSK   task number
 N I,XMIENS,XMFDA,ZTIO,ZTDESC,ZTRTN
 I '$D(^XMBS(4.2999,XMINST,0)) D STAT^XMTDR(XMINST)
 L +^XMBS(4.2999,XMINST):1
 I '$G(XMB("SCR IEN")) D  Q:'XMB("SCR IEN")
 . D XMTCHECK(XMINST,.XMB)
 . D SCRIPT^XMKPR1(XMINST,XMSITE,.XMB)
 S ZTIO=$P(XMB("SCR REC"),U,5)
 S ZTDESC=$$EZBLD^DIALOG(42000,XMSITE) ; MailMan: To |1|
 S:'$G(ZTDTH) ZTDTH=$H
 F I="XMINST","XMPOLL" S ZTSAVE(I)=""
 S ZTRTN="TASK^XMTDR"
 D ^%ZTLOAD
 S ^XMBS(4.2999,XMINST,3)="" ; current xmit stats
 S $P(^XMBS(4.2999,XMINST,3),U,7)=ZTSK
 S XMIENS=XMINST_","
 I 'XMB("TRIES"),'XMB("ITERATIONS") D
 . S XMFDA(4.2999,XMIENS,41)="@" ; xmit start date/time
 . S XMFDA(4.2999,XMIENS,42)="@" ; xmit finish date/time
 . S XMFDA(4.2999,XMIENS,45)="@" ; xmit latest try date/time
 . K ^XMBS(4.2999,XMINST,6)      ; xmit audit multiple
 S XMFDA(4.2999,XMIENS,25)=ZTSK                ; task number
 S XMFDA(4.2999,XMIENS,43)=XMB("SCR IEN")      ; ien of script to be used
 S XMFDA(4.2999,XMIENS,44)=XMB("TRIES")        ; xmit tries
 S XMFDA(4.2999,XMIENS,46)=XMB("ITERATIONS")   ; xmit iterations
 S XMFDA(4.2999,XMIENS,47)=XMB("FIRST SCRIPT") ; ien of first script
 S XMFDA(4.2999,XMIENS,48)=XMB("IP TRIED")     ; IP addresses tried
 S XMFDA(4.2999,XMIENS,51)=XMB("SCR REC")      ; script record
 D FILE^DIE("","XMFDA")
 L -^XMBS(4.2999,XMINST)
 Q
XMTCHECK(XMINST,XMB) ;
 N XMTREC
 L +^XMBS(4.2999,XMINST,4):0 L -^XMBS(4.2999,XMINST,4) ; ensure latest
 S XMTREC=$G(^XMBS(4.2999,XMINST,4))
 Q:'$P(XMTREC,U,1)!$P(XMTREC,U,2)
 ; Start time, but no finish time.
 ; Previous transmission attempt was aborted. Pick up where we left off.
 S XMB("SCR IEN")=$P(XMTREC,U,3)
 S XMB("TRIES")=$P(XMTREC,U,4)
 S XMB("LAST TRY")=$P(XMTREC,U,5)
 S XMB("ITERATIONS")=$P(XMTREC,U,6)
 S XMB("FIRST SCRIPT")=$P(XMTREC,U,7)
 S XMB("IP TRIED")=$P(XMTREC,U,8)
 S XMB("SCR REC")=$G(^XMBS(4.2999,XMINST,5))
 Q
REQUEUE(XMINST,XMSITE,XMB) ;
 N XMFDA,XMIENS,ZTDTH,ZTIO,ZTDESC,ZTRTN
 S XMFDA(4.29992,XMB("AUDIT IENS"),2)=$E($G(ER("MSG"),$$EZBLD^DIALOG(42192)),1,200) ;Unknown Error
 D FILE^DIE("","XMFDA")
 I XMB("TRIES")+1=$P(XMB("SCR REC"),U,3) D POSTFAIL(XMINST,XMSITE,.XMB)
 D SCRIPT^XMKPR1(XMINST,XMSITE,.XMB) Q:'XMB("SCR IEN")
 S XMIENS=XMINST_","
 S XMFDA(4.2999,XMIENS,43)=XMB("SCR IEN")    ; ien of script to be used
 S XMFDA(4.2999,XMIENS,44)=XMB("TRIES")      ; xmit tries
 S XMFDA(4.2999,XMIENS,46)=XMB("ITERATIONS") ; xmit iterations
 S XMFDA(4.2999,XMIENS,48)=XMB("IP TRIED")   ; IP addresses tried
 S XMFDA(4.2999,XMIENS,51)=XMB("SCR REC")    ; script record
 D FILE^DIE("","XMFDA")
 ; XMB("TRIES") starts off at 0 with every script.
 ; Each time the script is retried, XMB("TRIES") is bumped up by 1.
 ; XMB("ITERATIONS") starts off at 0.  After a cycle of scripts is tried,
 ; XMB("ITERATIONS") is bumped up by 1 when the cycle is started again.
 ; We start every new cycle after one hour.
 ; We start every new try after one minute
 I XMB("TRIES") D
 . S ZTDTH=$$HADD^XLFDT($H,"","",1) ; New try, add 1 minute
 E  I XMB("ITERATIONS"),XMB("SCR IEN")=XMB("FIRST SCRIPT") D
 . S ZTDTH=$$HADD^XLFDT($H,"",1) ; New iteration, add 1 hour
 E  S ZTDTH=$H  ; First try, new script within same iteration
 S ZTIO=$P(XMB("SCR REC"),U,5)
 S ZTDESC=$$EZBLD^DIALOG(42000.1,XMSITE) ;MailMan: To |1| (requeue)
 ; ("_XMB("ITERATIONS")_","_XMB("SCR IEN")_","_XMB("TRIES")_")"
 S ZTRTN="TASK^XMTDR"
 S ZTREQ=ZTDTH_U_ZTIO_U_ZTDESC_U_ZTRTN
 D DOTRAN^XMC1(42000.2,XMSITE) ;|1| Requeued
 Q
POSTFAIL(XMINST,XMSITE,XMB) ; Postmaster message on queue failure
 N XMPARM,XMINSTR,XMI,XMJ,XMTRIES,XMFIRST
 K ^TMP("XM",$J)
 S XMINSTR("FROM")="POSTMASTER",XMINSTR("ADDR FLAGS")="R"
 S XMTRIES=$P(XMB("SCR REC"),U,3)
 S XMPARM(1)=XMSITE,XMPARM(2)=XMTRIES
 S XMJ=0
 S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=""
 S XMFIRST=$P($G(^XMBS(4.2999,XMINST,6,0)),U,3)-XMTRIES
 S:XMFIRST<0 XMFIRST=0
 S XMI=XMFIRST ; Get tries audit from ^XMBS(4.2999, "XMIT AUDIT" multiple
 F  S XMI=$O(^XMBS(4.2999,XMINST,6,XMI)) Q:'XMI  S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=^(XMI,0)
 S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=""
 S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=$$EZBLD^DIALOG(42190) ;A transcript of the last delivery attempt follows:
 S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=""
 S XMI=0
 F  S XMI=$O(^TMP("XMC",XMC("AUDIT"),XMI)) Q:'XMI  S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=^(XMI,0)
 I XMFIRST'=0 D
 . N XMMAX ; Maximum number of old audit records
 . S XMMAX=100
 . S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)="**********************************************"
 . S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=""
 . I XMFIRST'>XMMAX D
 . . S XMI=0
 . . S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=$$EZBLD^DIALOG(42191) ;The following errors occurred in previous attempts:
 . E  D
 . . S XMI=XMFIRST-XMMAX
 . . S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=$$EZBLD^DIALOG(42191.1,$$FMTE^XLFDT($P(^XMBS(4.2999,XMINST,6,1,0),U,1),5)) ;The errors started on |1|.
 . . S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=""
 . . S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=$$EZBLD^DIALOG(42191.2,XMMAX) ;The following errors occurred in the previous |1| attempts:
 . ; Get tries audit from ^XMBS(4.2999, "XMIT AUDIT" multiple
 . S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=""
 . F  S XMI=$O(^XMBS(4.2999,XMINST,6,XMI)) Q:XMI>XMFIRST  S XMJ=XMJ+1,^TMP("XM",$J,XMJ,0)=^(XMI,0)
 D TASKBULL^XMXBULL(.5,"XM SEND ERR TRANSMISSION",.XMPARM,"^TMP(""XM"",$J)",.5,.XMINSTR)
 K ^TMP("XM",$J)
 Q
