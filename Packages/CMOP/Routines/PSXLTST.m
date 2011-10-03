PSXLTST ;BIR/SAB,HTW-CMOP Printer Test ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 U IO
NEW W "VA (XXX)",?53,"TEST OF ALIGNMENT   /\",?101,"top of form",!!!?53," NAME,PATIENT","   XXX-XX-XXXX"
 I $D(PSXBAR) S X="S",X2="XXX-123456789" W !!!!!!,?53 S X1=$X W @PSXBAR1,X2,@PSXBAR0,!
 E  F NLWS=1:1:6 W !
 W !!!!!!!!?53," 0000000",!!,"<--------Label Boundaries-----------------------><----------Vertical Perforation----------------><----------Vertical Perforation"
 W !!,?53," SIGNATURE___________________","(drug name)"
 W !!!!,"BOTTOM OF FORM \/  ",?53," bottom of form  \/",?101,"BOTTOM OF FORM  \/"
 I $D(PSXBAR) W @IOF Q
 W !,@IOF
 Q
