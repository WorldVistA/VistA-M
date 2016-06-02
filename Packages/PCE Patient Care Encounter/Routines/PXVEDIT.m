PXVEDIT ;BIR/CML3,ADM - LOT NUMBER EDIT ;11/05/2015
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210**;Aug 12, 1996;Build 21
 ;
EN ; entry point for PXTT EDIT IMMUNIZATION LOT option
 N PXVOUT,X,Y
 S PXVOUT=0
PICK W @IOF,"IMMUNIZATION INVENTORY FUNCTIONS",!
FUNC ; select function
 K DIR S DIR("A",1)="1. Enter/Edit Immunization Lot",DIR("A",2)="2. Display/Print Immunization Inventory Report",DIR("A",3)=""
 S DIR("A")="Enter a number",DIR(0)="NO^1:2" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S PXVOUT=1 D END Q
 I X["?" G PICK
 I Y=2 D ^PXVINV D END Q
F1 ; entry point for lot number enter/edit
 N DA,DIE,DIC,DIDEL,DIR,DLAYGO,DR,DTOUT,DUOUT,PXVIEN,X,Y
 F  D LN Q:PXVOUT
 K PXVOUT
 Q
LN ; edit lot number or enter new lot number
 W @IOF,!,?10,"Enter/Edit Immunization Lot",!
 K DIC S DIC="^AUTTIML(",DIC(0)="AEMLZ",DLAYGO=9999999.41 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(X="") S PXVOUT=1 D END Q
 S PXVIEN=$P($G(Y),"^")
EDIT ; edit existing lot number
 I $D(^AUPNVIMM("LN",PXVIEN)) D  D END Q
 .W !!,"LOT NUMBER: "_$P(^AUTTIML(PXVIEN,0),"^")_"// ** Already assigned and cannot be edited. **",$C(7)
 .S DA=PXVIEN,DIE=9999999.41,DR=".02;.04;.09;.03;.11;.12;.15;.18" D ^DIE
 K DA,DIE,DR S DA=PXVIEN,(DIDEL,DIE)=9999999.41,DR=".01;.04;.02;.09;.03;.11;.12;.15;.18" D ^DIE
 D END
 Q
END K DA,DIE,DIC,DIDEL,DIR,DLAYGO,DR,DTOUT,DUOUT,PXVIEN,X,Y
 Q
