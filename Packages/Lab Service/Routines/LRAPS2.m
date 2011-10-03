LRAPS2 ;AVAMC/REG - AUTOPSY PRT ;8/11/95  09:36 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S LR("M")=1,LRSS="AU" D ^LRAPU S X=$S($D(^LRO(69.2,+Y,0)):^(0),1:""),LRAU(3)=$P(X,"^",3),LRAU(4)=$P(X,"^",4)
 R:IOST["C-" !!,"Press RETURN key ",X:DTIME D ZZ I '$P(^LR(LRDFN,"AU"),U,15) W !!,"Report not verified." Q
 I $D(^LR(LRDFN,81)) W !,LRAU(3) S LRV=81 D F I $D(A("M")) K A("M") Q
 I $D(^LR(LRDFN,82)) W !,LRAU(4) S LRV=82 D F I $D(A("M")) K A("M") Q
 Q:'$D(^LR(LRDFN,"AW"))&('$D(^("AY")))&('$D(^("AWI")))
 D M I $D(A("M")) K A("M") Q
 D WT,M I $D(A("M")) K A("M") Q
 D ^LRAPT3,M I $D(A("M")) K A("M") Q
 I $D(^LR(LRDFN,"AY",0)),$P(^LR(LRDFN,"AY",0),"^",4)>0 D HD F O=0:0 S O=$O(^LR(LRDFN,"AY",O)) Q:'O!($D(A("M")))  D:$Y>(IOSL-3) M Q:$D(A("M"))  W !,$P(^LAB(61,+^LR(LRDFN,"AY",O,0),0),"^") D D
 I $D(A("M")) K A("M") Q
 K A("M") Q
F D EX S LR=0 F LRZ=0:1 S LR=$O(^LR(LRDFN,LRV,LR)) Q:'LR  D:$Y>(IOSL-3) M Q:$D(A("M"))  S X=^LR(LRDFN,LRV,LR,0) D ^DIWP
 Q:$D(A("M"))  D:LRZ ^DIWW Q
EX K ^TMP($J) S DIWR=75,DIWL=3,DIWF="W" Q
D F LRB=0:0 S LRB=$O(^LR(LRDFN,"AY",O,1,LRB)) Q:'LRB  D:$Y>(IOSL-3) M Q:$D(A("M"))  W !?5,$P(^LAB(61.4,+^LR(LRDFN,"AY",O,1,LRB,0),0),"^")
 Q:$D(A("M"))
 F LRB=0:0 S LRB=$O(^LR(LRDFN,"AY",O,3,LRB)) Q:'LRB  D:$Y>(IOSL-3) M Q:$D(A("M"))  W !?5,$P(^LAB(61.3,+^LR(LRDFN,"AY",O,3,LRB,0),0),"^")
 Q:$D(A("M"))
 F LRB=0:0 S LRB=$O(^LR(LRDFN,"AY",O,4,LRB)) Q:'LRB  D:$Y>(IOSL-3) M Q:$D(A("M"))  W !?5,$P(^LAB(61.5,+^LR(LRDFN,"AY",O,4,LRB,0),0),"^")
 Q:$D(A("M"))
 S M=0 F C=1:1 S M=$O(^LR(LRDFN,"AY",O,2,M)) Q:'M  D:$Y>(IOSL-3) M Q:$D(A("M"))  W !?5,$P(^LAB(61.1,+^LR(LRDFN,"AY",O,2,M,0),0),"^") D E
 Q
E S E=0 F F=1:1 S E=$O(^LR(LRDFN,"AY",O,2,M,1,E)) Q:'E  W !?7,$P(^LAB(61.2,+^LR(LRDFN,"AY",O,2,M,1,E,0),0),"^")
 Q
HD W !!,"Organ/tissue:",?33,"SNOMED CODING" Q
M I IOST["C-" R !,"'^' TO STOP: ",X:DTIME S:'$T X="^" S:X["^" A("M")=1 I X]"",X'["^" W $C(7) G M
 Q:$D(A("M"))  D ZZ Q
WT K B I '$D(^LR(LRDFN,"AW")) W !!?20,"No organ weights entered.",! Q
 I $D(^LR(LRDFN,"AW")) S X=^("AW"),B(9)=$P(X,"^",9),B(1)=$P(X,"^",11,99) W !!,"Rt--Lung--Lt  Liver Spleen  R--Kidney--Lt  Brain  Body Wt(lb)    Ht(in)"
 I $D(B) W !,$J($P(X,"^",3),4),?8,$J($P(X,"^",4),4),?14,$J($P(X,"^",5),5),?21,$J($P(X,"^",6),5),?28,$J($P(X,"^",7),4),?38,$J($P(X,"^",8),4),?45,$J($P(X,"^",10),4),?55,$P(X,"^",2),?68,$P(X,"^")
 W !! W:$D(B) "Heart(gm)" I $D(^LR(LRDFN,"AV")) S X=^("AV"),B(2)=$P(X,"^",7,99) W ?12,"TV(cm)  PV(cm)  MV(cm)  AV(cm)  RV(cm)  LV(cm)"
 W ! W:$D(B(9)) $J(B(9),5) I $D(B(2)) W ?12,$J($P(X,"^"),4),?20,$J($P(X,"^",2),4),?28,$J($P(X,"^",3),4),?36,$J($P(X,"^",4),4),?44,$J($P(X,"^",5),4),?52,$J($P(X,"^",6),4)
 I $D(B(2)) W !!,"Cavities(ml): Rt--Pleural--Lt  Pericardial  Peritoneal",!?14,$J($P(B(2),"^",2),4),?25,$J($P(B(2),"^"),4),?33,$J($P(B(2),"^",3),4),?45,$J($P(B(2),"^",4),4)
 I $D(B(1)) F B=1:1:8 I $P(B(1),"^",B) S X="25."_B W !,$P(^DD(63,X,0),"^"),": ",$P(B(1),"^",B)
 I $D(^LR(LRDFN,"AWI")) S Y=^("AWI") F B=1:1:5 I $P(Y,"^",B) S X=$S(B=1:25.9,1:25.9_(B-1)) W !,$P(^DD(63,X,0),"^"),": ",$P(Y,"^",B)
 Q
ZZ W @IOF,"Acc #",?10,"Date/time Died",?32,"Age",?40,"AUTOPSY",?52,"Date/time of Autopsy"
 S X=^LR(LRDFN,"AU"),LRLLOC=$P(X,"^",8) S DA=LRDFN D D^LRAUAW S Y=LR(63,12) D D^LRU W !,$P(X,"^",6)," ",Y,?26,$J($P(X,"^",9),3),?35,LRP S Y=+X D D^LRU W:Y'[1700 ?52,Y
 W ! F X(1)=7,10 S Y=$P(X,"^",X(1)),Y=$S(Y="":Y,$D(^VA(200,Y,0)):$P(^(0),"^"),1:Y) W:Y]"" $S(X(1)=7:"Resident:",1:"  Senior:"),Y
 Q
