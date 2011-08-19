IBDX41 ; COMPILED XREF FOR FILE #357.4 ; 10/15/04
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^IBE(357.4,DA,0))
 S X=$P(DIKZ(0),U,2)
 I X'="" I $P($G(^IBE(357.4,DA,0)),U,3) K ^IBE(357.4,"APO",$P(^(0),U,3),X,DA)
 S X=$P(DIKZ(0),U,3)
 I X'="" K ^IBE(357.4,"D",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,3)
 I X'="" I $P($G(^IBE(357.4,DA,0)),U,2)]"" K ^IBE(357.4,"APO",X,$P(^(0),U,2),DA)
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^IBE(357.4,"B",$E(X,1,30),DA)
END Q
