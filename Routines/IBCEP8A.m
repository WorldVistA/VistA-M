IBCEP8A ;ALB/ESG - Functions for provider ID maint ;12/27/2005
 ;;2.0;INTEGRATED BILLING;**320,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
CLIA(IBIFN) ; Default CLIA# for claim
 NEW CLIA,NONVA,DIV,INST
 S CLIA="",IBIFN=+$G(IBIFN)
 S NONVA=+$P($G(^DGCR(399,IBIFN,"U2")),U,10)    ; non-VA facility ptr
 I NONVA S CLIA=$$CLIANVA^IBCEP8(IBIFN) G CLIAX
 ;
 ; retrieve the default VA clia# based on claim data
 S DIV=+$P($G(^DGCR(399,IBIFN,0)),U,22)         ; claim's division
 I 'DIV G CLIAX
 S INST=+$P($G(^DG(40.8,DIV,0)),U,7)            ; inst file pointer
 I 'INST G CLIAX
 S CLIA=$$ID^XUAF4("CLIA",INST)                 ; API for clia#
CLIAX ;
 Q CLIA
 ;
LAB(IBIFN) ; Function determines if LAB type of service is on claim
 ; Claim must be a CMS-1500 claim form type
 NEW LAB,LN,IBXDATA
 S LAB=0
 I $$FT^IBCEF(IBIFN)'=2 G LABX    ;cms-1500 form types only
 D F^IBCEF("N-HCFA 1500 SERVICES (PRINT)",,,IBIFN)
 S LN=0
 F  S LN=$O(IBXDATA(LN)) Q:'LN  I $P(IBXDATA(LN),U,4)=5 S LAB=1 Q
LABX ;
 Q LAB
 ;
CLIAREQ(IBIFN) ; Function determines if the CLIA# is required for claim
 ; Return value=1 Yes, the CLIA# is required; otherwise 0.
 NEW REQ S REQ=0
 I $$FT^IBCEF(IBIFN)'=2 G CLIAREQX        ; cms-1500 claim
 I '$$LAB(IBIFN) G CLIAREQX               ; lab type of service
 ;
 ; this is required for VA facility
 I '$P($G(^DGCR(399,IBIFN,"U2")),U,10) S REQ=1 G CLIAREQX
 ;
 ; for non-VA facility, further check non-VA care type
 ;     Codes 1 and 3 are specifically Non-Lab
 I '$F(".1.3.","."_$P($G(^DGCR(399,IBIFN,"U2")),U,11)_".") S REQ=1
CLIAREQX ;
 Q REQ
 ;
MAMMO(IBIFN,IBMC) ; Function to determine the default mammography certification
 ; number for the claim
 ; Array IBMC is returned if passed by reference
 ;   IBMC = # of associated mammo#'s
 ;   IBMC(n) = [1] coding system or "" for Non-VA Facilities
 ;             [2] mammo cert#
 NEW MAMMO,NONVA,INST,CODSYS,IBMCID,CDSYS
 S MAMMO="",IBIFN=+$G(IBIFN),IBMC=0
 S NONVA=+$P($G(^DGCR(399,IBIFN,"U2")),U,10)    ; non-VA facility ptr
 I NONVA D  G MAMMOX
 . S MAMMO=$P($G(^IBA(355.93,NONVA,0)),U,15) Q:MAMMO=""
 . S IBMC=1,IBMC(1)=""_U_MAMMO
 . Q
 ;
 ; retrieve the default VA mammo# based on claim data
 S INST=+$$SITE^VASITE()                            ; inst file pointer
 I 'INST G MAMMOX
 ;
 ; Kernel API from XU*8*394 to get a list of coding systems
 D LCDSYS^XUAF4(.CDSYS)
 S CODSYS="MAMMO"
 F  S CODSYS=$O(CDSYS(CODSYS)) Q:$E(CODSYS,1,5)'="MAMMO"  D
 . S IBMCID=$$ID^XUAF4(CODSYS,INST) Q:IBMCID=""
 . S IBMC=IBMC+1
 . S IBMC(IBMC)=$P(CODSYS,"-",2)_U_IBMCID
 . I $P(CODSYS,"-",2)="FDA" S MAMMO=IBMCID    ; FDA is default ID#
 . Q
 I IBMC,MAMMO="" S MAMMO=$P(IBMC(1),U,2)
MAMMOX ;
 Q MAMMO
 ;
MAMMODP(IBIFN) ; Procedure to display a listing of default mammo cert#'s
 ; Used during input template on screen 8 for CMS-1500 claims
 NEW IBMC,IBZ
 I $$MAMMO(IBIFN,.IBMC)
 I 'IBMC W !!?3,"No default mammography certification numbers on file.",! G MAMMODPX
 W !!?3,"The Mammography Certification #" W:IBMC>1 "'s"
 W " defined for this " W:$P($G(^DGCR(399,IBIFN,"U2")),U,10) "non-"
 W "VA facility " W:IBMC>1 "are:" W:IBMC'>1 "is:"
 S IBZ=0
 F  S IBZ=$O(IBMC(IBZ)) Q:'IBZ  W !?7,$P(IBMC(IBZ),U,2),?21,$P(IBMC(IBZ),U,1)
 W !?3,"If you enter a different number it will be sent with this claim only."
 I $P($G(^DGCR(399,IBIFN,"U2")),U,10) W !?3,"To change the defined Mammography Certification #, use Prov ID Maint."
 W !
MAMMODPX ;
 Q
 ;
XRAY(IBIFN) ; Function determines if X-RAY type of service is on claim
 ; Claim must be a CMS-1500 claim form type
 NEW XRAY,LN,IBXDATA
 S XRAY=0
 I $$FT^IBCEF(IBIFN)'=2 G XRAYX    ;cms-1500 form types only
 D F^IBCEF("N-HCFA 1500 SERVICES (PRINT)",,,IBIFN)
 S LN=0
 F  S LN=$O(IBXDATA(LN)) Q:'LN  I $P(IBXDATA(LN),U,4)=4 S XRAY=1 Q
XRAYX ;
 Q XRAY
 ;
EIN(IBIFN) ; Function to return the EIN/tax ID for either the VA facility
 ; or the non-VA facility.  Used for SUB-9.
 NEW ID,IBU2,NONVA
 S ID="",IBU2=$G(^DGCR(399,IBIFN,"U2"))
 S NONVA=+$P(IBU2,U,10)                         ; non-VA facility ptr
 I NONVA D  G EINX
 . S ID=$P($G(^IBA(355.93,NONVA,0)),U,9)        ; ID# from file 355.93
 . ;
 . ; if not defined in file 355.93, then use legacy field# 234 in file
 . ; 399 - non-va care id#.  See NONVAID^IBCEF72.
 . I ID="",$P(IBU2,U,12)'="" S ID=$P(IBU2,U,12)
 . Q
 ;
 ; VA facility
 S ID=$P($G(^IBE(350.9,1,1)),U,5)    ; Federal tax id from site params
EINX ;
 Q ID
 ;
BOX324(IBIFN,IBXSAVE,IBXDATA) ; Procedure which further defines and formats
 ; form 1500, box 32, line 4.
 ; *** THIS IS NOT USED FOR THE NEW CMS-1500 CLAIM FORM ***
 ; This is either the facility Tax ID or it is the mammography
 ; certification number.
 ;  Input:  IBIFN, IBXSAVE array (pass by ref), IBXDATA (pass by ref)
 ; Output:  IBXDATA (pass by ref)
 ;
 NEW IBZ
 ;
 ; retrieve the mammo# if it exists into variable IBZ
 D F^IBCEF("N-MAMMOGRAPHY CERT#","IBZ",,IBIFN)
 ;
 ; If the claim is for the main VAMC and there is no mammo# then print
 ; nothing here.  See 364.7 iens# 348, 319, 327 for similar
 I '$G(IBXSAVE("REMOTE")),IBZ="" KILL IBXDATA G BOX32X
 ;
 ; If the mammo# exists, then display that
 I IBZ'="" S IBXDATA="Mammography Cert# "_IBZ G BOX32X
 ;
 ; Otherwise, display the facility tax id
 S IBXDATA="FAC. ID:"_$G(IBXDATA)
BOX32X ;
 KILL IBXSAVE("OFAC"),IBXSAVE("REMOTE")   ; cleanup
 Q
 ;
SUB1OK(IBIFN) ; This function determines if the claim meets the criteria
 ; for being eligible to output a SUB1 segment which is for professional
 ; purchased services.  Must be CMS-1500, non-VA facility, and Fee Basis.
 ;
 NEW OK,IBU2
 S OK=0,IBU2=$G(^DGCR(399,IBIFN,"U2"))
 ;
 I $$FT^IBCEF(IBIFN)'=2 G SX                      ; must be cms-1500
 I '$P(IBU2,U,10) G SX                            ; must be non-VA fac
 I '$F(".1.2.","."_$P(IBU2,U,11)_".") G SX        ; must be FEE services
 ;
 S OK=1    ; all checks passed, OK for SUB1 output
SX ;
 Q OK
 ;
