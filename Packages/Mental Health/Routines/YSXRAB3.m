YSXRAB3 ; COMPILED XREF FOR FILE #601 ; 03/13/23
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^YTT(601,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^YTT(601,"B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S ^YTT(601,"AI",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S ^YTT(601,"ATN",X,$P(^YTT(601,DA,0),U,1),DA)=""
 S X=$P($G(DIKZ(0)),U,10)
 I X'="" S ^YTT(601,"AE",$E(X,1,30),DA)=""
END G ^YSXRAB4
