IBJPI5 ;ENS/GSS - IBJP5 eIV SITE PARAMETERS SCREEN ;30-AUG-2010
 ;;2.0;INTEGRATED BILLING;**438,497**;31-AUG-10;Build 120
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Electronic Insurance Verification Site Selected Service Type Codes
 ;
 Q
 ;
EN ; main entry point for IBJP EIV SITE SELECTED CODES
 N DIR,I,IBDIRS,IBFLD,IBMAXDSC,IBSTCDF,IBSTCDFI,IBSTCR,X,Y
 ;
 D INIT,BLD
 ;
EXIT ; Exit
 K ^TMP("IBJPI5",$J)
 S VALMBCK="R"
 Q
 ;
INIT ; Initialize
 S IBMAXDSC=1  ; max # of DEFAULT STCs
 ; IBSTCDF=default STC IENs which herein remain unchanged
 S IBSTCDF=$G(^IBE(350.9,1,60)),IBSTCDFI=U_IBSTCDF_U
 Q
 ;
BLD ; Build screen and prompt for action
 N DIR,X,Y
 W @IOF,IORVON,"Service Type Codes",IORVOFF
 W !!,IOUON,"Default Service Type Codes",IOUOFF
 F IBFLD=1:1:IBMAXDSC D
 . S IBSTCR=^IBE(365.013,$P(IBSTCDF,U,IBFLD),0)
 . W:IBFLD#2=1 !
 . W:IBFLD#2=0 ?40 W $J($P(IBSTCR,U,1),2)," - ",$P(IBSTCR,U,2)
 F IBFLD=IBFLD:1:20 W !
 W !,IORVON,"          Enter ?? for more information                                         ",IORVOFF
 W !,"EX  Exit"
 S DIR("A")="Select Action: Exit//"
 S DIR(0)="SAO^EX:Exit^"
 S DIR("?")="^D HELP1^IBJPI5"
 S DIR("??")="^D HELP2^IBJPI5"
 D ACTN
 I $F("^E",X) Q
 G BLD
 ;
ACTN ;
 D ^DIR
 S X=$E(X,1),X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I '$F("^E",X) G ACTN
 Q
 ;
HELP1 ; Display actions in response to '?' entry
 D FULL^VALM1
 W @IOF
 Q
 ;
HELP2 ; Text to display in response to '??' entry
 N DIR
 D FULL^VALM1
 W @IOF
 W !,"The DEFAULT SERVICE TYPE CODES are not editable but defined by CBO."
 W !,"Action available is 'EX' to Exit"
 W !,"Enter '^' to quit."
 Q
