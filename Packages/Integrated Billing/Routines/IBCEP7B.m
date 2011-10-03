IBCEP7B ;ALB/TMP - Functions for PROVIDER ID ;1-16-05
 ;;2.0;INTEGRATED BILLING;**320,348,349**;16-JAN-2005;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
GETID(CLAIM,COB) ;
 N DIR,X,Y,DTOUT,DUOUT,WHICH,ID,IBMAIN,IBDIV,DIC,IBINS,DA,DIC,Z,Z0,IBCU,OK,IBCU
 ;
 S ID=""
 S IBINS=$P($G(^DGCR(399,CLAIM,"I"_COB)),U)
 I IBINS="" Q ID
 ;
 ; Make sure they have careunits IDS defined for this insurance company before we bother asking
 S OK=0
 S Z=0 F  S Z=$O(^IBA(355.92,"B",IBINS,Z)) Q:'Z  D  Q:OK
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:$P(Z0,U,8)'="E"
 . Q:$P(Z0,U,3)=""
 . S OK=1
 I 'OK Q ID
 ;
 S WHICH=$S(COB=1:"Primary",COB=2:"Secondary",1:"Tertiary")
 S DIR("A")="Define "_WHICH_" Payer ID by Care Unit? "
 S DIR("B")="No"
 S DIR(0)="YA"
 S DIR("?",1)="Enter No to select "_WHICH_" Provider # by Division."
 S DIR("?")="Enter Yes to select "_WHICH_" Provider # for a specific Care Unit."
 D ^DIR
 I Y'=1 Q ID
 ;
 ; Get the Division
 S IBMAIN=$$MAIN^IBCEP2B()
 S IBDIV=$$EXTERNAL^DILFD(399,.22,"",$P($G(^DGCR(399,CLAIM,0)),U,22))
 S DIR("A")="Division: ",DIR(0)="355.92,.05AOr"
 ; Default Division
 S DIR("B")=$S(IBDIV]"":IBDIV,1:IBMAIN)
 D ^DIR K DIR
 S IBDIV=+$S(Y>0:+Y,1:0)
 I Y<0 Q ID
 ;
 ; Get the Care Unit
 S DIC("A")="Care Unit: "
 S DIC("W")="W ""   "",$P(^(0),U,2)"
 S DIC=355.95,DIC("S")="I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)=+$G(IBDIV)",DIC(0)="AEMQ"
 D ^DIC
 I Y<0 Q ID
 S IBCU=+Y
 ;
 ; Compile the appropriate list of IDs
 S Z=0 F  S Z=$O(^IBA(355.92,"B",IBINS,Z)) Q:'Z  D  Q:ID]""
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:$P(Z0,U,8)'="E"
 . Q:$P(Z0,U,3)'=IBCU
 . S ID=$P(Z0,U,7)_U_$P(Z0,U,6)
 Q ID
 ;
 ; See if the insurance company flag is set to send the ATT/REND ID as the Billing Provider
ATTREND(CLAIM,COB) ;
 N ID,IBINS
 S ID=""
 S IBINS=$P($G(^DGCR(399,CLAIM,"I"_COB)),U)
 I IBINS="" Q 0
 ;
 I $$FT^IBCEF(CLAIM)=2,$$GET1^DIQ(36,IBINS,4.06,"I") Q 1   ; 1500
 I $$FT^IBCEF(CLAIM)=3,$$GET1^DIQ(36,IBINS,4.08,"I") Q 1   ; ub
 Q 0
 ;
 ; Get a list of the plan types that supress Billing Provider Secondary IDs for this  Insurance Co
 ; and see if the current plan type is one of them.
SUPPPT(CLAIM,COB) ;
 N IBINS,SUPPFL
 S SUPPFL=0
 S IBINS=$P($G(^DGCR(399,CLAIM,"I"_COB)),U)
 I IBINS="" Q SUPPFL
 ;
 I $D(^DIC(36,IBINS,13)) D
 . N PLAN,PLANTYPE
 . S PLAN=$P($G(^DGCR(399,CLAIM,"I"_COB)),U,18) Q:'PLAN
 . S PLANTYPE=$P($G(^IBA(355.3,PLAN,0)),U,15) Q:PLANTYPE=""
 . Q:'$D(^DIC(36,IBINS,13,"B",PLANTYPE))
 . S SUPPFL=1
 Q SUPPFL
