LRDPA2 ;AVAMC/REG - PT BLOOD BANK LOOKUP ;12/14/92  10:47 ;
 ;;5.2;LAB SERVICE;**310**;Sep 27, 1994
 K ^TMP($J) I '$D(IOM) S IOP="HOME" D ^%ZIS
 S:IOM="" IOM=80
 S DIWR=IOM-5,DIWL=5,DIWF="W"
 S A=0 F B=0:1 S A=$O(^LR(LRDFN,3,A)) Q:'A  W:'B $C(7),! S X=^(A,0) D ^DIWP
 D:B ^DIWW K R S A=0 F B=0:1 S A=$O(^LR(LRDFN,1.7,A)) Q:'A  W:'B $C(7),!,"Antibody present:" W:B ! S X=^LAB(61.3,A,0) W ?18,$P(X,"^") S:$P(X,"^",4) R($P(X,"^",4))=$P(X,"^")
 W ! S (LR("Q"),A)=0,A(1)=12
 S C=0 F B=0:1 S C=$O(^LR("AB",LRDFN,C)) Q:'C!(LR("Q"))  F A=0:0 S A=$O(^LR("AB",LRDFN,C,A)) Q:'A!(LR("Q"))  D R
 S A=0 W ! F B=0:1 S A=$O(^LR(LRDFN,1.9,A)) Q:'A!(LR("Q"))  S LR(1.9)=^(A,0) W:'B !,"TRANSFUSION REACTIONS WITHOUT UNIT IDENTIFIED:" S Y=+LR(1.9),A(1)=A(1)+1 D D^LRU W !,Y,?21,$P($G(^LAB(65.4,+$P(LR(1.9),U,2),0)),U) D W
 S LR("Q")=0 Q
W D:A(1)#22=0 M^LRU Q:LR("Q")  F B=0:0 S B=$O(^LR(LRDFN,1.9,A,1,B)) Q:'B!(LR("Q"))  S A(1)=A(1)+1 W !,^(B,0) D:A(1)#22=0 M^LRU
 Q
R S LR(1.9)=$G(^LR(LRDFN,1.6,A,0)) I LR(1.9)="" K ^LR("AB",LRDFN,C,A) Q
 S A(1)=A(1)+1,Y=+LR(1.9) D D^LRU
 W:A(1)=13 !,"TRANSFUSION REACTIONS WITH UNIT IDENTIFIED",?51,"UNIT ID",?66,"COMPONENT" W !,Y,?21,$P($G(^LAB(65.4,C,0)),U),?51,$P(LR(1.9),U,3),?69,$P($G(^LAB(66,+$P(LR(1.9),U,2),0)),U,2) D:A(1)#22=0 M^LRU
 Q:LR("Q")  F B(1)=0:0 S B(1)=$O(^LR(LRDFN,1.6,A,1,B(1))) Q:'B(1)!(LR("Q"))  S B(2)=^(B(1),0),A(1)=A(1)+1 D:A(1)#22=0 M^LRU Q:LR("Q")  W !,B(2)
 Q
