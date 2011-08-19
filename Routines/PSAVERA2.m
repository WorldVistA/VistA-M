PSAVERA2 ;BHM/DB - Edit previously verified invoices #2;21DEC99
 ;;3.0;DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21,49**; 10/24/97
 ;References to ^PSDRUG( are covered by IA #2095
 ;
ASKDRUG ;Change drug
 S PSAGAIN=0,PSABEFOR=PSADRG,DIC(0)="AEQMZ",DIC="^PSDRUG(" D ^DIC K DIC
 I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 S PSADJFLD="D",PSAREA="",PSASUPP=0
 I +Y=-1 D  Q:PSASUPP!(PSAOUT)
 .S PSAVER=1 D SUPPLY^PSANDF Q:PSAOUT  I 'PSASUPP S PSAGAIN=1 Q
 .S PSA50IEN=0,PSADJ=PSAREA,PSAREA=""
 .D RECORD
 G:$G(PSAGAIN) ASKDRUG
 S (PSA50IEN,PSADJ,PSADRG)=+Y D RECORD,VERDISP^PSAUTL4
 I PSANDC'="",$O(^PSDRUG("C",PSANDC,PSA50IEN,0)) D
 .S PSASUB=+$O(^PSDRUG("C",PSANDC,PSA50IEN,0)),$P(^PSD(58.811,PSAIEN,1,PSAIEN1,2),"^",3)=PSASUB
 .I '+$P($G(^PSDRUG(PSA50IEN,1,PSASUB,0)),"^",7) D DUOU^PSAVER2 Q
 .I +$P($G(^PSDRUG(PSA50IEN,1,PSASUB,0)),"^",7),+$P($G(^PSDRUG(PSA50IEN,1,PSASUB,0)),"^",7)'=+$P($G(^PSDRUG(PSABEFOR,1,PSASUB,0)),"^",7) D DUOU^PSAVER2
 W !,"Decrementing balance of "_PSABAL_" from "_$P($G(^PSDRUG(PSADRG,0)),"^")
 W !,"Increasing balance of "_PSANEWD_" by "_PSABAL_"."
 Q
 W !!,"Note that if you change the drug on this line item, the balances will be",!,"updated."
LOCATION ;Change pharmacy location
 W !,"If the location is changed, the balances will be decremented from the original",!,"location, the transaction file will record the proper changes.",!
LST ;List all data associated with location/drug
 ;get data from 58.8 & 58.81
 ;Show allsysnonym data from drug file.
RECORD ;Add adjusted data to DA Orders file
 K PSASUBB
 W !,"ok, we'll update the files now at RECORD"
 S PSABFR=0 F  S PSABFR=$O(^PSDRUG(PSABEFOR,1,PSABFR)) Q:PSABFR=$G(PSASUB)  Q:PSABFR'>0  S PSASUBB=PSABFR
 I $G(PSASUBB) S PREVDATA=$G(^PSDRUG(PSABEFOR,1,PSASUBB,0)) D
 .W !,"Will update old drug data with previous synonym data of : ",!,?20,PREVDATA
 I '$G(PSASUBB) W !,"Could not find previous sysnonym data, therefore the prices will remain as",!,"they are.",!
