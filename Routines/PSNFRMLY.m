PSNFRMLY ;BIR/WRT-formulary report routine ;09/26/98 11:08
 ;;4.0; NATIONAL DRUG FILE;**5**; 30 Oct 98
 W !!,"This report gives you a printed copy of formulary drugs from your local file",!,"with synonyms marked as trade names. You"
 W " will be asked if you want to include",!,"supply items. You are asked to type in a title for this report.",!,"You are then asked to print by Generic Name/Tradename or VA Class Code."
 W !,"If you choose to print by VA Class Code, it"
 W " will ask you to pick a range",!,"of VA Drug Class Codes."
 W " Only active drugs will print. Drugs with",!,"a future inactive date will print as well."
 W !,"You may queue the report to print, if you wish.",!! D SUPPLY Q:$D(DIRUT)
HEADER R !,"Enter title for report: HOSPITAL// ",PSNANS:DTIME S:'$T PSNANS="^" S:PSNANS']"" PSNANS="HOSPITAL" G:"^"[$E(PSNANS) KILL
 I $D(PSNANS),PSNANS?.E1C.E K PSNANS G HEADER
 I $D(PSNANS),$L(PSNANS)>30 W !,"Your answer must 30 characters or less.",! K PSNANS G HEADER
 I $D(PSNANS),"@"[$E(PSNANS) W !,"You cannot delete. This is a free text field. Please enter the name that you",!,"want to print at the top of this report.",! K PSNANS G HEADER
 I $D(PSNANS),"?"[$E(PSNANS) W !!,"Enter the name you want to print. This name will print at the top of this report",!,"along with the word ""FORMULARY""." D UPAR^PSNHELP K PSNANS G HEADER
 I $D(PSNANS) I PSNANS'="^" D ASKEM I $D(PSNANSR),PSNANSR="^" K PSNANS,PSNANSR
 Q
BEGIN K ^TMP($J) S DIC="^PSDRUG(",L=0,FLDS="[PSNFRMPRT]",BY="@VA CLASSIFICATION",DHD="@@",DIOEND="D ENQ1^PSNHFRM1" D EN1^DIP
 D KILL Q
HEAD1 I "Cc"[$E(PSNANSR) W !,PSNANS_" FORMULARY   (BY VA CLASS)",!
 Q
KILL K PSNANS,PSNANSR,PSNB,^TMP($J,"PSNDT"),PSNDATE
 Q
ASKEM W !!,"You may print by DRUG GENERIC NAME/TRADENAME or VA CLASS CODE.",!,"Enter a <RET> or ""G"" to print by DRUG GENERIC NAME/TRADENAME or",!,"""C"" for VA CLASS CODE."
 W !!,"Print by:" R !,?3,"DRUG GENERIC NAME/TRADENAME// ",PSNANSR:DTIME S:'$T PSNANSR="^" Q:PSNANSR="^"  S:PSNANSR']"" PSNANSR="Gg"
 I "?"[$E(PSNANSR) W !!,?5,"Enter a ""<RET>"" or ""Gg"" to print by local generic name/tradename.",!?5,"Enter a ""C"" to print by VA Drug Class Code",!?5,"You may enter an ""^"" to exit." K PSNANSR G ASKEM
 I "^"[$E(PSNANSR) Q
 I "CcGg"'[$E(PSNANSR) G ASKEM
 I $D(PSNANSR),PSNANSR?.E1C.E K PSNANSR G ASKEM
 I "Cc"[$E(PSNANSR) W ?40,"CLASS",! D BEGIN
 I $D(PSNANSR),"Gg"[$E(PSNANSR) W ?40,"GENERIC/TRADE",! K ^TMP($J) S PSNANS=PSNANS_" FORMULARY" D ^PSNHFRM
 Q
SUPPLY K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to include supply items" D ^DIR K DIR Q:$D(DIRUT)
 I Y(0)="YES" S SF=1
 I Y(0)="NO" S SF=0
 Q
