IBCAPP ;ALB/WCJ - Claims Auto Processing Main Processer;27-AUG-10
 ;;2.0;INTEGRATED BILLING;**432,447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 G AWAY
AWAY Q
 ;
EN(IBIFN,IBORIG,IBPYMT,IBWLF) ;
 ; This is called from tag BULL^IBCNSBL2.  It is the starting point for the claims auto-processing.
 ; Instead of sending a bulletin which started a manual process, the bulletin routine calls this routine
 ; which will evaluate the claim and perform one of three actions.
 ; 1) auto-process the claim to a subsequent payer.
 ; 2) auto-print a claim in case the payer does not want to receive secondary/tertiary claims electronically
 ; 3) put the claim on the new COB Management work list.
 ;
 ;   Input:    IBIFN  --  Pointer to AR (file #430), or Claim (file #399) (same internal number goes to files)
 ;            IBORIG  --  Original amount of the claim
 ;            IBPYMT  --  Total Amount paid on the claim
 ;             IBWLF  --  1 if it should go straight to the work list or 
 ;                        0 if it should be evaluated.
 ;
 N IBREASON,IBX,IBMRANOT,IBERRMSG,IBEOB,IBINS,Z,IB,IBF,IBFT,IBNCN,IBDV,IBREG,IBNCN
 S IBMRANOT=1
 ;
 ; A specific non-human user for all reg 835 EOB filing processes.
 ; Change the DUZ to be this user.
 ; *** Integration Agreement 4129 - Activated on 30-June-2003 ***
 S IBREG=$$IBREG()
 I IBREG>0 NEW DUZ D DUZ^XUP(IBREG)  ; IA#4129
 ;
 ; Check if this is being forced to the work list.  
 I $G(IBWLF) S IBREASON="IB813:CHAMPVA Center or TRICARE Fiscal Intermediary or TRICARE Supplemental policy." D PUTONWL(IBIFN,IBREASON) G ENX   ;IB*2*432
 ;
 I IBPYMT'<IBORIG D WLCK^IBCNSBL2(IBIFN) Q  ; no reason to continue if nothing else owed
 ;
 ; Make sure there is another payer
 I '$P($G(^DGCR(399,IBIFN,"I"_($$COBN^IBCEF(IBIFN)+1))),U,1) D WLCK^IBCNSBL2(IBIFN) G ENX   ;IB*2*432
 ;
 ; stop if the subsequent claim was already created
 I +$P($G(^DGCR(399,IBIFN,"M1")),U,$$COBN^IBCEF(IBIFN)+5) D WLCK^IBCNSBL2(IBIFN) G ENX ;IB*2*432
 ;
 ; stop if the subsequent payer is Medicare.  If there is a non-Medicare tertiary payer, force to worklist
 I $$WNRBILL^IBEFUNC(IBIFN,$$COBN^IBCEF(IBIFN)+1) D  Q
 .I $D(^DGCR(399,IBIFN,"I3")),'$$WNRBILL^IBEFUNC(IBIFN,3) D PUTONWL(IBIFN,"IB814") Q 
 .D WLCK^IBCNSBL2(IBIFN) Q
 ;
 ; check the Commercial Auto Processing criteria
 S IBX=$$CRIT^IBCAPP1(IBIFN,.IBEOB)
 ; 
 ; If it fails the criteria check, put it on the work list
 I '+IBX D PUTONWL(IBIFN,$P(IBX,U,2)) G ENX   ;IB*2*432
 ;
 ; Auto Process this bad boy
 ;
 ; first check that if it's supposed to be printed locally, the printers are defined.
 ; if not, put on the work list
 ; if they are, then fall through 
 S Z=$$COBN^IBCEF(IBIFN)+1
 S IBINS=$$POLICY^IBCEF(IBIFN,1,Z)
 S IBWLF=0
 I $P($G(^DIC(36,IBINS,6)),U,9)=1 D  I IBWLF D PUTONWL(IBIFN,IBREASON) G ENX   ;IB*2*432
 .I $$EOBPRT^IBCAPR()="" S IBWLF=1,IBREASON="IB811:Auto-printer not defined in IB Site Parameters" Q
 .I $$MRAPRT^IBCAPR()="" S IBWLF=1,IBREASON="IB811:Auto-printer not defined in IB Site Parameters" Q
 .S IB=$$FT^IBCU3(IBIFN) ; form type ien (2 or 3)
 .I "^2^3^"'[(U_IB_U) S IBWLF=1,IBREASON="IB810:No Form Type defined" Q
 .S IBFT=$$FTN^IBCU3(IB) ; form type name
 .S IBF=$P($G(^IBE(353,+IB,2)),U,8)
 .S:IBF="" IBF=IB ;Forces the use of the output formatter to print bills
 .; get default CMS or UB printer (based on claim form type)
 .S IBDV=$S(IB=2:$$CMS1500^IBCAPR1(),1:$$UB4PRT^IBCAPR1())
 .I IBDV="" S IBWLF=1,IBREASON="IB811:Auto-printer not defined in IB Site Parameters" Q
 I $G(IBREASON)]"" D PUTONWL(IBIFN,IBREASON) G ENX   ;IB*2*432
 ;
 ; create the new claim
 S IBNCN=""   ; Initialize New Claim Number
 D AUTOCOB^IBCEMQA(IBIFN,IBEOB,.IBERRMSG,IBMRANOT,.IBNCN)
 ;
 ; make sure everything was cool with creating the new claim.
 I $G(IBERRMSG)]""!('+$G(IBNCN)) S IBREASON="IB812:Failed AUTOCOB Generation" D PUTONWL(IBIFN,IBREASON) G ENX   ;IB*2*432
 ;
 ; If it's to be auto printed, set force to local print flag on new claim 
 S IBINS=$$POLICY^IBCEF(IBNCN,1,$$COBN^IBCEF(IBNCN))
 ; set field 35 on original claim to indicate subsequent claim was auto-created IB*2.0*447
 I $P($G(^DIC(36,IBINS,6)),U,9)=1 D FORCEPRT(IBNCN),AUTOPRC($G(IBIFN),2)
 D:$P($G(^DIC(36,IBINS,6)),U,9)'=1 AUTOPRC($G(IBIFN),3)
 ;
 ; authorize the new claim
 D AUTH^IBCEMQA(IBNCN,.IBERRMSG,IBMRANOT)
 ;
 ; If AUTH error occurred, file the automatic bill generation failure message
 I $G(IBERRMSG)]"" D AUTOMSG^IBCESRV3(IBEOB,IBERRMSG) G ENX
 ;
 ; If local print, then print it
 I $P($G(^DIC(36,IBINS,6)),U,9)=1 D STFLP^IBCAPR1(IBNCN)
 ;
ENX   ;Quit and Cleanup of Main Entry Point, added with IB*2*432
 ;
 ; DBIA #10111: Allows FM read access of ^XMB(3.8,D0,0) using DIC.
 S DIC="^XMB(3.8,",DIC(0)="QM",X="IB DEV TEAM" D ^DIC
 ;
 Q
 ;
PUTONWL(IBIFN,IBREASON) ; Put a claim on the worklist
 ; IBIFN - internal claim number
 ; IBREASON - reason why this is being put on the worklist (error code:text)
 ;
 N DA,DIE,DR
 S DA=IBIFN
 S DIE="^DGCR(399,"
 S DR="35///1"              ; place on the worklist
 S DR=DR_";"_"36///"_$P(IBREASON,":")        ; why placed on worklist
 D ^DIE
 Q
 ;
AUTOPRC(IBIFN,IBAP) ; record that a claim was auto-processed IB*2.0*447
 ; IBIFN - internal claim number
 ; IBAP - 2 = AUTO LOCAL PRINT, 3 = AUTO EDI
 ;
 N DA,DIE,DR
 Q:IBIFN=""
 Q:IBAP=""
 S DA=IBIFN
 S DIE="^DGCR(399,"
 S DR="35///"_IBAP              ; UPDATE AUTO-PROCESS FIELD
 D ^DIE
 Q
 ;
FORCEPRT(IBIFN) ; set force to local print flag in claim
 ; IBIFN - internal claim number 
 ;
 N DA,DIE,DR
 S DA=IBIFN
 S DIE="^DGCR(399,"
 S DR="27///1"      ; Force Local Print
 D ^DIE
 Q
 ;
IBREG() ; Returns IEN (Internal Entry Number) from file #200 for
 ; the Bill Authorizer of acceptable regular (non MRA) secondary claims,
 ; namely, AUTHORIZER,IB REG
 ;
 ; Output:    -1   if record not on file
 ;            IEN  if record is on file
 ;
 N DIC,X,Y
 S DIC(0)="MO",DIC="^VA(200,",X="AUTHORIZER,IB REG"
 ; call FM lookup utility
 D ^DIC
 ; if record is already on file, return IEN
 ; else  return -1
 Q +Y
