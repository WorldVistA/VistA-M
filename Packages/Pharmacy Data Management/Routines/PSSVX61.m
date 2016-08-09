PSSVX61 ; COMPILED XREF FOR FILE #52.6 ; 07/13/16
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^PS(52.6,DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" K ^PS(52.6,"AC",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I '$D(^PS(52.7,"AC",X)) S XX=$O(^PS(52.6,"AC",X,0)) S:XX=DA XX=$O(^(XX)) I XX,$P($G(^PSDRUG(X,2)),"^",3)["I" S PSIUDA=X,PSIUX="I" D END^PSSGIU
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .S DIU=$P($G(^PS(52.6,DA,0)),U,12) I DIU]"" S $P(^(0),U,12)="" I $O(^DD(52.6,16,1,0)) K DIV S (DIV,X)="",(D0,DIV(0))=DA,DIH=52.6,DIG=16 D ^DICR
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D K526^PSSPOID1
 S DIKZ("I")=$G(^PS(52.6,DA,"I"))
 S X=$P($G(DIKZ("I")),U,1)
 I X'="" X ^DD(52.6,12,1,1,2)
 S DIKZ(0)=$G(^PS(52.6,DA,0))
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" K ^PS(52.6,"AOI",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" K ^PS(52.6,"APD",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" X ^DD(52.6,17,1,1,2)
 S DIKZ(0)=$G(^PS(52.6,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^PS(52.6,"B",$E(X,1,30),DA)
END G ^PSSVX62
