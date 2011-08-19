XMXBSKT ;ISC-SF/GMB-Basket APIs ;03/25/2003  14:55
 ;;8.0;MailMan;**16**;Jun 28, 2002
CRE8BSKT(XMDUZ,XMKN,XMK) ; Routine creates basket, given name, and
 ; returns basket number.
 K XMERR,^TMP("XMERR",$J)
 I XMDUZ=.6,'$$POSTPRIV^XMXSEC Q
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC Q
 S XMK=$$FIND1^DIC(3.701,","_XMDUZ_",","X",XMKN)
 I XMK D  Q
 .; (It might be better if used an index which was the upper case of
 .;  the basket name, and if we checked for upper case of XMKN)
 . D ERRSET^XMXUTIL(37201.3,XMKN) ; Basket '_XMKN_' already exists.
 I XMDUZ=.5 D  Q:$G(XMERR)
 . N I,XMK
 . S XMK=.99
 . F I=1:1 S XMK=$O(^XMB(3.7,.5,2,XMK)) Q:XMK>999!'XMK
 . Q:I<999
 . D ERRSET^XMXUTIL(38113.1) ; Postmaster may not have more than 999 baskets.  (>999=Network msg queues)
 ;D VAL^DIE(3.701,"1,"_XMDUZ_",",.01,"H",XMKN) ; validate the name
 D MAKEBSKT(XMDUZ,.XMK,XMKN)
 Q
MAKEBSKT(XMDUZ,XMK,XMKN) ; Create a basket (For internal MM use only)
 ; If you give it an XMK, it'll put it there,
 ; else, it'll find a vacant XMK.
 N XMFDA,XMIEN,XMTRIES
 I 'XMK F XMK=2:1 Q:'$D(^XMB(3.7,XMDUZ,2,XMK))  ; Find 1st vacant bskt #
 S XMFDA(3.701,"+1,"_XMDUZ_",",.01)=XMKN
 S XMIEN(1)=XMK
MTRY D UPDATE^DIE("S","XMFDA","XMIEN") Q:'$D(DIERR)
 S XMTRIES=$G(XMTRIES)+1
 I $D(^TMP("DIERR",$J,"E",110)) H 1 G MTRY ; Try again if can't lock
 Q
DELBSKT(XMDUZ,XMK,XMFLAGS) ;
 ; XMK      Basket IEN
 N XMNEW
 K XMERR,^TMP("XMERR",$J)
 I XMDUZ=.6,'$$POSTPRIV^XMXSEC Q
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC Q
 I XMK'>1 D  Q
 . D ERRSET^XMXUTIL(37215.2,$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)) ; The '_IN/WASTE_' basket may not be deleted.
 I $G(XMFLAGS)'["D",$$BMSGCT^XMXUTIL(XMDUZ,XMK)>0 D  Q
 . D ERRSET^XMXUTIL(37215.4,$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)) ; The '_x_' basket may not be deleted, because it still has messages in it.
 S XMNEW=$$BNMSGCT^XMXUTIL(XMDUZ,XMK)
 L +^XMB(3.7,XMDUZ):1
 S:XMNEW $P(^(0),U,6)=$P(^XMB(3.7,XMDUZ,0),U,6)-XMNEW
 N XMFDA
 S XMFDA(3.701,XMK_","_XMDUZ_",",.01)="@"
 D FILE^DIE("","XMFDA")
 L -^XMB(3.7,XMDUZ)
 Q
LISTBSKT(XMDUZ,XMFLAGS,XMAMT,XMSTART,XMPART,XMTROOT) ;
 N XMORDER,XMI,XMCNT,XMK,XMKREC,XMSCREEN,XMFMFLAG
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC Q
 I $D(XMTROOT),XMTROOT'="" D
 . K @$$CREF^DILF(XMTROOT)
 . S XMTROOT=$$OREF^DILF(XMTROOT)_"""XMLIST"","
 E  D
 . K ^TMP("XMLIST",$J)
 . S XMTROOT="^TMP(""XMLIST"",$J,"
 I $G(XMFLAGS)["N" S XMSCREEN="I $P(^(0),U,2)" ; Only baskets w/new msgs
 E  S XMSCREEN=""
 S XMFMFLAG="I"
 I $G(XMFLAGS)["B" S XMFMFLAG=XMFMFLAG_"B"
 D LIST^DIC(3.701,","_XMDUZ_",","",XMFMFLAG,.XMAMT,.XMSTART,.XMPART,"",XMSCREEN)
 S @(XMTROOT_"0)")=^TMP("DILIST",$J,0)
 S XMORDER=$S($G(XMFLAGS)["B":-1,1:1)
 S XMCNT=0,XMI=""
 F  S XMI=$O(^TMP("DILIST",$J,2,XMI),XMORDER) Q:'XMI  S XMK=^(XMI) D
 . S XMCNT=XMCNT+1
 . S XMKREC=^XMB(3.7,XMDUZ,2,XMK,0)
 . S @(XMTROOT_XMCNT_")")=XMK_U_$P(XMKREC,U,1)_U_$$BMSGCT^XMXUTIL(XMDUZ,XMK)_U_+$P(XMKREC,U,2) ; basket ien^basket name^# msgs^# new msgs
 . I '$G(XMAMT) S @(XMTROOT_"""BSKT"",$$UP^XLFSTR($P(XMKREC,U,1)),"_XMCNT_")")=""
 K ^TMP("DILIST",$J)
 Q
NAMEBSKT(XMDUZ,XMK,XMKN) ;
 ; XMK      Basket IEN
 ; XMKN     New basket name
 K XMERR,^TMP("XMERR",$J)
 I XMDUZ=.6,'$$POSTPRIV^XMXSEC Q
 I XMDUZ'=DUZ,'$$WPRIV^XMXSEC  Q
 I XMK'>1!(XMDUZ=.5&(XMK>999)) D  Q
 . D ERRSET^XMXUTIL(37201.2,$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)) ; The '_x_' basket name may not be changed.
 N XMFDA
 S XMFDA(3.701,XMK_","_XMDUZ_",",.01)=XMKN
 D FILE^DIE("","XMFDA")
 Q
QBSKT(XMDUZ,XMK,XMMSG) ; Message counts for a mail basket
 N XMKREC
 K XMERR,^TMP("XMERR",$J)
 S XMMSG=""
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC  Q
 S XMKREC=^XMB(3.7,XMDUZ,2,XMK,0)
 S XMMSG=XMK_U_$P(XMKREC,U,1)_U_$$BMSGCT^XMXUTIL(XMDUZ,XMK)_U_+$P(XMKREC,U,2) ; basket ien^basket name^# msgs^# new msgs
 Q
RSEQBSKT(XMDUZ,XMK,XMMSG) ; Resequence message numbers
 ; XMZ      - Unique message number
 ; XMK      - basket number
 ; XMKZ     - Message number in basket
 ; XMKZCNT  - Number of messages in basket
 N XMKZCNT,XMERROR  ; (XMERROR is set in XMUT4)
 K XMERR,^TMP("XMERR",$J)
 S XMMSG=""
 ;I XMDUZ=.6,'$$POSTPRIV^XMXSEC Q  ; Shouldn't need special privileges.
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC  Q
 D BSKT^XMUT4(XMDUZ,XMK)     ; Basket integrity check
 D RSEQ(XMDUZ,XMK,.XMKZCNT)  ; resequence
 S XMMSG=$$EZBLD^DIALOG(37212.9,XMKZCNT) ; Resequenced from 1 to _XMKZCNT.
 Q
RSEQ(XMDUZ,XMK,XMKZNEW) ; Internal MailMan entry point to resequence a basket
 ; *** IN create date/xmz SEQUENCE ***
 N XMKZ,XMZ,XMFDA,XMCRE8DT
 K ^TMP("XM",$J,"RSEQ")
 S XMZ=0
 F  S XMZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,XMZ)) Q:XMZ'>0  S ^TMP("XM",$J,"RSEQ",+$P($G(^XMB(3.9,XMZ,.6)),U),XMZ)=""
 S XMKZNEW=0,(XMCRE8DT,XMZ)=""
 F  S XMCRE8DT=$O(^TMP("XM",$J,"RSEQ",XMCRE8DT)) Q:XMCRE8DT=""  D  Q:$D(XMERR)
 . F  S XMZ=$O(^TMP("XM",$J,"RSEQ",XMCRE8DT,XMZ)) Q:'XMZ  D  Q:$D(XMERR)
 . . S XMKZ=$P($G(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)),U,2) Q:'XMKZ
 . . S XMKZNEW=XMKZNEW+1
 . . Q:XMKZ=XMKZNEW
 . . S XMFDA(3.702,XMZ_","_XMK_","_XMDUZ_",",2)=XMKZNEW
 . . D FILE^DIE("","XMFDA") I $D(DIERR) D ERRSET^XMXUTIL(37212.8,$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)) ; Error resequencing the '_x_' basket.
 K ^TMP("XM",$J,"RSEQ")
 Q:$D(XMERR)
 S:+$P($G(^XMB(3.7,XMDUZ,2,XMK,1,0)),U,4)'=XMKZNEW $P(^(0),U,4)=XMKZNEW
 Q
XRSEQ(XMDUZ,XMK,XMKZNEW) ; Internal MailMan entry point to resequence a basket
 ; *** IN XMKZ SEQUENCE ***
 N XMKZ,XMZ,XMFDA
 S (XMKZ,XMKZNEW)=0
 F  S XMKZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,"C",XMKZ)) Q:XMKZ'>0  D  Q:$D(XMERR)
 . I XMKZ'>XMKZNEW S XMKZNEW=XMKZ-1
 . S XMZ=0
 . F  S XMZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,"C",XMKZ,XMZ)) Q:XMZ'>0  D  Q:$D(XMERR)
 . . S XMKZNEW=XMKZNEW+1
 . . Q:XMKZ=XMKZNEW
 . . S XMFDA(3.702,XMZ_","_XMK_","_XMDUZ_",",2)=XMKZNEW
 . . D FILE^DIE("","XMFDA") I $D(DIERR) D ERRSET^XMXUTIL(37212.8,$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)) ; Error resequencing the '_x_' basket.
 Q:$D(XMERR)
 S:+$P($G(^XMB(3.7,XMDUZ,2,XMK,1,0)),U,4)'=XMKZNEW $P(^(0),U,4)=XMKZNEW
 Q
FLTRBSKT(XMDUZ,XMK,XMMSG) ; Filter a basket
 ; XMZ      - Unique message number
 ; XMK      - basket number
 K XMERR,^TMP("XMERR",$J)
 S XMMSG=""
 I XMDUZ=.6,'$$POSTPRIV^XMXSEC Q
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC Q
 I XMK'=.5,'$D(^XMB(3.7,XMDUZ,15,"AF")) D  Q
 . D ERRSET^XMXUTIL($S(XMDUZ=DUZ:37204.1,1:37204.2),XMV("NAME")) ; You have / x has no message filters defined.
 I XMDUZ=.5,XMK>1000 D  Q
 . D ERRSET^XMXUTIL(37251) ; You may not do this with messages in the transmit queues.
 N XMZ,XMKN
 S XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)
 S XMZ=0
 F  S XMZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,XMZ)) Q:XMZ'>0  D FLTR^XMXMSGS2(XMDUZ,XMK,XMKN,XMZ)
 S XMMSG=$$EZBLD^DIALOG(34306.2) ; Basket filtered.
 Q
