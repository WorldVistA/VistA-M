DGRUGFY ;ALB/MLI - ENTER FISCAL YEAR RUG II WWU VALUES ; 20 JAN 88 @1000
 ;;5.3;Registration;**173**;Aug 13, 1993
 W !,"You are about to enter national fiscal year RUG values.  All entries must be"
 W !,"completed, otherwise those that you have entered will be deleted."
ASKFY W !,"Enter fiscal year (4 digits): " R X:DTIME G QUIT:X=""!(X="^")!('$T),FYH:'(X?4N) S %DT="E",%DT(0)=2870000 D ^%DT I Y'>0 G ASKFY
 S DGFY=+Y K Y F DGI=1:1:17 I $S(DGI<17:1,DGFY<2870000:1,DGFY>2880000:1,1:0) D ASK G:'$D(DGOUT) CHECK
CHECK F I=1:1:17 I $S(I<17:1,DGFY<2870000:1,DGFY>2880000:1,1:0),$S('$D(^DG(45.91,I,"FY",DGFY,0)):1,$P(^(0),"^",2)']"":1,1:0) W !,"RUG",I," WWU value not assigned" S DGNO(I)=I
COMP I $D(DGNO) W !,"Do you want to enter these values now" S %=2 D YN^DICN I %Y["?" W !?5,"ANSWER 'Y'ES OR 'N'O" G COMP
 I $D(DGNO) G:%=1 FILLIN G REASK
QUIT K %,%DT,%Y,D,DA,D0,D1,DI,DGFY,DGI,DGNO,DGOUT,DIC,DIE,DIK,DR,I,X,Y Q
FILLIN F DGI=0:0 S DGI=$O(DGNO(DGI)) Q:DGI'>0  D ASK Q:'$D(DGOUT)
 K DGNO G CHECK
REASK W !,"WARNING:  All existing WWU values for fiscal year ",$$FMTE^XLFDT(DGFY)," will be deleted.  OK to continue" S %=1 D YN^DICN I %Y["?" W !?5,"ANSWER 'Y'ES OR 'N'O" G REASK
 G COMP:%=2 S DA=DGFY F DGI=1:1:17 I $S(DGI<17:1,DGFY<2870000:1,DGFY>2880000:1,1:0) S DA(1)=DGI,DIK="^DG(45.91,"_DA(1)_",""FY""," D ^DIK
 G QUIT
ASK W !,"Enter RUG",DGI," value" S DA=DGI,DIE="^DG(45.91,",DR="1///"_DGFY,DR(2,45.9101)="1;S DGOUT=1" K DE,DQ,DGOUT D ^DIE
 Q
FYH W !?5,"Enter fiscal year (4 digits) from which you want RUG-II WWU values.",!?5,"Must not precede 1987." G ASKFY
