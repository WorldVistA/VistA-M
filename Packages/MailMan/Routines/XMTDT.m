XMTDT ;ISC-SF/GMB-Deliver later'd msgs & delete inactive msgs ;04/15/2003  12:48
 ;;8.0;MailMan;**18**;Jun 28, 2002
 ; Replaces ^XMADJ999,LATER^XMAD2 (ISC-WASH/CAP)
GO ;
 N XMWAIT
 I $D(ZTQUEUED) S ZTREQ="@"
 L +^XMBPOST("POST_Tickler"):1 E  Q
 I $D(ZTQUEUED) S %=$$PSET^%ZTLOAD(ZTSK)
 F  Q:$P($G(^XMB(1,1,0)),U,16)  D
 . D LATERNEW
 . D LATERFWD
 . D PURGEOLD
 . D FILTRFWD
 . S XMWAIT=$$TSTAMP^XMXUTIL1      ; Why can't we just H 60?
 . F  D  Q:$$TSTAMP^XMXUTIL1-XMWAIT>60
 . . H XMHANG
 L -^XMBPOST("POST_Tickler")
 I $D(ZTQUEUED) D PCLEAR^%ZTLOAD(ZTSK)
 Q
LATERNEW ; This routine takes care of 'new'ing messages which the user
 ; had previously 'later'ed for himself.
 N XMNOW,XMLATER,DIK,XMDUZ,XMZ,DA,XMZREC,XMINACT
 S XMNOW=$$NOW^XLFDT
 S XMLATER=0
 F  S XMLATER=$O(^XMB(3.73,"AB",XMLATER)) Q:XMLATER'>0!(XMLATER>XMNOW)  D
 . S DIK="^XMB(3.73,"
 . S XMDUZ=0
 . F  S XMDUZ=$O(^XMB(3.73,"AB",XMLATER,XMDUZ)) Q:'XMDUZ  D
 . . S XMINACT=$S($P($G(^VA(200,XMDUZ,0)),U,3)="":1,$P($G(^(.1)),U,2)="":1,$P($G(^(201)),U)="":1,1:0)  ; user is inactive if no access code, or verify code, or primary menu
 . . S XMZ=0
 . . F  S XMZ=$O(^XMB(3.73,"AB",XMLATER,XMDUZ,XMZ)) Q:'XMZ  D
 . . . S DA=$O(^XMB(3.73,"AB",XMLATER,XMDUZ,XMZ,0)) Q:'DA
 . . . I '$D(^XMB(3.73,DA,0)) D  Q  ; *** This should not be necessary
 . . . . K ^XMB(3.73,"AB",XMLATER,XMDUZ,XMZ,DA)
 . . . . K ^XMB(3.73,"AC",XMZ,XMDUZ,DA)
 . . . . K ^XMB(3.73,"C",XMDUZ,DA)
 . . . D ^DIK
 . . . Q:XMINACT
 . . . S XMZREC=$G(^XMB(3.9,XMZ,0)) Q:XMZREC=""
 . . . D RESURECT^XMXMSGS2(XMDUZ,XMZ)
 . . . D DELIVER^XMTDL2(XMDUZ,XMZ,$P(XMZREC,U,1),$P(XMZREC,U,2),0,1)
 Q
LATERFWD ; This routine takes care of forwarding messages which a user
 ; had previously scheduled for 'later' delivery to other users.
 N XMDUZ,XMNOW,XMLATER,DIK,XMIEN,XMZ,DA,XMREC,XMV,XMINSTR,XMTO,XMPRIVAT
 K XMERR,^TMP("XMERR",$J)
 S XMPRIVAT=$$EZBLD^DIALOG(39135) ; " [Private Mail Group]"
 S XMINSTR("FWD BY XMDUZ")=""
 S XMNOW=$$NOW^XLFDT
 S XMLATER=0
 F  S XMLATER=$O(^XMB(3.9,"AL",XMLATER)) Q:XMLATER'>0!(XMLATER>XMNOW)  D
 . S XMZ=0
 . F  S XMZ=$O(^XMB(3.9,"AL",XMLATER,XMZ)) Q:'XMZ  D
 . . S DA(1)=XMZ
 . . S DIK="^XMB(3.9,"_DA(1)_",7,"
 . . S XMIEN=0
 . . F  S XMIEN=$O(^XMB(3.9,"AL",XMLATER,XMZ,XMIEN)) Q:'XMIEN  D
 . . . S XMREC=$G(^XMB(3.9,XMZ,7,XMIEN,0))
 . . . I XMREC="" K ^XMB(3.9,"AL",XMLATER,XMZ,XMIEN) Q
 . . . S XMDUZ=$P(XMREC,U,3)
 . . . S XMTO=$P(XMREC,U,1)
 . . . I XMTO[XMPRIVAT S XMTO=$P(XMTO,XMPRIVAT,1) ; " [Private Mail Group]" (set in ^XMXADDRG)
 . . . I $P(XMREC,U,2)'="" S XMTO=$P(XMREC,U,2)_":"_XMTO
 . . . D INIT^XMXADDR
 . . . D CHKADDR^XMXADDR(XMDUZ,XMTO) K:$D(XMERR) XMERR,^TMP("XMERR",$J)
 . . . S XMINSTR("FWD BY")=$P(XMREC,U,4)
 . . . D:$D(^TMP("XMY",$J)) FWD^XMKP(XMDUZ,XMZ,.XMINSTR)
 . . . D CLEANUP^XMXADDR
 . . . S DA=XMIEN
 . . . D ^DIK
 Q
PURGEOLD ; This routine deletes msgs marked for automatic deletion,
 ; whether marked by the user, or marked by the 'in basket purge'
 ; because they hadn't been accessed for a certain number of days.
 ; Replaces ^XMAI0 (ISC-WASH/CAP/RJ)
 ; XMDDATE  Message delete date
 N XMDDATE,XMDUZ,XMK,XMZ,XMNOW
 S XMNOW=$$NOW^XLFDT
 S (XMDDATE,XMDUZ,XMK,XMZ)=""
 F  S XMDDATE=$O(^XMB(3.7,"AC",XMDDATE)) Q:XMDDATE=""!(XMDDATE>XMNOW)  D
 . F  S XMDUZ=$O(^XMB(3.7,"AC",XMDDATE,XMDUZ)) Q:XMDUZ=""  D
 . . F  S XMK=$O(^XMB(3.7,"AC",XMDDATE,XMDUZ,XMK)) Q:XMK=""  D
 . . . F  S XMZ=$O(^XMB(3.7,"AC",XMDDATE,XMDUZ,XMK,XMZ)) Q:XMZ=""  D
 . . . . I $D(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)) D ZAPIT^XMXMSGS2(XMDUZ,XMK,XMZ) Q
 . . . . K ^XMB(3.7,"AC",XMDDATE,XMDUZ,XMK,XMZ)
 Q
FILTRFWD ; This routine forwards messages for a user when a filter
 ; with 'forward to' recipients has activated during message delivery.
 N XMDUZ,XMUPTR,XMZ,XMREC,XMV,XMINSTR,XMTO,XMPRIVAT,XMFIEN,XMFWDIEN
 S XMPRIVAT=$$EZBLD^DIALOG(39135) ; " [Private Mail Group]"
 S XMINSTR("FWD BY XMDUZ")="F"
 S XMFIEN=0
 F  S XMFIEN=$O(^XMB(3.9,"AF",XMFIEN)) Q:'XMFIEN  D
 . S XMZ=0
 . F  S XMZ=$O(^XMB(3.9,"AF",XMFIEN,XMZ)) Q:'XMZ  D
 . . S XMUPTR=0
 . . F  S XMUPTR=$O(^XMB(3.9,"AF",XMFIEN,XMZ,XMUPTR)) Q:'XMUPTR  D
 . . . S XMREC=$G(^XMB(3.9,XMZ,1,XMUPTR,0))
 . . . S XMDUZ=$P(XMREC,U,1)
 . . . I XMREC=""!'XMDUZ!($P(XMREC,U,13)'=XMFIEN) K ^XMB(3.9,"AF",XMFIEN,XMZ,XMUPTR) Q
 . . . S XMFWDIEN=0
 . . . D INIT^XMXADDR
 . . . F  S XMFWDIEN=$O(^XMB(3.7,XMDUZ,15,XMFIEN,1,XMFWDIEN)) Q:'XMFWDIEN  S XMREC=$G(^(XMFWDIEN,0)) D
 . . . . S XMTO=$P(XMREC,U,1) Q:XMTO=""
 . . . . N XMERROR,XMFULL,XMFWDADD
 . . . . I XMTO[XMPRIVAT S XMTO=$P(XMTO,XMPRIVAT,1) ; " [Private Mail Group]" (set in ^XMXADDRG)
 . . . . ;I $P(XMREC,U,2)'="" S XMTO=$P(XMREC,U,2)_":"_XMTO
 . . . . D ADDRESS^XMXADDR(XMDUZ,XMTO,.XMFULL,.XMERROR) Q:'$D(XMERROR)
 . . . . D DELFWDTO^XMTDF(XMDUZ,XMFIEN,XMFWDIEN,XMTO,$$GETERR^XMXADDR4)
 . . . S XMINSTR("FWD BY")=$$NAME^XMXUTIL(XMDUZ)
 . . . D:$D(^TMP("XMY",$J)) FWD^XMKP(XMDUZ,XMZ,.XMINSTR)
 . . . D CLEANUP^XMXADDR
 . . . N XMFDA
 . . . S XMFDA(3.91,XMUPTR_","_XMZ_",",15)=0 ; filter forward completed
 . . . D FILE^DIE("","XMFDA")
 Q
