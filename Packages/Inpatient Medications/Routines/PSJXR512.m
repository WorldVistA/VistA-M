PSJXR512 ; COMPILED XREF FOR FILE #55.01 ; 10/28/97
 ; 
 S DA(1)=DA S DA=0
A1 ;
 I $D(DISET) K DIKLM S:$D(DA(1)) DIKLM=1 G:$D(DA(1)) 1 S DA(1)=DA,DA=0 G @DIKM1
0 ;
A S DA=$O(^PS(55,DA(1),"IV",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^PS(55,DA(1),"IV","B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" X ^DD(55.01,.02,1,1,1)
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^PS(55,"AIVS",$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^PS(55,"AIV",+$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" X ^DD(55.01,.03,1,2,1)
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^PS(55,DA(1),"IV","AIS",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" I $P($G(^PS(55,DA(1),"IV",DA,0)),U,4)]"" S ^PS(55,DA(1),"IV","AIT",$P(^(0),U,4),+X,DA)=""
 S X=$P(DIKZ(0),U,4)
 I X'="" X ^DD(55.01,.04,1,1,1)
 S X=$P(DIKZ(0),U,6)
 I X'="" X ^DD(55.01,.06,1,1,1)
 S X=$P(DIKZ(0),U,6)
 I X'="" I '$D(DIU(0)),$S($D(^PS(55,DA(1),5.1)):$P(^(5.1),"^",2)'=X,1:1) S $P(^(5.1),"^",2)=X
 S X=$P(DIKZ(0),U,8)
 I X'="" X ^DD(55.01,.08,1,1,1)
 S X=$P(DIKZ(0),U,9)
 I X'="" X ^DD(55.01,.09,1,1,1)
 S DIKZ(1)=$G(^PS(55,DA(1),"IV",DA,1))
 S X=$P(DIKZ(1),U,1)
 I X'="" X ^DD(55.01,.1,1,1,1)
 S X=$P(DIKZ(0),U,11)
 I X'="" X ^DD(55.01,.12,1,1,1)
 S DIKZ(3)=$G(^PS(55,DA(1),"IV",DA,3))
 S X=$P(DIKZ(3),U,1)
 I X'="" X ^DD(55.01,31,1,1,1)
 S X=$P(DIKZ(0),U,17)
 I X'="" X ^DD(55.01,100,1,1,1)
 S X=$P(DIKZ(0),U,17)
 I X'="" I $D(DIU(0)) S:X="N" ^PS(55,"ANVO",DA(1),DA)=""
 S X=$P(DIKZ(0),U,17)
 I X'="" S:X="D"&($D(^PS(55,DA(1),"IV",DA,"ADC"))) ^PS(55,"ADC",^PS(55,DA(1),"IV",DA,"ADC"),DA(1),DA)=""
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^PSJXR513
