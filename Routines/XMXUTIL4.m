XMXUTIL4 ;ISC-SF/GMB-List message recipients (cont.) ;04/11/2002  10:44
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points are for internal MailMan use only.
QLIST(XMZ,XMFLAGS,XMAMT,XMSTART,XMTROOT) ; list them
 N XMCNT,XMIEN,XMREC,XMTO,XMNAME
 S XMCNT=0,XMIEN=+$G(XMSTART("IEN"))
 F  S XMIEN=$O(^XMB(3.9,XMZ,1,XMIEN)) Q:'XMIEN  D  Q:XMCNT=XMAMT
 . S XMCNT=XMCNT+1
 . S XMREC=$G(^XMB(3.9,XMZ,1,XMIEN,0))
 . S XMTO=$P(XMREC,U,1)
 . S XMNAME=$$NAME^XMXUTIL(XMTO)
 . D QDFLDS(XMZ,XMFLAGS,XMIEN,XMREC,XMNAME,XMTROOT,XMCNT)
 S XMSTART("IEN")=XMIEN
 S @(XMTROOT_"0)")=XMCNT_U_XMAMT_U_$S(XMAMT="*":0,1:$O(^XMB(3.9,XMZ,1,XMIEN))>0)
 Q
QDFLDS(XMZ,XMFLAGS,XMIEN,XMREC,XMNAME,XMTROOT,XMCNT) ;
 S @(XMTROOT_XMCNT_",""TO"")")=$P(XMREC,U,1)
 S @(XMTROOT_XMCNT_",""TO NAME"")")=XMNAME
 I $D(^XMB(3.9,XMZ,1,XMIEN,"T")) S @(XMTROOT_XMCNT_",""TYPE"")")=$P(^("T"),U,1)
 I $D(^XMB(3.9,XMZ,1,XMIEN,"F")) D FWD(XMZ,XMIEN)
 I $P(XMREC,U,1)?.N D  Q
 . S @(XMTROOT_XMCNT_",""TO ID"")")="L" ; local user
 . S @(XMTROOT_XMCNT_",""TO DUZ"")")=$P(XMREC,U,1)
 . I $P(XMREC,U,2)'="" D
 . . S @(XMTROOT_XMCNT_",""RESP"")")=$P(XMREC,U,2)
 . I $P(XMREC,U,3)'="" D
 . . S @(XMTROOT_XMCNT_",""LREAD"")")=$P(XMREC,U,3)
 . . S @(XMTROOT_XMCNT_",""LREAD MM"")")=$$MMDT^XMXUTIL1($P(XMREC,U,3))
 . I $P(XMREC,U,10)'="" D
 . . S @(XMTROOT_XMCNT_",""FREAD"")")=$P(XMREC,U,10)
 . . S @(XMTROOT_XMCNT_",""FREAD MM"")")=$$MMDT^XMXUTIL1($P(XMREC,U,10))
 . I $D(^XMB(3.9,XMZ,1,XMIEN,"C")) D
 . . N XMD
 . . S XMD=^XMB(3.9,XMZ,1,XMIEN,"C")
 . . S @(XMTROOT_XMCNT_",""COPY"")")=XMD
 . . S @(XMTROOT_XMCNT_",""COPY MM"")")=$$MMDT^XMXUTIL1(XMD)
 . I $D(^XMB(3.9,XMZ,1,XMIEN,"D")),$G(^("D")) D
 . . N XMD
 . . S XMD=^XMB(3.9,XMZ,1,XMIEN,"D")
 . . S @(XMTROOT_XMCNT_",""TERM"")")=XMD
 . . S @(XMTROOT_XMCNT_",""TERM MM"")")=$$MMDT^XMXUTIL1(XMD)
 . I $D(^XMB(3.9,XMZ,1,XMIEN,"S")) D
 . . S @(XMTROOT_XMCNT_",""SURR"")")=^XMB(3.9,XMZ,1,XMIEN,"S")
 I $E(XMNAME,1,2)="F.",$P(XMREC,U,12)'=""!$P(XMREC,U,11) D  Q
 . S @(XMTROOT_XMCNT_",""TO ID"")")="F" ; fax
 . I $P(XMREC,U,5)'="" D
 . . S @(XMTROOT_XMCNT_",""FDATE"")")=$P(XMREC,U,5)
 . . S @(XMTROOT_XMCNT_",""FDATE MM"")")=$$MMDT^XMXUTIL1($P(XMREC,U,5))
 . I $P(XMREC,U,6)'="" D
 . . S @(XMTROOT_XMCNT_",""STATUS"")")=$P(XMREC,U,6)
 . I $P(XMREC,U,11)'="" D
 . . S @(XMTROOT_XMCNT_",""FAX IEN"")")=$P(XMREC,U,11)
 . I $P(XMREC,U,12)'="" D
 . . S @(XMTROOT_XMCNT_",""ID"")")=$P(XMREC,U,12)
 I XMNAME["@" D  Q
 . S @(XMTROOT_XMCNT_",""TO ID"")")="R" ; remote
 . I $P(XMREC,U,4)'="" D
 . . S @(XMTROOT_XMCNT_",""ID"")")=$P(XMREC,U,4)
 . I $P(XMREC,U,5)'="" D
 . . S @(XMTROOT_XMCNT_",""XDATE"")")=$P(XMREC,U,5)
 . . S @(XMTROOT_XMCNT_",""XDATE MM"")")=$$MMDT^XMXUTIL1($P(XMREC,U,5))
 . I $P(XMREC,U,6)'="" D
 . . S @(XMTROOT_XMCNT_",""STATUS"")")=$P(XMREC,U,6)
 . I $P(XMREC,U,7)'="",$D(^DIC(4.2,$P(XMREC,U,7),0)) D
 . . S @(XMTROOT_XMCNT_",""PATH"")")=$P(XMREC,U,7)
 . . S @(XMTROOT_XMCNT_",""PATH NAME"")")=$P(^DIC(4.2,$P(XMREC,U,7),0),U)
 . I $P(XMREC,U,8)'="" D
 . . S @(XMTROOT_XMCNT_",""SECS"")")=$P(XMREC,U,8)
 I $E(XMNAME,1,3)="* (" D  Q
 . S @(XMTROOT_XMCNT_",""TO ID"")")=$E(XMNAME) ; broadcast
 ; I ".D.H.S."[("."_$E(XMNAME,1,2))
 S @(XMTROOT_XMCNT_",""TO ID"")")=$E(XMNAME) ; device or server
 I $P(XMREC,U,3)'="" D
 . S @(XMTROOT_XMCNT_",""SDATE"")")=$P(XMREC,U,3)
 . S @(XMTROOT_XMCNT_",""SDATE MM"")")=$$MMDT^XMXUTIL1($P(XMREC,U,3))
 I $P(XMREC,U,6)'="" D
 . S @(XMTROOT_XMCNT_",""STATUS"")")=$P(XMREC,U,6)
 Q
FWD(XMZ,XMIEN) ;
 Q:'$D(^XMB(3.9,XMZ,1,XMIEN,"F"))
 N XMFWDREC,XMFWDBY
 S XMFWDREC=^XMB(3.9,XMZ,1,XMIEN,"F")
 S XMFWDBY=$P(XMFWDREC,U)
 I $E(XMFWDBY)?1A!($E(XMFWDBY)="<") D
 . N XMLEN
 . S XMLEN=$L(XMFWDBY," ")
 . S @(XMTROOT_XMCNT_",""FWD BY"")")=$P(XMFWDBY," ",1,XMLEN-4)
 . S @(XMTROOT_XMCNT_",""FWD ON"")")=$P(XMFWDBY," ",XMLEN-3,XMLEN)
 E  I $E(XMFWDBY)?1N!($E(XMFWDBY)=".") D
 . N XMLEN
 . S XMFWDBY=$$NAME^XMXUTIL(+XMFWDBY)_" "_$P(XMFWDBY," ",2,99)
 . S XMLEN=$L(XMFWDBY," ")
 . S @(XMTROOT_XMCNT_",""FWD BY"")")=$P(XMFWDBY," ",1,XMLEN-4)
 . S @(XMTROOT_XMCNT_",""FWD ON"")")=$P(XMFWDBY," ",XMLEN-3,XMLEN)
 E  S @(XMTROOT_XMCNT_",""FWD ON"")")=$E(XMFWDBY,2,99)
 I $P(XMFWDREC,U,2) S @(XMTROOT_XMCNT_",""FWD BY DUZ"")")=$P(XMFWDREC,U,2)
 I "R"'[$P(XMFWDREC,U,3) S @(XMTROOT_XMCNT_",""FWD TYPE"")")=$P(XMFWDREC,U,3)
 Q:$P(XMFWDREC,U,4)=""  ; or quit if FWD TYPE="A"
 S @(XMTROOT_XMCNT_",""FWD BY ORIG"")")=$P(XMFWDREC,U,4)
 I "R"'[$P(XMFWDREC,U,5) S @(XMTROOT_XMCNT_",""FWD TYPE ORIG"")")=$P(XMFWDREC,U,5)
 Q
QFIND(XMZ,XMFLAGS,XMFIND,XMTROOT,XMCNT) ; find them
 S XMCNT=0
 D FIND^DIC(200,"","","A",XMFIND,"","B^BB^C^D","I $D(^XMB(3.9,XMZ,1,""C"",+Y))")
 I '$D(DIERR) D MOVE(200,XMZ,XMFLAGS,XMTROOT,.XMCNT)
 Q:$O(^XMB(3.9,XMZ,1,"C",":"))=""  ; Quit if there aren't any non-local addressees
 N XMSCREEN
 S XMSCREEN=$S(+XMFIND=XMFIND:"I '$D(^XMB(3.9,XMZ,1,""C"",XMFIND))",1:"")
 D FIND^DIC(3.91,","_XMZ_",","","C",XMFIND,"","C",XMSCREEN)
 I '$D(DIERR) D MOVE(3.91,XMZ,XMFLAGS,XMTROOT,.XMCNT)
 Q:$E(XMFIND)'?1U  ; Quit if the search string does not begin with an upper case letter
 Q:$O(^XMB(3.9,XMZ,1,"C","`"))=""  ; Quit if there aren't any lower case addressees
 ; FM will translate lower case to upper case in its search, but won't
 ; translate upper to lower, so we do it here.
 S XMSCREEN="I ^(0)]""`""" ; Limit search to lower case addresses
 D FIND^DIC(3.91,","_XMZ_",","","C",$$LOW^XLFSTR(XMFIND),"","C",XMSCREEN)
 I '$D(DIERR) D MOVE(3.91,XMZ,XMFLAGS,XMTROOT,.XMCNT)
 Q
MOVE(XMFILE,XMZ,XMFLAGS,XMTROOT,XMCNT) ; move search results
 N I,XMIEN,XMREC,XMNAME
 S I=0
 F  S I=$O(^TMP("DILIST",$J,1,I)) Q:I=""  D
 . S XMIEN=^TMP("DILIST",$J,2,I)
 . I XMFILE=200 D
 . . S XMIEN=$O(^XMB(3.9,XMZ,1,"C",XMIEN,0))
 . . S XMREC=$G(^XMB(3.9,XMZ,1,XMIEN,0))
 . . S XMNAME=^TMP("DILIST",$J,1,I)
 . E  D
 . . S XMREC=$G(^XMB(3.9,XMZ,1,XMIEN,0))
 . . S XMNAME=$P(XMREC,U,1)
 . S XMCNT=XMCNT+1
 . D QDFLDS(XMZ,XMFLAGS,XMIEN,XMREC,XMNAME,XMTROOT,XMCNT)
 Q
