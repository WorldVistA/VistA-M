LRAPQACD ;AVAMC/REG/CYM - ENTER TC/QA CODES ;2/5/97  06:37
 ;;5.2;LAB SERVICE;**72,85,155**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END
 S DR=$S(LRSS="AU":"99",1:".99;.14;9") D ^LRAPDA Q
 ;
EN D ^LRAP G:'$D(Y) END
 W !!?10,"Delete Tissue committee/QA codes from ",LRO(68),!! D B^LRU G:Y<0 END
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 W !!?16,"OK to DELETE TC/QA codes",!?21,"from one date thru another " S %=2 D YN^LRU I %'=1 W !!?32,"OK, forget it !" G END
 D XR^LRU
 W ! F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  W "." D LRDFN
OUT W $C(7),!,"OK DONE !" G END
LRDFN F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D @($S("CYEMSP"[LRSS:"I",1:"A"))
 Q
I F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV K ^(9) S $P(^(0),"^",14)=""
 Q
A K:$P($P($G(^LR(LRDFN,"AU")),U,6)," ")=LRABV ^(99) Q
 ;
END D V^LRU Q
