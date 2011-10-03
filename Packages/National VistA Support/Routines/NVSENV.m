NVSENV ;JLS/OIOFO  -  NVSMENU Environment Check              1/21/06  NOON
 ;;1.8
 ;
 ; -- reset defaults to 'NO' for KIDs installation prompts --
 ;
EN S:+$G(XPDENV) XPDDIQ("XPI1","B")="NO",XPDDIQ("XPZ1","B")="NO"
 Q
