PSAVER5 ;BIR/JMB-Verify Invoices - CONT'D ;10/6/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;;**1**; 10/24/97
 ;This routine assigns an invoice to a pharmacy location or master vault
 ;if the location changes during verification.
 ;
MASTER ;Assigns invoice to Master Vault
 S (PSAMVN,PSAMV)=0 F  S PSAMV=+$O(^PSD(58.8,"ADISP","M",PSAMV)) Q:'PSAMV  D
 .S PSAMVN=PSAMVN+1,PSAONEMV=PSAMV,PSAMV($P(^PSD(58.8,PSAMV,0),"^"),PSAMV)=""
 I 'PSAMVN W !!,"No master vaults are set up. You must set up a master vault then",!,"select the Process Uploaded Prime Vendor Invoices Data option." S PSAOUT=1 Q
 I PSAMVN=1 D  Q
 .W !!,"Controlled substances on the invoice has been",!,"automatically assigned to the Master Vault."
 .W !,$P(^PSD(58.8,PSAONEMV,0),"^")
 .W !!,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN)
 .S DR="13///^S X="_PSAONEMV D PHARM^PSAVER2
 I PSAMVN>1 D DISPMV W !,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN) D SELMV
 Q
 ;
DISPMV ;Displays active master vaults
 W @IOF,!?22,"<<< ASSIGN A MASTER VAULT SCREEN >>>",!,PSASLN
 S PSA=0,PSAMVA="" F  S PSAMVA=$O(PSAMV(PSAMVA)) Q:PSAMVA=""  D
 .S PSAMVIEN=0 F  S PSAMVIEN=$O(PSAMV(PSAMVA,PSAMVIEN)) Q:'PSAMVIEN  D
 ..S PSA=PSA+1,PSAVAULT(PSA,PSAMVA,PSAMVIEN)=""
 ..W !,$J(PSA,2)_".",?4,PSAMVA
 W !
 Q
 ;
SELMV ;Select displayed master vaults
 W ! S DIR(0)="NO^1:"_PSA,DIR("A")="Select Master Vault",DIR("?")="Select the Master Vault that received the invoice's drugs"
 S DIR("??")="^D MV^PSAPROC" D ^DIR K DIR Q:Y=""  I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y
 S PSAMVA=$O(PSAVAULT(PSASEL,"")) Q:PSAMVA=""  S PSAMVIEN=+$O(PSAVAULT(PSASEL,PSAMVA,0)) Q:'PSAMVIEN  S DR="13///^S X="_PSAMVIEN D PHARM^PSAVER2
 Q
 ;
GETLOC ;Gets pharmacy locations
 S (PSALOC,PSANUM)=0 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .S PSANUM=PSANUM+1,PSAONE=PSALOC,PSAISIT=+$P(^PSD(58.8,PSALOC,0),"^",3),PSAOSIT=+$P(^(0),"^",10)
 .D SITES^PSAUTL1 S PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=PSAISIT_"^"_PSAOSIT
 G:'PSANUM NONE G:PSANUM=1 ONE G:PSANUM>1 MANY
 ;
NONE ;No DA pharmacy locations
 W !!,"There are no Drug Accountability pharmacy locations.",!!,"Use the Set Up/Edit a Pharmacy Location option on Pharmacy Location menu"
 W !,"to setup one or more pharmacy locations. Then select the Process Uploaded",!,"Prime Vendor Invoice Data option to process the invoices."
 Q
 ;
ONE ;Only one location
 S PSACNT=0,PSALOC=PSAONE,PSALOCN=$O(PSALOCA(""))
 W !!,"The non-controlled substance items on the invoice have",!,"been automatically assigned to the Pharmacy Location."
 W:$L(PSALOCN)>76 !,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 PSALOCN
 W !!,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN)
 S DR="4///^S X="_PSAONE D PHARM^PSAVER2
 Q
 ;
MANY ;If more than one pharmacy location, display invoices.
 D DISPLOC W !,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN) D SELLOC
 Q
 ;
DISPLOC ;Displays the active pharmacy locations.
 W @IOF,!?19,"<<< ASSIGN A PHARMACY LOCATION SCREEN >>>",!,PSASLN
 S PSACNT=0,PSALOCN="" F  S PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  D
 .S PSALOC=0 F  S PSALOC=$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC  D
 ..S PSACNT=PSACNT+1,PSAMENU(PSACNT,PSALOCN,PSALOC)=PSALOC
 ..W !,$J(PSACNT,2)_"." W:$L(PSALOCN)>72 ?4,$P(PSALOCN,"(IP)",1)_"(IP)",!?21,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<73 ?4,PSALOCN
 W !
 Q
 ;
SELLOC ;Select the Pharmacy Location to be assigned to the order.
 W ! K DIR S DIR(0)="NO^1:"_PSACNT,DIR("A")="Pharmacy Location",DIR("?")="Select the pharmacy location that received the invoice's drugs"
 S DIR("??")="^D LOCHELP^PSAVER5" D ^DIR K DIR Q:Y=""  I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y
 S PSALOCN=$O(PSAMENU(PSASEL,"")) Q:PSALOCN=""  S PSALOC=$O(PSAMENU(PSASEL,PSALOCN,0)) Q:'PSALOC  S DR="4///^S X="_PSALOC D PHARM^PSAVER2
 Q
 ;
CS ;Sets invoice's CONTROLLED SUBSTANCES field if a drug changed from CS to
 ;non-CS or vice-versa.
 S (PSA10,PSAL,PSAN10)=0 F  S PSAL=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAL)) Q:'PSAL  D
 .I +$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAL,0)),"^",10) S PSA10=PSA10+1 Q
 .S PSAN10=PSA10+1
 S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",8)=$S(PSA10&(PSAN10):"S",PSA10&('PSAN10):"A",1:"N")
 S PSAIN=^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 Q
 ;
LOCHELP ;Extended help for the select "Pharmacy Location" prompt
 W !?5,"Enter the number of the pharmacy location for which you want to assign",!?5,"the order. The invoiced drugs in the assigned pharmacy location will be"
 W !?5,"incremented with the quantity received after the order is verified."
 Q
