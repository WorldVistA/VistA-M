YSXRAV1 ; COMPILED XREF FOR FILE #625 ; 10/15/04
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^DIC(625,DA,0))
 S X=$P(DIKZ(0),U,2)
 I X'="" K ^DIC(625,"A",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,2)
 I X'="" K ^DIC(625,"E",$E(X,1,30),DA)
 S DIKZ(1)=$G(^DIC(625,DA,1))
 S X=$P(DIKZ(1),U,1)
 I X'="" X ^DD(625,2,1,1,2)
 S DIKZ(0)=$G(^DIC(625,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^DIC(625,"B",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,1)
 I X'="" X ^DD(625,.01,1,2,2)
END Q
