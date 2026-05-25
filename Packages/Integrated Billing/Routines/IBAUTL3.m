IBAUTL3  ;ALB/CPM - MEANS TEST BILLING UTILITIES (CON'T.) ; 31 May 2022  12:59 PM
 ;;2.0;INTEGRATED BILLING;**176,656,704,769**;21-MAR-94;Build 42
 ;Per VA Directive 6402, this routine should not be modified.
 ;
DED ; Find Medicare deductible rate on the billing clock date.
 ;  Input:   IBSERV, IBCLDT    Output:  IBMED - Medicare deductible
 N X S IBMED=0
 I $G(IBSERV)="" S IBY="-1^IB031" G DEDQ   ;IB*2.0*656  Ensure that the service is defined before performing the lookup
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
CLADD ; Add a new billing clock in File #351.  (Rewritten in IB*2*704)
 ;  Input:  IBSITE, DFN, IBCLDT, IBSERV    Output: IBCLDA, IBMED
 L +^IBE(351,0):10 E  S IBY="-1^IB014" G CLADDQ
 S X=$P($S($D(^IBE(351,0)):^(0),1:"^^-1"),"^",3)+1 I 'X S IBY="-1^IB015" G CLADDQ
 K DD,DO,DIC,DR S DIC="^IBE(351,",DIC(0)="L",DLAYGO=351
 F X=X:1 I X>0,'$D(^IBE(351,X)) L +^IBE(351,X):1 I $T,'$D(^IBE(351,X)) S DINUM=X,X=+IBSITE_X D FILE^DICN I +Y>0 Q
 S (DA,IBCLDA,IB351IEN)=+Y,DIE="^IBE(351,",DR=".02////"_DFN_";.03////"_IBCLDT_";.04////1;11////"_$S($D(DUZ):DUZ,1:.5)_";12///NOW;13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW"
 D ^DIE K DA,DR,DIE L -^IBE(351,IBCLDA)
 ;
 ;Add a call to fire of an HL7 message to synchronize billing 365 day clocks    IB*2*704
 I '$G(IBCCUPDF) D EN^IBECECQ1(DFN)
 S IBY=$S('$D(Y):1,1:"-1^IB028") D:IBY>0 DED
CLADDQ L -^IBE(351,0) K DO,DD,DINUM,DIC Q
 ;
CLOCK ; Determine if the patient has an active billing clock.
 ;  Input:  IBSERV    Output:  IBCLDA, IBCLDT, IBCLDAY, IBCLDOL
 S IBCLDA=+$O(^IBE(351,"ACT",DFN,0))
 D:IBCLDA CLDATA,DED,SYNC Q  ;IB*2*769 - add call to check if clocks are in sync across all sites
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
 N IB351IEN,IBVSRNUP,IBCLKST,ZTREQ,ZTRTN,ZTDESC,ZTSAVE,ZTIO,ZTDTH ;IB*2.0*769 - New variables clock update
 D NOW^%DTC
 ;IBVSRNUP used as a flag for EN^IBECECU1 so that the clock version is not updated as part of the nightly job
 S IBVSRNUP=$S($G(IBNGHTSK):0,1:1)
 S $P(^IBE(351,IBCLDA,0),"^",$S(IBCLDAY<91:5,IBCLDAY<181:6,IBCLDAY<271:7,1:8))=IBCLDOL,$P(^(0),"^",9)=IBCLDAY,$P(^(1),"^",3,4)=$S($D(DUZ):DUZ,1:.5)_"^"_%
 S DIK="^IBE(351,",DA=IBCLDA D IX1^DIK K DIK,DA   ; Remove the QUIT if we use the code below)
 ;LINE BELOW IS FOR IB*2.0*704/769 - include 3rd parameter in queue to IBECECU1
 I $P($G(^IBE(351,IBCLDA,1)),U,5)="" S IB351IEN=IBCLDA,IBCLKST=$$GET1^DIQ(351,IBCLDA,12,"I") D:($$FMDIFF^XLFDT($$NOW^XLFDT,IBCLKST,2)>10) EN^IBECECQ1(DFN) D  Q
 .S ZTRTN="EN^IBECECU1("_DFN_","_IBCLDA_","_IBVSRNUP_")",ZTSAVE("*")="",ZTDESC="Queue Billing Clock Sync update to allow time for query to run."
 .S ZTDTH=$$HADD^XLFDT($H,,,10,),ZTIO="" D ^%ZTLOAD
 ;Add a call to send an HL7 message to synchronize billing 365 day clocks    IB*2*704
 ;
 I +$P($G(^IBE(351,IBCLDA,1)),U,5)>0 D EN^IBECECU1(DFN,IBCLDA,IBVSRNUP)  ; IB*2*704
 Q
SYNC ; Check if billing clock is out of sync
 N IBECREF,IBECREFS,IBECTFL,IBECERR,IBECARY,IBECSITE,IBECVERN,IBVRNST,IBECENT
 Q:$G(DGPMA)  ;Quit if called from patient movement
 Q:$G(IBNGHTSK)  ;Quit if clocked is being updated by nightly task
 Q:'$$GET1^DIQ(351,IBCLDA,18,"I")
 S IBECREF=$O(^IBE(351.3,"B",IBCLDA,"")),IBECREFS=IBECREF_","
 D GETS^DIQ(351.3,IBECREFS,"**","E","IBECTFL","IBECERR")
 S IBECENT="" F  S IBECENT=$O(IBECTFL(351.31,IBECENT)) Q:IBECENT=""  D
 .S IBECSITE=IBECTFL(351.31,IBECENT,10,"E"),IBECVERN=IBECTFL(351.31,IBECENT,11,"E")
 .S IBECARY(IBECSITE)=IBECVERN
 W !!,"**********************************WARNING**********************************"
 W !!,"The local billing clock is out of sync with other facility(s) below.",!,"Please sync billing clock information before creating a copayment to ensure",!,"copayment billing accuracy.",!
 ;W "FACILTY                         FACILITY CLOCK VERSION"
 W ! S IBVRNST="" F  S IBVRNST=$O(IBECARY(IBVRNST)) Q:IBVRNST=""  W IBVRNST W:$O(IBECARY(IBVRNST))'="" "; "
 S DIR(0)="Y",DIR("A")="Do you still want to add a charge"
 S DIR("?")="Enter 'Y' to continue to add the charge, or 'N' or '^' to quit",DIR("B")="No"
 D ^DIR I Y<1 S IBSYNC=-1,IBY=-1,IBCLDA=""
 Q
