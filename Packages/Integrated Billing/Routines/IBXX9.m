IBXX9 ; COMPILED XREF FOR FILE #399.045 ; 03/14/19
 ; 
 S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGCR(399,DA(1),"D2",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGCR(399,DA(1),"D2",DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^DGCR(399,DA(1),"D2","B",$E(X,1,30),DA)
 G:'$D(DIKLM) A Q:$D(DIKILL)
END G ^IBXX10
