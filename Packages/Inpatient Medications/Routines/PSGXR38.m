PSGXR38 ; COMPILED XREF FOR FILE #53.1 ; 09/12/12
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^PS(53.1,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^PS(53.1,"B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,15)
 I X'="" S XX=X,X="PSGAXR" X ^%ZOSF("TEST") I  S X=XX D ENNPS^PSGAXR
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $P($G(^PS(53.1,DA,0)),"^",15),$D(^PS(55,+$P(^(0),U,15),0)),$P($G(^(5.1)),"^",2)'=X S $P(^(5.1),"^",2)=X
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I 'X S DIU=$S($D(^PS(53.1,DA,0)):$P(^(0),"^",6),1:"") I DIU]"" S $P(^(0),"^",6)="" I $O(^DD(53.1,6,1,0)) K DIV S (DIV(0),D0)=DA,DIV="",DIH=53.1,DIG=6 D ^DICR K DIV
 S DIKZ(0)=$G(^PS(53.1,DA,0))
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I X="O",$D(^PS(53.1,DA,2)),$P(^(2),"^",2),$P(^(2),"^",4),$P(^(2),"^",2)'=$P(^(2),"^",4) S DIU=$P(^(2),"^",4),$P(^(2),"^",4)=$P(^(2),"^",2) I $O(^DD(53.1,25,1,0)) K DIV S DIV=$P(^PS(53.1,DA,2),"^",2) X ^DD(53.1,7,1,2,1.4)
 S DIKZ(4)=$G(^PS(53.1,DA,4))
 S X=$P($G(DIKZ(4)),U,1)
 I X'="" S XX=X,X="PSGAXR" X ^%ZOSF("TEST") I  S X=XX D ENNACK^PSGAXR
 S DIKZ(2)=$G(^PS(53.1,DA,2))
 S X=$P($G(DIKZ(2)),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I '$D(DIU(0)),$D(PSGS0Y),PSGS0Y S DIU=$S($D(^PS(53.1,DA,2)):$P(^(2),"^",5),1:"") I DIU'=PSGS0Y S $P(^(2),"^",5)=PSGS0Y I $O(^DD(53.1,39,1,0)) K DIV S (DIV(0),D0)=DA,DIV=PSGS0Y,DIH=53.1,DIG=39 D ^DICR K DIV
 S X=$P($G(DIKZ(2)),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I $D(PSGS0XT),PSGS0XT S DIU=$S($D(^PS(53.1,DA,2)):$P(^(2),"^",6),1:"") I DIU'=PSGS0XT S $P(^(2),"^",6)=PSGS0XT I $O(^DD(53.1,41,1,0)) K DIV S (DIV(0),D0)=DA,DIV=PSGS0XT,DIH=53.1,DIG=41 D ^DICR K DIV
 S DIKZ(0)=$G(^PS(53.1,DA,0))
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S XX=X,X="PSGAXR" X ^%ZOSF("TEST") I  S X=XX D ENSS^PSGAXR
 S DIKZ(2)=$G(^PS(53.1,DA,2))
 S X=$P($G(DIKZ(2)),U,5)
 I X'="" S PSGS0Y=X
 S X=$P($G(DIKZ(2)),U,5)
 I X'="" I $D(^PS(53.1,DA,2)),$P(^(2),"^")["@" S $P(^(2),"^")=$P($P(^(2),"^"),"@")_"@"_X
 S DIKZ(.1)=$G(^PS(53.1,DA,.1))
 S X=$P($G(DIKZ(.1)),U,1)
 I X'="" D ENNDS^PSGAXR
 S DIKZ(.2)=$G(^PS(53.1,DA,.2))
 S X=$P($G(DIKZ(.2)),U,8)
 I X'="" S ^PS(53.1,"ACX",$E(X,1,30),DA)=""
CR1 S DIXR=502
 K X
 S DIKZ("DSS")=$G(^PS(53.1,DA,"DSS"))
 S X(1)=$P(DIKZ("DSS"),U,1)
 S X(2)=$P(DIKZ(0),U,15)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^PS(53.1,"AD",$E(X(1),1,20),$E(X(2),1,20),DA)=""
CR2 K X
END G ^PSGXR39
