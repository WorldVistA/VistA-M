PSSVX64 ; COMPILED XREF FOR FILE #52.6 ; 07/13/16
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^PS(52.6,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^PS(52.6,"B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S ^PS(52.6,"AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $P($G(^PSDRUG(X,2)),"^",3)'["I" S PSIUDA=X,PSIUX="I" D ENS^PSSGIU
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S (DIV,X)=$P($G(^PSDRUG(X,2)),U,6) I DIV S DIU=$P($G(^PS(52.6,DA,0)),U,12) I DIV'=DIU S $P(^(0),U,12)=DIV I $O(^DD(52.6,16,1,0)) S (D0,DIV(0))=DA,DIH=52.6,DIG=16 D ^DICR
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D S526^PSSPOID1
 S DIKZ("I")=$G(^PS(52.6,DA,"I"))
 S X=$P($G(DIKZ("I")),U,1)
 I X'="" X ^DD(52.6,12,1,1,1)
 S DIKZ(0)=$G(^PS(52.6,DA,0))
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" S ^PS(52.6,"AOI",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" S ^PS(52.6,"APD",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" X ^DD(52.6,17,1,1,1)
END G ^PSSVX65
