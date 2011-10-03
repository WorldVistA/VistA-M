XMUT4C ;ISC-SF/GMB-Integrity Checker for file 3.9 ;04/19/2002  13:00
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
MESSAGE(XMABORT) ;
 N XMZ,XMCNT,XMZREC,XMCRE8
 W !!,$$EZBLD^DIALOG(36094),! ; Checking MESSAGE file 3.9
 F  S XMZ=$O(^XMB(3.9,":"),-1) Q:XMZ?1N.N  D BOGUS(XMZ)
 S (XMZ,XMCNT)=0
 F  S XMZ=$O(^XMB(3.9,XMZ)) Q:XMZ'>0  D  Q:XMABORT
 . I XMZ'?1N.N D BOGUS(XMZ) Q
 . S XMCNT=XMCNT+1 I XMCNT#5000=0 D  Q:XMABORT
 . . I '$D(ZTQUEUED) W:$X>40 ! W XMCNT,"." Q
 . . I $$S^%ZTLOAD S (XMABORT,ZTSTOP)=1 ; User asked the task to stop
 . S XMZREC=$G(^XMB(3.9,XMZ,0))
 . I "^^^^^^^^"[XMZREC D
 . . D ERR(XMZ,201) ; Msg has bad/no 0 node: not fixed
 . E  D
 . . D SUBJ(XMZ,XMZREC)
 . . I $P(XMZREC,U,2)="" D
 . . . S $P(^XMB(3.9,XMZ,0),U,2)=$$EZBLD^DIALOG(34009) ;* No Name *
 . . . D ERR(XMZ,206) ; Msg has no sender: fixed
 . . I $P(XMZREC,U,3)="" D
 . . . S $P(^XMB(3.9,XMZ,0),U,3)=DT
 . . . D ERR(XMZ,207) ; Msg has no date/time: fixed
 . D CRE8DT(XMZ,$P(XMZREC,U,3))
 . D RESP(XMZ,XMZREC)
 . D:$D(^XMB(3.9,XMZ,1)) RECIP(XMZ)
 Q:XMABORT
 W !!,$$EZBLD^DIALOG(36093,XMCNT) ; |1| messages in the MESSAGE file 3.9
 I XMCNT=$P(^XMB(3.9,0),U,4) W !,$$EZBLD^DIALOG(36095) Q  ; Zero node is OK
 L +^XMB(3.9,0):1
 S $P(^XMB(3.9,0),U,4)=XMCNT
 L -^XMB(3.9,0)
 W !,$$EZBLD^DIALOG(36096) ; I reset the zero node.
 Q
BOGUS(XMZ) ;
 D ERR(XMZ,210) ; Msg IEN is corrupted: fixed
 I $L($P($G(^XMB(3.9,XMZ,0)),U,1)) K ^XMB(3.9,"B",$E($P(^XMB(3.9,XMZ,0),U,1),1,30),XMZ)
 K ^XMB(3.9,"C",+$P($G(^XMB(3.9,XMZ,.6)),U,1),XMZ)
 K ^XMB(3.9,XMZ)
 Q
SUBJ(XMZ,XMZREC) ;
 N XMSUBJ
 S XMSUBJ=$P(XMZREC,U)
 I XMSUBJ="" D
 . S XMSUBJ=$$EZBLD^DIALOG(34012) ;* No Subject *
 . S $P(^XMB(3.9,XMZ,0),U,1)=XMSUBJ
 . S ^XMB(3.9,"B",XMSUBJ,XMZ)=""
 . D ERR(XMZ,202) ; Msg has no subject: fixed
 I '$D(^XMB(3.9,"B",$E(XMSUBJ,1,30),XMZ)) D
 . I $L(XMSUBJ)>30,$D(^XMB(3.9,"B",XMSUBJ,XMZ)) D
 . . K ^XMB(3.9,"B",XMSUBJ,XMZ)
 . . D ERR(XMZ,205) ; Subject B xref too long: xref shortened
 . E  D ERR(XMZ,204) ; Subject has no B xref: xref created
 . S ^XMB(3.9,"B",$E(XMSUBJ,1,30),XMZ)=""
 I $L(XMSUBJ)<3!($L(XMSUBJ)>65) D
 . D ERR(XMZ,203) ; Msg subject <3 or >65: fixed
 . S XMSUBJ=$S($L(XMSUBJ)<3:XMSUBJ_"...",1:$E(XMSUBJ,1,65))
 . N XMFDA
 . S XMFDA(3.9,XMZ_",",.01)=XMSUBJ
 . D FILE^DIE("","XMFDA")
 Q
RESP(XMZ,XMZREC) ;
 N XMZO
 I $P(XMZREC,U,8) D  Q
 . S XMZO=$P(XMZREC,U,8)
 . I XMZO=XMZ D  Q
 . . D ERR(XMZ,211) ; Message thinks it's a response to itself: fixed
 . . S $P(^XMB(3.9,XMZ,0),U,8)=""
 . I '$D(^XMB(3.9,XMZO,0)) D  Q
 . . D ERR(XMZ,212,XMZO) ; No original message |1| for this response: fixed
 . . S $P(^XMB(3.9,XMZ,0),U,8)=""
 . I $$ATTACHED(XMZO,XMZ) Q
 . D ERR(XMZ,213,XMZO) ; Not in response chain of |1|: fixed
 . S $P(^XMB(3.9,XMZ,0),U,8)=""
 N XMSUBJ
 S XMSUBJ=$P(XMZREC,U)
 Q:XMSUBJ'?1"R"1.N
 Q:$P(XMZREC,U,2)["@"
 S XMZO=+$E(XMSUBJ,2,99)
 I '$D(^XMB(3.9,XMZO,0)) D  Q
 . D ERR(XMZ,216,XMZO) ; No original message |1| for this response: not fixed
 I '$$ATTACHED(XMZO,XMZ) D  Q
 . D ERR(XMZ,217,XMZO) ; Not in response chain of |1|: not fixed
 D ERR(XMZ,218,XMZO) ; Piece 8 didn't point to original message |1|: fixed
 S $P(^XMB(3.9,XMZ,0),U,8)=XMZO
 Q
ATTACHED(XMZO,XMZ) ; Is XMZ in the response chain of XMZO?
 N I
 S I=0
 F  S I=$O(^XMB(3.9,XMZO,3,I)) Q:'I  Q:$P($G(^(I,0)),U)=XMZ
 Q +I
CRE8DT(XMZ,XMDATE) ;
 S XMCRE8=$P($G(^XMB(3.9,XMZ,.6)),U,1)
 I 'XMCRE8 D  Q
 . I $P(XMDATE,".",1)?7N S XMDATE=$P(XMDATE,".",1)
 . E  I XMDATE="" S XMDATE=DT
 . E  D
 . . S XMDATE=$$CONVERT^XMXUTIL1(XMDATE)
 . . S:XMDATE=-1 XMDATE=DT
 . S $P(^XMB(3.9,XMZ,.6),U,1)=XMDATE
 . S ^XMB(3.9,"C",XMDATE,XMZ)=""
 . D ERR(XMZ,208) ; Msg has no local create date: fixed
 I '$D(^XMB(3.9,"C",XMCRE8,XMZ)) D
 . S ^XMB(3.9,"C",XMCRE8,XMZ)=""
 . D ERR(XMZ,209) ; Local create date C xref missing: fixed
 Q
RECIP(XMZ) ; Check recipient multiple
 N I,XMVAL,XMXREF,XMRECIPS
 D CXREF(XMZ)
 S (I,XMRECIPS)=0
 F  S I=$O(^XMB(3.9,XMZ,1,I)) Q:'I  D
 . S XMVAL=$P($G(^XMB(3.9,XMZ,1,I,0)),U)
 . I XMVAL="" D  Q
 . . Q:$P(^XMB(3.9,XMZ,.6),U,1)=DT
 . . K ^XMB(3.9,XMZ,1,I)
 . . D ERR(XMZ,221,I) ; Recipient |1| null, no C xref: fixed
 . S XMRECIPS=XMRECIPS+1
 . Q:$D(^XMB(3.9,XMZ,1,"C",$E(XMVAL,1,30),I))
 . I $L(XMVAL)>30,$D(^XMB(3.9,XMZ,1,"C",XMVAL,I)) D  Q
 . . ;K ^XMB(3.9,XMZ,1,"C",XMVAL,I)
 . . ;D ERR(XMZ,223,I) ; Recipient |1| C xref too long: xref shortened
 . . ;S ^XMB(3.9,XMZ,1,"C",$E(XMVAL,1,30),I)=""
 . D ERR(XMZ,222,I) ; Recipient |1| no C xref: xref created
 . S ^XMB(3.9,XMZ,1,"C",$E(XMVAL,1,30),I)=""
 I $D(^XMB(3.9,XMZ,1,0)) S:$P(^XMB(3.9,XMZ,1,0),U,4)'=XMRECIPS $P(^(0),U,4)=XMRECIPS Q
 S ^XMB(3.9,XMZ,1,0)="^3.91A^"_I_U_XMRECIPS
 Q
CXREF(XMZ) ; Check C xref for Recipient multiple
 N I,XMVAL,XMXREF
 S (I,XMXREF)=""
 F  S XMXREF=$O(^XMB(3.9,XMZ,1,"C",XMXREF)) Q:XMXREF=""  D
 . F  S I=$O(^XMB(3.9,XMZ,1,"C",XMXREF,I)) Q:'I  D
 . . S XMVAL=$P($G(^XMB(3.9,XMZ,1,I,0)),U)
 . . Q:$E(XMVAL,1,30)=$E(XMXREF,1,30)
 . . I XMVAL="" D  Q
 . . . S $P(^XMB(3.9,XMZ,1,I,0),U)=XMXREF
 . . . I $L(XMXREF)<30 D ERR(XMZ,231,I) Q  ; C xref, but recip |1| null: fixed using xref
 . . . D ERR(XMZ,232,I) ; C xref, but recip |1| null: fixed, but CHECK
 . . K ^XMB(3.9,XMZ,1,"C",XMXREF,I)
 . . D ERR(XMZ,233,I) ; C xref for recip |1| doesn't match recip: xref killed
 Q
ERR(XMZ,XMERRNUM,XMDPARM) ;
 N XMPARM
 S XMERROR(XMERRNUM)=$G(XMERROR(XMERRNUM))+1
 S XMPARM(1)=XMZ,XMPARM(2)=$J(XMERRNUM,3)
 S XMPARM(3)=$$EZBLD^DIALOG(36300+XMERRNUM,.XMDPARM)
 W !,$$EZBLD^DIALOG(36097,.XMPARM) ;Msg=|1|, Err=|2| |3|
 Q
