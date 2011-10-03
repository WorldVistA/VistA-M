XMUT4 ;ISC-SF/GMB-Integrity Checker for files 3.7, 3.9 ;07/15/2002  07:25
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; CHKFILES   XMUT-CHKFIL
 Q
CHKFILES ;
 I $D(ZTQUEUED) D PROCESS Q
 N XMABORT
 S XMABORT=0
 D WARNING^XMUT41(.XMABORT) Q:XMABORT
 D EN^XUTMDEVQ("PROCESS^XMUT4",$$EZBLD^DIALOG(36080)) ; MailMan: Global Integrity Checker
 Q
PROCESS ;
 I $D(ZTQUEUED) S ZTREQ="@"
 N XMABORT
 S XMABORT=0
 D MAILBOX(.XMABORT)
 D:'XMABORT MESSAGE^XMUT4C(.XMABORT)
 D SUMMARY^XMUT41(XMABORT)
 Q
MAILBOX(XMABORT) ;
 W:'$D(ZTQUEUED) !!,$$EZBLD^DIALOG(36081) ; Checking MAILBOX file 3.7
 D USERS(.XMABORT) Q:XMABORT
 D MXREF^XMUT41(.XMABORT) Q:XMABORT
 D POSTBSKT^XMUT41
 Q
USERS(XMABORT) ;
 ; XMUCNT   # users
 ; XMUKCNT  # bskts for a particular user
 ; XMUECNT  # msg entries for a particular user
 ; XMKCNT   # bskts
 ; XMECNT   # msg entries
 N XMUSER,XMECNT,XMUCNT,XMKCNT,XMUKCNT,XMUECNT
 W:'$D(ZTQUEUED) !!,$$EZBLD^DIALOG(36082),! ; Checking each user mailbox
 S (XMUSER,XMECNT,XMUCNT,XMKCNT)=0
 F  S XMUSER=$O(^XMB(3.7,XMUSER)) Q:XMUSER'>0  D  Q:XMABORT
 . S XMUCNT=XMUCNT+1 I XMUCNT#20=0 D  Q:XMABORT
 . . I '$D(ZTQUEUED) W:$X>40 ! W XMUCNT,"." Q
 . . I $$S^%ZTLOAD S (XMABORT,ZTSTOP)=1 ; User asked the task to stop
 . D USER(XMUSER,.XMUKCNT,.XMUECNT)
 . S XMKCNT=XMKCNT+XMUKCNT
 . S XMECNT=XMECNT+XMUECNT
 Q:XMABORT
 I '$D(ZTQUEUED) D
 . N XMPARM,XMTEXT
 . S XMPARM(1)=XMUCNT,XMPARM(2)=XMKCNT,XMPARM(3)=XMECNT
 . W !
 . D BLD^DIALOG(36083,.XMPARM,"","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . ;|1| Users, |2| Baskets, |3| Msg Entries"
 I $D(^XMB(3.7,0)) S:$P(^XMB(3.7,0),U,4)'=XMUCNT $P(^(0),U,4)=XMUCNT Q
 S ^XMB(3.7,0)="MAILBOX^3.7P^3^"_XMUCNT
 Q
USER(XMUSER,XMUKCNT,XMUECNT) ;
 ; XMUNCNT  # new msgs for a user
 ; XMUKECNT # msgs in a user's bskt
 ; XMUKNCNT # new msgs in a user's bskt
 N XMK,XMUKNCNT,XMUKECNT,XMUNCNT
 D BXREF(XMUSER)
 D N0XREF(XMUSER)
 S (XMK,XMUKCNT,XMUNCNT,XMUECNT)=0
 F  S XMK=$O(^XMB(3.7,XMUSER,2,XMK)) Q:XMK'>0  D
 . Q:XMK=.95
 . S XMUKCNT=XMUKCNT+1
 . D BSKT(XMUSER,XMK,.XMUKNCNT,.XMUKECNT)
 . S XMUNCNT=XMUNCNT+XMUKNCNT
 . S XMUECNT=XMUECNT+XMUKECNT
 S:$P($G(^XMB(3.7,XMUSER,0)),U,1)'=XMUSER $P(^(0),U,1)=XMUSER
 S:$P(^XMB(3.7,XMUSER,0),U,6)'=XMUNCNT $P(^(0),U,6)=XMUNCNT
 S:'$D(^XMB(3.7,"B",XMUSER,XMUSER)) ^XMB(3.7,"B",XMUSER,XMUSER)=""
 I $D(^XMB(3.7,XMUSER,2,0)) S:$P(^XMB(3.7,XMUSER,2,0),U,4)'=XMUKCNT $P(^(0),U,4)=XMUKCNT Q
 S ^XMB(3.7,XMUSER,2,0)="^3.701^"_$O(^XMB(3.7,XMUSER,2,"B"),-1)_U_XMUKCNT
 Q
BSKT(XMUSER,XMK,XMUKNCNT,XMUKECNT) ;
 N XMKN,XMKZ,XMZ,XMREC,XMRESEQ,XMKNAME
 S XMKNAME(1)=$$EZBLD^DIALOG(37005) ; IN
 S XMKNAME(.5)=$$EZBLD^DIALOG(37004) ; WASTE
 S XMKNAME("?")=$$EZBLD^DIALOG(34009) ; * No Name *
 D CXREF(XMUSER,XMK,.XMRESEQ)
 S (XMZ,XMUKNCNT,XMUKECNT)=0
 F  S XMZ=$O(^XMB(3.7,XMUSER,2,XMK,1,XMZ)) Q:XMZ'>0  D
 . S XMREC=^XMB(3.7,XMUSER,2,XMK,1,XMZ,0)
 . I $P(XMREC,U,1)'=XMZ D
 . . S $P(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0),U,1)=XMZ
 . . D ERR(103,XMUSER,XMK,XMZ) ; Msg in bskt, but no .01 field: .01 field created
 . I '$D(^XMB(3.9,XMZ,0)) D  Q
 . . D ERR(101,XMUSER,XMK,XMZ) ; Msg in bskt, but no msg: removed from bskt
 . . D ZAPIT^XMXMSGS2(XMUSER,XMK,XMZ)
 . S XMUKECNT=XMUKECNT+1
 . S XMKZ=$P(XMREC,U,2)
 . I XMKZ D
 . . I '$D(^XMB(3.7,XMUSER,2,XMK,1,"C",XMKZ,XMZ)) S ^(XMZ)="" D ERR(112,XMUSER,XMK,XMZ) ; Msg in bskt, but no C xref: xref created
 . E  D
 . . S XMKZ=$O(^XMB(3.7,XMUSER,2,XMK,1,"C",""),-1)+1
 . . S $P(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0),U,2)=XMKZ
 . . S ^XMB(3.7,XMUSER,2,XMK,1,"C",XMKZ,XMZ)=""
 . . D ERR(102,XMUSER,XMK,XMZ) ; Msg in bskt, but no seq #: seq # created
 . I '$D(^XMB(3.7,"M",XMZ,XMUSER,XMK,XMZ)) S ^(XMZ)="" D ERR(111,XMUSER,XMK,XMZ) ; Msg in bskt, but no M xref: xref created
 . ;I XMUSER=.5,XMK>999 Q
 . I $P(XMREC,U,3) D
 . . I XMK=.5 D  Q
 . . . D ERR(104,XMUSER,XMK,XMZ) ; New msg in WASTE bskt: msg made not new
 . . . S $P(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0),U,3)=""
 . . . K ^XMB(3.7,XMUSER,"N0",XMK,XMZ)
 . . S XMUKNCNT=XMUKNCNT+1
 . . I '$D(^XMB(3.7,XMUSER,"N0",XMK,XMZ)) S ^(XMZ)="" D ERR(113,XMUSER,XMK,XMZ) ; New msg, but no N0 xref: xref created
 I '$D(^XMB(3.7,XMUSER,2,XMK,0)) D
 . S XMKN=$G(XMKNAME(XMK),XMKNAME("?"))
 . S ^XMB(3.7,XMUSER,2,XMK,0)=XMKN
 . D ERR(131,XMUSER,XMK) ; No bskt 0 node: created
 E  D
 . S XMKN=$P(^XMB(3.7,XMUSER,2,XMK,0),U)
 . I XMKN="" D  Q
 . . S XMKN=$G(XMKNAME(XMK),XMKNAME("?"))
 . . S $P(^XMB(3.7,XMUSER,2,XMK,0),U)=XMKN
 . . D ERR(132,XMUSER,XMK) ; Bskt name null: created
 . Q:XMK>1
 . Q:'$D(XMKNAME(XMK))
 . Q:XMKN=XMKNAME(XMK)
 . N XMKNBAD
 . S XMKNBAD=XMKN
 . S XMKN=XMKNAME(XMK)
 . S $P(^XMB(3.7,XMUSER,2,XMK,0),U)=XMKN
 . K ^XMB(3.7,XMUSER,2,"B",XMKNBAD,XMK)
 . D ERR(134,XMUSER,XMK,"",XMKNBAD) ; Bskt name '|1|' wrong: corrected
 I '$D(^XMB(3.7,XMUSER,2,"B",$E(XMKN,1,30),XMK)) S ^(XMK)="" D ERR(141,XMUSER,XMK) ; Bskt name, but no B xref: xref created
 S:$P(^XMB(3.7,XMUSER,2,XMK,0),U,2)'=XMUKNCNT $P(^(0),U,2)=XMUKNCNT
 I $D(^XMB(3.7,XMUSER,2,XMK,1,0)) D
 . S:$P(^XMB(3.7,XMUSER,2,XMK,1,0),U,4)'=XMUKECNT $P(^(0),U,4)=XMUKECNT
 E  I XMUKECNT D
 . S ^XMB(3.7,XMUSER,2,XMK,1,0)="^3.702P^"_$O(^XMB(3.7,XMUSER,2,XMK,1,"C"),-1)_U_XMUKECNT
 . D ERR(133,XMUSER,XMK) ; No msg multiple 0 node: created
 Q:'$G(XMRESEQ)
 D RSEQ^XMXBSKT(XMUSER,XMK)
 D ERR(125,XMUSER,XMK) ; C xref duplicate seq #s: bskt reseq'd
 Q
CXREF(XMUSER,XMK,XMRESEQ) ; Check the bskt's C xref (msg seq numbers in bskt)
 N XMKZ,XMZ,XMCNT
 S XMKZ=0
 F  S XMKZ=$O(^XMB(3.7,XMUSER,2,XMK,1,"C",XMKZ)) Q:'XMKZ  D
 . S (XMZ,XMCNT)=0
 . F  S XMZ=$O(^XMB(3.7,XMUSER,2,XMK,1,"C",XMKZ,XMZ)) Q:'XMZ  D
 . . S XMCNT=XMCNT+1
 . . Q:$P($G(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0)),U,2)=XMKZ
 . . I '$D(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0)) D  Q
 . . . S ^XMB(3.7,XMUSER,2,XMK,1,XMZ,0)=XMZ_U_XMKZ
 . . . D ERR(122,XMUSER,XMK,XMZ) ; C xref, but msg not in bskt: put in bskt
 . . I $P(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0),U,2)="" D  Q
 . . . S $P(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0),U,2)=XMKZ
 . . . D ERR(123,XMUSER,XMK,XMZ) ; C xref, but no msg seq #: set seq # using xref
 . . K ^XMB(3.7,XMUSER,2,XMK,1,"C",XMKZ,XMZ)
 . . D ERR(124,XMUSER,XMK,XMZ) ; C xref does not match msg seq #: xref killed
 . S:XMCNT>1 XMRESEQ=1
 Q
N0XREF(XMUSER) ; Check the user's N0 xref (new msgs)
 N XMK,XMZ
 S XMK=0
 F  S XMK=$O(^XMB(3.7,XMUSER,"N0",XMK)) Q:'XMK  D
 . S XMZ=0
 . F  S XMZ=$O(^XMB(3.7,XMUSER,"N0",XMK,XMZ)) Q:'XMZ  D
 . . Q:$P($G(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0)),U,3)=1
 . . I '$D(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0)) D  Q
 . . . S ^XMB(3.7,XMUSER,2,XMK,1,XMZ,0)=XMZ_"^^1"
 . . . D ERR(126,XMUSER,XMK,XMZ) ; N0 xref, but msg not in bskt: msg put in bskt
 . . S $P(^XMB(3.7,XMUSER,2,XMK,1,XMZ,0),U,3)=1
 . . D ERR(127,XMUSER,XMK,XMZ) ; N0 xref, but msg not new: new flag set
 Q
BXREF(XMUSER) ; Check the user's B xref (bskt names)
 N XMK,XMKN
 S XMKN=""
 F  S XMKN=$O(^XMB(3.7,XMUSER,2,"B",XMKN)) Q:XMKN=""  D
 . S XMK=0
 . F  S XMK=$O(^XMB(3.7,XMUSER,2,"B",XMKN,XMK)) Q:'XMK  D
 . . Q:$E($P($G(^XMB(3.7,XMUSER,2,XMK,0)),U),1,30)=XMKN
 . . I $D(^XMB(3.7,XMUSER,2,XMK,0)) D  Q
 . . . I $P($G(^XMB(3.7,XMUSER,2,XMK,0)),U)="" D  Q
 . . . . S $P(^XMB(3.7,XMUSER,2,XMK,0),U)=XMKN
 . . . . D ERR(151,XMUSER,XMK) ; B xref, but bskt name null: name set using xref
 . . . D ERR(153,XMUSER,XMK) ; B xref does not match bskt name: xref killed
 . . . K ^XMB(3.7,XMUSER,2,"B",XMKN,XMK)
 . . S $P(^XMB(3.7,XMUSER,2,XMK,0),U)=XMKN
 . . D ERR(152,XMUSER,XMK) ; B xref, but no bskt node: node set using xref
 Q
ERR(XMERRNUM,XMUSER,XMK,XMZ,XMDPARM) ;
 S XMERROR(XMERRNUM)=$G(XMERROR(XMERRNUM))+1
 Q:$D(ZTQUEUED)
 N XMPARM
 S XMPARM(1)=XMUSER,XMPARM(2)=XMK,XMPARM(3)=XMERRNUM
 S XMPARM(4)=$$EZBLD^DIALOG(36000+XMERRNUM,.XMDPARM)
 ;DUZ=|1|, Bskt=|2|$S($G(XMZ):", Msg=|5|",1:""), Err=|3| |4|
 I $G(XMZ) S XMPARM(5)=XMZ W !,$$EZBLD^DIALOG(36099,.XMPARM) Q
 W !,$$EZBLD^DIALOG(36098,.XMPARM)
 Q
 ;34009     * No Name *
 ;37004     WASTE
 ;37005     IN
 ;36098     DUZ=|1|, Bskt=|2|, Err=|3| |4|
 ;36099     DUZ=|1|, Bskt=|2|, Msg=|5|, Err=|3| |4|
 ;36101     Msg in bskt, but no msg: removed from bskt
 ;36102     Msg in bskt, but no seq #: seq # created
 ;36103     Msg in bskt, but no .01 field: .01 field
 ;36104     New msg in WASTE bskt: msg made not new
 ;36111     Msg in bskt, but no M xref: xref created
 ;36112     Msg in bskt, but no C xref: xref created
 ;36113     New msg, but no N0 xref: xref created
 ;36122     C xref, but msg not in bskt: put in bskt
 ;36123     C xref, but no msg seq #: set seq # using
 ;36124     C xref does not match msg seq #: xref kill
 ;36125     C xref duplicate seq #s: bskt reseq'd
 ;36126     N0 xref, but msg not in bskt: msg put in
 ;36127     N0 xref, but msg not new: new flag set
 ;36131     No bskt 0 node: created
 ;36132     Bskt name null: created
 ;36133     No msg multiple 0 node: created
 ;36134     Bskt name '|1|' wrong: corrected
 ;36141     Bskt name, but no B xref: xref created
 ;36151     B xref, but bskt name null: name set using
 ;36152     B xref, but no bskt node: node set using
 ;36153     B xref does not match bskt name: xref kill
