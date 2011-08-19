PSAPROC6 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;10/7/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,21,34,50**; 10/24/97
 ;
 ;This routine allows the user to edit invoices by selecting the
 ;invoice's line item number.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;
SEL ;Loops thru selected invoices
 F PSAPC=1:1 S PSAMENU=$P(PSASEL,",",PSAPC) Q:'PSAMENU!(PSAOUT)  D CORR Q:PSAOUT  D CHECK
 Q  ;; <= *50  TO QUIT PROPERLY
 ;
CHECK ;Looks to see if all line items are processed
 S (PSACS,PSAERR,PSALINE,PSALINES,PSALNCNT,PSALNSU,PSAOUT,PSASUP)=0
 F  S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:'PSALINE  D
 .S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE),PSALNCNT=PSALNCNT+1
 .S:$P(PSADATA,"^",18)="P"!($P(PSADATA,"^",18)="OK") PSALINES=PSALINES+1
 .S:$P(PSADATA,"^",19)="CS" PSACS=PSACS+1
 I PSACS,PSALNCNT=PSACS D
 .S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",10)="ALL CS",$P(^("IN"),"^",9)="CS" W !,"All drugs on the invoice are marked as a controlled substance."
 .D:$P($G(^PSD(58.8,+$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12),0)),"^",2)'="M" MASTER^PSAPROC9
 E  S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",10)=""
 I PSACS S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",9)="CS"
 I +PSALNCNT,PSALNCNT=PSALINES D CHG D END^PSAPROC Q
 E  W !!,"** The invoice has not been placed in a Processed status!"
 D END^PSAPROC
 Q
 ;
CHG ;Asks if invoice's status should be changed to verified. If so, status
 ;is changed & new drugs to location is listed.
 W ! S DIR(0)="Y",DIR("A")="Do you want to change the invoice's status to Processed",DIR("?",1)="Enter YES to change the invoice's status to Processed.",DIR("?")="Enter NO to keep the invoice's status as Uploaded."
 S DIR("??")="^D CHGYN^PSAPROC6" D ^DIR K DIR
 I 'Y!($G(DIRUT)) S PSACHG=0,$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",8)="" W !!,"** The invoice's status has not been changed to Processed." Q
 S PSACHG=+Y,$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",8)="P"
 K PSAERR(PSAMENU) ;*50 rid select (1-0)
 W !!,"The invoice status has been changed to Processed!"
 ;
 ;PSA*3*21 (1/3/01 - file data in 58.811)
 D ^PSAPROC7
 ;
 Q
 ;
CORR S PSACTRL=$P(PSAERR(PSAMENU),"^",3),(PSALNCNT,PSALINES,PSACS)=0
 S PSAIN=^XTMP("PSAPV",PSACTRL,"IN"),PSARECD=$S(+$P(PSAIN,"^",11):+$P(PSAIN,"^",11),+$P(PSAIN,"^",6):+$P(PSAIN,"^",6),1:""),PSALOC=+$P(PSAIN,"^",7),PSAMV=+$P(PSAIN,"^",12)
 D HDR,RECD^PSAPROC3 Q:PSAOUT
LOC I $P(PSAIN,"^",9)="CS" W !!,"MASTER VAULT: "_$P($G(^PSD(58.8,PSAMV,0)),"^") D MV Q:PSAOUT
 I $P(PSAIN,"^",10)="" D  Q:PSAOUT
 .;OIFO BAY PINES;TEH;PATCH PSA*3.0*34
 .D SITES^PSAUTL1 S PSALOCN=$S($D(^PSD(58.8,PSALOC,0)):$P($G(^PSD(58.8,PSALOC,0)),"^"),1:"UNKNOWN")_PSACOMB
 .W !!,"PHARMACY LOCATION: "
 .W:$L(PSALOCN)>76 !,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 !,PSALOCN D PHARM
LINES S PSADONE=0 F  W !!,"Line Item Numbers: " D  Q:PSAOUT!(PSADONE)
 .S PSALINE=0 S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:'PSALINE  W ?19,PSALINE
 .F  S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:'PSALINE  D
 ..I $X+$L(PSALINE)+2>79 W !,?19,PSALINE Q
 ..W ","_PSALINE
 .W ! S DIR(0)="LO",DIR("A")="Select Line Item Number",DIR("?")="Enter the line numbers to be edited",DIR("??")="^D LNHELP^PSAPROC6"
 .D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 .I X="" S PSADONE=1 Q
 .S PSALINE=X
 .I '$D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) W !,"Invalid line number." Q
 .S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 .S PSAIEN=$S(+$P(PSADATA,"^",15):+$P(PSADATA,"^",15),1:+$P(PSADATA,"^",6))
 .S PSANDC=$P($P(PSADATA,"^",4),"~"),PSAVSN=$P($P(PSADATA,"^",5),"~"),PSASUB=+$P(PSADATA,"^",7),PSASUP=0
 .S PSALOC=$S($P(PSADATA,"^",19)="CS":+$P(PSAIN,"^",12),1:+$P(PSAIN,"^",7))
 .D EDITDISP^PSAUTL1 W !,PSASLN,!
 .D EDITITEM ;*50 ready for patch *54 make an entry point
 Q
EDITITEM        ;perform edit and checks on an item *50 to be ready for *54
 D
 .W "1. Drug",!,"2. Quantity Received",!,"3. Order Unit",!,"4. Dispense Units per Order Unit" S PSACHO=4
 .I +$P($G(^PSD(58.8,PSALOC,0)),"^",14) W !,"5. Stock Level",!,"6. Reorder Level" S PSACHO=6
 .W ! S DIR(0)="LO^1:"_PSACHO,DIR("A")="Edit fields",DIR("?")="Enter the number(s) of the data to be edited",DIR("??")="^D DQOR^PSAPROC6"
 .D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 .Q:Y=""  S PSAFLDS=Y,PSADU=0 D EDITDISP^PSAUTL1 W !,PSASLN
FIELDS .F PSAPCF=1:1 S PSAFLD=$P(PSAFLDS,",",PSAPCF) Q:'PSAFLD!(PSAOUT)  D
 ..I PSAFLD=1 D ASKDRUG^PSANDF Q
 ..I PSAFLD=2 D QTY^PSAPROC3 Q
 ..I PSAFLD=3 D GETOU^PSAPROC3 Q
 ..I PSAFLD=4,PSAIEN D:$P($G(^PSDRUG(PSAIEN,660)),"^",8)="" DU^PSAPROC8 D DUOU^PSAPROC3 Q
 ..I PSAFLD=5 D STOCK^PSAPROC8 Q
 ..I PSAFLD=6 D REORDER^PSAPROC8
 .D:'PSAOUT PROCESS
 Q
 ;
PROCESS ;Checks for & prompts for missing data.
 Q:$D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP"))
 S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 S PSAIEN=$S(+$P(PSADATA,"^",15):+$P(PSADATA,"^",15),+$P(PSADATA,"^",6):+$P(PSADATA,"^",6),1:0),PSASUB=+$P(PSADATA,"^",7)
 ;If no order unit, store it.
 I '+$P($P(PSADATA,"^",2),"~",2),'$P(PSADATA,"^",12) D  Q:PSAOUT
 .I PSAIEN,PSASUB,'$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",5) D GETOU^PSAPROC3 Q
 .I PSAIEN,'PSASUB D GETOU^PSAPROC3
 ;If synonym & doesn't have disp units/order unit, store it 50.
 I PSAIEN,PSASUB,'+$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",7),'+$P(PSADATA,"^",20) S PSADU=0 D DUOU^PSAPROC8 Q:PSAOUT
 ;If no synonym & disp units/order unit, store it XTMP.
 I PSAIEN,'PSASUB,'$P(PSADATA,"^",20) D DUOU^PSAPROC3 Q:PSAOUT
 I '+$P(PSADATA,"^",3) D PRICE^PSAPROC3 Q:PSAOUT
 ;If not CS & maintains stock, prompt for stock & reorder levels
 I $P(PSADATA,"^",19)'="CS",+$P(PSAIN,"^",7),+$P($G(^PSD(58.8,+$P(PSAIN,"^",7),0)),"^",14) D
 .I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",7),1,PSAIEN,0)),"^",3),'+$P(PSADATA,"^",27) S PSALOC=$P(PSAIN,"^",7) D STOCK^PSAPROC8 Q:PSAOUT
 .I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",7),1,PSAIEN,0)),"^",5),'+$P(PSADATA,"^",21) S PSALOC=$P(PSAIN,"^",7) D REORDER^PSAPROC8 Q:PSAOUT
 ;If CS & maintains stock, prompt for stock & reorder level
 I $P(PSADATA,"^",19)="CS",+$P(PSAIN,"^",12),+$P($G(^PSD(58.8,+$P(PSAIN,"^",12),0)),"^",14) D
 .I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",12),1,PSAIEN,0)),"^",3),'+$P(PSADATA,"^",27) S PSALOC=$P(PSAIN,"^",12) D STOCK^PSAPROC8 Q:PSAOUT
 .I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",12),1,PSAIEN,0)),"^",5),'+$P(PSADATA,"^",21) S PSALOC=$P(PSAIN,"^",12) D REORDER^PSAPROC8 Q:PSAOUT
 Q:PSAOUT  D CHECK^PSANDF Q:PSAOUT  D SETLINE^PSAPROC3
 Q
 ;
MV ;Assigns master vault
 S DIC("A")="Select Master Vault: ",DIC="^PSD(58.8,",DIC(0)="QAEMZ" S:+PSAMV DIC("B")=$P($G(^PSD(58.8,+PSAMV,0)),"^")
 S DIC("S")="I $D(^PSD(58.8,""ADISP"",""M"",+Y)),'+$G(^PSD(58.8,+Y,""I""))!(+$G(^PSD(58.8,+Y,""I""))&(+$G(^PSD(58.8,+Y,""I""))'<DT))"
 D ^DIC K DIC I $G(DTOUT)!($G(DUOUT))!(Y<0) S PSAOUT=1 Q
 S PSAMV=+Y,$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)=+Y,PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 Q
 ;
PHARM ;Assigns pharmacy location
 ;S DIC("A")="Select Pharmacy Location: ",DIC="^PSD(58.8,",DIC(0)="QAEMZ" S:+PSALOC DIC("B")=$P($G(^PSD(58.8,+PSALOC,0)),"^")
 ;S DIC("S")="I $D(^PSD(58.8,""ADISP"",""P"",+Y)),'$G(^PSD(58.8,+Y,""I""))!(+$G(^PSD(58.8,+Y,""I""))&(+$G(^PSD(58.8,+Y,""I""))'<DT))"
 ;D ^DIC K DIC I $G(DTOUT)!($G(DUOUT))!(Y<0) S PSAOUT=1 Q
 ;S PSALOC=+Y,$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)=+Y,PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 ;Dave Blocker  (PSA*3*21)
 D ^PSAUTL5 Q:$G(PSALOC)'>0  S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)=+PSALOC,PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 ;Eop
 Q
 ;
SUPPLY ;Asks if all items are supply items. If so, invoice is deleted from
 ;^XTMP global. If not, invoice is added to list of invoices to be edited.
 W ! S DIR(0)="Y",DIR("A")="Are all the items on the invoice supply items",DIR("B")="N"
 S DIR("?",1)="Enter YES if all line items are not drugs in the DRUG file.",DIR("?")="Enter NO if there is at least one line item that is in the DRUG file."
 S DIR("??")="^D ALLSUP^PSAPROC6" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 G:'Y NO
 W ! S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="Y",DIR("?",1)="Enter YES if all the line items on the invoice are supply items.",DIR("?")="Enter NO if there is at least one item on the invoice that is not a supply."
 S DIR("??")="^D ALLSUP^PSAPROC6" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
NO I 'Y S PSACNTER=PSACNTER+1,PSAERR(PSACNTER)=PSAOK(PSA) K PSAOK(PSA) Q
 K PSAOK(PSA) S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",8)="P",PSASUP=1,PSALINE=0
 F  S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:'PSALINE  D
 .S ^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP")=DUZ_"^"_DT_"^"_"SUPPLY ITEM",$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="P"
 Q
 ;
HDR ;Screen header
 W @IOF,!?26,"<<< EDIT INVOICE SCREEN >>>",!,"Order#: "_$P(PSAIN,"^",4)_"  Invoice#: "_$P(PSAIN,"^",2)_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN),!,PSASLN
 Q
 ;
CHGYN ;Extended help - 'Do you want to change the invoice's status to Processed'
 W !?5,"Enter YES if the invoice is completely correct. You will not be able",!?5,"to edit it again."
 W !!?5,"Enter NO if you need to edit the invoice again. You can edit it again",!?5,"by selecting the Process Orders option."
 Q
DQOR ;Extended help - 'Edit field'
 W !?5,"Enter the number or range of numbers of the field you want to edit."
 Q
LNHELP ;Extended help - 'Line Number"
 W !?5,"Enter the number of the item on the invoice you want to edit. You can",!?5,"enter a line item number then edit that line item. The ""Line Number""",!?5,"prompt will be displayed again. You can keep entering and editing line"
 W !?5,"items until you press the Return key at the ""Line Number"" prompt."
 Q
ALLSUP ;Extended help - "Are all the items on the invoice supply items" &
 ;"Are you sure?"
 W !!?5,"Enter YES if none of the line items on the invoice are",!?5,"in the DRUG file and will never be in the DRUG file.",!!?5,"Enter NO if there is at least one line item on the",!?5,"invoice that is in the DRUG file."
 Q
