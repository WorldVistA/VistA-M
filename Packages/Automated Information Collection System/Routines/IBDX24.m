IBDX24 ; COMPILED XREF FOR FILE #357.2 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^IBE(357.2,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^IBE(357.2,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^IBE(357.2,"C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,11)
 I X'="" S:X $P(^IBE(357.2,DA,0),U,14)=+$P($G(^IBE(357.6,X,0)),U,14) S:$P(^IBE(357.2,DA,0),U,14)&$P(^IBE(357.2,DA,0),U,2) ^IBE(357.2,"AD",$P(^IBE(357.2,DA,0),U,2),DA)=""
 S X=$P(DIKZ(0),U,14)
 I X'="" S:X&$P($G(^IBE(357.2,DA,0)),U,2) ^IBE(357.2,"AD",$P($G(^IBE(357.2,DA,0)),U,2),DA)=""
END G ^IBDX25
