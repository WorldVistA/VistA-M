LRSPS ;AVAMC/REG - CY/EM/SP PATH SEARCH LROPT SELECTOR ; 6/24/86  12:21 PM ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S IOP="HOME" D ^%ZIS,XR^LRU
OPTS W !!,"Select ",LRAA(1)," Search: " R X:DTIME Q:X=""!(X[U)
 F A=1:1 S Y=$P($T(OPT+A),";",3) Q:Y=""  G:$E(X,1)=$P(Y,U,2) DO
 W !!,"Select from:" G LST
DO W " ",$E($P(Y,U,1),7,$L($P(Y,U,1))),! S LROPT=$P(Y,U,3,4) D @LROPT G OPTS
LST W ! F A=1:1 W !,?15,$P($P($T(OPT+A),";",3),U,1) Q:$T(OPT+A)=""
 G OPTS
M S S(7)="MORPHOLOGY",LRSN=61.1,V=2 D ^LRAPSM Q
D S S(7)="DISEASE",LRSN=61.4,V=1 D ^LRAPSM Q
F S S(7)="FUNCTION",LRSN=61.3,V=3 D ^LRAPSM Q
E S S(7)="ETIOLOGY",LRSN=61.2,V=2 D ^LRAPSM Q
P S S(7)="PROCEDURE",LRSN=61.5,V=4 D ^LRAPSM Q
OPT ;OPTION LIST
 ;;M ==> Morphology Code Search, SNOMED^M^M
 ;;D ==> Disease Code Search, SNOMED^D^D
 ;;F ==> Function Code Search, SNOMED^F^F
 ;;E ==> Etiology Code Search, SNOMED^E^E
 ;;P ==> Procedure Code Search, SNOMED^P^P
 ;;I ==> ICD9CM code Search^I^^LRSPSICD
