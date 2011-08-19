XMJMR1 ;ISC-SF/GMB-Interactive Reply (cont.) ;08/24/2001  08:29
 ;;8.0;MailMan;;Jun 28, 2002
INIT(XMDUZ,XMK,XMKN,XMZO,XMZOSUBJ,XMZOFROM,XMINSTR,XMINCL,XMZI,XMWHICH,XMABORT) ;
 N DIR,Y,DIRUT,XMRESPS
 I XMDUZ=.6,DUZ=.6 D  Q
 . ; This is already handled in OPTMSG^XMXSEC2, but, just in case...
 . S XMABORT=1
 . W !,$$EZBLD^DIALOG(37422.6) ; SHARED,MAIL may not Reply to a message.
 . G H^XUS
 D CHKLOCK^XMJMS(XMDUZ,.XMABORT) Q:XMABORT
 I XMINSTR("FLAGS")["P" D  Q:XMABORT
 . N XMTEXT
 . W !,$C(7)
 . D BLD^DIALOG(34200,"","","XMTEXT","F") ; Responses to priority messages are not ... (need priority? send a new msg)
 . D MSG^DIALOG("WH","","","","XMTEXT")
 . W !
 . D PAGE^XMXUTIL(.XMABORT)
 I XMZOFROM["POSTMASTER",XMZOFROM["@" D  Q:XMABORT
 . N XMTEXT
 . W !,$C(7)
 . D BLD^DIALOG(34201,"","","XMTEXT","F") ; Because this message is from a remote ... (reply stays local)
 . D MSG^DIALOG("WH","","","","XMTEXT")
 . W !
 . D PAGE^XMXUTIL(.XMABORT)
 D CHKBSKT^XMJMOI(XMDUZ,XMZO,.XMK,.XMKN)
 I +XMK<1 D
 . W !
 . D SAVEMSG^XMJMOI(XMDUZ,.XMK,.XMKN,XMZO,XMZOSUBJ,XMZOFROM,$G(XMINSTR("RCPT BSKT")))
 S XMRESPS=+$P($G(^XMB(3.9,XMZO,3,0)),U,4)
 D WHICH(XMDUZ,XMZO,XMINCL,.XMZI,.XMWHICH,.XMABORT)
 Q
WHICH(XMDUZ,XMZO,XMINCL,XMZI,XMWHICH,XMABORT) ;
 ; XMINCL =0 Do not include previous responses.  Just reply.
 ;        =1 Include previous response(s) from this message
 ;           or include response(s) from another message in reply.
 ;        =2 Include response(s) from another message in a new message.
 Q:XMINCL=0
 D WHICHMSG(XMDUZ,XMZO,XMINCL,.XMZI,.XMABORT) Q:XMABORT
 D WHICH^XMJMC(XMZI,$$EZBLD^DIALOG(34209),.XMWHICH,.XMABORT) ; include
 Q
WHICHMSG(XMDUZ,XMZO,XMINCL,XMZI,XMABORT) ; Include responses from which (different) message
 N DIR,X,Y,XMIN,XMAX,XMPARM
 S (XMPARM(1),XMIN)=$O(^XMB(3.9,0)),(XMPARM(2),XMAX)=$O(^XMB(3.9,":"),-1)
 W !
 S DIR("A")=$$EZBLD^DIALOG(34270) ; Include responses from which message
 I XMINCL=1 D
 . S DIR("B")=$$EZBLD^DIALOG(34271) ; This message
 . S DIR(0)="FO^"_$$MIN^XLFMTH($L(XMIN),$L(DIR("B")))_":"_$$MAX^XLFMTH($L(XMAX),$L(DIR("B")))_"^D CHKMSG^XMJMR1(.Y)"
 . D BLD^DIALOG(34272,.XMPARM,"","DIR(""?"")")
 . ;Press Enter to include previous responses from this message
 . ;or enter the internal entry number of a different message
 . ;(_XMIN_-_XMAX_) to include any of its responses.
 E  D
 . S DIR(0)="NO^"_XMIN_":"_XMAX_":0^D CHKMSG^XMJMR1(.Y)"
 . D BLD^DIALOG(34273,.XMPARM,"","DIR(""?"")")
 . ;Enter the internal entry number of a different message
 . ;(_XMIN_-_XMAX_) to include any of its responses.
 D ^DIR
 I 'Y S XMABORT=1 Q
 S XMZI=+Y
 Q:XMINCL=1
 ; Do you want to review this message first?
 Q
CHKMSG(XMZI) ;
 I XMINCL=1,XMZI=DIR("B") S XMZI=XMZO Q  ; Include previous responses from this message.
 I XMINCL=1,$S(XMZI'?.N:1,XMZI<XMIN:1,XMZI>XMAX:1,1:0) K X W $C(7)," ?" Q
 I XMINCL=2,XMZI=XMZO D  Q
 . K X
 . W !,$$EZBLD^DIALOG(34274) ; You can't include the message you're editing.
 N XMZIREC ; Include responses from another message.
 S XMZIREC=$G(^XMB(3.9,XMZI,0))
 I XMZIREC="" K X Q
 I '$$INCLUDE^XMXSEC(XMDUZ,XMZI) D  Q
 . K X
 . D SHOW^XMJERR
 W "  ",$P(XMZIREC,U,1)
 Q
COPYTEXT(XMZI,XMZ,XMWHICH,XMHDR) ;
 N I,XMRESP,XMRANGE,XMC
 I $G(XMHDR) S XMHDR("XMZ")=XMZI,XMHDR("REC")=^XMB(3.9,XMZI,0)
 W !,$$EZBLD^DIALOG(34202) ; Copying...
 S XMC=+$O(^XMB(3.9,XMZ,2,""),-1)
 F I=1:1:$L(XMWHICH,",") D
 . S XMRANGE=$P(XMWHICH,",",I)
 . Q:XMRANGE=""  ; (XMWHICH can end with a ",", giving us a null piece.)
 . F XMRESP=$P(XMRANGE,"-",1):1:$S(XMRANGE["-":$P(XMRANGE,"-",2),1:XMRANGE) D
 . . I XMRESP=0 D COPYRESP(XMRESP,XMZI,XMZ,.XMC,.XMHDR) Q
 . . D COPYRESP(XMRESP,+$G(^XMB(3.9,XMZI,3,XMRESP,0)),XMZ,.XMC,.XMHDR)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_XMC_U_XMC_U_DT
 Q
COPYRESP(XMRESP,XMZI,XMZ,XMC,XMHDR) ;
 N XMF,XMFROM,XMDT,XMZREC,XMPARM
 S XMC=XMC+1
 S ^XMB(3.9,XMZ,2,XMC,0)=""
 S XMZREC=$G(^XMB(3.9,XMZI,0))
 S XMFROM=$$NAME^XMXUTIL($P(XMZREC,U,2))
 S XMDT=$P(XMZREC,U,3)
 I $G(XMHDR) D
 . S XMC=XMC+1
 . S ^XMB(3.9,XMZ,2,XMC,0)="In the message:"
 . S XMC=XMC+1
 . S ^XMB(3.9,XMZ,2,XMC,0)=">"_$$EZBLD^DIALOG(34536,$$SUBJ^XMXUTIL2(XMHDR("REC")))_"  "_$$EZBLD^DIALOG(34537,XMHDR("XMZ")) ; Subj: / [#]
 . S XMC=XMC+1
 . S ^XMB(3.9,XMZ,2,XMC,0)=">"_$$EZBLD^DIALOG(34538,$$FROM^XMXUTIL2(XMHDR("REC")))_$S($P(XMHDR("REC"),U,4)="":"",1:" "_$$EZBLD^DIALOG(34533,$$NAME^XMXUTIL($P(XMHDR("REC"),U,4)))) ; From: |1| (Sender: |1|)
 . S XMC=XMC+1
 . S ^XMB(3.9,XMZ,2,XMC,0)=">"_$$EZBLD^DIALOG(34585,$$MMDT^XMXUTIL1($P(XMHDR("REC"),U,3))) ; Sent: |1|
 S XMC=XMC+1
 S XMPARM(1)=$$MMDT^XMXUTIL1(XMDT)
 S XMPARM(2)=$S(XMRESP:$$EZBLD^DIALOG(34204,XMRESP),1:$$EZBLD^DIALOG(34205)) ; Response #|1| / Original message
 S XMPARM(3)=XMFROM
 S ^XMB(3.9,XMZ,2,XMC,0)=$$EZBLD^DIALOG(34203,.XMPARM) ; On |1| (|2|) |3| wrote:
 S XMF=.999999
 F  S XMF=$O(^XMB(3.9,XMZI,2,XMF)) Q:XMF=""  D
 . S XMC=XMC+1
 . W:XMC#50=0 "."
 . S ^XMB(3.9,XMZ,2,XMC,0)=$E(">"_^XMB(3.9,XMZI,2,XMF,0),1,254)
 Q
