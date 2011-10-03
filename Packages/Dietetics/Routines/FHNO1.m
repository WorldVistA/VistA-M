FHNO1 ; HISC/REL - Supplement Feeding Management ;3/8/95  13:27
 ;;5.5;DIETETICS;;Jan 28, 2005
EN3 ; Edit Supplemental Feedings
 D NOW^%DTC S DT=%\1 K %,%H,%I
 W ! S (DIC,DIE)="^FH(118,",DIC(0)="AEQLM",DIC("DR")=".01",DLAYGO=118 W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN3:Y<1
 S DA=+Y,DR=$S(DA>1:".01;",1:"")_"1;5//Y;6:20;22:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=118 D ^DIE K DA,DIE,DIDEL,DR G EN3
EN4 ; Edit Supp. Feeding Menus
 W ! S (DIC,DIE)="^FH(118.1,",DIC(0)="AEQLM",DIC("DR")=".01",DLAYGO=118.1 W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN4:Y<1
 I +Y=1 W *7,!!,"You cannot edit INDIVIDUALIZED Supplemental Menu",! G EN4
 S DA=+Y,DR=".01:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=118.1 D ^DIE G:'$D(DA) EN41
 S Y=$G(^FH(118.1,DA,1)),E=0
 F K=2:2:24 I $P(Y,"^",K),$P(Y,"^",K-1)="" S $P(Y,"^",K)="",E=1
 S:E ^FH(118.1,DA,1)=Y
EN41 K DA,DIE,DIDEL,DR,E,K,Y G EN4
EN6 ; List Supplemental Feedings
 W ! S L=0,DIC="^FH(118,",FLDS="[FHSFLST]",BY="NAME"
 S FR="",TO="",DHD="SUPPLEMENTAL FEEDINGS" D EN1^DIP,RSET Q
EN7 ; List Supplemental Feeding Menus
 W !!,"The list requires a 132 column printer.",!
 W ! S L=0,DIC="^FH(118.1,",FLDS="[FHSFMENU]",BY="NAME"
 S FR="",TO="",DHD="SUPPLEMENTAL FEEDING MENUS" D EN1^DIP,RSET Q
RSET K %ZIS S IOP="" D ^%ZIS
KIL G KILL^XUSCLEAN
