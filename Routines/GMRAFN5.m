GMRAFN5 ;HIRMFO/WAA-FDA MEDWATCH FORM ;11/30/95  15:36
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
 S GMRAX=$G(^GMR(120.85,GMRAPA1,"RPT"))
 W ?66,"|1. Name, address & phone #: " I GMRAPG1=1 W $P(GMRAX,U)
 W !,$E(LINE2,1,66),"|" I GMRAPG1=1 W $E($P(GMRAX,U,2)_"  "_$P(GMRAX,U,3)_"  "_$P(GMRAX,U,4),1,63)
 W !,?66,"|" I GMRAPG1=1 W $E($P(GMRAX,U,5),1,63) W:$P(GMRAX,U,6)'="" ", ",$P(^DIC(5,$P(GMRAX,U,6),0),U)," " W:$P(GMRAX,U,7)'="" $P(GMRAX,U,7) W "     ",$P(GMRAX,U,8)
 W !,"Mail to: MedWatch                      or FAX to:",?66,"|",$E(LINE1,68,131)
 W !,"         5600 Fishers Lane                1-800-FDA-0178",?66,"|2. Health professional? |3. Occupation |4. Reported to Mfr."
 W !,"         Rockville, MD 20852-9787",?66,"|"
 I GMRAPG1=1 W ?70,"[",$S($P(GMRAX,U,9)="n":"NO",$P(GMRAX,U,9)="y":"YES",1:" "),"]"
 W ?91,"|" I GMRAPG1=1 W $E($P(GMRAX,U,11),1,14)
 W ?106,"|" I GMRAPG1=1 W ?110,"[",$S($P($G(^GMR(120.85,GMRAPA1,"PTC1")),U,7)'="":"YES",1:"NO"),"]"
 W !,?66,"|",$E(LINE1,68,131)
 W !,?66,"|5. If you don't want your identity disclosed to the Manufacturer,"
 W !,?66,"|   place an ""X"" in the box.["
 I GMRAPG1=1 W $S($P(GMRAX,U,10)="n":"X",1:" "),"]"
 I GMRAPG1'=1 W " ]"
 W !,"FDA Form 3500",?66,"|",$E(LINE2,68,131)
 W !!,"Submission of a report does not constitute an admission that medical personnel or the product caused or contributed to the event."
 W @IOF
 Q
CONCO ;PRINT CONCOMITANT DRUG DATA
 S GMRAX=$G(^TMP($J,"GMR","C",GMRACCT)) K ^TMP($J,"GMR","C",GMRACCT)
 W "    ",$P(GMRAX,U)," " I $P(GMRAX,U,2)'="" W $E($P(GMRAX,U,2),4,5),"/",$E($P(GMRAX,U,2),6,7),"/",$E($P(GMRAX,U,2),2,3)
 I $P(GMRAX,U,3)'="" W "-",$E($P(GMRAX,U,3),4,5),"/",$E($P(GMRAX,U,3),6,7),"/",$E($P(GMRAX,U,3),2,3)
 K GMRAX
 I '$D(^TMP($J,"GMR","C",(GMRACCT+1))) S GMRANOC=0
 Q
