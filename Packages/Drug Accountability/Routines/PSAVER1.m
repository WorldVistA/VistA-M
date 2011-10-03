PSAVER1 ;BIR/JMB-Verify Invoices - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**33,60,65,71**; 10/24/97;Build 10
 ;This routine allows the user to edit processed invoices by selecting
 ;the invoice's line item number. If there are no errors after editing
 ;the line item is verified.
 ;
 ;References to global ^DIC(51.5 are covered by IA #1931
 ;References to global ^PSDRUG( are covered by IA #2095
 ;
EDIT W @IOF,!?18,"<<< EDIT INVOICES TO BE VERIFIED SCREEN >>>",!!?2,"Choose the invoices from the list you want to edit.",!,PSASLN
 S (PSA,PSACNT,PSASTOP)=0,PSATMP="" F  S PSA=+$O(PSAEDIT(PSA)) Q:'PSA  D  Q:PSASTOP
 .I $Y+5>IOSL D HEADER Q:PSASTOP
 .S PSAIEN=$P(PSAEDIT(PSA),"^"),PSAIEN1=$P(PSAEDIT(PSA),"^",2),PSAORD=$P(^PSD(58.811,PSAIEN,0),"^")
 .S PSAINV=$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^"),PSAINVDT=+$P(^(0),"^",2),PSACNT=PSACNT+1
 .W !?2,PSA_".",?6,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(PSAINVDT)
 K PSASTOP W !,PSASLN
 S DIR(0)="LO^1:"_PSACNT,DIR("A")="Select invoices to edit",DIR("?",1)="Enter the number to the left of the invoice",DIR("?")="data to be verified or a range of numbers.",DIR("??")="^D SELHELP^PSAVER"
 W ! D ^DIR K DIR Q:$G(DIRUT)
 S PSASEL=Y
 ;
SEL ;Select line items to be edit
 K PSAVBKG S PSATMP=""
 F PSAPC=1:1 S PSA=$P(PSASEL,",",PSAPC) Q:'PSA  D CORR Q:PSAOUT
 I $O(PSAVBKG(0)) D
 .;K ZTSAVE S ZTDESC="Drug Acct. - Verify Prime Vendor Invoices",ZTIO="",ZTDTH=$H,ZTRTN="^PSAVER6",ZTSAVE("PSAVBKG(")="" D ^%ZTLOAD
 .D ^PSAVER6
 Q
 ;
HEADER ;Header with screen hold
 S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 S DIR(0)="E" D ^DIR K DIR I $G(DIRUT) S PSASTOP=1 Q
 W @IOF,!?18,"<<< EDIT INVOICES TO BE VERIFIED SCREEN >>>",!!,PSASLN
 Q
 ;
CORR N PSASEL1 S PSASEL1=PSASEL N PSASEL  ;;<*65 RJS
 I $D(^PSD(58.811,"ASTAT","L")) D LCKCHK^PSAVER4
 S PSAIEN=$P(PSAEDIT(PSA),"^"),PSAIEN1=$P(PSAEDIT(PSA),"^",2),PSASEL=PSA ;;*65 RJS>
 S PSAMSG="" D VERLOCK^PSAVER4 ; <== PSA*3*60 (RJS-VMP)
 I $L(PSAMSG) D  Q
 .D HDR W !,?5,PSAMSG,! S DIR(0)="E" D ^DIR K DIR S PSASEL=PSASEL1 K PSALOCK(PSA),PSASEL1
 S PSAIN=^PSD(58.811,PSAIEN,1,PSAIEN1,0),PSAINV=$P(^(0),"^"),PSAINVDT=$P(^(0),"^",2),PSAORD=$P(^PSD(58.811,PSAIEN,0),"^")
 D HDR,RECD^PSAVER2 D:PSAOUT
 .I PSAOUT D VERUNLCK^PSAVER4 W !,"** The invoice's status has not been changed to Verified!"
 I $G(PSAOUT)!$G(DUOUT) S PSAOUT=0,PSASEL=PSASEL1 K PSALOCK(PSA),PSASEL1 Q
 S PSALOC=+$P(PSAIN,"^",5),PSAMV=+$P(PSAIN,"^",12)
 I PSALOC!($P(PSAIN,"^",8)="S")!($P(PSAIN,"^",8)="N") D  Q:PSAOUT
 .D SITES^PSAUTL1 S PSALOCN=$S($G(PSALOC)'>0:"UNKNOWN",1:$P(^PSD(58.8,PSALOC,0),"^"))_PSACOMB
 .W:$L(PSALOCN)>76 !!,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 !!,PSALOCN
 .S DR=4 D PHARM^PSAVER2
 I PSAMV!($P(PSAIN,"^",8)="S")!($P(PSAIN,"^",8)="A") W !!,$P($G(^PSD(58.8,PSAMV,0)),"^") S DR=13 D PHARM^PSAVER2
 I X="" D VERUNLCK^PSAVER4 W !,"** The invoice's status has not been changed to Verified!" S PSAOUT=0,PSASEL=PSASEL1 K PSALOCK(PSA),PSASEL1 Q
 ;
LINES F  W ! S DIC="^PSD(58.811,"_PSAIEN_",1,"_PSAIEN1_",1,",DA(2)=PSAIEN,DA(1)=PSAIEN1,DIC(0)="QAEMZ",DIC("A")="Select Line#: " D ^DIC K DIC D  Q:PSAOUT
 .I $G(DTOUT)!($G(DUOUT))!(Y<1) S PSAOUT=1 Q
 .S PSALINE=+Y,PSALINEN=$P(Y,"^",2)
 .I '$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0)) W !,"Invalid line number." Q
 .S PSADATA=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),PSASUP=0
 .S PSANDC=$P(PSADATA,"^",11),PSAVSN=$P(PSADATA,"^",12),PSALOC=$S(+$P(PSADATA,"^",10):+$P(PSAIN,"^",12),1:+$P(PSAIN,"^",5))
VIEW .D HDR,VERDISP^PSAUTL4 W PSASLN,!
 .W "1. Drug",!,"2. Quantity Received",!,"3. Order Unit",!,"4. Dispense Units per Order Unit",! S PSACHO=4
 .I $P($G(^PSD(58.8,PSALOC,0)),"^",14)  W "5. Stock Level",!,"6. Reorder Level",! S PSACHO=6
 .S DIR(0)="LO^1:"_PSACHO,DIR("A")="Edit fields",DIR("?")="Enter the number(s) of the data to be edited" S DIR("??")="^D DDQOR^PSAVER3"
 .D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 .Q:Y=""  S PSAFLDS=Y,PSASET=0 D HDR,VERDISP^PSAUTL4 W PSASLN
FIELDS .F PSAPCF=1:1 S PSAFLD=$P(PSAFLDS,",",PSAPCF) Q:'PSAFLD!(PSAOUT)  D
 ..I PSAFLD=1 D ASKDRUG^PSAVER2 Q
 ..I PSAFLD=2 D QTY^PSAVER2 Q
 ..I PSAFLD=3 D OU^PSAVER2 Q
 ..I PSAFLD=4,'PSASET S PSA50IEN=PSADRG D DUOU^PSAVER2 Q
 ..I PSAFLD=5 D STOCK^PSAVER2 Q
 ..I PSAFLD=6 D REORDER^PSAVER2
 ;<== PSA*3*60 (RJS-VMP)
 ;Determines if the invoice's status should be changed to verified. If
 ;so, the status is changed and the new drugs to the location is listed.
 W ! S DIR(0)="Y",DIR("A")="Do you want to change the invoice's status to Verified",DIR("?",1)="Enter YES to change the invoice's status to Verified.",DIR("?")="Enter NO to keep the invoice's status as Processed."
 S DIR("??")="^D CHGYN^PSAVER1" D ^DIR K DIR ;D:'Y VERUNLCK^PSAVER4
 I $G(DIRUT)!('Y) D VERUNLCK^PSAVER4 W !,"** The invoice's status has not been changed to Verified!" S (PSAOUT,PSACHG)=0,PSASEL=PSASEL1 K PSALOCK(PSA),PSASEL1 Q
 S PSACHG=Y,PSAVBKG(PSAIEN,PSAIEN1)=""
 ;==> PSA*3*60 (RJS-VMP)
 ;Looks to see if all line items are processed.
PROCESS S (PSACS,PSAERR,PSALINE,PSALINES,PSALNCNT,PSALNSU,PSAOUT,PSASUP)=0
 S PSAIN=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,0)),PSAORD=$P($G(^PSD(58.811,PSAIEN,0)),"^")
 F  S PSALINE=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE)) Q:'PSALINE!(PSAOUT)  D
 .S PSADATA=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),PSALNERR=0,PSALNCNT=PSALNCNT+1
 .D SETLINE^PSAVER3 I PSAOUT D VERUNLCK^PSAVER4 W !,"** The invoice's status has not been changed to Verified!" S (PSAOUT,PSACHG)=0,PSASEL=PSASEL1 K PSALOCK(PSA),PSASEL1 Q
 .S:'+$G(PSALNERR) PSALINES=PSALINES+1 S PSADATA=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0)
 .S:+$P(PSADATA,"^",10) PSACS=PSACS+1
 ;
CHECK I PSALNCNT'=PSALINES D  Q
 .K PSAHOLD(PSALOC,PSAIEN,PSAIEN1) W !!,"** The invoice has not been placed in a Verified status!"
 .D END^PSAPROC D:+$G(PSAERR) PRINT^PSAVER3
 .D VERUNLCK^PSAVER4 S PSASEL=PSASEL1 K PSALOCK(PSA),PSASEL1,PSAVBKG(PSAIEN,PSAIEN1) Q  ;;<*65 RJS>
 I +PSALNCNT,PSALNCNT=PSACS D
 .S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",8)="A" W !,"All drugs on the invoice are marked as a controlled substance."
 .D:'+$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,0)),"^",12) MASTER^PSAVER5
 I PSACS,PSALNCNT'=PSACS S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",8)="S" D:'$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,0)),"^",5) GETLOC^PSAVER5
 I 'PSACS S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",8)="N" D:'$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,0)),"^",5) GETLOC^PSAVER5
 I +PSALNCNT,PSALNCNT=PSALINES D  Q
 .D CHG
 .I PSALNCNT=PSASUP S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",13)=1 Q
 .S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",13)=0
 D END^PSAPROC D:+$G(PSAERR) PRINT^PSAVER3
 Q
 ;<== PSA*3*60 (RJS-VMP)
CHG D STATUS^PSAVER3,NEWDRUG
 W !!,"The invoice status has been changed to Verified!"
 D END^PSAPROC
 Q
 ;
NEWDRUG ;If this invoice will add new drugs to location/vault, store in an
 ;array the location/vault and drug name to be printed later.
 K PSALND,PSALN0,PSALNP,PSALNV
 S PSALINE=0,PSAPHARM=+$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,0)),"^",5),PSAMV=$P($G(^(0)),"^",12)
 Q:'PSALOC
 F  S PSALINE=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE)) Q:'PSALINE  D
 .S PSALN0=+$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0)),"^",2),PSALOC=$S($P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0)),"^",10):PSAMV,1:PSAPHARM)
 .I $O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"D",0)) D
 ..S PSADJ=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"D",0))
 ..Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ,0))
 ..S PSALNP=+$P(PSADJ,"^",2),PSALNV=+$P(PSADJ,"^",6)
 .S PSADD=$S($G(PSALNV):PSALNV,$G(PSALNP):PSALNP,PSALN0:PSALN0,1:0)
 .I PSADD,'$D(^PSD(58.8,PSALOC,1,PSADD,0)) S PSANEWD(PSALOC,$S($P($G(^PSDRUG(PSADD,0)),"^")'="":$P($G(^PSDRUG(PSADD,0)),"^"),1:"UNKNOWN"))=PSADD
 Q
 ;
HDR ;Header for screen that displays invoice data to be edited.
 W @IOF,!?18,"<<< EDIT INVOICES TO BE VERIFIED SCREEN >>>"
 W !!,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(PSAINVDT),!,PSASLN,!
 Q
 ;
CHGYN ;Extended help for 'Do you want to change the invoice's status to Verified'
 W !?5,"Enter YES if the invoice is completely correct. You will not be able",!?5,"to edit it again."
 W !!?5,"Enter NO if you need to edit the invoice again. You can edit it again",!?5,"by selecting the Verify Orders option."
 Q
