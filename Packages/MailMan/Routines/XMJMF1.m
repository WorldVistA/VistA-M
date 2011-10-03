XMJMF1 ;ISC-SF/GMB-XMJMF (cont.) ;07/12/2002  11:08
 ;;8.0;MailMan;;Jun 28, 2002
FIND(XMDUZ,XMK,XMKCHOOS,XMKN) ; Search mailbox or message file
 ; XMK       !=Search the message file
 ;           *=Search the user's mailbox
 ;           n=Search user's basket number n
 ; XMKCHOOS  1=user may choose which basket
 ;           0=user is locked into current basket
 ;           U=user is doing a Postmaster Super Search
 N XMDIR,XMOPT,XMOX,XMY,XMF,XMABORT,XMFFRN,XMFBSKTN,XMFTDTX,XMFFDTX,XMFRFRN,XMSRCHED,XMHDR
 S (XMABORT,XMSRCHED)=0
 I XMK="!" D  Q:XMABORT
 . I $G(XMKCHOOS)="U" D  Q:XMABORT
 . . I '$$SSPRIV^XMXSEC1 D  Q
 . . . D SHOW^XMJERR
 . . . D WAIT^XMXUTIL
 . . . S XMABORT=1
 . . S XMF("FLAGS")="U"
 . . S XMHDR=$$EZBLD^DIALOG(34435.5) ; Current 'All Messages Super Search' search criteria:
 . E  S XMHDR=$$EZBLD^DIALOG(34435) ; Current 'All Messages' search criteria:
 . S XMF("FDATE")=$$FMADD^XLFDT(DT,-30) ; Search period is last 30 days.
 . S XMF("TDATE")=DT
 . S XMFFDTX=$$MMDT^XMXUTIL1(XMF("FDATE"))
 . S XMFTDTX=$$MMDT^XMXUTIL1(XMF("TDATE"))
 E  D
 . S XMHDR=$$EZBLD^DIALOG(34436) ; Current 'Mailbox' search criteria:
 . S XMF("BSKT")=XMK
 . I XMK S XMFBSKTN=$G(XMKN,$$BSKTNAME^XMXUTIL(XMDUZ,XMK))
 F  D  Q:XMABORT
 . W @IOF,XMHDR
 . S XMDIR("A")=$$EZBLD^DIALOG(34420) ; Select search action
 . I XMK'="!" D
 . . I +XMF("BSKT")=XMF("BSKT") D
 . . . W !,$$EZBLD^DIALOG(34437),":",?30,XMFBSKTN ; Search basket
 . . . Q:'XMKCHOOS
 . . . D SET^XMXSEC1("B",34421.1,.XMOPT,.XMOX) ; Change Search basket
 . . . D SET^XMXSEC1("BA",34421.2,.XMOPT,.XMOX) ; Search all baskets
 . . E  D
 . . . W !,$$EZBLD^DIALOG(34437),":",?30,$$EZBLD^DIALOG(34437.1) ; Search basket / All baskets
 . . . D SET^XMXSEC1("B",34421,.XMOPT,.XMOX) ; Search one basket
 . I $D(XMF("SUBJ")) D
 . . W !,$$EZBLD^DIALOG(34438),":",?30,XMF("SUBJ") ; Subject contains
 . . D SET^XMXSEC1("S",34422.1,.XMOPT,.XMOX) ; Change 'Subject contains' string
 . E  D SET^XMXSEC1("S",34422,.XMOPT,.XMOX) ; Enter 'Subject contains' string
 . I $D(XMF("FROM")) D
 . . W !,$$EZBLD^DIALOG(34440),":",?30,XMFFRN ; Message from
 . . D SET^XMXSEC1("F",34423.1,.XMOPT,.XMOX) ; Change 'Message from' person
 . E  D SET^XMXSEC1("F",34423,.XMOPT,.XMOX) ; Enter 'Message from' person
 . I $D(XMF("TO")) D
 . . W !,$$EZBLD^DIALOG(34440.2),":",?30,XMF("TO") ; Message to
 . . D SET^XMXSEC1("T",34424.1,.XMOPT,.XMOX) ; Change 'Message to' addressee
 . E  D SET^XMXSEC1("T",34424,.XMOPT,.XMOX) ; Enter 'Message to' addressee
 . I $D(XMF("FDATE")) D
 . . W !,$$EZBLD^DIALOG(34444),":",?30,XMFFDTX ; Message sent on or after
 . . D SET^XMXSEC1("DA",34426.1,.XMOPT,.XMOX) ; Change 'Message sent on or after' date
 . E  D SET^XMXSEC1("DA",34426,.XMOPT,.XMOX) ; Enter 'Message sent on or after' date
 . I $D(XMF("TDATE")) D
 . . W !,$$EZBLD^DIALOG(34445),":",?30,XMFTDTX ; Message sent on or before
 . . D SET^XMXSEC1("DB",34427.1,.XMOPT,.XMOX) ; Change 'Message sent on or before' date
 . E  D SET^XMXSEC1("DB",34427,.XMOPT,.XMOX) ; Enter 'Message sent on or before' date
 . I $D(XMF("FLINE")) D
 . . W !,$$EZBLD^DIALOG(34449),":",?30,XMF("FLINE") ; Lines of text, minimum
 . . D SET^XMXSEC1("LM",34430.1,.XMOPT,.XMOX) ; Change 'Minimum Lines of text' number
 . E  D SET^XMXSEC1("LM",34430,.XMOPT,.XMOX) ; Enter 'Minimum Lines of text' number
 . ;I $D(XMF("TLINE")) D
 . ;. W !,$$EZBLD^DIALOG(34450),":",?30,XMF("TLINE") ; Lines of text, maximum
 . ;. D SET^XMXSEC1("LX",34431.1,.XMOPT,.XMOX) ; Change 'Maximum Lines of text' number
 . ;E  D SET^XMXSEC1("LX",34431,.XMOPT,.XMOX) ; Enter 'Maximum Lines of text' number
 . I $D(XMF("RFROM")) D
 . . W !,$$EZBLD^DIALOG(34440.1),":",?30,XMFRFRN ; Response from
 . . D SET^XMXSEC1("R",34428.1,.XMOPT,.XMOX) ; Change 'Response from' person
 . E  D SET^XMXSEC1("R",34428,.XMOPT,.XMOX) ; Enter 'Response from' person
 . I $D(XMF("TEXT")) D
 . . ; x.1:Message / x.2:Message or Response / x.3:Response contains
 . . W !,$$EZBLD^DIALOG(34446+(XMF("TEXT","L")/10)),":",?30,XMF("TEXT")
 . . D SET^XMXSEC1("X",34429.1,.XMOPT,.XMOX) ; Change 'Message contains' string
 . E  D SET^XMXSEC1("X",34429,.XMOPT,.XMOX) ; Enter 'Message contains' string
 . D SET^XMXSEC1("Q",34420.1,.XMOPT,.XMOX) ; Quit
 . I $D(XMF("SUBJ"))!$D(XMF("FROM"))!$D(XMF("FDATE"))!$D(XMF("TDATE"))!$D(XMF("TO"))!$D(XMF("RFROM"))!$D(XMF("TEXT"))!$D(XMF("FLINE"))!$D(XMF("TLINE")) D
 . . D SET^XMXSEC1("G",34420.2,.XMOPT,.XMOX) ; Go search
 . . S XMDIR("B")=$S(XMSRCHED:34420.1,1:34420.2) ; Q:Quit / G:Go search
 . E  D
 . . S XMDIR("B")=34422 ; S:Enter 'Subject contains' string
 . S XMDIR("??")="XM-U-Q-SEARCH CRITERIA"
 . S XMDIR(0)="SC" ; show choices/split into columns, if necessary
 . D XMDIR^XMJDIR(.XMDIR,.XMOPT,.XMOX,.XMY,.XMABORT) Q:XMABORT
 . S XMSRCHED=(XMY="G")
 . K XMOPT,XMOX,XMDIR
 . D @XMY^XMJMF2
 Q
