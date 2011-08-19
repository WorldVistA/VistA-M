LRAPTT1 ;AVAMC/REG/CYM - TURNAROUND TIME PATH ;2/13/98  09:42 ;
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,$S('$D(LR("AU")):"",LR("AU")=1:"PAD",1:"FAD")," Turnaround time for ",LRO(68)," (",LRABV,")" W:LRL " (Exceeding ",LRB," ",$S(LRB=1:"day",1:"days"),")" W !,"From: ",LRSTR,"  To: ",LRLST,?57,"Lab work"
 W !,"Acc #",?6,$S(LRSS="AU":"  Performed",1:" Rec'd"),?19,"Entry",?40,"ID",?43,"Typist",?51,$S('$D(LR("AU")):"Released",LR("AU")=2:"Released",1:"Completed"),?61,"Days",?66,"Pathologist",!,LR("%") Q
T R !,"Enter limit in days: ",X:DTIME Q:X=""!(X[U)  I +X'=X!(X<1)!(X>120) W $C(7),!,"Must be 1-120 days." G T
 S LRB=X,LRL=X+1 Q
F S B=0 F A=0:0 S A=$O(LRM(A)) Q:'A  I A'=2,LRM(A) S B=1 Q
 Q:'B  F LRA=0:0 S LRA=$O(LRM(LRA)) Q:'LRA  I LRM(LRA) D:$Y>(IOSL-8) LRAPTT1 Q:LR("Q")  D E
 Q
E W !!,"Total ",$P(^DIC(LRA,0),U)," file cases: ",LRM(LRA) S X=LRM(LRA)-LRF(LRA) W:X !?3,"Incomplete cases:",$J(X,4) W !?3,"Complete   cases:",$J(LRF(LRA),4)
 W:LRF(LRA) !?5,"Average turnaround time (days): ",$J(LRE(LRA)/LRF(LRA),2,2) W:LRL&(LRF(LRA)) ?44,"Cases exceeding limit: ",LRA(LRA)," (",$J(LRA(LRA)/LRF(LRA)*100,2,2),"%)" Q
