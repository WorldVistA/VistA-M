PSAPROC2 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**34,50,70**; 10/24/97;Build 12
 ;This routine allows the user to edit invoices with errors or missing
 ;data.
 ;
CHK S PSA=+$O(PSAERR(0))
 I 'PSA W @IOF,!!,"There are no invoices that need to be processed." D END^PSAPROC Q
 ;
INV D HDR W !,"  More data is needed on the following invoices. Choose the invoices from",!,"  the list you want to edit.",!,PSASLN
 S (PSACNT,PSAMENU,PSASTOP)=0
 F  S PSAMENU=+$O(PSAERR(PSAMENU)) Q:'PSAMENU!(PSAOUT)  D  Q:PSASTOP
 .I $Y+4>IOSL D HEADER Q:PSASTOP
 .S PSAORD=$P(PSAERR(PSAMENU),"^"),PSAINV=$P(PSAERR(PSAMENU),"^",2),PSACTRL=$P(PSAERR(PSAMENU),"^",3),PSACNT=PSACNT+1
 .W !?2,PSAMENU_". ",?6,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+^XTMP("PSAPV",PSACTRL,"IN"))
 W !,PSASLN K DIR,PSASTOP
 S DIR(0)="LO^1:"_PSACNT,DIR("A")="Select invoices to edit",DIR("?",1)="Enter the number to the left of the invoice",DIR("?")="data to be processed or a range of numbers." W !
 S DIR("??")="^D SELHELP^PSAPROC2" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y
 D PLOCK^PSAPROC8(2)  ;; < PSA*3*70 RJS
 I '$G(PSASEL) G EXIT^PSAPROC
 ;
PROC W ! S DIR("A",1)="Do you want to select the line items to be edited (S) or",DIR("A")="have them automatically (A) displayed for you?",DIR("B")="A",DIR(0)="SB^S:Select;A:Automatically displayed"
 S DIR("?",1)="Enter ""S"" to allow you to select the line items to be edited.",DIR("?",2)="Enter ""A"" to automatically receive prompts for the line items",DIR("?")="that need editing."
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 G:Y="S" SEL^PSAPROC6
 ;
AUTO ;Process line items
 F PSAPC=1:1 S PSAMENU=$P(PSASEL,",",PSAPC) Q:'PSAMENU!(PSAOUT)  D  Q:PSAOUT
 .Q:'$D(PSAERR(PSAMENU))
 .S PSACTRL=$P(PSAERR(PSAMENU),"^",3),(PSALNCNT,PSALINES,PSACS,PSALLSUP)=0
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))!('$D(^XTMP("PSAPV",PSACTRL,"IT")))
 .S PSAIN=^XTMP("PSAPV",PSACTRL,"IN"),PSALOC=+$P(PSAIN,"^",7),PSAMV=+$P(PSAIN,"^",12)
 .D HDR W !,"Order#: "_$P(PSAIN,"^",4)_"  Invoice#: "_$P(PSAIN,"^",2)_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN),!,PSASLN
 .W:$P(PSAIN,"^",9)="CS" !!,"MASTER VAULT: "_$S(PSAMV:$P($G(^PSD(58.8,PSAMV,0)),"^"),1:"Blank")
 .I $P(PSAIN,"^",10)="" D
 ..D SITES^PSAUTL1 S PSALOCN=$S($D(^PSD(58.8,PSALOC,0)):$P($G(^PSD(58.8,PSALOC,0)),"^"),1:"UNKNOWN")_PSACOMB
 ..W !!,"PHARMACY LOCATION: " I 'PSALOC W "Blank" Q
 ..W:$L(PSALOCN)>76 !,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 !,PSALOCN
 .W ! S PSARECD=$S(+$P(PSAIN,"^",11):+$P(PSAIN,"^",11),+$P(PSAIN,"^",6):+$P(PSAIN,"^",6),1:"") D RECD^PSAPROC3 Q:PSAOUT
 .;
 .;Gets & processes the line items
 .S PSALINE="" F  S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:PSALINE=""!(PSAOUT)  D  Q:PSAOUT
 ..S PSALNCNT=PSALNCNT+1,(PSAPASS,PSASUPP)=0,PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 ..I $P(PSADATA,"^",18)="OK"!($P(PSADATA,"^",18)="P") S:$P(PSADATA,"^",18)="OK" $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="P" S PSALINES=PSALINES+1 S:$P(PSADATA,"^",19)="CS" PSACS=PSACS+1 Q
 ..S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 ..S PSAIEN=$S(+$P(PSADATA,"^",15):+$P(PSADATA,"^",15),1:+$P(PSADATA,"^",6)),PSASUB=+$P(PSADATA,"^",7),PSANDC=$P($P(PSADATA,"^",4),"~"),PSAVSN=$P($P(PSADATA,"^",5),"~")
 ..D EDITDISP^PSAUTL1 D ^PSAPROC9
 .D:'PSAOUT SETINV
 Q:PSAOUT
 I '$O(PSAERR(0)) Q  ;*50 rid select (1-0)
 W @IOF,!,"If you are changing the status of an invoice to Processed, this is the",!,"last time you will be allowed to edit it before it goes to the verifier."
 W !,"If you are not changing the status of an invoice to Processed, you can",!,"edit it now.",!!,"You can edit the invoice's delivery date, pharmacy location, master vault,"
 W !,"and the line item's drug, quantity received, order unit, and dispense units",!,"per order unit. The reorder level can be edited if the pharmacy location or"
 W !,"master vault is set up to track the reorder levels.",!
 S DIR(0)="Y",DIR("A")="Edit invoices",DIR("B")="N",DIR("?",1)="Enter Yes to edit the invoices you just processed.",DIR("?",1)="Enter No to accept the invoices as they are now."
 S DIR("??")="^D EDIT^PSAPROC2" D ^DIR K DIR I $G(DIRUT)!('Y) S PSAOUT=1 Q
 ;
EDITINV ;Edits the invoice before placing in Processed status.
 K PSAERR S (PSACTRL,PSAERR,PSAOUT)=0
 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:PSACTRL=""  D
 .S:$D(^XTMP("PSAPV",PSACTRL,"IN")) PSAERR=PSAERR+1,PSAERR(PSAERR)=$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",4)_"^"_$P(^("IN"),"^",2)_"^"_PSACTRL_"^"_$P(^("IN"),"^",7)_"^"_$P(^("IN"),"^",12)
 ;
 W @IOF,!?26,"<<< EDIT INVOICE SCREEN >>>"
 W !!,"Choose the invoices to be edited. You can edit the invoice's date received and",!,"the line item's drug, quantity received, and order unit. The reorder and"
 W !,"stock levels can be edited if the pharmacy location or master vault is set",!,"up to maintain the reorder levels.",!,PSASLN,!
 S (PSACNT,PSAMENU,PSASTOP)=0
 F  S PSAMENU=+$O(PSAERR(PSAMENU)) Q:'PSAMENU!(PSAOUT)  D  Q:PSASTOP
 .I $Y+4>IOSL D HDR1 Q:PSASTOP
 .S PSAORD=$P(PSAERR(PSAMENU),"^"),PSAINV=$P(PSAERR(PSAMENU),"^",2),PSACTRL=$P(PSAERR(PSAMENU),"^",3),PSACNT=PSACNT+1
 .W !?1,PSACNT_".",?4,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+^XTMP("PSAPV",PSACTRL,"IN"))
 K PSASTOP
 S DIR(0)="LO^1:"_PSACNT,DIR("A")="Select invoices",DIR("?",1)="Enter the number to the left of the invoice",DIR("?")="data to be edited or a range of numbers." W !
 S DIR("??")="^D SEL^PSAPROC2" D ^DIR K DIR S:Y="" DUOUT=1 I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q  ;*50
 S PSASEL=Y D ^PSAPROC6
 Q
HDR ;Screen header
 W @IOF,!?19,"<<< EDIT INVOICES TO BE PROCESSED SCREEN >>>",!
 Q
 ;
HDR1 ;Screen header with hold
 S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 S DIR(0)="E" D ^DIR K DIR I $G(DIRUT) S PSASTOP=1 Q
 W @IOF,!?26,"<<< EDIT INVOICE SCREEN >>>",!!,PSASLN
 Q
 ;
HEADER ;Screen hold with header
 S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 S DIR(0)="E" D ^DIR K DIR I $G(DIRUT) S PSASTOP=1 Q
 W @IOF,!?19,"<<< EDIT INVOICES TO BE PROCESSED SCREEN >>>",!!,PSASLN
 Q
 ;
SETINV ;Sets invoice to processed if okay.
 S PSAOK=1
 I PSALLSUP=PSALNCNT S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)="",$P(^("IN"),"^",9)="",$P(^("IN"),"^",10)="",$P(^("IN"),"^",12)="",$P(^("IN"),"^",13)="SUP",PSAOK=1 G STATUS
 E  S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",13)=""
 I PSACS D  Q:PSAOUT
 .S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",9)="CS"
 .I $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)="" S PSACS(PSACTRL)="" D MASTER^PSAPROC9 Q:PSAOUT  S:$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)="" PSAOK=0
 .I PSACS=PSALNCNT S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",10)="ALL CS" Q
 .I PSACS'=PSALNCNT S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",10)=""
 I 'PSACS S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",9)="",$P(^("IN"),"^",10)="",$P(^("IN"),"^",12)="" D:$P(^("IN"),"^",7)="" GETLOC^PSAPROC9 Q:PSAOUT  S:$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)="" PSAOK=0
 ;
STATUS I PSALNCNT=PSALINES!(PSALNCNT=PSALLSUP),PSAOK D CHG^PSAPROC6,END^PSAPROC Q
 E  W !!,"** The invoice has not been placed in a Processed status!"
 D END^PSAPROC
 Q
EDIT ;Extended help for 'edit any invoices'
 W !?5,"If you answer Yes, a list of the invoices you were able to process will",!?5,"be displayed. You will be able to select the invoices to be edited then"
 W !?5,"the line item numbers. You will be able to edit the date the invoice was",!?5,"received, drug, quantity, order unit, and dispense units per order unit."
 W !?5,"If the drugs are assigned to a pharmacy location or master vault that",!?5,"maintains reorder levels, you will also be able to edit the reorder and",!?5,"stock levels.",!!?5,"Enter No if the invoice are correct."
 Q
SEL ;Extended help to 'Select invoices to process'
 W !?5,"Enter the number to the left of the invoice data that you want to process."
 Q
SELHELP ;Extended help to 'Select invoices to edit'
 W !?5,"Enter the number to the left of the invoice data that you want to",!?5,"edit. The line items will be displayed for you to select the ones"
 W !?5,"you want to edit. You are given this opportunity to edit the invoice",!?5,"because the automatic display may not catch all the needed corrections."
 W !!?5,"For example, the quantity on the invoice may be 6, but one bottle may",!?5,"be broken. Six is a valid quantity that the automatic display will not"
 W !?5,"realize as being incorrect. By answering Yes, you will be allowed to change",!?5,"the quantity to 5."
 Q
