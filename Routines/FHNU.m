FHNU ; HISC/REL - Nutrient Analysis ;3/24/95  13:07
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Edit Nutrients
 S (DIC,DIE)="^FHNU(",DIC(0)="AEQLM",DIC("DR")=".01",DLAYGO=112 W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN2:Y<1
 S DA=+Y,DR=$S($P(^FHNU(DA,0),"^",6)="N":"4:4.9",1:".01;2:5;7:27;29:99") S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=112 D ^DIE K DA,DIE,DIDEL,DR G EN2
EN5 ; List Nutrient File
 W !!,"The list requires a 132 column printer.",!
 W ! S L=0,DIC="^FHNU(",FLDS="[FHNULST]",BY="NAME"
 S FR="",TO="",DHD="FOOD NUTRIENTS" D EN1^DIP,RSET Q
EN8 ; List User Menus
 W !!,"The list requires a 132 column printer.",!
 W ! S L=0,DIC="^FHUM(",FLDS="[FHUMENU]",BY="USER,DATE ENTERED"
 S (FR,TO)=",",DHD="USER MENUS" D EN1^DIP,RSET Q
RSET K %ZIS S IOP="" D ^%ZIS
KIL G KILL^XUSCLEAN
