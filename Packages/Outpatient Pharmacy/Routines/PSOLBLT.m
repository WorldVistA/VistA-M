PSOLBLT ;BHAM ISC/SAB - ALIGNMENT TEST LABEL ; 09/30/92 13:22
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
EN U IO S PSOLTEST=PSOBAR1]""&(PSOBAR0]"") I +$P(PSOPAR,"^",28)=1 D NEW Q
OLD W $C(13),"VA (XXX)",?40,"TEST OF ALIGNMENT   /\",!?60,"top of form",!!?38,"XXX-XX-XXXX",!?3,"NAME,PATIENT"
 I $G(PSOLTEST) S X="S",X2="XXX-123456789" W !!!!,?40 S X1=$X W @PSOBAR1,X2,@PSOBAR0,!!
 E  W !!!!!!!!!
 W "<--------Label Boundries-------->",?38,"<----------Vertical Perforation"
 W !?8,"VA Medical Center",!!?4,"0000000",!!!!!!?5,"Physician",?38,"(drug name)",?60,"bottom of form",!,"(drug name)",?38,"Physician",?60,"\/"
 W @IOF K PSOLTEST Q
NEW W "VA NAME",?54,"TEST OF ALIGNMENT   /\",?102,"TOP OF FORM  /\",!!!?54," NAME,PATIENT","   XXX-XX-XXXX"
 W !!!!!!!,"<-----------Label Boundries-------------------->",?54,"<----------Vertical Perforation---------------><---Vertical Perforation--->"
 I $G(PSOLTEST) S X="S",X2="XXX-123456789" W !!!,?54 S X1=$X W @PSOBAR1,X2,@PSOBAR0,!
 E  F NLWS=1:1:7 W !
 W !!!!!!!!!,?54," Signature_____________________________"
 W !!!,"BOTTOM OF FORM \/  ",?54," BOTTOM OF FORM  \/",?102,"BOTTOM OF FORM  \/"
 W @IOF K PSOLTEST Q
