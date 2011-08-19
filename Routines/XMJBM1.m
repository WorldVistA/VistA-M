XMJBM1 ;ISC-SF/GMB-Manage Mail in Mailbox (cont.) ;07/19/2000  14:13
 ;;8.0;MailMan;;Jun 28, 2002
INIT(XMDUZ,XMRDR,XMABORT) ;
 D CHECK^XMVVITAE
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC D  Q
 . S XMABORT=1
 . D SHOW^XMJERR
 D RDR(.XMRDR,.XMABORT)
 Q
RDR(XMRDR,XMABORT) ;
 S XMRDR=XMV("RDR DEF")
 Q:XMV("RDR ASK")="N"
 N XMRDRTXT,XMOPT,XMOX,XMDIR
 D SET^XMXSEC1("C",34036,.XMOPT,.XMOX) ; C:Classic
 D SET^XMXSEC1("D",34037,.XMOPT,.XMOX) ; D:Detailed Full Screen
 D SET^XMXSEC1("S",34038,.XMOPT,.XMOX) ; S:Summary Full Screen
 I XMRDR="" S XMRDR="C"
 S XMRDRTXT=XMOPT(XMRDR)
 S XMDIR("A")=$$EZBLD^DIALOG(34047) ; Select message reader:
 S XMDIR("B")=XMOX("O",XMRDR)_":"_XMRDRTXT
 S XMDIR("??")="D QRDR^XMJBM1"
 D XMDIR^XMJDIR(.XMDIR,.XMOPT,.XMOX,.XMRDR,.XMABORT)
 Q
QRDR ;
 N XMTEXT
 ;The Classic reader is the one that has been around forever.
 ;The Full Screen reader has two flavors:
 ;Detailed Full Screen contains a detailed message list.
 ;Summary Full Screen contains a summary message list.
 D BLD^DIALOG(34039,"","","XMTEXT","F")
 I $P($G(^XMB(3.7,DUZ,0)),U,16)="" D
 . ;You may choose a default MESSAGE READER under
 . ;'Personal Preferences|User Options Edit'.
 . ;Until you do, the Classic reader will be your default.
 . D BLD^DIALOG(34040,"","","XMTEXT","F")
 E  D
 . ;Your default MESSAGE READER is the _XMRDRTXT_ reader.
 . ;You may change your default MESSAGE READER under
 . ;'Personal Preferences|User Options Edit'.
 . D BLD^DIALOG(34041,XMRDRTXT,"","XMTEXT","F")
 ;If you don't want to be asked this question again, and wish to use the 
 ;XMRDRTXT_ reader exclusively, set the MESSAGE READER PROMPT to
 ;"No, don't ask" under 'Personal Preferences|User Options Edit'.
 D BLD^DIALOG(34042,XMRDRTXT,"","XMTEXT","F")
 D MSG^DIALOG("WH","","","","XMTEXT")
 Q
ASKBSKT(XMDUZ,XMRDR,XMK,XMKN,XMABORT) ;
 N XMKNUM
 F  D ASKBSKT^XMJBN(XMDUZ,0,.XMK,.XMKN,.XMABORT) Q:XMABORT  D  Q:XMKNUM
 . S XMKNUM=+$P($G(^XMB(3.7,XMDUZ,2,XMK,1,0)),U,4)
 . D:'XMKNUM NOMSGS(XMDUZ,XMK,XMKN)
 Q:XMABORT
 Q:'XMKNUM
 Q:XMRDR'="C"
 N XMPARM,XMTEXT
 S XMPARM(1)=$O(^XMB(3.7,XMDUZ,2,XMK,1,"C",""),-1)
 S XMPARM(2)=XMKNUM
 S XMPARM(3)=$P(^XMB(3.7,XMDUZ,2,XMK,0),U,2)
 ;Last message number: |1|   Messages in basket: |2| (|3| new)
 ;Enter ??? for help.
 D BLD^DIALOG($S(XMPARM(3):34043.1,1:34043),.XMPARM,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 Q
NOMSGS(XMDUZ,XMK,XMKN) ;
 W !,$$EZBLD^DIALOG(34044,XMKN) ; No messages in '|1|' basket.
 Q:XMK<2
 I XMDUZ'=DUZ,$G(XMV("PRIV"))'["R",$G(XMV("PRIV"))'["W" Q
 W !
 N DIR,DIRUT,X,Y
 S DIR(0)="Y"
 ;Since the '_XMKN_' basket is empty,
 ;do you want to delete it
 D BLD^DIALOG(34045,XMKN,"","DIR(""A"")")
 S DIR("B")=$$EZBLD^DIALOG(39054) ; Yes
 D ^DIR Q:'Y
 D DELBSKT^XMXBSKT(XMDUZ,XMK)
 W !,$$EZBLD^DIALOG(34046) ; Basket deleted.
 Q
