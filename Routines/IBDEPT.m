IBDEPT ;ALB/CJM - ENCOUNTER FORM - installation routine for AICS 2.1 ;OCT 5, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**14**;APR 24, 1997
 ;
 Q
 D AUTOINS^IBDE4 ; auto install tool kit forms and tool kit blocks
 D DONE
 Q
DONE ; Installation has completed - display final messages
 ;
 D NOW^%DTC S IBDEDT("IBEP")=$H
 ;S IBDINIT="IBDE" D ALLDONE^IBD21PT
 ;D MSGE^IBD21PT
 Q
