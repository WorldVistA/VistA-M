LRAPSM1 ;AVAMC/REG/CYM - SEARCH BY SNOMED CODE PRINT ;8/13/97  09:58 ;
 ;;5.2;LAB SERVICE;**72,173**;Sep 27, 1994
 S (LR(13),N)=0,T="," S:LRN="" LRN="MANY" D H S LR("F")=1 D H1
 F A=0:1 S N=$O(^TMP($J,"B",N)) Q:N=""!(LR("Q"))  S LRYA=$O(^(N,0)),LRAX=$O(^(LRYA,0)),LR(11)=^TMP($J,LRYA,LRAX) D:$Y>(IOSL-6) H,H1 Q:LR("Q")  D Y
 S H(2)=1 D H,H2 Q:LR("Q")  D L
 D H Q:LR("Q")  W !,?21,"RESULT OF ",LRO(68)," SEARCH: "
 W !,LRAA(1)," PATIENTS WITHIN PERIOD SEARCHED: ",LR(2) W:LRSS'="AU" !,LRO(68)," ACCESSIONS WITHIN PERIOD SEARCHED: ",LR(3)
 I LR(2) W !!,$J(A,5)," OF ",$J(LR(2),5)," PATIENTS(",$J(A*100/LR(2),5,2),"%)"
 I LR(1) W !,$J(LR(13),5)," OF ",$J(LR(1),5)," SNOMED CODE ",S(2),"  SPECIMENS(",$J(LR(13)*100/LR(1),5,2),"%)"
 I LR W !,$J(LR,14)," ORGAN/TISSUE SPECIMENS WITHIN PERIOD SEARCHED",!?15,"(SNOMED TOPOGRAPHY CODE ",S(2)," IS ",$J(LR(1)*100/LR,5,2),"%)"
 Q
Y W ! W:$P(LR(11),"^",7)'=2 "#" W $E(N,1,17),?19,$P(LR(11),"^",5),?25,$P(LR(11),"^",3) S H(2)=0 F B=0:1 S H(2)=$O(^TMP($J,"B",N,H(2))) Q:'H(2)!(LR("Q"))  W:B ! D ABC
 Q
ABC S LRAN=0 F C=0:1 S LRAN=$O(^TMP($J,"B",N,H(2),LRAN)) Q:'LRAN!(LR("Q"))  D PRT
 Q
PRT S LR(11)=^TMP($J,H(2),LRAN) W:C>0 ! W ?27,$P(LR(11),"^",2) W ?31,$J($P(LR(11),"^"),7)
 S LR(7)=0 F E=1:1 S LR(7)=$O(^TMP($J,H(2),LRAN,LR(7))) Q:'LR(7)!(LR("Q"))  S LR(5)=^(LR(7),0),LR(13)=LR(13)+1 D:$Y>(IOSL-6) H3 Q:LR("Q")  W:E>1 ! W ?46,$E(LR(5),1,15) D M1
 Q
M1 S M=0 F Z=1:1 S M=$O(^TMP($J,H(2),LRAN,LR(7),M)) Q:M=""!(LR("Q"))  S LR(6)=^(M) D:$Y>(IOSL-6) H5 Q:LR("Q")  W:Z>1 ! S X=$P(LR(6),"^",2),Y=$S(X]"":16,1:80) W ?62,$E($P(LR(6),"^"),1,Y) W:X]"" ?80,$S(X=0:"Neg",X=1:"Pos",1:"?")
 Q
L F B=0:1 S H(2)=$O(^TMP($J,H(2))) Q:'H(2)!(LR("Q"))  D W
 Q
W S LRAN=0 F C=0:1 S LRAN=$O(^TMP($J,H(2),LRAN)) Q:'LRAN!(LR("Q"))  D PT
 Q
PT D:$Y>(IOSL-6) H,H2 Q:LR("Q")
 S LR(11)=^TMP($J,H(2),LRAN) W !,$P(LR(11),"^"),?16 W:$P(LR(11),"^",7)'=2 "#" W $E($P(LR(11),"^",4),1,15),?33,$P(LR(11),"^",5),?38,$P(LR(11),"^",3),?41,$J($P(LR(11),"^",2),3),?45,$J($P(LR(11),"^",6),5)
 S LR(7)=0 F E=1:1 S LR(7)=$O(^TMP($J,H(2),LRAN,LR(7))) Q:'LR(7)!(LR("Q"))  S LR(5)=^(LR(7),0) D:$Y>(IOSL-6) H4 Q:LR("Q")  W:E>1 ! W ?52,$E(LR(5),1,15) D M
 Q
M S M=0 F Z=1:1 S M=$O(^TMP($J,H(2),LRAN,LR(7),M)) Q:M=""!(LR("Q"))  S LR(6)=^(M) D:$Y>(IOSL-6) H6 Q:LR("Q")  W:Z>1 ! S X=$P(LR(6),"^",2),Y=$S(X]"":11,1:80) W ?69,$E($P(LR(6),"^"),1,Y) W:Y=11 ?86,$S(X=0:"Neg",X=1:"Pos",1:"?")
 Q
H I $D(LR("F")),$E(IOST,1,2)="C-" D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,") SEARCH(",LRSTR,"=>",LRLST,")"
 W !,"# = Not VA patient",!,"SNOMED TOPOGRAPHY CODE: ",S(2)_$E("-----",1,5-$L(S(2))),?46,"SNOMED ",S(7)," CODE: ",LRN_$E("-----",1,5-$L(LRN))
 W !,LR("%") Q
H1 Q:LR("Q")  W !!,?8,"NAME",?19,"ID",?23,"SEX",?27,"AGE",?32,"ACC #",?43,"ORGAN/TISSUE",?62,S(7) W !! Q
H2 Q:LR("Q")  W !!,"ACC #",?16,"NAME",?33,"ID",?37,"SEX",?41,"AGE",?45,"MO/DA",?52,"ORGAN/TISSUE",?69,S(7) Q
H3 D H,H1 Q:LR("Q")  W !,$E(N,1,18),?19,$P(LR(11),"^",5),?25,$P(LR(11),"^",3),?27,$P(LR(11),"^",2),?31,$J($P(LR(11),"^"),7) Q
H4 D H,H2 Q:LR("Q")  W !,$P(LR(11),"^"),?16,$E($P(LR(11),"^",4),1,15),?33,$P(LR(11),"^",5),?38,$P(LR(11),"^",3),?41,$J($P(LR(11),"^",2),3),?45,$J($P(LR(11),"^",6),5) Q
H5 D H3 Q:LR("Q")  W ?43,$E(LR(5),1,15) Q
H6 D H4 Q:LR("Q")  W ?55,$E(LR(5),1,15) Q
