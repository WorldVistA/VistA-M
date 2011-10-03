IBCRTN ;ALB/AAS - EDIT BILLS RETURNED FROM AR (NEW) ;23-MAY-90
 ;;2.0;INTEGRATED BILLING;**51,199,303**;21-MAR-94;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRTN
 ;
EN1 ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EN1^IBCRTN" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="EN1^IBCRTN-1" D T0^%ZOSV ;start rt clock
 ;
 D END S IBAC=5,IBV=0 D LOOK G:'$D(IBIFN) END D EDIT,SEND:$D(IBIFN),PRINT:$D(IBIFN) L  G EN1
 Q
 ;
EN2 ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EN2^IBCRTN" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="EN2^IBCRTN-1" D T0^%ZOSV ;start rt clock
 ;
 D END S IBAC=6,IBV=1 D LOOK G END:'$D(IBIFN) D RTN,SEND:$D(IBIFN),PRINT:$D(IBIFN) L  G EN2
 Q
 ;
LOOK N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DGCR(399,",DIC(0)="AEQMZ",DIC("S")="I $S($P(^(0),U,13)=7:0,+$$RETN^PRCAFN(Y):1,1:0)" D ^DIC K DIC Q:+Y<1
 I $P($G(^DGCR(399.3,+$P(^DGCR(399,+Y,0),U,7),0)),U,10) D NOEDT G LOOK
 S IBIFN=+Y,DFN=$P(Y(0),"^",2)
 L ^DGCR(399,IBIFN):1 I '$T W !,"Already being edited by another user" K IBIFN,DFN Q
 I '$P(^DGCR(399,IBIFN,"S"),"^",9)!('$D(^XUSEC("IB EDIT",DUZ))) Q
 ;
FILE K DD,DO I '$D(^DGCR(399,IBIFN,"R",0)) S ^(0)="^399.046^"
 S DIC(0)="MN",DA(1)=IBIFN,DIC="^DGCR(399,"_DA(1)_",""R"",",DIE=DIC,DIC("DR")=".02////"_DUZ S X="NOW",%DT="T" D ^%DT S X=Y D FILE^DICN G:Y<1 END S DGIFN=+Y
 Q
 ;
EDIT N DGIFN G RTN:IBAC=6 D ^IBCSCU,^IBCSC1 I '$T K IBIFN Q 
 ;
RTN I '$D(^XUSEC("IB AUTHORIZE",DUZ))!('$D(IBIFN)) K IBIFN Q
 D EDITS^IBCB2 I IBQUIT K IBIFN Q
RTN1 W !!,"WANT TO RETURN BILL TO A/R AT THIS TIME" S %=2 D YN^DICN Q:%=1  I %=-1!(%=2) K IBIFN Q
 I '% W !?4,"YES - To set the status to Returned",!?4,"No - To take no action" G RTN1
 Q
 ;
NOEDT ;*303
 N DIR
 S DIR(0)="EA",DIR("A",1)="",DIR("A",2)="This electronically transmitted bill cannot be selected in this option.",DIR("A",3)="You must use IB COPY AND CANCEL option to edit this claim data.",DIR("A")="Press RETURN to continue " D ^DIR K DIR W !
 Q
 ;store sending data at this point
SEND S DA(1)=IBIFN,DA=DGIFN,(DIC,DIE)="^DGCR(399,"_DA(1)_",""R"",",DR=".03;.04" D ^DIE
 I '$P(^DGCR(399,IBIFN,"R",DGIFN,0),"^",4) K IBIFN Q
 ;
 W !,"Passing completed Bill to Accounts Receivable.  Bill is no longer editable."
 I $P(^DGCR(399,IBIFN,"S"),"^",9) D ARCHK^IBCB2(1,1,0,0,0,.PRCASV) D REL^PRCASVC:PRCASV("OKAY") I 'PRCASV("OKAY") K IBIFN Q
 W !,"Completed Bill Successfully sent to Accounts Receivable."
 Q
 ;
PRINT I $D(IBIFN) S IBVIEW=1 D 4^IBCB1 Q
 Q
 ;
END L  K IBNDS,IBDISP,IBER,IBNDI1,IBV,DGIFN,IBVIEW,IBIFN,DFN,IBAC,PRCASV,PRCAERR D KILL^IBCMENU
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCRTN" D T1^%ZOSV ;stop rt clock
 Q
