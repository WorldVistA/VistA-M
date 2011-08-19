XMA30 ;ISC-SF/GMB-XMCLEAN, XMAUTOPURGE (cont.) ;01/08/2003  10:04
 ;;8.0;MailMan;**10,13**;Jun 28, 2002
 ; Was (WASH ISC)/CAP
AUDIT ; Lists data from previous purges
 N XMLIEN,XMREC,XMSTART,XMEND,XMLEFT,XMPURGE,XMTYPE,XMABORT
 S XMABORT=0
 W @IOF
 D BLD^DIALOG(36432,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;It's a good idea to look these over.
 ;Look for multiple purges running concurrently and missing purge dates.
 ;Check the times the purge ended - do they conflict with user activity?
 W !
 D AHDR
 S XMLIEN=0
 F  S XMLIEN=$O(^XMB(1,1,.1,XMLIEN)) Q:XMLIEN'>0  D  Q:XMABORT
 . I $Y+3>IOSL D  Q:XMABORT
 . . I $E(IOST,1,2)="C-" D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 . . W @IOF D AHDR
 . S XMREC=^XMB(1,1,.1,XMLIEN,0)
 . S XMSTART=$E($P(XMREC,U),1,12)
 . S XMLEFT=$P(XMREC,U,2)
 . S XMPURGE=$P(XMREC,U,3)
 . S XMTYPE=$P(XMREC,U,6)
 . S XMEND=$E($P(XMREC,U,8),1,12)
 . I XMTYPE="",'XMEND D  ; To handle old data before XM*7.1*37
 . . S XMEND=XMSTART
 . . K XMSTART
 . W !,$$EZBLD^DIALOG($S(+XMTYPE=0:36433,XMTYPE=1:36434,1:36435)) ; "Unref Msg" / "Date" / "Test Date"
 . W ?12,$S($D(XMSTART):$J($$FMTE^XLFDT(XMSTART,5),16),1:""),$J($$FMTE^XLFDT(XMEND,5),18)
 . I $D(XMSTART),XMEND>XMSTART W $J($$FMDIFF^XLFDT(XMEND,XMSTART,3),10)
 . W ?58,$J(XMPURGE,9),$J(XMLEFT,12)
 Q
AHDR ;
 N XMTEXT
 D BLD^DIALOG(36436,"","","XMTEXT","F")
 D MSG^DIALOG("WM","",IOM,"","XMTEXT")
 W !
 ;MailMan Purge History
 ;Type             Start             End         Duration      Purged         Kept
 Q
USERSTAT ; Display statistics
 N DIR,Y,XMTYPE,ZTSAVE,XMVAR,XMTEXT,XMDIALOG,XMI
 W !
 S XMVAR(2)=$O(^XMB(3.9,":"),-1) ; highest
 S XMVAR(1)=$J($O(^XMB(3.9,0)),$L(XMVAR(2))) ; lowest
 S XMVAR(3)=$J($P($G(^XMB(3.9,0)),U,4),$L(XMVAR(2))) ; how many
 D BLD^DIALOG(36437,.XMVAR,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;Lowest numbered message:  |1|
 ;Highest numbered message: |2|
 ;Number of messages:       |3|
 D BLD^DIALOG(36438,"","","DIR(""A"")") ; Scan Option
 ;A:Active Mailboxes;I:Inactive Mailboxes;M:All Mailboxes"
 S DIR(0)="S^"
 F XMI=36439.1,36439.2,36439.3 D
 . S XMDIALOG(XMI)=$$EZBLD^DIALOG(XMI)
 . S DIR(0)=DIR(0)_XMDIALOG(XMI)_";"
 S DIR(0)=$E(DIR(0),1,$L(DIR(0))-1)
 S DIR("B")=$P(XMDIALOG(36439.1),":",2) ; Active Mailboxes
 D ^DIR Q:$D(DIRUT)
 S XMI=0 F  S XMI=$O(XMDIALOG(XMI)) Q:$P(XMDIALOG(XMI),":",1)=Y
 S XMTYPE=$S(XMI=36439.1:"A",XMI=36439.2:"I",1:"M")
 S XMTYPE("DESC")=$P(XMDIALOG(XMI),":",2)
 S ZTSAVE("XMTYPE")="",ZTSAVE("XMTYPE(")=""
 D EN^XUTMDEVQ("DOSTATS^XMA30",$$EZBLD^DIALOG(36440),.ZTSAVE) ; MailMan: User Mailbox Statistics
 Q
DOSTATS ;
 N XMTODAY,XMPAGE,XMABORT,XMDUZ,XMK,XMINCNT,XMZCNT,XMKCNT,XMBOXCNT,XMLMAIL,XMNAME,XMREC,XMSTAT,XMLSIGN,XMINACT
 S XMTODAY=$$FMTE^XLFDT(DT,5),(XMPAGE,XMABORT,XMBOXCNT)=0
 S:$D(ZTQUEUED) ZTREQ="@"
 W:$E(IOST,1,2)="C-" @IOF D SHDR(XMTODAY,.XMPAGE)
 S XMNAME="",XMINACT=$$EZBLD^DIALOG(36441) ; "Inactive"
 F  S XMNAME=$O(^VA(200,"B",XMNAME)) Q:XMNAME=""  D  Q:XMABORT
 . S XMDUZ=0
 . F  S XMDUZ=$O(^VA(200,"B",XMNAME,XMDUZ)) Q:XMDUZ=""  D  Q:XMABORT
 . . Q:'$D(^XMB(3.7,XMDUZ))
 . . S XMREC=$G(^VA(200,XMDUZ,0))
 . . I $P(XMREC,U,3)="" Q:XMTYPE="A"  S XMSTAT=XMINACT
 . . E  I XMTYPE="I" Q
 . . E  S XMSTAT=""
 . . I $Y+3>IOSL D  Q:XMABORT
 . . . I $E(IOST,1,2)="C-" D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 . . . W @IOF D SHDR(XMTODAY,.XMPAGE)
 . . S XMBOXCNT=XMBOXCNT+1
 . . W !,$E($$NAME^XMXUTIL(XMDUZ),1,30)
 . . S XMK=.9,(XMINCNT,XMZCNT)=0
 . . F XMKCNT=1:1 S XMK=$O(^XMB(3.7,XMDUZ,2,XMK)) Q:XMK'>0  D
 . . . D:'$D(^XMB(3.7,XMDUZ,2,XMK,1,0)) MAKENODE
 . . . I XMK=1 S XMINCNT=+$P($G(^XMB(3.7,XMDUZ,2,XMK,1,0)),U,4),XMZCNT=XMINCNT Q
 . . . S XMZCNT=XMZCNT+$P($G(^XMB(3.7,XMDUZ,2,XMK,1,0)),U,4)
 . . S XMLSIGN=$P($G(^VA(200,XMDUZ,1.1)),U)
 . . S XMLSIGN=$S(XMSTAT'="":XMSTAT,'XMLSIGN:$$EZBLD^DIALOG(38002),1:$J($$MMDT^XMXUTIL1($P(XMLSIGN,".")),8)) ; Never
 . . S XMLMAIL=$P($G(^XMB(3.7,XMDUZ,"L")),U)
 . . S XMLMAIL=$S(XMLMAIL["@":$P(XMLMAIL,"@"),1:$P(XMLMAIL," ",1,3))
 . . W ?30,$J(XMKCNT,4),$J(XMZCNT,7),$J(XMINCNT,8),?53,XMLSIGN,?67,$S($L(XMLMAIL):XMLMAIL,1:$$EZBLD^DIALOG(38002)) ; Never
 Q:XMABORT
 W !!,XMTYPE("DESC"),": ",XMBOXCNT
 I $E(IOST,1,2)="C-" D WAIT^XMXUTIL
 Q
MAKENODE ; Create the zero node for the message multiple
 N XMCNT,XMZ
 Q:'$O(^XMB(3.7,XMDUZ,2,XMK,1,0))
 S (XMZ,XMCNT)=0
 F  S XMZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,XMZ)) Q:XMZ'>0  S XMCNT=XMCNT+1
 S ^XMB(3.7,XMDUZ,2,XMK,1,0)="^3.702P^"_+$O(^XMB(3.7,XMDUZ,2,XMK,1,"C"),-1)_U_XMCNT
 Q
SHDR(XMTODAY,XMPAGE) ; Header for Mailbox Statistics Report
 S XMPAGE=XMPAGE+1
 W XMTYPE("DESC"),", ",XMTODAY,?65,$J($$EZBLD^DIALOG(34542,XMPAGE),15) ; Page |1|
 D BLD^DIALOG(36443,"","","XMTEXT","F")
 D MSG^DIALOG("WM","",IOM,"","XMTEXT")
 W !
 ;User     Bskts  Msgs  IN Bskt  Last Sign on  Last Mail Use"
 Q
DONTPURG ; Find all messages which might not be in someone's mailbox,
 ; but which shouldn't be purged anyway.
 N XMDUZ,XMZ,XMZR,XMQ,XMT,XMD,XMINST,XMG
 K ^TMP("XM",$J)
 ;
 ; DON'T PURGE LOCAL MESSAGES AND REPLIES WHICH ARE ABOUT TO BE DELIVERED
 ;
 S (XMT,XMG,XMZ)="" ; new messages, forwarded messages, and replies
 F  S XMT=$O(^XMBPOST("BOX",XMT)) Q:XMT=""  D
 . F  S XMG=$O(^XMBPOST("BOX",XMT,XMG)) Q:XMG=""  D
 . . F  S XMZ=$O(^XMBPOST("BOX",XMT,XMG,XMZ)) Q:XMZ=""  S ^TMP("XM",$J,"NOP",+XMZ)="" I XMG="R" S ^TMP("XM",$J,"NOP",$P(XMZ,U,2))=""
 ;
 ; new messages, forwarded messages
 S (XMQ,XMT,XMZ)="" ; Queue number, Timestamp, Message IEN
 F  S XMQ=$O(^XMBPOST("M",XMQ)) Q:XMQ=""  D
 . F  S XMT=$O(^XMBPOST("M",XMQ,XMT)) Q:XMT=""  D
 . . F  S XMZ=$O(^XMBPOST("M",XMQ,XMT,XMZ)) Q:XMZ=""  S ^TMP("XM",$J,"NOP",+XMZ)=""
 ;
 ; replies
 S (XMQ,XMZ,XMZR)="" ; Queue number, Message IEN, Reply IEN
 F  S XMQ=$O(^XMBPOST("R",XMQ)) Q:XMQ=""  D
 . S XMT="" ; Timestamp
 . F  S XMT=$O(^XMBPOST("R",XMQ,XMT)) Q:XMT'>0  D
 . . F  S XMZ=$O(^XMBPOST("R",XMQ,XMT,XMZ)) Q:XMZ=""  D
 . . . S ^TMP("XM",$J,"NOP",XMZ)="" ; Original msg to new replies
 . . . F  S XMZR=$O(^XMBPOST("R",XMQ,XMT,XMZ,XMZR)) Q:XMZR=""  S ^TMP("XM",$J,"NOP",XMZR)="" ; Reply
 ;
 ; DON'T PURGE MESSAGES QUEUED TO BE DELIVERED REMOTELY
 S XMINST=999 ; Institution
 F  S XMINST=$O(^XMB(3.7,.5,2,XMINST)) Q:XMINST'>0  D
 . S XMZ=0
 . F  S XMZ=$O(^XMB(3.7,.5,2,XMINST,1,XMZ)) Q:XMZ'>0  S ^TMP("XM",$J,"NOP",XMZ)=""
 ;
 ; DON'T PURGE LATER'D MESSAGES
 S XMD=0 ; Date to be later'd
 F  S XMD=$O(^XMB(3.73,XMD)) Q:XMD'>0  D
 . S XMZ=$P(^XMB(3.73,XMD,0),U,3)
 . S:XMZ ^TMP("XM",$J,"NOP",XMZ)="" ; Msg to be later'd
 ;
 ; DON'T PURGE MESSAGES WHICH ARE BEING EDITED
 S (XMDUZ,XMZ)=""
 F  S XMDUZ=$O(^XMB(3.7,"AD",XMDUZ)) Q:XMDUZ=""  D
 . F  S XMZ=$O(^XMB(3.7,"AD",XMDUZ,XMZ)) Q:XMZ=""  S ^TMP("XM",$J,"NOP",XMZ)=""
 ;
 ; DON'T PURGE MESSAGES WHICH ARE TO BE DELIVERED LATER TO CERTAIN RECIPIENTS
 S (XMD,XMZ)=""
 F  S XMD=$O(^XMB(3.9,"AL",XMD)) Q:XMD=""  D
 . F  S XMZ=$O(^XMB(3.9,"AL",XMD,XMZ)) Q:XMZ=""  S ^TMP("XM",$J,"NOP",XMZ)=""
 Q
