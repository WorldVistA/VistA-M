XMXGRP1 ;ISC-SF/GMB-Group creation/enrollment (cont.) ;04/17/2002  14:10
 ;;8.0;MailMan;;Jun 28, 2002
FAFMSGS(XMDUZ,XMGRP,XMTO,XMINSTR,ZTSK) ; Create task to find and forward messages
 ; The following line can be deleted once we enable "A":
 S XMINSTR("FLAGS")=$TR($G(XMINSTR("FLAGS")),"A") Q:$G(XMINSTR("FLAGS"))'["F"
 N ZTSAVE,ZTDESC,ZTRTN,ZTDTH,ZTIO,I
 S ZTDESC=$$EZBLD^DIALOG(38023.8) ; MailMan: Find & Forward mail group messages
 S ZTIO="",ZTDTH=$H,ZTRTN="FAFTSK^XMXGRP1"
 F I="DUZ","XMDUZ","XMGRP*","XMTO*","XMINSTR(" S ZTSAVE(I)=""
 D ^%ZTLOAD
 Q
FAFTSK ; Find and add/forward messages
 N XMFDATE,XMTDATE,XMGROUP,XMX,XMFIRST,XMABORT
 S XMABORT=0
 D INIT Q:XMABORT
 D PROCESS
 D CLEANUP^XMXADDR
 K ^TMP("XM",$J,"SAVE")
 Q
PROCESS ;
 I XMINSTR("FLAGS")["A",XMINSTR("FLAGS")["F" D  Q  ; Forward some of the messages to the users, and add the users to the rest of the messages.
 . D SAVFWD(.XMX)
 . I XMFIRST<XMFDATE D
 . . D CHKADD(.XMX) Q:'$D(^TMP("XMY",$J))
 . . D ADDFWD(XMDUZ,.XMGROUP,"A",XMFIRST,XMFDATE-1,.XMX) ; add
 . . M ^TMP("XMY",$J)=^TMP("XM",$J,"SAVE")
 . D ADDFWD(XMDUZ,.XMGROUP,"F",XMFDATE,XMTDATE,.XMX) ; forward
 . I XMTDATE<DT D
 . . I XMX("RESTORE") M ^TMP("XMY",$J)=^TMP("XM",$J,"SAVE") S XMX("RESTORE")=0
 . . D CHKADD(.XMX) Q:'$D(^TMP("XMY",$J))
 . . D ADDFWD(XMDUZ,.XMGROUP,"A",XMTDATE+.1,DT,.XMX) ; add
 I XMINSTR("FLAGS")["F" D  Q  ; Just forward messages to users
 . D SAVFWD(.XMX)
 . D ADDFWD(XMDUZ,.XMGROUP,"F",XMFDATE,XMTDATE,.XMX) ; forward
 I XMINSTR("FLAGS")["A" D  Q  ; Just add users to messages
 . D CHKADD(.XMX) Q:'$D(^TMP("XMY",$J))
 . D ADDFWD(XMDUZ,.XMGROUP,"A",XMFDATE,XMTDATE,.XMX) ; add
 Q
INIT ;
 N XMPRIVAT,XMGN,XMI
 S ZTREQ="@"
 S XMPRIVAT=$$EZBLD^DIALOG(39135) ; " [Private Mail Group]"
 S XMFIRST=$O(^XMB(3.9,"C",2500000)) ; earliest message date (after 1950!)
 S XMFDATE=$G(XMINSTR("FDATE"),XMFIRST)
 S XMTDATE=$G(XMINSTR("TDATE"),DT)
 D INITAPI^XMVVITAE
 D INIT^XMXADDR
 D CHKADDR^XMXADDR(XMDUZ,.XMTO)
 I '$$GOTADDR^XMXADDR S XMABORT=1 Q
 I $G(XMGRP)]"" S XMGRP(XMGRP)=$O(^XMB(3.8,"B",XMGRP,0))
 S XMGN=""
 F  S XMGN=$O(XMGRP(XMGN)) Q:XMGN=""  D
 . S XMI=XMGRP(XMGN)
 . S XMGROUP("G."_XMGN_$S($P($G(^XMB(3.8,XMI,0)),U,2)="PR":XMPRIVAT,1:""))=XMI
 K XMGRP
 I $D(XMINSTR("SELF BSKT")) S XMX("SELF BSKT")=XMINSTR("SELF BSKT")
 Q
SAVFWD(XMX) ;
 S XMX("RESTORE")=0
 M ^TMP("XM",$J,"SAVE")=^TMP("XMY",$J)
 S XMX("ONE")=$O(^TMP("XMY",$J,"")) ; First recipient.  Is it the only one?
 I $O(^TMP("XMY",$J,XMX("ONE")))'="" S XMX("ONE")=0 ; There's more than one recipient
 Q
CHKADD(XMX) ;
 S XMX("FWDBY")=XMV("NAME")_$S(XMDUZ=DUZ:"",1:$$EZBLD^DIALOG(38008,XMV("DUZ NAME")))_" "_$$MMDT^XMXUTIL1($$NOW^XLFDT) ; " (Surrogate: _x_)"
 S XMI=0 ; Delete any remote addresses - responses won't be forwarded.
 F  S XMI=$O(^TMP("XMY",$J,XMI)) Q:XMI=""  K:+XMI'=XMI ^(XMI)
 Q
ADDFWD(XMDUZ,XMGROUP,XMWHAT,XMFDATE,XMTDATE,XMX) ;
 N XMZ,XMCRE8,XMGN
 S XMZ=0
 S XMCRE8=XMFDATE-.1
 F  S XMCRE8=$O(^XMB(3.9,"C",XMCRE8)) Q:'XMCRE8  Q:XMCRE8>XMTDATE  D  Q:$G(ZTSTOP)
 . I $$S^%ZTLOAD S ZTSTOP=1 Q
 . F  S XMZ=$O(^XMB(3.9,"C",XMCRE8,XMZ)) Q:'XMZ  D
 . . Q:$$ZCLOSED^XMXSEC(XMZ)  ; Message is closed
 . . S XMGN=""
 . . F  S XMGN=$O(XMGROUP(XMGN)) Q:XMGN=""  Q:$S($L(XMGN)<31:$D(^XMB(3.9,XMZ,6,"B",XMGN)),$D(^XMB(3.9,XMZ,6,"B",$E(XMGN,1,30))):(XMGN=$P($G(^XMB(3.9,XMZ,6,+$O(^XMB(3.9,XMZ,6,"B",$E(XMGN,1,30),0)),0)),U,1)),1:0)
 . . Q:XMGN=""  ; Message is not addressed to any of the groups
 . . I XMWHAT="F" D FWD(XMDUZ,XMZ,.XMX) Q
 . . D ADD(XMDUZ,XMZ,.XMX)
 Q
FWD(XMDUZ,XMZ,XMX) ; Forward the message to the user
 N XMINSTR
 I $D(XMX("SELF BSKT")) S XMINSTR("SELF BSKT")=XMX("SELF BSKT")
 I XMX("ONE")'=0 Q:$D(^XMB(3.9,XMZ,1,"C",XMX("ONE")))  ; User already on msg.
 I XMX("ONE")=0 D  Q:'$D(^TMP("XMY",$J))
 . I XMX("RESTORE") M ^TMP("XMY",$J)=^TMP("XM",$J,"SAVE") S XMX("RESTORE")=0
 . N XMI
 . S XMI=""
 . F  S XMI=$O(^TMP("XMY",$J,XMI)) Q:XMI=""  D
 . . Q:'$D(^XMB(3.9,XMZ,1,"C",XMI))  ; User not yet on msg.
 . . K ^TMP("XMY",$J,XMI)  ; User on msg - don't forward to user.
 . . S XMX("RESTORE")=1
 D FWD^XMKP(XMDUZ,XMZ,.XMINSTR)
 Q
ADD(XMDUZ,XMZ,XMX) ; Add user(s) to message.
 ; XMX("FWDBY")
 N XMI,XMFDA,XMIENS,XMPRI
 S XMPRI=$$ZPRI^XMXUTIL2(XMZ) ; Is msg priority?
 ; Put users into RECIPIENT multiple
 S XMI=0
 F  S XMI=$O(^TMP("XMY",$J,XMI)) Q:'XMI  D
 . Q:$D(^XMB(3.9,XMZ,1,"C",XMI))  ; User already on msg - don't add.
 . D NEW^XMKP(XMZ,XMPRI,XMI,$G(^TMP("XMY",$J,XMI,1)),.XMFDA,.XMIENS) ; New recipient
 . S XMFDA(3.91,XMIENS,8)=XMX("FWDBY") ; fwd by name date time
 . S XMFDA(3.91,XMIENS,8.01)=XMDUZ  ; fwd by duz
 . ; Need new field that says 'parked until next reply'.
 . D UPDATE^DIE("","XMFDA")
 Q
NOTIFY(XMG,XMNEWMBR) ; If the group is restricted in any way,
 ; notify the organizer & coordinator of the new members.
 N XMREC,XMTO,I
 S XMREC=^XMB(3.8,XMG,0)
 I $P(XMREC,U,2)="PU",$P(XMREC,U,3)="y" Q
 S I=$P($G(^XMB(3.8,XMG,3)),U) S:I XMTO(I)="" ; organizer
 S I=$P(XMREC,U,7) S:I XMTO(I)="" ; coordinator
 Q:$D(XMTO(DUZ))
 N XMPARM,XMTEXT,XMINSTR,XMNAME,J
 S I=0 F  S I=$O(XMNEWMBR(I)) Q:'I  S XMNAME($$NAME^XMXUTIL(I,1))=""
 S J="" F I=1:1 S J=$O(XMNAME(J)) Q:J=""  S XMTEXT(I)=J
 S XMINSTR("FROM")=.5
 S XMPARM(1)=$$NAME^XMXUTIL(DUZ),XMPARM(2)=$P(^XMB(3.8,XMG,0),U,1)
 D TASKBULL^XMXBULL(DUZ,"XM GROUP EDIT NOTIFY",.XMPARM,"XMTEXT",.XMTO,.XMINSTR)
 Q
