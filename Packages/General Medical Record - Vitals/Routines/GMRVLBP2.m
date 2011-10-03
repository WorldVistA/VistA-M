GMRVLBP2 ;HIRMFO/YH-SET GRAPH LOWER BOX DATA ;7/15/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
FOOTER ;PRINT VITAL SIGNS-I/O SHEET FOOTER
 W ! W:GMRNAM'="" ?$X-3,$E(GMRNAM,1,35) W "  "_$P($G(VADM(2)),"^",2)_"  "_$P($G(VADM(3)),"^",2)_"  "_$P($G(VADM(4)),"^")_" YRS   "_$P($G(VADM),"^",2)
 W ?95,"MEDICAL RECORD" W !,"Unit: "_$S(GMRWARD(1)'="":GMRWARD(1),1:"     "),"   "_"Room: "_$S($P(VAIN(5),"^")'="":$P($P(VAIN(5),"^"),"-",1,2),1:"    "),?95,"B/P PLOTTING CHART"
 D INP^VADPT S GMRVHLOC=$P($G(^DIC(42,+$G(VAIN(4)),44)),"^")
 W !,"Division: "_$S(GMRVHLOC>0:$$GET1^DIQ(4,+$$GET1^DIQ(44,+GMRVHLOC,3,"I"),.01,"I"),1:""),?55,"Page "_GMRPGC,?95,"VA STANDARD FORM 512-A",!
 W GSTRFIN Q
STLNP ;
 S GMR(GMRI)=$O(^TMP($J,"GMRVG",GMRI,GMRDT,"")) Q:GMR(GMRI)=""
 S (GMRSITE,GMRSITE(1),GMRINF,GMRVJ)=""
 S GMRSITE(1)=$P($G(^TMP($J,"GMRVG",GMRI,GMRDT,GMR(GMRI))),"^"),GMRSITE(2)=$P($G(^(GMR(GMRI))),"^",3),GMRINF=$P($G(^(GMR(GMRI))),"^",4) I GMRSITE(1)'="" S GI=GMRI D SYNOARY^GMRVLGQU
 I "UNAVAILABLEPASSREFUSED"'[$$UP^XLFSTR(GMR(GMRI)) S GMR(GMRI)=GMR(GMRI)_$S($P(^TMP($J,"GMRVG",GMRI,GMRDT,GMR(GMRI)),"^",2)'=1:" ",1:"*")
 I GMRI="P" D  Q
 . S $P(GMRLINE(GMRI),"|",GMRNM)=$E(GMR(GMRI)_$S($L(GMRSITE," ")>3:" "_$P(GMRSITE," "),1:"")_"          ",1,10)
 . S $P(GMRLINE("P1"),"|",GMRNM)=$E($S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE)_"          ",1,10)
 I GMRI="B" D  Q
 . S $P(GMRLINE(GMRI),"|",GMRNM)=$E(GMR(GMRI)_"          ",1,10)
 . S $P(GMRLINE("D"),"|",GMRNM)=$E($O(^TMP($J,"GMRVG","C",GMRDT,""))_$S($L(GMRSITE," ")>3:" "_$P(GMRSITE," "),1:"")_"          ",1,10)
 . S $P(GMRLINE("BQUAL"),"|",GMRNM)=$E($S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE)_"          ",1,10)
 . S $P(GMRLINE("MAP"),"|",GMRNM)=$E($O(^TMP($J,"GMRVG","M",GMRDT,""))_"          ",1,10)
 K GI Q
