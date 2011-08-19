LRAPBK1 ;AVAMC/REG - AP LOG BOOK ;1/12/94  12:55
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 F Z=0:0 S Z=$O(^LR(LRDFN,LRSS,LRI,2,Z)) Q:'Z  S LRT=+^(Z,0) D:$Y>(IOSL-6) H1^LRAPBK Q:LR("Q")  S X=$S($D(^LAB(61,LRT,0)):^(0),1:"?") W !?14,"T-",$P(X,"^",2)," ",$P(X,"^") D M
 Q
M F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,Z,2,LRM)) Q:'LRM!(LR("Q"))  S X=+^(LRM,0),LRM(1)=$S($D(^LAB(61.1,X,0)):^(0),1:"?") D:$Y>(IOSL-6) H1^LRAPBK W !?17,"M-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^") D:$D(LRB(1)) E
 Q:'$D(LRB(1))  F J=0:0 S J=$O(^LR(LRDFN,LRSS,LRI,2,Z,4,J)) Q:'J!(LR("Q"))  S LRX=^(J,0),LRX(1)=$P(LRX,"^",2) D:$Y>(IOSL-6) H1^LRAPBK S X=$S($D(^LAB(61.5,+LRX,0)):^(0),1:"?") W !?17,"P-",$P(X,"^",2)," ",$P(X,"^") D:LRX(1)]"" W
 F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,Z,1,LRM)) Q:'LRM!(LR("Q"))  S X=+^(LRM,0),LRM(1)=$S($D(^LAB(61.4,X,0)):^(0),1:"?") D:$Y>(IOSL-6) H1^LRAPBK W !?17,"D-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,Z,3,LRM)) Q:'LRM!(LR("Q"))  S X=+^(LRM,0),LRM(1)=$S($D(^LAB(61.3,X,0)):^(0),1:"?") D:$Y>(IOSL-6) H1^LRAPBK W !?17,"F-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 Q
W W " (",$S(LRX(1)=1:"Positive",LRX(1)=0:"Negative",1:"?"),")" Q
E F LRE=0:0 S LRE=$O(^LR(LRDFN,LRSS,LRI,2,Z,2,LRM,1,LRE)) Q:'LRE  S X=+^(LRE,0),LRE(1)=$S($D(^LAB(61.2,X,0)):^(0),1:"?") W !?20,"E-",$P(LRE(1),"^",2)," ",$P(LRE(1),"^")
 Q
AU F Z=0:0 S Z=$O(^LR(LRDFN,"AY",Z)) Q:'Z  S LRT=+^(Z,0) D:$Y>(IOSL-6) H1^LRAPBK Q:LR("Q")  S X=$S($D(^LAB(61,LRT,0)):^(0),1:"?") W !?14,"T-",$P(X,"^",2)," ",$P(X,"^") D MA
 Q
MA F LRM=0:0 S LRM=$O(^LR(LRDFN,"AY",Z,2,LRM)) Q:'LRM!(LR("Q"))  S X=+^(LRM,0),LRM(1)=$S($D(^LAB(61.1,X,0)):^(0),1:"?") D:$Y>(IOSL-6) H1^LRAPBK W !?17,"M-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^") D:$D(LRB(1)) EA
 Q:'$D(LRB(1))  F J=0:0 S J=$O(^LR(LRDFN,"AY",Z,4,J)) Q:'J!(LR("Q"))  S LRX=^(J,0),LRX(1)=$P(LRX,"^") D:$Y>(IOSL-6) H1^LRAPBK S X=$S($D(^LAB(61.5,+LRX,0)):^(0),1:"?") W !?17,"P-",$P(X,"^",2)," ",$P(X,"^") D:LRX(1)]"" W
 F LRM=0:0 S LRM=$O(^LR(LRDFN,"AY",Z,1,LRM)) Q:'LRM!(LR("Q"))  S X=+^(LRM,0),LRM(1)=$S($D(^LAB(61.4,X,0)):^(0),1:"?") D:$Y>(IOSL-6) H1^LRAPBK W !?17,"D-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 F LRM=0:0 S LRM=$O(^LR(LRDFN,"AY",Z,3,LRM)) Q:'LRM!(LR("Q"))  S X=+^(LRM,0),LRM(1)=$S($D(^LAB(61.3,X,0)):^(0),1:"?") D:$Y>(IOSL-6) H1^LRAPBK W !?17,"F-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 Q
EA F LRE=0:0 S LRE=$O(^LR(LRDFN,"AY",Z,2,LRM,1,LRE)) Q:'LRE  S X=+^(LRE,0),LRE(1)=$S($D(^LAB(61.2,X,0)):^(0),1:"?") W !?20,"E-",$P(LRE(1),"^",2)," ",$P(LRE(1),"^")
 Q
