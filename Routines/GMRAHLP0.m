GMRAHLP0 ;HIRMFO/YMP,RM-ALLERGY HELP MODULES ;11/16/07  09:06
 ;;4.0;Adverse Reaction Tracking;**41**;Mar 29, 1996;Build 8
 ;DBIA Section
 ;PSNDI - 4554
 ;DIC   - 10006
 ;XLFDT - 10103
EN1 ; PRINT HELP FOR CAUSATIVE AGENT FIELD
 W !?3,"ENTER THE NAME OF THE CAUSATIVE AGENT, 3-30 CHARACTERS."
 Q
HELP ; HELP FOR A/AR LOOKUP
 I $D(GMRAHLP) D:'$D(GMRAL) EN1^GMRADPT D EN1^GMRADSP0(.GMRAL) Q:GMRAOUT
EXHLP W !!?4,"Would you like to see a list of:",!?6,"1  Local Allergies (Food/Drug/Other)",!?6,"2  Drug Classes",!?6,"3  Drug Ingredients",!?6,"4  National Drugs" ;41 Removed file 50 from list
 R !?4,"Select a number (1-4):",X:DTIME S:'$T X="^^" I "^^"[X S:X="^^"!(X="^") GMRAOUT=1 Q  ;41 changed range from 1-5 to 1-4
 I X\1'=X!(X<1)!(X>4) W !?7,$C(7),"ANSWER WITH THE NUMBER (1-4) OF THE SELECTION FOR",!?7,"WHICH YOU WISH TO SEE MORE HELP." G EXHLP ;41 Changed 5 to 4 for selection
 S DIC=$S(X=1:120.82,X=2:50.605,X=3:50.416,1:50.6) D HLPLK ;41 Removed file 50 reference
 G EXHLP
HLPLK ; LOOKUP ON FILE IN DIC
 S DIC(0)="E",X="??" S:DIC=50.416 D="P" S:DIC=50.605 DIC("W")="W ?10,$P(^(0),U,2)",DIC(0)="SE",D="C" ;41 Split line due to length
 I DIC=120.82 D ^DIC Q  ;41 Separate out the call to DIC if it's 120.82
 I DIC=50.6 D DIC^PSNDI(DIC,"GMRA",.DIC,.X,,$$DT^XLFDT) Q  ;41 Changed DIC calls to associated calls in pharmacy
 D IX^PSNDI(DIC,"GMRA",.DIC,D,.X,,$$DT^XLFDT) ;41 Changed DIC calls to associated calls in pharmacy
 Q
