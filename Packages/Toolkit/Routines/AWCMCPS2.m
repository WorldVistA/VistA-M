AWCMCPS2 ;VISN7/THM-RE-INDEX PARAMETER FILE ; Feb 27, 2004
 ;;7.3;TOOLKIT;**86**;Jan 09, 2004
 ;
 S IOP="HOME" D ^%ZIS K IOP
 ;
EN W @IOF,!!,"Re-index the CPRS Monitor Parameter file (177100.12)",!!
 W !,"Please wait . . . " H 2
 ; re-index .01 field
 K ^AWC(177100.12,"B")
 S DIK="^AWC(177100.12,",DA=1,DIK(1)=".01" D EN^DIK
 W "Finished.",!
 ;
EXIT K %,AWCMTPL,DA,AWCMOPT,DIK
 Q
