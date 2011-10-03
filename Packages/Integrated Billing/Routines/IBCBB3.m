IBCBB3 ;ALB/TMP - CONTINUATION OF EDIT CHECKS ROUTINE (MEDICARE) ;06/23/98
 ;;2.0;INTEGRATED BILLING;**51,137,155,349,371,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EDITMRA(IBQUIT,IBER,IBIFN,IBFT) ;
 ; Requires execution of GVAR^IBCBB, IBIFN defined
 ; File IB ERROR (350.8) contains error codes/text
 ;
 N IBMRATYP,Z,IBZP,IBZP1,IBOK
 S IBQUIT=0 ;Flag to say we have too many errors - quit edits
 ;
 S IBMRATYP=$$MRATYPE^IBEFUNC(IBIFN,"C")
 ;
 I IBFT=3 D
 . D PARTA
 ;
 I IBFT=2 D PARTB^IBCBB9
 ;
 K IBXDATA D F^IBCEF("N-ADMITTING DIAGNOSIS",,,IBIFN)
 ; Req. for UB-04 type of bills 11x!18x
 I $G(IBXDATA)="",IBFT=3 D  Q:IBQUIT
 . N Z
 . I "^11^18^"[(U_IBTOB12_U) S IBQUIT=$$IBER(.IBER,231) Q
 . I $$INPAT^IBCEF(IBIFN,1) S Z="Admitting Diagnosis may be required by payer, please verify" D WARN^IBCBB11(Z)
 ;
 D GETPRV^IBCEU(IBIFN,"2,3,4",.Z)
 S IBOK=1,Z=0,IBZP=U F  S Z=$O(Z(Z)) Q:'Z  S:$S($P($G(Z(Z,1)),U,3)["VA(200":1,1:0) IBZP=IBZP_+$P(Z(Z,1),U,3)_U
 D ALLPROC^IBCVA1(IBIFN,.IBZP1)
 S Z=0 F  S Z=$O(IBZP1(Z)) Q:'Z  I $P(IBZP1(Z),U,18),IBZP'[(U_$P(IBZP1(Z),U,18)_U) S IBOK=0 Q
 I 'IBOK D WARN^IBCBB11("At least one provider on a procedure does not match your "_$S(IBFT=2:"render",1:"attend")_"ing or operating provider")
 I IBFT=2 D EN^IBCBB2
 ; edit checks for UB-04 (institutional) forms
 I IBFT=3 D EN^IBCBB21(.IBZPRC92)
 ;
 Q
 ;
PARTA ; MEDICARE specific edit checks for PART A claims (UB-04 formats)
 ;
 N IBI,IBJ,IBX,IBCTYP,VADM,VAPA,IBSTOP,IBDXC,IBDXARY,IBPR,IBLABS,REQMRA
 N IBS,IBTUNIT,IBCAGE,IBREV1,IBOCCS,IBOCSDT,IBVALCD,IBOCCD,IBNOPR
 N IBCCARY1,IBPATST,IBZADMIT,IBZDISCH,IBXIEN,IBXERR,IBXDATA,IBOCSP
 N IBCOV,IBNCOV,IBREVC,IBREVDUP,IBBCPT,IBREVC12,IBREVTOT,IBECAT,IBINC
 ;
 ; Medicare is the current payer, but no diagnosis codes
 I $$WNRBILL^IBEFUNC(IBIFN) D SET^IBCSC4D(IBIFN,.IBDX,.IBDXO) I '$P(IBDX,U,2) S IBQUIT=$$IBER(.IBER,120) Q:IBQUIT
 ;
 ; Type of Bill must be three digits
 I IBTOB'?3N S X=$$IBER(.IBER,103) Q
 ;
 ; Covered Days
 S IBCTYP=0
 S IBCOV=$P(IBNDU2,U,2),IBNCOV=$P(IBNDU2,U,3)
 ;
 ; If interim bill, covered days must not be greater than 60
 I "23"[$E(IBTOB,3),IBCOV>60 S IBQUIT=$$IBER(.IBER,"096") Q:IBQUIT
 ;
 ; I bill type is 11x or 18x or 21x then we need covered days
 I "^11^18^21^"[(U_IBTOB12_U) S IBCTYP=1 I IBCOV="" S IBQUIT=$$IBER(.IBER,106) Q:IBQUIT
 ;
 S (IBI,IBJ)=0
 K IBXDATA D F^IBCEF("N-CONDITION CODES",,,IBIFN)
 ; Re-sort the condition codes by code
 S IBI=0 F  S IBI=$O(IBXDATA(IBI)) Q:'IBI  S IBCCARY1($P(IBXDATA(IBI),U))=""
 ;
 ; for condition code 40, covered days must be 0
 I $D(IBCCARY1(40)),IBCOV'=0 S IBQUIT=$$IBER(.IBER,107) Q:IBQUIT
 ;
 ; cov days+non=to date -from date unless the patient status = 30 (still
 ;  pt) or outpatient or if the to date and from date are same then add 1
 S IBPATST="",IBX=$P(IBNDU,U,12),IBPATST=$P($G(^DGCR(399.1,+IBX,0)),U,2)
 S IBINC=$S(IBPATST=30!(IBFDT=IBTDT):1,1:0)
 I $$INPAT^IBCEF(IBIFN,1),(IBCOV+IBNCOV)'=($$FMDIFF^XLFDT(IBTDT,IBFDT)+IBINC) S IBQUIT=$$IBER(.IBER,108) Q:IBQUIT
 ;
 ; if covered days >100 and type of bill is 21x or 18x error
 I IBCOV>100,(IBTOB12=18!(IBTOB12=21)) S IBQUIT=$$IBER(.IBER,109) Q:IBQUIT
 ;
 S (IBJ,IBTUNIT,IBS,IBREVTOT("AC"),IBREVTOT("AI"),IBREVTOT("AO"),IBREVTOT)=0
 ;
 K IBXDATA D F^IBCEF("N-UB-04 SERVICE LINE (EDI)",,,IBIFN) ;Get rev codes
 ;
 ; Re-sort the revenue codes by code
 ;>> IBREV1(rev code,x)=Rev code^ptr cpt^unit chg^units^total^tot unc
 ;   IBREV1(rev code) = revenue code edit category
 ;
 ; IBNOPR = flag that determines if there are revenue codes with
 ;          charges that do not have a procedure - no need to check
 ;          for billable MCR procedures if at least one RC is billable
 ;          1 = there is at least one billable revenue code without a
 ;              procedure
 ;
 S REQMRA=$$REQMRA^IBEFUNC(IBIFN)
 S (IBNOPR,IBI)=0
 F  S IBI=$O(IBXDATA(IBI)) Q:'IBI  D
 . I REQMRA D GYMODCHK(IBXDATA(IBI))      ; IB*2*377 GY modifier check
 . S IBJ=$P(IBXDATA(IBI),U),IBECAT=""
 . I 'IBNOPR D
 .. I $P(IBXDATA(IBI),U,2)'="" S IBPR($P(IBXDATA(IBI),U,2))=IBI Q
 .. S IBNOPR=1 K IBPR
 . S:$D(IBREV1(IBJ)) IBECAT=$G(IBREV1(IBJ))
 . I '$D(IBREV1(IBJ))!(IBECAT="") D  S IBREV1(IBJ)=IBECAT
 . . ;
 . . ; Accomodations (AC)
 . . I (IBJ'<100&(IBJ'>219))!(IBJ=224) S IBECAT="AC" Q
 . . ;
 . . ; Ancillary Outpatient (AO)
 . . I '$$INPAT^IBCEF(IBIFN,1) S IBECAT="AO" Q
 . . ;
 . . ; Ancillary Inpatient (AI)
 . . S IBECAT="AI"
 . ;
 . S IBREV1(IBJ,+$O(IBREV1(IBJ,""),-1)+1)=IBXDATA(IBI)
 . S IBREVTOT(IBECAT)=IBREVTOT(IBECAT)+$P(IBXDATA(IBI),U,6)
 . I IBECAT="AC" S IBTUNIT=IBTUNIT+$P(IBXDATA(IBI),U,4)
 ;
 I $$NEEDMRA^IBEFUNC(IBIFN),$O(IBPR(""))'="" D  Q:IBQUIT
 . ; Don't allow a bill containing only billable procedures for:
 . ;    Oxygen, labs, or influenza shots
 . ;  OR a bill with prosthetics on it
 . ;    to be sent to MEDICARE for an MRA
 . D NONMCR(.IBPR,.IBLABS) ; Remove Oxygen, labs, influenza shots
 . I $G(IBLABS) D WARN^IBCBB11("The only possible billable procedures on this bill are labs -"),WARN^IBCBB11(" Please verify that MEDICARE does not reimburse these labs at 100%") Q
 . I $O(IBPR(""))="" D
 .. S IBQUIT=$$IBER(.IBER,"098")
 ;
 ; covered days+non covered = units of accom rev codes
 ; Check room and board
 I IBTUNIT,IBTUNIT'=(IBCOV+IBNCOV) S IBQUIT=$$IBER(.IBER,114) Q:IBQUIT
 ;
 ; Non Covered Days
 ;   required when the type of bill is 11x,18x,21x or covered days=0
 I IBNCOV="",(IBCTYP!(IBCOV=0)) S IBQUIT=$$IBER(.IBER,115) Q:IBQUIT
 ;
 ; if cc code=40 then non-covered days must be 1
 I $D(IBCCARY1(40)),IBNCOV'=1 S IBQUIT=$$IBER(.IBER,116) Q:IBQUIT
 ;
 ; Patient Sex
 ; must be "M" or "F"
 D DEM^VADPT
 I $P(VADM(5),U)'="M",$P(VADM(5),U)'="F" S IBQUIT=$$IBER(.IBER,124) Q:IBQUIT
 ;
 ; esg - 10/17/07 - patch 371
 ; For Part A replacement MRA request claims, make sure
 ; the Medicare ICN/DCN number is present and also text in FL-80.
 I $$REQMRA^IBEFUNC(IBIFN),$F(".137.138.117.118.","."_IBTOB_".") D  Q:IBQUIT
 . N IBZ,FL80TXT
 . D F^IBCEF("N-CURR INS FORM LOC 64","IBZ",,IBIFN)  ; see CI3-11
 . I IBZ="" S IBQUIT=$$IBER(.IBER,205) Q:IBQUIT      ; missing ICN/DCN
 . S FL80TXT=$P($G(^DGCR(399,IBIFN,"UF2")),U,3)
 . I FL80TXT="" S IBQUIT=$$IBER(.IBER,206) Q:IBQUIT  ; missing FL80 text
 . Q
 ;
 D ^IBCBB4
 Q
 ;
IBER(IBER,ERRNO) ; Sets error list
 ; NOTE: add code to check error list > 20 ... If so, display message and
 ;   quit so we don't get too many errors at once to handle
 ;   Print all if printing list
 ;
 I '$G(IBQUIT) D
 . I ERRNO?1N.N S:$L(ERRNO)<3 ERRNO=$E("00",1,3-$L(ERRNO))_ERRNO
 . I $L(IBER,";")>19,'$G(IBPRT("PRT")) S IBER=IBER_"IB999;",IBQUIT=1
 . I $G(IBER)'[("IB"_ERRNO_";") S IBER=IBER_"IB"_ERRNO_";"
 Q IBQUIT
 ;
NONMCR(IBPR,IBLABS) ;  Delete all oxygen and lab, flu shot CPT entries from IBPR
 ; IBPR = array subscripted by CPT codes from bill
 ; IBLABS = flag returned =1 if labs found on bill
 N Z S IBLABS=0
 ; Oxygen
 F Z="A0422","A4575","A4616","A4619","A4620","A4621","E0455","E1353","E1355" K IBPR(Z)
 F Z=77:1:85 S Z0="E13"_Z K IBPR(Z0)
 ; Labs
 S Z="80000" F  S Z=$O(IBPR(Z)) Q:Z'?1"8"4N  S IBLABS=1
 ; Flu shots
 F Z="90724","G0008","90732","G0009","90657","90658","90659","90660" K IBPR(Z)
 Q
 ;
MCRANUM(IBIFN) ; Determine MEDICARE A provider ID # from bedsection for
 ; bill ien IBIFN
 N IBX
 ; PART A MRA (only) needed - determine if psych/non-psych claim
 N IBX,IBI
 S IBI=$P($G(^DGCR(399,IBIFN,"U")),U,11)
 S IBX=$S($TR($P($G(^DGCR(399.1,+IBI,0)),U),"psych","PSYCH")'["PSYCH":670899,1:674499)
 Q IBX
 ;
MCRACK(IBIFN,X,IBFLD) ; Check for MEDICARE A for bill IBIFN
 ; Called from CLAIM STATUS MRA field (#24) xrefs in file 399
 ; X = current value of field 399;24
 ; IBFLD = 1 for primary ins co, 2 for secondary, 3 for tertiary
 N IB
 S IB=0
 I +X,$$COBN^IBCEF(IBIFN)=IBFLD,$$WNRBILL^IBEFUNC(IBIFN,IBFLD),$$MRATYPE^IBEFUNC(IBIFN,"C")="A" S IB=1
 Q IB
 ;
GYMODCHK(Z) ; GY modifier check procedure.  IB*2*377 - 2/4/08
 ; Z is the IBXDATA(IBI) service line EDI
 N MODS
 I IBER["IB123" Q     ; error already found
 S MODS=$P(Z,U,9)     ; list of modifiers separated by commas
 I MODS'["GY" Q       ; GY modifier not here on this line item
 I $P(Z,U,6) Q        ; non-covered charges exist on this line item
 S IBQUIT=$$IBER(.IBER,123)
GYMODX ;
 Q
 ;
