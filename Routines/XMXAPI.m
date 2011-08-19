XMXAPI ;ISC-SF/GMB-Message APIs ; 4/2/09 10:11am
 ;;8.0;MailMan;**15,41**;Jun 28, 2002;Build 3
 ; All entry points covered by DBIA 2729.
 ; Variables input:
 ; XMATTACH  Imaging system BLOB attachment array
 ; XMBODY    Message text (MUST NOT BE "XMBODY")
 ;              (must be closed root, passed by value.  See WP_ROOT
 ;               definition for WP^DIE(), FM word processing filer)
 ; XMDUZ     User's DUZ, or enough of user's name for a positive ID
 ;              eg: 1301 or "lastname,firs"
 ; XMK       Basket number, or enough of a name for a positive ID
 ;              eg: 1 or "IN"
 ; XMKZ      Message number in basket XMK
 ;           OR
 ;           if $G(XMK)="", Message number in ^XMB(3.9
 ; XMKZA     Message number list or list array in basket XMK
 ;              eg: "1,3,5-7" or ARRAY("1,3")=""
 ;                               ARRAY("5-7")=""
 ;              (list may end in comma)
 ;              (ARRAY must be passed by reference)
 ;           OR
 ;           if $G(XMK)="", Message number list or list array in ^XMB(3.9
 ;              (same rules, but number ranges are NOT allowed)
 ; XMSUBJ    Message subject
 ; XMTO      Addressee or addressee array
 ;              (array must be passed by reference)
 ;           User's DUZ, or enough of user's name for a positive ID
 ;              eg: 1301 or "lastname,firs" or ARRAY(1301)=""
 ;                                             ARRAY("lastname,firs")=""
 ;           G.group name (enough for positive ID)
 ;           S.server name (enough for positive ID)
 ;           D.device name (enough for positive ID)
 ;           prefix above (except devices and servers) by:
 ;              I: for 'information only' recipient (may not reply)
 ;                 eg: "I:1301" or "I:lastname,firs"
 ;              C: for 'copy' recipient (not expected to reply)
 ;                 eg: "C:1301" or "C:lastname,firs"
 ;              L@datetime: for when (in future) to send to this recipient
 ;                 (datetime may be anything accepted by FM)
 ;                 eg: "L@25 DEC@0500:1301" or "L@1 JAN:lastname,firs"
 ;                     or "L@2981225.05:1301"
 ;              (may combine IL@datetime:  or  CL@datetime:)
 ;           To delete recipient, prefix by -
 ;                 eg: -1301 or "-lastname,firs"
 ; XMZ       message number in ^XMB(3.9,
 ;
 ; Variables output (must be passed by reference):
 ; XMFULL    expanded address of last addressee
 ; XMMSG     simple message telling how many messages were acted on
 ; XMZ       message number created in ^XMB(3.9,
 ;
 ; Errors
 ; XMERR     if there's any errors, then XMERR is set to the number of
 ;           errors, otherwise XMERR is undefined.
 ;           ^TMP("XMERR",$J,error number,"TEXT",line number)=error text
ANSRMSG(XMDUZ,XMK,XMKZ,XMSUBJ,XMBODY,XMTO,XMINSTR,XMZR) ; Answer a msg (Send new msg with copy of original msg inside)
 ; In:  User, basket, msg #
 ; Out: XMZR (message number of answer)
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D ANSRMSG^XMXPARM(.XMDUZ,.XMK,.XMKZ,.XMSUBJ,.XMBODY,.XMTO,.XMINSTR) Q:$D(XMERR)
 D ANSRMSG^XMXANSER(XMDUZ,.XMK,XMKZ,.XMSUBJ,XMBODY,.XMTO,.XMINSTR,.XMZR)
 Q
DELMSG(XMDUZ,XMK,XMKZA,XMMSG) ; Delete msgs from a basket
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D ACTMSGS^XMXPARM(.XMDUZ,.XMK,.XMKZA) Q:$D(XMERR)
 D DELMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,.XMMSG)
 Q
FLTRMSG(XMDUZ,XMK,XMKZA,XMMSG) ; Filters msgs in a basket
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D ACTMSGS^XMXPARM(.XMDUZ,.XMK,.XMKZA) Q:$D(XMERR)
 D FLTRMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,.XMMSG)
 Q
FWDMSG(XMDUZ,XMK,XMKZA,XMTO,XMINSTR,XMMSG) ; Forward msgs
 ; XMINSTR("SHARE DATE")
 ; XMINSTR("SHARE BSKT")
 ; XMINSTR("SELF BSKT")
 ; XMINSTR("FWD BY") substitute any string instead of XMDUZ name
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D FWDMSG^XMXPARM(.XMDUZ,.XMK,.XMKZA,.XMTO,.XMINSTR) Q:$D(XMERR)
 D FWDMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,.XMTO,.XMINSTR,.XMMSG)
 Q
LATERMSG(XMDUZ,XMK,XMKZA,XMINSTR,XMMSG) ; Later msgs
 ; XMINSTR("LATER")
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D LATERMSG^XMXPARM(.XMDUZ,.XMK,.XMKZA,.XMINSTR) Q:$D(XMERR)
 D LATERMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,.XMINSTR,.XMMSG)
 Q
MOVEMSG(XMDUZ,XMK,XMKZA,XMKTO,XMMSG) ; Move msgs from one basket to another
 ; XMKTO   Basket number, or enough of a name for a positive ID.
 ;         Identifies basket to move to
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D MOVEMSG^XMXPARM(.XMDUZ,.XMK,.XMKZA,.XMKTO) Q:$D(XMERR)
 D MOVEMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,XMKTO,.XMMSG)
 Q
NTOGLMSG(XMDUZ,XMK,XMKZA,XMMSG) ; New Toggle msgs
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D ACTMSGS^XMXPARM(.XMDUZ,.XMK,.XMKZA) Q:$D(XMERR)
 D NTOGLMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,.XMMSG)
 Q
PRTMSG(XMDUZ,XMK,XMKZA,XMPRTTO,XMINSTR,XMMSG,XMTASK,XMSUBJ,XMTO) ; Print msgs
 ; XMINSTR("HDR"), "RESPS", "RECIPS", "WHEN"
 ; XMPRTTO Printer name
 ; XMSUBJ & XMTO used only if XMPRTTO is a P-MESSAGE device.  Even then, they're optional.
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D PRTMSG^XMXPARM(.XMDUZ,.XMK,.XMKZA,.XMPRTTO,.XMINSTR,.XMSUBJ,.XMTO) Q:$D(XMERR)
 D PRTMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,XMPRTTO,.XMINSTR,.XMMSG,.XMTASK,.XMSUBJ,.XMTO)
 Q
PUTSERV(XMKN,XMZ) ; Put a message in a server basket
 ; XMKN   full server name, including "S."
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 D SERV^XMXPARMB(.XMKN,.XMZ) Q:$D(XMERR)
 D PUTSERV^XMXMSGS1(XMKN,XMZ)
 Q
REPLYMSG(XMDUZ,XMK,XMKZ,XMBODY,XMINSTR,XMZR) ; Reply to msg (Attach reply to original msg)
 ; XMINSTR("NET REPLY") 1=send over the network; 0=don't (default)
 ; XMINSTR("NET SUBJ")  Network Reply subject (see XMSUBJ)
 ; Out: XMZR (message number of answer)
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D REPLYMSG^XMXPARM(.XMDUZ,.XMK,.XMKZ,.XMBODY,.XMINSTR) Q:$D(XMERR)
 D REPLYMSG^XMXREPLY(XMDUZ,.XMK,XMKZ,XMBODY,.XMINSTR,.XMZR)
 Q
SENDBULL(XMDUZ,XMBN,XMPARM,XMBODY,XMTO,XMINSTR,XMZ,XMATTACH) ; Send a bulletin (returns XMZ)
 ; In:  User, bulletin name, bulletin parameters, add'l text,
 ;      add'l recipients, send now or later (when?), opt'l BLOB
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D BULLETIN^XMXPARM(.XMDUZ,.XMBN,.XMPARM,.XMBODY,.XMTO,.XMINSTR,.XMATTACH) Q:$D(XMERR)
 D SENDBULL^XMXBULL(XMDUZ,XMBN,.XMPARM,.XMBODY,.XMTO,.XMINSTR,.XMZ,.XMATTACH)
 Q
SENDMSG(XMDUZ,XMSUBJ,XMBODY,XMTO,XMINSTR,XMZ,XMATTACH) ; Send a msg
 ; In:  User, basket (if you are recipient), all msg parts,
 ;      priority?, closed?, (info?,cc?), send now or later (when?),
 ;      (KIDS,MIME,text,PackMan), delete date (if to shared,mail)
 ; XMINSTR("RCPT BSKT")
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D SENDMSG^XMXPARM(.XMDUZ,.XMSUBJ,.XMBODY,.XMTO,.XMINSTR,.XMATTACH) Q:$D(XMERR)
 D SENDMSG^XMXSEND(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR,.XMZ,.XMATTACH)
 Q
TASKBULL(XMDUZ,XMBN,XMPARM,XMBODY,XMTO,XMINSTR,XMTASK,XMATTACH) ; Send a bulletin (Task it - does not return XMZ)
 ; XMBN     Bulletin name (must be full name)
 ; XMPARM   Array of parameters necessary for bulletin
 ;             ARRAY(1)="parameter 1"
 ;             ARRAY(2)="parameter 2"
 ; XMBODY   Additional text to append to the bulletin text
 ;              (must be closed root, passed by value.  See WP_ROOT
 ;               definition for WP^DIE(), FM word processing filer)
 ; XMTO     Additional addressee(s)
 ; XMINSTR("SELF BSKT")
 ;  ***ETC.***
 ; In:  User, bulletin name, bulletin parameters, add'l text,
 ;      add'l recipients, send now or later (when?), opt'l BLOB
 ; Out: XMTASK (task number)
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D BULLETIN^XMXPARM(.XMDUZ,.XMBN,.XMPARM,.XMBODY,.XMTO,.XMINSTR,.XMATTACH) Q:$D(XMERR)
 D TASKBULL^XMXBULL(XMDUZ,XMBN,.XMPARM,.XMBODY,.XMTO,.XMINSTR,.XMTASK,.XMATTACH)
 Q
TERMMSG(XMDUZ,XMK,XMKZA,XMMSG) ; Terminate msgs
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D ACTMSGS^XMXPARM(.XMDUZ,.XMK,.XMKZA) Q:$D(XMERR)
 D TERMMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,.XMMSG)
 Q
VAPORMSG(XMDUZ,XMK,XMKZA,XMINSTR,XMMSG) ; Set vaporize date for msgs in a basket
 ; XMINSTR("VAPOR")
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D VAPORMSG^XMXPARM(.XMDUZ,.XMK,.XMKZA,.XMINSTR) Q:$D(XMERR)
 D VAPORMSG^XMXMSGS(XMDUZ,.XMK,.XMKZA,.XMINSTR,.XMMSG)
 Q
ZAPSERV(XMKN,XMZ) ; Delete a message from a server basket
 ; XMKN   full server name, including "S."
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 D SERV^XMXPARMB(.XMKN,.XMZ) Q:$D(XMERR)
 D ZAPSERV^XMXMSGS1(XMKN,XMZ)
 Q
 ; ***** other actions
ADDRNSND(XMDUZ,XMZ,XMTO,XMINSTR) ; Build a message part 2 (address and send)
 ; XMZ (in)
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D ADDRNSND^XMXPARM(.XMDUZ,.XMZ,.XMTO,.XMINSTR) Q:$D(XMERR)
 D ADDRNSND^XMXSEND(XMDUZ,XMZ,.XMTO,.XMINSTR)
 Q
CRE8XMZ(XMSUBJ,XMZ) ; Build a message part 1 (create)
 ; In:  subject
 ; Out: XMZ
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 D VSUBJ^XMXPARM(.XMSUBJ) Q:$D(XMERR)
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMZ)
 Q
MOVEBODY(XMZ,XMBODY) ; Move text to the message
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 D MOVEBODY^XMXPARM(.XMZ,.XMBODY) Q:$D(XMERR)
 D MOVEBODY^XMXSEND(XMZ,XMBODY)
 Q
TOWHOM(XMDUZ,XMZ,XMTYPE,XMTO,XMINSTR,XMFULL) ; Check ONE msg addressee
 ; XMFULL   Expanded address of the addressee
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D TOWHOM^XMXPARM(.XMDUZ,.XMZ,.XMTYPE,XMTO,.XMINSTR) Q:$D(XMERR)
 D TOWHOM^XMXTO(XMDUZ,.XMZ,XMTYPE,XMTO,.XMINSTR,.XMFULL)
 Q
VSUBJ(XMSUBJ) ; Validate a subject
 N DIERR ; ADDED IN PATCH XM*8.0*41 JDG
 D VSUBJ^XMXPARM(.XMSUBJ)
 Q
