LRAPBK1 ;DALOI/STAFF - AP LOG BOOK ;Dec 19 , 2007
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;
 N LRSCT,LRX
 ;
 F Z=0:0 S Z=$O(^LR(LRDFN,LRSS,LRI,2,Z)) Q:'Z  D
 . S LRT=+^LR(LRDFN,LRSS,LRI,2,Z,0)
 . D:$Y>(IOSL-6) H1^LRAPBK Q:LR("Q")
 . S X=$G(^LAB(61,LRT,0),"?")
 . I LRPSNM?1(1"1",1"3") W !?14,"T-",$P(X,"^",2)," (SNM)  ",$P(X,"^")
 . I LRPSNM>1 D
 . . S LRSCT=$$IEN2SCT^LA7VHLU6(61,LRT,DT,"")
 . . I LRSCT'="" W !,?14,$S(LRPSNM=2:"Topography: ",1:""),$P(LRSCT,"^")," (",$P(LRSCT,"^",3),")  ",$P(LRSCT,"^",2)
 . D M
 Q
 ;
 ;
M ;
 S LRM=0
 F  S LRM=$O(^LR(LRDFN,LRSS,LRI,2,Z,2,LRM)) Q:'LRM!(LR("Q"))  D
 . S X=+^LR(LRDFN,LRSS,LRI,2,Z,2,LRM,0),LRM(1)=$S($D(^LAB(61.1,X,0)):^(0),1:"?")
 . D:$Y>(IOSL-6) H1^LRAPBK
 . W !?17,"M-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 . I LRB=1 D E
 ;
 I LRB=2 Q
 ;
 S J=0
 F  S J=$O(^LR(LRDFN,LRSS,LRI,2,Z,4,J)) Q:'J!(LR("Q"))  D
 . S LRX=^LR(LRDFN,LRSS,LRI,2,Z,4,J,0),LRX(1)=$P(LRX,"^",2)
 . D:$Y>(IOSL-6) H1^LRAPBK
 . S X=$S($D(^LAB(61.5,+LRX,0)):^(0),1:"?")
 . W !?17,"P-",$P(X,"^",2)," ",$P(X,"^")
 . I LRX(1)'="" D W
 ;
 S LRM=0
 F  S LRM=$O(^LR(LRDFN,LRSS,LRI,2,Z,1,LRM)) Q:'LRM!(LR("Q"))  D
 . S X=+^LR(LRDFN,LRSS,LRI,2,Z,1,LRM,0),LRM(1)=$G(^LAB(61.4,X,0),"?")
 . D:$Y>(IOSL-6) H1^LRAPBK
 . W !?17,"D-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 ;
 S LRM=0
 F  S LRM=$O(^LR(LRDFN,LRSS,LRI,2,Z,3,LRM)) Q:'LRM!(LR("Q"))  D
 . S X=+^LR(LRDFN,LRSS,LRI,2,Z,3,LRM,0),LRM(1)=$G(^LAB(61.3,X,0),"?")
 . D:$Y>(IOSL-6) H1^LRAPBK
 . W !?17,"F-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 Q
 ;
 ;
E ;
 S LRE=0
 F  S LRE=$O(^LR(LRDFN,LRSS,LRI,2,Z,2,LRM,1,LRE)) Q:'LRE  D
 . S LRX=+^LR(LRDFN,LRSS,LRI,2,Z,2,LRM,1,LRE,0),LRE(1)=$G(^LAB(61.2,LRX,0),"?")
 . I LRPSNM?1(1"1",1"3") W !?20,"E-",$P(LRE(1),"^",2)," (SNM)  ",$P(LRE(1),"^")
 . I LRPSNM>1 D
 . . S LRSCT=$$IEN2SCT^LA7VHLU6(61.2,LRX,DT,"")
 . . I LRSCT'="" W !,?20,$S(LRPSNM=2:"Etiology: ",1:""),$P(LRSCT,"^")," (",$P(LRSCT,"^",3),")  ",$P(LRSCT,"^",2)
 Q
 ;
 ;
AU ;
 S Z=0
 F  S Z=$O(^LR(LRDFN,"AY",Z)) Q:'Z  D
 . S LRT=+^(Z,0)
 . D:$Y>(IOSL-6) H1^LRAPBK Q:LR("Q")
 . S X=$S($D(^LAB(61,LRT,0)):^(0),1:"?")
 . W !?14,"T-",$P(X,"^",2)," ",$P(X,"^")
 . D MA
 Q
 ;
 ;
MA ;
 S LRM=0
 F  S LRM=$O(^LR(LRDFN,"AY",Z,2,LRM)) Q:'LRM!(LR("Q"))  D
 . S X=+^LR(LRDFN,"AY",Z,2,LRM,0),LRM(1)=$S($D(^LAB(61.1,X,0)):^(0),1:"?")
 . D:$Y>(IOSL-6) H1^LRAPBK
 . W !?17,"M-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 . I LRB=1 D EA
 ;
 I LRB=2 Q
 ;
 S J=0
 F  S J=$O(^LR(LRDFN,"AY",Z,4,J)) Q:'J!(LR("Q"))  D
 . S LRX=^LR(LRDFN,"AY",Z,4,J,0),LRX(1)=$P(LRX,"^")
 . D:$Y>(IOSL-6) H1^LRAPBK
 . S X=$S($D(^LAB(61.5,+LRX,0)):^(0),1:"?")
 . W !?17,"P-",$P(X,"^",2)," ",$P(X,"^")
 . D:LRX(1)]"" W
 ;
 S LRM=0
 F  S LRM=$O(^LR(LRDFN,"AY",Z,1,LRM)) Q:'LRM!(LR("Q"))  D
 . S X=+^LR(LRDFN,"AY",Z,1,LRM,0),LRM(1)=$S($D(^LAB(61.4,X,0)):^(0),1:"?")
 . D:$Y>(IOSL-6) H1^LRAPBK
 . W !?17,"D-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 ;
 S LRM=0
 F  S LRM=$O(^LR(LRDFN,"AY",Z,3,LRM)) Q:'LRM!(LR("Q"))  D
 . S X=+^LR(LRDFN,"AY",Z,3,LRM,0),LRM(1)=$S($D(^LAB(61.3,X,0)):^(0),1:"?")
 . D:$Y>(IOSL-6) H1^LRAPBK
 . W !?17,"F-",$P(LRM(1),"^",2)," ",$P(LRM(1),"^")
 Q
 ;
 ;
EA ;
 S LRE=0
 F  S LRE=$O(^LR(LRDFN,"AY",Z,2,LRM,1,LRE)) Q:'LRE  D
 . S LRX=+^LR(LRDFN,"AY",Z,2,LRM,1,LRE,0),LRE(1)=$G(^LAB(61.2,LRX,0),"?")
 . I LRPSNM?1(1"1",1"3") W !?20,"E-",$P(LRE(1),"^",2)," (SNM)  ",$P(LRE(1),"^")
 . I LRPSNM>1 D
 . . S LRSCT=$$IEN2SCT^LA7VHLU6(61.2,LRX,DT,"")
 . . I LRSCT'="" W !,?20,$S(LRPSNM=2:"Etiology: ",1:""),$P(LRSCT,"^")," (",$P(LRSCT,"^",3),")  ",$P(LRSCT,"^",2)
 Q
 ;
 ;
W ;
 W " (",$S(LRX(1)=1:"Positive",LRX(1)=0:"Negative",1:"?"),")"
 Q
