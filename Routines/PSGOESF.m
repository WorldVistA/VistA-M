PSGOESF ;BIR/MLM-SPEED FINISH ORDERS ENTERED THROUGH OE/RR ;10 Mar 98 / 2:35 PM
 ;;5.0; INPATIENT MEDICATIONS ;**7,11,29,35,127,133,221,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ; Reference to ^PSSLOCK is supported by DBIA 2789
 ;
EN ;
 I '$$HIDDEN^PSJLMUTL("SPEED") S VALMBCK="R" Q
 ;PSJ*5*221 Account for pending orders being below pending renewals
 N CODE,ST,DRG,ON,PSGONF,PSGONF2,PSGSFD,PENDCT
 D FULL^VALM1 S PSGLMT=PSJOCNT,(PSGONF,PSGONF2,PENDCT)=0
 S CODE="" F  S CODE=$O(^TMP("PSJ",$J,CODE)) Q:CODE=""  D
 .S ST="" F  S ST=$O(^TMP("PSJ",$J,CODE,ST)) Q:ST=""  D
 ..S DRG="" F  S DRG=$O(^TMP("PSJ",$J,CODE,ST,DRG)) Q:DRG=""  D
 ...S ON="" F  S ON=$O(^TMP("PSJ",$J,CODE,ST,DRG,ON)) Q:ON=""  S PSGONF=PSGONF+1 D
 ....I CODE="CC" S:$G(PSGONF2)=0 PSGONF2=PSGONF S PSGRLAST=PSGONF ;gets first renewal #
 ....;PSJ*5*221 count pending orders to offset SF selection
 ....I CODE="CB" S PENDCT=PENDCT+1
 I PENDCT,$G(PSGRLAST) S PSGRLAST=PSGRLAST-PENDCT,PSGONF2=PSGONF2-PENDCT
 I PSGONF2'>0 W !,"There are no orders which can be Speed Finished at this time.",!,"Only PENDING RENEWALS can be Speed Finished." D PAUSE^VALM1 Q
 S PSGONF=PSGONF2_"^"_PSGRLAST
 N DIR,L1,L2 S L1=+PSGONF,L2=$P(PSGONF,U,2),DIR(0)="LAO^"_L1_":"_L2,DIR("A")="FINISH which orders ("_L1_"-"_L2_"): ",DIR("?",1)="Select order"_$E("s",L1'=L2)_"to finish: ",DIR("??")="^D HELP^PSGOESF"
 D ^DIR K DIR I $D(DIRUT) K X G DONE
 I X?1N1"-" Q:$P(PSGONF,U,2)<X  S Y="" F L1=+X:1 S Y=Y_L1_"," Q:L1=$P(PSGONF,U,2)
 I 'Y W $C(7),!!,"??" G EN
ENCHK ;
 S PSJSPEED=1
 K PSGODDD S PSGODDD=1,PSGODDD(1)="" F Q=1:1:$L(Y,",") S X1=$P(Y,",",Q) D SET^PSGON Q:'$D(X)
 S PSGOSD=0 F PSGOERS=1:1:PSGODDD F PSGOERS1=1:1 S PSGOERS2=$P(PSGODDD(PSGOERS),",",PSGOERS1) Q:'PSGOERS2  S Y=+^TMP("PSJON",$J,PSGOERS2),F=$G(^PS(53.1,Y,0)),D=$G(^(.2)) D HMSG^PSGOERS I F G EN
 I $P(PSJSYSP0,"^",3) D  I '$D(PSGFOK) S X="" G DONE
 .S PSGORD=^TMP("PSJON",$J,+PSGODDD(1)),PSGOFD=$P($G(^PS(53.1,+PSGORD,2)),U,4),DA=+PSGORD,DA(1)=PSGP,PSGSFD=$P($G(^PS(53.1,+PSGORD,0)),U,16)
 .S PSGORD=$P(^PS(53.1,+PSGORD,0),U,25)
 .S PSGWLL=$S($P(PSJSYSW0,"^",4):+$G(^PS(55,PSGP,5.1)),1:0),PSGOEE="R" W ! D DATE^PSGOER0(PSGP,PSGORD,PSGSFD)
 .I '$D(PSGFOK(1)) W $C(7),!,"...order",$E("s",$L(PSGODDD(1),",")>2)," NOT finished..." K PSGFOK Q
 .I 'PSGNEDFD,$P(PSJSYSW0,"^",4) D ENWALL^PSGNE3(PSGSD,PSGFD,PSGP)
 W ! F PSGOERS=1:1:PSGODDD F PSGOERS1=1:1 S PSGOERS2=$P(PSGODDD(PSGOERS),",",PSGOERS1) Q:'PSGOERS2  S PSGORD=^TMP("PSJON",$J,PSGOERS2),PSGOEFF=0 D
 .I '$$LS^PSSLOCK(PSGP,PSGORD) W !,"  ",PSGOERS2,". ",$P($$DRUGNAME^PSJLMUTL(PSGP,PSGORD),"^")," ",$P($G(^PS(53.1,+PSGORD,.2)),"^",2),!,"...No action taken on this order...",! H 1 Q
 .;K PSGORQF D ENDDC^PSGSICHK(PSGP,+$G(^PS(53.1,+PSGORD,1,1,0)))
 .;I '$D(PSGORQF) K PSGORQF,^TMP($J,"DI") D
 .;. F PSGDDI=1:0 S PSGDDI=$O(^PS(53.1,+PSGORD,1,PSGDDI)) Q:'PSGDDI  S PSJDD=+$G(^PS(53.1,+PSGORD,1,PSGDDI,0)) D IVSOL^PSGSICHK
 .S X=$G(^PS(53.1,+PSGORD,.2)),PSGPDRGN=$$ENPDN^PSGMI(+X),PSGDO=$P(X,U,2),X=$G(^PS(53.1,+PSGORD,0)),PSGMRN=$$ENMRN^PSGMI($P(X,U,3)),PSGST=$P(X,U,7)
 .S PSGSCH=$P($G(^PS(53.1,+PSGORD,2)),U),PSGSI=$G(^(6))
 .D OC531
 .I 'PSGOEFF&($D(PSGORQF)) W !!,"  ",PSGOERS2,". ",$P($$DRUGNAME^PSJLMUTL(PSGP,PSGORD),"^")," ",$P($G(^PS(53.1,+PSGORD,.2)),"^",2),!,"...No action taken on this order...",! H 1 Q
 .;S X=$G(^PS(53.1,+PSGORD,.2)),PSGPDRGN=$$ENPDN^PSGMI(+X),PSGDO=$P(X,U,2),X=$G(^PS(53.1,+PSGORD,0)),PSGMRN=$$ENMRN^PSGMI($P(X,U,3)),PSGST=$P(X,U,7)
 .;S PSGSCH=$P($G(^PS(53.1,+PSGORD,2)),U),PSGSI=$G(^(6))
 .S $P(^PS(53.1,+PSGORD,2),U,2)=PSGSD,$P(^(2),U,4)=PSGFD,X=+$P($G(^PS(53.1,+PSGORD,0)),U,25)
 .I $P($G(^PS(55,PSGP,5,+X,2)),U,4)>PSGSD S $P(^(2),U,3)=$P(^(2),U,4) K DA,DIE,DR S DA(1)=PSGP,DA=X,DR="34////"_PSGSD,DIE="^PS(55,"_DA(1)_",5," D ^DIE
 .W !!,"  ",PSGOERS2,". ",$P($$DRUGNAME^PSJLMUTL(PSGP,PSGORD),"^")," "
 .W $P($G(^PS(53.1,+PSGORD,.2)),"^",2)
 .D UPDATE
 .D EN^PSGOEV(PSGORD)
 .D UNL^PSSLOCK(PSGP,PSGORD)
 ;
DONE ; Kill and exit.
 S DIR(0)="E" D ^DIR K DIR
 I $G(PSGPXN) D ^PSGPER1
 K PSJSPEED,PSGODDD,PSGOERS,PSGORD,PSGOERS2,PSGPDRGN,PSGDO,PSGSCH,PSGSI,NF,Y,PSGRLAST
 Q
HELP    ; Display help text for select order to be finished prompt."
 W !!,"  Select the orders to be speed finished. Only orders listed under the PENDING",!,"RENEWALS heading are selectable. The start and stop date/times specified will"
  W !,"be used for all orders selected to be finished using this function.",!
 Q
UPDATE        ;
 N LOOP K ^PS(53.45,PSJSYSP,2)
 F LOOP=0:0 S LOOP=$O(^PS(53.1,+PSGORD,1,LOOP)) Q:'LOOP  D
 .S ^PS(53.45,PSJSYSP,2,LOOP,0)=^PS(53.1,+PSGORD,1,LOOP,0)
 .S PSJJDRUG=$P(^PS(53.1,+PSGORD,1,LOOP,0),"^")
 .S ^PS(53.45,PSJSYSP,2,"B",PSJJDRUG,LOOP)=""
 .S ^PS(53.45,PSJSYSP,2,0)="^53.4502P"_"^"_LOOP_"^"_LOOP K PSJJDRUG
 Q
OC531 ;* Order checks for Speed finish and regular finish
 ;PSJOCDS("ON_TYPE") - Order type of either "UD" or "IV"
 ;PSJOCDS - 0/1 (O - will exclude dose check.  1 - include the dose check for the prospective)
 N INTERVEN,PSJDDI,PSJIREQ,PSJRXREQ,PSJPDRG,PSJDD,PSJALLGY,PSJOCDS,PSJX,PSGDT,%
 D NOW^%DTC S PSGDT=%
 S Y=1,(PSJIREQ,PSJRXREQ,INTERVEN,X)=""
 ;K PSGORQF D ENDDC^PSGSICHK(PSGP,+$G(^PS(53.1,+PSGORD,1,1,0)))
 ;I '$D(PSGORQF) K PSGORQF,^TMP($J,"DI") D
 ;. F PSGDDI=1:0 S PSGDDI=$O(^PS(53.1,+PSGORD,1,PSGDDI)) Q:'PSGDDI  S PSJDD=+$G(^PS(53.1,+PSGORD,1,PSGDDI,0)) K PSJPDRG D IVSOL^PSGSICHK
 I $G(PSJSPEED) D
 . F PSGDDI=0:0 S PSGDDI=$O(^PS(53.1,+PSGORD,1,PSGDDI)) Q:'PSGDDI  D
 .. S PSJDD=+$G(^PS(53.1,+PSGORD,1,PSGDDI,0))
 .. S PSJX=$S('$D(^PSDRUG(+PSJDD,0)):1,$P($G(^(2)),U,3)'["U":1,$G(^("I"))="":0,1:^("I")'>$G(PSGDT))
 .. Q:PSJX
 .. S PSJALLGY(PSJDD)=""
 I '+$G(PSJSPEED) S PSJDD=$$DD53P45^PSJMISC()
 S PSJDD=$O(PSJALLGY(0)) Q:'+PSJDD
 K PSGORQF D ENDDC^PSGSICHK(PSGP,PSJDD)
 ;Only do dosing check for speed finish. Regular finish will do dosing check at ENCKDD^PSGOEF1
 I '+$G(PSJSPEED),$G(PSGOEFF) Q
 ;For some reasons PSGMR is not define when SF a UD order
 ;If user was not required to enter a DD (order was able to default a DD), need to get dosing check
 NEW PSGMR I ($G(PSGORD)["P") S PSGMR=$P($G(^PS(53.1,+PSGORD,0)),U,3)
 D:'$G(PSGORQF) IN^PSJOCDS($G(PSGORD),"UD",+PSJDD)
 Q
