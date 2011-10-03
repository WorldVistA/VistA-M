LRUPS ;AVAMC/REG/WTY - PATIENT SPEC LOOK-UP ;3/20/01
 ;;5.2;LAB SERVICE;**72,248,259,322,362**;Sep 27, 1994;Build 11
 ;Removed space between "No  data" at tag EN
 ;
GETP W ! K LRAN,DIC S X="",DFN=-1,DIC(0)="EQM",(LRX,LRDPF)="" D DPA^LRDPA
 I DFN=-1 S LRAN=-1 Q
I N LRAY
 I '$D(LRPFLG) N LRPFLG S LRPFLG=0
 I LRSS="AU" G AU
EN I '$D(^LR(LRDFN,LRSS))!($P($G(^LR(LRDFN,LRSS,0)),U,3)<1) W $C(7),!!,"No data for ",PNM G GETP
 S (LRI,LRLIDT,E)=0 S:'$D(LRABV) LRABV=0
 I "CYEMSP"'[LRSS W !!,"Count #",?10,"Accession #",?29,"Date",?45,"Site/specimen"
 E  W !!,"Specimen(s)",?30,"Count #",?40,"Accession #",?55,"Date Obtained"
 S C=0
 F  S LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI!(E)  D
 .S X=$G(^LR(LRDFN,LRSS,LRI,0)) Q:X=""  S LRAC=$P(X,U,6)
 .I $P(LRAC," ")=LRABV!(LRABV=0) D WT:C#5=0 Q:E  D
 ..S LRAY=$P(LRAC," ",2)
 ..I LRPFLG,LRAY'=$E(LRAD,2,3) Q
 ..S C=C+1,LRAN=+$P(LRAC," ",3)
 ..S LRAN(C)=LRI_U_LRAN,LRLIDT=LRI
 ..S Y=$P(X,U),LRST=$P(X,U,5) D D^LRU,@($S("CYEMSP"[LRSS:"SP",1:"CY"))
 I 'C W !!,"No specimens entered for "_LRH(0) G GETP
 I C=1 S LRI=+LRAN(1),Y(0)=^LR(LRDFN,LRSS,LRI,0),LRTK=+Y(0) G L
ACC W !?11,"Choose Count #(1-",C,"): " R X:DTIME I X=""!(X[U) S LRAN=-1 Q
 I X'?1N.N W $C(7),!!,"Enter numbers only",!! G ACC
OK I '$D(LRAN(X)) W "  Doesn't exist for ",PNM G ACC
GOT S LRI=+LRAN(X),Y(0)=^LR(LRDFN,LRSS,LRI,0),LRTK=+Y(0)
L S LRAC=$P(Y(0),U,6),LRAN=+$P(LRAC," ",3),Y=$P(Y(0),U) D D^LRU W !!," Accession #: ",LRAC W:Y'[1700 " Date Obtained: ",Y,! S LRWW=$S(Y'[1700:Y,1:"")
 Q
WT I C>0 W !,"More accessions " S %=2 D YN^LRU S E=$S(%=1:0,1:1) Q
 Q
SP W !?30,"(",$J(C,2),")",?40,LRAC,?55,Y I '$P(X,"^",11) W " not verified"
 S LRST=0 F A=0:1 S LRST=$O(^LR(LRDFN,LRSS,LRI,.1,LRST)) Q:'LRST  W:$D(^(LRST,0)) !,$P(^(0),"^")
 Q
CY W !?2,"(",$J(C,2),")",?10,LRAC,?25,Y W:LRST ?45,$S($D(^LAB(61,LRST,0)):$E($P(^(0),U),1,34),1:"") Q
AU S LRND=$G(^LR(LRDFN,"AU"))
 I '$L(LRND) W $C(7),!!,"No autopsy entry for ",LRP,!! S LRAN="?" Q
 S LRAC=$P(LRND,U,6)
 I $P(LRAC," ")'=LRABV W $C(7),!!,"No autopsy accession" S LRAN="?" Q
 S LRAY=$P(LRAC," ",2)
 I LRPFLG,LRAY'=$E(LRAD,2,3) D  Q
 .W $C(7),!!,"No autopsy accession for "_LRH(0) S LRAN="?"
 S LRAN=+$P(LRAC," ",3)
 I 'LRAN S LRAN=-1 W $C(7),!!,"No autopsy # for ",LRP Q
 S Y=+LRND D D^LRU W !,"Autopsy performed: ",Y,"  Acc # ",LRAC
 Q
EN1 ;from LRAPMOD, LRSPRPT, LRSPT
 W ! K DIC,LRAN S DIC(0)="EQM",(LRX,LRDPF)="" D DPA^LRDPA I DFN=-1 S LRAN=-1 Q
 G I
