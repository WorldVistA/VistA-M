XMXSEC ;ISC-SF/GMB-Message security and restrictions ;05/17/2002  13:25
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2731.
BCAST(XMZ) ; 0=msg was not broadcast; 1=msg was broadcast
 N XMBCAST
 S XMBCAST=$$EZBLD^DIALOG(39006) ; * (Broadcast to all local users)
 Q:$D(^XMB(3.9,XMZ,1,"C",$E(XMBCAST,1,30))) 1
 Q:$D(^XMB(3.9,XMZ,1,"C",XMBCAST)) 1
 Q 0
ZCLOSED(XMZ) ;
 Q $$CLOSED($G(^XMB(3.9,XMZ,0)))
CLOSED(XMZREC) ; 0=msg is not closed; 1=msg is closed
 Q "^Y^y^"[(U_$P(XMZREC,U,9)_U)
ZCONFID(XMZ) ;
 Q $$CONFID($G(^XMB(3.9,XMZ,0)))
CONFID(XMZREC) ; 0=msg is not confidential; 1=msg is confidential
 Q "^Y^y^"[(U_$P(XMZREC,U,11)_U)
ZCONFIRM(XMZ) ;
 Q $$CONFIRM($G(^XMB(3.9,XMZ,0)))
CONFIRM(XMZREC) ; 0=msg is not confirm receipt requested; 1=msg is confirm
 Q "^Y^y^"[(U_$P(XMZREC,U,5)_U)
ZINFO(XMZ) ;
 Q $$INFO($G(^XMB(3.9,XMZ,0)))
INFO(XMZREC) ; 0=msg is not information only; 1=msg is information only
 Q "^Y^y^"[(U_$P(XMZREC,U,12)_U)
ZORIGIN8(XMDUZ,XMZ) ;
 Q $$ORIGIN8R(XMDUZ,$G(^XMB(3.9,XMZ,0)))
ORIGIN8R(XMDUZ,XMZREC) ; Did the user send the message?
 ; 1=user is the originator ; 0=user is NOT the originator
 Q:XMDUZ=$P(XMZREC,U,2) 1
 Q:XMDUZ=$P(XMZREC,U,4) 1
 Q:XMDUZ=DUZ 0
 Q:DUZ=$P(XMZREC,U,2) 1
 Q:DUZ=$P(XMZREC,U,4) 1
 Q 0
ZPRI(XMZ) ;
 Q $$PRIORITY($G(^XMB(3.9,XMZ,0)))
PRIORITY(XMZREC) ; 0=msg is not priority; 1=msg is priority
 Q $P(XMZREC,U,7)["P"
SURRCONF(XMDUZ,XMZ) ; 0=msg is not confidential; 1=msg is confidential, and surrogate may not read it.
 ; We already know that XMDUZ'=DUZ.
 ; But the surrogate may read a confidential message if it was the
 ; surrogate who sent it.
 Q:"^Y^y^"'[(U_$P($G(^XMB(3.9,+XMZ,0)),U,11)_U) 0
 Q:DUZ=$P(^(0),U,2) 0  ; naked ref from above
 Q:DUZ=$P(^(0),U,4) 0  ; naked ref from above
 Q 1
ACCESS(XMDUZ,XMZ,XMZREC) ; Determines user access to a message.
 ; 1=user may access; 0=user may not access
 Q:$D(^XMB(3.7,"M",XMZ,XMDUZ)) $S(XMDUZ=DUZ:1,1:$$SURRACC(XMDUZ,"",XMZ,$G(XMZREC)))  ; Message is in user's mailbox
 N XMPRE
 S XMPRE=$P(^XMB(3.7,XMDUZ,0),U,7)
 I XMPRE,$P($G(^XMB(3.9,XMZ,.6)),U,1)<XMPRE D  Q 0
 . D ERRSET^XMXUTIL(37100,$$MMDT^XMXUTIL1(XMPRE),XMZ) ; You may not access any message prior to _X_ unless someone forwards it to you.
 Q:$D(^XMB(3.9,XMZ,1,"C",XMDUZ)) $S(XMDUZ=DUZ:1,1:$$SURRACC(XMDUZ,"",XMZ,$G(XMZREC)))  ; User is recipient
 ;Q:$D(^XMB(3.9,XMZ,1,"C",DUZ)) 1 ; Surrogate is a recipient.
 ; We comment out the above line, because it's not enough that the
 ; surrogate is a recipient of the message.  If the surrogate wants to
 ; access the message as XMDUZ, and the message is not in the mailbox
 ; of XMDUZ, then the message must have been sent by or to XMDUZ.
 Q:$$BCAST(XMZ) 1
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I $P(XMZREC,U,8) D  Q 0
 . N XMPARM
 . S XMPARM(1)=XMZ,XMPARM(2)=$P(XMZREC,U,8)
 . D ERRSET^XMXUTIL(37101,.XMPARM,XMZ) ; Message _XMZ_ is a response to message _$P(XMZREC,U,8)_.
 ; User (XMDUZ) is not a recipient.  Investigate further.
 Q $$ACCESS2^XMXSEC1(XMDUZ,XMZ,XMZREC)
SURRACC(XMDUZ,XMACCESS,XMZ,XMZREC) ; Determines surrogate access to a message.
 ; Assumes that we already know that XMDUZ is authorized to see this
 ; message, and that XMDUZ'=DUZ.  Now we want to know if DUZ may see it.
 ; 1=surrogate may access; 0=surrogate may not access
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 Q:'$$CONFID(XMZREC) 1  ; Message isn't confidential.
 Q:DUZ=$P(XMZREC,U,2) 1 ; Surrogate sent the message.
 Q:DUZ=$P(XMZREC,U,4) 1 ; Surrogate sent the message.
 ;Q:$D(^XMB(3.9,XMZ,1,"C",DUZ)) 1 ; Surrogate is a recipient.
 I $G(XMACCESS)'="" D ERRSET^XMXUTIL(37452,XMACCESS,XMZ) Q 0  ; Surrogates may not _XMACCESS_ CONFIDENTIAL messages.
 D ERRSET^XMXUTIL(37451,XMZ) ; Surrogates may not access or do anything to Confidential messages.
 Q 0
ANSWER(XMDUZ,XMZ,XMZREC) ; Answer (1=may, 0=may not)
 I DUZ=.6!(XMDUZ=.6) D ERRSET^XMXUTIL(37462,"",XMZ) Q 0  ; You may not do this in SHARED,MAIL.
 I XMDUZ'=DUZ Q:'$$WPRIV 0  Q:'$$SURRACC(XMDUZ,"",XMZ,.XMZREC) 0  ; "answer"
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I $$PAKMAN^XMXSEC1(XMZ,XMZREC) D ERRSET^XMXUTIL(37401.4,"",XMZ) Q 0  ; May not answer a PackMan message.
 I $D(^XMB(3.9,XMZ,"K")) D ERRSET^XMXUTIL(47401.2,"",XMZ) Q 0  ; May not answer a scrambled message.  Use Reply.
 I '$$GOTNS^XMVVITA(XMDUZ) D ERRSET^XMXUTIL($S(XMDUZ=DUZ:37401.1,1:37401.3),XMV("NAME"),XMZ) Q 0  ; You / X must have a network signature in order to answer a message.
 Q 1
COPY(XMDUZ,XMZ,XMZREC) ; Copy (1=may, 0=may not)
 I XMDUZ'=DUZ Q:'$$WPRIV 0  Q:'$$SURRACC(XMDUZ,"",XMZ,.XMZREC) 0  ; "copy"
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I $$CLOSED(XMZREC),'$$ORIGIN8R(XMDUZ,XMZREC) D ERRSET^XMXUTIL(37403.1,"",XMZ) Q 0  ; Only the message originator may copy CLOSED messages.
 I XMDUZ=.6,DUZ'=$P(XMZREC,U,2),DUZ'=$P(XMZREC,U,4) D ERRSET^XMXUTIL(37403.6,"",XMZ) Q 0  ; Only the originator may copy messages in SHARED,MAIL.
 I $D(^XMB(3.9,XMZ,"K")) D ERRSET^XMXUTIL(37403.2,"",XMZ) Q 0  ; May not copy a scrambled message.
 Q 1
INCLUDE(XMDUZ,XMZ,XMZREC) ; Include message XMZ as part of another message (1=may, 0=may not)
 ; If XMDUZ'=DUZ, assumes that surrogate has the privilege to
 ; send a new message, or reply to a message.
 Q:'$$ACCESS(XMDUZ,XMZ,.XMZREC) 0
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I $$CLOSED(XMZREC),'$$ORIGIN8R(XMDUZ,XMZREC) D ERRSET^XMXUTIL(37403.1,"",XMZ) Q 0  ; Only the message originator may copy CLOSED messages.
 I $D(^XMB(3.9,XMZ,"K")) D ERRSET^XMXUTIL(37403.2,"",XMZ) Q 0  ; May not copy a scrambled message.
 Q 1
DELETE(XMDUZ,XMK,XMZ,XMZREC) ; Delete, Terminate (1=may, 0=may not)
 Q:XMDUZ=DUZ 1
 Q:'$$RWPRIV 0
 ;I XMDUZ=.5,$G(XMK,$O(^XMB(3.7,"M",XMZ,XMDUZ,"")))>999 Q 1
 I XMDUZ=.5 Q 1
 Q:'$$SURRACC(XMDUZ,"",XMZ,.XMZREC) 0  ; "delete"
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I XMDUZ=.6,DUZ'=$P(XMZREC,U,2),DUZ'=$P(XMZREC,U,4),'$D(^XUSEC("XMMGR",DUZ)),'$D(^XMB(3.7,"AB",DUZ,.5,0)) D  Q 0
 . D ERRSET^XMXUTIL(37461,"",XMZ) ; Only the originator, postmaster surrogate, or XMMGR key holder may do this in SHARED,MAIL.
 Q 1
FORWARD(XMDUZ,XMZ,XMZREC) ; Forward (1=may, 0=may not)
 I XMDUZ'=DUZ Q:'$$RWPRIV 0  Q:'$$SURRACC(XMDUZ,"",XMZ,.XMZREC) 0  ; "forward"
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I $$CLOSED(XMZREC),'$$ORIGIN8R(XMDUZ,XMZREC) D ERRSET^XMXUTIL(37406.1,"",XMZ) Q 0  ; Only the message originator may forward CLOSED messages.
 I XMDUZ=.6,DUZ'=$P(XMZREC,U,2),DUZ'=$P(XMZREC,U,4) D ERRSET^XMXUTIL(37406.6,"",XMZ) Q 0  ; Only the originator may forward messages in SHARED,MAIL.
 Q 1
LATER(XMDUZ) ; Later or New Toggle (1=may, 0=may not)
 I DUZ=.6!(XMDUZ=.6) D ERRSET^XMXUTIL(37462) Q 0  ; SHARED,MAIL may not 'later' or 'new toggle' a message.
 Q:XMDUZ=DUZ 1
 Q $$RWPRIV
MOVE(XMDUZ,XMZ,XMZREC) ; Save or Filter (1=may, 0=may not)
 Q:XMDUZ=DUZ 1
 Q:'$$RWPRIV 0
 ;Q:'$$SURRACC(XMDUZ,"",XMZ,.XMZREC) 0  ; "save"
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I XMDUZ=.6,DUZ'=$P(XMZREC,U,2),DUZ'=$P(XMZREC,U,4),'$D(^XUSEC("XMMGR",DUZ)),'$D(^XMB(3.7,"AB",DUZ,.5,0)) D  Q 0
 . D ERRSET^XMXUTIL(37461,"",XMZ) ; Only the originator, postmaster surrogate, or XMMGR key holder may do this in SHARED,MAIL.
 Q 1
READ(XMDUZ,XMZ,XMZREC) ; Read or Print (1=may, 0=may not)
 Q:XMDUZ=DUZ 1
 Q $$SURRACC(XMDUZ,"",XMZ,.XMZREC)  ; "access"
REPLY(XMDUZ,XMZ,XMZREC) ; Reply (1=may, 0=may not)
 ; Should we make sure XMZ is an original msg and not a reply?
 ; Should we make sure the msg has recipients?
 I DUZ=.6 D ERRSET^XMXUTIL(37422.6,"",XMZ) Q 0  ; May not reply to message as SHARED,MAIL.
 I XMDUZ'=DUZ Q:'$$RWPRIV 0  Q:'$$SURRACC(XMDUZ,"",XMZ,.XMZREC) 0  ; "reply to"
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I $D(^XMB(3.9,XMZ,"K")),$$PAKMAN^XMXSEC1(XMZ,XMZREC) D ERRSET^XMXUTIL(37422.4,"",XMZ) Q 0  ; May not reply to secure PackMan message.
 Q:$$ORIGIN8R(XMDUZ,XMZREC) 1
 I $$INFO(XMZREC) D ERRSET^XMXUTIL(37422.1,"",XMZ) Q 0  ; Only originator may reply to 'INFORMATION ONLY' message.
 I $P($G(^XMB(3.9,XMZ,1,+$O(^XMB(3.9,XMZ,1,"C",XMDUZ,0)),"T")),U,1)["I" D ERRSET^XMXUTIL(37422.2,"",XMZ) Q 0  ; 'INFORMATION ONLY' recipient may not reply to message.
 I $P(XMZREC,U,2)["POSTMASTER@" D ERRSET^XMXUTIL(37422.5,"",XMZ) Q 0  ; You may not reply to a message from a remote Postmaster."
 Q 1
SEND(XMDUZ,XMINSTR) ; Send (1=may, 0=may not)
 I DUZ=.6!(XMDUZ=.6) D ERRSET^XMXUTIL(37462) Q 0  ; You may not do this in SHARED,MAIL.
 Q:XMDUZ=DUZ 1
 Q:$D(XMINSTR("FROM")) 1
 Q:XMDUZ=.5 1
 Q $$WPRIV
RWPRIV() ; Does the surrogate have 'read' or 'send' privilege? (1=yes, 0=no)
 Q:$G(XMV("PRIV"))["R"!($G(XMV("PRIV"))["W") 1
 D ERRSET^XMXUTIL(37457,XMV("NAME")) ; You do not have 'read' or 'send' privilege for "_XMV("NAME")
 Q 0
RPRIV() ; Does the surrogate have 'read' privilege? (1=yes, 0=no)
 Q:$G(XMV("PRIV"))["R" 1
 D ERRSET^XMXUTIL(37455,XMV("NAME")) ; You do not have 'read' privilege for "_XMV("NAME")
 Q 0
WPRIV() ; Does the surrogate have 'send' privilege? (1=yes, 0=no)
 Q:$G(XMV("PRIV"))["W" 1
 D ERRSET^XMXUTIL(37456,XMV("NAME")) ; You do not have 'send' privilege for "_XMV("NAME")
 Q 0
POSTPRIV() ; Perform postmaster actions (1=may, 0=may not)
 ; This includes permission to perform group message actions in Shared,Mail.
 I '$D(^XUSEC("XMMGR",DUZ)),'$D(^XMB(3.7,"AB",DUZ,.5)) D ERRSET^XMXUTIL(37458) Q 0  ; Only a POSTMASTER surrogate or XMMGR key holder may do this.
 Q 1
ZPOSTPRV() ; Perform postmaster actions (1=may, 0=may not)
 ; This includes permission to perform group message actions in Shared,Mail.
 Q:$D(^XUSEC("XMMGR",DUZ)) 1
 Q:$D(^XMB(3.7,"AB",DUZ,.5)) 1
 Q 0
