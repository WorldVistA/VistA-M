LRAPPF2 ;AVAMC/REG - ANAT PATH ACC# INDEX ;8/13/95  22:01 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S F=0 F A=0:0 S F=$O(^TMP($J,"S",F)) Q:F=""!(LR("Q"))  S H(4)=F+1700 S:H(4)=1700 H(4)="???" D H Q:LR("Q")  W !,H(4),":",!,"----" D N1
 Q
N1 F N=0:0 S N=$O(^TMP($J,"S",F,N)) Q:'N!(LR("Q"))  S W=^(N) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?6,$J(N,5),?12,$P(W,"^",2),?43,$P(W,"^",3) W:$P(W,"^")'="PATIENT" ?60,$P(W,"^")
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," ACCESSION INDEX (from: ",LRSTR," to: ",LRLST,")"
 W !,"YEAR",?6,"Acc #",?12,"Entry",?43,"Identifier",?65,"File"
 W !,LR("%") Q
H1 D H Q:LR("Q")  W !,"YEAR:",!,"----" Q
