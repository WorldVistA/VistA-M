XMA3 ;ISC-SF/GMB-XMCLEAN, XMAUTOPURGE ;04/18/2002  07:09
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; CLEAN      Option: XMCLEAN - Clean out waste baskets and
 ;                              Postmaster's ARRIVING basket
 ; EN         Option: XMAUTOPURGE - Purge Unreferenced Messages
 ; SCAN       Option: XMPURGE - Purge Unreferenced Messages, then STAT
 ; STAT       Option: XMSTAT  - Message Statistics
 Q
EN ;
 N XMPARM
 D PURGEIT(.XMPARM)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
STAT ;
 D AUDIT^XMA30 ; Show purge audit records
 D USERSTAT^XMA30 ; Show user mailbox info
 Q
SCAN ; PURGE MESSAGES
 I $D(ZTQUEUED) G EN
 N DIR,XMPARM,XMTEXT
 D AUDIT^XMA30 ; Show purge audit records
 S DIR(0)="E" D ^DIR Q:$D(DIRUT)  K DIR
 D BLD^DIALOG(36425,"","","XMTEXT","F")
 ;I will purge messages which are not in anybody's Mailbox.
 ;This will be done by comparing the message numbers in the MESSAGE file
 ;(3.9) against the 'M' cross reference of the MAILBOX file (3.7).
 ;Because this is a real-time dynamic cross reference, it is
 ;RECOMMENDED that you run the INTEGRITY CHECKER with some
 ;frequency, to CORRECT problems, if any.
 I '$P($G(^XMB(1,1,.12)),U) D
 . D BLD^DIALOG(36426,"","","XMTEXT","SF")
 . ;A Mailbox INTEGRITY CHECK will run before the PURGE.
 E  D
 . D BLD^DIALOG(36427,"","","XMTEXT","SF")
 . ;A Mailbox INTEGRITY CHECK will NOT run before the PURGE,
 . ;because your site parameters indicate you do not want it to.
 . ;You may want to do a BACK-UP just before this runs, and revert
 . ;to it if many problems are discovered.
 W !
 D MSG^DIALOG("WM","","","","XMTEXT")
 W !
 D GETPARMS(.XMPARM)
 D BLD^DIALOG(36428,"","","DIR(""A"")") ;Do you really want to purge all unreferenced messages
 S DIR("B")=$$EZBLD^DIALOG(39053) ; NO
 S DIR(0)="Y"
 D ^DIR Q:'Y
 D WAIT^DICD
 D PURGEIT(.XMPARM)
 K DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  K DIR
 D STAT
 Q
PURGEIT(XMPARM) ;
 N XMKILL,XMIEN,XMCNT,XMCRE8,XMABORT
 D INIT(.XMIEN,.XMPARM,.XMKILL,.XMABORT) Q:XMABORT
 D MPURGE(.XMCRE8,.XMPARM,.XMKILL,.XMCNT,.XMABORT)
 D FINISH(XMIEN,XMCRE8,.XMKILL,.XMCNT,XMABORT)
 Q
INIT(XMIEN,XMPARM,XMKILL,XMABORT) ;
 S XMABORT=0
 D:'$D(XMPARM) GETPARMS(.XMPARM)
 I '$P($G(^XMB(1,1,.12)),U) D MAILBOX^XMUT4(.XMABORT) Q:XMABORT  ; Integrity check
 S (XMKILL("MSG"),XMKILL("RESP"))=0
 S XMKILL("START")=$P(^XMB(3.9,0),U,4)
 D AUDTPURG^XMA32 ; purge audit records
 D DONTPURG^XMA30 ; Note all messages which shouldn't be purged
 D INITAUDT^XMA32A(.XMIEN,.XMPARM)
 Q
GETPARMS(XMPARM) ;
 N XMSBUF,XMBUFREC
 S (XMPARM("TYPE"),XMPARM("START"))=0
 ; Set up a date buffer, beyond which we won't purge
 S XMBUFREC=$G(^XMB(1,1,.14))
 S XMPARM("END")=$$PDATE(+$P(XMBUFREC,U,1),2) ; purge thru this date
 S XMPARM("PDATE")=$$PDATE(+$P(XMBUFREC,U,2),7) ; don't purge local messages sent on or after this date to remote sites.
 ; If today is Saturday, start purge at beginning.
 ; If not Saturday, check MailMan Site Parameter file for field 4.304 ...
 I $$DOW^XLFDT(DT,1)'=6 D
 . S XMSBUF=+$P($G(^XMB(1,1,"NOTOPURGE")),U)
 . I XMSBUF=0,($G(^XMB("NETNAME"))="FORUM.VA.GOV"!$G(^XMB("NETNAME"))="FORUM.MED.VA.GOV") S XMSBUF=45
 . Q:XMSBUF=0
 . S XMPARM("START")=$$PDATE(XMSBUF,45)
 Q:$D(ZTQUEUED)
 N XMTEXT,XMVAR
 S XMVAR(1)=$$FMTE^XLFDT($S(XMPARM("START")=0:$O(^XMB(3.9,"C",0)),1:XMPARM("START")),5)
 S XMVAR(2)=$$FMTE^XLFDT(XMPARM("END"),5)
 S XMVAR(3)=$$FMTE^XLFDT(XMPARM("PDATE"),5)
 D BLD^DIALOG(36429,.XMVAR,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;Any unreferenced message will be purged if its local create date
 ;is from |1| to |2| inclusive.
 ;However, locally generated messages sent to remote sites will not be purged
 ;if they were sent on or after |3|.
 ;The following messages are considered 'referenced' and will not be purged:
 ;- Messages in users' baskets
 ;- Messages in transit (arriving or being sent)
 ;- Server messages
 ;- Messages being edited (includes aborted edits)
 ;- Later'd messages
 Q
PDATE(XMDAYS,XMDEFALT) ; Subtract so many days from today and return that date.
 S:+XMDAYS=0 XMDAYS=XMDEFALT ; use default if days is null
 Q $$FMADD^XLFDT(DT,-XMDAYS)
FINISH(XMIEN,XMCRE8,XMKILL,XMCNT,XMABORT) ;
 K ^TMP("XM",$J)
 S XMKILL("TOTAL")=XMKILL("MSG")+XMKILL("RESP")
 ;I $G(ZTSTOP) W !!,"*** Stopping prematurely per user request ***"
 I '$D(ZTQUEUED) D
 . N XMVAR,XMTEXT
 . S XMVAR(1)=$J(XMCNT,$L(XMKILL("START")))
 . S XMVAR(2)=$J(XMKILL("TOTAL"),$L(XMKILL("START")))
 . S XMVAR(3)=$J(XMKILL("START")-XMKILL("TOTAL"),$L(XMKILL("START")))
 . W !
 . D BLD^DIALOG(36430,.XMVAR,"","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . ;|1| messages processed, |2| messages purged, |3| messages in file 3.9
 D CHKAUDT^XMA32A(XMIEN,XMCRE8,.XMKILL)
 Q
MPURGE(XMCRE8,XMPARM,XMKILL,XMCNT,XMABORT) ;
 N XMZREC,XMZ
 S XMZ="",XMCNT=0
 S XMCRE8=$S(XMPARM("START")=0:0,1:$O(^XMB(3.9,"C",XMPARM("START")),-1))
 F  S XMCRE8=$O(^XMB(3.9,"C",XMCRE8)) Q:'XMCRE8  Q:XMCRE8>XMPARM("END")  D
 . F  S XMZ=$O(^XMB(3.9,"C",XMCRE8,XMZ)) Q:'XMZ  D
 . . S XMCNT=XMCNT+1 I XMCNT#5000=0 D  Q:XMABORT
 . . . I '$D(ZTQUEUED) W:$X>40 ! W XMCNT,"." Q
 . . . I $$S^%ZTLOAD S (XMABORT,ZTSTOP)=1 ; User asked the task to stop
 . . I '$D(^XMB(3.9,XMZ)) K ^XMB(3.9,"C",XMCRE8,XMZ) Q
 . . Q:$D(^XMB(3.7,"M",XMZ))        ; Msg is in someone's basket
 . . Q:$D(^TMP("XM",$J,"NOP",XMZ))  ; Msg is one of "do not purge"
 . . S XMZREC=$G(^XMB(3.9,XMZ,0))
 . . Q:$P(XMZREC,U,8)                  ; Msg is a response
 . . I $P($P(XMZREC,U,3),".")?7N,XMCRE8'<XMPARM("PDATE"),$O(^XMB(3.9,XMZ,1,"C",":"))'="" Q  ; local msg recently sent to remote site
 . . D PURGE(XMZ,.XMKILL)
 Q
PURGE(XMZ,XMKILL) ; Purge message and responses
 N XMZR,XMIEN
 S XMIEN=0
 F  S XMIEN=$O(^XMB(3.9,XMZ,3,XMIEN)) Q:XMIEN'>0  D
 . S XMZR=$P($G(^XMB(3.9,XMZ,3,XMIEN,0)),U) Q:'XMZR
 . D KILLRESP(XMZR,.XMKILL)
 D KILLMSG(XMZ,.XMKILL)
 Q
KILLRESP(XMZ,XMKILL) ; Kill response
 Q:'$D(^XMB(3.9,XMZ))      ; Response does not exist
 Q:$D(^XMB(3.7,"M",XMZ))   ; Someone has response in mailbox
 D KILLMSG^XMXUTIL(XMZ)
 S XMKILL("RESP")=XMKILL("RESP")+1
 Q
KILLMSG(XMZ,XMKILL) ; Kill message
 D KILLMSG^XMXUTIL(XMZ)
 S XMKILL("MSG")=XMKILL("MSG")+1
 Q
CLEAN ; Clean various files
 D CSTAT ; Clean Message Statistics file
 D CMBOX ; Clean WASTE baskets & Postmaster's ARRIVING basket
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CSTAT ; Clean Statistics file audits - delete records more than 2 years old
 N XMINST,XMAUDT,XMCUTOFF,DA,DIK
 S XMCUTOFF=DT\100-200   ; 2 years ago, in yyymm format
 S XMINST=0
 F  S XMINST=$O(^XMBS(4.2999,XMINST)) Q:XMINST'>0  D
 . S DA(1)=XMINST,DIK="^XMBS(4.2999,"_DA(1)_",100,"
 . S XMAUDT=0
 . F  S XMAUDT=$O(^XMBS(4.2999,XMINST,100,XMAUDT)) Q:XMAUDT'>0!(XMAUDT>XMCUTOFF)  D
 . . S DA=XMAUDT D ^DIK
 Q
CMBOX ; Clean the mailbox file
 N XMDUZ,XMCNT,XMABORT
 D CARRIVE
 S (XMDUZ,XMCNT,XMABORT)=0
 F  S XMDUZ=$O(^XMB(3.7,XMDUZ)) Q:XMDUZ'>0  D  Q:XMABORT
 . D CWASTE(XMDUZ,.XMCNT,.XMABORT)
 W:'$D(ZTQUEUED) !,$$EZBLD^DIALOG(36431) ; Waste & Arriving Baskets Cleaned!
 Q
CWASTE(XMDUZ,XMCNT,XMABORT) ; Clean a user's WASTE basket
 S XMCNT=XMCNT+1 I XMCNT#100=0 D  Q:XMABORT
 . I '$D(ZTQUEUED) W:$X>40 ! W XMCNT,"." Q
 . I $$S^%ZTLOAD S (XMABORT,ZTSTOP)=1 ; User asked the task to stop
 L +^XMB(3.7,XMDUZ,2,.5):5  E  Q
 N XMZ
 S XMZ=0
 F  S XMZ=$O(^XMB(3.7,XMDUZ,2,.5,1,XMZ)) Q:XMZ'>0  K ^XMB(3.7,"M",XMZ,XMDUZ,.5)
 K ^XMB(3.7,XMDUZ,2,.5)
 S ^XMB(3.7,XMDUZ,2,.5,0)=$$EZBLD^DIALOG(37004) ; "WASTE"
 S ^XMB(3.7,XMDUZ,2,.5,1,0)="^3.702P^0^0"
 L -^XMB(3.7,XMDUZ,2,.5)
 Q
CARRIVE ; Clean the postmaster's ARRIVING basket
 N XMZ,XMCNT,XMZLAST,XMDATE,XMPARM
 S XMPARM("END")=$$PDATE(+$P($G(^XMB(1,1,.14)),U,1),2)
 L +^XMB(3.7,.5,2,.95):5 E  Q
 S (XMZ,XMCNT,XMZLAST)=0
 F  S XMZ=$O(^XMB(3.7,.5,2,.95,1,XMZ)) Q:XMZ'>0  D
 . I '$D(^XMB(3.9,XMZ,0)) D  Q
 . . S DA=XMZ,DA(1)=.95,DA(2)=.5,DIK="^XMB(3.7,.5,2,.95,1," D ^DIK
 . ; If it's still arriving, its date will be a FileMan date.
 . ; After it's finished arriving, its date will be an internet (text) date.
 . S XMDATE=$P($G(^XMB(3.9,XMZ,0)),U,3)
 . I XMDATE?7N1".".N,XMDATE'>XMPARM("END") D  Q  ; been arriving for over 24 hours
 . . S DA=XMZ,DA(1)=.95,DA(2)=.5,DIK="^XMB(3.7,.5,2,.95,1," D ^DIK
 . S XMCNT=XMCNT+1,XMZLAST=XMZ
 S ^XMB(3.7,.5,2,.95,0)="ARRIVING",^(1,0)="^3.702P^"_XMZLAST_U_XMCNT
 L -^XMB(3.7,.5,2,.95)
 Q
