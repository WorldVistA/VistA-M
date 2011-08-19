RTXP2 ; COMPILED XREF FOR FILE #194.2 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^RTV(194.2,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^RTV(194.2,"B",$E(X,1,45),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^RTV(194.2,"C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,15)
 I X'="" S ^RTV(194.2,"AC",$E(X,1,30),DA)=""
END Q
