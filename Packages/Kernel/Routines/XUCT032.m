XUCT032 ; COMPILED XREF FOR FILE #3.081 ; 02/11/20
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^XUSEC(0,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^XUSEC(0,"CUR",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" K ^XUSEC(0,"CUR",+^XUSEC(0,DA,0),DA)
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" N %,Y S %=^XUSEC(0,DA,0) K:$L($P(%,U,11)) ^XUSEC(0,"AS1",$P($P(%,U,11),":"),DA) K:$L($P(%,U,12)) ^XUSEC(0,"AS2",$P($P(%,U,12),":"),DA) S Y=$G(^XUSEC(0,DA,1)) K:$L($P(Y,U)) ^XUSEC(0,"AS4",$P(Y,U),DA)
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" N %,Y S %=^XUSEC(0,DA,0) I $L($P(%,U,11)) K ^XUSEC(0,"AS3",$P(%,U),$P($P(%,U,11),":"),DA) S Y=$G(^XUSEC(0,DA,1)) K:$L($P(Y,U)) ^XUSEC(0,"AS5",$P(%,U),$P(Y,U),DA)
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" S ^XUSEC(0,"ALDEV",X)=+^XUSEC(0,DA,0)
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" S:'$P(^XUSEC(0,DA,0),U,4) ^XUSEC(0,"AS1",$P(X,":"),DA)=""
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" N % S %=^XUSEC(0,DA,0) I '$P(%,U,4) S ^XUSEC(0,"AS3",$P(%,U),$P(X,":"),DA)=""
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" S:'$P(^XUSEC(0,DA,0),U,4) ^XUSEC(0,"AS2",$P(X,":"),DA)=""
 S DIKZ(1)=$G(^XUSEC(0,DA,1))
 S X=$P($G(DIKZ(1)),U,1)
 I X'="" S:'$P(^XUSEC(0,DA,0),U,4) ^XUSEC(0,"AS4",X,DA)=""
 S X=$P($G(DIKZ(1)),U,1)
 I X'="" N % S %=^XUSEC(0,DA,0) I '$P(%,U,4) S ^XUSEC(0,"AS5",$P(%,U),X,DA)=""
END Q
