PSOXZA11 ; COMPILED XREF FOR FILE #52.01 ; 04/25/23
 ; 
 S DA(1)=DA S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^PSRX(DA(1),4,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^PSRX(DA(1),4,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^PSRX(DA(1),4,"B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" K:X'=0 ^PSRX(DA(1),4,"A",$P(^PSRX(DA(1),4,DA,0),"^",3),DA) S:X=0 ^PSRX(DA(1),4,"A",$P(^PSRX(DA(1),4,DA,0),"^",3),DA)=""
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" X ^DD(52.01,3,1,2,1)
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" X ^DD(52.01,3,1,3,1)
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^PSOXZA12
