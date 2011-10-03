GMRVLPO2 ;DOT MATRIX HIRMFO/YH-PULSE OX. AND RESPIRATION DATA ;7/15/97
 ;;4.0;Vitals/Measurements;**1,11**;Apr 25, 1997
FOOTER ;PRINT FOOTER
 W ! W:GMRNAM'="" ?$X-3,$E(GMRNAM,1,35) W "   "_$P($G(VADM(2)),"^",2)_"   "_$P($G(VADM(3)),"^",2)_"   "_$P($G(VADM(4)),"^")_" YRS   "_$P($G(VADM),"^",2)
 W ?95,"MEDICAL RECORD" W !,"Unit: "_$S(GMRWARD(1)'="":GMRWARD(1),1:"     "),"   "_"Room: "_$S($P(VAIN(5),"^")'="":$P($P(VAIN(5),"^"),"-",1,2),1:"    "),?95,"Pulse Oximetry/Respiration Graph"
 D INP^VADPT S GMRVHLOC=$P($G(^DIC(42,+$G(VAIN(4)),44)),"^")
 W !,"Division: "_$S(GMRVHLOC>0:$$GET1^DIQ(4,+$$GET1^DIQ(44,+GMRVHLOC,3,"I"),.01,"I"),1:""),?55,"Page "_GMRPGC,?95,"SF 512",!
 W GSTRFIN Q
STLNP ;
 S GMR(GMRI)=$O(^TMP($J,"GMRVG",GMRI,GMRDT,"")) Q:GMR(GMRI)=""
 N GMRVOK S (GMRSITE,GMRSITE(1),GMRINF,GMRVJ)="",GMRVOK=0
 S GMRSITE(1)=$P($G(^TMP($J,"GMRVG",GMRI,GMRDT,GMR(GMRI))),"^"),GMRSITE(2)=$P($G(^(GMR(GMRI))),"^",3),GMRINF=$P($G(^(GMR(GMRI))),"^",4)
 I GMRSITE(1)'="" D  Q:GMRVOK
 .I GMRI="P",(GMRSITE(1)'["RADIAL"),(GMRSITE(1)'["APICAL"),(GMRSITE(1)'["BRACHIAL") S GMRVOK=1 Q
 .S GI=GMRI D SYNOARY^GMRVLGQU
 .Q
 S GI=$S(GMR(GMRI)>0&(GMRI="PO2"):$J(GMR(GMRI),0,1),1:GMR(GMRI))
 I "UNAVAILABLEPASSREFUSED"'[$$UP^XLFSTR(GMR(GMRI)) S GI=GI_$S($P(^TMP($J,"GMRVG",GMRI,GMRDT,GMR(GMRI)),"^",2)'=1:" ",1:"*")
 S $P(GMRLINE(GMRI),"|",GMRNM)=$E(GI_$S(GMRI="R":GMRSITE,GMRI="P"&($L(GMRSITE," ")>3):$P(GMRSITE," "),1:"")_"          ",1,10)
 I GMRI="P" S $P(GMRLINE("P1"),"|",GMRNM)=$E($S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE)_"          ",1,10)
 D SETLN
 I GMRI="PO2",$D(GMRLINE("OX1")) D
 . S $P(GMRLINE("OX3"),"|",GMRNM)=$E(GMRSITE_"          ",1,10)
 . S GMRINF=$P(^TMP($J,"GMRVG",GMRI,GMRDT,GMR(GMRI)),"^",4),(GMRINF(1),GMRINF(2))="" D
 . . I GMRINF="" S $P(GMRLINE("OX1"),"|",GMRNM)="          ",$P(GMRLINE("OX2"),"|",GMRNM)="          "
 . . E  D PO2^GMRVLGQU(.GMRINF) S $P(GMRLINE("OX1"),"|",GMRNM)=$E(GMRINF(1)_"          ",1,10),$P(GMRLINE("OX2"),"|",GMRNM)=$E(GMRINF(2)_"          ",1,10)
 K GI Q
SETLN ;
 S GVAR(GMRI)=""
 I GMRI="PO2" S (GVAR("PO2"),GVAR("OX1"),GVAR("OX2"),GVAR("OX3"))="" Q
 Q
