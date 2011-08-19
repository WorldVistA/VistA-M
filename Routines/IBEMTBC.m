IBEMTBC ;ALB/RLW - IB MEANS TEST BILLING CLOCK FILE UPDATE ; 15-JAN-92
 ;;2.0;INTEGRATED BILLING;**153,199**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Entry point for Clock Maintenance
 ;
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBEMTBC" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBEMTBC-1" D T0^%ZOSV ;start rt clock
 ;
 D HOME^%ZIS,NOW^%DTC S IBDT=% K % I '$D(DT) D DT^DICRW
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIR(0)="PO^2:AEMQZ" D ^DIR K DIR S DFN=+Y I $D(DIRUT) G ENQ
 I $$BILST^DGMTUB(DFN)=0 S J=5 D ERR G EN
 I $D(^IBE(351,"ACT",DFN)) S IBSELECT="ADJUST",IBDR="[IB BILLING CYCLE ADJUST]" D ADJUST,CLEANUP G ENQ
 S IBSELECT="ADD",IBDR="[IB BILLING CYCLE ADD]" D ADDNEW,CLEANUP
 ;
ENQ I '$D(DIRUT) W ! G EN
 K DIC,IBSELECT,DFN,IBDR,IBEL,DFN,IBIEN,IBDATA,J,DIRUT,IBFAC,IBSITE,IBDT
 ;
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBEMTBC" D T1^%ZOSV ;stop rt clock
 ;
 Q
 ;
ADJUST ; - show current active clock; inactivate and add a new one
 W @IOF
 S IBIEN=$O(^IBE(351,"ACT",DFN,0))
 S DIC="^IBE(351,",DA=IBIEN W !! D EN^DIQ K DIC,DA
 S DIR(0)="Y",DIR("A")="Do you want to update" D ^DIR K DIR Q:+Y<1
 ;
 ; - save current clock, change to cancelled and delete "ACT" xref
 K ^IBE(351,"ACT",DFN) L +(^IBE(351,IBIEN))
 S IBDATA=$P(^IBE(351,IBIEN,0),"^",2,10),$P(^IBE(351,IBIEN,0),"^",4)=3,$P(^(1),"^",3,4)=DUZ_"^"_IBDT
 L -(^IBE(351,IBIEN))
 ;
ADDNEW ; - add a new clock and allow updating
 I IBSELECT="ADD" D  Q:'Y  W !
 .W !!,"This patient does not have an active billing clock!"
 .S DIR(0)="Y",DIR("A")="Is it okay to add a new billing clock for this patient"
 .D ^DIR K DIR,DIRUT,DUOUT,DTOUT
 ;
 D SITE^IBAUTL I 'IBSITE S J=1 G ERR
 S I=$P($S($D(^IBE(351,0)):^(0),1:"^^-1"),"^",3)+1 I 'I S J=3 G ERR
 K DD,DO,DIC,DR S DIC="^IBE(351,",DIC(0)="L",DLAYGO=351,DIC("DR")=".02////"_DFN_";11////"_DUZ_";12////"_IBDT
 F I=I:1 I I>0,'$D(^IBE(351,I)) L +^IBE(351,I):2 I $T,'$D(^IBE(351,I)) S DINUM=I,X=+IBSITE_I D FILE^DICN K DIC,DR S IBCL=+Y Q:+Y>0
 I IBSELECT'="ADD" S $P(^IBE(351,IBCL,0),"^",2,10)=IBDATA,DIK="^IBE(351,",DA=IBCL D IX1^DIK K DIK
 S DIE="^IBE(351,",DA=IBCL,DR=IBDR D ^DIE K DA,DIE,DR
 L -^IBE(351,IBCL)
 ;
 ; - if the updated clock was cancelled, with no other changes made,
 ; - move the update reason over to the old clock and cancel the new one.
 I IBSELECT'="ADD" D
 .I $L(^IBE(351,+$G(IBIEN),0),"^")=9 S $P(^IBE(351,+$G(IBIEN),0),"^",10)=""
 .I $L(^IBE(351,IBCL,0),"^")=9 S $P(^IBE(351,IBCL,0),"^",10)=""
 .Q:$P(^IBE(351,+$G(IBIEN),0),"^",2,10)'=$P(^IBE(351,IBCL,0),"^",2,10)
 .W !!,"Since you only cancelled the clock, I'll delete the new clock..."
 .I $P(^IBE(351,IBCL,0),"^",11)]"" S $P(^IBE(351,+$G(IBIEN),0),"^",11)=$P(^IBE(351,IBCL,0),"^",11) W !,"(but I'll save the update reason)..."
 .S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 ;
 ; - if the user is adding a new clock, and there is no clock
 ; - begin date or status, delete the clock.
 I IBSELECT="ADD" S IBDATA=^IBE(351,IBCL,0) I '$P(IBDATA,"^",3)!'$P(IBDATA,"^",4) D
 .W !!,"This new clock is incomplete!!  Deleting the clock from the system..."
 .S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 K IBCL
 Q
 ;
ERR ; - display error messages
 W !?5,$P($T(ERRMSG+J),";;",2)
CLEANUP K IBCLDA,IBCLDAY,IBCLDT,IBMED,IBCLDOL,X,IBSELECT,DLAYGO,IBDT
 Q
 ;
ERRMSG ; - possible error messages
 ;;No value returned from call to SITE^IBAUTL
 ;;Record locked, try again later!
 ;;Problem extracting last IFN from zeroth node of MEANS TEST BILLING CLOCK file
 ;;Unable to add record to MEANS TEST BILLING CLOCK file
 ;;Not a Means Test copay patient!
