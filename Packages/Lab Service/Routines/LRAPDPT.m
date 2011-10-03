LRAPDPT ;AVAMC/REG/CYM - POW PTS ;2/10/98  22:15 ;
 ;;5.2;LAB SERVICE;**72,114,201**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END D XR^LRU S LRC=0 W !!?25,LRO(68)," SEARCH FOR",!?28,"PRISONER OF WAR VETERANS",!!
DATE D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
DEV S ZTRTN="QUE^LRAPDPT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRB=9999999.98-LRLDT,LRE=9999999.98-LRSDT D L^LRU,S^LRU,H S LR("F")=1
 F A=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
 D W W:IOST'?1"C".E @IOF K ^TMP($J) D END^LRUTL,END Q
LRDFN F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D CK
 Q
CK Q:$P(^LR(LRDFN,0),"^",2)'=2  S DFN=$P(^(0),"^",3),S(4)=""
 I 'LRC Q:$P($G(^DPT(DFN,.52)),"^",5)'="Y"  S X=$P(^(.52),"^",6) S:X X=$S($D(^DIC(22,X,0)):$P(^(0),"^"),1:"") S S(4)=S(4)_"POW " S:$L(X) S(4)=S(4)_" PERIOD "_X
 I LRC=1 S X=$P($G(^DPT(DFN,.322)),"^",10) Q:X'="Y"
 S X=^DPT(DFN,0),LRP=$P(X,"^"),LRDPF=2,SSN=$P(X,"^",9),Y=$P(X,"^",3) D D^LRU,SSN^LRU S ^TMP($J,LRP,SSN)=Y_"^"_S(4)_"^"_LRDFN
 Q
 ;
EN ; Persian gulf registry
 D ^LRAP G:'$D(Y) END D XR^LRU S LRC=1 W !!?25,LRO(68)," SEARCH FOR",!?28,"PERSIAN GULF VETERANS",!! G DATE
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,")",?40,$S('LRC:" POW VETERANS",1:" *PERSIAN GULF SERVICE* "),!,"From: ",LRSTR," to ",LRLST
 W !,"Patient",?40,"DOB",?60,"ID",!,LR("%") Q
H1 D H Q:LR("Q")  W !,LRN,?40,$P(P,"^"),?60,I,!?5,"Continued from page ",LRQ-1 Q
W S LRN=0 F A=0:0 S LRN=$O(^TMP($J,LRN)) Q:LRN=""!(LR("Q"))  S I=0 D A
 Q
A F B=0:0 S I=$O(^TMP($J,LRN,I)) Q:I=""!(LR("Q"))  S P=^(I),LRDFN=+$P(P,"^",3) D:$Y>(IOSL-6) H Q:LR("Q")  W !,LRN,?40,$P(P,"^"),?60,I,!?5,$P(P,"^",2) D @$S(LRSS="AU":"AU",1:"AP") W !,LR("%")
 Q
AP F LRI=LRB:0 S LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI!(LRI>LRE)!(LR("Q"))  S LRX=^(LRI,0) I $P($P(LRX,U,6)," ")=LRABV D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,"Specimen date: ",$$FMTE^XLFDT(+LRX),?40,"Accession number: ",$P(LRX,"^",6)
 Q
AU S X=$G(^LR(LRDFN,"AU")) I $P($P(X,U,6)," ")=LRABV W !,"Autopsy date: ",$$FMTE^XLFDT(+X),?30,"Autopsy number: ",$P(X,"^",6)
 Q
 ;
END D V^LRU Q
