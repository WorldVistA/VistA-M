YSXRAS1 ; COMPILED XREF FOR FILE #618.2 ; 10/15/04
 ; 
 S DIKZK=2
 S DIKZ(1)=$G(^YSG("SUB",DA,1))
 S X=$P(DIKZ(1),U,1)
 I X'="" K ^YSG("SUB","AWD",$E(X,1,30),DA)
 S X=$P(DIKZ(1),U,2)
 I X'="" K ^YSG("SUB","C",$E(X,1,30),DA)
 S X=$P(DIKZ(1),U,6)
 I X'="" K ^YSG("SUB","AOR",$P(^YSG("SUB",DA,1),U),X,DA)
 S DIKZ(0)=$G(^YSG("SUB",DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^YSG("SUB","B",$E(X,1,30),DA)
END Q
