FHPRF ; HISC/REL - Forecasting ;2/13/95  14:27 
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Production Diet Percentages
 W ! S DIC="^FH(119.72,",DIC(0)="AEQM" D ^DIC G KIL:"^"[X!$D(DTOUT),EN1:Y<1 S DA=+Y
 W ! S DIE="^FH(119.72,",DR="11",DR(2,119.7211)="10:16;W !" D ^DIE
 S DA(1)=DA,DIK="^FH(119.72,DA(1),""A""," F DA=0:0 S DA=$O(^FH(119.72,DA(1),"A",DA)) Q:DA'>0  I $P($G(^(DA,0)),"^",2,8)?."^" D ^DIK
 D KIL G EN1
EN2 ; Enter/Edit Other Meals
 W ! S DIC="^FH(119.72,",DIC(0)="AEQM" D ^DIC G KIL:"^"[X!$D(DTOUT),EN2:Y<1 S DA=+Y
 W ! S DIE="^FH(119.72,",DR=10,DR(2,119.721)="10:30;W !" D ^DIE
 S DA(1)=DA,DIK="^FH(119.72,DA(1),""B""," F DA=0:0 S DA=$O(^FH(119.72,DA(1),"B",DA)) Q:DA'>0  I $P($G(^(DA,0)),"^",2,22)?."^" D ^DIK
 D KIL G EN2
KIL G KILL^XUSCLEAN
