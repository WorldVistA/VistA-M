YSXRAT1 ; COMPILED XREF FOR FILE #618.4 ; 10/15/04
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^YSG("INP",DA,0))
 S X=$P(DIKZ(0),U,2)
 I X'="" K ^YSG("INP","C",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,2)
 I X'="" K ^YSG("INP","CP",X,DA)
 S X=$P(DIKZ(0),U,3)
 I X'="" K ^YSG("INP","AIN",9999999-X,DA)
 S X=$P(DIKZ(0),U,5)
 I X'="" K ^YSG("INP","AC",X,DA)
 S X=$P(DIKZ(0),U,6)
 I X'="" K ^YSG("INP","ACP",X,DA)
 S X=$P(DIKZ(0),U,7)
 I X'="" K ^YSG("INP","ACR",X,DA)
 S DIKZ(7)=$G(^YSG("INP",DA,7))
 S X=$P(DIKZ(7),U,2)
 I X'="" K ^YSG("INP","AOUT",9999999-X,DA)
 S X=$P(DIKZ(7),U,4)
 I X'="" D LEAVE^YSCEN5
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^YSG("INP","B",$E(X,1,30),DA)
END G ^YSXRAT2
