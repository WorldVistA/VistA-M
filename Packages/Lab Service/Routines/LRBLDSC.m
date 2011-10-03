LRBLDSC ;AVAMC/REG - DONOR SCHEDULING REPORT ;2/18/93  09:01
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W @IOF,!?10,"DONOR SCHEDULING REPORT BY DONATION OR DEFERRAL DATE"
 D B^LRU G:Y<0 END
 S ZTRTN="QUE^LRBLDSC" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRT=$P(^DD(65.54,1.1,0),U,3),LRD=$P(^DD(65.54,1,0),U,3),LRA=LRSDT-1 D L^LRU,S^LRU,H S LR("F")=1
 F LRA=LRA:0 S LRA=$O(^LRE("AD",LRA)) Q:'LRA!(LRA>LRLDT)  S Y=LRA,LRIDT=9999999-LRA D I
 S (LR("N","S"),LR("W","S"),LR("W","S","A"),LR("W","S","H"),LR("W","S","T"),LR("W","S","D"),LR("P","S"),LR("C","S"))=0
 F LRA=0:0 S LRA=$O(^TMP($J,LRA)) Q:'LRA!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  S Y=LRA,LRIDT=9999999-LRSDT D DT^LRU W !!?2,"DONATION OR DEFERRAL DATE: ",Y S LRW=Y D W
 I 'LR("Q") W !!?5,"Total" S LRF=0 F A="N","W","P","C" Q:LR("Q")  I LR(A,"S") W:LRF ! W ?11,$P($P(LRD,A_":",2),";"),?25,":",$J(LR(A,"S"),8) S LRF=1 D:$Y>(IOSL-6) H2 D:A="W" T
 D END^LRUTL,END Q
W S (LR("N"),LR("W"),LR("W","A"),LR("W","H"),LR("W","T"),LR("W","D"),LR("P"),LR("C"))=0
 F LRB=-1:0 S LRB=$O(^TMP($J,LRA,LRB)) Q:LRB=""!(LR("Q"))  F LRI=0:0 S LRI=$O(^TMP($J,LRA,LRB,LRI)) Q:'LRI!(LR("Q"))  S LRE=^(LRI) D:$Y>(IOSL-6) H1 Q:LR("Q")  D Y
 Q:LR("Q")  D:$Y>(IOSL-6) H1
 W !?2,"Subtotal" S LRF=0 F A="N","W","P","C" Q:LR("Q")  I LR(A) W:LRF ! W ?11,$P($P(LRD,A_":",2),";"),?25,":",$J(LR(A),8) S LRF=1 D:$Y>(IOSL-6) H1 D:A="W" B
 Q
B F B="A","H","T","D" Q:LR("Q")  I LR(A,B) W !?13,$P($P(LRT,B_":",2),";"),?24,":",$J(LR(A,B),3) D:$Y>(IOSL-6) H1
 Q
Y S A=$P(LRE,"^",2),B=$P(LRE,"^",3) S LR(A)=LR(A)+1,LR(A,"S")=LR(A,"S")+1 I B]"",$D(LR(A,B)) S LR(A,B)=LR(A,B)+1,LR(A,"S",B)=LR(A,"S",B)+1
 S A=$P($P(LRD,A_":",2),";"),B=$P($P(LRT,B_":",2),";"),Y=$S(LRB:LRB,1:LRA) D DT^LRU W !,$S(Y[":":Y,1:Y_"??:??"),?15,$P(LRE,"^"),?28,A,?43,B,?54,$P(LRE,"^",4) Q
I F LRI=0:0 S LRI=$O(^LRE("AD",LRA,LRI)) Q:'LRI!(LR("Q"))  I $D(^LRE(LRI,5,LRIDT,0)) S X=^(0),A=+X,B=+$P(X,"^",13),^TMP($J,A,B,LRI)=$P(X,"^",4)_"^"_$P(X,"^",2)_"^"_$P(X,"^",11)_"^"_$P(X,"^",5)
 Q
T F B="A","H","T","D" Q:LR("Q")  I LR(A,"S",B) W !?13,$P($P(LRT,B_":",2),";"),?24,":",$J(LR(A,"S",B),4) D:$Y>(IOSL-6) H2
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"DONOR SCHEDULING REPORT FROM ",LRSTR," TO ",LRLST
 W !,"ARRIVAL/APPT",?15,"UNIT ID",?28,"DON/DEF",?43,"DON. TYPE",?54,"PATIENT CREDIT",!,LR("%") Q
H1 D H Q:LR("Q")  W !!?2,"DONATION OR DEFERRAL DATE: ",LRW Q
H2 D H Q:LR("Q")  W !?2,"Total Count: " Q
 ;
END D V^LRU Q
