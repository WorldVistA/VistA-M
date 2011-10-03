SDPURG ;ALB/TMP - Purge Routine Parameter Selection ; 12/24/85
 ;;5.3;Scheduling;**140,132**;Aug 13, 1993
 S:'$D(DTIME) DTIME=300 I '$D(DT) D DT^SDUTL
 S SDLIM=($E(DT,1,3)-$S($E(DT,4,5)>9:1,1:2))_"1001"
 W !,"The date you select to delete through may not exceed " S X1=SDLIM,X2=-1 D C^%DTC S (Y,SDLFY)=X D DT^DIQ W "."
 W !,"The files you may choose to delete from and the nodes that will be deleted are:",!!," from the HOSPITAL LOCATION File",!,"  -  the 'S' nodes, APPOINTMENT multiple"
 W !,"  -  the 'ST' nodes, clinic PATTERN multiple",!,"  -  the 'OST' nodes, clinic SPECIAL PATTERN multiple",!,"  -  the 'C' nodes, CHART CHECK multiple",!,"  -  the 'AAS' nodes, 10/10 visits cross-reference"
 W !," from the PATIENT File",!,"  -  the 'ASDPSD' nodes, Special Survey cross-reference"
 W !!,"OK to continue" S %=1 D YN^DICN Q:%<0!(%>1)  I '% G SDPURG
A1 S %=2 W !!,"Do you want to purge the Hospital Location file nodes" D YN^DICN Q:%<0  I '% W !,"Reply YES or NO" G A1
 S SD44=$S('(%-1):1,1:0)
A2 S %=2 W !!,"Do you want to purge the Patient file nodes" D YN^DICN Q:%<0  I '% W !,"Reply YES or NO" G A2
 S SD2=$S('(%-1):1,1:0)
 I 'SD2,'SD44 W !!,*7,"No files selected for purging --- NO PURGING DONE!!" G Q^SDPURG1
DT1 S Y=SDLFY D D^DIQ W !!,"Select date through which you want these files purged: ",Y," // " R X:DTIME Q:X["^"  I X']"" S SDLIM1=SDLIM G OV
 I X?1"?".E W !,"This date may be different from the default - choose the date through which",!," you want to purge" G DT1
 W ! S %DT="E",%DT(0)=-DT D ^%DT I Y'>0 W !,"Invalid date" G DT1
 I Y>SDLFY W !,*7,"You can only purge data up to " S Y=SDLFY D DT^DIQ G DT1
 K %DT S SDLIM1=+Y_.9
OV I 'SD2,'SD44 W !!,*7,"No files selected for purging --- NO PURGING DONE!!" G Q^SDPURG1
A4 S %=2 W !!,"Do you want to print nodes (in GLOBAL format - %G) as they are deleted" D YN^DICN Q:%<0  I '% W !,"Reply YES or NO" G A4
 S SDPR=$S('(%-1):1,1:0)
A5 S %=1 W !!,"Is everything OK to proceed" D YN^DICN Q:%<0  I '% W !,"Reply YES or NO" G A5
 I (%-1) W !,*7,"NO PURGING DONE!!" G Q^SDPURG1
 S VAR="SDLIM^SDLIM1^SD44^SD2^SDPR",VAL=SDLIM_"^"_SDLIM1_"^"_SD44_"^"_SD2_"^"_SDPR,PGM="START^SDPURG1" D ZIS^DGUTQ G:POP Q^SDPURG1
 G START^SDPURG1
