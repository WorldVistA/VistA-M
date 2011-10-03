LRAPA ;AVAMC/REG/WTY - ANAT PATH ACCESSIONS PER DAY ;9/25/00
 ;;5.2;LAB SERVICE;**72,248,338**;Sep 27, 1994
 ;
 D ^LRAP G:'$D(Y) END W !!,LRO(68)," ACCESSION/SPECIMEN LIST COUNT BY DAY" D XR^LRU
 D B^LRU G:Y<0 END
 S ZTRTN="QUE^LRAPA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S (C,S)=0,LRSDT=LRSDT-.01,LRLDT=LRLDT+.99 D L^LRU,S^LRU
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  S W=LRSDT\1 D Y
 D H S LR("F")=1 F LRX=0:0 S LRX=$O(^TMP($J,LRX)) Q:'LRX  S Y=LRX,A=^(LRX),C=C+A D D^LRU S LRY=Y D:$Y>(IOSL-6) H Q:LR("Q")  W !,LRY,?25,$J(A,9) I $D(^TMP($J,LRX,1)) S S(1)=^(1),S=S+S(1) W ?45,$J(S(1),9)
 S X=0 F A=0:1 S X=$O(^TMP($J,"P",X)) Q:'X
 W !?25,"---------",?45,"---------"
 W !,"Total number",?25,$J(C,9),?45,$J(S,9)
 W !,"Total Patients: ",A
 K ^TMP($J)
 W:IOST'?1"C".E&($E(IOST,1,2)'="P-"!($D(LR("FORM")))) @IOF
 D END^LRUTL,END
 Q
Y F Y=0:0 S Y=$O(^LR(LRXR,LRSDT,Y)) Q:'Y  D @($S("CYEMSP"[LRSS:"I",1:"A"))
 Q
I S I=0 F  S I=$O(^LR(LRXR,LRSDT,Y,I)) Q:'I  I $P($P($G(^LR(Y,LRSS,I,0)),U,6)," ")=LRABV S ^TMP($J,"P",Y)="" S:'$D(^TMP($J,W)) ^(W)=0 S ^(W)=^(W)+1 I $D(^LR(Y,LRSS,I,.1,0)) S V=$P(^(0),"^",4) S:'$D(^TMP($J,W,1)) ^(1)=0 S ^(1)=^(1)+V
 Q
A I $P($P($G(^LR(Y,"AU")),U,6)," ")=LRABV S ^TMP($J,"P",Y)="" S:'$D(^TMP($J,W)) ^(W)=0 S ^(W)=^(W)+1
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," ACCESSION/SPECIMEN COUNT BY DATE",!?23,"FROM ",LRSTR," TO ",LRLST,!,"DATE",?25,"Accession Count",?45,"Specimen count",!,LR("%") Q
 ;
END D V^LRU Q
