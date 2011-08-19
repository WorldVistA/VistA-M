LRAPT2 ;AVAMC/REG/WTY - AUTOPSY PRT ;08/23/01
 ;;5.2;LAB SERVICE;**1,248,259**;Sep 27, 1994
 ;
 N LRSPSM S LRSPSM=0
 S:'$D(LRSF515) LRSF515=0
 D:'LRSF515 FF
 I LRSF515 D:$Y>(IOSL-12) FTR
 S LR("F")=1 Q:LR("Q")
 I '$D(LRD("V")),'$P(^LR(LRDFN,"AU"),U,15) D  Q
 .W !!,"Report not verified."
 S O(2)=^LR(LRDFN,"AU"),X=$P(O(2),"^",8)_":"
 S LRLLOC=$P($P(LRAU("L"),X,2),";"),X=$P(O(2),"^",11)_":"
 S LRAU(3)=$P($P(LRAU("T"),X,2),";")
 W !,"Acc #: ",$P(O(2),"^",6),?32,"AUTOPSY DATA"
 W ?52,"Age: ",$J($P(O(2),"^",9),3)
 I LRSF515 D:$Y>(IOSL-12) FTR Q:LR("Q")
 W !,"Date/time Died",?52,"Date/time of Autopsy"
 I LRSF515 D:$Y>(IOSL-12) FTR Q:LR("Q")
 S DA=LRDFN D D^LRAUAW S Y=LR(63,12) D D^LRU
 W !,Y,?32,$E(LRAU(3),1,18)
 S Y=+O(2) D D^LRU W:Y'[1700 ?52,Y
 I LRSF515 D:$Y>(IOSL-12) FTR Q:LR("Q")
 W ! S TAB=0 F X(1)=7,10 D
 .S Y=$P(O(2),"^",X(1)) Q:Y=""
 .S:$D(^VA(200,Y,0)) Y=$P(^(0),"^")
 .S:X(1)=10 Y=$E(Y,1,19),TAB=52
 .W ?TAB,$S(X(1)=7:"Resident: ",1:"Senior: "),Y
 K TAB
 I '$D(LRD("V")),$D(LR("AU1")),'$P(^LR(LRDFN,"AU"),U,15) D  Q
 .W !!,"Report not verified."
 W ! D EN
 Q:LR("Q")
 D ^LRAPT3
 S:+$G(LR("SPSM")) LRSPSM=1  ;Set flag to suppress SNOMED codes
 S A=0 F F=0:1 S A=$O(^LR(LRDFN,"AY",A)) Q:'A!(LR("Q"))  D
 .I 'F,'LRSPSM D HD
 .S (T(3),T)=+^(A,0),T=^LAB(61,T,0),T(8)=$P(T,"^",2)
 .I 'LRSF515,($Y>(IOSL-6)) D FF D:'LRSPSM HD
 .Q:LR("Q")
 .I LRSF515,($Y>(IOSL-12)) D
 ..D FTR Q:LR("Q")
 ..D:'LRSPSM HD
 .Q:LR("Q")
 .I 'LRSPSM D
 ..W !,"T-",T(8),": "
 ..S X=$P(T,"^") D:$G(LRS(5)) C^LRUA W X
 .S T(4)=61
 .D EN^LRSPRPT1,M
 Q:LR("Q")!($D(LR("W")))
 W !
 I '$D(LRAURPT),$D(^LR(LRDFN,81)) W !,LRAU(1) S LRE=81 D  Q:LR("Q")
 .D F
 .I 'LRSF515,($Y>(IOSL-6)) D FF
 .Q:LR("Q")
 .I LRSF515,($Y>(IOSL-12)) D FTR
 I '$D(LRAURPT),$D(^LR(LRDFN,82)) W !,LRAU(2) S LRE=82 D  Q:LR("Q")
 .D F
 .I 'LRSF515,($Y>(IOSL-6)) D FF
 .Q:LR("Q")
 .I LRSF515,($Y>(IOSL-12)) D FTR
 Q
F ;
 D EE
 S A=0 F LRZ=0:1 S A=$O(^LR(LRDFN,LRE,A)) Q:'A!(LR("Q"))  D
 .S X=^LR(LRDFN,LRE,A,0) D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW Q
EE ;
 K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF="W"
 Q
M ;
 S B=0 F  S B=$O(^LR(LRDFN,"AY",A,2,B)) Q:'B!(LR("Q"))  D
 .S (T(3),M)=+^LR(LRDFN,"AY",A,2,B,0),M=^LAB(61.1,M,0)
 .I 'LRSF515,($Y>(IOSL-6)) D FF D:'LRSPSM HD Q:LR("Q")
 .I LRSF515,($Y>(IOSL-12)) D  Q:LR("Q")
 ..D FTR Q:LR("Q")
 ..D:'LRSPSM HD
 .Q:LR("Q")
 .I 'LRSPSM D
 ..W !?5,"M-",$P(M,"^",2),": "
 ..S X=$P(M,"^") D:$G(LRS(5)) C^LRUA W X
 .S T(4)=61.1
 .D EN^LRSPRPT1,E
 F B=1.4,3.3,4.5 D  Q:LR("Q")
 .S C=0 F  S C=$O(^LR(LRDFN,"AY",A,$P(B,"."),C)) Q:'C!(LR("Q"))  D
 ..S (T(3),M)=+^LR(LRDFN,"AY",A,$P(B,"."),C,0)
 ..D A
 Q
A S (E,T(4))="61."_$P(B,".",2)
 S M=^LAB(E,M,0)
 I 'LRSF515,($Y>(IOSL-6)) D FF D:'LRSPSM HD Q:LR("Q")
 I LRSF515,($Y>(IOSL-12)) D  Q:LR("Q")
 .D FTR Q:LR("Q")
 .D:'LRSPSM HD
 Q:LR("Q")
 I 'LRSPSM D
 .W !?5,$S(B=1.4:"D-",B=3.3:"F-",B=4.5:"P-",1:""),$P(M,"^",2),?12,": "
 .S X=$P(M,"^") D:$G(LRS(5)) C^LRUA W X
 D EN^LRSPRPT1
 Q
E ;
 S C=0 F  S C=$O(^LR(LRDFN,"AY",A,2,B,1,C)) Q:'C!(LR("Q"))  D
 .S (T(3),E)=+^LR(LRDFN,"AY",A,2,B,1,C,0),E=^LAB(61.2,E,0)
 .I $Y>(IOSL-6) D FF D:'LRSPSM HD Q:LR("Q")
 .I 'LRSF515,($Y>(IOSL-6)) D FF D:'LRSPSM HD Q:LR("Q")
 .I LRSF515,($Y>(IOSL-12)) D  Q:LR("Q")
 ..D FTR Q:LR("Q")
 ..D:'LRSPSM HD
 .Q:LR("Q")
 .S T(4)=61.2
 .I 'LRSPSM D
 ..W !?10,"E-",$P(E,"^",2),": "
 ..S X=$P(E,"^") D:$G(LRS(5)) C^LRUA W X
 D EN^LRSPRPT1
 Q
HD ;
 Q:LR("Q")
 W !!,"SNOMED code(s):"
 Q
EN ;from LRAPPF1
 K B
 I $D(^LR(LRDFN,"AW")) D
 .S X=^LR(LRDFN,"AW"),B(9)=$P(X,"^",9),B(1)=$P(X,"^",11,99)
 .W !,"Rt--Lung--Lt  Liver Spleen  Rt--Kidney--Lt  Brain  Body "
 .W "Wt(lb)    Ht(in)"
 I LRSF515 D:$Y>(IOSL-12) FTR  Q:LR("Q")
 I $D(B) D
 .W !,$J($P(X,"^",3),4),?8,$J($P(X,"^",4),4),?14,$J($P(X,"^",5),5)
 .W ?21,$J($P(X,"^",6),5),?28,$J($P(X,"^",7),4),?38,$J($P(X,"^",8),4)
 .W ?45,$J($P(X,"^",10),4),?55,$P(X,"^",2),?68,$P(X,"^")
 I LRSF515 D:$Y>(IOSL-12) FTR
 Q:LR("Q")
 W !! W:$D(B) "Heart(gm)"
 I LRSF515 D:$Y>(IOSL-12) FTR
 Q:LR("Q")
 I $D(^LR(LRDFN,"AV")) D
 .S X=^LR(LRDFN,"AV"),B(2)=$P(X,"^",7,99)
 .W ?12,"TV(cm)  PV(cm)  MV(cm)  AV(cm)  RV(cm)  LV(cm)"
 W ! W:$D(B(9)) $J(B(9),5)
 I LRSF515 D:$Y>(IOSL-12) FTR  Q:LR("Q")
 I $D(B(2)) D  Q:LR("Q")
 .W ?12,$J($P(X,"^"),4),?20,$J($P(X,"^",2),4),?28,$J($P(X,"^",3),4)
 .W ?36,$J($P(X,"^",4),4),?44,$J($P(X,"^",5),4),?52,$J($P(X,"^",6),4)
 .I LRSF515 D:$Y>(IOSL-12) FTR  Q:LR("Q")
 .W !!,"Cavities(ml): Rt--Pleural--Lt  Pericardial  Peritoneal"
 .I LRSF515 D:$Y>(IOSL-12) FTR  Q:LR("Q")
 .W !?14,$J($P(B(2),"^",2),4),?25,$J($P(B(2),"^"),4)
 .W ?33,$J($P(B(2),"^",3),4),?45,$J($P(B(2),"^",4),4)
 I LRSF515 D:$Y>(IOSL-12) FTR Q:LR("Q")
 S DIC="^DD(63,",DIC(0)="Z"
 I $D(B(1)) F B=1:1:8 Q:LR("Q")  D
 .I $P(B(1),"^",B) S X="25."_B D
 ..D ^DIC Q:Y='1
 ..W !,Y(0,0)_": ",$P(B(1),"^",B)
 ..I LRSF515 D:$Y>(IOSL-12) FTR
 Q:LR("Q")
 I $D(^LR(LRDFN,"AWI")) D
 .S Z=^LR(LRDFN,"AWI") F B=1:1:5 Q:LR("Q")  D
 ..I $P(Z,"^",B) S X=$S(B=1:25.9,1:25.9_(B-1)) D
 ...D ^DIC Q:Y=-1
 ...W !,Y(0,0),": ",$P(Z,"^",B)
 ...I LRSF515 D:$Y>(IOSL-12) FTR
 K DIC,X,Y,Z
 Q
FTR ;
 D:LRSS="AU" FT^LRAURPT,H^LRAURPT
 D:LRSS'="AU" F^LRAPF,^LRAPF
 Q
FF ;
 D H1^LRAPT
 Q
