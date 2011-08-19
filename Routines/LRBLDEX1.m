LRBLDEX1 ;AVAMC/REG/CYM - EX-BLOOD DONORS ;7/3/96  20:44 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S LRP=0 D H S LR("F")=1 F A=1:1 S LRP=$O(^LRO(69.2,LRAA,8,65.5,1,"B",LRP)) Q:LRP=""  F LRI=0:0 S LRI=$O(^LRO(69.2,LRAA,8,65.5,1,"B",LRP,LRI)) Q:'LRI  D L
 G:LR("Q") OUT I $D(^TMP("LRBL",$J)) D H2 Q:LR("Q")  S A=0 F B=0:0 S A=$O(^TMP("LRBL",$J,A)) Q:A=""!(LR("Q"))  D:$Y>(IOSL-6) H2 Q:LR("Q")  W !,A,?15,^TMP("LRBL",$J,A)
OUT K ^TMP("LRBL",$J) D V^LRU,END^LRUTL Q  ;out
T Q:'Y  S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) Q
 ;
L D:$Y>(IOSL-6) H Q:LR("Q")  S W=^LRE(LRI,0),Y=$P(W,"^",3) D T W !,LRP," (Donor #: ",LRI,")",?40,Y,?49,$P(W,"^",2),?52,$J($P(W,"^",5),2),?55,$P(W,"^",6),?62,$S($P(W,"^",4)=1:"YES",1:"NO"),?73,$S($P(W,"^",10):"YES",1:"NO")
 W !,"Reg/edited: " S Y=$P(W,"^",11) D T W Y W:$P(W,"^",7) " cum donations: ",$P(W,"^",7) W:$P(W,"^",8) " total awards: ",$P(W,"^",8) W:$P(W,"^",9) " demog ent/edit by:" S Y=$P(W,"^",9) D:Y EN1 W Y
 K W I $D(^LRE(LRI,1)) S W=^(1),W(6)=$P(X,"^",6) W !,$P(W,"^")," ",$P(W,"^",2)," ",$P(W,"^",3)," ",$P(W,"^",4)," " S X=$P(W,"^",5) W $S(X:$P(^DIC(5,X,0),"^",2),1:"") W:W(6) " ",W(6)
 I $D(W) S W(7)=$P(W,"^",7),W(8)=$P(W,"^",8) W:IOM<($X+22) ! W:W(7) " Home:",W(7) W:IOM<($X+22) ! W:W(8) " Work:",W(8)
 D:$Y>(IOSL-6) EN Q:LR("Q")  S W=0 F B=0:1 S W=$O(^LRE(LRI,1.1,W)) Q:'W!(LR("Q"))  S W(1)=$P(^(W,0),"^",2) W:'B !,"RBC antigens present:" I $D(^LAB(61.3,W,0)) W:IOM<($X+31) ! W "  ",$P(^(0),"^") W:W(1)]"" "(",W(1),")"
 Q:LR("Q")  D:$Y>(IOSL-6) EN Q:LR("Q")  S W=0 F B=0:1 S W=$O(^LRE(LRI,1.2,W)) Q:'W  S W(1)=$P(^(W,0),"^",2) W:'B !,"RBC antigens absent:" I $D(^LAB(61.3,W,0)) W:IOM<($X+31) ! W "  ",$P(^(0),"^") W:W(1)]"" "(",W(1),")"
 Q:LR("Q")  D:$Y>(IOSL-6) EN Q:LR("Q")  S W=0 F B=0:1 S W=$O(^LRE(LRI,1.3,W)) Q:'W  S W(1)=$P(^(W,0),"^",2) W:'B !,"HLA antigens present:" I $D(^LAB(61.3,W,0)) W:IOM<($X+31) ! W "  ",$P(^(0),"^") W:W(1)]"" "(",W(1),")"
 Q:LR("Q")  D:$Y>(IOSL-6) EN Q:LR("Q")  S W=0 F B=0:1 S W=$O(^LRE(LRI,1.4,W)) Q:'W  S W(1)=$P(^(W,0),"^",2) W:'B !,"HLA antigens absent:" I $D(^LAB(61.3,W,0)) W:IOM<($X+31) ! W "  ",$P(^(0),"^") W:W(1)]"" "(",W(1),")"
 Q:LR("Q")  D:$Y>(IOSL-6) EN Q:LR("Q")  S W=0 F B=0:1 S W=$O(^LRE(LRI,2,W)) Q:'W  W:'B !,"Group affiliations:" I $D(^LAB(65.4,W,0)) W:IOM<($X+31) ! W "  ",$P(^(0),"^")
 Q:LR("Q")  D:$Y>(IOSL-6) EN Q:LR("Q")  S W=0 F B=0:1 S W=$O(^LRE(LRI,4,W)) Q:'W  S X=^(W,0) W:'B !,"Donor scheduling/recall:" W:IOM<($X+10) ! W "  ",$$EXTERNAL^DILFD(65.53,.01,"",X)
 Q:LR("Q")  D EN^LRBLDEX2 Q
EN1 ;also from LRBLDEX2
 S Y=$S($D(^VA(200,Y,0)):$P(^(0),"^",2),1:Y) Q
 ;
HDR Q:LR("Q")  I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRAA(1),"   NO DONATIONS SINCE ",LRSTR Q
H D HDR Q:LR("Q")  W !?10,"Donor (Reg #)",?42,"DOB",?48,"SEX",?52,"ABO/Rh",?59,"APHERESIS",?69,"PERM DEFER",!,LR("%") Q
EN ;from LRBLDEX2
 D H Q:LR("Q")  W !,LRP," (Donor #: ",LRI,") <continued from page ",LRQ-1,">" Q
H2 D HDR Q:LR("Q")  W !,"Donor ID",?15,"DONOR NAME",!,LR("%")
