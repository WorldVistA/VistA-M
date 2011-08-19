PSATRAN ;BIR/JMB-Transfer Drugs between Pharmacies ;8/21/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;
 I $D(^XUSEC("PSAMGR",DUZ)),'$D(^XUSEC("PSJ RPHARM",DUZ)) W !!,"** Contact your Pharmacy Coordinator for access to transfer drugs between",!,?4,"pharmacies. PSAMGR and PSJ RPHARM security keys are required.",! Q
 S PSADUZ=DUZ,PSADUZN=$P($G(^VA(200,PSADUZ,0)),"^") D SIG^XUSESIG G:X1="" EXIT
FROM ;select FROM pharmacy
 S (PSADD,PSACNT,PSAOUT)=0,PSASLN="",$P(PSASLN,"-",80)="",PSATRAN="F"
 D ^PSAUTL3 G:PSAOUT EXIT S PSACHK=$O(PSALOC(""))
 I PSACHK="",'PSALOC W !,"There are no active pharmacy locations." G EXIT
 S PSAFROM=+PSALOC,PSAFROMN=PSALOCN
DRUG ;select drug
 I '$O(^PSD(58.8,PSAFROM,1,0)) W !!,"There are no drugs in the transferring pharmacy.",!! G EXIT
 W @IOF,!,PSAFROMN
 K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSAFROM,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***"""
 S DIC("A")="Select DRUG: ",DA(1)=+PSAFROM,DIC(0)="QEAM",DIC="^PSD(58.8,"_PSAFROM_",1,"
 D ^DIC K DIC G:Y<0 FROM I ($D(DTOUT))!($D(DUOUT)) G EXIT
 G:Y<0 FROM
 S PSADRG=+Y,PSADRGN=$P($G(^PSDRUG(PSADRG,0)),"^"),PSABAL=+$P($G(^PSD(58.8,PSAFROM,1,PSADRG,0)),"^",4)
 I PSABAL'>0 W $C(7),!!,PSADRGN," has a "_$S(PSABAL=0:"zero",1:"negative")_" balance.",!,"Select another drug to transfer." G DRUG
QTY ;enter quantity
 S PSADU=$S($P($G(^PSDRUG(PSADRG,660)),"^",8)'="":$P($G(^PSDRUG(PSADRG,660)),"^",8),1:"Unknown")
 W !!,?5,"Dispense Unit: ",PSADU,?35,"Current Balance: "_PSABAL,!
 S DIR(0)="NO^1:"_PSABAL_":0",DIR("A")="Enter Quantity to Transfer",DIR("?")="Enter a whole number between 1 and "_PSABAL,DIR("??")="^D QTYHELP^PSATRAN"
 D ^DIR K DIR I $G(DIRUT) D MSG G DRUG
 S PSATQTY=+Y D TO
 ;
CHK I '$D(^PSD(58.8,PSATO,1,PSADRG,0)) W $C(7),!!,PSATON," does not stock ",PSADRGN,"!",! D ADD G:'PSADD DRUG
ASK ;ask ok
 W !,PSASLN,!,$P($G(^PSDRUG(PSADRG,0)),"^"),!,"Transferring: ",PSATQTY," (",$P($G(^PSDRUG(PSADRG,660)),"^",8),")",!!,"From: ",PSAFROMN,!,"To  : ",PSATON,!,PSASLN,!
 K DIR,DIRUT S DIR(0)="Y",DIR("A")="OK to post",DIR("B")="Yes",DIR("?")="Answer 'YES' to post this transfer, 'NO' or '^' to quit.",DIR("??")="^D HELP^PSATRAN"
 D ^DIR K DIR I 'Y!$D(DIRUT) D MSG G DRUG
 D:PSADD ADD1 D ^PSATRAN1 G:'PSAOUT DRUG
 ;
EXIT I $O(^TMP("PSASIG",$J,0)) D
 .W ! S DIR(0)="Y",DIR("A")="Print transfer signature sheets",DIR("B")="Y",DIR("?",1)="Enter YES to print transfer signature sheets for the transfers just entered."
 .S DIR("?")="Enter NO to bypass printing the sheets then exit the option.",DIR("??")="^D PRINTYN^PSATRAN" D ^DIR K DIR Q:$G(DIRUT)!('+Y)
 .D ^PSASIG
 ;
KILL K %,DA,DIC,DIE,DINUM,DIR,DIRUT,DTOUT,DUOUT,PSABAL,PSACHK,PSACNT,PSADD,PSADISP,PSADJ,PSADRG,PSADRGN,PSADT,PSADU,PSADUZ,PSADUZN,PSAFRDA,PSAFROM,PSAFROMN
 K PSAJJ,PSALCNT,PSALES,PSALOC,PSALOCA,PSALOCN,PSANODE,PSARDT,PSAREC,PSAREPRT,PSARET,PSASEL,PSASLN,PSAOUT
 K PSATEMP,PSATF,PSATODA,PSATO,PSATON,PSATQTY,PSATRAN,X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY,Y,YY
 Q
MSG W $C(7),!!,"No action taken.",! H 1
 Q
ADD ;ask to add drug
 K DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("?")="Answer 'YES' to continue with this transfer, 'NO' or '^' to quit.",DIR("??")="^D HELP^PSATRAN"
 D ^DIR K DIR I $G(DIRUT) D MSG Q
 S PSADD=+Y
 Q
ADD1 ;add drug
 Q:$D(^PSD(58.8,PSATO,1,PSADRG,0))
 S:'$D(^PSD(58.8,PSATO,1,0)) ^PSD(58.8,PSATO,1,0)="^58.8001IP^^"
 K DA,DD,DO S DIC(0)="L",DIC="^PSD(58.8,"_+PSATO_",1,",DA(1)=+PSATO,(X,DINUM)=+PSADRG D FILE^DICN K DA,DIC
 Q
 ;
TO ;transfer TO pharmacy
 K PSALOCA(PSAFROMN),DA
 S PSACNT=0,PSATON="" F  S PSATON=$O(PSALOCA(PSATON)) Q:PSATON=""  S PSACNT=PSACNT+1
 I PSACNT=1 S PSATON=$O(PSALOCA("")),PSATO=+$O(PSALOCA(PSATON,0)) Q:'$G(PSAREPRT)
 ;
 S PSACNT=0,PSATRAN="T" W ! D DISP^PSAUTL3 G:PSAOUT EXIT S PSACNT=0,PSACHK=$O(PSALOC(""))
 S PSATO=+PSALOC,PSATON=PSALOCN
 Q
HELP ;Extended help for 'Do you want to continue?'
 W !?5,"Enter YES if it is okay to transfer this drug. Enter NO to abort the transfer."
 Q
PRINTYN ;Extended help for 'Print transfer signature sheets?'
 W !?5,"Enter YES if you want to print sheets that can be carried with the drugs",!?5,"to the receiving pharmacy for signature. The person signing the sheet is",!?5,"signing that he/she received the drug(s)."
 W !!?5,"Enter NO if you do not want to print the signature sheets. You will exit",!?5,"from the option."
 Q
QTYHELP ;Extended help for 'Enter Quantity to Transfer'
 W !?5,"Enter the number of dispense units to be transferred out of the",!?5,"pharmacy location. Enter a whole number between 1 and "_PSABAL_"."
 Q
