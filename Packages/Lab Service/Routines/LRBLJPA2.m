LRBLJPA2 ;AVAMC/REG/CYM - UNIT FINAL DISPOSITION ;6/20/96  07:13 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 I $D(^LRD(65,LRI,10)) S X=^(10),Y=$P(X,U)_":",Z=$P(X,U,2),X(3)=$P(X,U,3) S:Y=":" Y=0 W !,"ABO interp: ",$P($P(LRTABO,Y,2),";",1),"            Tech: ",$S('Z:Z,$D(^VA(200,Z,0)):$P(^(0),U),1:Z),"  ",X(3)
 I $D(^LRD(65,LRI,11)) S X=^(11),Y=$P(X,U)_":",Z=$P(X,U,2),X(3)=$P(X,U,3) S:Y=":" Y=0 W !,"Rh interp:  ",$P($P(LRTRH,Y,2),";",1),"     Tech: ",$S('Z:Z,$D(^VA(200,Z,0)):$P(^(0),U),1:Z),"  ",X(3)
 D H Q:LR("Q")
 F LRA=60,70,80,90 I $O(^LRD(65,LRI,LRA,0)) D H1 Q:LR("Q")  F A=0:0 S A=$O(^LRD(65,LRI,LRA,A)) Q:'A!(LR("Q"))  S A(1)=^(A,0) D H Q:LR("Q")  W !?3,$S($D(^LAB(61.3,A,0)):$P(^(0),"^"),1:A) W:$P(A(1),"^",2)]"" "  (",$P(A(1),"^",2),")"
 D H Q:LR("Q")  I $O(^LRD(65,LRI,9,0)) W !,"Modified to/from:" D D Q:LR("Q")
 D H Q:LR("Q")  I $O(^LRD(65,LRI,2,0)) W !,"Patient xmatched/assigned:" F A=0:0 S A=$O(^LRD(65,LRI,2,A)) Q:'A!(LR("Q"))  S A(1)=^(A,0) D:$Y>(IOSL-6) H3 Q:LR("Q")  D A
 D H Q:LR("Q")  I $O(^LRD(65,LRI,3,0)) W !,"Date unit relocated:" F A=0:0 S A=$O(^LRD(65,LRI,3,A)) Q:'A!(LR("Q"))  S A(1)=^(A,0) D:$Y>(IOSL-6) H6 Q:LR("Q")  D C
 Q
C S Y=+A(1),X=$P(A(1),"^",2)_":",X(3)=$P(A(1),"^",3) D Y^LRBLJPA1 W !,Y," Inspect:",$P($P(LRTINS,X,2),";")," Tech:",$S('X(3):X(3),$D(^VA(200,X(3),0)):$P(^(0),"^"),1:X(3))," ",$P(A(1),"^",4)
 W !?2,"Issued to/rec'd from:",$P(A(1),"^",5),"  For patient:",$P(A(1),"^",6) W:$P(A(1),"^",7) " (",$P(A(1),"^",7),")"
 Q
A S X=A D P^LRBLJPA1 W !,$P(Y,"^")," ssn:",$P(Y,"^",9)," ",$P(X(1),"^",5)," ",$P(X(1),"^",6)," Date assigned:" S Y=$P(A(1),"^",2) D Y^LRBLJPA1 W Y
 F B=0:0 S B=$O(^LRD(65,LRI,2,A,1,B)) Q:'B!(LR("Q"))  S B(1)=^(B,0) D:$Y>(IOSL-6) H4 Q:LR("Q")  S Y=$P(B(1),"^") D Y^LRBLJPA1 D B
 Q
B W !,Y," ",$P(B(1),"^",6)," ",$P(B(1),"^",2) W:$P(B(1),"^",7) "(",$P(B(1),"^",7),")" W " ",$P(B(1),"^",3) W:$P(B(1),"^",8) "(",$P(B(1),"^",8),")"
 S X=$P(B(1),"^",5),Y=$P(B(1),"^",4)_":" W !,"Xmatch tech:",$S('X:X,$D(^VA(200,X,0)):$P(^(0),"^"),1:X)," Result:",$P($P(LRT,Y,2),";",1)
 F C=0:0 S C=$O(^LRD(65,LRI,2,A,1,B,3,C)) Q:'C!(LR("Q"))  S C(1)=^(C,0) D:$Y>(IOSL-6) H5 Q:LR("Q")  W !,C(1)
 Q
D F A=0:0 S A=$O(^LRD(65,LRI,9,A)) Q:'A!(LR("Q"))  S A(1)=^(A,0) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?3,$J(A,2),") ",$P(A(1),"^",2) S X=$P(A(1),"^") W ?20,$S('X:X,$D(^LAB(66,X,0)):$P(^(0),"^"),1:X)
 Q
H D:$Y>(IOSL-6) H1^LRBLJPA1 Q
H1 Q:LR("Q")  W !,$S(LRA=60:"RBC antigen present",LRA=70:"RBC antigen absent",LRA=80:"HLA antigen present",1:"HLA antigen absent"),":" Q
H2 D H1^LRBLJPA1 Q:LR("Q")  W !,"Modified to/from:" Q
H3 D H1^LRBLJPA1 Q:LR("Q")  W !,"Patient xmatched/assigned:" Q
H4 D H1^LRBLJPA1 Q
H5 D H4 Q:LR("Q")  W !,"Crossmatch comment:" Q
H6 D H4 Q:LR("Q")  W !,"Date unit relocated:" Q
