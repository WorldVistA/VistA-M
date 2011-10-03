LRBLPP ;AVAMC/REG - BB PATIENT PRINT OPTS ; 7/18/88  07:0 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S X="BLOOD BANK" D ^LRUTL Q:Y=-1
 W @IOF W ?31,"Blood Bank Patient Print Options"
OPTS ;
 R !!,"Select Blood Bank Patient Print Option: ",X:DTIME Q:X=""!(X[U)
 F A=1:1 S Y=$P($T(OPT+A),";",3) Q:Y=""  G:$E(X,1)=$P(Y,U,2) DO
 W !!,"Select from:" G LST
DO W " ",$E($P(Y,U,1),7,$L($P(Y,U,1))),! S LROPT=$P(Y,U,3,4) D @LROPT G OPTS
LST F A=1:1 W !,?15,$P($P($T(OPT+A),";",3),U,1) Q:$T(OPT+A)=""
 G OPTS
T S (BY,FLDS)="[LRBL TRANSFUSION REACTIONS]" G SET
SET D V^LRU S L=0,DIC="^LRD(65," K IOP G EN1^DIP
OPT ;;OPTION LIST
 ;;D ==> Display Blood bank record^D^^LRBLPD
 ;;T ==> Transfusion reactions report^T^T
