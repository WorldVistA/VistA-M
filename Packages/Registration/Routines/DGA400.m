DGA400 ;ALB/MRL - AMIS 401-420 GENERATION OF FILE ;01 JAN 1988@2300
 ;;5.3;Registration;**50**;Aug 13, 1993
 S (DGDEV,IOP)="HOME" D ^%ZIS K IOP S:'$D(U) U="^" S:'$D(DTIME) DTIME=300 I '$D(DT) S %DT="",X="T" D ^%DT S DT=+Y
 I $S('$D(DUZ):1,('$D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,1:0) W !!,"I DON'T KNOW WHO YOU ARE...UNABLE TO PROCEED!",*7 Q
EN S DGWR=1 D ^DGA4002 G Q:DGE W ! S %DT="EA",%DT("A")="Select AMIS 401-420 MONTH/YEAR:  " D ^%DT G Q:Y'>0 K %DT S DGA=$E(Y,1,5)_"00",DGAE=$E(Y,1,5)_"31.2359" X ^DD("DD") S DGA1=Y
 ;I DGA>2871031 S X=$E(DGA,4,5),X1=$S('(X-1):12,1:X-1),X=2_$S(X'=12:$E(DGA,2,3),1:$E(DGA,2,3)-1)_X1_"00" I '$D(^DG(391,"AR",X,401)) S Y=X X ^DD("DD") W !!,*7,"Report for previous month of '",Y,"' must be run first...",!! G EN
 S X=$O(^DG(391.1,"AR",DGA,400)) G PAT:X>420!(X<401) W !!,"Totals already on file for '",DGA1,"..."
GEN W !,"DO YOU WISH TO REGENERATE (WHICH CAN TAKE A WHILE)" S %=2 D YN^DICN G PAT:%=1,DV:%=2,Q:% W !!?4,"YES - To regenerate the totals for '",DGA1,"'.",!?4,"NO  - To QUIT this process immediately.",! G GEN
PAT W !!,"Do you want a patient listing included with this report" S %=2 D YN^DICN G Q:%=-1 S:% DGAL=$S(%=2:0,1:%) I '% W !!?4,"YES - To include a listing of all patients counted in these reports.",!?4,"NO - To exclude listing." G PAT
CODE D ASK^DGGECSA G Q:%<0 S DGCODFLG=%
 W ! F I=1:1 S J=$P($T(T+I),";;",2) Q:J=""  W !,J
 W !!,"THIS REPORT IS FORMATTED TO RUN WITH A RIGHT MARGIN OF 132!",*7,! S DGA1=DGA,DGAE1=DGAE,(DGQUIT,DGHOME)=0,DGVAR="DGCODFLG^DGDEV^DGAL^DGA1^DGHOME^DUZ^DGQUIT^DGAE1",DGPGM="^DGA4001" D ZIS^DGUTQ I POP G Q
 ;U IO 
 S DGHOME=1 G ^DGA4001
DV S DGPR="A" G QUE:'$P(^DG(43,1,"GL"),"^",2)
 W !!,"PRINT REPORT FOR ALL DIVISIONS" S %=1 D YN^DICN G QUE:%=1,DV1:%=2,Q:% W !!?4,"YES - To print report for ALL divisions.",!?4,"NO  - To select a specific division you wish to print." G DV
DV1 S DIC="^DG(40.8,",DIC(0)="AEMQZ" D ^DIC Q:Y'>0  S DGPR=+Y
QUE W !!,"THIS PRINTOUT IS FORMATTED TO OUTPUT WITH A 132-COLUMN RIGHT MARGIN!",*7 S DGAL=0,DGVAR="DGA^DGPR^DGAL^DUZ",DGPGM=$S(DGPR="A":"REP1",1:"REP")_"^DGA4005" D ZIS^DGUTQ G Q:POP
 ;U IO 
 G @DGPGM
UP S $P(^DG(43,1,"AMIS"),"^",3)=1,$P(^("AMIS"),"^",4)=+DUZ,$P(^("AMIS"),"^",5)=1 Q
Q G QUIT1^DGA4002
T ;
 ;;In the process of generating this report I will check for "open" or "pending"
 ;;dispositions which may be remaining on file for this timeframe.  If any "open"
 ;;dispositions are found you will be advised via a mailman message and the data
 ;;necessary for the report will not be generated.  A separate option is available
 ;;to list these "open" and "pending" dispositions.  "Pending" dispositions should
 ;;be changed to another status as soon as possible but this status does not impact
 ;;the generation of the AMIS 401-420 reports.
