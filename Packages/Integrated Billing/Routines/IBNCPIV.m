IBNCPIV ;ALB/ESG - Manual Rx Eligibility Verification ;23-SEP-2010
 ;;2.0;INTEGRATED BILLING;**435,452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to EN^BPSNCPD9 supported by IA# 5576
 ; Reference to PID^VADPT6 supported by IA# 10062
 ; Reference to DT^DICRW supported by IA# 10005
 ;
 Q
 ;
EN ; -- main entry point for IBNCPDP INS ELIG VER INQ
 N IBNCPIVD,DFN
 D DT^DICRW
 S IBNCPIVD=DT      ; first time in compile Active Rx ins as of today
 D EN^VALM("IBNCPDP INS ELIG VER INQ")
 Q
 ;
HDR ; -- header code
 N VA,NAME
 D PID^VADPT6
 S NAME=$P($G(^DPT($G(DFN),0)),U,1)
 S VALMHDR(1)="Perform Rx Eligibility Insurance Inquiry"
 S VALMHDR(2)="   Patient: "_$E(NAME,1,20)_"  ("_$E(NAME)_$G(VA("BID"))_")"
 S VALMHDR(3)="   Showing: All Insurance Policies on File"
 I $G(IBNCPIVD) S VALMHDR(3)="   Showing: Active Rx Policies as of Effective Date "_$$FMTE^XLFDT(IBNCPIVD,"2Z")
 S VALMHDR(4)=" "
 I +$$BUFFER^IBCNBU1($G(DFN)) S VALMHDR(4)="    Buffer: *** Patient has Insurance Buffer Records ***"
 Q
 ;
INIT ; Build the list of valid insurance policies
 D INIT^IBCNSM4
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBNSM",$J),^TMP("IBNSMDX",$J)
 D CLEAN^VALM10
 Q
 ;
SEND ; send the ELIG inquiry
 N VALMY,IBDATA,IBRES,IBX,IBY,IBPPOL,INSIEN,INSNM,GENERR,IBPL,IBCDFN,EPHPLAN,IBSTL,LIST,G,IBSTA,TXT,DEFDT
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,DIC,LOCKFLG,IBREL,IBPER
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")    ; user selection - 1 entry from the list
 I '$D(VALMY) G SENDX
 S IBX=$O(VALMY(0)) I 'IBX G SENDX
 S IBPPOL=$G(^TMP("IBNSMDX",$J,+$O(^TMP("IBNSM",$J,"IDX",IBX,0))))
 I IBPPOL="" W !!,$T(+0)_" - System error - policy data not found!" D PAUSE^VALM1 G SENDX
 S INSIEN=+$P(IBPPOL,U,5)                ; file 36 ien
 S INSNM=$P($G(^DIC(36,INSIEN,0)),U,1)   ; ins company name
 S GENERR="Unable to submit Eligibility Verification Inquiry to "_INSNM_"."
 S IBPL=+$P(IBPPOL,U,22)                 ; plan file 355.3 ien
 I 'IBPL W !!,GENERR,!,"This policy has no plan." D PAUSE^VALM1 G SENDX
 S IBDATA("PLAN")=IBPL                   ; plan file 355.3 ien
 S IBCDFN=+$P(IBPPOL,U,4)                ; subfile 2.312 ien
 ;
 ; lock check
 L +^IBDPTL(DFN,IBCDFN):$G(DILOCKTM,3)
 E  W !!,GENERR,!,"Another user is currently processing the same patient and policy!" D PAUSE^VALM1 G SENDX
 S LOCKFLG=1
 ;
 S EPHPLAN=+$P($G(^IBA(355.3,IBPL,6)),U,1)   ; epharmacy plan ien
 I 'EPHPLAN W !!,GENERR,!,"This policy's plan is not linked with an ePharmacy plan." D PAUSE^VALM1 G SENDX
 ;
 ; scan for any other errors and display them all
 K IBY D STCHK^IBCNRU1(EPHPLAN,.IBY,1)
 I $E($G(IBY(1)))'="A" D  G SENDX
 . S IBSTL=$G(IBY(6))         ; list of error msg code#'s
 . K LIST
 . D STATAR^IBCNRU1(.LIST)    ; build the list of error messages
 . W !!,GENERR
 . F G=1:1:$L(IBSTL,",") S IBSTA=+$P(IBSTL,",",G),TXT=$G(LIST(IBSTA)) I TXT'="" W !,TXT
 . D PAUSE^VALM1
 . Q
 ;
 ; Ask for Effective Date for the ELIG transmission
 S DEFDT=$G(IBNCPIVD)
 I 'DEFDT S DEFDT=DT   ; default date
 S DIR(0)="D"
 S DIR("A")="Effective Date"
 S DIR("?")="Enter the Date for which to perform the Eligibility Verification check."
 S DIR("B")=$$FMTE^XLFDT(DEFDT,"2Z")
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!('Y) G SENDX
 ;
 ; check for pharmacy coverage as of this date
 I '$$PLCOV^IBCNSU3(IBPL,Y,3) W !!,GENERR,!,"This policy has no Active Pharmacy Coverage on this date." D PAUSE^VALM1 G SENDX
 S IBDATA("DOS")=Y
 ;
 ; Ask for Relationship Code
 S IBREL=+$P($G(^DPT(DFN,.312,IBCDFN,0)),U,16)    ; pt. relationship to insured (2.312,16)
 I IBREL'<4 S IBREL=4
 S DIC=9002313.19
 S DIC(0)="AEQZ"
 S DIC("A")="Relationship Code: "
 S DIC("B")=IBREL
 W ! D ^DIC K DIC
 I $D(DTOUT)!$D(DUOUT)!(Y'>0) G SENDX
 S IBDATA("REL CODE")=$P(Y,U,2)
 ;
 ; Ask for Person Code
 S IBPER=IBDATA("REL CODE")
 S IBPER=$S(IBPER:0_IBPER,1:"01")    ; base the default value on the selected relationship code
 S DIR(0)="FO^1:3"
 S DIR("A")="Person Code"
 S DIR("?",1)="Enter the Specific Person Code Assigned to the Patient by the Payer."
 S DIR("?",2)="This is a code assigned to a specific person within a family."
 S DIR("?",3)=" "
 S DIR("?",4)="Enrollment Standard Examples"
 S DIR("?",5)="----------------------------"
 S DIR("?",6)="001=Cardholder"
 S DIR("?",7)="002=Spouse"
 S DIR("?")="003-999=Dependents and Others (including second spouses, etc.)"
 S DIR("B")=IBPER
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G SENDX
 S IBDATA("PERSON CODE")=Y
 ;
 ; call BPS to send the elig transaction
 S IBRES=$$EN^BPSNCPD9(DFN,.IBDATA)
 ;
 ; success!
 I +IBRES W !!,"Eligibility Verification Inquiry sent to "_INSNM_".",!,$P(IBRES,U,2) D PAUSE^VALM1 G SENDX
 ;
 ; error
 W !!,"Failure to submit Eligibility Verification Inquiry to "_INSNM_"."
 W !,$P(IBRES,U,2)
 D PAUSE^VALM1
 ;
SENDX ;
 I $G(LOCKFLG) L -^IBDPTL(DFN,IBCDFN)    ; unlock
 S VALMBCK="R"
 Q
 ;
CP ; Change Patient
 N VALMQUIT,IBDFN
 D FULL^VALM1
 S IBDFN=$G(DFN)
 W ! D PAT^IBCNSM
 I $D(VALMQUIT) S DFN=IBDFN
 I IBDFN=$G(DFN) G CPX   ; no changes
 K VALMHDR
 D INIT
CPX ;
 S VALMBCK="R"
 Q
 ;
CHGD ; change the date for the screen display
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,ORIG,DEFDT
 S (ORIG,DEFDT)=$G(IBNCPIVD)     ; save the original value coming in
 I 'DEFDT S DEFDT=DT             ; always have a default date
 D FULL^VALM1
 S DIR(0)="D"
 S DIR("A")="Enter the Effective Date"
 S DIR("B")=$$FMTE^XLFDT(DEFDT,"2Z")
 S DIR("?",1)="Please enter the effective date to be used in order to look-up active"
 S DIR("?",2)="pharmacy insurance policies as of this effective date.  The effective"
 S DIR("?",3)="date used for the current screen display is found in the header of"
 S DIR("?")="this screen unless ALL insurance policies are displayed."
 W ! D ^DIR K DIR
 I Y S IBNCPIVD=Y
 I ORIG=$G(IBNCPIVD) G CHGDX   ; no changes to date
 K VALMHDR
 D INIT
CHGDX ;
 S VALMBCK="R"
 Q
 ;
TOGGLE ; toggle the display between all ins policies and Rx only policies
 ;
 N CASE,TEXT,PROMPT,X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 D FULL^VALM1
 ;
 I $G(IBNCPIVD) D
 . S CASE=1
 . S TEXT="The screen is now showing Active Rx Insurance as of "_$$FMTE^XLFDT(IBNCPIVD,"2Z")_"."
 . S PROMPT="Do you want to display ALL insurance on file"
 . Q
 ;
 I '$G(IBNCPIVD) D
 . S CASE=2
 . S TEXT="The screen is now showing ALL insurance on file."
 . S PROMPT="Do you want to display only Active Rx Insurance"
 . Q
 ;
 S DIR(0)="Y"
 S DIR("A")=PROMPT
 S DIR("A",1)=TEXT
 S DIR("B")="YES"
 W ! D ^DIR K DIR
 I 'Y G TOGGX        ; user said NO, no changes so get out
 ;
 I CASE=1 K IBNCPIVD,VALMHDR D INIT G TOGGX     ; change to ALL insurance/rebuild list
 ;
 D CHGD    ; change to Active Rx only ins/get effective date & rebuild list
 ;
TOGGX ;
 S VALMBCK="R"
 Q
 ;
