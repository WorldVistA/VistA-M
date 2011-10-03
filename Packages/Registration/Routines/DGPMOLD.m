DGPMOLD ;ALB/MIR - LODGER OUTPUTS ; 23 MAY 90 @12
 ;;5.3;Registration;;Aug 13, 1993
EN D Q S DGHOW=1 G CONT
EN1 D Q S DGHOW=2
CONT D ASK2^SDDIV G:Y<0 Q S VAUTNI=DGHOW D WARD^VAUTOMA I Y<0 G Q
ASK W !,"Do you want to include patients lodged at another facility" S %=2 D YN^DICN I %<0 G Q
 I '% W !?3,"Enter 'Y'es to include lodgers who stayed at another facility,",!?3,"or 'N'o to only include lodgers that stayed at your facility." G ASK
 S DGOF='(%-1) I DGHOW=1 G QUEUE
DAT S %DT(0)="-DT",%DT="AEP",%DT("A")="START DATE: " D ^%DT G Q:X["^",DAT:Y<0 S DGFR=Y-.1
 S %DT("A")="  END DATE: ",%DT(0)=DGFR,%DT="AEP" D ^%DT G Q:X["^",DAT:Y<0 S DGTO=Y_.9
QUEUE W !!,*7,"This output requires 132 columns",! S DGPGM="START^DGPMOLD",DGVARS="DGHOW^DGFR^DGOF^DGTO^VAUTD#^VAUTW#" D ZIS^DGUTQ I POP G Q
START D STORE^DGPMOLD1
Q W ! K ^UTILITY($J,"LOD"),%DT,DFN,DGEND,DGFL,DGFR,DGFROM,DGHOW,DGNOW,DGOF,DGONE,DGPG,DGPGM,DGTO,DGVARS,DGX,DIR,I,J,K,L,POP,R,VA,VAERR,VAUTD,VAUTW,W,X,Y,Z D CLOSE^DGUTQ Q
