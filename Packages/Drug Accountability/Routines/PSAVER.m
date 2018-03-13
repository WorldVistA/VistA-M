PSAVER ;BIR/JMB-Verify Invoices ;9/6/97
 ;;3.0;DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**60,65,71,78**;10/24/97;Build 4
 ;This routine allows the user to verify processed invoices. The entire
 ;invoice may be verified with/without editing. After verification, the
 ;pharmacy location or master vault balances are incremented during a
 ;background job (PSAVER5).
 ;
 I '$D(^XUSEC("PSA ORDERS",DUZ)) W !,"You do not hold the key to enter the option." Q
 I $D(^PSD(58.811,"ASTAT","L")) D LCKCHK^PSAVER4
 I '$D(^PSD(58.811,"ASTAT","P")) W !!,"There are no invoices that need to be verified." H 1 Q
 ;
 ;Creates a list of invoices that can be verified by the user. If the
 ;invoice contains at least one item marked as a controlled substance,
 ;the user must have the pharmacist key before it can be verified.
 S (PSACNT,PSAIEN,PSASUP)=0
 F  S PSAIEN=+$O(^PSD(58.811,"ASTAT","P",PSAIEN)) Q:'PSAIEN  D
 .Q:'$D(^PSD(58.811,PSAIEN,0))
 .S PSAIEN1=0 F  S PSAIEN1=+$O(^PSD(58.811,"ASTAT","P",PSAIEN,PSAIEN1)) Q:'PSAIEN1  D
 ..Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,0))
 ..I $P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",10)'=DUZ,$P(^(0),"^",8)="N"!(($P(^(0),"^",8)="S"!($P(^(0),"^",8)="A"))&($D(^XUSEC("PSJ RPHARM",DUZ)))) S PSACNT=PSACNT+1,PSAVER(PSACNT)=PSAIEN_"^"_PSAIEN1
 I 'PSACNT D  H 1 G EXIT
 .W !!,"There is at least one invoice that needs to be verified. However, invoices",!,"cannot be verified by the same person who processed them and a pharmacist",!,"must verify invoices that contain a drug marked as a controlled substance."
 .W !!,"There are no invoices you can verify because the invoice(s) meet one of the",!,"above conditions."
 ;
ESIG D SIG^XUSESIG G:X1="" EXIT S PSAOUT=0
 ;
PRINT ;Asks & prints all invoices the user can verify.
 W ! S DIR(0)="Y",DIR("B")="N",DIR("A")="Print processed invoices",DIR("?",1)="Enter YES to print all invoices you can verify then begin verification.",DIR("?")="Enter NO to bypass printing the invoices and begin verification."
 S DIR("??")="^D PRINTYN^PSAVER"
 D ^DIR K DIR G:$G(DIRUT) EXIT G:'Y ENTIRE
 W ! S %ZIS="Q" D ^%ZIS G:POP ENTIRE
 I $D(IO("Q")) D  G ENTIRE
 .K ZTSAVE
 .S ZTDESC="Drug Acct. - Print Prime Vendor Invoices",ZTDTH=$H,ZTRTN="PRTINV^PSAVER",ZTSAVE("PSAVER(")="" D ^%ZTLOAD
 D PRTINV
 ;
ENTIRE ;Displays a list of all invoices the user can select to be verified.
 S PSASLN="",$P(PSASLN,"-",80)="",PSADLN="",$P(PSADLN,"=",80)=""
 W @IOF,!?21,"<<< VERIFY ENTIRE INVOICE SCREEN >>>"
 W !!?2,"If there are no corrections, you can change the invoices' status",!?2,"to ""Verified"" by selecting them from the list. If you do have"
 W !?2,"corrections, press the return key then a second list will be",!?2,"displayed. You will be able to choose the invoices from that list",!?2,"and enter corrections.",!!?2,"Choose the invoices from the list you want to verify.",!,PSADLN
 S (PSA,PSACNT,PSASTOP)=0
 F  S PSA=+$O(PSAVER(PSA)) Q:'PSA  D  Q:PSASTOP
 .I $Y+5>IOSL D HDR Q:PSASTOP
 .S PSAIEN=$P(PSAVER(PSA),"^"),PSAIEN1=$P(PSAVER(PSA),"^",2),PSAORD=$P(^PSD(58.811,PSAIEN,0),"^"),PSAINV=$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^"),PSAINVDT=+$P(^(0),"^",2),PSACNT=PSACNT+1
 .W !?(3-$L(PSA)),PSA_".  Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(PSAINVDT)
 K PSASTOP W !,PSADLN
 S DIR(0)="LO^1:"_PSACNT,DIR("A")="Select invoices to verify",DIR("?",1)="Enter the number to the left of the invoice",DIR("?")="data to be verified or a range of numbers.",DIR("??")="^D SEL^PSAVER"
 W ! D ^DIR K DIR G:$G(DTOUT)!($G(DUOUT)) EXIT
 I Y="",$D(^PSD(58.811,"ASTAT","L")) D LCKCHK^PSAVER4,LOAD G EDIT
 I Y="",'$D(^PSD(58.811,"ASTAT","L")) D LOAD G EDIT
 S PSASEL=Y
 ;
OKAY ;Verifies correct invoices were selected.
 W @IOF,!?21,"<<< VERIFY ENTIRE INVOICE SCREEN >>>",!,PSADLN,!
 S PSACNT=0,PSATMP="" F PSAPC=1:1 S PSA=+$P(PSASEL,",",PSAPC) Q:'PSA  D
 .S PSAIEN=$P(PSAVER(PSA),"^"),PSAIEN1=$P(PSAVER(PSA),"^",2)
 .Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,0))
 .S PSAIN=^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 .S PSAORD=$P(^PSD(58.811,PSAIEN,0),"^"),PSAINV=$P(PSAIN,"^"),PSAINVDT=+$P(PSAIN,"^",2),PSACNT=PSACNT+1
 .W !?(3-$L(PSACNT)),PSACNT_".  Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(PSAINVDT)
 .I +$P(PSAIN,"^",5) D
 ..S PSALOC=+$P(PSAIN,"^",5) D SITES^PSAUTL1 S PSALOCN=$P(^PSD(58.8,PSALOC,0),"^")_PSACOMB
 ..W:$L(PSALOCN)>76 !?6,$P(PSALOCN,"(IP)",1)_"(IP)",!?23,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 !?6,PSALOCN
 .I +$P(PSAIN,"^",12) W !?6,"MASTER VAULT: "_$P(^PSD(58.8,+$P(PSAIN,"^",12),0),"^")
 .W !
 .S PSAMSG="" D VERLOCK^PSAVER4 ; <== PSA*3*60 (RJS-VMP)
 .W:$L(PSAMSG) ?5,PSAMSG,!
 I PSASEL'=PSATMP S PSASEL=PSATMP K PSATMP
 I PSASEL="" S DIR(0)="E" D ^DIR G:$G(DIRUT) EXIT G ENTIRE
 S DIR(0)="Y",DIR("B")="N",DIR("A")="Are you sure "_$S(PSACNT=1:"this invoice's",1:"these invoices'")_" status should be changed to Verified"
 S DIR("?",1)="Enter YES if the list contains invoices with no corrections.",DIR("?",2)="Enter NO if the list contains at least one invoice you do not",DIR("?")="want to verify.",DIR("??")="^D VERIFY^PSAVER"
 D ^DIR K DIR D:'Y VERUNLCK^PSAVER4 G:$G(DIRUT) EXIT G:'Y ENTIRE ; <== PSA*3*60 (RJS-VMP)
 ;
 ;Send entire invoices to be verified in background, delete these
 ;invoices from the list, then create a new list of remaining invoices
 ;to be verified.
BKGJOB K PSAVBKG W ! F PSAPC=1:1 S PSA=+$P(PSASEL,",",PSAPC) Q:'PSA!(PSAOUT)  D
 .S PSAIEN=$P(PSAVER(PSA),"^"),PSAIEN1=$P(PSAVER(PSA),"^",2),PSASUP=0
 .Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,0))!('$D(^PSD(58.811,PSAIEN,0)))
 .S (PSACS,PSAERR,PSALINE,PSALNCNT,PSALNERR,PSALNSU)=0
 .S PSAIN=^PSD(58.811,PSAIEN,1,PSAIEN1,0),PSAINV=$P(PSAIN,"^"),PSAORD=$P(^PSD(58.811,PSAIEN,0),"^")
 .F  S PSALINE=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE)) Q:'PSALINE!(PSAOUT)  D
 ..Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0))
 ..S PSADATA=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0),PSALNCNT=PSALNCNT+1
 ..S PSALOC=$S(+$P(PSADATA,"^",10):$P(PSAIN,"^",12),1:$P(PSAIN,"^",5))
 ..W "." D SETLINE^PSAVER3
 .Q:PSAOUT
 .I '$O(PSANOVER(PSAIEN,PSAIEN1,0)) D  Q
 ..S PSAVBKG(PSAIEN,PSAIEN1)="" K PSAVER(PSA) D STATUS^PSAVER3
 ..I '+$P(^PSD(58.811,PSAIEN,1,PSAIEN1,0),"^",13),$P($G(^PSD(58.8,+$P(PSAIN,"^",5),0)),"^",14)!($P($G(^PSD(58.8,+$P(PSAIN,"^",12),0)),"^",14)) D NEWDRUG^PSAVER1 I 1 ;*50
 ..W !,"   Order# "_PSAORD_" Invoice# "_PSAINV_"'s status has been changed to Verified!"
 .H 1 I $O(PSANOVER(PSAIEN,PSAIEN1,0)) D
 ..W !,"** Order# "_PSAORD_" Invoice# "_PSAINV_"'s status has not been changed to Verified."
 ..S PSAERR=0,PSAVER(PSA)=PSAIEN_"^"_PSAIEN1
 ..D PRINT^PSAVER3
 ..N PSATMP S PSATMP=PSASEL ;;<*65 RJS
 ..N PSASEL S PSASEL=PSA
 ..D VERUNLCK^PSAVER4  ;;*65 RJS>
 ..S PSAOUT=0
 ;
 ;If the invoices selected are error free, send them to the background
 ;job to complete the invoice and increment inventory.
 I $D(^PSD(58.811,"ASTAT","L")) D LCKCHK^PSAVER4
 D LOAD
 I $O(PSAVBKG(0)) D
 . K ZTSAVE S ZTDESC="Drug Acct. - Verify Prime Vendor Invoices",ZTIO="",ZTDTH=$H,ZTRTN="^PSAVER6",ZTSAVE("PSASEL")="",ZTSAVE("PSAVBKG(")="" D ^%ZTLOAD Q:$G(POP)
 ;D ^PSAVER6
 K PSAVBKG G:'$O(PSAEDIT(0)) EXIT
EDIT S PSARTN1=0
 D EDIT^PSAVER1
 ;
EXIT I $O(PSANEWD(0)) D ^PSAVER4 S PSARTN1=0
 I $G(PSARTN1) D END^PSAPROC
 K %ZIS,DA,DD,DIC,DIE,DIK,DIR,DIRUT,DO,DR,DTOUT,DUOUT,PSA,PSA10,PSAGAIN,PSA50IEN,PSAA,PSABEFOR,PSACHG,PSACHO,PSACNT,PSACOMB,PSACS,PSACSLN,PSACTRL
 K PSADATA,PSADD,PSADJ,PSADJD,PSADJFLD,PSADJN,PSADJO,PSADJOP,PSADJOV,PSADJP,PSADJPP,PSADJPV,PSADJQ,PSADJQP,PSADJQV,PSADJSUP,PSADLN,PSADRG
 K PSADRGN,PSADUOU,PSAEDIT,PSAERR,PSAFLD,PSAFLDS,PSAHOLD,PSAIEN,PSAIEN1,PSAIN,PSAINV,PSAINVDT,PSAISIT,PSAISITN,PSAKK,PSAL,PSALEN,PSALINE,PSALINEN
 K PSALINES,PSALN,PSALN0,PSALNCNT,PSALND,PSALNERR,PSALNP,PSALNSU,PSALNV,PSALOAD,PSALOC,PSALOCA,PSALOCN,PSAMENU,PSAMV,PSAMVA,PSAMVIEN,PSAMVN,PSAN10,PSANAME,PSANDC,PSANEW,PSANEWD
 K PSANO,PSANODE,PSANOVER,PSANUM,PSAONE,PSAONEMV,PSAORD,PSAORDU,PSAPHARM,PSAPRICE,PSAOSIT,PSAOSITN,PSAOU,PSAOUT,PSAPC,PSAPCF,PSAPCL,PSAPG,PSAPRINT,PSAQTY,PSALOCK,PSAMSG
 K PSAREA,PSAREC,PSARECD,PSAREORD,PSASAVE,PSASEL,PSASET,PSASLN,PSASTOCK,PSASUB,PSASUP,PSASUPP,PSATAB,PSATEMP,PSAUPC,PSAVAULT,PSAVBKG,PSAVER,PSAVSN,PSAOU,PSATMP,PSALCK
 K PSASS,X,X1,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,PSARTN1
 Q
 ;
HDR ;Header with screen hold
 S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 S DIR(0)="E" D ^DIR K DIR I $G(DIRUT) S PSASTOP=1 Q
 W @IOF,!?21,"<<< VERIFY ENTIRE INVOICE SCREEN >>>",!!,PSADLN
 Q
LOAD ;Loads invoices to be edited into an array
 K PSAEDIT S (PSALOAD,PSACNT)=0
 F  S PSALOAD=+$O(PSAVER(PSALOAD)) Q:'PSALOAD  S PSACNT=PSACNT+1,PSAEDIT(PSACNT)=PSAVER(PSALOAD)
 K PSAVER
 Q
 ;
PRTINV ;Sends invoices to printer
 S (PSA,PSAOUT)=0 F  S PSA=+$O(PSAVER(PSA)) Q:'PSA!(PSAOUT)  D
 .S PSAORD=$P(PSAVER(PSA),"^"),PSAINV=$P(PSAVER(PSA),"^",2) D ^PSAORDP1
 D ^%ZISC
 Q
 ;
SEL ;Extended help to 'Select invoices'
 W !?5,"Enter the number to the left of the invoice data that you want to verify.",!?5,"The invoices' statuses will be changed to Verified."
 Q
SELHELP ;Extended help for 'Select invoices to verify'
 W !?5,"Enter the number to the left of the invoice data you want to verify.",!?5,"The line items will be displayed for you to select the ones you want"
 W !?5,"to correct."
 Q
PRINTYN ;Extended help for 'Print invoices?'
 W !?5,"Enter YES to print all of the processed invoices you can verify.",!?5,"Enter NO to bypass printing the invoices and continue with verification."
 Q
VERIFY ;Extended help for 'Are you sure...'
 W !!?5,"Enter YES if the list contains invoices to be verified.",!!?5,"Enter NO if the list contains at least one invoice that should not be"
 W !?5,"verified. You will be returned to the original list so you can choose",!?5,"the invoices to be verified again."
 Q
