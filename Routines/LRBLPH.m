LRBLPH ;AVAMC/REG - PATIENT DRUG LIST ;2/18/93  09:44
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU S LRDPAF=1 D ^LRDPA G:LRDFN<1 END I +LRDPF'=2 W $C(7),!,"Must be entry in Patient File (2)" G LRBLPH
 W ! S ZTRTN="QUE^LRBLPH" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU
 D H S LR("F")=1
 F X=0:0 S X=$O(^PS(55,DFN,"P",X)) Q:'X  I $D(^(X,0)) S Y=+^(0) I $D(^PSRX(Y,0)) S ^TMP($J,+$P(^(0),"^",6))=0
 F LRX=0:0 S LRX=$O(^TMP($J,LRX)) Q:'LRX  I $D(^PSDRUG(LRX,0)) D:$Y>(IOSL-6) H Q:LR("Q")  W !,"OUTPATIENT PHARMACY ITEM: ",$P(^PSDRUG(LRX,0),"^")
 G:LR("Q") OUT K ^TMP($J) F X=0:0 S X=$O(^PS(55,DFN,"IV",X)) Q:'X  F Y=0:0 S Y=$O(^PS(55,DFN,"IV",X,"AD",Y)) Q:'Y  S ^TMP($J,+^(Y,0))=""
 F LRX=0:0 S LRX=$O(^TMP($J,LRX)) Q:'LRX  I $D(^PS(52.6,LRX,0)) D:$Y>(IOSL-6) H Q:LR("Q")  W !,"IV DRUG: ",$P(^PS(52.6,LRX,0),"^")
 G:LR("Q") OUT K ^TMP($J) F X=0:0 S X=$O(^PS(55,DFN,5,X)) Q:'X  F Y=0:0 S Y=$O(^PS(55,DFN,5,X,1,Y)) Q:'Y  S ^TMP($J,+^(Y,0))=""
 F LRX=0:0 S LRX=$O(^TMP($J,LRX)) Q:'LRX  I $D(^PSDRUG(LRX,0)) D:$Y>(IOSL-6) H Q:LR("Q")  W !,"INPATIENT  PHARMACY ITEM: ",$P(^PSDRUG(LRX,0),"^")
OUT D END^LRUTL,END Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Medication List for ",PNM," ",SSN,!,LR("%") Q
 ;
END D V^LRU Q
