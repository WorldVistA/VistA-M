IBCNSP02 ;ALB/AAS - INSURANCE MANAGEMENT - EXPANDED POLICY  ; 05-MAR-1993
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
AI ; -- Add ins. verification entry
 ;    called from ai^ibcnsp1
 N X,Y,I,J,DA,DR,DIC,DIE,DR,DD,DO,VA,VAIN,VAERR,IBQUIT,IBXIFN,IBTRN,DUOUT,IBX,IBQUIT,DTOUT,IBA
 Q:'$G(DFN)
 Q:'$G(IBCDFN)  S IBQUIT=0
 ;
 ; -- see if current inpatient
 ;D INP^VADPT I +VAIN(1) D
 S IBA=+$G(^DPT(DFN,.105)) I +IBA S IBTRN=$O(^IBT(356,"AD",+IBA,0))
 ;
 S IBXIFN=$O(^IBE(356.11,"ACODE",85,0))
 ;
 ; -- if not tracking id allow selecting
 I '$G(IBTRN) D  G:IBQUIT AIQ
 .W !,"You can now enter a contact and relate it to a Claims Tracking Admission entry."
 .S DIC("A")="Select RELATED ADMISSION DATE: "
 .S DIC="^IBT(356,",DIC(0)="AEQ",D="ADFN"_DFN,DIC("S")="I $P(^(0),U,5),$P(^(0),U,2)=DFN,$P(^(0),U,20)"
 .D IX^DIC K DA,DR,DIC,DIE I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1 Q
 .I +Y>1 S IBTRN=+Y
 ;
 ;I '$G(IBTRN) W !!,"Warning: This contact is not associated with any care in Claims Tracking.",!,"You may only edit or view this contact using this action.",!
 ;
 ; -- select date
 S IBOK=0,IBI=0 F  S IBI=$O(^IBT(356.2,"D",DFN,IBI)) Q:'IBI  I $P($G(^IBT(356.2,+IBI,0)),"^",4)=IBXIFN,$P($G(^(1)),"^",5)=IBCDFN S IBOK=1
 I IBOK D  G:IBQUIT AIQ
 .S DIC="^IBT(356.2,",DIC("A")="Select Contact Date: "
 .S X="??",DIC(0)="EQ",DIC("S")="I $P(^(0),U,5)=DFN,$P($G(^(1)),U,5)=IBCDFN,$P(^(0),U,4)=IBXIFN" ;,DLAYGO=356.2
 .S D="ADFN"_DFN
 .D IX^DIC K DIC,DR,DA,DIE,D I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1
 ;
 S DIC="^IBT(356.2,",DIC("A")="Select Contact Date: ",DIC("B")="TODAY"
 S DIC("DR")=".02////"_$G(IBTRN)_";.04////"_IBXIFN_";.05////"_DFN_";.19////1;1.01///NOW;1.02////"_DUZ_";1.05////"_IBCDFN
 S DIC(0)="AEQL",DIC("S")="I $P(^(0),U,5)=DFN,$P($G(^(1)),U,5)=IBCDFN,$P(^(0),U,4)=IBXIFN",DLAYGO=356.2
 D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(+Y<1) G AIQ
 S IBTRC=+Y I '$G(IBTRN),$P(^IBT(356.2,+IBTRC,0),"^",2) S IBTRN=$P(^(0),"^",2)
 ;
 I '$G(IBTRN) W !!,"Warning: This contact is not associated with any care in Claims Tracking.",!,"You may only edit or view this contact using this action.",! K IBTRN
 ;
 I $G(IBTRC),$G(IBTRN),'$P(^IBT(356.2,+IBTRC,0),"^",2) S DA=IBTRC,DIE="^IBT(356.2,",DR=".02////"_$G(IBTRN) D ^DIE
 ;
 ; -- edit ins ver type
 D EDIT^IBTRCD1("[IBT INS VERIFICATION]",1)
AIQ Q
 ;
AIP(IBTRC) ; -- ask if want to print a worksheet
 N DIR,DIRUT,DTOUT,DUOUT,IBW,IBCTHDR
 I '$D(IBTRN) N IBTRN S IBTRN=$P($G(^IBT(356.2,+$G(IBTRC),0)),"^",2)
 I '$D(DFN) N DFN S DFN=$P($G(^IBT(356,+$G(IBTRN),0)),"^",2)
 Q:'$G(DFN)!('$G(IBTRN))
 W ! S DIR(0)="SOBA^C:CT SUMMARY;W:WORKSHEET;B:BOTH;N:NONE"
 S DIR("A")="Print [C]T Summary  [W]ork Sheet (UR)  [N]one  [B]oth: "
 S DIR("B")="NONE"
 S DIR("?")="You may choose print a UR work sheet, a summary from claims tracking (of this episode), both or nothing."
 D ^DIR K DIR
 S IBW=Y I "CWB"'[Y!($D(DIRUT)) G AIPQ
 S %ZIS="QM" D ^%ZIS G:POP AIPQ
 I $D(IO("Q")) S ZTRTN="AIPDQ^IBCNSP02",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB - Print UR from Ins review" D ^%ZTLOAD D HOME^%ZIS G AIPQ
 U IO
AIPDQ ; entry point from taskman
 I IBW="C"!(IBW="B") S IBCTHDR="Claims Tracking Summary" D ONE^IBTOBI W @IOF
 I IBW="W"!(IBW="B") D DQ^IBTRC4
 ;
END I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,%ZIS,VA,IBTRND,IBTRND1,IBPAG,IBHDT,IBDISDT,IBETYP,IBQUIT,IBTAG,DIRUT,DUOUT,IBCNT,IBI,IBJ,IBNAR,IBTNOD,IBTRCD1,IBTRTP,IBDA
 D KVAR^VADPT
AIPQ Q
