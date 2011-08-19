LRBLPR1 ;AVAMC/REG - BLOOD BANK PT RECORD-COND'T ;9/11/95  07:30 ;
 ;;5.2;LAB SERVICE;**1,72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D E S LR(9)=0 F LRZ=0:1 S LR(9)=$O(^LR(LRDFN,3,LR(9))) Q:'LR(9)!(LR("Q"))  D:$Y>(IOSL-6) H^LRBLPR,H Q:LR("Q")  S X=^LR(LRDFN,3,LR(9),0) D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW
 D S Q:LR("Q")
 I $O(^LR(LRDFN,1.7,0)) W !?4,"Antibodies identified: " F LR(9)=0:0 S LR(9)=$O(^LR(LRDFN,1.7,LR(9))) Q:'LR(9)!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  W:$X>(IOM-15) !?4 W " ",$P(^LAB(61.3,LR(9),0),"^")
 Q:LR("Q")  I $D(^LR(LRDFN,LRSS)),LR(8) D V
 W ! Q
 ;
V W !,"Accession Number",?24,"Date/time",?40,"ABO",?44,"Rh",?48,"AHG(D)",?55,"AHG(I)"
 S LRI=0 F A=1:1 S LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI!(A>LR(8))!(LR("Q"))  S LR(5)=^(LRI,0) D:$Y>(IOSL-6) H2 Q:LR("Q")  S T=+LR(5) D T W !,$J($P(LR(5),"^",6),15),?24,T D W
 Q
W S LR(10)=$S($D(^LR(LRDFN,LRSS,LRI,10)):^(10),1:""),LR(11)=$S($D(^(11)):^(11),1:""),LR(0)=$S($D(^(2)):^(2),1:""),LR(6)=$S($D(^(6)):^(6),1:"")
 W ?41,$J($P(LR(10),"^"),2),?44,$P(LR(11),"^"),?51,$P(LR(0),"^",9),?58,$P(LR(6),"^")
 F E=10,11 I $P(LR(E),"^",3)]"" D:$Y>(IOSL-6) H2 Q:LR("Q")  S X=$P(LR(E),"^",3) W !?20,$E(X,1,59) I $L(X)>59 W !?40,$E(X,60,80)
 Q:LR("Q")  D:$Y>(IOSL-6) H2 Q:LR("Q")  S X=$P(LR(0),"^",10) I X]"" W !?20,$E(X,1,59) W:$L(X)>59 !?40,$E(X,60,80)
 F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,4,E)) Q:'E!(LR("Q"))  D:$Y>(IOSL-6) H2 Q:LR("Q")  S X=^LR(LRDFN,LRSS,LRI,4,E,0) W !?20,$E(X,1,59) W:$L(X)>59 !?40,$E(X,60,80)
 Q:LR("Q")  F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,5,E)) Q:'E!(LR("Q"))  D:$Y>(IOSL-6) H2 Q:LR("Q")  S X=+^LR(LRDFN,LRSS,LRI,5,E,0) I X,$D(^LAB(61.3,X,0)) W !?20,"Serum  antibody: ",$P(^(0),"^")
 Q:LR("Q")  F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,"EA",E)) Q:'E!(LR("Q"))  D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?20,"Eluate antibody: ",$P(^LAB(61.3,E,0),"^")
 Q:LR("Q")  F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,99,E)) Q:'E!(LR("Q"))  S LRE=^(E,0) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?8,LRE
 Q
T S T=T_"000",T=$E(T,4,5)_"/"_$E(T,6,7)_"/"_$E(T,2,3)_$S(T[".":" "_$E(T,9,10)_":"_$E(T,11,12),1:"") Q
E K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF="W" Q
H Q:LR("Q")  W !,LRP,?31,$P(LR(4),"^",2),?42,"[See previous page (Pg ",LRQ-1,")]" Q
H1 D H^LRBLPR,H Q:LR("Q")  W !?4,"Antibodies identified (cond't): " Q
H2 D H^LRBLPR,H Q:LR("Q")  W !?4,"Date/time",?20,"ABO",?24,"Rh",?28,"AHG(D)",?35,"AHG(I)" Q
H3 D H^LRBLPR,H Q:LR("Q")  W !,"TRANSFUSION REACTIONS WITH UNIT IDENTIFIED",?51,"UNIT ID",?66,"COMPONENT" Q
H4 D H^LRBLPR,H Q:LR("Q")  W !,"TRANSFUSION REACTIONS WITHOUT UNIT IDENTIFIED" Q
S S (C,LRA)=0 F B=0:1 S C=$O(^LR("AB",LRDFN,C)) Q:'C!(LR("Q"))  F A=0:0 S A=$O(^LR("AB",LRDFN,C,A)) Q:'A!(LR("Q"))  D R
 Q:LR("Q")  S A=0 W ! F B=0:1 S A=$O(^LR(LRDFN,1.9,A)) Q:'A!(LR("Q"))  S LR(1.9)=^(A,0) W:'B !,"TRANSFUSION REACTIONS WITHOUT UNIT IDENTIFIED:" S Y=+LR(1.9) D D^LRU W !,Y,?21,$P($G(^LAB(65.4,+$P(LR(1.9),U,2),0)),U) D A
 Q
A D:$Y>(IOSL-6) H4 Q:LR("Q")  F B=0:0 S B=$O(^LR(LRDFN,1.9,A,1,B)) Q:'B!(LR("Q"))  S B(1)=^(B,0) D:$Y>(IOSL-6) H4 Q:LR("Q")  W !,B(1)
 Q
R S LR(1.9)=$G(^LR(LRDFN,1.6,A,0)),Y=+LR(1.9) I LR(1.9)="" K ^LR("AB",LRDFN,C,A) Q
 D D^LRU W:'LRA !,"TRANSFUSION REACTIONS WITH UNIT IDENTIFIED",?51,"UNIT ID",?66,"COMPONENT" W !,Y,?21,$P($G(^LAB(65.4,C,0)),U),?51,$P(LR(1.9),U,3),?69,$P($G(^LAB(66,+$P(LR(1.9),U,2),0)),U,2) S LRA=LRA+1
 D:$Y>(IOSL-6) H3 Q:LR("Q")  F B(1)=0:0 S B(1)=$O(^LR(LRDFN,1.6,A,1,B(1))) Q:'B(1)!(LR("Q"))  S B(2)=^(B(1),0) D:$Y>(IOSL-6) H3 Q:LR("Q")  W !,B(2)
 Q
