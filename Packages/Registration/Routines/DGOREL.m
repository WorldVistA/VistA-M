DGOREL ;ALB/MAC - PATIENT OUTPUT BY RELIGIOUS AFFILIATIONS ; 5 JUL 88@12:00
 ;;5.3;Registration;;Aug 13, 1993
 D QUIT1,DT^DICRW,ASK2^SDDIV G QUIT1:Y<0
DISP W !!,"Display report for (D)ATE RANGE or (C)URRENT DATE:  CURRENT// " S Z="^CURRENT^DATE RANGE",X="" R X:DTIME G QUIT1:X["^"!('$T) S:X["d"!(X["c") X=$C($A(X)-32) I X="" S X="C" W X
 S DGL=$E(X) D IN^DGHELP I %=-1 W !!?3,"You may display report for :" D HELP2 S %="" G DISP
 D:DGL="D" BEG G:X="^" QUIT1
PRO W !!,"Do you want to select only one religion" S %=2 D YN^DICN I %=0 W !!?10,"Enter 'Y' for YES or 'N' for NO or '^' to EXIT" G PRO
 G QUIT1:%=-1 I %=1 W ! S DIC="^DIC(13,",DIC(0)="AEQM" D ^DIC G QUIT1:Y'>0 S DGR=$P(Y,"^",2)
 S VAUTNI=1 W ! D WARD^VAUTOMA G QUIT1:Y<0
ASK W !!,"List Report By (W)ARD or (R)ELIGION: RELIGION// " S Z="^WARD^RELIGION",X="" R X:DTIME G QUIT1:X["^"!('$T) S:X["w"!(X["r") X=$C($A(X)-32) I X="" S X="R" W X
 S DGHOW=$E(X) D IN^DGHELP I %=-1 W !!?3,"You may list the report by either :" D HELP S %="" G ASK
SPEC S DGNON=0 I '$D(DGR) W !!,"Do you want patients with 'NOT SPECIFIED' religion displayed" S %=2 D YN^DICN G QUIT1:%=-1 S DGNON=% I %=0 D HELP1 G SPEC
 S DGVAR="DGBEG^DGBEG1^DGEND1^DGEND^DGHOW^DGL^DGNON^DGR^VAUTD#^VAUTW#",DGPGM="START^DGOREL1" W ! D ZIS^DGUTQ I 'POP U IO G START^DGOREL1
QUIT1 K %,%DT,DGBEG,DGBEG1,DGEND,DGEND1,DGL,DGHOW,DGNON,DGPGM,DGR,DGVAR,DIC,POP,VAUTD,VAUTNI,X,Y,Z Q
BEG W ! S %DT="AETX",%DT("A")="Enter the beginning date: " D ^%DT S DGBEG=(Y-.0001),DGBEG1=Y Q:X="^"  I X="" G BEG
END W ! S %DT("A")="Enter ending date: " D ^%DT Q:X="^"  S DGEND=Y_.9999,DGEND1=Y I X="" G END
 I DGEND<DGBEG W !!?5,"The ending date can not be before the beginning date" G END
 Q
HELP W !!?10,"R for RELIGION - Major sort is by RELIGION. Within each religion",!?10,"patient names are further sorted by Ward.",!?25,"Prints each religion on a separate page."
 W !!?10,"W for WARD - Major sort is by WARD. Within each ward",!?10,"patient names are further sorted by Religion.",!?25,"Prints each ward on separate page." Q
HELP1 W !!?10,"Enter 'Y' to list the patients who ",!?15,"have not specified a religion",!!?10,"Enter 'N' if you don't want to list patients who ",!?15,"have not specified a religion",!!?10,"Enter '^' to quit" Q
HELP2 W !!?10,"C for CURRENT DATE - Report will display only those patients that",!?10,"are inpatients in hospital today.",!!?10,"D for DATE RANGE - to display all patients that were admitted",!?10,"to the hospital during that period."
