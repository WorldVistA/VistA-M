XMXUTIL3 ;ISC-SF/GMB-List addressees, recipients, message network header ;03/05/2001  15:23
 ;;8.0;MailMan;**34**;Jun 28, 2002
 ; All entry points covered by DBIA 2737.
 ; Common Parameters for Q, QD, QL, QN, QX:
 ; XMZ     message number in message file
 ; XMAMT   How many?
 ;         =number - Get this many
 ;         =*      - Get all (default)
 ; XMSTART("IEN") is used to start the lister going.  The lister will
 ;         keep it updated from call to call.
 ;         It is the IEN to start AFTER.
 ;         (Default is to start at the beginning: after 0.)
 ; XMTROOT is the target root to receive the message list.
 ;         (default is ^TMP("XMLIST",$J))
 ; XMFLAGS are used to control processing (currently not used, except QX)
 ; XMFIND  Search for recipients/addressees matching this string.
 ;         Same rules as for FileMan lookups.
 ;         (If XMFIND is supplied, XMSTART and XMAMT are ignored, and
 ;          a complete list is returned.)
 ;
Q(XMZ,XMFLAGS,XMAMT,XMSTART,XMFIND,XMTROOT) ; Addressee listing
 N XMCNT,XMIEN,XMREC
 D QINIT(.XMFLAGS,.XMAMT,.XMFIND,.XMTROOT)
 I $D(XMFIND) D
 . D FIND^DIC(3.911,","_XMZ_",","","",XMFIND,"","B")
 E  D
 . D LIST^DIC(3.911,","_XMZ_",","","",XMAMT,.XMSTART,"","B")
 S XMCNT=0
 F  S XMCNT=$O(^TMP("DILIST",$J,2,XMCNT)) Q:XMCNT=""  S XMIEN=^(XMCNT) D
 . S XMREC=$G(^XMB(3.9,XMZ,6,XMIEN,0))
 . S @(XMTROOT_XMCNT_",""TO NAME"")")=$P(XMREC,U,1)
 . I $P(XMREC,U,2)'="" S @(XMTROOT_XMCNT_",""TYPE"")")=$P(XMREC,U,2)
 S @(XMTROOT_"0)")=$G(^TMP("DILIST",$J,0))
 K ^TMP("DILIST",$J)
 Q
QD(XMZ,XMFLAGS,XMAMT,XMSTART,XMFIND,XMTROOT) ; Recipient listing
 D QINIT(.XMFLAGS,.XMAMT,.XMFIND,.XMTROOT)
 I $D(XMFIND) D
 . N XMCNT
 . D QFIND^XMXUTIL4(XMZ,XMFLAGS,XMFIND,XMTROOT,.XMCNT)
 . S @(XMTROOT_"0)")=XMCNT_U_"*^0"
 . K ^TMP("DILIST",$J)
 E  D
 . D QLIST^XMXUTIL4(XMZ,XMFLAGS,XMAMT,.XMSTART,XMTROOT)
 Q
QL(XMZ,XMFLAGS,XMAMT,XMSTART,XMFIND,XMTROOT) ; Later'd Addressee listing
 N XMCNT,XMIEN,XMREC
 D QINIT(.XMFLAGS,.XMAMT,.XMFIND,.XMTROOT)
 I $D(XMFIND) D
 . D FIND^DIC(3.914,","_XMZ_",","","",XMFIND,"","B")
 E  D
 . D LIST^DIC(3.914,","_XMZ_",","","",XMAMT,.XMSTART,"","B")
 S XMCNT=0
 F  S XMCNT=$O(^TMP("DILIST",$J,2,XMCNT)) Q:XMCNT=""  S XMIEN=^(XMCNT) D
 . S XMREC=$G(^XMB(3.9,XMZ,7,XMIEN,0))
 . S @(XMTROOT_XMCNT_",""TO NAME"")")=$P(XMREC,U,1)
 . I $P(XMREC,U,2)'="" S @(XMTROOT_XMCNT_",""TYPE"")")=$P(XMREC,U,2)
 . S @(XMTROOT_XMCNT_",""BY DUZ"")")=$P(XMREC,U,3)
 . S @(XMTROOT_XMCNT_",""BY NAME"")")=$P(XMREC,U,4)
 . S @(XMTROOT_XMCNT_",""WHEN"")")=$P(XMREC,U,5)
 . S @(XMTROOT_XMCNT_",""WHEN MM"")")=$$MMDT^XMXUTIL1($P(XMREC,U,5))
 S @(XMTROOT_"0)")=$G(^TMP("DILIST",$J,0))
 K ^TMP("DILIST",$J)
 Q
QINIT(XMFLAGS,XMAMT,XMFIND,XMTROOT) ; For internal MailMan use only.
 S XMFLAGS=$G(XMFLAGS)
 I $G(XMAMT)="" S XMAMT="*"
 I $D(XMFIND),XMFIND="" K XMFIND
 I $D(XMTROOT),XMTROOT'="" D
 . K @$$CREF^DILF(XMTROOT)
 . S XMTROOT=$$OREF^DILF(XMTROOT)_"""XMLIST"","
 E  D
 . K ^TMP("XMLIST",$J)
 . S XMTROOT="^TMP(""XMLIST"",$J,"
 Q
QN(XMZ,XMFLAGS,XMAMT,XMSTART,XMTROOT) ; Get network header lines
 N XMCNT,XMIEN
 D QNINIT(.XMAMT,.XMTROOT)
 S XMCNT=0
 S XMIEN=+$G(XMSTART("IEN"))
 F  S XMIEN=$O(^XMB(3.9,XMZ,2,XMIEN)) Q:XMIEN'<1  D  Q:XMCNT=XMAMT
 . S XMCNT=XMCNT+1
 . S @(XMTROOT_XMCNT_")")=^XMB(3.9,XMZ,2,XMIEN,0)
 S XMSTART("IEN")=XMIEN
 S @(XMTROOT_"0)")=XMCNT_U_XMAMT_U_$S(XMIEN'<1:0,$O(^XMB(3.9,XMZ,2,XMIEN))<1:1,1:0) ; Any more?
 Q
QNINIT(XMAMT,XMTROOT) ; For internal MailMan use only.
 I $G(XMAMT)="" S XMAMT="*"
 I $D(XMTROOT),XMTROOT'="" D
 . K @$$CREF^DILF(XMTROOT)
 . S XMTROOT=$$OREF^DILF(XMTROOT)_"""XMLIST"","
 E  D
 . K ^TMP("XMLIST",$J)
 . S XMTROOT="^TMP(""XMLIST"",$J,"
 Q
QX(XMZ,XMFLAGS,XMAMT,XMSTART,XMTROOT) ; Local Recipient Xtract
 ; XMFLAGS = "C" list users who are current in reading the message
 ;           "N" list users who are NOT current in reading the message
 ;           "T" list users who have terminated the message
 N XMFIND,XMCNT,XMIEN,XMREC,XMTO,XMNAME,XMRESPS,XMMORE
 I $L($G(XMFLAGS))'=1,"CNT"'[XMFLAGS Q
 D QINIT(.XMFLAGS,.XMAMT,.XMFIND,.XMTROOT)
 S XMRESPS=+$P($G(^XMB(3.9,XMZ,3,0)),U,4)
 S XMCNT=0,XMTO=+$G(XMSTART("IEN"))
 F  S XMTO=$O(^XMB(3.9,XMZ,1,"C",XMTO)) Q:+XMTO'='XMTO  D  Q:XMCNT=XMAMT
 . S XMIEN=$O(^XMB(3.9,XMZ,1,"C",XMTO)) Q:'XMIEN
 . S XMREC=$G(^XMB(3.9,XMZ,1,XMIEN,0))
 . I XMFLAGS="C",$P(XMREC,U,2)'=XMRESPS Q  ; not current
 . I XMFLAGS="N",$P(XMREC,U,2)=XMRESPS Q  ; current
 . I XMFLAGS="T",'$G(^XMB(3.9,XMZ,1,XMIEN,"D")) Q  ; not terminated
 . S XMCNT=XMCNT+1
 . S XMNAME=$$NAME^XMXUTIL(XMTO)
 . D QDFLDS^XMXUTIL4(XMZ,XMFLAGS,XMIEN,XMREC,XMNAME,XMTROOT,XMCNT)
 S XMSTART("IEN")=XMTO
 I XMAMT'="*" D
 . S XMMORE=0 ; any more?
 . F  S XMTO=$O(^XMB(3.9,XMZ,1,"C",XMTO)) Q:+XMTO'='XMTO  D  Q:XMMORE
 . . S XMIEN=$O(^XMB(3.9,XMZ,1,"C",XMTO)) Q:'XMIEN
 . . S XMREC=$G(^XMB(3.9,XMZ,1,XMIEN,0))
 . . I XMFLAGS="C",$P(XMREC,U,2)'=XMRESPS Q  ; not current
 . . I XMFLAGS="N",$P(XMREC,U,2)=XMRESPS Q  ; current
 . . I XMFLAGS="T",'$G(^XMB(3.9,XMZ,1,XMIEN,"D")) Q  ; not terminated
 . . S XMMORE=1
 S @(XMTROOT_"0)")=XMCNT_U_XMAMT_U_$S(XMAMT="*":0,1:XMMORE)
 Q
