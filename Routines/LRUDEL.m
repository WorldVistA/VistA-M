LRUDEL ;AVAMC/REG/CYM - DELETE AN AP ACCESSION NUMBER ;2/18/98  10:04 ;
 ;;5.2;LAB SERVICE;**1,72,121,201**;Jul 03, 1997
 D END,^LRAP G:'$D(Y) END D XR^LRU
 W !?22,"Delete an Accession Number",!!
D S %DT("A")="Accession number date: ",%DT="AQE" D ^%DT K %DT Q:Y<1  S (Y,LRAD)=$E(Y,1,3)_"0000" D DATE S LRH(0)=Y
 I '$D(^LRO(68,LRAA,1,LRAD,0)) W $C(7),!!,"No accession numbers for ",LRH(0),! G D
 S H(2)=$E(LRAD,1,3)
N1 K LRNO
 R !!,"Select Accession # : ",LRAN:DTIME Q:LRAN=""!(LRAN["^")
 D REST L -^LRO(69.2,LRAA) I $D(LRDFN),$L($G(LRSS)) L -^LR(LRDFN,LRSS)
 G N1
REST I LRAN'?1N.N W $C(7),!!,"Enter NUMBERS only" Q
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession number ",LRAN," for ",LRH(0)," not in ACCESSION file",!! Q
 L +^LRO(68,LRAA,1,LRAD,1,LRAN):1 I '$T W !!?10,$C(7),"Someone else is editing this entry ",! Q
 L +^LRO(69.2,LRAA):1 I '$T W !!?10,$C(7),"Someone else is editing this entry ",! Q
 S LRND=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRRC=$P(LRND,U,3)
 S LRDFN=+LRND G:'$D(^LR(LRDFN,0)) BAD S Y=^(0),LRPFN=$P(Y,U,2),LRFNAM=$P(^DIC(LRPFN,0),U),LRPF=^(0,"GL"),Y=$P(Y,U,3),LRP=@(LRPF_Y_",0)") W !,$P(LRP,U)," ID: ",$P(LRP,U,9) S Y=$P(LRP,U,3) D DATE W:Y'[1700 " DOB: ",Y
 W !!,"ACC # ",LRAN S Y=LRRC D DATE G:LRSS="AU" DEL^LRAUAW
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)) K ^LRO(68,LRAA,1,LRAD,1,LRAN),^LRO(68,LRAA,1,"AC",DUZ(2),LRAD,LRAN) D T W !,LRAN," Deleted" Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,3),LRSD=+X,LRI=$P(X,"^",5) Q:'LRI
 S X=$G(^LR(LRDFN,LRSS,LRI,0)) I $P(X,"^",3)!($P(X,"^",11))!($P(X,"^",15)) W $C(7),!,"Report completed &/or released, deletion not allowed." Q
 L +^LR(LRDFN,LRSS,LRI):1 I '$T W !!?10,"Someone else is editing this entry ",!,$C(7) Q
 W "  DATE RECEIVED: ",Y,"  OK to DELETE " S %=2 D YN^LRU I %'=1 W $C(7),!?4,"NOT DELETED",!! Q
 D ACC^LR7OB1(LRAA,LRAD,LRAN,"OC") ; Cancel order
 I $D(^LR(LRDFN,LRSS,LRI)) K ^(LRI) I $D(^LR(LRDFN,LRSS,0)) S X=^LR(LRDFN,LRSS,0),X(1)=$O(^(0)),X(2)=$P(X,"^",4)-1,^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_X(2)
 K:LRRC ^LR(LRXR,LRRC,LRDFN,LRI) K ^LR(LRXREF,H(2),LRABV,LRAN,LRDFN,LRI) D K
 K ^LRO(68,LRAA,1,LRAD,1,LRAN),^LRO(68,LRAA,1,"AC",DUZ(2),LRAD,LRAN) K:LRRC ^LRO(68,LRAA,1,LRAD,1,"E",LRRC,LRAN)
 L +^LRO(68,LRAA,1,LRAD,1,0) S X=^LRO(68,LRAA,1,LRAD,1,0),X(1)=$O(^(0)),X(2)=$P(X,"^",4)-1 S:X(2)<1 X(2)=0 S ^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_X(2) L -^LRO(68,LRAA,1,LRAD,1,0)
 D T Q
BAD W $C(7),!!,"Entry not in file",!!
 Q
T ;
 F A=1,2,3,4 I $D(^LRO(69.2,LRAA,A,LRAN)) K ^(LRAN) S X(1)=$O(^LRO(69.2,LRAA,A,0)) S:'X(1) X(1)=0 I $D(^LRO(69.2,LRAA,A,0)) S X=^(0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:X(1),1:($P(X,"^",4)-1))
 Q
 ;
DATE ; Returns the date in eye-readable month format
 S Y=$TR($$FMTE^XLFDT(Y,"M"),"@"," ")
 Q
K ; also from LRAPED
 F A=0:0 S A=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,A)) Q:'A  K ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_A)
 Q
 ;
END D V^LRU Q
