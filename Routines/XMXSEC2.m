XMXSEC2 ;ISC-SF/GMB-Message security and restrictions (cont.) ;04/18/2002  08:01
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2733.
EDIT(XMDUZ,XMZ,XMZREC) ; May the user edit the message? (1=may, 0=may not)
 I '$$ORIGIN8R^XMXSEC(XMDUZ,.XMZREC) D ERRSET^XMXUTIL(37405.1) Q 0  ; Only the originator may Edit a message.
 I $P($G(^XMB(3.9,XMZ,1,0)),U,4)>1!($P(XMZREC,U,2)'=$O(^XMB(3.9,XMZ,1,"C",0))) D ERRSET^XMXUTIL(37405.2) Q 0  ; You may not Edit a message you have already sent to someone else.
 I $O(^XMB(3.9,XMZ,3,0)) D ERRSET^XMXUTIL(37405.3) Q 0  ; You may not Edit a message which has a reply.
 I $D(^XMB(3.9,XMZ,"K")),XMINSTR("TYPE")["X"!(XMINSTR("TYPE")["K") D ERRSET^XMXUTIL(37405.4) ; You may not Edit a secure KIDS or PackMan message.
 Q 1
OPTEDIT(XMINSTR,XMOPT,XMOX,XMQDNUM) ; We know the user may edit the message.
 ; Now, what, exactly, may be edited?
 D SET("C",$S($G(XMINSTR("FLAGS"))["C":37302,1:37301),.XMOPT,.XMOX) ; UnConfidential (surrogate may read) / Confidential (surrogate can't read)
 D SET("D",$S($D(XMINSTR("RCPT BSKT")):37304,1:37303),.XMOPT,.XMOX) ; Delivery basket remove / Delivery basket set
 D SET("I",$S($G(XMINSTR("FLAGS"))["I":37308,1:37307),.XMOPT,.XMOX) ; UnInformation only / Information only
 D SET("NS",37309,.XMOPT,.XMOX) ; Add Network Signature
 D SET("P",$S($G(XMINSTR("FLAGS"))["P":37312,1:37311),.XMOPT,.XMOX) ; Normal delivery / Priority delivery
 D SET("R",$S($G(XMINSTR("FLAGS"))["R":37314,1:37313),.XMOPT,.XMOX) ; No Confirm receipt / Confirm receipt
 D SET("ES",37305,.XMOPT,.XMOX) ; Edit Subject
 D SET("ET",37306,.XMOPT,.XMOX) ; Edit Text
 D SET("V",$S($G(XMINSTR("VAPOR")):37318,1:37317),.XMOPT,.XMOX) ; Vaporize date remove / Vaporize date set
 D SET("X",$S($G(XMINSTR("FLAGS"))["X":37320,1:37319),.XMOPT,.XMOX) ; UnClose (forward allowed) / Closed (no forward allowed)
 D SET("S",$S($D(^XMB(3.9,XMZ,"K")):37316,$D(XMINSTR("SCR KEY")):37316,1:37315),.XMOPT,.XMOX) ; UnScramble / Scramble message text
 I $G(XMPAKMAN)!($G(XMINSTR("TYPE"))["X")!($G(XMINSTR("TYPE"))["K") D
 . D Q("NX",37309.4) ; You may not add a Network Signature to a KIDS or PackMan message.
 . D Q("S",37315.4) ; Sorry, but we can't (un)secure a KIDS or PackMan message here.
 I '$D(XMOPT("NS","?")),'$$GOTNS^XMVVITA(XMDUZ) D
 . ; pgmr note: this must be the last place that sets XMOPT("NS","?").
 . I XMDUZ=DUZ D Q("NS",37309.1) Q  ; You have no Network Signature.
 . S XMOPT("NS","?")=$$EZBLD^DIALOG(37309.3,XMV("NAME")) ; |1| has no Network Signature.
 I $D(^TMP("XMY",$J,.6)) D
 . D Q("C",37301.6) ; Messages addressed to SHARED,MAIL may not be 'Confidential'.
 . D Q("X",37320.6) ; Messages addressed to SHARED,MAIL may not be 'Closed'.
 Q
SET(XMCD,XMDN,XMOPT,XMOX) ;
 N XMDREC
 S XMDREC=$$EZBLD^DIALOG(XMDN)
 S XMOPT(XMCD)=$P(XMDREC,":",2,99)
 S XMOX("O",XMCD)=$P(XMDREC,":",1) ; "O"=original english to foreign
 S XMOX("X",$P(XMDREC,":",1))=XMCD ; "X"=translate foreign to english
 Q
Q(XMCD,XMDN) ;
 I $G(XMQDNUM) S XMOPT(XMCD,"?")=XMDN Q
 S XMOPT(XMCD,"?")=$$EZBLD^DIALOG(XMDN)
 Q
OPTMSG(XMDUZ,XMK,XMZ,XMIM,XMINSTR,XMIU,XMOPT,XMOX,XMQDNUM) ; The user has access to the message.  Now what may the user do with it?
 ; in:
 ; XMDUZ  = the user
 ; XMK    = basket IEN if message is in a basket
 ;        = ! if super search (option XM SUPER SEARCH)
 ;        = 0 otherwise
 ; XMZ    = the message IEN
 ; The following are set by INMSG1 and INMSG2^XMXUTIL2
 ; XMIM("FROM")  = piece 2 of the message's zero node
 ; XMINSTR       = special instructions
 ; XMIU("ORIGN8")=
 ; XMIU("IEN")   = the user's IEN in the message's recipient multiple
 ; XMQDNUM = 0 - set XMOPT(<opt>,"?")=dialog text (default)
 ;           1 - set XMOPT(<opt>,"?")=dialog number (all are TYPE: ERROR)
 ;           FYI, XMOPT(<opt>,"?") is displayed in SHOWERR^XMJDIR.
 ; out:
 ; XMOPT(<opt>) Possible options
 ; '$D(XMOPT(<opt>,"?")) User may do these things.
 ;  $D(XMOPT(<opt>,"?")) User may NOT do these things.
 N XMSECPAK
 I $D(^XMB(3.9,XMZ,"K")),XMINSTR("TYPE")["X"!(XMINSTR("TYPE")["K") S XMSECPAK=1 ; secure packman
 E  S XMSECPAK=0
 K XMOPT,XMOX
 D SET("B",37441,.XMOPT,.XMOX) ; Backup
 D SET("I",37442,.XMOPT,.XMOX) ; Ignore
 D SET("P",37416,.XMOPT,.XMOX) ; Print
 D SET("Q",37417,.XMOPT,.XMOX) ; Query
 D SET("QC",37431,.XMOPT,.XMOX) ; Query Current
 D SET("QD",37418,.XMOPT,.XMOX) ; Query Detailed
 D SET("QN",37419,.XMOPT,.XMOX) ; Query Network
 D SET("QNC",37432,.XMOPT,.XMOX) ; Query Not Current
 D SET("QR",37420,.XMOPT,.XMOX) ; Query Recipients
 D SET("QT",37433,.XMOPT,.XMOX) ; Query Terminated
 Q:XMK="!"
 D SET("A",37401,.XMOPT,.XMOX) ; Answer
 D SET("AA",37402,.XMOPT,.XMOX) ; Access Attachments
 D SET("C",37403,.XMOPT,.XMOX) ; Copy
 D SET("D",37404,.XMOPT,.XMOX) ; Delete
 D SET("E",37405,.XMOPT,.XMOX) ; Edit
 D SET("F",37406,.XMOPT,.XMOX) ; Forward
 D SET("IN",$S($G(XMINSTR("FLAGS"))["I":37409,1:37408),.XMOPT,.XMOX) ; UnInformation only / Information only
 D SET("H",37407,.XMOPT,.XMOX) ; Headerless Print
 D SET("K",$S($G(XMINSTR("FLAGS"))["K":37412,1:37411),.XMOPT,.XMOX) ; UnPriority replies / Priority replies
 D SET("L",37413,.XMOPT,.XMOX) ; Later
 D SET("N",$S($G(XMINSTR("FLAGS"))["N":37415,1:37414),.XMOPT,.XMOX) ; UnNew / New
 D SET("R",37422,.XMOPT,.XMOX) ; Reply
 D SET("S",37423,.XMOPT,.XMOX) ; Save
 D SET("T",37424,.XMOPT,.XMOX) ; Terminate
 D SET("V",37425,.XMOPT,.XMOX) ; Vaporize date edit
 D SET("W",37444,.XMOPT,.XMOX) ; Write
 D SET("X",$S($G(XMINSTR("TYPE"))["K":37427,$G(XMINSTR("TYPE"))["X":37428,1:37426),.XMOPT,.XMOX) ; Xtract KIDS / Xtract PackMan / Xtract
 I XMDUZ=DUZ!($G(XMV("PRIV"))["W") D
 . D OPTW(XMDUZ,XMZ,XMIM("FROM"),XMIU("ORIGN8"),XMSECPAK,.XMINSTR)
 E  D
 . D OPTWNO^XMXSEC3(XMIU("ORIGN8"))
 D OPTR(XMDUZ,XMK,XMZ,.XMIU,XMSECPAK,.XMINSTR)
 I DUZ=.6 D Q("R",37422.6) ; SHARED,MAIL may not Reply to a message.
 I XMDUZ=.6 D DOSHARE^XMXSEC3(XMDUZ,XMK,XMIU("ORIGN8"),.XMINSTR) Q
 I XMDUZ=.5,XMK>999 D DOPOST^XMXSEC3
 Q
OPTW(XMDUZ,XMZ,XMFROM,XMORIGN8,XMSECPAK,XMINSTR) ; User must be self or have 'write' privilege as surrogate.
 I XMINSTR("TYPE")["X"!(XMINSTR("TYPE")["K") D Q("A",37401.4) ; You may not Answer a KIDS or PackMan message.
 I XMINSTR("FLAGS")["X",'XMORIGN8 D Q("C",37403.1) ; Only the originator may Copy a 'closed' message.
 I $D(^XMB(3.9,XMZ,"K")) D
 . I XMSECPAK D Q("C",37403.4) ; You may not Copy a secure KIDS or PackMan message.
 . E  D
 . . I '$D(XMOPT("A","?")) D Q("A",37401.2) ; You may not Answer a scrambled message.  Use Reply.
 . . I '$D(XMOPT("C","?")) D Q("C",37403.2) ; You may not Copy a scrambled message.
 I '$D(XMOPT("A","?")),'$$GOTNS^XMVVITA(XMDUZ) D
 . ; pgmr note: this must be the last place that sets XMOPT("A","?").
 . I XMDUZ=DUZ D Q("A",37401.1) Q  ; You must have a Network Signature to Answer a message.
 . S XMOPT("A","?")=$$EZBLD^DIALOG(37401.3,XMV("NAME")) ; |1| must have a Network Signature to Answer a message.
 I 'XMORIGN8 D  Q
 . D Q("IN",37409.1) ; Only the originator may toggle 'Information only'.
 . D Q("E",37405.1) ; Only the originator may Edit a message.
 I $P($G(^XMB(3.9,XMZ,1,0)),U,4)>1!(XMFROM'=$O(^XMB(3.9,XMZ,1,"C",0))) D  Q
 . ; You may not Edit a message you have already sent to someone else.
 . ; You may toggle the 'information only' switch, if you wish.
 . I $G(XMQDNUM) S XMOPT("E","?")=37405.2 Q
 . N DIR
 . D BLD^DIALOG(37405.2,"","","DIR(""?"")")
 . M XMOPT("E","?")=DIR("?")
 I $O(^XMB(3.9,XMZ,3,0)) D Q("E",37405.3) Q  ; You may not Edit a message which has a reply.
 I XMSECPAK D Q("E",37405.4) ; You may not Edit a secure KIDS or PackMan message.
 Q
OPTR(XMDUZ,XMK,XMZ,XMIU,XMSECPAK,XMINSTR) ; User must be self or have 'read' privilege as surrogate.
 I '$O(^XMB(3.9,XMZ,2005,0)) D Q("AA",37402.1) ; This message has no Attachments.
 I 'XMK D
 . D Q("D",37404.1) ; This message has already been deleted.  It's not in a basket.
 . D Q("V",37425.1) ; This message has already vaporized.  It's not in a basket.
 I XMINSTR("FLAGS")'["P" D Q("K",37412.1) ; The message must be 'priority' in order to toggle 'Priority replies'.
 I XMINSTR("FLAGS")["X",'XMIU("ORIGN8") D Q("F",37406.1) ; Only the originator may forward a 'closed' message.
 I XMSECPAK D
 . D Q("P",37416.4) ; You may not Print a secure KIDS or PackMan message.
 . S XMOPT("H","?")=XMOPT("P","?")
 . D Q("R",37422.4) ; You may not Reply to a secure KIDS or PackMan message.
 E  I 'XMIU("ORIGN8") D
 . I XMINSTR("FLAGS")["I" D Q("R",37422.1) Q  ; Only the originator may Reply to an 'Information only' message.
 . I $P($G(^XMB(3.9,XMZ,1,XMIU("IEN"),"T")),U,1)="I" D Q("R",37422.2) ; 'Information only' recipients may not reply to a message.
 E  I $$BCAST^XMXSEC(XMZ) D Q("R",37422.3) ; May not reply to a Broadcast message.  Send a new one.
 I XMINSTR("TYPE")["X"!(XMINSTR("TYPE")["K") D
 . I '$D(^XUSEC("XUPROGMODE",DUZ)) D Q("X",37428.2) ; You must hold the XUPROGMODE key to extract KIDS or PackMan messages.
 E  D Q("X",37428.1) ; This message is neither KIDS nor PackMan.
 Q
