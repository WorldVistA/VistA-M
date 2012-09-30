PSO126EN ;BIR/PW-ENVIRONMENTAL CHECK FOR PATCH 126 ;12/09/02
 ;;7.0;OUTPATIENT PHARMACY;**126**;DEC 1997
CHK525 ;check for .01 holes in 52.5
 K XPDQUIT,PSXQUIT
 W !,"Checking the RX SUSPENSE file (#52.5) for entries with missing #.01 fields",! H 4
 S IEN=0 F I=0:1 W:'(I#100) "." S IEN=$O(^PS(52.5,IEN)) Q:IEN'>0  I +$G(^PS(52.5,IEN,0))'>0 S PSXQUIT=1 W !,IEN
 I $G(PSXQUIT) D
 . S XPDQUIT=1
 . W !!,"The RX SUSPENSE file (#52.5) has been found to have entries without a #.01 field."
 . W !,"Please call NVS to clear this problem."
 . K DIR S DIR(0)="E",DIR("A")="<CR> - to continue" D ^DIR K DIR
 I '$G(XPDQUIT) W !,"No problems with the file were found. Continuing with the installation.",! H 4
 Q
