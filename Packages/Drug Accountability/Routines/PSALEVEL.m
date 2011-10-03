PSALEVEL ;BIR/JMB-Enter/Edit Stock and Reorder Levels ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine allows the user to select a pharmacy location/master vault
 ;to set the MAINTAIN STOCK LEVELS? field. If yes, the stock and reorder
 ;levels can be edited.
 ;
 I '$D(^XUSEC("PSA ORDERS",DUZ)) W !,"You do not hold the key to enter the option." Q
SETUP S PSASLN="",$P(PSASLN,"-",80)=""
 ;Counts pharmacy locations
 S (PSALOC,PSANUM)=0
 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .S PSANUM=PSANUM+1,PSAONE=PSALOC,PSAISIT=+$P(^PSD(58.8,PSALOC,0),"^",3),PSAOSIT=+$P(^(0),"^",10)
 .D SITES^PSAUTL1 S PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=PSAISIT_"^"_PSAOSIT
 ;Counts master vaults
 S (PSAMVNUM,PSAMV)=0
 F  S PSAMV=+$O(^PSD(58.8,"ADISP","M",PSAMV)) Q:'PSAMV  D
 .Q:'$D(^PSD(58.8,PSAMV,0))!($P($G(^PSD(58.8,PSAMV,0)),"^")="")!('$P($G(^PSD(58.8,PSAMV,0)),"^",8))
 .I +$G(^PSD(58.8,PSAMV,"I")),+^PSD(58.8,PSAMV,"I")'>DT Q
 .S PSAMVNUM=PSAMVNUM+1,PSAONEMV=PSAMV,PSAMV($P(^PSD(58.8,PSAMV,0),"^"),PSAMV)=""
 ;
BEGIN S (PSABEG,PSALOC,PSAMV,PSAOUT)=0
 I $D(^XUSEC("PSJ RPHARM",DUZ)) G:'PSAMVNUM&('PSANUM) NONE D PHARMKEY
 I '$D(^XUSEC("PSJ RPHARM",DUZ)) G:'PSANUM NONE D:PSANUM=1 ONE D:PSANUM>1 MANY
 G:PSAOUT EXIT G:PSABEG BEGIN
 ;
MAINTAIN ;Maintain reorder levels in pharmacy location/master vault?
 S PSA=$S(PSALOC:PSALOC,1:PSAMV)
 S DIE="^PSD(58.8,",DA=PSA,DR=34 D ^DIE K DA,DIE
 G:$G(DTOUT)!($G(DUOUT)) EXIT
 I '+X G:PSANUM&(PSAMVNUM) BEGIN G EXIT
 ;
GETDRUG ;Gets drug levels
 W ! S DIC(0)="AEMQZ",DIC="^PSD(58.8,"_PSA_",1,",DA(1)=PSA,DIC("S")="I +$P($G(^PSD(58.8,PSA,1,+Y,0)),U,14)'<DT!('$P($G(^PSD(58.8,PSA,1,+Y,0)),U,14))"
 D ^DIC K DA,DIC G:$G(DTOUT)!($G(DUOUT)) EXIT
 I Y=-1 G:(PSANUM=1&('PSAMVNUM))!('PSANUM&(PSAMVNUM=1)) EXIT G BEGIN
 S PSADRG=+Y
 S DIE="^PSD(58.8,"_PSA_",1,",DA(1)=PSA,DA=PSADRG,DR="2STOCK LEVEL (in Dispense Units);4REORDER LEVEL (in Dispense Units)" D ^DIE K DIE
 G:$G(DTOUT)!($G(DUOUT)) EXIT
 G GETDRUG
 ;
CHOOSE ;Selects the type of location to have the levels enter/edited.
 W @IOF,!?16,"<< ENTER/EDIT STOCK AND REORDER LEVELS SCREEN >>",!,PSASLN
 S DIR(0)="SO^P:Pharmacy Location;M:Master Vault",DIR("A")="Enter/edit levels for a pharmacy location or master vault",DIR("??")="^D CHO^PSALEVEL"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S PSACHO=Y
 I PSACHO="P" D:PSANUM=1 ONE D:PSANUM>1 MANY Q
 I PSACHO="M" D:PSAMVNUM=1 ONEMV D:PSAMVNUM>1 MANYMV
 Q
 ;
EXIT ;Kills variables
 K DA,DIC,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,PSA,PSABEG,PSACHO,PSACNT,PSACOMB,PSADRG,PSAISIT,PSAISITN,PSALOC,PSALOCA,PSALOCN
 K PSAMENU,PSAMV,PSAMVA,PSAMVIEN,PSAMVNUM,PSANUM,PSAONE,PSAONEMV,PSAOSIT,PSAOSITN,PSAOUT,PSASEL,PSASLN,PSAVAULT,X,Y
 Q
 ;
PHARMKEY ;
 I 'PSAMVNUM D:PSANUM=1 ONE D:PSANUM>1 MANY Q
 I PSANUM D CHOOSE Q
 I 'PSANUM D:PSAMVNUM=1 ONEMV D:PSAMVNUM>1 MANYMV
 Q
 ;
ONEMV ;Assigns invoice to Master Vault
 S PSAMV=PSAONEMV
 W @IOF,!?16,"<< ENTER/EDIT STOCK AND REORDER LEVELS SCREEN >>"
 W !?31,"<< MASTER VAULT >>",!!,$P(^PSD(58.8,PSAMV,0),"^"),!,PSASLN,!
 Q
 ;
MANYMV ;Displays active master vaults
 W @IOF,!?16,"<< ENTER/EDIT STOCK AND REORDER LEVELS SCREEN >>",!,PSASLN,!
 S PSASEL=0,PSAMVA="" F  S PSAMVA=$O(PSAMV(PSAMVA)) Q:PSAMVA=""  D
 .S PSAMVIEN=0 F  S PSAMVIEN=$O(PSAMV(PSAMVA,PSAMVIEN)) Q:'PSAMVIEN  D
 ..S PSASEL=PSASEL+1,PSAVAULT(PSASEL,PSAMVA,PSAMVIEN)=""
 ..W !,$J(PSASEL,2)_".",?4,PSAMVA
 W ! S DIR(0)="NO^1:"_PSASEL,DIR("A")="Select Master Vault",DIR("?")="Select the Master Vault to be edited",DIR("??")="^D MV^PSALEVEL"
 D ^DIR K DIR I Y="",PSANUM S PSABEG=1 Q
 I Y="",'PSANUM S PSAOUT=1 Q
 I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y
 S PSAMVA=$O(PSAVAULT(PSASEL,"")) Q:PSAMVA=""  S PSAMVIEN=+$O(PSAVAULT(PSASEL,PSAMVA,0)) Q:'PSAMVIEN  S PSAMV=PSAMVIEN
 W @IOF,!?16,"<< ENTER/EDIT STOCK AND REORDER LEVELS SCREEN >>"
 W !?31,"<< MASTER VAULT >>",!!,$P(^PSD(58.8,PSAMV,0),"^"),!,PSASLN,!
 Q
 ;
NONE ;No DA pharmacy locations
 Q:PSAMVNUM
 W !!,"There are no Drug Accountability pharmacy locations.",!!,"Use the Set Up/Edit a Pharmacy Location option on Pharmacy Location menu"
 W !,"to setup one or more pharmacy locations."
 G EXIT
 ;
ONE ;Only one location
 S PSACNT=0,PSALOC=PSAONE,PSALOCN=$O(PSALOCA(""))
 W @IOF,!?16,"<< ENTER/EDIT STOCK AND REORDER LEVELS SCREEN >>"
 W !?31,"PHARMACY LOCATION",!!
 I $L(PSALOCN)>76 W $P(PSALOCN,":")_" :"_$P($P(PSALOCN,":",2),"(IP)",1)_"(IP)",!?20,$P(PSALOCN,"(IP)",2)
 W:$L(PSALOCN)<77 PSALOCN W !,PSASLN,!
 Q
 ;
MANY ;If more than one pharmacy location, display invoices.
 W @IOF,!?16,"<< ENTER/EDIT STOCK AND REORDER LEVELS SCREEN >>",!,PSASLN,!
 S PSACNT=0,PSALOCN="" F  S PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  D
 .S PSALOC=0 F  S PSALOC=$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC  D
 ..S PSACNT=PSACNT+1,PSAMENU(PSACNT,PSALOCN,PSALOC)=PSALOC
 ..W !,$J(PSACNT,2)_"." W:$L(PSALOCN)>72 ?4,$P(PSALOCN,"(IP)",1)_"(IP)",!?21,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<73 ?4,PSALOCN
 W !! K DIR S DIR(0)="NO^1:"_PSACNT,DIR("A")="Pharmacy Location",DIR("?")="Select the pharmacy location to be edited",DIR("??")="^D PL^PSALEVEL"
 D ^DIR K DIR I Y="",PSAMVNUM S PSABEG=1 Q
 I Y="",'PSAMVNUM S PSAOUT=1 Q
 I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y,PSALOCN=$O(PSAMENU(PSASEL,"")) Q:PSALOCN=""
 S PSALOC=$O(PSAMENU(PSASEL,PSALOCN,0)) Q:'PSALOC
 W @IOF,!?16,"<< ENTER/EDIT STOCK AND REORDER LEVELS SCREEN >>"
 W !?28,"<< PHARMACY LOCATION >>",!!
 I $L(PSALOCN)>76 W $P(PSALOCN,"(IP)",1)_"(IP)",!?20,$P(PSALOCN,"(IP)",2)
 W:$L(PSALOCN)<77 PSALOCN W !,PSASLN,!
 Q
 ;
CHO ;Extended help for "Enter/edit levels for pharmacy location or master vault."
 W !?5,"Enter P to add or edit stock and reorder levels in a pharmacy location.",!?5,"Enter M to add or edit stock and reorder levels in a master vault."
 W !!?5,"After making your selection, you will be given a list of active pharmacy",!?5,"locations or master vaults from which to choose."
 Q
MV ;Extended help for "Select Master Vault"
 W !?5,"Enter the numbers of master vaults from the list. Select the ones that",!?5,"contain drugs you want to add or edit stock and reorder levels."
 Q
PL ;Extended help for "Select Pharmacy Location"
 W !?5,"Enter the numbers of pharmacy locations from the list. Select the ones that",!?5,"contain drugs you want to add or edit stock and reorder levels."
 Q
