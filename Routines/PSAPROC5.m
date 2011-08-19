PSAPROC5 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3**; 10/24/97
 ;This routine allows the user to edit invoices with errors or missing
 ;data.
 ;
MANYUPCS ;List supply synonym data & ask user which on to use
 K PSADIFF,PSASAME
 S (PSACNT,PSAFND,PSAIEN50)=0,PSASUP=$P($P(PSADATA,"^",26),"~"),PSANDC="S"_PSASUP
 F  S PSAIEN50=$O(^PSDRUG("C",PSANDC,PSAIEN50)) Q:'PSAIEN50  S PSASYN=0 D
 .F  S PSASYN=$O(^PSDRUG("C",PSANDC,PSAIEN50,PSASYN)) Q:'PSASYN  D
 ..Q:'$D(^PSDRUG(PSAIEN50,1,PSASYN,0))
 ..;DAVE B (PSA*3*3)
 ..Q:$D(^PSDRUG(PSAIEN50,"I"))
 ..I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^",4)=PSAVSN S PSAFND=PSAFND+1,PSASAME(PSAFND)=PSAIEN50_"^"_PSASYN
 ..I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^",4)'=PSAVSN S PSACNT=PSACNT+1,PSADIFF(PSACNT)=PSAIEN50_"^"_PSASYN
 G:PSAFND SAMEU G:PSACNT DIFFU
 Q
 ;
SAMEU ;If more than one drug with same VSN, assign to correct drug.
 W !!,"There is more than one supply in the DRUG file",!,"with the same UPC and Vendor Stock Number.",!
 S (PSACNT,PSAMENU)=0
 F  S PSACNT=$O(PSASAME(PSACNT)) Q:'PSACNT  D
 .S PSAIEN50=$P(PSASAME(PSACNT),"^"),PSASYN=$P(PSASAME(PSACNT),"^",2),PSANODE=$G(^PSDRUG(PSAIEN50,1,PSASYN,0)),PSAMENU=PSAMENU+1
 .Q:'$D(^PSDRUG(PSAIEN50,1,PSASYN,0))
 .D LIST^PSAPROC4 Q:PSAOUT
 D CHOOSEU Q:PSAOUT
 I PSAPICK=PSAMENU D ASKDRUG^PSANDF G:PSAOUT KILL^PSAPROC4 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)=PSASUP,PSANEXT=1,PSADATA=^(PSALINE) G KILL^PSAPROC4
 I PSAPICK<PSAMENU D
 .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC,$P(^(PSALINE),"^",7)=$P(PSASAME(PSAPICK),"^",2),$P(^(PSALINE),"^",15)=$P(PSASAME(PSAPICK),"^"),$P(^(PSALINE),"^",26)=PSASUP,PSANEXT=1,PSADATA=^(PSALINE)
 .I $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",13)="SUP" S $P(^("IN"),"^",13)="",PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 G KILL^PSAPROC4
 ;
DIFFU ;If more than one supply with different UPC, assign to correct drug.
 W !!,"There is more than one supply in the DRUG file with the same UPC.",!
 S (PSACNT,PSAMENU)=0 F  S PSACNT=$O(PSADIFF(PSACNT)) Q:'PSACNT  D
 .S PSAIEN50=$P(PSADIFF(PSACNT),"^"),PSASYN=$P(PSADIFF(PSACNT),"^",2),PSANODE=$G(^PSDRUG(PSAIEN50,1,PSASYN,0)),PSAMENU=PSAMENU+1
 .Q:'$D(^PSDRUG(PSAIEN50,1,PSASYN,0))
 .D LIST^PSAPROC4 Q:PSAOUT
 D CHOOSEU Q:PSAOUT
 I PSAPICK=PSAMENU D ASKDRUG^PSANDF G:PSAOUT KILL^PSAPROC4 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)=PSASUP,PSANEXT=1,PSADATA=^(PSALINE) G KILL^PSAPROC4
 I PSAPICK<PSAMENU D
 .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC,$P(^(PSALINE),"^",7)=$P(PSADIFF(PSAPICK),"^",2),$P(^(PSALINE),"^",15)=$P(PSADIFF(PSAPICK),"^"),$P(^(PSALINE),"^",26)=PSASUP,PSANEXT=1,PSADATA=^(PSALINE)
 .I $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",13)="SUP" S $P(^("IN"),"^",13)="",PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 G KILL^PSAPROC4
 ;
CHOOSEU S PSAMENU=PSAMENU+1
 W !?1,PSAMENU_".",?4,"Select another item."
 W ! S DIR(0)="NO^1:"_PSAMENU,DIR("A")="Select the invoiced item",DIR("?")="Select the item from the list for which you were invoiced.",DIR("??")="^D UPCHELP^PSAPROC5"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S PSAPICK=+Y
 Q
 ;
NDCDIFF ;If New NDC is correct, remove "~" piece with questionable NDC in ^XTMP.
 ;If Old NDC is correct, remove "~" piece with questionable NDC & set
 ;old NDC in NDC piece in ^XTMP.
 W !!,"There is a change in Vendor Stock Number's NDC."
 W !,"New NDC: "_PSANDC_"  "
 W !,"Old NDC: "_$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5),"~",3),!
 S DIR(0)="Y",DIR("A")="Is the new NDC correct",DIR("B")="Y",DIR("?",1)="Enter Yes if the line item's NDC is correct.",DIR("?")="Enter No is the old NDC is correct."
 S DIR("??")="^D NEWOLDN^PSAPROC5" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 I +Y S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=PSAVSN_"~~~1",$P(^(PSALINE),"^",4)=PSANDC,PSADATA=^(PSALINE),PSANEXT=1 Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5),"~",3),$P(^(PSALINE),"^",5)=PSAVSN,PSANEXT=1,PSADATA=^(PSALINE)
 Q
 ;
SUPDIFF ;If New UPC is correct, remove "~" piece with questionable UPC in ^XTMP.
 ;If Old UPC is correct, remove "~" piece with questionable UPC & set old UPC in VSN piece in ^XTMP.
 W !!,"There is a change in item's Universal Product Code (UPC)."
 W !,"New UPC: "_PSAUPC
 W !,"Old UPC: "_$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26),"~",3),!
 S DIR(0)="Y",DIR("A")="Is the new UPC correct",DIR("B")="Y",DIR("?",1)="Enter Yes if the line item's Universal Product Code is correct.",DIR("?")="Enter No is the old Universal Product Code is correct."
 S DIR("??")="^D NEWUPC^PSAPROC5" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S PSANDC="S"_$P($P(PSADATA,"^",26),"~")
 I +Y S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC,$P(^(PSALINE),"^",26)=PSAUPC,PSADATA=^(PSALINE),PSANEXT=1 Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)=$P($P(^(PSALINE),"^",26),"~",3),$P(^(PSALINE),"^",4)=PSANDC,PSADATA=^(PSALINE),PSANEXT=1
 Q
 ;
VSNDIFF ;If New VSN is correct, remove "~" piece with questionable VSN in ^XTMP.
 ;If Old VSN is correct, remove "~" piece with questionable VSN & set old VSN in VSN piece in ^XTMP.
 W !!,"There is a change in the NDC's Vendor Stock Number (VSN)."
 W !,"New VSN: "_PSAVSN_"  "
 W !,"Old VSN: "_$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4),"~",3),!
 S DIR(0)="Y",DIR("A")="Is the new VSN correct",DIR("B")="Y",DIR("?",1)="Enter Yes if the line item's Vendor Stock Number is correct.",DIR("?")="Enter No is the old Vendor Stock Number is correct."
 S DIR("??")="^D NEWOLD^PSAPROC5" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 I +Y S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC_"~~~1",$P(^(PSALINE),"^",5)=PSAVSN,PSADATA=^(PSALINE),PSANEXT=1 Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4),"~",3),$P(^(PSALINE),"^",4)=PSANDC,PSADATA=^(PSALINE),PSANEXT=1
 Q
 ;
NEWOLD ;Extended help to 'Is new VSN correct'
 W !?5,"Enter Yes to add another synonym for the NDC with the new VSN.",!?5,"Enter No to discard the new VSN."
 Q
NEWOLDN ;Extended help to 'Is new NDC correct'
 W !?5,"Enter Yes to add another synonym for the NDC with the new NDC.",!?5,"Enter No to discard the new NDC."
 Q
NEWUPC ;Extended help to 'Is new UPC correct'
 W !?5,"Enter Yes to add another synonym for the NDC with the new UPC.",!?5,"Enter No to discard the new UPC."
 Q
UPCHELP ;Extended help for selecting invoiced supply
 W !?5,"Enter the number of the invoiced item. If you select an item from the",!?5,"list, the invoice data will be added to that item. If you select to"
 W !?5,"add a new entry in the DRUG file for the invoiced item, a new",!?5,"synonym for the item will be added to the DRUG file."
 Q
