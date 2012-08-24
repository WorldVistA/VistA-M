IBNCPDS1 ;ALB/BDB - DISPLAY RX COB DETERMINATION ;30-NOV-07
 ;;2.0;INTEGRATED BILLING;**411,452**; 21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ; -- main entry point to display rx cob determination
EN ;
 S U="^"
 D FULL^VALM1
 N DIROUT,DIRUT,DTOUT,DUOUT,IBADT,IBANY,IBINS,IBQUIT,IBT,IBX,X,Y
 S IBQUIT=0
 S DIR("?",1)="Enter the date for which you want to see active insurances."
 S DIR("?",2)="A valid date entry is required, or"
 S DIR("?")="enter up-arrow ( ^ ) to return to the main display screen."
 S DIR("A")="Date of Service",DIR("A",1)=" ",DIR("B")="TODAY",DIR(0)="D"
 F  D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S IBADT=Y,IBQUIT=1  Q:IBQUIT
 K DIR
 G:'IBQUIT COBQ
 ; -- look up insurance for patient
 K IBINS S IBINS=0
 D ALL^IBCNS1(DFN,"IBINS",1,IBADT,1)
 ;
 ; -- no pharmacy coverage, quit
 I '$$PTCOV^IBCNSU3(DFN,IBADT,"PHARMACY",.IBANY) G COBQ
 D EN^DDIOL("Insurance Co.COB Type of Policy Group     Holder   Effect.  Expires  Elec/Paper","","!!?1")
 ;
 S IBX=0
 F  S IBX=$O(IBINS("S",IBX)) Q:'IBX  D
 . S IBT=0 F  S IBT=$O(IBINS("S",IBX,IBT)) Q:'IBT  D
 .. N IBCAT,IBCOB,IBDAT,IBEFFDT,IBELEC,IBEXPDT,IBGRPN,IBHOLD,IBINSN,IBPIEN,IBPL,IBPTYPE,IBY,IBZ
 .. S IBQUIT=1
 .. Q:'$G(IBINS(IBT,0))
 .. S IBPL=$$GET1^DIQ(2.312,IBT_","_DFN_",",.18,"I") ; plan
 .. Q:'IBPL
 .. S IBCAT=$O(^IBE(355.31,"B","PHARMACY","")) I '$G(IBCAT)!'$$PLCOV^IBCNSU3(IBPL,IBADT,IBCAT) Q  ; not covered
 .. S IBINSN=$$GET1^DIQ(2.312,IBT_","_DFN_",",.01) ; ins name
 .. S IBPTYPE=$$GET1^DIQ(355.3,IBPL_",",.09) ; plan type
 .. S IBCOB=$$GET1^DIQ(2.312,IBT_","_DFN_",",.2,"I"),IBCOB=$S(IBCOB=1:"p",IBCOB=2:"s",IBCOB=3:"t",1:"p") ; cob indicator
 .. S IBGRPN=$$GET1^DIQ(355.3,$$GET1^DIQ(2.312,IBT_","_DFN_",",.18,"I")_",",.04) ; group id
 .. S IBHOLD=$$GET1^DIQ(2.312,IBT_","_DFN_",",6,"I") ; subscriber id
 .. S IBHOLD=$S(IBHOLD="v":"SELF",IBHOLD="s":"SPOUSE",IBHOLD="o":"OTHER",1:"")
 .. S IBEFFDT=$P(IBINS(IBT,0),U,8) I IBEFFDT]"" S IBEFFDT=$$DFORMAT(IBEFFDT) ; effective date
 .. S IBEXPDT=$P(IBINS(IBT,0),U,4) I IBEXPDT]"" S IBEXPDT=$$DFORMAT(IBEXPDT) ; expiration date
 .. S IBELEC="P" D
 ... S IBPIEN=$$GET1^DIQ(355.3,$$GET1^DIQ(2.312,IBT_","_DFN_",",.18,"I")_",",6.01,"I")
 ... I 'IBPIEN Q  ; Not linked
 ... D STCHK^IBCNRU1(IBPIEN,.IBY)
 ... I $E($G(IBY(1)))'="A" Q  ; not active
 ... S IBELEC="E"  ;Both linked and active, so electronic submit
 .. D EN^DDIOL($E(IBINSN,1,10),"","!?1")
 .. D EN^DDIOL(IBCOB,"","?14")
 .. D EN^DDIOL($E(IBPTYPE,1,12),"","?18")
 .. D EN^DDIOL($E(IBGRPN,1,7),"","?33")
 .. D EN^DDIOL($E(IBHOLD,1,9),"","?43")
 .. D EN^DDIOL($E(IBEFFDT,1,8),"","?52")
 .. D EN^DDIOL($E(IBEXPDT,1,8),"","?61")
 .. D EN^DDIOL(IBELEC,"","?70")
 ;
COBQ ;
 D PAUSE^IBNCPBB("")
 S VALMBCK="R"
 Q
 ;
DFORMAT(DF) ; Format date with slashes
 Q $E(DF,4,5)_"/"_$E(DF,6,7)_"/"_$E(DF,2,3)
 ; end of IBNCPDS1
