LRAPST ;AVAMC/REG - TISSUE STAIN LOOK-UP ;8/12/95  14:15 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END D S
GETP W ! D ^LRDPA G:LRDFN<1 END D I G GETP
I I LRSS="AU" S A=0 D AU^LRAPST1 Q:A  G EN
 S (LRI,E)=0
 S C=0 F  S LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI  S X=^(LRI,0) I $P($P(X,U,6)," ")=LRABV D WT:C#5=0 Q:E  S C=C+1,LREP=$P(X,U,6),LREP(C)=LRI_U_LREP,Y=$P(X,U),LRST=$P(X,U,5) D:C=1 P D D^LRU,SEL
 I 'C W !,"No ",LRO(68)," specimens entered" Q
ACC W !?11,"Choose Count #(1-",C,"): " R X:DTIME Q:X=""!(X[U)
 I X'?1N.N W $C(7),!!,"Enter numbers only",!! G ACC
OK I '$D(LREP(X)) W "  Doesn't exist for ",LRP G ACC
GOT S LRI=+LREP(X),LRA=^LR(LRDFN,LRSS,LRI,0),LRTK=+LRA
EN I '$D(IOF) S IOP="HOME" D ^%ZIS
 K LREP S LREP=$P(LRA,U,6),Y=+LRA D D^LRU S LRY=Y,LRW=$S(Y'[1700:Y,1:"")
 S LRM=0 D H I LRSS="AU" D ^LRAPST1 Q
 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A!(LRM[U)  S LRB=^(A,0) D:$Y>(IOSL-3) M Q:LRM[U  W !,$P(LRB,U) D SP
 W ! Q
SP I $D(LRF) S Z=$P(LRB,U,4)_":",Y=$P(LRB,U,3) S:Z=":" Z="" D:Y DD^%DT W:$L($P(LRB,U))>29 ! W ?30,Y,?50,$P($P(LR(1),Z,2),";") Q
 F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,E)) Q:'E!(LRM[U)  S B=0 F F=1:1 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B)) Q:'B!(LRM[U)  S LRB(1)=^(B,0) D:$Y>(IOSL-3) M Q:LRM[U  D T
 Q
T W:F=1 !,LRSS(LRSS,E) W !?3,$P(LRB(1),U),?21,"Stain/Procedure" S Y=$P(LRB(1),U,2) D D^LRU W:Y]"" ?59,Y
 F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,C)) Q:'C!(LRM[U)  S Y=^(C,0),X=$P(Y,U,2),Z=$S("SPCY"[LRSS:$P(Y,U,3),1:"") D:$Y>(IOSL-3) M Q:LRM[U  D W
 Q
W W !?16,$S($D(^LAB(60,C,0)):$P(^(0),U),1:C),?47 W:X $J(X,5) W:Z ?52,"/",Z S Y=$P(Y,U,4) D:Y D^LRU W ?59,Y Q
P W !!,"Specimen(s)",?30,"Count #",?40,"Accession #",?55,"Date" Q
 ;
WT I C>0 W !,"More accessions " S %=2 D YN^LRU W $C(13),$J("",30),$C(13) S E=$S(%=1:0,1:1) Q
 Q
SEL W !?30,"(",$J(C,2),")",?40,$J(LREP,7),?55,Y
 S LRST=0 F A=1:1 S LRST=$O(^LR(LRDFN,LRSS,LRI,.1,LRST)) Q:'LRST  W:$D(^(LRST,0)) !?3,$P(^(0),U) I A#5=0 W !?3,"More specimens " S %=2 D YN^LRU W:%=1 $C(13),$J("",33),$C(13) Q:%'=1
 Q
H W @IOF,LRP," ",SSN(1)," Acc #: ",LREP," Date: ",LRY I $D(LRF) W !?34,"Date  Gross Description/Cutting  Type" Q
 W !?46,$S("AUSPCY"[LRSS:"Slide/Ctrl",1:"Count"),?57,"Last " W $S(LRSS="EM":"section",1:"stain") W:"AUSPEM"[LRSS "/block" W " date" Q
M R !,"'^' TO STOP: ",LRM:DTIME S:'$T LRM=U D:LRM'[U H Q
S ;called by LRAPBS,LRAPSA,LRAPSL,LRAPWR
 D @(LRSS_1) Q
SP1 S LRSS("SP",1)="Paraffin Block",LRSS("SP",2)="Plastic Block",LRSS("SP",3)="Frozen Tissue" Q
CY1 S LRSS("CY",1)="Smear Prep",LRSS("CY",2)="Cell Block",LRSS("CY",3)="Membrane Filter",LRSS("CY",4)="Prepared Slides",LRSS("CY",5)="Cytospin" Q
EM1 S LRSS("EM",1)="Epon Block" Q
AU1 S LRSS("AU",1)="Paraffin Block" Q
 ;
END D V^LRU Q
