IBDX31 ; COMPILED XREF FOR FILE #357.3 ; 10/15/04
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^IBE(357.3,DA,0))
 S X=$P(DIKZ(0),U,3)
 I X'="" K ^IBE(357.3,"C",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,3)
 I X'="" I $P($G(^IBE(357.3,DA,0)),U,5)]"",$P(^(0),U,4) K ^IBE(357.3,"APO",X,$P(^(0),U,4),$P(^(0),U,5),DA)
 S X=$P(DIKZ(0),U,4)
 I X'="" K ^IBE(357.3,"D",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,4)
 I X'="" I $P($G(^IBE(357.3,DA,0)),U,5)]"",$P(^(0),U,3) K ^IBE(357.3,"APO",$P(^(0),U,3),X,$P(^(0),U,5),DA)
 S X=$P(DIKZ(0),U,5)
 I X'="" I $P($G(^IBE(357.3,DA,0)),U,3),$P(^(0),U,4) K ^IBE(357.3,"APO",$P(^(0),U,3),$P(^(0),U,4),X,DA)
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^IBE(357.3,"B",$E(X,1,30),DA)
END G ^IBDX32
