LRAPOLD ;AVAMC/REG - ENTER OLD AP ACCESSIONS ;8/12/95  08:04 ;
 ;;5.2;LAB SERVICE;**72,324**;Sep 27, 1994
 S IOP="HOME" D ^%ZIS W @IOF,?20,"Enter old pathology records",!!
 W $C(7),!,"This option skips entering accession number in the Accession Area file.",!?5,"Is this what you want " S %=2 D YN^LRU G:%'=1 END
 D A^LRAPD Q:'$D(Y)  S (LRB,LRC)=1 D XR^LRU
 W !!,"Enter Etiology, Function, Procedure & Disease " S %=2 D YN^LRU G:%<1 END K:%=2 LRB
 W !!,"Enter Special Studies " S %=2 D YN^LRU G:%<1 END K:%=2 LRC
GETP W ! K DIC D ^LRDPA G:LRDFN=-1 END D REST G GETP
REST I '$D(^LR(LRDFN,LRSS,0)) S ^LR(LRDFN,LRSS,0)="^"_LRSF_"DA^0^0"
DT W ! S %DT="AEXT",%DT(0)="-N",%DT("A")="Date (must be exact) specimen taken: " D ^%DT K %DT G:X["?" DT Q:Y<1
 S LRE=Y,LRH="",LRI=9999999-Y D D^LRU S %DT("B")=Y
R W ! S %DT="AEXT",%DT(0)="-N",%DT("A")="Date (must be exact) specimen received: " D ^%DT K %DT G:X["?" R Q:Y<1  I Y<LRE W $C(7),!!,"Date received must be after date taken.",! G R
 S LRAD=Y,LRF=$E(LRAD,1,3) D D^LRU S LRD=Y D A G DT
A R !!,"Enter Accession number: ",LRAN:DTIME Q:LRAN=""!(LRAN[U)  I LRAN'?1N.N!($L(LRAN)>5) W $C(7),!!,"Enter up to 5 numbers",!! G A
 I $D(^LR(LRXREF,LRF,LRABV,LRAN)) S X=+$O(^LR(LRXREF,LRF,LRABV,LRAN,0)) I $D(^LR(X,0)) S X=^(0) D ^LRUP W $C(7),!,"AC #",LRAN," in ",LRO(68)," for ",$E(LRF,2,3),!?5,"Patient: ",LRP,"  ID: ",SSN G A
 I $D(^LR(LRDFN,LRSS,LRI,0)) S LRI=LRI-.00001 D FIX
 L +^LR(LRDFN,LRSS) S ^LR(LRDFN,LRSS,LRI,0)=LRE,^LR(LRDFN,LRSS,0)="^"_LRSF_"DA^"_LRI_"^"_($P(^LR(LRDFN,LRSS,0),"^",4)+1) L -^LR(LRDFN,LRSS)
 N LRAPOLDF
 S LRAPOLDF=1
 S DIE="^LR(LRDFN,LRSS,",DA=LRI,DA(1)=LRDFN,LRAC=LRABV_" "_$E(LRF,2,3)_" "_LRAN D @LRSS,^DIE
 I $D(Y) W $C(7),!!,"All Prompts were not answered  <ENTRY DELETED>" L +^LR(LRDFN,LRSS) K ^LR(LRDFN,LRSS,DA) D X L -^LR(LRDFN,LRSS) Q
FIX Q:'$D(^LR(LRDFN,LRSS,LRI,0))  S LRI=LRI-.00001 G FIX
X I $D(LRH),LRH>1 K ^LR(LRXR,LRH,LRDFN,LRI)
 S X=^LR(LRDFN,LRSS,0),X(1)=+$O(^(0)) S ^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 K ^LR(LRXREF,LRF,LRABV,LRAN,LRDFN,LRI) Q
SP S DR=".1///"_LRD_";S LRH=X;.03//"_LRD_";.02;.11////1;.06///"_LRAC_";10;.99",DR(2,63.12)=".01;S LRJ=$P(^LAB(61,X,0),U,4);S:'LRJ Y=4;2;4;S:'$D(LRB) Y=""@1"";1;1.5;3;@1;S:'$D(LRC) Y=0;5",DR(3,63.16)=".01;I '$D(LRB) S Y=0;1" Q
CY S DR=".1///"_LRD_";S LRH=X;.03//"_LRD_";.02;.11////1;.06///"_LRAC_";10;.99",DR(2,63.912)=".01;4;S:'$D(LRB) Y=""@1"";1;1.5;3;@1;S:'$D(LRC) Y=0;5",DR(3,63.916)=".01;I '$D(LRB) S Y=0;1" Q
EM S DR=".1///"_LRD_";S LRH=X;.03//"_LRD_";.02;.11////1;.06///"_LRAC_";10;.99",DR(2,63.212)=".01;4;S:'$D(LRB) Y=""@1"";1;1.5;3;@1;S:'$D(LRC) Y=0;5",DR(3,63.216)=".01;I '$D(LRB) S Y=0;1" Q
 ;
END D V^LRU Q
