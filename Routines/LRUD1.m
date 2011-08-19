LRUD1 ;AVAMC/REG - STUFF DATA CHANGE IN COMMENT FIELD ;1/14/91  09:44
 ;;5.2;LAB SERVICE;;Sep 27, 1994
BB Q:'$D(L("BB"))  S:'$D(^LR(LRDFN,"BB",LRI,99,0)) ^(0)="^63.199A^^" S Z(10)=$P(^(0),"^",3)+1
E I $D(^LR(LRDFN,"BB",LRI,99,Z(10),0)) S Z(10)=Z(10)+1 G E
 S Y=Z(1) D D^LRU S ^LR(LRDFN,"BB",LRI,99,Z(10),0)=Z(3)_" changed from:"_O,Z(10)=Z(10)+1,^LR(LRDFN,"BB",LRI,99,Z(10),0)="Above changed:"_Y_" By:"_Z(2)
 S X=^LR(LRDFN,"BB",LRI,99,0),^(0)=$P(X,"^",1,2)_"^"_Z(10)_"^"_($P(X,"^",4)+2) K L Q
