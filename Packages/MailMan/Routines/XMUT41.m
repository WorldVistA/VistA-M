XMUT41 ;(ISC-SF/GMB- XMUT4 (Cont.) ;04/17/2002  11:52
 ;;8.0;MailMan;;Jun 28, 2002
WARNING(XMABORT) ;
 N DIR,X,Y,XMTEXT
 W !
 D BLD^DIALOG(36084,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 W !
 ;The MailMan file checker may take some time to process.
 ;If you have not tried it before, PLEASE try it when the
 ;system will be quiescent for a LONG period of time.
 ;Errors listed are generally not fatal.  Most errors are
 ;corrected.  Please enter a NOIS if there are many errors.
 ;Keep the error printout for future reference.  If you see
 ;errors in MailMan, the printout may help to resolve them.
 S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(36085) ; Do you wish to proceed
 S DIR("B")=$$EZBLD^DIALOG(39053) ; "NO"
 D ^DIR
 I $D(DIRUT)!'Y S XMABORT=1
 Q
MXREF(XMABORT) ;
 ; XMECNT   # msgs in mailbox
 N XMZ,XMUSER,XMECNT,XMK
 W:'$D(ZTQUEUED) !!,$$EZBLD^DIALOG(36086),! ; Checking M xref
 S (XMZ,XMECNT)=0
 F  S XMZ=$O(^XMB(3.7,"M",XMZ)) Q:'XMZ  D  Q:XMABORT
 . S XMECNT=XMECNT+1 I XMECNT#5000=0 D  Q:XMABORT
 . . I '$D(ZTQUEUED) W:$X>40 ! W XMECNT,"." Q
 . . I $$S^%ZTLOAD S (XMABORT,ZTSTOP)=1 ; User asked the task to stop
 . S XMUSER=""
 . F  S XMUSER=$O(^XMB(3.7,"M",XMZ,XMUSER)) Q:'XMUSER  D
 . . S XMK=""
 . . F  S XMK=$O(^XMB(3.7,"M",XMZ,XMUSER,XMK)) Q:'XMK  D
 . . . Q:$D(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0))
 . . . K ^XMB(3.7,"M",XMZ,XMUSER,XMK)
 . . . D ERR^XMUT4(121,XMUSER,XMK,XMZ) ; M xref, but msg not in bskt: xref killed
 Q:XMABORT!$D(ZTQUEUED)
 W !
 D BLD^DIALOG(36092,XMECNT,"","XMTEXT","F")
 D MSG^DIALOG("WM","",IOM,"","XMTEXT")
 ;|1| unique messages referenced in MAILBOX file 3.7
 Q
POSTBSKT ; Check the Postmaster's bskts to see if any remote bskts
 ; are numbered below 1000.  If so, move them.
 N XMK,XMKN,XMKINST,XMZ,XMINST,XMPUT
 S XMK=1
 F  S XMK=$O(^XMB(3.7,.5,2,XMK)) Q:XMK>999!'XMK  S XMKN=$P(^(XMK,0),U,1)  D
 . S XMINST=$$FIND1^DIC(4.2,"","XQ",XMKN)
 . Q:'XMINST
 . D ERR^XMUT4(160,.5,XMK) ; Xmit basket<1000 has domain name: investigate msgs.
 . ; This bskt has a remote site name.  Does it have msgs to xmit?
 . S XMKINST=XMINST+1000
 . I '$D(^XMB(3.7,.5,2,XMKINST)) D MAKEBSKT^XMXBSKT(.5,XMKINST,XMKN)
 . S (XMZ,XMPUT)=0
 . F  S XMZ=$O(^XMB(3.7,.5,2,XMK,1,XMZ)) Q:'XMZ  D
 . . I '$D(^XMB(3.9,XMZ,1,"AQUEUE",XMINST)) D  Q
 . . . ; This msg does not need to be transmitted.  Does it belong here?
 . . . Q:$D(^XMB(3.9,XMZ,1,"C",.5))!$$BCAST^XMXSEC(XMZ)
 . . . D ERR^XMUT4(161,.5,XMK,XMZ) ; Msg in xmit basket<1000 not addressed to Postmaster: deleted.
 . . . D ZAPIT^XMXMSGS2(.5,XMK,XMZ)
 . . ; This msg needs to be transmitted.  Is it in the real xmit bskt?
 . . Q:$D(^XMB(3.7,.5,2,XMKINST,1,XMZ))  ; already there
 . . S XMPUT=XMPUT+1
 . . I $D(^XMB(3.9,XMZ,1,"C",.5))!$$BCAST^XMXSEC(XMZ) D  Q
 . . . D ERR^XMUT4(162,.5,XMK,XMZ) ; Msg in xmit basket<1000: copied to proper bskt.
 . . . D PUTMSG^XMXMSGS2(.5,XMKINST,XMKN,XMZ)
 . . D ERR^XMUT4(163,.5,XMK,XMZ) ; Msg in xmit basket<1000: moved to proper bskt.
 . . D COPYIT^XMXMSGS2(.5,XMK,XMZ,XMKINST)
 . . D ZAPIT^XMXMSGS2(.5,XMK,XMZ)
 . Q:$$BMSGCT^XMXUTIL(.5,XMK)
 . N XMFDA
 . S XMFDA(3.701,XMK_",.5,",.01)="@"
 . D FILE^DIE("","XMFDA")
 . D ERR^XMUT4(164,.5,XMK) ; Xmit basket<1000 with no msgs: deleted.
 Q
SUMMARY(XMABORT) ;
 I $G(ZTSTOP) W !!,$$EZBLD^DIALOG(36422) ; *** Stopping prematurely per user request ***
 W !!,$$EZBLD^DIALOG(36087)   ; Summary of Integrity Check:
 D SUM(36089,36000.1,99,199)  ; Results for MAILBOX file 3.7:
 D SUM(36091,36300.1,199,299) ; Results for MESSAGE file 3.9:
 K XMERROR
 Q
SUM(XMTITLE,XMBASE,XMSTART,XMLIMIT) ;
 N XMERRNUM,XMPARM,XMTEXT
 W !!,$$EZBLD^DIALOG(XMTITLE) ; Results for xxx file xxx:
 S XMERRNUM=XMSTART
 F  S XMERRNUM=$O(XMERROR(XMERRNUM)) Q:'XMERRNUM!(XMERRNUM>XMLIMIT)  D
 . S XMPARM(1)=$J(XMERRNUM,3),XMPARM(2)=XMERROR(XMERRNUM)
 . W !!,$$EZBLD^DIALOG(36090,.XMPARM) ; Type |1| errors=|2|
 . D BLD^DIALOG(XMBASE+XMERRNUM,"","","XMTEXT","F")
 . D MSG^DIALOG("WE","",IOM,"","XMTEXT")
 I '$D(XMPARM) W !,$$EZBLD^DIALOG(36088) ; No errors to report.
 Q
