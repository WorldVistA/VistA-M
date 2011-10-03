LRSPRPT1 ;AVAMC/REG/WTY - SURG PATH RPT PRINT CONT. ;10/16/01
 ;;5.2;LAB SERVICE;**1,259,315**;Sep 27, 1994;Build 25
 ;
 ;25-Jul-01;WTY;In line tag L, if being called by LRAPT2, don't do
 ;              line tag F.  Do H1^LRAPT2 instead.
 ;21-Aug-01;WTY;Removed call to LRSPRPT2 which prints SNOMED codes.
 ;
 S A=0 F  S A=+$O(^LR(LRDFN,LRSS,LRI,2,A)) Q:'A!(LR("Q"))  D
 .S T=+^LR(LRDFN,LRSS,LRI,2,A,0),X=$S($D(^LAB(61,T,0)):^(0),1:"")
 .S T(1)=$P(X,"^"),T(8)=$P(X,"^",2)
 .D SP Q:LR("Q")
 .D T
 Q:LR("Q")
 I $D(LRS(99)),'+$G(LR("SPSM")) D ^LRSPRPT2
 Q:LR("Q")
 I $D(LRS(99)) W ! D
 .S A=0 F  S A=$O(^LR(LRDFN,LRSS,LRI,3,A)) Q:'A!(LR("Q"))  D
 ..D:$Y>(IOSL-12) F Q:LR("Q")
 ..S X=+^LR(LRDFN,LRSS,LRI,3,A,0)
 ..N LRX
 ..S LRX=X,LRX=$$ICDDX^ICDCODE(LRX,,,1)
 ..S X=$P(LRX,U,4)
 ..W !,"ICD code: ",$P(LRX,U,2),?20 D:LR(69.2,.05) C^LRUA W X
 Q
SP ;
 S C=0 F  S C=$O(^LR(LRDFN,LRSS,LRI,2,A,5,C)) Q:'C!(LR("Q"))  D
 .S T(3)=^LR(LRDFN,LRSS,LRI,2,A,5,C,0)
 .S Y=$P(T(3),"^",2),E=$P(T(3),"^",3)
 .S T(4)=$P(T(3),"^")_":",T(4)=$P($P(LR(LRSS),T(4),2),";",1)
 .D D^LRU S T(2)=Y
 .D:$Y>(IOSL-12) F Q:LR("Q")  D WP
 Q
WP ;
 W !!,T(4)," ",E," Date: ",T(2)," ",!,T(1),!
 D E S B=0
 F LRZ=0:1 S B=$O(^LR(LRDFN,LRSS,LRI,2,A,5,C,1,B)) Q:'B!(LR("Q"))  D
 .D:$Y>(IOSL-12) F Q:LR("Q")
 .S X=^LR(LRDFN,LRSS,LRI,2,A,5,C,1,B,0) D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW
 Q
E ;
 K ^UTILITY($J) S DIWR=IOM-10,DIWL=10,DIWF="W"
 Q
T ;
 S T(3)=T,T(4)=61 D EN
 S M=0 F  S M=$O(^LR(LRDFN,LRSS,LRI,2,A,2,M)) Q:'M!(LR("Q"))  D
 .S T(3)=+^LR(LRDFN,LRSS,LRI,2,A,2,M,0),T(4)=61.1 D EN Q:LR("Q")  D
 ..S N=0 F  S N=$O(^LR(LRDFN,LRSS,LRI,2,A,2,M,1,N)) Q:'N!(LR("Q"))  D
 ...S T(3)=+^LR(LRDFN,LRSS,LRI,2,A,2,M,1,N,0),T(4)=61.2 D EN
 Q:LR("Q")
 S M=0 F  S M=$O(^LR(LRDFN,LRSS,LRI,2,A,1,M)) Q:'M!(LR("Q"))  D
 .S T(3)=+^LR(LRDFN,LRSS,LRI,2,A,1,M,0),T(4)=61.4 D EN
 Q:LR("Q")
 S M=0 F  S M=$O(^LR(LRDFN,LRSS,LRI,2,A,3,M)) Q:'M!(LR("Q"))  D
 .S T(3)=+^LR(LRDFN,LRSS,LRI,2,A,3,M,0),T(4)=61.3 D EN
 Q
EN ;also from LRAPT2
 S C(1)=0
 F  S C(1)=$O(^LAB(T(4),T(3),"JR",C(1))) Q:'C(1)!(LR("Q"))  D
 .I $P(^LAB(T(4),T(3),"JR",C(1),0),"^",7) S T(9)=^(0),T(5)=1 D L
 Q
L ;
 S X=$O(^LAB(T(4),T(3),"JR",C(1),1,0))
 I X K T(5) D
 .S X=0 F  S X=$O(^LAB(T(4),T(3),"JR",C(1),1,X)) Q:'X  D
 ..S Y=$P(^LAB(T(4),T(3),"JR",C(1),1,X,0),"^")
 ..I Y=$E(T(8),1,$L(Y)) S T(5)=1
 Q:'$D(T(5))
 D PGCHK
 Q:LR("Q")
 W ! D PGCHK Q:LR("Q")
 W !,"Reference: "
 D PGCHK Q:LR("Q")
 W !,$P(T(9),"^")
 D PGCHK Q:LR("Q")
 W !,$P(T(9),"^",2)
 D PGCHK Q:LR("Q")
 W !
 I $P(T(9),"^",3) D
 .W $P(^LAB(95,$P(T(9),"^",3),0),"^"),"  vol.",$P(T(9),"^",4)
 .W " pg.",$P(T(9),"^",5)
 S Y=$P(T(9),"^",6) D D^LRU W "  Date: ",Y
 Q
F ;
 D F^LRAPF,^LRAPF
 Q
PGCHK ;
 I $Y>(IOSL-12) D
 .I LRSS="AU" D  Q
 ..I '+$G(LRSF515) D H1^LRAPT Q
 ..D:+$G(LRSF515) FT^LRAURPT,H^LRAURPT
 .D F
 Q
END ;
 W $C(7),!!,"OK TO DELETE THE ",LRAA(1)," FINAL REPORT LIST"
 S %=2 D YN^LRU
 I %=1 K ^LRO(69.2,LRAA,2) S ^LRO(69.2,LRAA,2,0)="^69.23A^0^0" D  Q
 .W $C(7),!,"LIST DELETED !"
 W !!,"FINE, LET'S FORGET IT",!
 Q
