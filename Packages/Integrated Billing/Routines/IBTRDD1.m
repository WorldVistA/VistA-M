IBTRDD1 ;ALB/AAS - CLAIMS TRACKING DENIAL/APPEAL EDIT ; 06-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G ^IBTRD
 ;
QE ; -- Appeal/denial edit
 N IBXX,VALMY,DA,DR,DIC,DIE
 D FULL^VALM1
 D QE1^IBTRD1
 D BLD^IBTRDD
 S VALMBCK="R"
 Q
 ;
NX(IBTMPNM) ; -- edit next template
 N IBXX,VALMY
 D EN^VALM(IBTMPNM)
 I '$D(IBFASTXT) D BLD^IBTRDD
 S VALMBCK="R"
 Q
 ;
EDIT(DR,BLD) ; -- edit entry point for claims tracking reviews
 ; -- Input   IBTEMP = template name or dr string
 ;               BLD = any non-zero value if calling routine is doing own
 ;                      rebuild
 ;
 N IBDIF,DA,DIC,DIE,DIR,X,Y
 D FULL^VALM1
 L +^IBT(356.2,+IBTRC):5 I '$T D LOCKED^IBTRCD1 G EDITQ
 D SAVE^IBTRCD1
 S DIE="^IBT(356.2,",DA=IBTRC
 D ^DIE K DA,DR,DIC,DIE
 D COMP^IBTRCD1
 I IBDIF=1 D UPDATE^IBTRCD1
 L -^IBT(356.2,+IBTRC)
 D BLD^IBTRDD:'$G(BLD)
EDITQ K ^TMP($J,"IBT")
 S VALMBCK="R"
 Q
