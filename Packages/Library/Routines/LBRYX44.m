LBRYX44 ; COMPILED XREF FOR FILE #682.1 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^LBRY(682.1,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^LBRY(682.1,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^LBRY(682.1,"C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S:$P($G(^LBRY(682.1,DA,0)),U,3)'="" ^LBRY(682.1,"AA",$E($P(^LBRY(682.1,DA,0),U,3),1,30),$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^LBRY(682.1,"AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" S:$P($G(^LBRY(682.1,DA,0)),U,2)'="" ^LBRY(682.1,"AA",$E(X,1,30),$E($P(^LBRY(682.1,DA,0),U,2),1,30),DA)=""
 S DIKZ(1)=$G(^LBRY(682.1,DA,1))
 S X=$P(DIKZ(1),U,1)
 I X'="" S ^LBRY(682.1,"AD",$E(X,1,30),DA)=""
END G ^LBRYX45
