LRAPDEL ;AVAMC/REG - ANAT PATH DELETE DESCRIPTIONS ;8/12/95  07:42 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 D ^LRAP Q:'$D(Y)
 W !!?20,"Remove descriptions from ",LRO(68),!! D B^LRU G:Y<0 END
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 W !!?16,"OK to DELETE DESCRIPTIONS (clinical,pathological)",!?21,"from one date thru the other " S %=2 D YN^LRU I %'=1 W !!?32,"OK, forget it !" G END
 I LRSS'="AU" S (LRK,LRZ)=0,X=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),U,4),1:"Microscopic") W !!,"OK to delete ",X," entries " S %=2 D YN^LRU G:%<1 END S:%=1 LRK=1
 D XR^LRU I LRSS="SP" W !!,"OK to delete Frozen Section Description entries " S %=2 D YN^LRU G:%<1 END S:%=1 LRZ=1
 W ! F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  W "." D LRDFN
OUT W $C(7),!,"OK DONE !" G END
LRDFN F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D @($S("CYEMSP"[LRSS:"I",1:"A"))
 Q
I F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV K ^(.2),^(.3),^(.4),^(.5),^(1),^(1.2),^(4),^(5),^(6),^(7),^(97),^(99) K:LRK ^(1.1) K:LRZ ^(1.3)
 Q
A K ^LR(LRDFN,81),^(82) Q
 ;
EN ;delete free text specimen entries
 S LRDICS="SPCYEM" D ^LRAP Q:'$D(Y)
 W !!,"Remove free text specimen entries from ",LRO(68),!! D B^LRU G:Y<0 END
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99 W !!?16,"OK to DELETE FREE TEXT ENTRIES from",!?16,LRSTR," to ",LRLST S %=2 D YN^LRU I %'=1 W !!?26,"OK, no deletions." G END
 D XR^LRU W ! F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  W "." F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  D K
 W !,$C(7),"OK, DONE." Q
K I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),"^",6)," ")=LRABV K ^(.1)
 Q
 ;
END D V^LRU Q
