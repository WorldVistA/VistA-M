IBCBB ;ALB/AAS - EDIT CHECK ROUTINE TO BE INVOKED BEFORE ALL BILL APPROVAL ACTIONS ;2-NOV-89
 ;;2.0;INTEGRATED BILLING;**80,51,137,288,327,361,371,377,400,432,461,547,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRBB
 ;
 ;IBNDn = IBND(n) = ^ib(399,n)
 ;RETURNS:
 ;IBER=fields with errors separated by semi-colons
 ;PRCASV("OKAY")=1 if iber="" and $D(prcasv("array")) compete
 ;
GVAR ;set up variables for mccr
 Q:'$D(IBIFN)  F I=0,"M","U","U1","S","MP","TX","UF3","UF31","U2" S @("IBND"_I)=$G(^DGCR(399,IBIFN,I))
 S IBBNO=$P(IBND0,"^"),DFN=$P(IBND0,"^",2),IBEVDT=$P(IBND0,"^",3)
 S IBLOC=$P(IBND0,"^",4),IBCL=$P(IBND0,"^",5),IBTF=$P(IBND0,"^",6)
 S IBAT=$P(IBND0,"^",7),IBWHO=$P(IBND0,"^",11),IBST=$P(IBND0,"^",13),IBFT=$P(IBND0,"^",19)
 S IBFDT=$P(IBNDU,"^",1),IBTDT=$P(IBNDU,"^",2)
 S IBTC=$P(IBNDU1,"^",1),IBFY=$P(IBNDU1,"^",9),IBFYC=$P(IBNDU1,"^",10)
 S IBEU=$P(IBNDS,"^",2),IBRU=$P(IBNDS,"^",5),IBAU=$P(IBNDS,"^",8)
 S IBTOB=$$TOB(IBND0),IBTOB12=$E(IBTOB,1,2)
 K ^TMP($J,"BILL-WARN")
 Q
 ;
EN ;Entry to check for errors
 N IBQ,IBXERR,IBXDATA,IBXSAVE,IBZPRC92,IBQUIT,IBISEQ,IDDATA,IBFOR,IBC,IBDX,IBDX1
 I $D(IBFL) N IBFL
 K ^TMP($J)
 W !
 S IBER="" D GVAR I '$D(IBND0) S IBER=-1 Q
 ;
 ;patient in patient file
 I DFN="" S IBER=IBER_"IB057;"
 I DFN]"",'$D(^DPT(DFN)) S IBER=IBER_"IB057;"
 ;IB*2.0*623;check date fields for validity;begin
 I $$DTCK($$GET1^DIQ(2,DFN_",",.03,"I")) S IBER=IBER_"IB368;"
 I $$DTCK($$GET1^DIQ(2,DFN_",",.351,"I")) S IBER=IBER_"IB369;"
 S IBDX=0 F  S IBDX=$O(^DPT(DFN,.312,IBDX)) Q:'IBDX  D
 . S IBDX1=$$GET1^DIQ(2.312,IBDX_","_DFN_",",3.01,"I")
 . I $$DTCK(IBDX1) S IBER=IBER_"IB366;"
 . Q
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",151,"I")) S IBER=IBER_"IB370;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",152,"I")) S IBER=IBER_"IB371;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",166,"I")) S IBER=IBER_"IB372;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",167,"I")) S IBER=IBER_"IB373;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",246,"I")) S IBER=IBER_"IB374;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",245,"I")) S IBER=IBER_"IB375;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",247,"I")) S IBER=IBER_"IB376;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",263,"I")) S IBER=IBER_"IB377;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",264,"I")) S IBER=IBER_"IB378;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",282,"I")) S IBER=IBER_"IB379;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",283,"I")) S IBER=IBER_"IB380;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",262,"I")) S IBER=IBER_"IB381;"
 I $$DTCK($$GET1^DIQ(399,IBIFN_",",237,"I")) S IBER=IBER_"IB382;"
 ;
 ;end;IB*2.0*623
 ;
 ;Event date in correct format
 I IBEVDT="" S IBER=IBER_"IB049;"
 I IBEVDT]"",IBEVDT'?7N&(IBEVDT'?7N1".".N) S IBER=IBER_"IB049;"
 ;JWS;IB*2.0*623;add check for event date
 I IBER'["IB049",$$DTCK(IBEVDT) S IBER=IBER_"IB049;"
 ;
 ;Rate Type
 I IBAT="" S IBER=IBER_"IB059;"
 I IBAT]"",'$D(^DGCR(399.3,IBAT,0)) S IBER=IBER_"IB059;"
 I IBAT]"",$D(^DGCR(399.3,IBAT,0)),'$P(^(0),"^",6) S IBER=IBER_"IB059;",IBAT=""
 I IBAT]"",$P($G(^DGCR(399.3,IBAT,0)),"^",6) S IBARTP=$P($$CATN^PRCAFN($P(^DGCR(399.3,IBAT,0),"^",6)),"^",3)
 ;Check that AR category expects same debtor as defined in who's responsible.
 I $D(IBARTP),IBWHO="i"&(IBARTP'="T")!(IBWHO="p"&("PC"'[IBARTP))!(IBWHO="o"&(IBARTP'="N")) S IBER=IBER_"IB058;"
 ;
 ;Who's Responsible
 I IBWHO=""!($L(IBWHO)>1)!("iop"'[IBWHO) S IBER=IBER_"IB065;"
 S IBMRA=$S($$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN)):$$TXMT^IBCEF4(IBIFN)>0,1:0)
 ;  MCR will not reimburse is only valid if there is subsequent insurance
 ;   that will reimburse
 I IBWHO="i" D
 . ;JWS;IB*2.0*592;US1109; If Dental and Plan Coverage Limitation is NO skip; IA# 3820
 . I $$FT^IBCEF(IBIFN)=7 D
 .. N INSONBIL,LOOP
 .. ;JWS;IB*2.0*592;; only want to check insurance on the bill at this point
 .. F LOOP="I1","I2","I3" I $D(^DGCR(399,IBIFN,LOOP)) K INSONBIL S INSONBIL(+^(LOOP))="" I '$$PTCOV^IBCNSU3(DFN,$P($G(^DGCR(399,IBIFN,0)),"^",3),"DENTAL",,.INSONBIL),IBER'["IB362" S IBER=IBER_"IB362;"
 . I IBMRA D  Q
 .. ;JWS;IB*2.0*592;Do not allow to bill Dental to Medicare WNR
 .. I $$FT^IBCEF(IBIFN)=7,'$F(IBER,"IB359;") S IBER=IBER_"IB359;"
 .. N Z,IBZ
 .. S IBZ=0
 .. F Z=$$COBN^IBCEF(IBIFN):1:3 I $D(^DGCR(399,IBIFN,"I"_(Z+1))),$P($G(^DIC(36,+$G(^DGCR(399,IBIFN,"I"_(Z+1))),0)),U,2)'="N" S IBZ=1 Q
 .. I 'IBZ S IBER=IBER_"IB054;" D WARN^IBCBB11("A valid claim for MEDICARE WNR needs subsequent ins. that will reimburse")
 . I $$COB^IBCEF(IBIFN)="S",$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN))=1,$D(^DGCR(399,IBIFN,"I3")) Q
 . I $S('IBNDMP:1,1:$P(IBNDMP,U,2)'=$$BPP^IBCNS2(IBIFN,1)) S IBER=IBER_"IB054;"
 I IBWHO="o",'$P(IBNDM,"^",11) S IBER=IBER_"IB053;"
 ;
 ; Outpatient Statement dates can not span the ICD-10 activation date
 I IBCL>2,$$ICD10S^IBCU4(IBFDT,IBTDT) S IBER=IBER_"IB354;"
 ;
 ; All bill ICD codes must match Code Version on Statement To Date IB356
 D ICD10V^IBCBB0(IBIFN)
 ;
 ; Billing Provider check - IB*2*400
 D BP^IBCBB0(IBIFN)
 ;
 ; Pay-to Provider check - IB*2*400
 D PAYTO^IBCBB0(IBIFN)
 ;
 ; All insurance subscribers must have a birth date on file
 ;  - 11/10/04 - IB*2.0*288
 ;  - 12/14/06 - IB*2.0*361 - must have INSURED'S SEX too
 ; IB error codes
 ;    IB221 - Primary insurance subscriber missing date of birth
 ;    IB222 - Secondary insurance subscriber missing date of birth
 ;    IB223 - Tertiary insurance subscriber missing date of birth
 ;    IB261 - Primary insurance subscriber is missing INSURED'S SEX
 ;    IB262 - Secondary insurance subscriber is missing INSURED'S SEX
 ;    IB263 - Tertiary insurance subscriber is missing INSURED'S SEX
 ;
 F IBISEQ=1:1:3 D
 . I '$P($G(^DGCR(399,IBIFN,"I"_IBISEQ)),U,1) Q   ; no insurance here
 . K ^UTILITY("VADM",$J),^UTILITY("VAPA",$J)
 . S IDDATA=$$INSDEM^IBCEF(IBIFN,IBISEQ)
 . K ^UTILITY("VADM",$J),^UTILITY("VAPA",$J)
 . ;
 . I '$P(IDDATA,U,1) D ERR(221)   ; birth date missing
 . ;IB*2.0*623;JWS;date validation
 . I $$DTCK($P(IDDATA,U)) S IBER=IBER_"IB367;"
 . ;
 . I "^M^F^"'[(U_$P(IDDATA,U,2)_U) D ERR(261)  ; sex missing
 . ;
 . ; IB*2*371 - esg - check for other missing insurance pieces
 . ; check insured's name, primary ID#, pt. relationship to insured,
 . ; and subscriber address data  
 . N INNAME,SUBID,PTREL,SFA,CAS,LN,FN
 . ;
 . ;          IB273 - Primary Insurance name of insured missing
 . ;          IB274 - Secondary Insurance name of insured missing
 . ;          IB275 - Tertiary Insurance name of insured missing
 . S INNAME=$$POLICY^IBCEF(IBIFN,17,IBISEQ)
 . S LN=$P(INNAME,",",1),FN=$P(INNAME,",",2)   ; last name,first name
 . S LN=$$NOPUNCT^IBCEF(LN,1)
 . S FN=$$NOPUNCT^IBCEF(FN,1)
 . ; ib*2.0*547 - subscriber only needs last name
 . ;I LN=""!(FN="") D ERR(273)   ; name of insured missing or invalid
 . I LN="" D ERR(273)   ; name of insured missing or invalid
 . S LN=$$NAME^IBCEFG1(INNAME)  ; additional name checks
 . S FN=$P(LN,U,2)
 . S LN=$P(LN,U,1)
 . ;I LN=""!(FN="") D ERR(273)   ; name of insured missing or invalid
 . I LN="" D ERR(273)   ; name of insured missing or invalid
 . ;
 . ;          IB276 - Primary Insurance subscriber ID missing
 . ;          IB277 - Secondary Insurance subscriber ID missing
 . ;          IB278 - Tertiary Insurance subscriber ID missing
 . S SUBID=$$NOPUNCT^IBCEF($$POLICY^IBCEF(IBIFN,2,IBISEQ),1)
 . I SUBID="" D ERR(276)     ; subscriber ID# missing
 . ;
 . ;          IB279 - Primary Insurance missing pt relationship
 . ;          IB280 - Secondary Insurance missing pt relationship
 . ;          IB281 - Tertiary Insurance missing pt relationship
 . S PTREL=$$POLICY^IBCEF(IBIFN,16,IBISEQ)
 . I PTREL="" D ERR(279)      ; missing patient relationship to insured
 . ;
 . ; subscriber address section
 . S SFA=$$INSADDR^IBCEF(IBIFN,IBISEQ)     ; full address all pieces
 . S CAS=$$NOPUNCT^IBCEF($P(SFA,U,2,5),1)  ; string city,st,zip,addr1
 . ;
 . ;          IB282 - Primary Insurance address line 1 missing
 . ;          IB283 - Secondary Insurance address line 1 missing
 . ;          IB284 - Tertiary Insurance address line 1 missing
 . I $$NOPUNCT^IBCEF($P(SFA,U,5),1)="" D   ; address line 1 is blank
 .. ; pat=subscriber and current insurance - address is required
 .. I +PTREL=1,IBISEQ=$$COBN^IBCEF(IBIFN) D ERR(282) Q
 .. ; if any part of the address is there, then all fields are required
 .. I CAS'="" D ERR(282) Q
 .. Q
 . ;
 . ;          IB285 - Primary Insurance city missing
 . ;          IB286 - Secondary Insurance city missing
 . ;          IB287 - Tertiary Insurance city missing
 . I $$NOPUNCT^IBCEF($P(SFA,U,2),1)="" D   ; city is blank
 .. ; pat=subscriber and current insurance - address is required
 .. I +PTREL=1,IBISEQ=$$COBN^IBCEF(IBIFN) D ERR(285) Q
 .. ; if any part of the address is there, then all fields are required
 .. I CAS'="" D ERR(285) Q
 .. Q
 . ;
 . ;          IB288 - Primary Insurance state missing
 . ;          IB289 - Secondary Insurance state missing
 . ;          IB290 - Tertiary Insurance state missing
 . I $$NOPUNCT^IBCEF($P(SFA,U,3),1)="" D   ; state is blank
 .. ; pat=subscriber and current insurance - address is required
 .. I +PTREL=1,IBISEQ=$$COBN^IBCEF(IBIFN) D ERR(288) Q
 .. ; if any part of the address is there, then all fields are required
 .. I CAS'="" D ERR(288) Q
 .. Q
 . ;
 . ;          IB291 - Primary Insurance zipcode missing
 . ;          IB292 - Secondary Insurance zipcode missing
 . ;          IB293 - Tertiary Insurance zipcode missing
 . I $$NOPUNCT^IBCEF($P(SFA,U,4),1)="" D   ; zipcode is blank
 .. ; pat=subscriber and current insurance - address is required
 .. I +PTREL=1,IBISEQ=$$COBN^IBCEF(IBIFN) D ERR(291) Q
 .. ; if any part of the address is there, then all fields are required
 .. I CAS'="" D ERR(291) Q
 .. Q
 . ;
 . Q
 ;
 ; esg - IB*2*371 - check patient address fields
 K ^UTILITY("VAPA",$J)
 ;
 S IBFOR=0                              ; foreign address flag
 S IBC=+$$PTADDR^IBCEF(IBIFN,25)        ; country code ien
 I IBC D
 . N CODE
 . S CODE=$$GET1^DIQ(779.004,IBC,.01)   ; .01 code field file 779.004
 . I CODE'="",CODE'="USA" S IBFOR=1     ; foreign country exists
 . Q
 ;
 I $$NOPUNCT^IBCEF($$PTADDR^IBCEF(IBIFN,1),1)="" S IBER=IBER_"IB269;"
 I $$NOPUNCT^IBCEF($$PTADDR^IBCEF(IBIFN,4),1)="" S IBER=IBER_"IB270;"
 I $$NOPUNCT^IBCEF($$PTADDR^IBCEF(IBIFN,5),1)="",'IBFOR S IBER=IBER_"IB271;"
 I $$NOPUNCT^IBCEF($$PTADDR^IBCEF(IBIFN,11),1)="",'IBFOR S IBER=IBER_"IB272;"
 K ^UTILITY("VAPA",$J)
 ;
 D PAYERADD^IBCBB0(IBIFN)     ; check the payer addresses
 D ^IBCBB1
 Q
 ; The remaining code below is being removed with Patch IB*2.0*432.
 ;
 ; esg - 9/20/07 - IB patch 371 - prevent EDI transmission for 3 payer
 ;       claims for all but the first payer.  To be removed when Emdeon
 ;       and FSC are able to deal with these.
 ;
 I +$G(^DGCR(399,IBIFN,"I2")),+$G(^DGCR(399,IBIFN,"I3")),$$TXMT^IBCEF4(IBIFN) D
 . ; for MRA request claims, make sure the MRA secondary claim is forced to print
 . I $$REQMRA^IBEFUNC(IBIFN) D  Q
 .. I '$P($G(^DGCR(399,IBIFN,"TX")),U,9) S IBER=IBER_"IB146;"
 .. Q
 . ;
 . I $$COBN^IBCEF(IBIFN)=1 Q   ; primary payer sequence claims are OK
 . ;
 . ; But claims with a payer sequence of 2 or 3 need to print locally
 . S IBER=IBER_"IB147;"
 . Q
 ;
 Q
 ;
EDIT(IBIFN) ; Run edits from within the billing edit screens
 N IBVIEW,IBDISP,IBNOFIX,DIR,X,Y
 S (IBNOFIX,IBVIEW,IBDISP)=1
 D EDITS^IBCB2
 W ! S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
 Q
 ;
TOB(IBND0) ;
 ; IBND0 = the 0-node of the bill (file 399)
 Q ($P(IBND0,U,24)_$P($G(^DGCR(399.1,+$P(IBND0,U,25),0)),U,2)_$P(IBND0,U,26))
 ;
ERR(Z) ; update IBER variable from the above insurance checks
 ; Z is the IB error code# for the primary insurance error
 N IBERRNO
 S IBERRNO="IB"_(Z+IBISEQ-1)
 I IBER[IBERRNO Q
 S IBER=IBER_IBERRNO_";"
 Q
 ;
DTCK(DATE) ; IB*2.0*623 - check for valid date
 I DATE="" Q 0
 S X=DATE D H^%DTC
 I %Y=-1 Q 1
 Q 0
 ;
