VAQUTL94 ;ALB/JFP - UTILITY ROUTINES; 01-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
PARTIC(ARRAY,PART) ;DOES PATICIAL LOOK UP ON AGIANST INPUT ARRAY
 ;INPUT  : ARRAY -  Array to look agianst (full global reference)
 ;         PART  -  What to look for
 ;OUTPUT : FULL  -  Full value
 ;         -1    -  Error (bad input)
 ;
 ; -- Check input
 Q:($G(ARRAY)="") -1
 Q:($G(PART)="") -1
 ; -- Declare variables
 N PLEN,FULL,SEL,FLEN,EXACT,ENTRY,X,Y
 ; -- Init variables
 S PLEN=$L(PART)
 Q:PLEN=0 -1
 ;
 S FULL="",SEL=0
 F  S FULL=$O(@ARRAY@(FULL))  Q:FULL=""  D
 .S FLEN=$L(FULL)
 .I ($E(FULL,1,PLEN)=PART)&(PLEN=FLEN) S EXACT=FULL Q
 .I $E(FULL,1,PLEN)=PART S SEL=SEL+1,^TMP("VAQSEL",$J,SEL)=FULL
 ;
 Q:$D(EXACT) EXACT ; -- Exact match
 Q:SEL=0 -1 ; -- No particial entries found
 I SEL=1 S FULL=$G(^TMP("VAQSEL",$J,SEL)) K ^TMP("VAQSEL",$J) Q FULL
 ;
 S ENTRY=""
 F  S ENTRY=$O(^TMP("VAQSEL",$J,ENTRY))  Q:ENTRY=""  W !,ENTRY,"     ",$G(^TMP("VAQSEL",$J,ENTRY))
 S DIR("A")="Choose (1-"_SEL_"): "
 S DIR(0)="NAO^1:"_SEL
 D ^DIR K DIR Q:$D(DIRUT) -1
 S X=Y
 I X="" Q -1
 S FULL=$G(^TMP("VAQSEL",$J,X)) K ^TMP("VAQSEL",$J) Q FULL
 QUIT
 ;
DOMKEY(STDE) ;DETERMINES WHICH DOMAIN TO DISPLAY ON STATUS SCREEN
 ;INPUT  : STDE  -  Pointer to status file
 ;OUTPUT : R     -  Pull from request node
 ;         A     -  Pull form athr node
 ;         -1    -  Error (bad input)
 ;
 ; -- Check input
 Q:'$D(STDE) -1
 Q:STDE="" -1
 ; -- Declare variables
 N STATMNU
 ; -- Init variables
 S STATMNU=$P($G(^VAT(394.85,STDE,0)),U,1)
 I (STATMNU="VAQ-AMBIG")!(STATMNU="VAQ-PROC")!(STATMNU="VAQ-TUNSL")!(STATMNU="VAQ-UNACK") Q "R"
 Q "A"
 ;
