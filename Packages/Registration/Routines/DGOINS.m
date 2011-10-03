DGOINS ;ALB/MAC - OUTPUT FOR PATIENTS ADMITTED WITH UNKNOWN INSURANCE ; SEP 12 1988@12:00
 ;;5.3;Registration;;Aug 13, 1993
 D QUIT,DT^DICRW,ASK2^SDDIV G QUIT:Y<0 S VAUTNI=1,(DGY,DGBEG,DGBEG1,DGEND,DGEND1,DGD,DGL)=0
DISP W !!,"Display report for (D)ATE RANGE or (C)URRENT DATE:  CURRENT// " S Z="^CURRENT^DATE RANGE",X="" R X:DTIME G QUIT:X["^"!('$T) S:X["d"!(X["c") X=$C($A(X)-32) I X="" S X="C" W X
 S DGL=$E(X) D IN^DGHELP I %=-1 W !!?3,"You may display report for :" D HELP2 S %="" G DISP
 D:DGL="D" BEG G:X="^" QUIT
SERV W !!,"Include Service Connected Inpatients " S %=1 D YN^DICN G QUIT:%=-1 S DGSC=% I %=0 D HELP1 G SERV
 W ! S DGVAR="VAUTD#^DGBEG^DGBEG1^DGEND^DGEND1^DGL^DGSC",DGPGM="START^DGOINS1" D ZIS^DGUTQ I 'POP U IO D START^DGOINS1
QUIT K %,%DT,DIR(0),DIR("A"),DFN,DGBEG,DGBEG1,DGCA,DGCL,DGD,DGDT,DGDV,DGEND,DGEND1,DGJ,DGL,DGN,DGNO,DGP,DGC,DGPGM,DGS,DGSC,DGT,DGU,DGV,DGVAR,DGW,DGY,K,L,POP,VA("PID"),VA("BID"),VAUTD,VADAT,VADATE,VAERR,VAMT,VAUTNI,X,X1,Y,Z,^UTILITY($J) Q
BEG W ! S %DT="AETX",%DT("A")="Enter the beginning date: " D ^%DT S DGBEG=Y,DGBEG1=Y-.0001 Q:X="^"  I X="" G BEG
END W ! S %DT("A")="Enter ending date: " D ^%DT Q:X="^"  S DGEND=Y,DGEND1=Y_.9999 I X="" G END
 I DGEND<DGBEG W !!?5,"The ending date can not be before the beginning date" G END
 Q
HELP2 W !!?10,"C for CURRENT DATE - Report will display only those patients that",!?10,"are inpatients in hospital today.",!!?10,"D for DATE RANGE - to display all patients that were admitted",!?10,"to the hospital during that period."
 Q
HELP1 W !!,"Choose (Y)es or (N)o:",!!?10,"Y - if you want to include service connected inpatients",!?14,"in the report.",!?10,"N - if you do not want to include service connected inpatients."
 Q
