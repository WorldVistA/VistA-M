GMRVORC0 ;HIRMFO/RM,MD-CANCEL AND PURGE ACTIONS FOR AN ORDER ;4/15/95
 ;;4.0;Vitals/Measurements;**6**;Apr 25, 1997
EN1 ; ENTRY FROM ORDER CANCEL ACTIONS
 I +ORSTS=2 W !,$C(7),?3,"Completed orders cannot be discontinued" Q
 D NOW^%DTC S ORETURN("ORSTOP")=%,ORETURN("ORSTS")=1,ORETURN("OREVENT")="" D RETURN^ORX K %,%H
 Q
EN2 ; ENTRY FROM ORDER PURGE ACTIONS
 S DA=ORIFN,DIK="^GMR(120.55," D ^DIK
 Q
ADS ;
 S GMRVDF=$P(GMRVAS,"^"),ORTX=$S($D(GMRVORD(2)):$P(GMRVORD(2),U,5),1:"")
RA W !,"Schedule:"_$S(GMRVDF="":"",1:" "_GMRVDF_"//")_" " R X:DTIME S:'$T X="^"
 I X="",GMRVDF'="" S X=GMRVDF
 I X="" W !?4,$C(7),"This response is required." G RA
 I "^^"[X S GMROUT=1 S:X="^^" DIROUT=1 Q
 S X=$$UP^XLFSTR(X)
 S PSJPP="GMRV",PSJX=X D ENSV^PSJEEU I '$D(PSJX) W !?4,$C(7),"INVALID SCHEDULE" G RA
 I $G(PSJX)?1"?".E G RA
 S X=PSJX G ADSL
YNNS W !?4,"You have selected a non-standard schedule.  Are you sure that ",!?4,"'",PSJX,"' is the schedule that you want" S %=1 D YN^DICN W:'% !?7,$C(7),"ANSWER YES OR NO" G YNNS:'%,RA:%=2 I %=-1 S GMROUT=1 S:%Y="^^" DIROUT=1 Q
ADSL S:$P(GMRVAS,"^")'=PSJX ORTX=$P(ORTX," - ")_" - "_PSJX S GMRVAS=PSJX_"^"_PSJAT_"^"_PSJM K PSJPP,PSJX,PSJAT,PSJM,PSJTS,PSJY
 Q
