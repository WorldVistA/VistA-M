XMUT5B ;(WASH ISC)/CAP-Gather Delivery Queue Data ;04/17/2002  12:05
 ;;8.0;MailMan;;Jun 28, 2002
 ;;XX.XX
 ;
 ;M("O") & R("O") = #items ^ timestamp of oldest ^ #deliveries
 ;M("T") & R("T") = same as "O" above except for all messages/responses
GO ;S X="USERY^XMUT5B",@^%ZOSF("TRAP"),X=$ZC(%SPAWN,"SUBMIT/QUE=FORUM7_BATCH LEEUSER.COM")
GP ;
 N I,XMFWD
 S XMFWD=$$EZBLD^DIALOG(36223) ; (f)
 S M("T")=0
 F I=1:1:10 S M("O",I)=0 I $D(^XMBPOST("M",I)) D Q("M",.M,I)
 S R("T")=0
 F I=1:1:10 S R("O",I)=0 I $D(^XMBPOST("R",I)) D Q("R",.R,I)
 Q
Q(XMGROUP,XMQ,I) ;
 N XMREC,XMTSTAMP,XMZ
 S XMREC=$G(^XMBPOST(XMGROUP,I)),XMTSTAMP=$O(^(I,0)) S XMZ=$S(XMTSTAMP:$O(^(XMTSTAMP,"")),1:"")
 I XMGROUP="M",XMZ D
 . I XMZ[U S XMZ=$P(XMZ,U,1)_U_XMFWD ; if [U, then it's a forward
 . E  S XMZ=XMZ_U
 . S XMZ=XMZ_U_$O(^XMB(3.7,"M",$P(XMZ,U,1),""),-1) ; latest delivery
 S XMQ("O",I)=+XMREC_U_XMTSTAMP_U_$P(XMREC,U,2)_U_XMZ
 Q:'XMREC
 S $P(XMQ("T"),U)=$P(XMQ("T"),U)+XMREC,$P(XMQ("T"),U,3)=$P(XMQ("T"),U,3)+$P(XMREC,U,2)
 I $S('$P(XMQ("T"),U,2):1,$P(XMQ("T"),U,2)>XMTSTAMP:1,1:0) S $P(XMQ("T"),U,2)=XMTSTAMP
 Q
USERS(%) ;Get the number of ZSLOT users
 ;%=1 do not display output, %=0 display
 N X,A,B,C,Y,Z,ZSLOTDSP S ZSLOTDSP=%
 ;
 ;First -- is the ZSLOT software installed ?
 S X="ZSLOT" X ^%ZOSF("TEST") E  S %=0 G USERQ
 ;
 ;Call ZSLOT for count of ZSLOT users
 S %="N/A" I $T(ENTCLUST^ZSLOT)'="" D ENTCLUST^ZSLOT S %=Y
USERQ Q %
