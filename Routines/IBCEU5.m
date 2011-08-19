IBCEU5 ;ALB/TMP - EDI UTILITIES (continued) FOR CMS-1500 ;13-DEC-99
 ;;2.0;INTEGRATED BILLING;**51,137,232,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EXTCR(IBPRV) ; Called by trigger on field .02 of file 399.0222
 ; Function returns the first 3 digits of the provider's degree if
 ; a VA provider or the credentials in file 355.9 if non-VA provider
 ; IBPRV = vp to file 200 or 355.93
 Q $E($$CRED^IBCEU(IBPRV),1,3)
 ; 
FTPRV(IBIFN,NOASK) ; If form type changes from UB-04 to CMS-1500 or vice
 ; versa, ask to change provider function to appropriate function for
 ; form type (ATTENDING = UB-04, RENDERING = CMS-1500)
 ; IBIFN = ien of bill in file 399
 ; NOASK (flag) = 1 if change should happen without asking first
 N ATT,REN,FT
 S FT=$$FT^IBCEF(IBIFN)
 S REN=$$CKPROV^IBCEU(IBIFN,3,1)
 S ATT=$$CKPROV^IBCEU(IBIFN,4,1)
 I $S(FT=2:'REN&ATT,FT=3:'ATT&REN,1:0) D
 . I '$G(NOASK) D TXFERPRV(IBIFN,FT) Q
 . D PRVCHG(IBIFN,FT)
 Q
 ;
TXFERPRV(IBIFN,FT) ; Ask to change the function of the main provider on
 ;  bill IBIFN to the function appropriate to the form type FT
 ;  
 N DIR,X,Y,Z,DIE,DA,DR,HAVE,NEED,IBZ
 W ! S DIR("A")="  WANT TO CHANGE THE "_$S(FT=3:"RENDERING",1:"ATTENDING")_" PROVIDER'S FUNCTION TO "_$S(FT=3:"ATTENDING",1:"RENDERING")_"?: "
 S DIR(0)="YA",DIR("B")="YES",DIR("?",1)="IF YOU ANSWER YES HERE, YOU WILL MAKE THE PROVIDER FUNCTIONS CONSISTENT",DIR("?")="  WITH THE FORM TYPE OF THE BILL"
 D ^DIR K DIR
 Q:Y'=1
 D PRVCHG(IBIFN,FT)
 Q
 ;
PRVCHG(IBIFN,IBFT) ; Change provider type to type consistent with current
 ; data on bill
 N Z,IBZ,HAVE,NEED,DIE,DA,X,Y
 S HAVE=$S(IBFT=3:3,1:4)
 S NEED=$S(IBFT=3:4,1:3)
 S Z=$O(^DGCR(399,IBIFN,"PRV","B",HAVE,0))
 I Z D
 . S DA(1)=IBIFN,DA=+Z
 . D FDA^DILF(399.0222,.DA,.01,,NEED,"IBZ")
 . D FILE^DIE(,"IBZ")
 ;I Z S DA(1)=IBIFN,DIE="^DGCR(399,"_DA(1)_",""PRV"",",DA=+Z,DR=".01////"_NEED D FILE^DIE(,DIE
 Q
 ;
PRVHELP ; Text for the provider function help
 Q:$G(X)'="??"
 N IBZ,IBQUIT,IB,IB1,DIR
 S IBQUIT=0
 I '$D(IOSL)!'$D(IOST) D HOME^%ZIS
 Q:IOST'["C-"
 W @IOF
 I $G(D0) D
 . N Z
 . D SPECIFIC(D0)
 . S Z=$$FT^IBCEF(D0)
 . I $S(Z=2:$D(^DGCR(399,D0,"PRV","B",4)),Z=3:$D(^DGCR(399,D0,"PRV","B",3)),1:0) D
 .. W !,"**** ",$S(Z=2:"ATTENDING",1:"RENDERING")," FUNCTION DOES NOT BELONG ON THIS BILL TYPE & MUST BE DELETED"
 S IB=IOSL,IB1=1
 F IBZ=1:1 S:$P($T(HLPTXT+IBZ),";;",2)="" IBQUIT=1 Q:IBQUIT  S IB1=1 D
 . I $Y>(IB-3) N DIR,X,Y S IB1=0,DIR(0)="E" D ^DIR K DIR S IB=IB+IOSL I Y'=1 S IBQUIT=1 Q
 . W !,$P($T(HLPTXT+IBZ),";;",2)
 I IB1 D
 . N DIR,X,Y S DIR(0)="E" D ^DIR K DIR
 W @IOF
 Q
 ;
SPECIFIC(IBIFN) ; Display specific provider requirements for the bill IBIFN
 N IBFT,IBPRV,IBR,ONBILL,Z,IBZ
 S IBFT=$$FT^IBCEF(IBIFN)
 D GETPRV^IBCEU(IBIFN,"ALL",.IBPRV) ;Returns needed providers
 W !,"This bill is ",$S(IBFT=3:"UB-04",1:"CMS-1500"),"/",$S($$INPAT^IBCEF(IBIFN):"Inpatient",1:"Outpatient")
 W !!,"The valid provider functions for this bill are:"
 F IBZ=1:1:5,9 I $$PRVOK^IBCEU(IBZ,IBIFN) D
 . S ONBILL=$$CKPROV^IBCEU(IBIFN,IBZ)
 . S IBR=$S($G(IBPRV(IBZ,"NOTOPT")):1,1:0)
 . W !,IBZ,"  ",$$EXPAND^IBTRE(399.0222,.01,IBZ),?13,$S(IBR&'ONBILL:"**",1:""),?15,$S(IBR:"REQUIRED",1:"OPTIONAL"),$S(ONBILL:" - ALREADY ON BILL",1:" - NOT ON BILL")
 W !
 Q
 ;
HLPTXT ; Helptext for provider function
 ;; 
 ;;PROVIDER FUNCTION requirements:
 ;; 
 ;;RENDERING: CMS-1500 (both inpatient and outpatient): REQUIRED
 ;;           This is the provider who performed the services.
 ;;           Data will appear in Form Locator 24 of the CMS-1500.
 ;; 
 ;;    NOTE: There can be only one rendering provider per CMS-1500
 ;;          claim form, so there may be multiple CMS-1500's for a
 ;;          single episode of care if services were performed by more
 ;;          than one provider.  For example, there will be 2 CMS-1500's
 ;;          created for an episode of care that involved a surgical
 ;;          procedure and a radiology exam.  The operating physician
 ;;          would be the rendering provider on the CMS-1500 that
 ;;          included the surgical procedure(s) and the radiologist
 ;;          would be the rendering provider on the CMS-1500 that
 ;;          included the radiology procedure(s).
 ;; 
 ;; 
 ;;ATTENDING: UB-04 (inpatient and outpatient): REQUIRED
 ;;           The physician who normally would be expected to
 ;;           certify and recertify the medical necessity of the
 ;;           services rendered and/or who has primary responsibility
 ;;           for the patient's medical care and treatment.  Data is
 ;;           printed in Form Locator 76 on the UB-04.
 ;; 
 ;;    NOTE: If there are multiple attending providers for the bill,
 ;;          report the attending provider for the procedure having the
 ;;          highest charge.  For outpatient, if the patient is
 ;;          self-referred (e.g.: an ER or clinic visit), you may use
 ;;          SLF000 as the attending provider id, with no provider
 ;;          name.  SLF000 may NOT be used for services which require a
 ;;          physician referral/order.
 ;; 
 ;; 
 ;;OPERATING: UB-04 (inpatient and outpatient): SOMETIMES REQUIRED
 ;;           The provider who performed the principal procedure(s)
 ;;           being billed.  Data will be printed in Form Locator 77
 ;;           on the UB-04.
 ;; 
 ;;    NOTE: Not applicable for CMS-1500 form type as this would be
 ;;                             reported as the rendering provider on
 ;;                             the CMS-1500.
 ;;          UB-04 (inpatient): REQUIRED IF type of bill has first 2
 ;;                             digits of 11, and there is a principal
 ;;                             procedure that will print in Form
 ;;                             Locator 74 of the claim.
 ;;          UB-04 (outpatient): REQUIRED IF type of bill has first 2
 ;;                             digits of 83, and there is a principal
 ;;                             procedure that will print in Form
 ;;                             Locator 74 of the claim.
 ;; 
 ;; 
 ;;REFERRING: CMS-1500 (both inpatient and outpatient): OPTIONAL
 ;;           The provider who requested that the services being billed
 ;;           be performed.  Data will be printed in boxes 17 and 17a of
 ;;           the CMS-1500.
 ;; 
 ;; 
 ;;SUPERVISING: CMS-1500 (both inpatient and outpatient): OPTIONAL
 ;;           Required only when the rendering provider is supervised
 ;;           by a physician.  Data will not be printed.
 ;; 
 ;; 
 ;;OTHER: UB-04 (both inpatient and outpatient): OPTIONAL
 ;;           Used to report providers with functions not specifically
 ;;           designated here.
 ;;
 ;
LINKRX(IBIFN,IBREV) ; Ask for revenue code's RX if not already there
 N DIR,X,Y,IBZ,IBRX,Z,Z0,DA
 Q:$P($G(^DGCR(399,IBIFN,"RC",IBREV,0)),U,11)!($P($G(^(0)),U,10)'=3)
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  I Z'=IBREV S Z0=$G(^(Z,0)) I $P(Z0,U,10)=3,$P(Z0,U,11) S IBRX(+$P(Z0,U,11))=""
 S DIR(0)="PAO^IBA(362.4,:AEMQ",DIR("S")="I $P(^(0),U,2)=IBIFN,'$D(IBRX(+Y))"
 S DIR("A")="Select Rx for this charge: "
 S DIR("?",1)="Enter an Rx# for this revenue code"
 S DIR("?")=" The Rx must not already have an associated revenue code"
 D ^DIR K DIR
 I Y>0 D
 . S DA(1)=IBIFN,DA=IBREV,IBZ=""
 . D FDA^DILF(399.042,.DA,.11,"R",+Y,"IBZ")
 . D FILE^DIE(,"IBZ")
 Q
 ;
LINKCPT(IBIFN,IBREV) ; Ask for revenue code's CPT
 N DIR,X,Y,IBZ,IBCP,Z,Z0,Z1,DA,IBRC,IBP
 S IBRC=$G(^DGCR(399,IBIFN,"RC",IBREV,0))
 Q:$P(IBRC,U,8)!($P(IBRC,U,10)'=4)
 S IBP=+$P(IBRC,U,6)
 I $P(IBRC,U,11) W !,"PROCEDURE #"_$P(IBRC,U,11)_" HAS BEEN ASSOCIATED WITH THIS MANUAL CHARGE"
 I '$P(IBRC,U,11) D  Q:IBRC=""
 . S DIR("?",1)="Respond YES if this revenue code charge specifically references the data for"
 . S DIR("?",2)="  a particular procedure that was manually entered on the previous screen."
 . S DIR("?",3)="  For outpatient UB-04 bills, associating a manual revenue code charge with",DIR("?")="  a procedure is the only way to print a modifier in box 44"
 . S DIR(0)="YA",DIR("A")="SHOULD A PROCEDURE ENTRY BE ASSOCIATED WITH THIS CHARGE?: ",DIR("B")=$S(IBP:"YES",1:"NO") W ! D ^DIR K DIR W !
 . I Y'=1 S IBRC="" Q
 I $P(IBRC,U,11) D
 . S DIR("?",1)="Respond YES if you no longer want this revenue code charge to reference a",DIR("?")="  specific manually entered procedure"
 . S DIR(0)="YA",DIR("A")="DELETE THE EXISTING PROCEDURE ASSOCIATION?: ",DIR("B")="NO" W ! D ^DIR K DIR
 . I Y=1 D UPDPTR(IBIFN,IBREV,"") S $P(IBRC,U,11)=""
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  S Z0=$G(^(Z,0)) I IBREV'=Z,$P(Z0,U,11) D
 . ; Don't allow to link to 'used' proc
 . I $P(Z0,U,10)=4 S IBCP($P(Z0,U,11))="" Q
 . I $P(Z0,U,10)=3,$P(Z0,U,15) S IBCP($P(Z0,U,15))=""
 S DIR(0)="PAO^DGCR(399,"_IBIFN_",""CP"",:AEMQ",DIR("S")="I '$D(IBCP(+Y)),$P(^(0),U)[""CPT"",+^(0)="_+$P($G(^DGCR(399,IBIFN,"RC",IBREV,0)),U,6)
 S DIR("A")="SELECT A PROCEDURE ENTRY: "_$S($P(IBRC,U,11):"#"_$P(IBRC,U,11)_" - "_$$EXPAND^IBTRE(399.0304,.01,$P($G(^DGCR(399,IBIFN,"CP",$P(IBRC,U,11),0)),U))_"// ",1:"")
 S DIR("?")="Enter a manually-added CPT procedure to associate with this charge"
 S DA(1)=IBIFN
 D ^DIR K DIR W !
 I Y>0 D UPDPTR(IBIFN,IBREV,+Y)
 Q
 ;
UPDPTR(IBIFN,IBREV,Y) ;
 N IBZ,DA
 S DA(1)=IBIFN,DA=IBREV,IBZ=""
 D FDA^DILF(399.042,.DA,.11,"R",$S(Y:+Y,1:""),"IBZ")
 D FILE^DIE(,"IBZ")
 Q
 ;
INSFT(IBIFN) ; Returns 1 if form type is UB-04, 0 if CMS-1500
 Q ($$FT^IBCEF(IBIFN)=3)
 ;
