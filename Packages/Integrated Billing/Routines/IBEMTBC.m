IBEMTBC ;ALB/RLW - IB MEANS TEST BILLING CLOCK FILE UPDATE ; 10/16/23 2:32pm
 ;;2.0;INTEGRATED BILLING;**153,199,704,769**;21-MAR-94;Build 42
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Entry point for Clock Maintenance
 ;
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBEMTBC" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBEMTBC-1" D T0^%ZOSV ;start rt clock
 ;
 S IBCORRECT="corrected" ;Set corrected clock flag whenever edit billing clock option used.
 D HOME^%ZIS,NOW^%DTC S IBDT=% K % I '$D(DT) D DT^DICRW
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIR(0)="PO^2:AEMQZ" D ^DIR K DIR S DFN=+Y I $D(DIRUT) G ENQ
 I $$BILST^DGMTUB(DFN)=0 S J=5 D ERR G EN
 I $D(^IBE(351,"ACT",DFN)) S IBSELECT="ADJUST",IBDR="[IB BILLING CYCLE ADJUST]" D ADJUST,CLEANUP G ENQ
 S IBSELECT="ADD",IBDR="[IB BILLING CYCLE ADD]" D ADDNEW,CLEANUP
 ;
ENQ I '$D(DIRUT) W ! G EN
 K DIC,IBSELECT,DFN,IBDR,IBEL,DFN,IBIEN,IBDATA,J,DIRUT,IBFAC,IBSITE,IBDT,IBQRY,IBERRMSG,IBX,IBCORRECT
 ;
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBEMTBC" D T1^%ZOSV ;stop rt clock
 ;
 Q
 ;
ADJUST ; - show current active clock; inactivate and add a new one
 N IBQRYRN,IBECREF,IBECREFS,IBECTFL,IBECERR,IBECDA,IBECARY,IBECSITE,IBECVERN,IBVRNST,IBECENT,IBVRSN,IBCLKCHG,IBOOSYNC
 W @IOF
 S IBIEN=$O(^IBE(351,"ACT",DFN,0))
 S DIC="^IBE(351,",DA=IBIEN W !! D EN^DIQ K DIC,DA
 I $$GET1^DIQ(351,IBIEN,18,"I") W !,"      *****This clock is currently out of sync.******" D
 .S IBOOSYNC=1
 .S IBECREF=$O(^IBE(351.3,"B",IBIEN,"")),IBECREFS=IBECREF_","
 .D GETS^DIQ(351.3,IBECREFS,"**","E","IBECTFL","IBECERR")
 .S IBECENT="" F  S IBECENT=$O(IBECTFL(351.31,IBECENT)) Q:IBECENT=""  D
 ..S IBECSITE=IBECTFL(351.31,IBECENT,10,"E"),IBECVERN=IBECTFL(351.31,IBECENT,11,"E")
 ..I IBECSITE'="" S IBECARY(IBECSITE)=IBECVERN
 .;S IBCORRECT="corrected"
 .W !,"Please ensure you have the correct clock information from all applicable sites,"
 .W !,"as editing this clock will clear the sync flag.",!
 .W !,"The local billing clock is out of sync with other facility(s) below."
 .W ! S IBVRNST="" F  S IBVRNST=$O(IBECARY(IBVRNST)) Q:IBVRNST=""  W !,IBVRNST
 .W !
 S DIR(0)="Y",DIR("A")="Do you want to update" D ^DIR K DIR Q:+Y<1
 ;
 S DIE="^IBE(351,",DA=IBIEN,DR="16///1;18///^S X=""@""" D ^DIE ;Remove flag when editing clock, set query sent field
 I $$ICN^IBARXMU(DFN),'$$GET1^DIQ(351,IBIEN,16,"I"),'$G(IBOOSYNC) D  ;
 .W !!,"Local Clock not queried." D EDTCLCK^IBECECX1(DFN,$$GET1^DIQ(351,IBIEN,.03,"I"),IBIEN) S IBQRYRN=1
 I $G(IBFLAG1),$G(IBERRMSG)="" W !!,"Billing clock query successful and clock has been updated if applicable." I $G(IBECDA) S IBIEN=IBECDA D
 .K DR
 .S DIC="^IBE(351,",DA=IBIEN W !! D EN^DIQ K DIC,DA
 I $G(IBFLAG1),$G(IBERRMSG)=""  S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="Yes" D ^DIR K DIR I +Y<1 D EN^IBECECU1(DFN,IBIEN,1) Q
 ; - save current clock, change to cancelled and delete "ACT" xref
 I $G(IBFLAG1),$G(IBERRMSG)'="" S IBTEXT=IBERRMSG D WRAP^IBECECX1(0,80,.IBTEXT) D
 .S IBX=0 F  S IBX=$O(IBTEXT(IBX)) Q:'IBX  W !,IBTEXT(IBX)
 .I $$GET1^DIQ(351,IBIEN,18,"I") D  Q
 ..W !,"The local billing clock is out of sync with other facility(s) below.",!
 ..W ! S IBVRNST="" F  S IBVRNST=$O(IBECARY(IBVRNST)) Q:IBVRNST=""  W !,IBVRNST
 ..W !!,"Please sync billing clock information before creating a copayment to ensure",!,"copayment billing accuracy.",!!
 ..S IBQUIT=1 K DR S DIC="^IBE(351,",DA=IBIEN D EN^DIQ K DIC,DA
 ..W !!,"Please ensure you have the correct clock information from all applicable sites,"
 ..W !,"before editing the clock.",!
 .S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="No" D ^DIR K DIR I +Y<1 S IBQUIT=1
 Q:$G(IBQUIT)
 I '$G(IBFLAG1),IBSELECT'="ADD",$G(IBQRYRN) W !!,"Billing Clock Query was not returned from VDIF and clock could not be synced",!,"with other potential clocks.",! D
 .W !,"Please try again later, and if the problem persists, submit a trouble ticket.",!
 .S DIR(0)="Y",DIR("A")="Do you still want to continue",DIR("B")="No" D ^DIR K DIR I +Y<1 S IBQUIT=1
 K ^IBE(351,"ACT",DFN) L +(^IBE(351,IBIEN)):$G(DILOCKTM,3)
 S IBDATA=$P(^IBE(351,IBIEN,0),"^",2,10),$P(^IBE(351,IBIEN,0),"^",4)=3,$P(^(1),"^",3,4)=DUZ_"^"_IBDT
 S IBQRY=$P(^IBE(351,IBIEN,1),"^",5),IBCLSTDT=$$GET1^DIQ(351,IBIEN,.03,"I"),IBVRSN=$$GET1^DIQ(351,IBIEN,17,"I")
 L -(^IBE(351,IBIEN))
 ;
ADDNEW ; - add a new clock and allow updating
 N IBNCLCK,IBNOCL
 I IBSELECT="ADD" D  Q:'Y  W !
 .W !!,"This patient does not have an active billing clock!"
 .S DIR(0)="Y",DIR("A")="Is it okay to add a new billing clock for this patient"
 .D ^DIR K DIR,DIRUT,DUOUT,DTOUT
 ;
 D SITE^IBAUTL I 'IBSITE S J=1 G ERR
 S I=$P($S($D(^IBE(351,0)):^(0),1:"^^-1"),"^",3)+1 I 'I S J=3 G ERR
 K DD,DO,DIC,DR S DIC="^IBE(351,",DIC(0)="L",DLAYGO=351,DIC("DR")=".02////"_DFN_";11////"_DUZ_";12////"_IBDT
 F I=I:1 I I>0,'$D(^IBE(351,I)) L +^IBE(351,I):2 I $T,'$D(^IBE(351,I)) S DINUM=I,X=+IBSITE_I D FILE^DICN K DIC,DR S IBCL=+Y Q:+Y>0
 L -^IBE(351,IBCL)
 I IBSELECT'="ADD" S $P(^IBE(351,IBCL,0),"^",2,10)=IBDATA,$P(^IBE(351,IBCL,1),"^",5)=IBQRY,$P(^IBE(351,IBCL,1),"^",6)=IBVRSN,DIK="^IBE(351,",DA=IBCL D IX1^DIK K DIK
 I IBSELECT="ADD" S DIE="^IBE(351,",DA=IBCL,DR=".03" D ^DIE Q:$D(DTOUT)  Q:X=""  I $$GET1^DIQ(351,IBCL,.03,"I") D EDTCLCK^IBECECX1(DFN,$$GET1^DIQ(351,IBCL,.03,"I"),IBCL) I $G(IBFLAG1) D  Q:$G(IBQUIT)
 .I $$GET1^DIQ(351,IBCL,.05)'="",'$G(IBERRMSG) W !!,"Billing clock query successful and clock has been updated if applicable.",! D
 ..K DR
 ..S DIC="^IBE(351,",DA=IBCL W !! D EN^DIQ K DIC,DA
 .I $$GET1^DIQ(351,IBCL,.05)="",$G(IBERRMSG)="" S IBNOCL=1 W !!,"Query returned successfully with no billing clocks."
 .I $G(IBERRMSG)'="" S IBTEXT=IBERRMSG D WRAP^IBECECX1(0,80,.IBTEXT) D
 ..S IBX=0 F  S IBX=$O(IBTEXT(IBX)) Q:'IBX  W !,IBTEXT(IBX)
 ..W !!,"Please sync billing clock information before creating a copayment to ensure",!,"copayment billing accuracy.",!!
 ..I $$GET1^DIQ(351,IBCL,18,"I") D  Q
 ...W !,"The local billing clock is out of sync with other facility(s) below.",!
 ...W ! S IBVRNST="" F  S IBVRNST=$O(IBECARY(IBVRNST)) Q:IBVRNST=""  W !,IBVRNST ;W:$O(IBECARY(IBVRNST))'="" "; "
 ...W !!,"Please sync billing clock information before creating a copayment to ensure",!,"copayment billing accuracy.",!!
 ...S IBQUIT=1 K DR S DIC="^IBE(351,",DA=IBCL D EN^DIQ K DIC,DA
 ...W !!,"Please ensure you have the correct clock information from all applicable sites,"
 ...W !,"before editing the clock.",!
 ..S DIR(0)="Y",DIR("A")="Do you still want to continue",DIR("B")="NO" D ^DIR K DIR I +Y<1 S IBQUIT=1 D
 ...S IBDATA=^IBE(351,IBCL,0) I '$P(IBDATA,"^",3)!'$P(IBDATA,"^",4) D
 ....W !!,"This new clock is incomplete!!  Deleting the clock from the system..."
 .Q:$G(IBQUIT)
 .I '$G(IBNOCL),$G(IBERRMSG)="" S DIR(0)="Y",DIR("A")="Do you still want to update" D ^DIR K DIR I +Y<1 S IBQUIT=1 Q
 .S IBIEN=IBCL S:$G(IBECDA) IBCL=IBECDA S IBSELECT="ADJUST",IBDR="[IB BILLING CYCLE ADJUST]",IBCLSTDT=$$GET1^DIQ(351,IBCL,.03,"I"),IBNCLCK=1
 .I IBIEN'=IBCL S DA=IBIEN,DIK="^IBE(351," D ^DIK K DIK,DA D
 ..K DR W !!!
 ..S DIC="^IBE(351,",DA=IBCL W !! D EN^DIQ K DIC,DA
 ..I $$GET1^DIQ(351,IBIEN,18,"I") W !,"      *****This clock is currently out of sync.******" D
 ...W !,"Please ensure you have the correct clock information from all applicable sites,"
 ...W !,"as editing this clock will clear the sync flag.",!
 ..S DIR(0)="Y",DIR("A")="Do you want to update" D ^DIR K DIR I Y<1 S IBQUIT=1
 I $G(IBQUIT) D  Q
 .S IBDATA=^IBE(351,IBCL,0) I '$P(IBDATA,"^",3)!'$P(IBDATA,"^",4) D
 ..W !!,"This new clock is incomplete!!  Deleting the clock from the system..."
 ..S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 I $G(IBIEN) S DIE="^IBE(351,",DA=IBIEN,DR="18///^S X=""@""" D ^DIE ;Remove flag after edit
 I '$$GET1^DIQ(351,IBCL,.03,"I") D  Q 
 .W !!,"This new clock is incomplete!!  Deleting the clock from the system..."
 .S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 I $$GET1^DIQ(351,IBCL,.04,"I")=2 W !!,"Billing clock is in a closed status and cannot be edited.",! Q
 I IBSELECT="ADD",'$G(IBFLAG1) D
 .W !!,"Billing Clock Query was not returned from VDIF and clock could not be synced",!,"with other potential clocks.",! S DIR(0)="Y",DIR("A")="Do you still want to update",DIC("B")="N" D ^DIR K DIR I +Y<1 D
 ..I $$GET1^DIQ(351,IBCL,.03)=""!($$GET1^DIQ(351,IBCL,.04)="") S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA D  ;Delete clock if status null indicating no clock data added for stubbed clock
 ...W !,"Billing clock will not be created."
 ..S IBQUIT=1
 Q:$G(IBQUIT)
 I IBSELECT'="ADD" L +^IBE(351,IBCL):$G(DILOCKTM,5) S DIE="^IBE(351,",DA=IBCL,DR=".03" D ^DIE L -^IBE(351,IBCL) I X="" D  Q  ;Quit if ^ entered
 .I $$GET1^DIQ(351,IBCL,.03)=""!($$GET1^DIQ(351,IBCL,.04)="") S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA D  S IBQUIT=1  Q  ;Delete clock if status null indicating no clock data added for stubbed clock
 ..W !,"Billing clock will not be created."
 Q:$G(IBQUIT)
 I $$GET1^DIQ(351,IBCL,.03,"I")'=$G(IBCLSTDT),'($G(IBOOSYNC)) S $P(^IBE(351,IBCL,1),"^",5)="",IBQRYRN="",IBCLKCHG=1
 I IBSELECT'="ADD",'$P(^IBE(351,IBCL,1),"^",5),'$G(IBQRYRN),$G(IBCLKCHG),'$G(IBOOSYNC) W !!,"Billing Clock start date change requires new Query, please wait." D CLNCLK,EDTCLCK^IBECECX1(DFN,$$GET1^DIQ(351,IBCL,.03,"I"),IBCL) I $G(IBFLAG1) D
 .I '$G(IBERRMSG) W !!!,"Billing clock query successful and clock has been updated if applicable",!
 .I $G(IBECDA),IBCL'=$G(IBECDA) S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA S IBCL=IBECDA
 .I $G(IBERRMSG)'="" S IBTEXT=IBERRMSG D WRAP^IBECECX1(0,80,.IBTEXT) D
 ..S IBX=0 F  S IBX=$O(IBTEXT(IBX)) Q:'IBX  W !,IBTEXT(IBX)
 ..W !!,"Please sync billing clock information before creating a copayment to ensure",!,"copayment billing accuracy.",!!
 ..I $$GET1^DIQ(351,IBCL,18,"I") D  Q
 ...W "The local billing clock is out of sync with other facility(s) below.",!
 ...W ! S IBVRNST="" F  S IBVRNST=$O(IBECARY(IBVRNST)) Q:IBVRNST=""  W !,IBVRNST ;W:$O(IBECARY(IBVRNST))'="" "; "
 ...W ! S IBQUIT=1 K DR S DIC="^IBE(351,",DA=IBCL D EN^DIQ K DIC,DA
 ...W !!,"Please ensure you have the correct clock information from all applicable sites,"
 ...W !,"before editing the clock.",!
 ..S DIR(0)="Y",DIR("A")="Do you still want to update" D ^DIR K DIR I +Y<1 S IBQUIT=1 Q
 .Q:$G(IBQUIT)
 .S $P(^IBE(351,IBCL,1),"^",5)=1
 .K DR W !
 .S DIC="^IBE(351,",DA=IBCL W !! D EN^DIQ K DIC,DA
 .I $$GET1^DIQ(351,IBCL,18,"I") W !!,"*****This clock is currently out of sync.******"
 .S DIR(0)="Y",DIR("A")="Do you still want to update",DIR("B")="NO" D ^DIR K DIR I +Y<1 S IBQUIT=1
 I $G(IBQUIT) S IBDEL=0 D  Q
 .S IBDATA=^IBE(351,IBCL,0) I '$P(IBDATA,"^",3)!'$P(IBDATA,"^",4) S IBDEL=1 D
 ..W !!,"This new clock is incomplete!!  Deleting the clock from the system..."
 ..S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 .I '$G(IBDEL) D:'$$GET1^DIQ(351,IBCL,18,"I") EN^IBECECU1(DFN,IBCL,1) Q
 I '$G(IBFLAG1),IBSELECT'="ADD",$$GET1^DIQ(351,IBCL,.03,"I")'=IBCLSTDT,'$G(IBOOSYNC) W !!,"Billing Clock Query not returned.",! D
 .S DIR(0)="Y",DIR("A")="Do you still want to update" D ^DIR K DIR I +Y<1 S IBQUIT=1
 I $G(IBQUIT) D  Q
 .S IBDATA=^IBE(351,IBCL,0) I '$P(IBDATA,"^",3)!'$P(IBDATA,"^",4) D
 ..W !!,"This new clock is incomplete!!  Deleting the clock from the system..."
 ..S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 L +^IBE(351,IBCL):$G(DILOCKTM,5) S DIE="^IBE(351,",DA=IBCL,DR=IBDR D ^DIE K DA,DIE,DR ;S $P(^IBE(351,IBCL,1),"^",5)=1
 L -^IBE(351,IBCL)
 ;
 ; - if the updated clock was cancelled, with no other changes made,
 ; - move the update reason over to the old clock and cancel the new one.
 I IBSELECT'="ADD" D
 .Q:'$D(^IBE(351,+$G(IBIEN)))  Q:IBCL=IBIEN
 .I $L(^IBE(351,+$G(IBIEN),0),"^")=9 S $P(^IBE(351,+$G(IBIEN),0),"^",10)=""
 .I $L(^IBE(351,IBCL,0),"^")=9 S $P(^IBE(351,IBCL,0),"^",10)=""
 .Q:$P(^IBE(351,+$G(IBIEN),0),"^",2,10)'=$P(^IBE(351,IBCL,0),"^",2,10)
 .W !!,"Since you only cancelled the clock, I'll delete the new clock..."
 .I $P(^IBE(351,IBCL,0),"^",11)]"" S $P(^IBE(351,+$G(IBIEN),0),"^",11)=$P(^IBE(351,IBCL,0),"^",11) W !,"(but I'll save the update reason)..."
 .S $P(^IBE(351,IBIEN,1),"^",5)=1 ;IB*2*769 - Change to set query sent field to yes for canceled clocks
 .S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 .I $D(^IBE(351,IBIEN)),$$GET1^DIQ(351,IBIEN,16,"I"),('$$GET1^DIQ(351,IBIEN,18,"I")) D EN^IBECECU1(DFN,IBIEN,1) ;IB*2.0*769 - Send update for canceled clock
 ;
 ; - if the user is adding a new clock, and there is no clock
 ; - begin date or status, delete the clock.
 I IBSELECT="ADD"!($G(IBNCLCK)) S IBDATA=^IBE(351,IBCL,0) I '$P(IBDATA,"^",3)!'$P(IBDATA,"^",4) D
 .W !!,"This new clock is incomplete!!  Deleting the clock from the system..."
 .S DA=IBCL,DIK="^IBE(351," D ^DIK K DIK,DA
 I $D(^IBE(351,IBCL)),$$GET1^DIQ(351,IBCL,16,"I"),('$$GET1^DIQ(351,IBCL,18,"I")) D EN^IBECECU1(DFN,IBCL,1)
 K IBCL
 Q
CLNCLK ;Clean up old clock
 S IBIEN=IBCL
 K ^IBE(351,"ACT",DFN) L +(^IBE(351,IBIEN)):$G(DILOCKTM,3)
 S IBDATA=$P(^IBE(351,IBIEN,0),"^",2,10),$P(^IBE(351,IBIEN,0),"^",4)=3,$P(^(1),"^",3,4)=DUZ_"^"_IBDT
 S IBQRY=$P(^IBE(351,IBIEN,1),"^",5),IBVRSN=$$GET1^DIQ(351,IBIEN,17,"I")
 L -(^IBE(351,IBIEN))
 S I=$P($S($D(^IBE(351,0)):^(0),1:"^^-1"),"^",3)+1 I 'I S J=3 G ERR
 K DD,DO,DIC,DR S DIC="^IBE(351,",DIC(0)="L",DLAYGO=351,DIC("DR")=".02////"_DFN_";11////"_DUZ_";12////"_IBDT
 F I=I:1 I I>0,'$D(^IBE(351,I)) L +^IBE(351,I):2 I $T,'$D(^IBE(351,I)) S DINUM=I,X=+IBSITE_I D FILE^DICN K DIC,DR S IBCL=+Y Q:+Y>0
 S $P(^IBE(351,IBCL,0),"^",2,10)=IBDATA,$P(^IBE(351,IBCL,1),"^",5)=IBQRY,$P(^IBE(351,IBCL,1),"^",6)=IBVRSN,DIK="^IBE(351,",DA=IBCL D IX1^DIK K DIK
 L -^IBE(351,IBCL)
 Q
 ;
ERR ; - display error messages
 W !?5,$P($T(ERRMSG+J),";;",2)
CLEANUP K IBCLDA,IBCLDAY,IBCLDT,IBMED,IBCLDOL,X,IBSELECT,DLAYGO,IBDTK,IBFLAG1,DR,IBECDA,IBQUIT,IBCLSTDT,IB351IEN,IBDEL
 Q
 ;
ERRMSG ; - possible error messages
 ;;No value returned from call to SITE^IBAUTL
 ;;Record locked, try again later!
 ;;Problem extracting last IFN from zeroth node of MEANS TEST BILLING CLOCK file
 ;;Unable to add record to MEANS TEST BILLING CLOCK file
 ;;Not a Means Test copay patient!
