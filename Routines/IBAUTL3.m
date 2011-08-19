IBAUTL3 ;ALB/CPM-MEANS TEST BILLING UTILITIES (CON'T.) ; 05-SEP-91
 ;;2.0;INTEGRATED BILLING;**176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DED ; Find Medicare deductible rate on the billing clock date.
 ;  Input:   IBSERV, IBCLDT    Output:  IBMED - Medicare deductible
 N X S IBMED=0
 S X=$O(^IBE(350.1,"ANEW",IBSERV,81,0)) I 'X S IBY="-1^IB031" G DEDQ
 S X=$O(^IBE(350.2,"AIVDT",+X,-(IBCLDT+.1))),X=$O(^(+X,0))
 S IBMED=$P($G(^IBE(350.2,+X,0)),"^",4) I 'IBMED S IBY="-1^IB032"
DEDQ Q
 ;
EVADD ; Add a new billable event in File #350.
 ;  Input:  IBSITE, DFN, IBSL, IBEVDT, IBSERV, IBNH    Output:  IBEVDA
 ;          IBNHLTC (optional for LTC only)
 D ADD^IBAUTL I Y<1 S IBY=Y G EVADDQ
 N IBATYP,IBDESC
 S IBEVDA=IBN
 S IBATYP=$O(^IBE(350.1,"ANEW",IBSERV,$S($G(IBNHLTC):93,IBNH:92,1:91),0)) I 'IBATYP S IBY="-1^IB008" G EVADDQ
 S IBDESC=$P($G(^IBE(350.1,+IBATYP,0)),"^")
 S $P(^IB(IBN,0),"^",3,17)=IBATYP_"^"_IBSL_"^1^^^"_IBDESC_"^^^^^"_IBFAC_"^^^"_IBN_"^"_IBEVDT
 D NOW^%DTC S $P(^IB(IBN,1),"^")=DUZ,$P(^(1),"^",3,4)=DUZ_"^"_%
 S DIK="^IB(",DA=IBN D IX1^DIK
EVADDQ K DIK,DA Q
 ;
EVFIND ; Find most recent active (incomplete - still being billed)
 ; inpatient/NHCU event since original admission.
 ;  Input:  DFN, IBADMDT     Output:  IBEVDT, IBEVDA, IBEVCAL
 N IBD,J S IBD=IBADMDT\1,(IBEVDA,IBEVCAL,IBEVDT)=0,J=-DT
 F  S J=$O(^IB("AFDT",DFN,J)) Q:'J!(-J<IBD)!(IBEVDT)  F  S IBEVDA=$O(^IB("AFDT",DFN,J,IBEVDA)) Q:'IBEVDA  I $P($G(^IB(IBEVDA,0)),"^",5)=1 S IBEVDT=-J,IBEVCAL=$P(^(0),"^",18) Q
 Q
 ;
EVCLOS1 ; Set Last Calc date to yesterday before closing event.  Input: IBDT
 S X1=IBDT,X2=-1 D C^%DTC S IBEVCLD=X
EVCLOSE ; Close event record.  Input: IBEVDA, IBEVCLD
 N IBDR S IBDR=".05////2;"
EVUPD ; Update event record.  Input: IBEVDA, IBEVCLD
 S DR=".18////"_IBEVCLD_";13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW"
 I $D(IBDR) S DR=IBDR_DR
 S DIE="^IB(",DA=IBEVDA D ^DIE K DIE,DA,DR Q
 ;
CLADD ; Add a new billing clock in File #351.
 ;  Input:  IBSITE, DFN, IBCLDT, IBSERV    Output: IBCLDA, IBMED
 L +^IBE(351,0):10 E  S IBY="-1^IB014" G CLADDQ
 S X=$P($S($D(^IBE(351,0)):^(0),1:"^^-1"),"^",3)+1 I 'X S IBY="-1^IB015" G CLADDQ
 K DD,DO,DIC,DR S DIC="^IBE(351,",DIC(0)="L",DLAYGO=351
 F X=X:1 I X>0,'$D(^IBE(351,X)) L +^IBE(351,X):1 I $T,'$D(^IBE(351,X)) S DINUM=X,X=+IBSITE_X D FILE^DICN I +Y>0 Q
 S (DA,IBCLDA)=+Y,DIE="^IBE(351,",DR=".02////"_DFN_";.03////"_IBCLDT_";.04////1;11////"_$S($D(DUZ):DUZ,1:.5)_";12///NOW;13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW"
 D ^DIE K DA,DR,DIE L -^IBE(351,IBCLDA)
 S IBY=$S('$D(Y):1,1:"-1^IB028") D:IBY>0 DED
CLADDQ L -^IBE(351,0) K DO,DD,DINUM,DIC Q
 ;
CLOCK ; Determine if the patient has an active billing clock.
 ;  Input:  IBSERV    Output:  IBCLDA, IBCLDT, IBCLDAY, IBCLDOL
 S IBCLDA=+$O(^IBE(351,"ACT",DFN,0))
 D:IBCLDA CLDATA,DED Q
 ;
CLDATA ; Return data from the current billing clock.
 N X S X=$G(^IBE(351,+IBCLDA,0)),IBCLDT=$P(X,"^",3),IBCLDAY=$P(X,"^",9)
 S IBCLDOL=$P(X,"^",$S(IBCLDAY<91:5,IBCLDAY<181:6,IBCLDAY<271:7,1:8)) Q
 ;
CLOCKCL ; Close out the current billing clock.
 ;  Input:   DFN, IBCLDA, IBCLDT; IBCLDOL, IBCLDAY {opt}
 ;  Output:  IBCLDA=0
 N IBCLENDT,K S K=$$BILST^DGMTUB(DFN)
 S X1=IBCLDT,X2=364 D C^%DTC S IBCLENDT=X
 I K S:K<IBCLENDT IBCLENDT=K
 I $D(IBCLDOL),$D(IBCLDAY) D CLUPD
 S DA=IBCLDA,DIE="^IBE(351,",DR=".04////2;.1////"_IBCLENDT_";13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW"
 D ^DIE K DA,DR,DIE S IBY=$S('$D(Y):1,1:"-1^IB028"),IBCLDA=0 Q
 ;
CLUPD ; - update billing clock.  Input:  IBCLDA, IBCLDOL, IBCLDAY
 D NOW^%DTC
 S $P(^IBE(351,IBCLDA,0),"^",$S(IBCLDAY<91:5,IBCLDAY<181:6,IBCLDAY<271:7,1:8))=IBCLDOL,$P(^(0),"^",9)=IBCLDAY,$P(^(1),"^",3,4)=$S($D(DUZ):DUZ,1:.5)_"^"_%
 S DIK="^IBE(351,",DA=IBCLDA D IX1^DIK K DIK,DA Q
