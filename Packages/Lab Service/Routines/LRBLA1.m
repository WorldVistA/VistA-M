LRBLA1 ;AVAMC/REG/CYM - BB ADM DATA ;6/21/96  07:45
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 K LRB D W S LRF=1 D H Q:LR("Q")  D ^LRBLA2
 Q:$O(^TMP("LR",$J,"N","T",0))=""&($O(^TMP("LR",$J,"N","P",0))="")  D H Q:LR("Q")  W !!,"COUNT",?7,"TEMPORARY DEFERRAL REASON"
 F A=0:0 S A=$O(^TMP("LR",$J,"N","T",A)) Q:'A  S Y=^(A),X=9999999-Y,^TMP("LR",$J,"Z",X,A)=Y
 F LRX=0:0 S LRX=$O(^TMP("LR",$J,"Z",LRX)) Q:'LRX!(LR("Q"))  D A Q:LR("Q")
 Q:LR("Q")  D:$Y>(IOSL-6) H Q:LR("Q")  W !!,"PERMANENT DEFERRALS:",!,"--------------------" S LRP=0
 F LRA=0:0 S LRP=$O(^TMP("LR",$J,"N","P",LRP)) Q:LRP=""!(LR("Q"))  F LRB=0:0 S LRB=$O(^TMP("LR",$J,"N","P",LRP,LRB)) Q:'LRB!(LR("Q"))  F LRD=0:0 S LRD=$O(^TMP("LR",$J,"N","P",LRP,LRB,LRD)) Q:'LRD!(LR("Q"))  D D
 Q
D D:$Y>(IOSL-6) H3  Q:LR("Q")  S Y=9999999-LRD D D^LRU S LRY=Y W !!,LRP,?32,"Deferral Date: ",Y K ^TMP($J)
 S LRE=0 F LRG=0:1 S LRE=$O(^LRE(LRB,99,LRE)) Q:'LRE!(LR("Q"))  S LRX=^(LRE,0) D:$Y>(IOSL-6) H4 Q:LR("Q")  S X=LRX D ^DIWP
 D:LRG ^DIWW Q
 ;
A F LRA=0:0 S LRA=$O(^TMP("LR",$J,"Z",LRX,LRA)) Q:'LRA!(LR("Q"))  S LRB=^(LRA),X=$S($D(^LAB(65.4,LRA,0)):^(0),1:""),LRD=$S($P(X,"^",3)]"":$P(X,"^",3),1:$P(X,"^")) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,$J(LRB,4),?7,LRD
 Q
 ;
S S X=" UNITS",LRF=0,LRB("S")="TOTAL"_X,LRB("H")="HOMOLOGOUS"_X,LRB("A")="AUTOLOGOUS"_X,LRB("T")="THERAPEUTIC"_X,LRB("D")="DIRECTED"_X D S^LRU
 S Y=$P(^DD(66,.26,0),"^",3) F T="T","H","A","D","S" F A=1:1 S X=$P(Y,";",A) Q:X=""  S Z=$P(X,":"),LRA(Z)=$P(X,":",2) F B="A","B","C","D","E","F" S ^TMP("LR",$J,T,B,Z)=0
 F T=12:1:20 F E="WA","WD","WH","WT","PA","PD","PH","PT","CA","CD","CH","CT" S ^TMP("LR",$J,"Y",T,E)=0
 F E="WA","WD","WH","WT","PA","PD","PH","PT","CA","CD","CH","CT" S ^TMP("LR",$J,"Y",E)=0
 F T="WH","WA","WT","WD","PH","PA","PT","PD","CH","CA","CT","CD" S ^TMP("LR",$J,T)=0,^(T,"D")=0
 S ^TMP("LR",$J,"N")=0,^("N","P")=0,^("T")=0 Q
W S X="WHOLE BLOOD",LRB("WH")=X_" HOMOLOGOUS",LRB("WA")=X_" AUTOLOGOUS",LRB("WD")=X_" DIRECTED",LRB("WT")=X_" THERAPEUTIC"
 S X="PLASMAPHERESIS",LRB("PH")=X_" HOMOLOGOUS",LRB("PA")=X_" AUTOLOGOUS",LRB("PT")=X_" THERAPEUTIC",LRB("PD")=X_" DIRECTED"
 S X="CYTAPHERESIS" S LRB("CH")=X_" HOMOLOGOUS",LRB("CA")=X_" AUTOLOGOUS",LRB("CT")=X_" THERAPEUTIC",LRB("CD")=X_" DIRECTED"
 S LRB("N")="NO DONATION" Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Blood Bank Administrative Data from: ",LRSTR," to ",LRLST W:LRC !,"DIVISION: ",LRC(2) W !,LR("%") Q:LRF
 W !,"| ",LRB(LRB),?20,"|",?30,"SOURCE",?40,"|",?50,"INVENTORY DISPOSITION",?79,"|"
 W !,LR("%"),!,"|",?5,"COMPONENT",?20,"|Prepared",?30,"|Received",?40,"|Transfused",?51,"|Shipped",?59,"|Outdated",?69,"|Discarded",?79,"|",!,LR("%")
 Q
H1 D H Q:LR("Q")  W !,"COUNT",?7,"TEMPORARY DEFERRAL REASON" Q
H3 D H Q:LR("Q")  W !,"PERMANENT DEFERRALS:" Q
H4 D H3 Q:LR("Q")  W !,LRP,?31,"Deferral Date: ",LRY Q
