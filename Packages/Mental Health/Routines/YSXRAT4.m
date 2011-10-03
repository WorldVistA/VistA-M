YSXRAT4 ; COMPILED XREF FOR FILE #618.4 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^YSG("INP",DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^YSG("INP","B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^YSG("INP","C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" I $P($G(^YSG("INP",DA,7)),U,4) S ^YSG("INP","CP",X,DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^YSG("INP","AIN",9999999-X,DA)=""
 S X=$P(DIKZ(0),U,4)
 I X'="" D CROSS^YSCEN5
 S X=$P(DIKZ(0),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^YSG("INP",D0,7)):^(7),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV S X=DIV,X=X X ^DD(618.4,3,1,2,1.4)
 S DIKZ(0)=$G(^YSG("INP",DA,0))
 S X=$P(DIKZ(0),U,5)
 I X'="" I $D(^YSG("INP",DA,7)),$P(^YSG("INP",DA,7),U,4)?1N.N S ^YSG("INP","AC",X,DA)=""
 S X=$P(DIKZ(0),U,6)
 I X'="" I $D(^YSG("INP",DA,7)),$P(^YSG("INP",DA,7),U,4)?1N.N S ^YSG("INP","ACP",X,DA)=""
 S X=$P(DIKZ(0),U,7)
 I X'="" I $D(^YSG("INP",DA,7)),$P(^YSG("INP",DA,7),U,4)?1N.N S ^YSG("INP","ACR",X,DA)=""
 S DIKZ(7)=$G(^YSG("INP",DA,7))
 S X=$P(DIKZ(7),U,2)
 I X'="" S ^YSG("INP","AOUT",9999999-X,DA)=""
 S X=$P(DIKZ(7),U,4)
 I X'="" D ENTRY^YSCEN5
END G ^YSXRAT5
