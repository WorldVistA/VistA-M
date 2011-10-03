FHCTF ; HISC/REL - Clinician Tickler File ;2/13/95  14:21
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter Personal item
 D NOW^%DTC S NOW=% K %
 S %DT="AEFXT",%DT("A")="Date/Time: " W ! D ^%DT G:Y<1 KIL S DAT=Y
 I DAT'>NOW W "  [ Date must be in Future ]" G EN1
E1 R !,"Comment: ",COM:DTIME G:'$T!(COM["^") KIL I COM'?.ANP W *7," ??" G E1
 I $L(COM)>60!(COM?1"?".E) W *7,!,"Enter 1-60 character comment" G E1
 S FHDUZ=DUZ,FHTF=DAT_"^X^"_COM D FILE^FHCTF2
KIL G KILL^XUSCLEAN
