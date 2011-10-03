IBDX42 ; COMPILED XREF FOR FILE #357.4 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^IBE(357.4,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^IBE(357.4,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" I $P($G(^IBE(357.4,DA,0)),U,3) S ^IBE(357.4,"APO",$P(^(0),U,3),X,DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^IBE(357.4,"D",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" I $P($G(^IBE(357.4,DA,0)),U,2)]"" S ^IBE(357.4,"APO",X,$P(^(0),U,2),DA)=""
END Q
