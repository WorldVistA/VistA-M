LRUSE ;AVAMC/REG - ENTER/EDIT SNOMED FIELDS ; 6/2/86  9:12 AM ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
OPTS R !!,"Select SNOMED FIELD to edit: ",X:DTIME Q:X=""!(X["^")
 F A=1:1 S Y=$P($T(OPT+A),";",3) Q:Y=""  G:$E(X,1)=$P(Y,"^",2) DO
 W !!,"Select from:" G LST
DO W " ",$E($P(Y,"^"),7,$L($P(Y,"^"))),! S DR=$P($T(OPT+A),"^",4),F=$P(Y,"^",3)
ASK W ! S (DIC,DIE,DLAYGO)=F,DIC(0)="AEQLM" D ^DIC K DIC,DLAYGO G:Y<1 OPTS S DA=+Y D ^DIE G ASK
LST W ! F A=1:1 W !,?15,$P($P($T(OPT+A),";",3),"^") Q:$T(OPT+A)=""
 G OPTS
OPT ;OPTION LIST
 ;;T ==> Topography Field^T^61^.01;2;3;4;6
 ;;M ==> Morphology Field^M^61.1^.01;2;3;6
 ;;E ==> Etiology Field^E^61.2^.01;2;7;6
 ;;D ==> Disease Field^D^61.4^.01;2;3;6
 ;;F ==> Function Field^F^61.3^.01;2;3;6
 ;;P ==> Procedure Field^P^61.5^.01;2;3;6
 ;;O ==> Occupation Field^O^61.6^.01;2;3;6
