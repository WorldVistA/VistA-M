PSSJXR19 ; COMPILED XREF FOR FILE #55.01 ; 09/12/12
 ; 
 S DA(1)=DA S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^PS(55,DA(1),"IV",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^PS(55,DA(1),"IV","B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" X ^DD(55.01,.02,1,1,1)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S ^PS(55,"AIVS",$E(X,1,30),DA(1),DA)=""
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S ^PS(55,"AIV",+$E(X,1,30),DA(1),DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" X ^DD(55.01,.03,1,2,1)
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S ^PS(55,DA(1),"IV","AIS",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" I $P($G(^PS(55,DA(1),"IV",DA,0)),U,4)]"" S ^PS(55,DA(1),"IV","AIT",$P(^(0),U,4),+X,DA)=""
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" X ^DD(55.01,.04,1,1,1)
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" X ^DD(55.01,.06,1,1,1)
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" I '$D(DIU(0)),$S($D(^PS(55,DA(1),5.1)):$P(^(5.1),"^",2)'=X,1:1) S $P(^(5.1),"^",2)=X
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" X ^DD(55.01,.08,1,1,1)
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" X ^DD(55.01,.09,1,1,1)
 S DIKZ(1)=$G(^PS(55,DA(1),"IV",DA,1))
 S X=$P($G(DIKZ(1)),U,1)
 I X'="" X ^DD(55.01,.1,1,1,1)
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" X ^DD(55.01,.12,1,1,1)
 S DIKZ(3)=$G(^PS(55,DA(1),"IV",DA,3))
 S X=$P($G(DIKZ(3)),U,1)
 I X'="" X ^DD(55.01,31,1,1,1)
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" X ^DD(55.01,100,1,1,1)
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" I $D(DIU(0)) S:X="N" ^PS(55,"ANVO",DA(1),DA)=""
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" S:X="D"&($D(^PS(55,DA(1),"IV",DA,"ADC"))) ^PS(55,"ADC",^PS(55,DA(1),"IV",DA,"ADC"),DA(1),DA)=""
 S DIKZ(4)=$G(^PS(55,DA(1),"IV",DA,4))
 S X=$P($G(DIKZ(4)),U,9)
 I X'="" X ^DD(55.01,142,1,1,1)
 S X=$P($G(DIKZ(4)),U,9)
 I X'="" K:X ^PS(55,"APIV",DA(1),DA) S:'X ^PS(55,"APIV",DA(1),DA)=""
 S DIKZ(4)=$G(^PS(55,DA(1),"IV",DA,4))
 S X=$P($G(DIKZ(4)),U,10)
 I X'="" X ^DD(55.01,143,1,1,1)
 S X=$P($G(DIKZ(4)),U,10)
 I X'="" K:X ^PS(55,"ANIV",DA(1),DA) S:'X ^PS(55,"ANIV",DA(1),DA)=""
CR1 S DIXR=415
 K X
 S DIKZ(.2)=$G(^PS(55,DA(1),"IV",DA,.2))
 S X(1)=$P(DIKZ(.2),U,8)
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X(2)=$P(DIKZ(0),U,21)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . N DIKXARR M DIKXARR=X S DIKCOND=1
 . S X=1
 . S DIKCOND=$G(X) K X M X=DIKXARR
 . Q:'DIKCOND
 . S ^PS(55,"ACX",$E(X(1),1,30),$E(X(2),1,30),DA_"V")=""
CR2 S DIXR=466
 K X
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X(1)=$P(DIKZ(0),U,2)
 S X(2)=$P(DIKZ(0),U,3)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . N DIKXARR M DIKXARR=X S DIKCOND=1
 . S X=$$PATCH^XPDUTL("PXRM*1.5*12")
 . S DIKCOND=$G(X) K X M X=DIKXARR
 . Q:'DIKCOND
 . D SPSPA^PSJXRFS(.X,.DA,"IV")
CR3 S DIXR=498
 K X
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X(1)=$P(DIKZ(0),U,3)
 S DIKZ("DSS")=$G(^PS(55,DA(1),"IV",DA,"DSS"))
 S X(2)=$P(DIKZ("DSS"),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^PS(55,"AIVC",$E(X(1),1,20),$E(X(2),1,20),DA(1),DA)=""
CR4 S DIXR=500
 K X
 S DIKZ(0)=$G(^PS(55,DA(1),"IV",DA,0))
 S X(1)=$P(DIKZ(0),U,3)
 S DIKZ("DSS")=$G(^PS(55,DA(1),"IV",DA,"DSS"))
 S X(2)=$P(DIKZ("DSS"),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^PS(55,DA(1),"IV","AIN",X(1),X(2),DA)=""
CR5 K X
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^PSSJXR20
