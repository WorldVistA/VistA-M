XMUPIN ;ISC-SF/GMB-IN Basket Purge ;04/11/2002  08:33
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMAI,^XMAI0,^XMAI1 (ISC-WASH/CAP)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ENTER  XMMGR-IN-BASKET-PURGE
ENTER ;
 ; XMIDAYS  If msg hasn't been read for this many days, flag for deletion
 ; XMDDAYS  If flagged msg hasn't been read after this many days, delete it
 N XMIDAYS,XMDDAYS,XMKALL,XMEXEMPT,XMABORT,XMTEST
 D INIT(.XMDUZ,.XMTEST,.XMDDAYS,.XMIDAYS,.XMKALL,.XMABORT) Q:XMABORT
 D PROCESS(XMTEST,XMDDAYS,XMIDAYS,XMKALL,.XMEXEMPT)
 Q
TEST ;
 N XMIDAYS,XMDDAYS,XMKALL,XMEXEMPT,XMABORT,XMTEST
 S XMTEST=1
 D INIT(.XMDUZ,.XMTEST,.XMDDAYS,.XMIDAYS,.XMKALL,.XMABORT) Q:XMABORT
 D PROCESS(XMTEST,XMDDAYS,XMIDAYS,XMKALL,.XMEXEMPT)
 Q
INIT(XMDUZ,XMTEST,XMDDAYS,XMIDAYS,XMKALL,XMABORT) ;
 I '$G(DUZ) W $C(7),!!,$$EZBLD^DIALOG(38105) G H^XUS ; You do not have a DUZ.
 I '$D(XMDUZ) S XMDUZ=.5
 D DT^DICRW ; Set up required FM variables
 S:'$D(XMTEST) XMTEST=0
 S XMDDAYS=30,XMABORT=0
 S XMIDAYS=+$P($G(^XMB(1,1,0)),U,9)
 S:'XMIDAYS XMIDAYS=30
 S XMKALL=+$P($G(^XMB(1,1,.15)),U)
 Q:$D(ZTQUEUED)
 N DIR,Y,DIRUT,XMPARM
 W !
 S XMPARM(1)=XMIDAYS,XMPARM(2)=XMDDAYS
 ;This process cleans out old messages from user mailboxes.
 ;
 ;Fields in the MAILMAN SITE PARAMETERS file 4.3 let you fine-tune:
 ; - field 10:    Number of days since the messages have been read
 ; - field 10.01: Examine ALL baskets or just the IN basket.
 ;
 ;Messages that are not 'NEW' and have NOT been READ for |1| days are
 ;marked for automatic deletion.  Messages so marked, which have not been
 ;read nor saved into another Basket within |2| days, will be deleted
 ;automatically from users' mailboxes.
 ;
 ;Each user will receive a message listing messages that are marked
 ;for deletion.  The |2| day grace period allows users to receive
 ;this message and have time to prevent messages they want to keep from
 ;being deleted from their Mail Baskets.
 ;
 ;Even then many of the messages may still be recalled via the
 ;search process that can be invoked to search for messages that
 ;the user is a recipient of.  As long as the 'AUTOPURGE' has not
 ;been run or another user has kept a copy, messages can be recovered.
 D BLD^DIALOG(36610,.XMPARM,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 W ! ;This may take some time.  Do you wish to continue
 D BLD^DIALOG(36611,"","","DIR(""A"")")
 S DIR(0)="Y",DIR("B")=$$EZBLD^DIALOG(39053) ;No
 S DIR("??")="XM-IN-BASKET-PURGE"
 D ^DIR I 'Y S XMABORT=1 Q
 W !
 D BLD^DIALOG($S(XMKALL:36612,1:36613),XMDDAYS,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;Compiling lists of messages to PURGE in |1| days from *all*/IN baskets
 Q
PROCESS(XMTEST,XMDDAYS,XMIDAYS,XMKALL,XMEXEMPT) ;
 ; XMDDATE  Deletion date for inactive messages (FM format)
 ; XMDDATEX Deletion date for inactive messages (external format)
 ; XMIDATE  Date beyond which message has had no activity (and thus
 ;          becomes candidate for deletion).
 ; XMKALL   1=all baskets; 0=IN basket only
 ; XMEXEMPT Users exempt from purge (":duz1:duz2:...:duzn:")
 N XMDDATE,XMDDATEX,XMIDATE,XMUSER,XMK,XMI,XMLEN,XMLEFT,XMHDR
 S XMLEFT=79
 S XMLEN("XMZ")=$L($O(^XMB(3.9,":"),-1))+2
 S XMLEN("DATE")=$L($$MMDT^XMXUTIL1(DT))
 S XMLEFT=XMLEFT-XMLEN("XMZ")-(2*XMLEN("DATE"))-6
 S XMLEN("SUBJ")=XMLEFT*2\3
 S XMLEN("FROM")=XMLEFT-XMLEN("SUBJ")
 S XMHDR(1)=$$LJ^XLFSTR($$EZBLD^DIALOG(34633),XMLEN("XMZ")+1)_$$LJ^XLFSTR($$EZBLD^DIALOG(34632),XMLEN("DATE")+1)_$$LJ^XLFSTR($$EZBLD^DIALOG(34002),XMLEN("SUBJ")+2) ;Msg ID / Date / Subject
 S XMHDR(1)=XMHDR(1)_$$LJ^XLFSTR($$EZBLD^DIALOG(34006),XMLEN("FROM")+2)_$$EZBLD^DIALOG(36614) ;From  / Last Read
 S XMHDR(2)=$$REPEAT^XLFSTR("-",XMLEN("XMZ"))_" "_$$REPEAT^XLFSTR("-",XMLEN("DATE"))_" "_$$REPEAT^XLFSTR("-",XMLEN("SUBJ"))_"  "_$$REPEAT^XLFSTR("-",XMLEN("FROM"))_"  "_$$REPEAT^XLFSTR("-",XMLEN("DATE"))
 S XMDDATE=$$FMADD^XLFDT(DT,30)
 S XMDDATEX=$$MMDT^XMXUTIL1(XMDDATE)
 S XMIDATE=$$FMADD^XLFDT(DT,-XMIDAYS)
 S XMUSER=.999
 K ^TMP("XM",$J)
 F  S XMUSER=$O(^XMB(3.7,XMUSER)) Q:XMUSER'>0  D
 . Q:$G(XMEXEMPT)[(":"_XMUSER_":")
 . S XMI=0
 . I XMKALL D
 . . S XMK=.99
 . . F  S XMK=$O(^XMB(3.7,XMUSER,2,XMK)) Q:XMK'>0  D BASKET(XMTEST,XMK,$P($G(^(XMK,0),"NO NAME"),U),XMIDATE,XMDDATE,.XMLEN,.XMHDR,.XMI)
 . E  D BASKET(XMTEST,1,$$EZBLD^DIALOG(37005),XMIDATE,XMDDATE,.XMLEN,.XMHDR,.XMI) ;IN
 . Q:'$D(^TMP("XM",$J))
 . D SENDMSG(XMTEST,XMKALL,XMIDAYS,XMDDATEX,XMUSER)
 . K ^TMP("XM",$J)
 Q
BASKET(XMTEST,XMK,XMKN,XMIDATE,XMDDATE,XMLEN,XMHDR,XMI) ; Process Basket
 N XMZ,XMZDATE,XMREC,XMZREC,XMFDA,XMIENS,XMFIRST,XMIREC
 S XMZ=0,XMFIRST=1
 F  S XMZ=$O(^XMB(3.7,XMUSER,2,XMK,1,XMZ)) Q:XMZ'>0  S XMREC=$G(^(XMZ,0)) D
 . ; Quit if no data OR new msg OR already scheduled for deletion
 . ; OR activity after the cutoff date
 . Q:XMREC=""!$P(XMREC,U,3)!$P(XMREC,U,5)!($P(XMREC,U,4)>XMIDATE)
 . S XMZREC=$G(^XMB(3.9,XMZ,0))
 . S XMZDATE=$P(XMZREC,U,3)
 . S:XMZDATE'?7N1".".N XMZDATE=$$CONVERT^XMXUTIL1(XMZDATE)
 . I $P(XMREC,U,4)="" Q:XMZDATE>XMIDATE
 . I 'XMTEST D  ; Mark message w/delete date ("AC" x-ref created by trigger)
 . . S XMIENS=XMZ_","_XMK_","_XMUSER_","
 . . S XMFDA(3.702,XMIENS,5)=XMDDATE
 . . S XMFDA(3.702,XMIENS,7)=1
 . . D FILE^DIE("","XMFDA")
 . I XMFIRST D
 . . S XMFIRST=0
 . . S XMI=XMI+1,^TMP("XM",$J,XMI)=""
 . . S XMI=XMI+1,^TMP("XM",$J,XMI)=$$EZBLD^DIALOG(34656,XMKN) ;Basket: |1|
 . . S XMI=XMI+1,^TMP("XM",$J,XMI)=""
 . . S XMI=XMI+1,^TMP("XM",$J,XMI)=XMHDR(1)
 . . S XMI=XMI+1,^TMP("XM",$J,XMI)=XMHDR(2)
 . S XMIREC=$J("["_XMZ_"]",XMLEN("XMZ"))_" "_$E($$MMDT^XMXUTIL1(XMZDATE),1,XMLEN("DATE"))_" "_$$LJ^XLFSTR($E($$SUBJ^XMXUTIL2(XMZREC),1,XMLEN("SUBJ")),XMLEN("SUBJ"))
 . S XMIREC=XMIREC_"  "_$$LJ^XLFSTR($E($$NAME^XMXUTIL($P(XMZREC,U,2)),1,XMLEN("FROM")),XMLEN("FROM"))_"  "_$$MMDT^XMXUTIL1($P($P(XMREC,U,4),".",1))
 . S XMI=XMI+1,^TMP("XM",$J,XMI)=XMIREC
 Q
SENDMSG(XMTEST,XMKALL,XMIDAYS,XMDDATEX,XMTO) ; Send a message to the user
 N XMINSTR,XMPARM,XMBULL
 S XMINSTR("FLAGS")="I" ; Info only
 S XMINSTR("FROM")=.5
 S XMPARM(1)=XMIDAYS,XMPARM(2)=XMDDATEX
 S XMBULL=$S(XMTEST:"XM IN BASKET PURGE REQUEST",1:"XM IN BASKET PURGE WARNING")
 D TASKBULL^XMXBULL(.5,XMBULL,.XMPARM,"^TMP(""XM"",$J)",XMTO,.XMINSTR)
 Q
