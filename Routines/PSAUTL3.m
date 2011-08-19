PSAUTL3 ;BIR/JMB-Upload and Process Prime Vendor Invoice Data Utility - CONT'D ;7/23/97
 ;;3.0;DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**49**; 10/24/97
 ;This utility displays locations & allows user to select one, many, or
 ;all locations.
 ;
 S PSALOC=+$O(^PSD(58.8,"ADISP","P",0))
 I 'PSALOC W !!?5,"No Drug Accountability location has been created yet." S PSAOUT=1 G EXIT
 ;
ORDER ;If more than one pharmacy location, collect them in alpha order.
 S (PSACNT,PSALOC)=0 W !
 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .I '$D(PSATRAN) Q:'$O(^PSD(58.8,PSALOC,1,0))
 .;VMP OIFO BAY PINES;ELR;PSA*3*49
 .S (PSAOSIT,PSAOSITN)=""
 .D SITES^PSAUTL1
 .S PSACNT=PSACNT+1,PSAONE=+PSALOC
 .S PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=$P(^(0),"^",3)_"^"_$P(^(0),"^",10)_"^"_$P($G(^PSD(58.8,PSALOC,"I")),"^")
 I PSACNT=1 G:$G(PSATRAN)="" ONE W !?5,"There is only one active pharmacy location.",!?5,"There must be at least two to transfer drugs." S PSAOUT=1 Q
 S PSACHK=$O(PSALOCA("")) I PSACHK="" G EXIT
 G DISP
 ;
ONE ;only one
 S PSALOC=PSAONE
 I '$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="") W !,"There are no Drug Accountability pharmacy locations with data." Q
 S PSALOCN="",PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  S PSALOC=0,PSALOC=+$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC  S PSALOC(PSALOCN,PSALOC)=PSALOCA(PSALOCN,PSALOC)
 G EXIT
 ;
DISP ;Displays the available pharmacy locations.
 W @IOF,!
 W:$G(PSATRAN)="F" "Choose the pharmacy location transferring the drugs:"
 W:$G(PSATRAN)="T" "Choose the pharmacy location receiving the transferred drugs:"
 W:$G(PSATRAN)="" "Choose one or many pharmacy locations:"
 W ! S PSACNT=0,PSALOCN=""
 F  S PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  D
 .S PSALOC=0 F  S PSALOC=+$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC  D
 ..S PSACNT=PSACNT+1,PSAMENU(PSACNT,PSALOCN,PSALOC)=""
 ..W !,$J(PSACNT,2)
 ..W:$L(PSALOCN)>76 ?4,$P(PSALOCN,"(IP)",1)_"(IP)",!?21,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 ?4,PSALOCN
 W !
 ;
SELECT I $G(PSATRAN)="" S DIR(0)="L^1:"_PSACNT,DIR("A")="Select PHARMACY LOCATION",DIR("??")="^D HELP^PSAUTL3"
 I $G(PSATRAN)="F"!($G(PSATRAN)="T") S DIR(0)="N^1:"_PSACNT D
 .I $G(PSATRAN)="F" S DIR("A")="Select Transfer from Pharmacy",DIR("??")="^D FROMHELP^PSAUTL3"
 .I $G(PSATRAN)="T" S DIR(0)="N^1:"_PSACNT,DIR("A")="Select Transfer to Pharmacy",DIR("??")="^D TOHELP^PSAUTL3"
 S DIR("?")="Enter the number(s) of the pharmacy location"
 D ^DIR K DIR I 'Y S PSAOUT=1 G EXIT
 S PSASEL=Y F PSAPC=1:1 S PSANUM=+$P(PSASEL,",",PSAPC) Q:'PSANUM  D
 .S PSALOCN=$O(PSAMENU(PSANUM,"")),PSALOC=+$O(PSAMENU(PSANUM,PSALOCN,0))
 .S PSALOC(PSALOCN,PSALOC)=PSALOCA(PSALOCN,PSALOC)
 ;
EXIT ;Kills all variables except PSALOC array & PSAOUT
 K DIR,PSACOMB,PSAISIT,PSAISITN,PSAMENU,PSAONE,PSANUM,PSAOSIT,PSAOSITN,PSAPC,Y
 Q
 ;
FROMHELP ;Extended help to 'Select Transfer from Pharmacy'
 W !?5,"Enter the number of the pharmacy location that will transfer the drugs to another pharmacy."
 Q
HELP ;Extended help to 'Select PHARMACY LOCATION'
 W !?5,"Enter the number of the pharmacy location you want to select.",!?5,"If you want more than one pharmacy location, enter the numbers",!?5,"separated by a comma."
 W !!?5,"For example: Enter 1,3 or 1-3,5."
 Q
TOHELP ;Extended help to 'Select Transfer to Pharmacy'
 W !?5,"Enter the number of the pharmacy location that will receive the transferred the drugs."
 Q
 ;
SETAORD ;Set logic for "AORD" X-Ref
 S PSADA(1)=$O(^PSD(58.811,"B",X,0))
 S PSADA=0 F  S PSADA=$O(^PSD(58.811,PSADA(1),1,PSADA)) Q:'PSADA  D
 .S ^PSD(58.811,"AORD",X,$P($G(^PSD(58.811,PSADA(1),1,PSADA,0)),"^"),PSADA(1),PSADA)=""
 K PSADA
 Q
KILLAORD ;Kill logic for "AORD" X-Ref
 K ^PSD(58.811,"AORD",X)
 Q
 ;
SLOC ;Set logic for "ALOC" X-Ref on Pharmacy Location & Master Vault fields
 Q:'+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",2)
 S ^PSD(58.811,"ALOC",X,+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",2),DA(1),DA)=""
 Q
KLOC ;Kill logic for "ALOC" X-Ref on Pharmacy Location & Master Vault fields
 K ^PSD(58.811,"ALOC",X,+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",2),DA(1),DA)
 Q
 ;
SLOCDT ;Set logic for "ALOC" X-Ref on Invoice Date field
 S:+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",5) ^PSD(58.811,"ALOC",+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",5),X,DA(1),DA)=""
 S:+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",12) ^PSD(58.811,"ALOC",+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",12),X,DA(1),DA)=""
 Q
KLOCDT ;Kill logic for "ALOC" X-Ref
 K ^PSD(58.811,"ALOC",+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",5),X,DA(1),DA)
 K ^PSD(58.811,"ALOC",+$P($G(^PSD(58.811,DA(1),1,DA,0)),"^",12),X,DA(1),DA)
 Q
