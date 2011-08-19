LRAPQOR2 ;AVAMC/REG/CYM - QA AUTOPSY DATA ;2/13/97  07:52
 ;;5.2;LAB SERVICE;**155**;Sep 27, 1994
 D FIELD^DID(63,14.5,"","POINTER","LRS") S LRS=LRS("POINTER")_"?:?;" D H1
 F LRA=0:0 S LRA=$O(^TMP($J,LRA)) Q:'LRA!(LR("Q"))  S LRM=0,LRB=$S($D(^LAB(62.5,LRA,0)):^(0),1:"??") D:$Y>(IOSL-6) H1 Q:LR("Q")  W !!,$P(LRB,U),?5,$P(LRB,U,2) D S
 Q:LR("Q")  D ^LRAPQOR3 Q
S S LRI="" F  S LRI=$O(^TMP($J,"S",LRA,LRI)) Q:LRI=""!(LR("Q"))  D:$Y>(IOSL-6) H2 Q:LR("Q")  S LRK=LRI_":",LRK=$P($P(LRS,LRK,2),";") W !!?5,"SERVICE: ",LRK D T
 Q:LR("Q")  W !,"Total QA Codes for ",$P(LRB,U),": ",LRM Q
T S LRL="" F  S LRL=$O(^TMP($J,"S",LRA,LRI,LRL)) Q:LRL=""!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  S LRL(1)=$S(LRL="?":"?",1:$P($G(^DIC(45.7,LRL,0)),U)) W !?7,"TREATING SPECIALTY: ",LRL(1) D M
 Q
M S LRP="" F  S LRP=$O(^TMP($J,"S",LRA,LRI,LRL,LRP)) Q:LRP=""!(LR("Q"))  D:$Y>(IOSL-6) H4 Q:LR("Q")  S LRP(1)=$S(LRP="?":"?",1:$P($G(^VA(200,LRP,0)),U)) W !?10,"CLINICIAN: ",LRP(1) D A
 Q
A S LRC=0 F  S LRC=$O(^TMP($J,"S",LRA,LRI,LRL,LRP,LRC)) Q:'LRC  D
 . Q:(LR("Q"))>0
 . S LRY=$$FMTE^XLFDT(LRC,"D"),LRD=""
 . S LRF=0 F  S LRF=$O(^TMP($J,"S",LRA,LRI,LRL,LRP,LRC,LRF)) Q:LRF']""  D
 .. Q:(LR("Q"))>0  D W Q
 Q
W D:$Y>(IOSL-6) H5 Q:LR("Q")  W !?13,"Autopsy: ",$J(LRF,4),?35,"Date: ",LRY S LRM=LRM+1 Q
 D ^LRAPQOR3 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"QA CODES by SERVICE, TREATING SPECIALTY and CLINICIAN",!,"From ",LRSTR," To ",LRLST Q
H1 D H Q:LR("Q")  W !,LR("%") Q
H2 D H1 Q:LR("Q")  W !,$P(LRB,U),?5,$P(LRB,U,2) Q
H3 D H2 Q:LR("Q")  W !!?5,"SERVICE: ",LRK Q
H4 D H3 Q:LR("Q")  W !?7,"TREATING SPECIALTY: ",LRL(1) Q
H5 D H4 Q:LR("Q")  W !?10,"CLINICIAN: ",LRP(1) Q
