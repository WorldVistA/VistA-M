PSAVER3 ;BIR/JMB-Verify Invoices - CONT'D ;9/5/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,19,21,64,70**; 10/24/97;Build 12
 ;This routine checks for verification errors, prints an error report,
 ;& changes data in DA ORDERS to verification if there are no errors.
 ;
 ;References to ^DIC(51.5 are covered by IA #1931
 ;References to ^PSDRUG( are covered by IA #2095
 ;
SETLINE ;Set line as verified if all data is present.
 K PSADRG,PSAOU,PSAQTY S (PSADJN,PSADJ)=0
 S PSADATA=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0))
 I $O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,0)) D
 .S PSAA=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,0)) Q:PSAA=2
 .S PSADJ=0 F  S PSADJ=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ)) Q:'PSADJ  D
 ..Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ,0))
 ..S PSADJN=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ,0)
 ..I $P(PSADJN,"^")="D" D
 ...I (+$P(PSADJN,"^",9)&($P(PSADJN,"^",6)'?.N))!('+$P(PSADJN,"^",9)&(+$P(PSADJN,"^",5))&($P(PSADJN,"^",2)'?.N)) S PSASUP=PSASUP+1,PSALNSU=1,PSADRG=0 Q
 ...S PSADRG=$S($P(PSADJN,"^",6)'="":$P(PSADJN,"^",6),$P(PSADJN,"^",2)'="":$P(PSADJN,"^",2),1:0)
 ..I $P(PSADJN,"^")="O" S PSAOU=$S(+$P(PSADJN,"^",6):+$P(PSADJN,"^",6),+$P(PSADJN,"^",2):+$P(PSADJN,"^",2),1:0)
 ..I $P(PSADJN,"^")="Q" S PSAQTY=$S($P(PSADJN,"^",6)'="":+$P(PSADJN,"^",6),$P(PSADJN,"^",2)'="":+$P(PSADJN,"^",2),1:0)
 S:'$G(PSADRG) PSADRG=+$P(PSADATA,"^",2) S:'$D(PSAQTY) PSAQTY=+$P(PSADATA,"^",3)
 ;DAVE B (13SEP99) PSA*3*19 If item is supply, skip this area
 I $G(PSALNSU)=1,$G(PSADRG)=0,$G(PSASUP)>0 G SUPPLY
 S PSATEMP=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,2)),PSANDC=$P(PSADATA,"^",11)
 ;DAVE B (PSA*3*19) Check for exisitence of NDC
 S PSASUB=$S(+$P(PSATEMP,"^",3):+$P(PSATEMP,"^",3),1:0) ;NDC may be zero
 I $G(PSANDC)'="",$G(PSANDC)'=0,$G(PSADRG)'="",$G(PSADRG)'=0,$D(^PSDRUG("C",PSANDC,PSADRG)) S PSASUB=$S($G(PSASUB):$G(PSASUB),+$O(^PSDRUG("C",PSANDC,PSADRG,0)):+$O(^PSDRUG("C",PSANDC,PSADRG,0)),1:0)
 S PSADUOU=+$P(PSATEMP,"^"),PSAREORD=+$P(PSATEMP,"^",2),PSASTOCK=+$P(PSATEMP,"^",4)
 I '$D(PSAOU) D
 .I +$P(PSADATA,"^",4),$P($G(^DIC(51.5,+$P(PSADATA,"^",4),0)),"^")'="" S PSAOU=+$P(PSADATA,"^",4) Q
 .I PSADRG,PSASUB,$P($G(^PSDRUG(PSADRG,1,PSASUB,0)),"^",5) S PSAOU=$P($G(^PSDRUG(PSADRG,1,PSASUB,0)),"^",5) Q
 .I $P(PSATEMP,"^",5)'="",+$P($P(PSATEMP,"^",5),"~",2) S PSAOU=+$P($P(PSATEMP,"^",5),"~",2)
 I PSASUB D
 .;Next line added 8APR98 (Dave B)
 .S PSALOC=$S($G(PSALOC)'="":PSALOC,1:$S($P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",12):$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",12),$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",5):$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",5),1:0))
 .S:'PSADUOU PSADUOU=$S(PSADRG&(+$P($G(^PSDRUG(PSADRG,1,PSASUB,0)),"^",7)):+$P($G(^PSDRUG(PSADRG,1,PSASUB,0)),"^",7),1:1)
 .S:'PSASTOCK PSASTOCK=$S(PSADRG:+$P($G(^PSD(58.8,PSALOC,1,PSADRG,0)),"^",3),1:0)
 .S:'PSAREORD PSAREORD=$S(PSADRG:+$P($G(^PSD(58.8,PSALOC,1,PSADRG,0)),"^",5),1:0)
 ;
SUPPLY ;If it is a supply, automatically verify it.
 I '+$G(PSAERR),PSALNSU,'$G(PSAPRINT) D VERIFY,VERIFY1 Q
 Q:$G(PSASUP)&(+$G(PSAERR))  ;; <PSA*3*70 RJS
 ;
NEWDRUG ;Store in array if drug is new to location/vault
 I +PSADRG D
 .I $P($G(^PSDRUG(PSADRG,2)),"^",3)["N",+$P(PSAIN,"^",12),'$D(^PSD(58.8,+$P(PSAIN,"^",12),1,PSADRG,0)) D
 ..S PSAHOLD(+$P(PSAIN,"^",12),PSAIEN,PSAIEN1,$S($P($G(^PSDRUG(PSADRG,0)),"^")'="":$P($G(^PSDRUG(PSADRG,0)),"^"),1:"UNKNOWN"))=PSADRG,$P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),"^",10)=1
 .I $P($G(^PSDRUG(PSADRG,2)),"^",3)'["N",+$P(PSAIN,"^",5),'$D(^PSD(58.8,+$P(PSAIN,"^",5),1,PSADRG,0)) D
 ..S PSAHOLD(+$P(PSAIN,"^",5),PSAIEN,PSAIEN1,$S($P($G(^PSDRUG(PSADRG,0)),"^")'="":$P($G(^PSDRUG(PSADRG,0)),"^"),1:"UNKNOWN"))=PSADRG,$P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),"^",10)=0
 ;
NOTSUP ;If it is not a supply, look for drug, qty, dispense units, dispense
 ;units/order unit, order unit, location/master vault, & reorder level
 I '+$P(PSADATA,"^",2)&('$G(PSADRG)) S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"D"
 I $P(PSADATA,"^",3)=""&($G(PSAQTY)="") S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"Q"
 I $P($G(^PSDRUG(PSADRG,660)),"^",8)="" S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_8
 I '+$P($G(^PSDRUG(PSADRG,1,+PSASUB,0)),"^",7)&('+$G(PSADUOU)) S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"U"
 I '+$P(PSADATA,"^",4)&('$G(PSAOU)) S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"O"
 ;
 I $P($G(^PSDRUG(PSADRG,2)),"^",3)'["N" D
 .I '+$P(PSAIN,"^",5) S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"P" D CS^PSAVER5
 .S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),"^",10)=0,PSADATA=^(0)
 I $P(PSAIN,"^",8)="N"!($P(PSAIN,"^",8)="S"),'+$P(PSAIN,"^",5),$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))'["P" S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"P"
 ;
 I $P($G(^PSDRUG(PSADRG,2)),"^",3)["N" D
 .I '+$P(PSAIN,"^",12) S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"M" D CS^PSAVER5
 .S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),"^",10)=1,PSADATA=^(0)
 I $P(PSAIN,"^",8)="A"!($P(PSAIN,"^",8)="S"),'+$P(PSAIN,"^",12),$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))'["M" S PSANOVER(PSAIEN,PSAIEN1,PSALINE)=$G(PSANOVER(PSAIEN,PSAIEN1,PSALINE))_"M"
 ;
 S:$D(PSANOVER(PSAIEN,PSAIEN1,PSALINE)) PSAERR=PSAERR+1,PSALNERR=1
 I 'PSAERR D GOOD Q
 Q
 ;
GOOD ;If no errors found, verify invoice.
 D VERIFY,VERIFY1
 S PSAL=0 F  S PSAL=+$O(PSAHOLD(PSAL)) Q:'PSAL  D
 .S PSANAME="" F  S PSANAME=$O(PSAHOLD(PSAL,PSAIEN,PSAIEN1,PSANAME)) Q:PSANAME=""  D
 ..S PSANEWD(PSAL,PSANAME)=PSAHOLD(PSAL,PSAIEN,PSAIEN1,PSANAME)
 K PSAHOLD
 Q
 ;
PRINT ;Prints verification error list
 S DIR(0)="Y",DIR("A")="Do you want to print the verification error report",DIR("B")="N"
 S DIR("?",1)="Enter YES if you want to print the report just displayed.",DIR("?")="Enter NO if you do not want to print the report.",DIR("??")="^D PRINTYN^PSAVER3"
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 Q:Y=""!('+Y)
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTDESC="Drug Acct. - Print Prime Vendor Invoices",ZTRTN="PRN^PSAVER3"
 .I $O(PSANOVER(0))'="" S ZTSAVE("PSANOVER(")=""
 .F PSASAVE="PSAIN","PSASLN" S:$D(@PSASAVE) ZTSAVE(PSASAVE)=""
 .D ^%ZTLOAD
PRN ;Entry point to print verification errors
 S (PSAERR,PSALINE,PSAOUT,PSAPG)=0,PSAPRINT=1
 S PSAIEN=0 F  S PSAIEN=$O(PSANOVER(PSAIEN)) Q:'PSAIEN!(PSAOUT)  D
 .Q:'$D(^PSD(58.811,PSAIEN,0))  S PSAORD=$P(^PSD(58.811,PSAIEN,0),"^")
 .S PSAIEN1=0 F  S PSAIEN1=$O(PSANOVER(PSAIEN,PSAIEN1)) Q:'PSAIEN1!(PSAOUT)  D
 ..Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,0))  S PSAIN=^PSD(58.811,PSAIEN,1,PSAIEN1,0),PSAINV=$P(PSAIN,"^")
 ..S PSALINE=0 F  S PSALINE=$O(PSANOVER(PSAIEN,PSAIEN1,PSALINE)) Q:'PSALINE!(PSAOUT)  D
 ...D NOVER
 .K PSANOVER(PSAIEN)
 W !!,"** The invoice has not been placed in a Verified status!",!
 D:$E(IOST,1,2)="C-" END^PSAPROC W:$E(IOST)'="C" @IOF
 D ^%ZISC
 Q
 ;
NOVER ;Prints errors
 S PSANO=PSANOVER(PSAIEN,PSAIEN1,PSALINE),PSALEN=$L(PSANO)
 S PSALINEN=$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0)),"^"),PSATAB=$L(PSALINEN)+8
 I $E(IOST,1,2)="C-" D:'PSAPG HDR I $Y+(4+PSALEN)>IOSL D END^PSAPROC Q:PSAOUT  D HDR
 I $E(IOST)'="C",$Y+(4+PSALEN)>IOSL!('PSAPG) D HDR
 W "Line# "_PSALINEN_": "
 W:PSANO[8 ?PSATAB,"Dispense unit",!
 W:PSANO["U" ?PSATAB,"Dispense unit per order unit",!
 W:PSANO["D" ?PSATAB,"Drug",!
 I PSANO["M" W ?PSATAB,"Master Vault",!
 W:PSANO["O" ?PSATAB,"Order unit",!
 I PSANO["P" W ?PSATAB,"Pharmacy location",!
 W:PSANO["Q" ?PSATAB,"Quantity",!
 W !
 Q
 ;
HDR ;Prints header
 I $E(IOST,1,2)="C-" W @IOF,!?23,"<<< VERIFICATION ERROR REPORT >>>"
 I $E(IOST)'="C" W:PSAPG'=1 @IOF W !?20,"DRUG ACCOUNTABILITY/INVENTORY INTERFACE",!?27,"VERIFICATION ERROR REPORT",?72,"Page "_PSAPG,!
 S PSAPG=PSAPG+1
 W !,"Order#: "_PSAORD_"  Invoice#: "_$P(PSAIN,"^")_"  Invoice Date: "_$$FMTE^XLFDT(+$P(PSAIN,"^",2)) W:'$G(PSAERR) !,PSASLN,!
 I $G(PSAERR) W !!,"The following line numbers' status cannot be changed to Verified.",!,"The fields that contain an error or need data are listed with the line item.",!,PSASLN,!
 Q
 ;
STATUS ;Sets invoice's status to Verified
 ;
 ;PSA*3*3 (DAVE B)
 S DA=PSAIEN1,DA(1)=PSAIEN,DIE="^PSD(58.811,"_DA(1)_",1,",DR="2///V;12////^S X="_DUZ
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 K DIE
 Q
 ;
VERIFY ;Set line item to verified
 I PSADRG,$P($G(^PSDRUG(PSADRG,2)),"^",3)["N" S PSACSLN=1
 E  S PSACSLN=0
 K DA S DA=PSALINE,DA(1)=PSAIEN1,DA(2)=PSAIEN,DIE="^PSD(58.811,"_DA(2)_",1,"_DA(1)_",1,",DR="7///^S X="_DT_";8////^S X="_DUZ_";12///^S X=PSACSLN"
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 K DIE
 Q
 ;
VERIFY1 ;Set adjs if entire invioce was verified
 S DA=0 F  S DA=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,DA)) Q:'DA  D
 .Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,DA,0))
 .Q:$P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,DA,0),"^",9)=DUZ
 .S PSAREA="",PSADJ=$P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,DA,0),"^",2) D ADJ^PSAVER2
 Q
 ;
DDQOR ;Extended help for 'Edit field'
 W !?5,"Enter the number or range of numbers of the field you want to edit.",!?5,"For example, 1-3 or 1,3"
 Q
LNHELP ;Extended help for 'Line Number"
 W !?5,"Enter the number of the item on the invoice you want to edit.",!?5,"You may enter several line item numbers separated by comas.",!!?5,"Do NOT enter a range of numbers separated by a dash."
 Q
PRINTYN ;Extended help for 'Print verification report'
 W !?5,"Enter YES to print the Verification Error Report on a printer.",!?5,"Enter NO if you do not want to print the report."
 Q
