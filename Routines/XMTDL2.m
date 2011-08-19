XMTDL2 ;ISC-SF/GMB-Deliver local mail to mailbox (cont.) ;04/17/2002  11:31
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMADJF1B (ISC-WASH/CAP)
 ; XMTO     Recipient DUZ
 ; XMZ      Original XMZ
 ; XMZSUBJ  Msg subject
 ; XMZFROM  Who sent the original message
 ; XMFROM   Who sent the msg or reply, or who forwarded the msg
 ; XMREPLY  0=msg is not a reply; 1=msg is a reply
 ; XMK      Basket number (or name) to deliver to (as specified by sender XMFROM)
 ; XMDEL    Delete Date (as specified by sender XMZFROM)
 ; XMKCURR  Basket the msg is currently in
DELIVER(XMTO,XMZ,XMZSUBJ,XMZFROM,XMFROM,XMREPLY,XMK,XMDEL,XMZBSKT) ;
 N XMKCURR,XMACT
 I +XMTO'>0!'$D(^XMB(3.7,XMTO,2)) Q  ; Do not deliver if invalid mailbox
 S XMFROM=+$G(XMFROM),XMREPLY=+$G(XMREPLY),XMK=$G(XMK),XMDEL=+$G(XMDEL),XMZBSKT=$G(XMZBSKT)
 I XMTO=.6,XMREPLY Q  ; Do not deliver response to Shared,Mail
 S XMKCURR=$O(^XMB(3.7,"M",XMZ,XMTO,0)) ; Get basket it is in
 I XMKCURR D  Q  ; Already in a basket (ignore any basket sender may have specified)
 . Q:'XMREPLY  ; If this is a reply, continue, else it must be a forwarded msg, so quit.
 . I XMKCURR=.5 D  Q  ; Msg is in waste basket
 . . D CHEKBSKT(XMTO,.XMK,XMZSUBJ,XMZFROM,XMZBSKT,.XMACT) ; Where should it go?
 . . Q:XMK=.5
 . . D MOVENEW(XMFROM,XMTO,XMK,XMZ,.XMACT) ; Move msg and make it new.
 . ; Msg is not in waste basket.  Make the msg new.
 . Q:$D(^XMB(3.7,XMTO,"N0",XMKCURR,XMZ))  ; Already new.
 . D:XMFROM'=XMTO MAKENEW(XMTO,XMKCURR,XMZ)
 ; Not yet in a basket.
 ; Reinstated user may not see replies to old msgs which he doesn't already have.
 I XMREPLY,$P(^XMB(3.7,XMTO,0),U,7) Q:$$SECRET($P(^(0),U,7),XMZ)
 S:$G(XMK)="" XMK=0
 I +XMK=XMK D
 . D CHEKBSKT(XMTO,.XMK,XMZSUBJ,XMZFROM,XMZBSKT,.XMACT)
 E  D
 . S XMK=$$NAMEBSKT(XMTO,XMK,"Y")
 D ADDNEW($S(XMREPLY:XMFROM,1:XMZFROM),XMTO,XMK,XMZ,XMDEL,.XMACT,XMREPLY)
 Q
CHEKBSKT(XMTO,XMK,XMZSUBJ,XMZFROM,XMZBSKT,XMACT) ; Basket number (or no basket at all)
 N XMREC
 S XMREC=$G(^XMB(3.7,XMTO,16))
 ; If the message hasn't been sent to a specific basket for this user
 ; and the sender specified a delivery basket, and the recipient is
 ; OK with that, then use the delivery basket.
 ; Note: The IN basket is not considered a 'specific basket'.
 I XMK<2,XMZBSKT'="","^^N^"'[(U_$P(XMREC,U,2)_U) S XMK=$$NAMEBSKT(XMTO,XMZBSKT,$P(XMREC,U,2)) Q:XMK
 ; If the message hasn't been sent to a specific basket for this user
 ; and active filters exist, and filtering is turned on,
 ; then filter the message.
 I XMK<2,$D(^XMB(3.7,XMTO,15,"AF")),$P(XMREC,U,1)="Y" D FILTER^XMTDF(XMTO,XMZ,XMZSUBJ,XMZFROM,.XMK,"",.XMACT) Q
 ; The message was sent to a specific basket for this user.
 I XMK Q:$D(^XMB(3.7,XMTO,2,XMK,0))  ; Quit if the basket XMK exists.
 S XMK=1 ; Since the basket doesn't exist, force to the IN basket
 Q:$D(^XMB(3.7,XMTO,2,XMK,0))  ; Quit if the IN basket exists.
 D MAKEBSKT^XMXBSKT(XMTO,XMK,$$EZBLD^DIALOG(37005)) ; Create the "IN" basket
 Q
NAMEBSKT(XMTO,XMKN,XMZBOK) ; Basket name (not number)
 N XMK
 S XMK=$O(^XMB(3.7,XMTO,2,"B",XMKN,0))
 S:'XMK XMK=$$FIND1^DIC(3.701,","_XMTO_",","X",$$LOW^XLFSTR(XMKN))
 I XMK D  Q XMK
 . Q:XMZBOK'="S"  ; 'YES' or 'EXISTING ONLY'
 . S:$P(^XMB(3.7,XMTO,2,XMK,0),U,3)'="Y" XMK=0  ; 'SELECTED ONLY'
 ; Basket not found
 Q:XMZBOK'="Y" 0  ; quit if not 'YES'
 I XMKN=$$EZBLD^DIALOG(37004) S XMK=.5 D MAKEBSKT^XMXBSKT(XMTO,XMK,XMKN) Q XMK  ; "WASTE"
 I XMKN=$$EZBLD^DIALOG(37005) S XMK=1 D MAKEBSKT^XMXBSKT(XMTO,XMK,XMKN) Q XMK  ; "IN"
 D MAKEBSKT^XMXBSKT(XMTO,.XMK,XMKN)
 Q XMK
ADDNEW(XMFROM,XMTO,XMK,XMZ,XMDEL,XMACT,XMREPLY) ;
 N XMFDA,XMIENS,XMIEN,XMTRIES
 S XMIENS="+1,"_XMK_","_XMTO_","
 S XMIEN(1)=XMZ
 S XMFDA(3.702,XMIENS,.01)=XMZ
 I XMK'=.5 D
 . I XMFROM'=XMTO D
 . . I $G(XMACT("NONEW")),'$$RESP^XMXUTIL2(XMZ),$$ZREAD^XMXUTIL2(XMTO,XMZ)="" Q
 . . S XMFDA(3.702,XMIENS,3)=1  ; new flag
 . . D INCRNEW^XMXUTIL(XMTO,XMK)  ; New counts
 . I $G(XMACT("VDAYS")) D  Q
 . . S XMFDA(3.702,XMIENS,5)=$$FMADD^XLFDT(DT,XMACT("VDAYS"))  ; vapor date
 . . S XMFDA(3.702,XMIENS,7)=0  ; vapor date set by user
 . I XMDEL S XMFDA(3.702,XMIENS,5)=XMDEL  ; vapor date
 ; Basket sequence number (XMKZ), and priority & new xrefs are handled by FM triggers.
ATRY D UPDATE^DIE("S","XMFDA","XMIEN")
 I '$D(DIERR) D  Q
 . Q:'$D(XMACT("FWD"))
 . I 'XMREPLY,XMFROM'=XMTO D FORWARD(XMTO,XMZ,XMACT("FWD"))
 S XMTRIES=$G(XMTRIES)+1
 I $D(^TMP("DIERR",$J,"E",110)) H 1 G ATRY ; Try again if can't lock
 Q
MAKENEW(XMTO,XMK,XMZ) ;
 ; We ignore any "vapor" date here because this is an existing msg
 N XMFDA,XMREC
 S XMREC=$G(^XMB(3.7,XMTO,2,XMK,1,XMZ,0))
 I XMREC="" D  Q:XMREC=""
 . ; Message entry should have been there, but it wasn't.  Add it.
 . D FIXBSKT(XMTO,XMK,XMZ)
 . S XMREC=$G(^XMB(3.7,XMTO,2,XMK,1,XMZ,0)) Q:XMREC'=""
 . D ADDNEW(0,XMTO,XMK,XMZ,0)
 S XMFDA(3.702,XMZ_","_XMK_","_XMTO_",",3)=1  ; new flag
 ; Delete 'automatic delete date' if it was set by the system
 ; (during IN BASKET PURGE).
 S:$P(XMREC,U,7) XMFDA(3.702,XMZ_","_XMK_","_XMTO_",",5)="@"
 L +^XMB(3.7,XMTO,2,XMK,1,XMZ,0):1 ; Lock message
 ; Priority & new xrefs are handled by FM triggers.
 D FILE^DIE("","XMFDA")
 L -^XMB(3.7,XMTO,2,XMK,1,XMZ,0)
 D INCRNEW^XMXUTIL(XMTO,XMK) ; New counts
 Q
SECRET(XMDATE,XMZ) ;
 ; Don't need to check to see if the user already has the msg, because
 ; at this point, we already know that he doesn't.
 N XMCRE8
 S XMCRE8=$P($G(^XMB(3.9,XMZ,.6)),U)
 Q $S('XMCRE8:0,XMDATE>XMCRE8:1,1:0)  ; 1 means user may NOT see the msg.
MOVENEW(XMFROM,XMTO,XMK,XMZ,XMACT) ; Move msg from WASTE bskt and make new
 N XMFDA,XMREC,XMIENS,XMIEN,XMTRIES
 S XMREC=$G(^XMB(3.7,XMTO,2,.5,1,XMZ,0))
 I XMREC="" D  Q:XMREC=""
 . ; Message entry should have been there, but it wasn't.
 . D FIXBSKT(XMTO,.5,XMZ)
 . S XMREC=$G(^XMB(3.7,XMTO,2,.5,1,XMZ,0)) Q:XMREC'=""
 . D ADDNEW(XMFROM,XMTO,XMK,XMZ,0)
 S XMIENS="+1,"_XMK_","_XMTO_","
 S XMIEN(1)=XMZ
 S XMFDA(3.702,XMIENS,.01)=XMZ
 S:XMFROM'=XMTO XMFDA(3.702,XMIENS,3)=1 ; new flag
 S:$P(XMREC,U,4) XMFDA(3.702,XMIENS,4)=$P(XMREC,U,4) ; date last accessed
 ;I '$P(XMREC,U,7),$P(XMREC,U,5)>DT S XMFDA(3.702,XMIENS,5)=$P(XMREC,U,5) ; vapor date set by user, not system
 I $G(XMACT("VDAYS")) D
 . S XMFDA(3.702,XMIENS,5)=$$FMADD^XLFDT(DT,XMACT("VDAYS"))  ; vapor date
 . S XMFDA(3.702,XMIENS,7)=0  ; vapor date set by user
MTRY D UPDATE^DIE("S","XMFDA","XMIEN")
 I '$D(DIERR) D  Q
 . D:XMFROM'=XMTO INCRNEW^XMXUTIL(XMTO,XMK) ; Increment new counts
 . N DA,DIK
 . S DA(2)=XMTO,DA(1)=.5,DA=XMZ
 . S DIK="^XMB(3.7,"_XMTO_",2,.5,1,"
 . D ^DIK ; delete msg from waste bskt
 S XMTRIES=$G(XMTRIES)+1
 I $D(^TMP("DIERR",$J,"E",110)) H 1 G MTRY ; Try again if can't lock
 Q
FIXBSKT(XMTO,XMK,XMZ) ; Basket integrity check
 N XMERROR ; (set in ^XMUT4)
 L +^XMB(3.7,XMTO,2,XMK):1
 K ^XMB(3.7,"M",XMZ,XMTO,XMK) ; This xref is wrong.
 D BSKT^XMUT4(XMTO,XMK)
 L -^XMB(3.7,XMTO,2,XMK)
 Q
FORWARD(XMTO,XMZ,XMFIEN) ;
 ; XMFIEN  IEN of the filter which activated.
 N XMUPTR
 S XMUPTR=+$O(^XMB(3.9,XMZ,1,"C",XMTO,0))
 Q:$P($G(^XMB(3.9,XMZ,1,XMUPTR,0)),U,13)'=""  ; already forwarded once.
 N XMFDA
 S XMFDA(3.91,XMUPTR_","_XMZ_",",15)=XMFIEN
 D FILE^DIE("","XMFDA")
 Q
