LRBLDR1 ;AVAMC/REG - DONOR EXAM,COLLECTION ;2/11/94  07:50 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 I G S Y=G(16) D D^LRU W $C(7),!!!!!!,"Donor is in the file as permanently deferred as of ",Y,".",!,"If you have any questions, please see the physician in charge."
 S LRZ=0 I $D(^LRE(W,9)) S DIWR=IOM-5,DIWL=5,DIWF="W" S A=0 F LRZ=0:1 S A=$O(^LRE(W,9,A)) Q:'A  W:'LRZ !! S LRX=^(A,0) D:$Y>(IOSL-6) H Q:LR("Q")  S X=LRX D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW W !,LR("%")
 D H Q:LR("Q")  W !!,"EXAM:",!!,"General appearance:",!!,"Venipuncture site:"
 D H Q:LR("Q")  W !!,"Weight (lb):",?30,"Temp:",?45,"Pulse:",?60,"BP:",!!,"Hb:",?20,"Hct:"
 D H Q:LR("Q")  W !!,"OK to collect unit (Yes or No):"
 D H Q:LR("Q")  W !!,"If not OK to collect reason(s):"
 D H Q:LR("Q")  W !!,"Patient credit:",!!,"Examiner:",?40,"Phlebotomist:"
 D H Q:LR("Q")  W !!,"UNIT NUMBER:",?40,"Bag lot #:"
 D H Q:LR("Q")  W !!,"Time collection started:",?40,"Time completed:"
 D H Q:LR("Q")  W !!,"Donor reaction(s) ? :"
 D H Q:LR("Q")  W !!,"Date/time processed:",!!,"Collected primary unit (gm):",?40,"Empty primary unit container (gm):",!!,"Vol collected (ml):"
 Q
S ;from LRBLDR
 W @IOF,?20,"List of donors for registration forms",!
 S X=-1 F J=1:1 S X=$O(^LRO(69.2,LRAA,5,"C",X)) Q:X=""  F Y=0:0 S Y=$O(^LRO(69.2,LRAA,5,"C",X,Y)),LRQ=1 Q:'Y  D:'$D(^LRE(Y,0)) K I $D(LRQ) W:J#2 ! W:'(J#2) ?40 W $P(^LRE(Y,0),"^")
 Q
D ;from LRBLDR
 W $C(7),!!?15,"Do you really want to delete the list for printing",!?20,"the registration forms " S %=2 D YN^LRU Q:%'=1
 W !!,"OK, LIST DELETED !",!! K ^LRO(69.2,LRAA,5) S ^LRO(69.2,LRAA,5,0)="^69.24A^^" Q
K K ^LRO(69.2,LRAA,5,"C",X,Y),^LRO(69.2,LRAA,5,Y),LRQ Q
H D:$Y>(IOSL-6) H^LRBLDR Q
 ;
A S DIC="^LAB(65.4,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)[""G""",DIC("A")="Select GROUP AFFILIATION: " D ^DIC K DIC Q:Y<1  S A=+Y D WAIT^LRU L +^LRO(69.2,LRAA,5)
 S Y=0 F B=0:1 S Y=$O(^LRE("AB",A,Y)) Q:'Y  S X=$P(^LRE(Y,0),"^"),^LRO(69.2,LRAA,5,Y,0)=Y_"^65.5^"_X,^LRO(69.2,LRAA,5,"C",X,Y)=""
 S X=^LRO(69.2,LRAA,5,0),Y=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_Y_"^"_($P(X,"^",4)+B) L -^LRO(69.2,LRAA,5) W ! Q
