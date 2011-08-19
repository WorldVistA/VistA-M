IBCB11 ;ALB/AAS - Process bill after enter/edited ;2-NOV-89
 ;;2.0;INTEGRATED BILLING;**327**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
AUTH N DIR,Y,X,IBINS,NXTINS
 S NXTINS=+$$POLICY^IBCEF(IBIFN,1,$$COBN^IBCEF(IBIFN)+1)  ; next ins
 S IBINS=$P($G(^DIC(36,NXTINS,0)),U)   ; name of next insurance
 Q:$$MCRWNR^IBEFUNC(NXTINS)            ; quit if its Medicare
 ;IF IBMRA = R2 PASS BILL DIRECTLY TO TERTIARY INSURANCE
 I IBMRA="R2" D  Q
 .D EN^DDIOL("This bill has secondary policy of MEDICARE and an MRA will not be submitted.","","!")
 .D EN^DDIOL("This bill will go directly to "_IBINS,"","!!")
 .D COBCHG^IBCCC2(IBIFN,+$$CURR^IBCEF2(IBIFN))
 .Q
 ;
 S DIR(0)="YO",DIR("B")="YES",DIR("A",1)=" "
 S DIR("A",2)="This bill has prior insurance of MEDICARE, but"
 I +$P($G(^IBE(350.9,1,8)),U,10)'<2 D
 . S DIR("A",3)="Ins Co, "_IBINS_", does not want/need an MRA."
 E  D
 . S DIR("A",3)="the site parameter for MRA Requests is turned off."
 S DIR("A",4)=" "
 S DIR("A")="Do you want this bill to go directly to "_IBINS
 S DIR("?",1)="If you answer NO, the bill will not be authorized."
 S DIR("?")="If you answer YES, this bill will automatically become a "_$P("secondary^tertiary",U,$$COBN^IBCEF(IBIFN))_" bill."
 D ^DIR K DIR
 I 'Y S IBEND=1 W !,"Can't continue",! Q
 D COBCHG^IBCCC2(IBIFN,+$$CURR^IBCEF2(IBIFN))
 Q
