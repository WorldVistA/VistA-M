LRAPQOR1 ;AVAMC/REG/CYM - QA CODE REPORT ;2/12/98  10:46
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
 S LR("QA")=0 W !,"Sort by QA CODE only " S %=2 D YN^LRU G:%<1 END I %=1 S LR("QA")=1
 S ZTRTN="QUE^LRAPQOR1" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRN=0 D XR^LRU,L^LRU,S^LRU,H1 S LR("F")=1
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D I
 F LRA=0:0 S LRA=$O(^TMP($J,LRA)) Q:'LRA  S LRM=0,LRB=$S($D(^LAB(62.5,LRA,0)):^(0),1:"??") D:$Y>(IOSL-6) H1 Q:LR("Q")  W !!,$P(LRB,"^"),?5,$P(LRB,"^",2) D D
 W !!,"Total cases reviewed: ",LRN F P=0:0 S P=$O(^TMP($J,"P",P)) Q:'P  S X=$S($D(^VA(200,P,0)):$P(^(0),"^"),1:"??"),^TMP($J,"C",X,P)=""
  I 'LR("QA") D H3 S LRP="" F LRX=0:0 S LRP=$O(^TMP($J,"C",LRP)) Q:LRP=""!(LR("Q"))  F LR=0:0 S LRT=0,LR=$O(^TMP($J,"C",LRP,LR)) Q:'LR!(LR("Q"))  D W1
 I LRSS="AU",LR("QA") D ^LRAPQOR2
 K ^TMP($J) W:IOST'?1"C".E @IOF D END^LRUTL,V^LRU Q
D F LRC=0:0 S LRC=$O(^TMP($J,LRA,LRC)) Q:'LRC!(LR("Q"))  S LRY=$$FMTE^XLFDT(LRC,"D"),LRD="" F LRF=0:0 S LRD=$O(^TMP($J,LRA,LRC,LRD)) Q:LRD=""  S X=+^(LRD),LRE=$S($D(^VA(200,X,0)):$P(^(0),"^"),1:"??") D W
 W !,"Total QA Codes: ",LRM Q
W D:$Y>(IOSL-6) H2 Q:LR("Q")  W !,LRD,?10,LRY,?24,LRE S LRM=LRM+1 Q
W1 D:$Y>(IOSL-6) H3 W !!,"Pathologist: ",LRP F LRA=0:0 S LRA=$O(^TMP($J,"P",LR,LRA)) Q:'LRA!(LR("Q"))  S LRN=0,LRB=$S($D(^LAB(62.5,LRA,0)):^(0),1:"??") D:$Y>(IOSL-6) H4 Q:LR("Q")  W !,$P(LRB,"^"),?5,$P(LRB,"^",2) D W2
 W !?24,"Total QA Codes: ",$J(LRT,3) Q
W2 F LRD=0:0 S LRD=$O(^TMP($J,"P",LR,LRA,LRD)) Q:'LRD!(LR("Q"))  S LRY=$$FMTE^XLFDT(LRD,"D"),LRE="" F LRF=0:0 S LRE=$O(^TMP($J,"P",LR,LRA,LRD,LRE)) Q:LRE=""!(LR("Q"))  D:$Y>(IOSL-6) H5 Q:LR("Q")  W !,LRE,?10,LRY S LRN=LRN+1
 W !,"Subtotal QA Codes: ",$J(LRN,3) S LRT=LRT+LRN Q
I F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN!(LR("Q"))  D @($S("CYEMSP"[LRSS:"L",1:"A"))
 Q
L Q:'$D(^LR(LRDFN,0))  F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $O(^LR(LRDFN,LRSS,LRI,9,0)) S LRN=LRN+1,X=^LR(LRDFN,LRSS,LRI,0),P=+$P(X,"^",2),Y=$P($P(X,"^",10),"."),A=$P(X,"^",6) D S
 Q
S F LRA=0:0 S LRA=$O(^LR(LRDFN,LRSS,LRI,9,LRA)) Q:'LRA  D U
 Q
U S ^TMP($J,"P",P,LRA,Y,A)="",^TMP($J,LRA,Y,A)=P S:LRSS="AU" ^TMP($J,"S",LRA,S,T,M,Y,A)="" Q
A Q:'$O(^LR(LRDFN,99,0))  Q:'$D(^LR(LRDFN,"AU"))  S X=^("AU"),Y=$P($P(X,"^"),"."),A=$P(X,"^",6),P=$P(X,"^",10),S=$P(X,"^",8),T=$P(X,"^",14),M=$P(X,"^",12),LRN=LRN+1 S:S="" S="?" S:T="" T="?" S:M="" M="?"
 F LRA=0:0 S LRA=$O(^LR(LRDFN,99,LRA)) Q:'LRA  D U
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"QA CODES for ",LRAA(1)," From: ",LRSTR,"  To: ",LRLST Q
H1 D H Q:LR("Q")  W !,"Acc #",?11,$S(LRSS'="AU":"Rec'd",1:"Date"),?24,"Pathologist",!,LR("%") Q
H2 D H1 Q:LR("Q")  W !,$P(LRB,"^"),?5,$P(LRB,"^",2) Q
H3 D H Q:LR("Q")  W !,"Acc #",?10,"Rec'd",!,LR("%") Q
H4 D H3 Q:LR("Q")  W !,"Pathologist: ",LRP Q
H5 D H4 Q:LR("Q")  W !,$P(LRB,"^"),?5,$P(LRB,"^",2) Q
 ;
END D V^LRU Q
