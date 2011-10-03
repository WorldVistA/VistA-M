DGANHD ;ALB/RMO - Driver Routine to Generate NHCU and DOM AMIS's 345-346 ; 29 AUG 90 10:20 am
 ;;5.3;Registration;;Aug 13, 1993
 ;
 D LO^DGUTL
MYR ;Prompt User for AMIS Month/Year
 S DIC("A")="Select AMIS 345-346 MONTH/YEAR: ",DIC="^DGAM(345,",DIC(0)="AELMQ",DLAYGO=42.7 W ! D ^DIC K DIC,DLAYGO G Q:Y<0 S DGMYR=+Y
 ;
CHK ;Check if AMIS has Already been Calculated for Selected Month/Year
 S %=1 I $D(^DGAM(345,DGMYR,"SE")) W !!,"Results already exist for this month. Do you wish to recalculate" S %=2 D YN^DICN G Q:%<0,EN^DGANHD3:%=2 I '% W !!?3,"Enter 'YES' to recalculate monthly totals, or 'NO' to print." G CHK
 ;
GEN ;Prompt User to generate AMIS Code Sheets
 S %=0 D ASK^DGGECSA G Q:%<0 S DGCODFLG=$S(%=1:1,1:0)
 ;
 S (X,DGBOM)=$E(DGMYR,1,5)_"01" D EOM^DGUTL S DGEOM=Y S X1=DGBOM,X2=-1 D C^%DTC S DGPMYR=$E(X,1,5)_"00",DGPEOM=X
 S DGPGM="START^DGANHD",DGVAR="DGCODFLG^DGMYR^DGBOM^DGEOM^DGPMYR^DGPEOM" D ZIS^DGUTQ G Q:POP
 ;
START ;Start AMIS Generation
 U IO K ^UTILITY($J,"DGANHD") D ^DGANHD1
 ;
Q K ^UTILITY($J,"DGANHD"),%,DGBOM,DGCALFLG,DGCODFLG,DGEOM,DGMYR,DGPEOM,DGPGM,DGPMYR,DGVAR,POP,X,X1,X2,Y W ! D CLOSE^DGUTQ
 Q
