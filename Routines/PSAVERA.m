PSAVERA ;BHM/DBM - Change verified invoice data;16AUG05
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21,36,40,53,63,70**; 10/24/97;Build 12
 ;
 ;References to ^DIC(51.5 are covered by IA #1931
 ;References to ^PSDRUG( are covered by IA #2095
 D Q
 D HOME^%ZIS S XX="VERIFIED INVOICE ALTERATION SCREEN" W @IOF,!!,?((IOM/2)-($L(XX)/2)),XX,!!
ORDR ;Get Order Number
 S DIC(0)="AEQMZ",DIC("A")="Select Order Number: ",DIC="^PSD(58.811," D ^DIC K DIC G Q:+Y'>0 S PSAIEN=+Y,PSAORD=$P(Y,U,2)
 ;
INV ;Get Invoice Number
 S DIC(0)="AEQMZ",DIC("A")="Select Invoice Number: ",DIC="^PSD(58.811,"_PSAIEN_",1,",D="ASTAT" D ^DIC K DIC G Q:+Y'>0 S PSAIEN1=+Y,PSAINV=$P(Y,U,2)
 S DATA=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,0))
 S PSALOC=$S($P(DATA,"^",12)'="":$P(DATA,"^",12),1:$P(DATA,"^",5)) I $G(PSALOC)="" S PSALOC="No Location identified"
 D ^PSAVERA1
 K DATA,PSAITM,LINENUM,X,X1,X2,X3,DIC,DA,DR D HDR
DISP S PSAITM=$S('$D(PSAITM):$O(INVARRAY(PSAORD,PSAINV,0)),1:$O(INVARRAY(PSAORD,PSAINV,PSAITM))) G LINEASK:PSAITM'>0 S LINENUM=$G(LINENUM)+1
 S DATA=$G(INVARRAY(PSAORD,PSAINV,PSAITM)),PSAOU=$P(DATA,"^",4) I $G(PSAOU) S PSAOU(1)=$P($G(^DIC(51.5,$P(DATA,"^",4),0)),"^") ;Current Order Unit  ;; <*63 RJS
 W !,PSAITM,?6,$S($P($P(DATA,"^",1),"~",1)'>0:$P($P(DATA,"^",1),"~",1),1:$P($P(DATA,"^",1),"~",2)),?45,$S($G(PSAOU)="":"none",$G(PSAOU(1))'="":$G(PSAOU(1)),1:$G(PSAAOU)),?55,$J($P($G(DATA),"^",2),4),?61,$P(DATA,"^",5)  ;;<PSA*3*70 RJS
 I IOST["C-",$Y>(IOSL-5) S DIR(0)="E" D ^DIR G Q:$G(DUOUT)=1 D HDR
 G DISP
LINEASK ;ask for line number
 W !,"Enter the corresponding item number to edit: " R AN:DTIME I AN["^"!(AN="") G Q
 I AN<1!(AN>LINENUM) W !,"Enter a number between 1 & ",LINENUM,! G LINEASK
 I "?"[AN W !,"Select the number that corresponds to the line item that needs editing",! K AN G LINEASK
 S DATA=$G(INVARRAY(PSAORD,PSAINV,AN))
 S PSALINE=AN,PSAIN="NADA" I '$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0)) W !,"Invalid line selection." G LINEASK
 S PSADATA=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),PSASUP=0
 S PSACS=0 S:+$P(PSADATA,"^",10) PSACS=$G(PSACS)+1
 S PSANDC=$P(PSADATA,"^",11)
 S PSALINEN="" D VERDISP^PSAUTL4 W !,PSASLN,!
 S PSAVEND=$P(^PSD(58.811,PSAIEN,0),"^",2)
 S PSAODUOU=PSADUOU
 ;; *63
 S PSA581="" F  S PSA581=$O(^PSD(58.81,"PV",PSAINV,PSA581)) Q:'PSA581  I $P(^PSD(58.81,PSA581,0),U,5)=PSADRG S PSABFR(581)=$G(^PSD(58.81,PSA581,0))
 S:$G(PSABFR(581)) PSDTRN=$P(PSABFR(581),U,1),PSABFR("Q")=$S($G(^PSD(58.81,PSDTRN,4)):$P(^PSD(58.81,PSDTRN,4),"^",3),1:$P(^PSD(58.81,PSDTRN,0),"^",6)) ; <*63 RJS >
DRG W !,"Select (D)rug or (O)rder Unit " R AN:DTIME G Q:AN["^"!(AN="") W $S("Dd"[AN:"rug","oO"[AN:"rder Unit",1:"??") I "DdOo"'[AN W !,"Enter a 'D' to edit the Drug, or 'O' to edit the order unit",! K AN G DRG
 I "Dd"'[AN D ^PSAVERA3 G Q  ;;*63
 ;Get either new name of drug or supply item description
 S PSABFR=$P(DATA,"~",1),PSABFR(1)=$S(PSABFR'?.N:PSABFR,1:$P($P(DATA,"^"),"~",2)),PSABFR("NDC")=$P(PSADATA,"^",11)  ;;*63
DRGAGN D
 .S X1=0 F  S X1=$O(^PSDRUG(PSABFR,1,X1)) Q:X1'>0  S DATA=$G(^PSDRUG(PSABFR,1,X1,0)) I $P(DATA,"^",2)=PSABFR("NDC") S PSABFR("SYNNODE")=X1  ;;*63
 D PSANDC1^PSAHELP S PSADASH=PSANDCX K PSANDCX
 I $G(PSABFR("SYNNODE"))="",$E(PSABFR("NDC"))'="S" S PSABFR("NDC")="S"_PSABFR("NDC") G DRGAGN ;may be supply, try again
 I $G(PSABFR("SYNNODE"))'="" S PSASUB=PSABFR("SYNNODE") D
 .S DATA=$G(^PSDRUG(PSABFR,1,PSASUB,0)),PSAOU=$P(DATA,"^",5),PSAPOU=$P(DATA,"^",6),PSADUOU=$P(DATA,"^",7),PSAPDUOU=$P(DATA,"^",8)
 .S PSADU=$P($G(^PSDRUG(PSABFR,660)),"^",8)
 I ($G(PSAOU)=""!$G(PSAPOU)=""!$G(PSADUOU)=""!$G(PSAPDUOU)="") W !!,"Sorry, I could not find the necessary information to change the drug selection.",! G Q
 W !,"Current Drug : ",PSABFR(1)
DRG1 S PSAGAIN=0,DIC("A")="Select name of Correct Drug: ",PSABFR=PSADRG,DIC(0)="AEQMZ",DIC="^PSDRUG(" D ^DIC K DIC G Q:PSAOUT
 I $G(DTOUT)!($G(DUOT))!(Y<0) S PSAOUT=1 Q
 S (PSADJ,PSADRG)=+Y
 W !!,"Comparing drug file data..."
 S PSAODU=$P($G(^PSDRUG(PSADRG,660)),"^",8),PSAXDUOU=$P($G(^PSDRUG(PSADRG,660)),"^",5)
 I $P($G(^PSDRUG(PSADRG,660)),"^",2)'=$G(PSAOU) W !,"The Order Units are different between these two drugs."
 I $P($G(^PSDRUG(PSADRG,660)),"^",8)'=$G(PSADU) W !,"Please Enter an appropriate Dispense Unit" S DIE="^PSDRUG(",DA=PSADRG,DR="14.5" D ^DIE S PSADU=$P(^PSDRUG(PSADRG,660),"^",8)
 I $P($G(^PSDRUG(PSADRG,660)),"^",5)'=$G(PSADUOU) W !,"Please enter the appropriate Dispense Units per order unit" S DIE="^PSDRUG(",DA=PSADRG,DR="15" D ^DIE S PSADUOU=$P(^PSDRUG(PSADRG,660),"^",5)
 K DIE,DA,DR
ASK R !!,"Are you sure about this ?  NO// ",AN:DTIME G NOCHNG:AN["^"!(AN="")
 S AN=$E(AN) I "yYnN"'[AN W !,"Answer yes, and the data on file for the current drug will be transferred",!,"to the new drug selection.",!,"That includes Order Unit, Dispense Unit, Dispense Units per Order Unit, etc.",!! G ASK
 I "Nn"[AN G NOCHNG ;*53
 S PSAAFTER=PSADRG,PSADRG=PSABFR
 I $D(^PSDRUG(PSADRG))&$G(PSABFR(581)) D
 .W !,"Removing "_PSABFR("Q")_" from "_PSABFR(1)
 .S FMDATA=$P($G(^PSDRUG(PSADRG,660.1)),"^")-PSABFR("Q"),DIE="^PSDRUG(",DA=PSADRG,DR="50////^S X="_FMDATA
 .F  L +^PSDRUG(DA,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D ^DIE L -^PSDRUG(DA,0) K FMDATA
 S PSADRG=PSAAFTER
 I $G(PSAPOU)="",$G(PSAPRICE)'="" S PSAPOU=PSAPRICE
 W !,"Adding "_($G(PSAQTY)*$G(PSADUOU))_" to "_$P($G(^PSDRUG(PSADRG,0)),"^")
 W !,"Entering new drug selection as an adjustment."
 S PSAREA="",PSADJFLD="D",PSADJ=PSADRG D RECORD^PSAVER2,50^PSAVER7
FILE ;File dispense units per order units into 58.811
 S DIE="^PSD(58.811,"_PSAIEN_",1,"_PSAIEN1_",1,",DA=PSALINE,DA(1)=PSAIEN1,DA(2)=PSAIEN,DR="10///"_PSADUOU D ^DIE
 G:$D(^PSD(58.811,"ASTAT","P",PSAIEN,PSAIEN1)) Q  ;; *63 RJS
 D UPDATE^PSAVERA1 G Q
 ;
HDR W @IOF,!?25,"EDIT VERIFIED INVOICED ITEM SCREEN",!,PSASLN,!
 W !,?44,"Order",!,"#",?6,"Drug/Item Name",?45,"Unit",?56,"Qnty.",?67,"NDC",!,PSASLN,! Q  ;; <- PSA*3*70 RJS
Q K AN,D,DA,DATA,DIC,DIR,INVARRAY,LINENUM,POP,PSA50IEN,PSA581,PSAABAL,PSAAFTER,PSAAQTY,PSABAL,PSABFR,PSACS,PSADASH,PSADATA,PSADJ,PSADJD,PSADJFLD,PSADJO,PSADJP,PSADJQ,PSADRG,PSADRUGN,PSADT
 K PSADU,PSADUOU,PSADUREC,PSAEDTT,PSAGAIN,PSAIEN,PSAIEN1,PSAIN,PSAINV,PSAITM,PSALINE,PSALINEN,PSALOC,PSANDC,PSANDUOU,PSANEW,PSANODE,PSANPDU,PSANQTY,PSAODASH,PSAODU,PSAODUOU,PSAONDC,PSAORD
 K PSAOU,PSAOUT,PSAPOU,PSAPRICE,PSAQTY,PSAREA,PSAREORD,PSASET,PSASLN,PSASTOCK,PSASUB,PSASUP,PSASUPP,PSAT,PSATEMP,PSAUPC,PSAVDUZ,PSAVEND,PSAVER,PSAVSN,PSAXDUOU,PSDTRN,X,X1,X2,X3,XX,XXX,Y
 Q
NOCHNG ;*53 said no to changes, backout the edits on the new drug choice.
 K DIE,DR,DA
 S DIE="^PSDRUG(",DA=PSADRG,DR="14.5////^S X=PSAODU;15////^S X=PSAXDUOU" D ^DIE
 W !,"NO CHANGE",! G Q
