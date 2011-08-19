FBCHVP ;AISC/CMR-VOID & CANCEL VOIDED INPATIENT PAYMENT ;3/3/93
 ;;3.5;FEE BASIS;**55,69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Variable 'FBVOID' is set if cancelling a voided payment.
 ;Variable 'FBTYPE' is set to 6 for CH or 7 for CNH.
 D DT^DICRW
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"Sorry, you must be a supervisor to use this option.",! Q
RDP ;Get veteran if they have an inpatient invoice (DFN).
 K ^TMP($J) W !! S DIC=161,DIC(0)="AEMZ",DIC("S")="I $D(^FBAAI(""AK"",+Y))" D ^DIC K DIC G Q:X=""!($D(DTOUT))!($D(DUOUT)),RDP:Y<0 S DFN=+Y
RDV ;Get vendor if an inpatient provider for this patient (FBV).
 W !! S DIC=161.2,DIC(0)="AEMZ",DIC("S")="I $D(^FBAAI(""AK"",DFN,+Y))" D ^DIC K DIC G Q:X=""!($D(DTOUT))!($D(DUOUT)),RDV:Y<0 S FBV=+Y
 D EN1
 I FBCTR=0 W !!?12,*7,"Vendor has no",$S($D(FBVOID):" VOIDED",1:"")," finalized payments ",$S('$D(FBVOID):"to VOID",1:""),!?12,"for this patient under the ",$S(FBTYPE=6:"CIVIL HOSPITAL",1:"COMMUNITY NURSING HOME")," program." G RDV
 W !!,"Which payment item(s) would you like to ",$S($D(FBVOID):"Cancel the void on",1:"Void")," ? " S DIR(0)="L^1:"_FBCTR D ^DIR G RDV:$D(DIRUT) S FBX=Y W @IOF D HED
 F A=1:1:FBCTR S X=$P(FBX,",",A) Q:X=""  S FBI=+FBI(X),FBINV=^TMP($J,"FBCHVP",FBI),FBVD=$P(FBINV,"^",14) W ! D WRT1 S ^TMP($J,"FBCHVP","VOID",FBI)=""
 W ! S DIR(0)="Y",DIR("A")="Are you sure you want to "_$S($D(FBVOID):"Cancel the void on",1:"Void")_" the payment(s)",DIR("B")="No" D ^DIR K DIR G RDP:$D(DIRUT)!'Y
 S FBI=0 F  S FBI=$O(^TMP($J,"FBCHVP","VOID",FBI)) Q:FBI'>0  D SETR,CONF W !,?5,".... Done.",!
Q K DFN,FBV,FBI,FBTYPE,FBVOID,FBCTR,FBAMTC,FBAMTP,FBBAT,FBDRG,FBFDT,FBINV,FBNUM,FBREIM,FBTDT,FBVD,Q,FBX,VP,^TMP($J,"FBCHVP"),Y,DIE,DR,FBVR,DA
 Q
EN1 ;Find finalized payments that match FBTYPE and store in ^TMP.
 S (FBI,FBCTR)=0,Q="-",$P(Q,"-",80)="-"
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
 F  S FBI=$O(^FBAAI("AK",DFN,FBV,FBI)) Q:FBI'>0  I $D(^FBAAI(FBI,0)),'$D(^("FBREJ")) S FBINV=^(0),FBVD=$P(FBINV,"^",14) I $P(FBINV,"^",16)'=""&($P(FBINV,"^",12)=FBTYPE)&($S($D(FBVOID):(FBVD="VP"),1:(FBVD=""))) D WRT
 Q
WRT N FBX,FBY2,FBY3,FBCDAYS,FBSCID,FBFPPSC,FBFPPSL,FBADJLR,FBRRMKL
 S FBX=$$ADJLRA^FBCHFA(FBI_",")
 S FBY2=$G(^FBAAI(FBI,2))
 S FBY3=$G(^FBAAI(FBI,3))
 S FBCDAYS=$P(FBY2,U,10)  ; covered days
 S FBSCID=$P(FBY2,U,11)  ; patient control number
 S FBFPPSC=$P(FBY3,U)  ; fpps claim id
 S FBFPPSL=$P(FBY3,U,2)  ; fpps line item
 S FBRRMKL=$$RRL^FBCHFR(FBI_",")  ; remit remarks
 S FBADJLR=$P(FBX,U)  ; adjustment reason
 S ^TMP($J,"FBCHVP",FBI)=FBINV
 S ^TMP($J,"FBCHVP",FBI,"FBMR")=FBCDAYS_U_FBADJLR_U_FBRRMKL_U_FBSCID_U_FBFPPSC_U_FBFPPSL
 I FBCTR=0!($Y+5>IOSL) W @IOF D HED
 S FBCTR=FBCTR+1,FBI(FBCTR)=FBI
 W !,FBCTR_") " D WRT1 I $D(FBVOID)&($D(^FBAAI(FBI,"R"))) W !?3,"Reason:",!?10,^("R"),!
 Q
WRT1 N FBMRVP S FBMRVP=^TMP($J,"FBCHVP",FBI,"FBMR")
 S FBREIM=$P(FBINV,"^",13),FBFDT=$P(FBINV,"^",6),FBTDT=$P(FBINV,"^",7),FBDRG=$P(FBINV,"^",24),FBAMTC=$P(FBINV,"^",8),FBAMTP=$P(FBINV,"^",9),FBNUM=+FBINV,FBBAT=$P(FBINV,"^",17)
 D FBCKI^FBAACCB1(FBI)
 W $S(FBREIM="R":"*",1:""),$S(FBVD="VP":"#",1:""),?3,$$DATX^FBAAUTL(FBFDT),?16,$$DATX^FBAAUTL(FBTDT)
 W ?26,$S($G(FBDRG):$J($$ICD^FBCSV1(FBDRG,$G(FBFDT)),4),1:""),?35,$J($FN(FBAMTC,",",2),8),?48,$J($FN(FBAMTP,",",2),8),?62,$J(FBNUM,5),?72,$J($P($G(^FBAA(161.7,+FBBAT,0)),"^"),6)
 W !,?5,$P(FBMRVP,U),?19,$P(FBMRVP,U,2),?34,$P(FBMRVP,U,3),?54,$P(FBMRVP,U,4)
 I $P(FBMRVP,U,5)]"" W !,?5,"FPPS Claim ID: ",$P(FBMRVP,U,5),?33,"FPPS Line Item: ",$P(FBMRVP,U,6)
 N A2 S A2=+FBAMTP D PMNT^FBAACCB2
 Q
HED W !,"Patient Name: ",$P(^DPT(DFN,0),"^"),?50,"Pt.ID ",$$SSN^FBAAUTL(DFN),!!,?2,"VENDOR: ",$P(^FBAAV(FBV,0),"^"),!,?10,"('*' Represents Reimbursement to Patient)",!,?10,"('#' Represents a Voided Payment)"
 W !,"   FROM DATE",?16,"TO DATE",?26,"DRG",?33,"AMT CLAIMED",?48,"AMT PAID",?60,"INVOICE #",?72,"BATCH #"
 W !,?5,"COV.DAYS",?19,"ADJ CODE",?34,"REMIT REMARKS",?55,"PATIENT CONTROL #"
 W !,Q,!
 Q
SETR ;Set/delete void node on record.
 S DA=FBI,VP=$S($D(FBVOID):"",1:"VOID")
 I $D(FBVOID) S DR="16///@;16.5///@;17///@"
 I '$D(FBVOID) S DR="16///^S X=VP;17////^S X=DUZ"_$S($D(FBVR):";16.5////^S X=FBVR",1:";16.5R;S FBVR=X")
 S DIE="^FBAAI(",DIDEL=162.5 D ^DIE K DIDEL
 Q
CONF ;Print void/cancel void confirmation.
 W !,?10,$S($D(FBVOID):"Cancel Voided",1:"Void")," payment for ",$$NAME^FBCHREQ2(DFN),!,*7,"You must adjust control point accordingly through IFCAP!"
 Q
