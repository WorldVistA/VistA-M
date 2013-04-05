PSGOEF1 ;BIR/CML3-FINISH ORDERS ENTERED THROUGH OE/RR (CONT) ;02 Feb 2001  12:20 PM
 ;;5.0;INPATIENT MEDICATIONS;**2,7,35,39,45,47,50,63,67,58,95,110,186,181,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^VALM1 is supported by DBIA# 10116.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ; Reference to ^%DTC is supported by DBIA 10000.
 ; Reference to ^%RCR is supported by DBIA 10022.
 ; Reference to ^DIE is supported by DBIA 10018.
 ; Reference to ^DIR is supported by DBIA 10026.
 ;
UPD ;
 W !!,"...accepting order..."
 I PSGST="",(PSGSCH="NOW"!(PSGSCH="ONCE")) S PSGST="O"
 I PSJCOM D UPD^PSJCOM Q
 K DA,DR S DA=+PSGORD,DIE="^PS(53.1,",DR="28////N;4////U"_";7////"_PSGST_";10////"_PSGSD_";25////"_PSGFD
 I $D(PSGSI),$P($G(^PS(53.1,+PSGORD,0)),U,24)'="R" S ^PS(53.1,DA,6)=PSGSI
 I $D(PSGSI),$P($G(^PS(53.1,+PSGORD,0)),U,24)="R" S $P(^PS(53.1,DA,6),U)=$P(PSGSI,U) I $P(^PS(53.1,DA,6),U)="" S $P(^PS(53.1,DA,6),U,2)=""
 S:PSGOEFF#2 DR=DR_";26////"_PSGSCH
 I PSGSM,PSGOHSM'=PSGHSM S DR=DR_";5////"_PSGSM_";6////"_PSGHSM
 D ^DIE W "."
 F Q=1,3 K @(PSGOEEWF_Q_")") S %X="^PS(53.45,"_PSJSYSP_","_$S(Q=1:2,1:1)_",",%Y=PSGOEEWF_Q_"," K @(PSGOEEWF_Q_")") D %XY^%RCR W "."  ;MOU-0100-30945
 S PSGND=$G(^PS(53.1,+PSGORD,0)),X=$P(PSGND,U,24)
 I $S(X="R":1,+$G(^PS(55,PSGP,5.1))>PSGDT:0,1:X'="E") S X=$G(^PS(53.1,DA,2)) D ENWALL^PSGNE3(+$P(X,U,2),+$P(X,U,4),PSGP)
 I $P(PSGND,U,24)="R",$P(PSGND,U,25),PSGSD<$P($G(^PS(55,PSGP,5,+$P(PSGND,U,25),2)),U,4) D
 .K DA,DR S DA(1)=PSGP,DA=+$P(PSGND,U,25),DIE="^PS(55,"_PSGP_",5,",DR="34////"_PSGFD_";25////"_$P($G(^PS(55,PSGP,5,+$P(PSGND,U,25),2)),U,4)
 .D ^DIE,EN1^PSJHL2(PSGP,"XX",$P(PSGND,U,25))
 S $P(^PS(53.1,+PSGORD,.2),U,2)=PSGDO,$P(^PS(53.1,+PSGORD,2),U,5)=PSGAT S:$G(PSGS0XT) $P(^(2),U,6)=PSGS0XT
 I 'PSGOEAV D NEWNVAL^PSGAL5(PSGORD,$S(+PSJSYSU=3:22005,1:22000))
 I $D(^PS(53.45,+$G(DUZ),5,1,0)) D FILESI^PSJBCMA5(PSGP,PSGORD) N SIARRAY S SIARRAY="" D NEWNVAL^PSGAL5(PSGORD,6000,"SPECIAL INSTRUCTIONS",,.SIARRAY)
 I $D(^PS(53.45,+$G(DUZ),6,1,0)) D FILEOPI^PSJBCMA5(PSGP,PSGORD) N SIARRAY S SIARRAY="" D NEWNVAL^PSGAL5(PSGORD,6000,"OTHER PRINT INFO",,.SIARRAY)
 I PSGOEAV,+$G(PSJSYSU)=3 D VFY^PSGOEV Q
 I PSGOEAV,$G(PSJRNF) D VFY^PSGOEV
 Q
 ;
ENDRG(PSGPDRG,DRGDA) ; enter dispense drug for order w/o one
 NEW PSJALLGY
 K PSGORQF
 D NOW^%DTC K DRG S (DRG,Q)=0 F  S Q=$O(^PSDRUG("ASP",+PSGPDRG,Q)) Q:'Q  I $D(^PSDRUG(Q,0)),$P($G(^(2)),U,3)["U" S X=+$G(^("I")) I 'X!(X>%) S DRG=DRG+1,DRG(DRG)=Q_"^"_^(0)
 I 'DRG W $C(7),!!,"No dispense drugs were found for this order's Orderable Item." K DIR S DIR(0)="E" D ^DIR K DIR S CHK=-1 Q
 S:DRG=1 Y(0)=1
 I DRG>1 D  I 'Y S DRG=0,CHK=-1 Q
 .W !!,"CHOOSE FROM:" F Q=1:1:DRG W !?3,$J(Q,3),". ",$P(DRG(Q),"^",2)
 .N DIR S DIR(0)="LAO^1:"_DRG_U_"I X#1!(X[""."") K X",DIR("A")="Select DISPENSE DRUG(S) for this order: " S:DRG=1 DIR("B")=1 S DIR("?")="^D DRGH^PSGOEF1" W ! D ^DIR
 ;
 S DRG=Y(0) F Q1=1:1 S Q2=$P(DRG,",",Q1) Q:'Q2  D
 . S PSJALLGY(+DRG(Q2))=""
 I 'DRGDA S ^PS(53.45,PSJSYSP,2,0)="^53.4502P"
 F Q1=1:1 S Q2=$P(DRG,",",Q1) Q:'Q2  D
 . S DRGDA=DRGDA+1,^PS(53.45,PSJSYSP,2,DRGDA,0)=+DRG(Q2),^PS(53.45,PSJSYSP,2,"B",+DRG(Q2),DRGDA)=""
 . S DA(1)=PSJSYSP,DA=DRGDA,DIE="^PS(53.45,"_PSJSYSP_",2,",DR=".02//1" W !!,$P(DRG(Q2),U,2) D ^DIE
 D ENCKDD(PSGP,+$O(PSJALLGY(0))) Q:$G(PSGORQF)
 S PSGDI=0
 S:DRGDA>0 $P(^PS(53.45,PSJSYSP,2,0),"^",3,4)=DRGDA_"^"_DRGDA,CHK=0 Q
 Q
 ;
DRGH ;
 W !!?2,"This order must have at least one dispense drug before it can be completed.",!,"Select one or more items listed.  For each item selected, you will be",!,"prompted for the UNITS PER DOSE for the item."
 Q
ENIVUD(PSJORD)     ;
 ;Determine if user should be prompted to transfer the order to IV.
 ;  INPUT: PSJORD - IEN in 53.1_order location code.
 ; OUTPUT: 1 - Order not transferred, process as always.
 ;         0 - User selected to transfer order and quit upon return.
 ;
 NEW DIR,DIRUT,PSJCOI,PSJND0,Y
 S PSJND0=$G(^PS(53.1,+PSJORD,0)),PSJCOI=+$G(^PS(53.1,+PSJORD,.2))
 I $P(PSJND0,U,4)="F" Q 1
 D FULL^VALM1
 I $S($P(PSJND0,U,24)="R":1,1:'$P(PSJND0,U,13)) Q 1
 S DIR(0)="SAB^I:IV;U:UNIT DOSE",DIR("A")="COMPLETE THIS ORDER AS IV OR UNIT DOSE? ",DIR("B")=$S($P(PSJND0,U,4)="I":"IV",1:"UNIT DOSE")
 S DIR("??")="^D THELP^PSGOEF1("""_$S(DIR("B")="IV":"UNIT DOSE",1:"IV")_""","_PSJCOI_")"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) Q 0
 I Y="I" D  Q 0
 . I +PSJSYSU=1,'$G(PSJIRNF) W !!!!,"You need the PSJI RNFINISH key to finish this order as IV!" D PAUSE^VALM1 S VALMBCK="R" Q
 . D IV^PSJLIFNI(PSJORD,PSJCOI)
 I Y="U" D  Q 0
 . I +PSJSYSU=1,'$G(PSJRNF) W !!!!,"You need the PSJ RNFINISH key to finish this order as Unit Dose!" D PAUSE^VALM1 S VALMBCK="R" Q
 . I $G(PSJITECH),($P(PSJSYSU,";",3)'=3) W !!!!,"You may not finish this order as Unit Dose!" D PAUSE^VALM1 S VALMBCK="R" Q
 . D ENUD^PSGOEF1(PSJORD,PSJCOI)
 Q 1
 ;
ENUD(PSJORD,PSGPD)       ;
 N PSJTUD S PSJTUD=1,DFN=$P($G(^PS(53.1,+PSJORD,0)),U,15)
 K DRG,DRGOC,DRGT,DRGTMP,ERR,ON,ON55,P,PSJSTAR,PSJTIM,UL80
 D DISACTIO^PSJOE(DFN,PSJORD,$G(PSJPNV)) S VALMBCK="Q"
 I +$G(PSGORQF) S VALMBCK="R"
 Q
THELP(PKG,COI) ;
 W !,"Choose the package this order should be completed as a IV or Unit Dose order",!
 Q
 ;
ENCKDD(PSGP,PSJDRG) ;
 ;If the OI is edited, the OC is done in ^PSGOEE (PSGOE8 - Non-VFY; PSGOE9 - Active)
 Q:$G(PSGOEER)["101^PSGOE8"
 Q:$G(PSGOEER)["101^PSGOE9"
 N DRG
 S PSGORQF=0
 D ENDDC^PSGSICHK(PSGP,PSJDRG) Q:$G(PSGORQF)
 D IN^PSJOCDS($G(PSGORD),"UD",+PSJDRG)
 Q
