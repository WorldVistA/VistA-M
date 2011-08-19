XMUTERM1 ;ISC-SF/GMB-Delete Mailbox (cont.) ;12/04/2002  13:51
 ;;8.0;MailMan;**10**;Jun 28, 2002
 ; Taken from XUSTERM (SEA/AMF/WDE)
ALL1TASK ; Deletions
 N XMI,XMABORT,XMTERM,XMNAME,XMWHY,XMCUTEXT,XMLEN,XMCNT,XMADDED,XMAC,XMVC,XMPM,XMLASTON,XMTDATE,XMDELM,XMTOTAL,XMNEW,XMFWD,XMYES
 S XMYES=$$EZBLD^DIALOG(39054.1) ; Y
 S XMCUTEXT=$$FMTE^XLFDT(XMCUTOFF,"2DF")
 S XMLEN=$L($P(^VA(200,0),U,3))
 S (XMCNT,XMABORT,XMTOTAL)=0
 W:$E(IOST,1,2)="C-" @IOF D HEADER1
 S XMI=.999
 F  S XMI=$O(^XMB(3.7,XMI)) Q:XMI'>0  D  Q:XMABORT
 . S XMTOTAL=XMTOTAL+1 I '$D(ZTQUEUED),'(XMTOTAL#1000) U IO(0) W:$X>50 ! W "." U IO
 . D CHECK1(XMI,XMGRACE,XMCUTOFF,.XMTERM,.XMNAME,.XMWHY) Q:'XMTERM
 . D GETDATA(XMI,.XMADDED,.XMAC,.XMVC,.XMPM,.XMLASTON,.XMTDATE,.XMDELM,.XMNEW,.XMFWD)
 . I $Y+3+(XMAC=XMYES&(XMFWD'=""))>IOSL D  Q:XMABORT
 . . I $E(IOST,1,2)="C-" D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 . . W @IOF D HEADER1
 . W !,$J(XMI,XMLEN)," ",$E(XMNAME,1,32-XMLEN),?34,XMADDED,?44,XMAC,?47,XMVC,?50,XMPM,?53,XMLASTON,?63,XMTDATE,?76,XMDELM
 . I XMAC=XMYES,XMFWD'="" W !,$$EZBLD^DIALOG(36347),$$EZBLD^DIALOG(38004),XMFWD Q  ; *** not deleted - Forwarding Address:
 . S XMCNT=XMCNT+1
 . D:'XMTEST TERMINAT(XMI)  ; Delete if real mode
 W:XMCNT=0 !!,$$EZBLD^DIALOG(36351) ; No user mailboxes deleted.
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
HEADER1 ;
 N XMPARM
 S XMPARM(1)=$S(XMTEST:$$EZBLD^DIALOG(36352),1:"") ; Test:
 S XMPARM(2)=XMCUTEXT
 D BLD^DIALOG(36353,.XMPARM,"","","F")
 D MSG^DIALOG("WM","",IOM)
 ;|1|Delete user mailbox
 ;(Logon cutoff date: |2|, AC=Access Code, VC=Verify Code, PM=Primary Menu)
 ;                                           Last
 ;                       ^VA(200             Mail/  Terminate  Delete
 ;Delete Mailbox         Created  AC VC PM  Sign on    Date     Mail
 ;-----------------------------------------------------------------------
 ;                      xx/xx/xx  y  y  y  xx/xx/xx  xx/xx/xx     y
 Q
CHECK1(XMI,XMGRACE,XMCUTOFF,XMTERM,XMNAME,XMWHY) ;
 N XMREC,XMADDED
 S XMTERM=0
 Q:XMI<1
 S XMREC=$G(^VA(200,XMI,0))
 I XMREC="" D  Q
 . S XMTERM=1
 . S XMNAME=$$EZBLD^DIALOG(34009) ; * No Name *
 . S XMWHY=$$EZBLD^DIALOG(36346) ; Not in NEW PERSON file
 ; User is in NEW PERSON file
 S XMADDED=$P($G(^VA(200,XMI,1)),U,7)
 Q:XMADDED>XMGRACE
 I $P(XMREC,U,3)="" D  Q  ; if no access code...
 . N XMTDATE
 . S XMTDATE=$P(XMREC,U,11)
 . I XMTDATE="" D  Q
 . . S XMTERM=1
 . . S XMNAME=$$NAME^XMXUTIL(XMI)
 . . S XMWHY=$$EZBLD^DIALOG(36357) ; No AC, no termination date
 . I XMTDATE'<DT Q  ; To be Terminated in the future
 . I $P(XMREC,U,5)="n" Q  ; Terminated w/mail retention
 . S XMTERM=1
 . S XMNAME=$$NAME^XMXUTIL(XMI)
 . S XMWHY=$$EZBLD^DIALOG(36358) ; No AC, terminated w/o mail retention
 ; User has access code
 I $P($G(^VA(200,XMI,201)),U,1)="" D  Q  ; if no primary menu...
 . S XMTERM=1
 . S XMNAME=$$NAME^XMXUTIL(XMI)
 . S XMWHY=$$EZBLD^DIALOG(36359) ; AC, but no PM
 ; User has primary menu
 I $P($G(^VA(200,XMI,.1)),U,2)="" D  Q  ; if no verify code...
 . N XMLASTON  ; latest of 'last sign on' or 'last mailman use'
 . S XMLASTON=$$MAX^XLFMTH(+$P($G(^VA(200,XMI,1.1)),U),+$P($G(^XMB(3.7,XMI,"L")),U,2))
 . I XMLASTON=0 D  Q
 . . I XMADDED<XMCUTOFF D  Q
 . . . S XMTERM=1
 . . . S XMNAME=$$NAME^XMXUTIL(XMI)
 . . . S XMWHY=$$EZBLD^DIALOG(36360,$$FMTE^XLFDT(XMADDED,"2DF")) ; AC & PM, no VC, no logon, added |1|
 . I XMLASTON<XMCUTOFF D  Q
 . . S XMTERM=1
 . . S XMNAME=$$NAME^XMXUTIL(XMI)
 . . S XMWHY=$$EZBLD^DIALOG(36361,$$FMTE^XLFDT(XMLASTON,"2DF")) ; AC & PM, no VC, last logon |1|
 ; User has verify code
 Q
GETDATA(XMI,XMADDED,XMAC,XMVC,XMPM,XMLASTON,XMTDATE,XMDELM,XMNEW,XMFWD,XMDIS) ;
 N XMREC
 S XMREC=$G(^VA(200,XMI,0))
 S XMADDED=$P($G(^VA(200,XMI,1)),U,7) ; date added to NEW PERSON file
 S XMADDED=$S(XMADDED="":"",1:$$FMTE^XLFDT(XMADDED,"2DF"))
 S XMAC=$S($P(XMREC,U,3)="":"",1:XMYES) ; access code
 S XMVC=$S($P($G(^VA(200,XMI,.1)),U,2)="":"",1:XMYES) ; verify code
 S XMPM=$S($P($G(^VA(200,XMI,201)),U,1)="":"",1:XMYES) ; primary menu
 S XMLASTON=$$MAX^XLFMTH(+$P($G(^VA(200,XMI,1.1)),U),+$P($G(^XMB(3.7,XMI,"L")),U,2)) ; last sign on / mailman use
 S XMLASTON=$S(XMLASTON=0:"",1:$$FMTE^XLFDT(XMLASTON,"2DF"))
 S XMTDATE=$P(XMREC,U,11) ; termination date
 S XMTDATE=$S(XMTDATE="":"",1:$$FMTE^XLFDT(XMTDATE,"2DF"))
 S XMDELM=$$UP^XLFSTR($P(XMREC,U,5)) ; delete mail on termination
 S XMDIS=$S($P(XMREC,U,7):XMYES,1:"") ; DISUSER'd
 S XMREC=$G(^XMB(3.7,XMI,0))
 S XMFWD=$P(XMREC,U,2) ; Forwarding address
 S XMNEW=$P(XMREC,U,6) ; New messages
 Q
ALL2TASK ; Suggestions
 N XMI,XMABORT,XMTERM,XMNAME,XMWHY,XMCUTEXT,XMSVC,XMLEN,XMCNT,XMADDED,XMAC,XMVC,XMPM,XMLASTON,XMTDATE,XMDELM,XMREC,XMTOTAL,XMNEW,XMFWD,XMFIRST,XMYES,XMDIS,XMSURR,XMSNAM
 S XMYES=$$EZBLD^DIALOG(39054.1) ; Y
 K ^TMP("XM",$J)
 S XMCUTEXT=$$FMTE^XLFDT(XMCUTOFF,"2DF")
 S XMLEN=$L($P(^VA(200,0),U,3))
 S (XMCNT,XMABORT,XMTOTAL)=0,XMFIRST=1
 S XMI=.999
 F  S XMI=$O(^XMB(3.7,XMI)) Q:XMI'>0  D  Q:XMABORT
 . S XMTOTAL=XMTOTAL+1 I '$D(ZTQUEUED),'(XMTOTAL#1000) U IO(0) W:$X>50 ! W "." U IO
 . D CHECK2(XMI,XMCUTOFF,.XMTERM,.XMNAME,.XMWHY) Q:'XMTERM
 . S XMCNT=XMCNT+1
 . D GETDATA(XMI,.XMADDED,.XMAC,.XMVC,.XMPM,.XMLASTON,.XMTDATE,.XMDELM,.XMNEW,.XMFWD,.XMDIS)
 . S XMSVC=$S($P($G(^VA(200,XMI,5)),U,1)="":$$EZBLD^DIALOG(36334),1:$P($G(^DIC(49,$P(^(5),U,1),0),$$EZBLD^DIALOG(36334)),U,1)) ; NONE
 . S ^TMP("XM",$J,XMSVC,$S(XMNAME="":$$EZBLD^DIALOG(34009),1:$E(XMNAME,1,25-XMLEN)),XMI)=XMAC_U_XMVC_U_XMPM_U_XMLASTON_U_XMTDATE_U_XMDELM_U_XMDIS_U_XMNEW_U_XMFWD ; * No Name *
 S (XMSVC,XMNAME,XMI)=""
 F  S XMSVC=$O(^TMP("XM",$J,XMSVC)) Q:XMSVC=""  D  Q:XMABORT
 . I XMFIRST D
 . . S XMFIRST=0
 . . W:$E(IOST,1,2)="C-" @IOF D HEADER2
 . E  D PAGE2(.XMABORT) Q:XMABORT
 . F  S XMNAME=$O(^TMP("XM",$J,XMSVC,XMNAME)) Q:XMNAME=""  D  Q:XMABORT
 . . F  S XMI=$O(^TMP("XM",$J,XMSVC,XMNAME,XMI)) Q:XMI=""  D  Q:XMABORT
 . . . S XMREC=^TMP("XM",$J,XMSVC,XMNAME,XMI)
 . . . I $Y+3+($P(XMREC,U,1)=XMYES&($P(XMREC,U,9)'=""))>IOSL D PAGE2(.XMABORT) Q:XMABORT
 . . . W !,$J(XMI,XMLEN)," ",XMNAME,?27,$P(XMREC,U,1),?30,$P(XMREC,U,2),?33,$P(XMREC,U,3),?35,$P(XMREC,U,4),?44,$P(XMREC,U,5),?54,$P(XMREC,U,6),?58,$P(XMREC,U,7),?60,$J($P(XMREC,U,8),6)
 . . . S XMSURR=0,XMSNAM=""
 . . . F  S XMSURR=$O(^XMB(3.7,XMI,9,XMSURR)) Q:'XMSURR  D  Q:XMSNAM'=""
 . . . . S XMSNAM=$S($D(^VA(200,+$G(^XMB(3.7,XMI,9,XMSURR,0)),0)):$$NAME^XMXUTIL(+^XMB(3.7,XMI,9,XMSURR,0)),1:"")
 . . . I XMSNAM'="" W " ",$E(XMSNAM,1,12)
 . . . I $P(XMREC,U,1)=XMYES,$P(XMREC,U,9)'="" W !,?XMLEN+1,$$EZBLD^DIALOG(38004),$P(XMREC,U,9) ; Forwarding address:
 W:XMCNT=0 !!,$$EZBLD^DIALOG(36362) ; No user mailboxes to report.
 K ^TMP("XM",$J)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
PAGE2(XMABORT) ;
 I $E(IOST,1,2)="C-" D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 W @IOF D HEADER2
 Q
HEADER2 ;
 N XMPARM
 S XMPARM(1)=XMSVC
 S XMPARM(2)=XMCUTEXT
 D BLD^DIALOG(36364,.XMPARM,"","","F")
 D MSG^DIALOG("WM","",IOM)
 ;Check user mailbox for Service/Section: |1|
 ;
 ;(Logon cutoff date: |2|, AC=Access Code, VC=Verify Code, PM=Primary Menu)
 ;
 ;                            Last
 ;                            Mail/    Term   Del  DIS  New
 ;Check Mailbox    AC VC PM  Sign on   Date  Mail USER Msgs Surrogate
 ;----------------------------------------------------------------------
 ;                  y  y  y xx/xx/xx xx/xx/xx  y   y xxxxxx xxxxxxxxxxxx
 Q
CHECK2(XMI,XMCUTOFF,XMTERM,XMNAME,XMWHY) ;
 N XMREC
 S XMTERM=0
 Q:XMI<1
 S XMREC=$G(^VA(200,XMI,0))
 Q:XMREC=""  ; not in NEW PERSON file
 I $P(XMREC,U,7) D  Q
 . ; DISUSER'd
 . S XMTERM=1
 . S XMNAME=$$NAME^XMXUTIL(XMI)
 . S XMWHY=$$EZBLD^DIALOG(36366) ; DISUSER'd
 I $P(XMREC,U,3)="" D  Q
 . ; no access code
 . N XMTDATE
 . S XMTDATE=$P(XMREC,U,11)
 . Q:XMTDATE=""  ; not terminated
 . Q:XMTDATE'<XMCUTOFF  ; terminated after cutoff date
 . Q:$P(XMREC,U,5)'="n"  ; Terminated w/o mail retention
 . S XMTERM=1
 . S XMNAME=$$NAME^XMXUTIL(XMI)
 . S XMWHY=$$EZBLD^DIALOG(36367) ; No AC, terminated w/mail retention
 ; User has access code
 Q:$P($G(^VA(200,XMI,201)),U,1)=""  ; no primary menu
 Q:$P($G(^VA(200,XMI,.1)),U,2)=""   ; no verify code
 ; User has verify code and primary menu
 N XMLASTON  ; latest of last sign on / mailman use
 S XMLASTON=$$MAX^XLFMTH(+$P($G(^VA(200,XMI,1.1)),U),+$P($G(^XMB(3.7,XMI,"L")),U,2))
 I XMLASTON<XMCUTOFF D  Q
 . S XMNAME=$$NAME^XMXUTIL(XMI)
 . I XMLASTON="" D  Q
 . . N XMADDED
 . . S XMADDED=$P($G(^VA(200,XMI,1)),U,7)
 . . Q:XMADDED'<XMCUTOFF
 . . S XMTERM=1
 . . S XMWHY=$$EZBLD^DIALOG(36368,$$FMTE^XLFDT(XMADDED,"2DF")) ; AC, VC, & PM, no logon, added |1|
 . S XMTERM=1
 . S XMWHY=$$EZBLD^DIALOG(36369,$$FMTE^XLFDT(XMLASTON,"2DF")) ; AC, VC, & PM, last logon |1|
 Q
 ; The following entry is called from a Kernel routine.
TERMINAT(XMDUZ) ; Remove user from MailMan
 D GROUP^XMUTERM2(XMDUZ)
 D SURROGAT^XMUTERM2(XMDUZ)
 D MAILBOX^XMUTERM2(XMDUZ)
 D LATERNEW^XMUTERM2(XMDUZ)
 D LATERSND^XMUTERM2(XMDUZ)
 Q
