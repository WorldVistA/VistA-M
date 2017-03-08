PXVEDIT ;BIR/CML3,ADM - LOT NUMBER EDIT ;04/22/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210,216**;Aug 12, 1996;Build 11
 ;
EN ; entry point for PXTT EDIT IMMUNIZATION LOT option
 N PXVDEF,PXVFAC,PXVFIEN,PXVI,PXVOUT,PXVSTN,PXVTITLE,PXVY,X,Y
 S PXVOUT=0,PXVFAC=""
 D PICK,LIST I PXVFAC="" D END Q
 D PICK1
FUNC ; select function
 K DIR S DIR("A",1)="1. Enter/Edit Immunization Lot",DIR("A",2)="2. Display/Print Immunization Inventory Report",DIR("A",3)=""
 S DIR("A")="Enter a number",DIR("?",1)=" Enter '1' to update information for an existing immunization lot or"
 S DIR("?",2)=" to enter a new immunization lot. Enter '2' to display or print an",DIR("?")=" immunization inventory report."
 S DIR(0)="NO^1:2" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S PXVOUT=1 D END Q
 I X["?" G PICK
 I Y=2 D ^PXVINV D END Q
F1 ; entry point for lot number enter/edit
 N DA,DIE,DIC,DIDEL,DIR,DLAYGO,DR,DTOUT,DUOUT,PXVIEN,X,Y
 F  D LN Q:PXVOUT
 K PXVOUT
 Q
LN ; edit lot number or enter new lot number
 W @IOF,!,?10,"Enter/Edit Immunization Lot for "_PXVTITLE,!
 K DIC S DIC="^AUTTIML(",DIC(0)="AEMLZ",DLAYGO=9999999.41
 S DIC("S")="I $P(^(0),""^"",10)=PXVFIEN!($P(^(0),""^"",10)="""")"
 S DIC("DR")=".02;.04;.09;.03;.11;.12;.15;.18"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(X="") S PXVOUT=1 D END Q
 S PXVIEN=$P($G(Y),"^")
 I $P(Y,"^",3)=1 K DA,DIE,DR S DA=PXVIEN,DIE=9999999.41,DR=".1////"_PXVFIEN D ^DIE D END Q
 I $P(^AUTTIML(PXVIEN,0),"^",10)="" D LINK
EDIT ; edit existing lot number
 I $D(^AUPNVIMM("LN",PXVIEN)) D  D END Q
 .W !!,"LOT NUMBER: "_$P(^AUTTIML(PXVIEN,0),"^")_"// ** Already assigned and cannot be edited. **",$C(7)
 .S DA=PXVIEN,DIE=9999999.41,DR=".02;.04;.09;.03;.11;.12;.15;.18" D ^DIE
 K DA,DIE,DR S DA=PXVIEN,(DIDEL,DIE)=9999999.41,DR=".01;.04;.02;.09;.03;.11;.12;.15;.18" D ^DIE
 D END
 Q
END K DA,DIE,DIC,DIDEL,DIR,DLAYGO,DR,DTOUT,DUOUT,PXVIEN,X,Y
 Q
PICK W @IOF,"IMMUNIZATION INVENTORY FUNCTIONS",!
 Q
PICK1 W @IOF,"IMMUNIZATION INVENTORY FUNCTIONS FOR "_PXVTITLE,!
 Q
LIST ;
 N PXVCT,PXVI,PXVINST,PXVJ,PXVSITE,PXVX,PXVY S PXVCT=0
 W !,"Select associated VA facility from the list or enter another facility."
 I $O(^AUTTIML("AF",0)) D
 .S PXVI=0 F  S PXVI=$O(^AUTTIML("AF",PXVI)) Q:'PXVI  D SITE
 E  S PXVI=$$KSP^XUPARAM("INST") D SITE
 S PXVI="" F  S PXVI=$O(PXVINST(PXVI)) Q:PXVI=""  S X=PXVINST(PXVI) D
 .W !?10,$P(X,"^",2)_" ("_$P(X,"^",3)_")"
 W !,"Inventory information to be updated or displayed will be related to"
 W !,"the selected facility.",!
RD K DIR S DIR(0)="9999999.41,.1",DIR("A")="Enter the facility name or station number"
 I PXVCT=1 S PXVI="",PXVI=$O(PXVINST(PXVI)),DIR("B")=$P(PXVINST(PXVI),"^",2)
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I X="" W !,"This is a required entry." G RD
 S PXVFAC=Y,PXVFIEN=+Y
 S PXVY=$$GET1^DIQ(4,$P(PXVFAC,"^"),99),PXVFAC=PXVFAC_"^"_PXVY
 S PXVTITLE=$P(PXVFAC,"^",2)_" ("_$P(PXVFAC,"^",3)_")"
 Q
SITE ;
 S PXVSITE=PXVI F PXVJ=.01,99 S PXVX=$$GET1^DIQ(4,PXVI,PXVJ),PXVSITE=PXVSITE_"^"_PXVX
 S PXVINST($P(PXVSITE,"^",2))=PXVSITE,PXVCT=PXVCT+1
 Q
LINK ;
 S DIR("A")="Associate this lot number with "_PXVTITLE,DIR(0)="Y"
 S DIR("?",1)=" Enter YES to associate this lot number entry exclusively with this facility."
 S DIR("?",2)=" Enter NO if this immunization lot should remain not associated with any"
 S DIR("?")=" specific facility or should be associated with a different facility."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I Y K DA,DIE,DR S DA=PXVIEN,(DLAYGO,DIE)=9999999.41,DR=".1////"_PXVFIEN D ^DIE K DA,DIE,DR
 Q
