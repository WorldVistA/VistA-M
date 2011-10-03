LRSPSICP ;AVAMC/REG - SEARCH BY ICD CODE PRINT ;8/15/95  08:50 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S N=0 D H,H1 S LR("F")=1
 F A=0:1 S N=$O(^TMP($J,"B",N)) Q:N=""!(LR("Q"))  S V(2)=$O(^(N,0)),V(3)=$O(^(V(2),0)),V=^TMP($J,V(2),V(3)) D:$Y>(IOSL-6) H,H1 Q:LR("Q")  W !,$E(N,1,18),?19,$P(V,"^",5),?25,$P(V,"^",3) D A
 S H(2)=1 D H,H2 Q:LR("Q")  D L
 Q
A S H(2)=0 F B=0:1 S H(2)=$O(^TMP($J,"B",N,H(2))) Q:'H(2)!(LR("Q"))  D ABC
 Q
ABC S LRAN=0 F C=0:1 S LRAN=$O(^TMP($J,"B",N,H(2),LRAN)) Q:'LRAN!(LR("Q"))  D PRT
 Q
PRT S V=^TMP($J,H(2),LRAN) W:C>0 ! W ?27,$P(V,"^",2) W ?31,$J($P(V,"^"),7),?39,$E($P(V,"^",8),1,18)
 S O=0 F Z=1:1 S O=$O(^TMP($J,H(2),LRAN,O)) Q:'O!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  W:Z>1 ! W ?58,$E(^(O),1,21)
 Q
L F B=0:1 S H(2)=$O(^TMP($J,H(2))) Q:'H(2)!(LR("Q"))  D LRAN
 Q
LRAN S LRAN=0 F C=0:1 S LRAN=$O(^TMP($J,H(2),LRAN)) Q:'LRAN!(LR("Q"))  D PT
 Q
PT D:$Y>(IOSL-6) H,H2 Q:LR("Q")
 S V=^TMP($J,H(2),LRAN) W !,$J($P(V,"^"),7),?9,$E($P(V,"^",4),1,18),?28,$P(V,"^",5),?34,$P(V,"^",3),?37,$J($P(V,"^",2),3),?41
 W $J($P(V,"^",6),5),?47,$E($P(V,"^",8),1,15) S O=-1 F Z=1:1 S O=$O(^TMP($J,H(2),LRAN,O)) Q:'O!(LR("Q"))  D:$Y>(IOSL-6) H4 Q:LR("Q")  W:Z>1 ! W ?65,$E(^(O),1,14)
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," SEARCH (",LRSTR,"=>",LRLST,")"
 W !!,"ICD CODE: ",I(1),?30,I
 W !,LR("%") Q
H1 Q:LR("Q")  W !!,?8,"NAME",?19,"ID",?23,"SEX",?27,"AGE",?32,"ACC #",!! Q
H2 Q:LR("Q")  W !!,"ACC #",?9,"NAME",?28,"ID",?33,"SEX",?37,"AGE",?41,"MO/DA" Q
H3 D H,H1 Q:LR("Q")  W !,$E(N,1,18),?19,$P(V,"^",5),?25,$P(V,"^",3),?27,$P(V,"^",2),?31,$J($P(V,"^"),7) Q
H4 D H,H2 Q:LR("Q")  W !,$J($P(V,"^"),7),?9,$E($P(V,"^",4),1,18),?28,$P(V,"^",5),?34,$P(V,"^",3),?37,$J($P(V,"^",2),3),?41,$J($P(V,"^",6),5) Q
