IBEPTC3 ;ALB/ARH - TP FLAG ALL CLINICS ; 3/26/96
 ;;Version 2.0 ; INTEGRATED BILLING ;**55**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 W @IOF,!,"FLAG ALL CLINICS FOR THE THIRD PARTY AUTO BILLER:"
 W !!,"I -  IGNORED"
 W !,"     Stops the auto biller from creating bills for all Clinics."
 W !,"     This should only be used if the outpatient auto biller is turned on."
 W !,"     After using this option, individual or a group of clinics can be set"
 W !,"     to be auto billed resulting in a small number of clinics being auto billed."
 W !!,"B -  BILLED"
 W !,"     Resets all clinics to be billed by the auto biller."
 W !!,"This option does not change a clinics billable status, only whether or not"
 W !,"all billable clinics are processed by the auto biller."
 ;
 S DIR("A")="Set ALL Clinics to be ignored or billed by the Third Party auto biller"
 S DIR(0)="SO^I:IGNORED;B:BILLED",DIR("?")="^D HACL^IBEPTC3" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) G EX
 ;
 S IBOPT=Y W !!,"All clinics will be set as ",$S(IBOPT="I":"NON-",1:""),"auto billable Clinics."
 ;
 S DIR(0)="YO",DIR("A")="Do you want to continue" D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G EX
 I IBOPT="I" D NBCLIN G EX
 I IBOPT="B" D ABCLIN G EX
EX K IBOPT,DIR,Y
 Q
 ;
NBCLIN ; set all clinics as non-auto billed:
 ; - if the most recent entry sets the clinic to non-billable or non-auto billed then no change
 ; - if the most recent entry sets the clinic to auto billed this entry is reset to not auto bill
 ; - otherwise adds a new entry for each clinic, set to not auto bill
 N IBX,IBY,IBDT,IBCNT,IBCL,IBCLN,IBNABCL,X,Y,DIC,DIE,DA,DR
 S (IBCNT,IBCL)=0 F  S IBCL=$O(^SC(IBCL)) Q:'IBCL  D
 . S IBCLN=$G(^SC(IBCL,0)) I $P(IBCLN,U,3)'="C" Q
 . S IBNABCL=$$FN(IBCL,"") I $P(IBNABCL,U,2)!($P(IBNABCL,U,3)) Q
 . I 'IBNABCL K DO,DA S DLAYGO=352.4,DIC="^IBE(352.4,",DIC(0)="L",X=+IBCL,DIC("DR")=".02////"_DT_";.04////2" D FILE^DICN K DLAYGO S IBNABCL=Y
 . I +IBNABCL S DIE="^IBE(352.4,",DA=+IBNABCL,DR=".06////1" D ^DIE K DIC,X,DIE,DA,DR
 . S IBCNT=IBCNT+1 I '(IBCNT#5) W "."
 W !," done."
 Q
 ;
ABCLIN ; set all billable clinics to auto billed:
 ; - deletes all entries flagging a clinic for the auto biller
 ; - except those changing a clinic from non-billable to billable, these all are set to billable and auto billed
 N IBX,IBY,IBCNT,IBCL,IBDT,IBNEXT,X,Y,DIC,DIE,DA,DR
 S (IBCNT,IBCL)=0 F  S IBCL=$O(^IBE(352.4,"AIVDTT2",IBCL)) Q:'IBCL  D
 . S IBDT="" F  S IBDT=$O(^IBE(352.4,"AIVDTT2",IBCL,IBDT)) Q:IBDT=""  D
 .. S IBX=0 F  S IBX=$O(^IBE(352.4,"AIVDTT2",IBCL,IBDT,IBX)) Q:'IBX  D
 ... S IBY=$G(^IBE(352.4,IBX,0)) Q:+$P(IBY,U,5)
 ... S IBNEXT=$$FN(IBCL,IBDT) I $P(IBNEXT,U,2) D  Q
 .... I $P(IBY,U,6) S DIE="^IBE(352.4,",DA=+IBX,DR=".06////0" D ^DIE K DIC,X,DIE,DA,DR
 ... S DIK="^IBE(352.4,",DA=+IBX D ^DIK K DIK
 ... S IBCNT=IBCNT+1 I '(IBCNT#5) W "."
 W !," done."
 Q
FN(IBCL,IBDT) ; find next oldest entry for clinic
 N IBX,IBY S (IBY,IBX)=0,IBCL=+$G(IBCL),IBDT=$G(IBDT)
 S IBDT=$O(^IBE(352.4,"AIVDTT2",IBCL,IBDT))
 I IBDT'="" S IBX=$O(^IBE(352.4,"AIVDTT2",IBCL,IBDT,0))
 I +IBX S IBY=$G(^IBE(352.4,IBX,0)),IBY=IBX_U_$P(IBY,U,5)_U_$P(IBY,U,6)
 Q IBY
 ;
HACL ; help fo All Clinics
 W !,"Enter Ignored - if you want to turn on the Auto Biller one clinic at a time."
 W !,"              - if the Third Party Auto biller should create bills for"
 W !,"                outpatient visits in only a few clinics and the bills"
 W !,"                for the remaining clinics continue to be manually created."
 ;
 W !!,"Enter Billed  - to set all clinics to be billed by the auto biller."
 Q
