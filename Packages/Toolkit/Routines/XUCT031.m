XUCT031 ; COMPILED XREF FOR FILE #3.081 ; 08/15/16
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^XUSEC(0,DA,0))
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" K ^XUSEC(0,"AS1",$P(X,":"),DA)
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" N % S %=^XUSEC(0,DA,0) K ^XUSEC(0,"AS3",$P(%,U),$P(X,":"),DA)
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" K ^XUSEC(0,"AS2",$P(X,":"),DA)
 S DIKZ(1)=$G(^XUSEC(0,DA,1))
 S X=$P($G(DIKZ(1)),U,1)
 I X'="" K ^XUSEC(0,"AS4",X,DA)
 S X=$P($G(DIKZ(1)),U,1)
 I X'="" N % S %=^XUSEC(0,DA,0) K ^XUSEC(0,"AS5",$P(%,U),X,DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^XUSEC(0,"CUR",$E(X,1,30),DA)
END Q
