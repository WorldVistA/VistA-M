PSNVER ;BIR/WRT-Allows user to verify one or several drug matches ; 10/18/98 13:03
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 S PSNFL=0 D EXPLN F PSNMM=1:1 D START S:'$D(PSNFL) PSNFL=0 Q:PSNFL
DONE W !!,"Remember, these matches, after verified, must then be merged using the",!,"option ""Merge National Drug File Data Into Local File"".",! K PSNMM,PSNFL,X,Y,PSNB,PSNDEA,PSNINACT D KILL Q
EXPLN W !!,"Enter name of drug from your local drug file and if the",!,"drug has been matched, you will be asked to verify the match.",!,"Press return at the ""Select DRUG GENERIC NAME: "" prompt to exit.",! Q
START D KILL S DIC="^PSDRUG(",DIC(0)="QEA" D ^DIC K DIC I Y<0 S PSNFL=1 Q
 S (PSNB,PSNDRG)=+Y,PSNLOC=$P(Y,"^",2)
 I '$D(^PSNTRAN(+Y,0)) W !,"This entry has not been matched to verify.",! Q
 I $D(^PSNTRAN(+Y,0)),$P(^PSNTRAN(+Y,0),"^",2)']"" W !,"This entry has not been matched to verify.",! Q
 I $D(^PSNTRAN(+Y,0)),$P(^PSNTRAN(+Y,0),"^",9)="Y" W !,"This entry has already been verified.",! Q
 I $D(^PSDRUG(PSNB,"I")),$P(^PSDRUG(PSNB,"I"),"^")<DT W !!,"This drug is ""Inactive"". Please try again.",!
VERIFY D CHK^PSNVFY
 Q
KILL D KILL^PSNVFY K PSNDRG
 Q
