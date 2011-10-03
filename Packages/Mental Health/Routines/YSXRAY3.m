YSXRAY3 ; COMPILED XREF FOR FILE #627.8 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^YSD(627.8,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^YSD(627.8,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^YSD(627.8,"C",$E(X,1,30),DA)=""
 S DIKZ(1)=$G(^YSD(627.8,DA,1))
 S X=$P(DIKZ(1),U,1)
 I X'="" S X1=$S(X["ICD":"I",X["DIC":"D",1:"Z"),^YSD(627.8,"AE",X1,$P(^YSD(627.8,DA,0),"^",2),$P(^YSD(627.8,DA,0),"^",3),$E(X,1,30),DA)=""
 S X=$P(DIKZ(1),U,1)
 I X'="" S ^YSD(627.8,"AF",$P(^YSD(627.8,DA,0),"^",2),9999999.0000-$P(^YSD(627.8,DA,0),"^",3),$E(X,1,30),DA)=""
 S X=$P(DIKZ(1),U,1)
 I X'="" S X1=$S(X["ICD":"I",X["DIC":"D",1:"Z"),^YSD(627.8,"AG",X1,$P(^YSD(627.8,DA,0),"^",2),$E(X,1,30),DA)=""
 S X=$P(DIKZ(1),U,4)
 I X'="" S ^YSD(627.8,"AC",$P(^YSD(627.8,DA,0),"^",2),9999999-$P(^YSD(627.8,DA,0),"^",3),$P(^YSD(627.8,DA,1),"^"),X,DA)=""
 S X=$P(DIKZ(1),U,3)
 I X'="" S:X="y" ^YSD(627.8,"AD",$P(^YSD(627.8,DA,0),"^",2),9999999.0000-$P(^YSD(627.8,DA,0),"^",3),DA)=""
 S X=$P(DIKZ(1),U,3)
 I X'="" I "yc"[X S ^YSD(627.8,"AH",$P(^YSD(627.8,DA,0),"^",2),9999999-$P(^YSD(627.8,DA,0),"^",3),DA)=""
 S DIKZ(60)=$G(^YSD(627.8,DA,60))
 S X=$P(DIKZ(60),U,2)
 I X'="" N X1 S X1=$G(^YSD(627.8,DA,0)) S ^YSD(627.8,"AX4",$P(X1,U,2),9999999-$P(X1,U,3),DA)=""
 S X=$P(DIKZ(60),U,3)
 I X'="" N X1 S X1=$G(^YSD(627.8,DA,0)) S ^YSD(627.8,"AX5",$P(X1,U,2),9999999-$P(X1,U,3),DA)=""
END G ^YSXRAY4
