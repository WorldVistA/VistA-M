LRAPH ;AVAMC/REG/CYM - HISTOLOGY RECORD ;7/28-97  07:19
 ;;5.2;LAB SERVICE;**72,173**;Sep 27, 1994
 S LRDICS="SPCYEM" D ^LRAP G:'$D(Y) END W !!,LRO(68)," HISTOPATHOLOGY DATA SHEET"
ASK S %DT="AEX",%DT(0)="-N",%DT("A")="Select ACCESSION DATE: " D ^%DT K %DT G:Y<1 END S LRSDT=Y-.0001,LRLDT=Y+.99 D D^LRU S LRD=Y
 S ZTRTN="QUE^LRAPH",ZTDESC="Histology Data Sheet",ZTSAVE("LR*")="" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D XR^LRU,L^LRU,S^LRU,H S LR("F")=1
 F A=LRSDT:0 S A=$O(^LR(LRXR,A)) Q:'A!(A>LRLDT)  S A(1)=$E(A,2,3) F B=0:0 S B=$O(^LR(LRXR,A,B)) Q:'B  F C=0:0 S C=$O(^LR(LRXR,A,B,C)) Q:'C  D A
 S A=0 F B=0:1 S A=$O(^TMP($J,A)) Q:A=""!(LR("Q"))  S C="" F  S C=$O(^TMP($J,A,C)) Q:C=""!(LR("Q"))  S X=^(C),LRDFN=+X,LRI=$P(X,"^",2) D W
 W:'B !!,"NO ACCESSIONS FOR ",LRD D END^LRUTL,END Q
W F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,E)) Q:'E  S F=$P(^(E,0),U) D:$Y>(IOSL-6) H Q:LR("Q")  W !,C,?10,"|",$E(F,1,30),?41,"|",?51,"|",?61,"|",?71,"|",!,LR("%")
 Q
A I '$D(^LR(B,LRSS,C,0)) K ^LR(LRXR,A,B,C) Q
 S X=^LR(B,LRSS,C,0),Y=$P(X,"^",6) Q:$P(Y," ")'=LRABV  S ^TMP($J,A(1),Y)=B_"^"_C Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,") SHEET ",?37,"ACCESSION DATE: ",LRD
 W !,LR("%"),!,"Accession",?10,"|      SPECIMEN",?41,"|CASSETTE",?51,"| BLOCKS",?61,"| SLIDES",?71,"| STAINS",!,LR("%")
 Q
END D V^LRU Q
