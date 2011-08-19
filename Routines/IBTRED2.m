IBTRED2 ;ALB/AAS - CLAIMS TRACKING EDIT BILLING INFORMATION; 06-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(DT) D DT^DICRW
 I '$D(IOF) D HOME^%ZIS
 W @IOF,?15,"Assign Reason Not Billable to Claims Tracking Entry",!!
 S IBQUIT=0
 ;
PAT ; -- select patient
 D END Q:IBQUIT
 D PAT^IBCNSM I '$G(DFN)!($D(VALMQUIT)) G END
 ;
CT ; -- select claims tracking entry
 D TRAC^IBTRV
 I +IBY<1 D ADD G:IBQUIT END
 I '$G(IBTRN) G PAT
 D EDIT("[IBT BILLING INFO]")
 W !!
 G PAT
 ;
END K DFN,VALMQUIT,IBY,IBTRN
 Q
 ;
EDIT(IBTEMP) ; -- edit without list manager
 ; -- Input   IBTEMP = template name or dr string
 ;
 N X,Y,I,J,DA,DR,DIC,DIE
 G:$G(IBTRN)<1 EDITQ
 L +^IBT(356,+IBTRN):5 I '$T D LOCKED^IBTRCD1 G EDITQ
 D SAVE^IBTRED1
 S DIE="^IBT(356,",DA=IBTRN
 S DR=IBTEMP
 D ^DIE
 D COMP^IBTRED1
 I IBDIF=1 D UPDATE^IBTRED1
 L -^IBT(356,+IBTRN)
EDITQ K ^TMP($J,"IBT")
 Q
 ;
ADD ; -- ask if want to add a new tracking id
 N DIR,IBOK K IBTRN
 G:'$D(DFN) ADDQ
 W !
 S DIR(0)="Y",DIR("A")="Add New Claims Tracking entry",DIR("B")="NO"
 S DIR("?")="Enter 'YES' if you wish to add a new claims tracking entry so that it can be assigned a reason not billable, answer 'NO' if you do not wish to add a new entry."
 D ^DIR K DIR S IBOK=Y
 G:'IBOK ADDQ
 ;
 ; -- set up required variable before call
 S IBTASS=1
 S IBTBDT=$$FMADD^XLFDT(DT,-720),IBTEDT=$$FMADD^XLFDT(DT,+45)
 W !
 D TEST^IBTRE2
ADDQ W ! Q
