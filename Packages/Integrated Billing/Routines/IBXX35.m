IBXX35 ; COMPILED XREF FOR FILE #399.30416 ; 12/13/16
 ; 
 S DA(1)=0 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=2 DIKLM=1 S:DIKM1'=2&'$G(DIKPUSH(2)) DIKPUSH(2)=1,DA(2)=DA(1),DA(1)=DA,DA=0 G @DIKM1
A S DA(1)=$O(^DGCR(399,DA(2),"CP",DA(1))) I DA(1)'>0 S DA(1)=0 G END
1 ;
B S DA=$O(^DGCR(399,DA(2),"CP",DA(1),"MOD",DA)) I DA'>0 S DA=0 Q:DIKM1=1  G A
2 ;
 S DIKZ(0)=$G(^DGCR(399,DA(2),"CP",DA(1),"MOD",DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^DGCR(399,DA(2),"CP",DA(1),"MOD","B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S ^DGCR(399,DA(2),"CP",DA(1),"MOD","C",$E(X,1,30),DA)=""
 G:'$D(DIKLM) B Q:$D(DISET)
END Q
