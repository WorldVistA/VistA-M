FHPRO ; HISC/REL/RTK - Food Production Manager ;4/12/06  15:53
 ;;5.5;DIETETICS;**4,5,12**;Jan 28, 2005;Build 3
 ;
 ; 10/16/2007 BY/KAM FH*5.5*12 Rem Call 210883 Remove access to old
 ;                             Clinician field
EN2 ; Enter/Edit Nutrition Locations (Inpatient Wards/Outpatient Clinics)
 W ! K DIR,DIC S DIR("A")="Select WARD or OUTPATIENT Location: "
 S DIR(0)="SAO^W:Ward Location;O:Outpatient Location" D ^DIR I $D(DIRUT) G KIL
 I Y'=-1 S FHANS=Y
 I FHANS="W" D EN2WRD Q
 I FHANS="O" D EN2OL Q
 Q
EN2WRD ;Ward locations
 K DIC S (DIC,DIE)="^FH(119.6,",DIC(0)="AEQLM",DLAYGO=119.6
 S DIC("DR")=".01" W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN2:Y<1
 ; S DR=".01;2:2.5;... POTENTIAL CHG FOR 210883 WAS S DR=".01:2.5;3"
 ; 10/16/2007 BP/KAM FH*5.5*12 changed next line to remove access to field # 1 Clinician (Old Clinician field)
 S DA=+Y,DR=".01;2:2.5;3;S:X="""" Y=4;3.5;4;S:X="""" Y=5;4.5;5;S:'X Y=6;5.5;6:29;99;107;107.5;108;108.5;109;109.5;110;110.5;111;111.5;112" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=119.6 D ^DIE,KIL G EN2
EN2OL ;Outpatient locations
 K DIC S (DIC,DIE)="^FH(119.6,",DIC(0)="AEQLM",DLAYGO=119.6
 S DIC("DR")=".01" W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN2:Y<1
 S DA=+Y,DR=".01;2;2.6;3;S:X="""" Y=4;3.5;4;S:X="""" Y=5;4.5;5;S:'X Y=6;5.5;6;7;103:106;11;20:99;107;107.5;108;108.5;109;109.5;110;110.5;111;111.5;112" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=119.6 D ^DIE,KIL G EN2
EN3 ; Enter/Edit Production Diets
 K DIC S (DIC,DIE)="^FH(116.2,",DIC(0)="AEQLM",DLAYGO=116.2
 S DIC("DR")=".01" W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN3:Y<1
 S DA=+Y,DR=$S(DA=1:"1:8",1:".01:7.5;10;S:X'=""Y"" Y=8;11;8;12:99") S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=116.2 D ^DIE I '$D(DA) D KIL G EN3
 S:$O(^FH(116.2,DA,"R",0))<1 $P(^FH(116.2,DA,0),"^",4)="N" D KIL G EN3
EN4 ; List Production Diets
 W !!,"The list requires a 132 column printer.",!
 W ! S L=0,DIC="^FH(116.2,",FLDS="[FHPROD]",BY="8,.01"
 S FR="@",TO="",DHD="PRODUCTION DIETS" D EN1^DIP,RSET Q
EN5 ; Enter/Edit Production Facilities
 K DIC S (DIC,DIE)="^FH(119.71,",DIC(0)="AEQLM",DLAYGO=119.71
 S DIC("DR")=".01" W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN5:Y<1
 S DA=+Y,DR=".01:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=119.71 D ^DIE,KIL G EN5
EN6 ; Enter/Edit Service Points
 K DIC S (DIC,DIE)="^FH(119.72,",DIC(0)="AEQLM",DLAYGO=119.72
 S DIC("DR")=".01" W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN6:Y<1
 S DA=+Y S DR=".01:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=119.72 D ^DIE I '$D(DA) D KIL G EN6
 S DA(1)=DA S DIK="^FH(119.72,DA(1),""A""," F DA=0:0 S DA=$O(^FH(119.72,DA(1),"A",DA)) Q:DA'>0  I $P($G(^(DA,0)),"^",2,8)?."^" D ^DIK
 S DIK="^FH(119.72,DA(1),""B""," F DA=0:0 S DA=$O(^FH(119.72,DA(1),"B",DA)) Q:DA'>0  I $P($G(^(DA,0)),"^",2,22)?."^" D ^DIK
 D KIL G EN6
EN7 ; Enter/Edit Communication Offices
 K DIC S (DIC,DIE)="^FH(119.73,",DIC(0)="AEQLM",DLAYGO=119.73
 S DIC("DR")=".01" W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN7:Y<1
 S DA=+Y,DR=".01:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=119.73 D ^DIE,KIL G EN7
EN8 ; Enter/Edit Supplemental Feeding Sites
 K DIC S (DIC,DIE)="^FH(119.74,",DIC(0)="AEQLM",DLAYGO=119.74
 S DIC("DR")=".01" W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN8:Y<1
 S DA=+Y,DR=".01:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=119.74 D ^DIE,KIL G EN8
RSET K %ZIS S IOP="" D ^%ZIS
KIL G KILL^XUSCLEAN
