LRBLJPA1 ;AVAMC/REG/CYM - UNIT FINAL DISPOSITION ;02/11/98  09:24 ;
 ;;5.2;LAB SERVICE;**72,203,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D FIELD^DID(65,4.1,"","POINTER","LRD") S LRD=LRD("POINTER")
 D FIELD^DID(65.02,.04,"","POINTER","LRT") S LRT=LRT("POINTER")
 D FIELD^DID(65.03,.02,"","POINTER","LRTINS") S LRTINS=LRTINS("POINTER")
 D FIELD^DID(65,10,"","POINTER","LRTABO") S LRTABO=LRTABO("POINTER")
 D FIELD^DID(65,11,"","POINTER","LRTRH") S LRTRH=LRTRH("POINTER")
 D FIELD^DID(65,8.1,"","POINTER","LRE") S LRE=LRE("POINTER")
 D FIELD^DID(65,8.1,"","POINTER","LRF") S LRF=LRF("POINTER")
 S (LRQ,LRID)=0 D H
 S LR("F")=1 F A=1:1 S LRID=$O(^LRO(69.2,LRAA,8,65,1,"B",LRID)) Q:LRID=""!(LR("Q"))  F LRI=0:0 S LRI=$O(^LRO(69.2,LRAA,8,65,1,"B",LRID,LRI)) Q:'LRI!(LR("Q"))  D R
 Q
R D:$Y>(IOSL-7) H Q:LR("Q")  S X=^LRD(65,LRI,0),Y=$P($G(^(1)),"^"),Z=+$P(X,"^",4),LRP=$P(X,"^"),LRC=$S($D(^LAB(66,Z,0)):$P(^(0),"^"),1:Z) W !!,LRP,?14,LRC,?55,$P(X,"^",3),?66,$P(X,"^",2)
 I Y]"" W !?14,"(Bag Lot #: ",Y,")"
 S Y=$P(X,"^",5) D Y W !,Y W ?18,$P(X,"^",7),?20,$P(X,"^",8) S Y=$P(X,"^",6) D Y W ?24,Y,?37 S Y=$P(X,"^",9) W $S('Y:Y,$D(^VA(200,Y,0)):$P(^(0),"^"),1:""),?65,$J($P(X,"^",10),7,2),?73,$P(X,"^",11)
 S Y=$P(X,"^",12) W:Y !,"Typing charge: ",$J($P(X,"^",12),6,2) S Z=$P(X,"^",13) I Z]"" W:'Y ! W " Shipping invoice:",Z
 S X=$P(X,"^",14) I X]"" W:'Y&(Z="") ! W " Return credit: ",X
 D H4 Q:LR("Q")  S X=^LRD(65,LRI,4),X(1)=$P(X,"^")_":",Y=$P(X,"^",2),X(3)=$P(X,"^",3),X(4)=$P(X,"^",4) D Y W !,$P($P(LRD,X(1),2),";",1),?20,Y,?39,$S('X(3):X(3),$D(^VA(200,X(3),0)):$P(^(0),"^"),1:""),?66 W:X(4)]"" "Pool/div:",X(4)
 I $P(X,"^",5)]"" W !?2,"Shipped to: ",$P(X,"^",5)
 I $O(^LRD(65,LRI,5,0)) D H4 Q:LR("Q")  W !,"Disposition comment(s):" F LRA=0:0 S LRA=$O(^LRD(65,LRI,5,LRA)) Q:'LRA!(LR("Q"))  D:$Y>(IOSL-6) H2 Q:LR("Q")  W !,^LRD(65,LRI,5,LRA,0)
 I $D(^LRD(65,LRI,8)) D H4 Q:LR("Q")  S Y=^(8),X=+Y,W(2)=$P(Y,"^",2),W(3)=$P(Y,"^",3) D AU
 I $O(^LRD(65,LRI,15,0)) D H4 Q:LR("Q")  F LRA=0:0 S LRA=$O(^LRD(65,LRI,15,LRA)) Q:'LRA!(LR("Q"))  S Z=^(LRA,0) D H4 Q:LR("Q")  S Y=$P(Z,"^") D Y,W
 D H4 Q:LR("Q")  I $D(^LRD(65,LRI,6)) S Z=^(6) D:+Z T
 D H4 Q:LR("Q")  D ^LRBLJPA2 Q
Y Q:'Y  S Y=$TR($$FMTE^XLFDT(Y,"5M"),"@"," ")
 I $L($P(Y,"/"))=1 S $P(Y,"/")="0"_$P(Y,"/") ;-->pad for 2 digit day
 I $L($P(Y,"/",2))=1 S $P(Y,"/",2)="0"_$P(Y,"/",2) ;-->pad for 2 digit month
 Q
P Q:'$D(^LR(X,0))  S X(1)=^(0),Y=$P(X(1),"^",3),(LRDPF,X)=$P(X(1),"^",2),X=^DIC(X,0,"GL"),Y=@(X_Y_",0)"),SSN=$P(Y,"^",9) D SSN^LRU Q
T S X=+Z,(Y,X(1))="" D P W !,"Pt transfused:",$P(Y,"^")," ssn:",SSN," ABO:",$P(X(1),"^",5)," Rh:",$P(X(1),"^",6)
 W:$P(Z,"^",2)]"" " Physician:",$P(Z,"^",2) W:$P(Z,"^",6) "(",$P(Z,"^",6),")" S X=$P(Z,"^",5) W:$P(Z,"^",4) " Tx record#:",$P(Z,"^",4)
 W !,"Tx reaction:",$S(X=0:"NO",X:"YES",1:"")," Rx specialty: ",$P(Z,"^",3) W:$P(Z,"^",7) "(",$P(Z,"^",7),")" D H4
 I $O(^LRD(65,LRI,7,0)) W !,"Transfusion comment(s):" F LRA=0:0 S LRA=$O(^LRD(65,LRI,7,LRA)) Q:'LRA!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  W !,^LRD(65,LRI,7,LRA,0)
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRAA(1),!,"DISPOSITION (Date rec'd from: ",LRSTR," to: ",LRLST,")"
 W !,"UNIT ID",?14,"Component",?55,"Invoice #",?66,"Source"
 W !,"Date rec'd",?17,"ABO",?21,"Rh",?24,"Exp date",?36,"Logged-in by",?67,"Cost",?72,"Vol(ml)",!,"Disposition",?21,"Disposition date",?39,"Person entering disposition"
 W !,LR("%") Q
H1 D H Q:LR("Q")  W !,LRP,?14,LRC,"  (continued from pg ",LRQ-1,")" Q
H2 D H1 Q:LR("Q")  W !,"Disposition comment(s):" Q
H3 D H1 Q:LR("Q")  W !,"Transfusion comment(s):" Q
H4 D:$Y>(IOSL-6) H1 Q
AU I X D P W !,"Restricted for:",$P(Y,"^")," ",SSN
 I W(2)]""!(W(3)]"") W ! W:W(2)]"" "Pos/incomplete screen tests:",$P($P(LRE,W(2)_":",2),";") W:W(3)]"" ?40,"Donation type:",$P($P(LRF,W(3)_":",2),";")
 Q
W W !,"Date re-entered: ",Y," Previous disposition: ",$P(Z,"^",2),"  Date: " S Y=$P(Z,"^",3) D Y W Y,!?3,"Previous disp entering person: ",$P(^VA(200,$P(Z,"^",4),0),"^")
 D H4 Q:LR("Q")  W !?3,"Previous shipping invoice: ",$P(Z,"^",5),"  Receiving invoice: ",$P(Z,"^",6)
 D H4 Q:LR("Q")  W !?3,"Previous log-in  person: ",$P(^VA(200,$P(Z,"^",7),0),"^"),!?3,"Previous date logged-in: " S Y=$P(Z,"^",8) D Y W Y W:$P(Z,"^",9)]"" !?3,"Ship to: ",$P(Z,"^",9) Q
