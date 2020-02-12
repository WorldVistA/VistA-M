IBCBB1 ;ALB/AAS - CONTINUATION OF EDIT CHECK ROUTINE ;2-NOV-89
 ;;2.0;INTEGRATED BILLING;**27,52,80,93,106,51,151,148,153,137,232,280,155,320,343,349,363,371,395,384,432,447,488,554,577,592,608,623**;21-MAR-94;Build 70
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; *** Begin IB*2.0*488 VD  (Issue 46 RBN)
 N I
 S I=""
 S X=+$G(^DGCR(399,IBIFN,"MP"))
 I 'X,$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN)) S X=+$$CURR^IBCEF2(IBIFN)
 ;JWS;IB*2.0*592:US1108 - Dental form check
 I X,+$G(^DIC(36,X,3)) S I=$P(^(3),U,$S($$FT^IBCEF(IBIFN)=2:2,$$FT^IBCEF(IBIFN)=7:15,1:4))
 S I=$$UP^XLFSTR(I)
 I (I'=""&(I["PRNT")&($G(IBER)'["IB488")) D 
 . S IBER=$G(IBER)_"IB488;"
 ;
 ; Cause an error if FORCED TO PRINT TO CLEARINGHOUSE
 I $P($G(^DGCR(399,IBIFN,"TX")),U,8)=2 D
 . S IBER=$G(IBER)_"IB489;"
 ;
 ; Cause a fatal error if the claim has no procedures & is NOT a UB-04 Inpatient claim.
 I +$O(^DGCR(399,IBIFN,"CP",0))=0 D
 .I $$INPAT^IBCEF(IBIFN,1),$$INSPRF^IBCEF(IBIFN) Q   ; inpatient UB-04 check
 .I '$$INPAT^IBCEF(IBIFN,1),$$INSPRF^IBCEF(IBIFN) D  Q      ; Outpatient Institutional Claim.
 ..I IBER["IB352" Q
 ..S IBER=IBER_"IB352;"
 .;
 .; Professional claim
 .I IBER["IB353" Q
 .S IBER=IBER_"IB353;"
 .Q
 ; *** End IB*2.0*488 -- VD
 ;
 ;MAP TO DGCRBB1
 ;
% ;Bill Status
 N Z,Z0,Z1,IBFT
 I $S(+IBST=0:1,1:"^1^2^3^4^7^"'[(U_IBST_U)) S IBER=IBER_"IB045;"
 ;
 ;Statement Covers From
 I IBFDT="" S IBER=IBER_"IB061;"
 I IBFDT]"",IBFDT'?7N&(IBFDT'?7N1".".N) S IBER=IBER_"IB061;"
 I IBFDT>IBTDT S IBER=IBER_"IB061;" ; from must be on or before the to date 
 S IBFFY=$$FY^IBOUTL(IBFDT)
 ; if inpat - from date must not be prior to admit date.
 I $$INPAT^IBCEF(IBIFN,1),(IBFDT<($P($G(^DGPT(+$P(IBND0,U,8),0)),U,2)\1))  S IBER=IBER_"IB061;"
 ;
 ;Statement Covers To
 I IBTDT="" S IBER=IBER_"IB062;"
 I IBTDT]"",IBTDT'?7N&(IBTDT'?7N1".".N) S IBER=IBER_"IB062;"
 I IBTDT>DT!(IBTDT<IBFDT) S IBER=IBER_"IB062;"  ; to date must not be >than today's date
 S IBTFY=$$FY^IBOUTL(IBTDT)
 ;
 ;Total Charges
 ; IB*2.0*447/TAZ Removed this error so that zero dollar revenue codes can process on the 837
 ;I +IBTC'>0!(+IBTC'=IBTC) S IBER=IBER_"IB064;"
 ;
 ;Billable charges for secondary claim
 I $$MCRONBIL^IBEFUNC(IBIFN)&(($P(IBNDU1,U,1)-$P(IBNDU1,U,2))'>0) S IBER=IBER_"IB094;"
 ;Fiscal Year 1
 S IBFFY=$$FY^IBOUTL(IBFDT)
 ;
 ;Check provider link for current user, enterer, reviewer and Authorizor
 I '$D(^VA(200,DUZ,0)) S IBER=IBER_"IB048;"
 I IBEU]"",'$D(^VA(200,IBEU,0)) S IBER=IBER_"IB048;"
 I IBRU]"",'$D(^VA(200,IBRU,0)) S IBER=IBER_"IB060;"
 I IBAU]"",'$D(^VA(200,IBAU,0)) S IBER=IBER_"IB041;"
 ;
 I IBER="",+$$STA^PRCAFN(IBIFN)=104 S IBER=IBER_"IB040;"
 ; If ins bill, must have valid COB sequence
 I $P(IBND0,U,11)="i",$S($P(IBND0,U,21)="":1,1:"PST"'[$P(IBND0,U,21)) S IBER=IBER_"IB324;"
 ;
 ; Check for valid sec provider id for current ins
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"PRV",Z)) Q:'Z  S Z0=$G(^(Z,0)),Z1=+$$COBN^IBCEF(IBIFN) I $P(Z0,U,4+Z1)'="",$P(Z0,U,11+Z1)'="" D
 . I '$$SECIDCK^IBCEF74(IBIFN,Z1,$P(Z0,U,11+Z1),Z) D WARN^IBCBB11("Prov secondary id type for the "_$P("PRIMARY^SECONDARY^TERTIARY",U,Z1)_" "_$$EXTERNAL^DILFD(399.0222,.01,,+Z0)_" is invalid/won't transmit")
 ; Check NPIs
 D NPICHK^IBCBB11
 ;
 ; Check multiple rx NPIs
 D RXNPI^IBCBB11(IBIFN)
 ;
 ; Check taxonomies
 D TAXCHK^IBCBB11
 ;
 ; Check for Physician Name
 K IBXDATA D F^IBCEF("N-ATT/REND PHYSICIAN NAME",,,IBIFN)
 ; IB*2.0*432 - CMS1500 no longer needs a claim level rendering
 S IBFT=$$FT^IBCEF(IBIFN)
 ;JWS;IB*2.0*592:US1108 - Dental form check
 I IBFT'=2,IBFT'=7,$P($G(IBXDATA),U)="" S IBER=IBER_"IB303;"
 ;
 N FUNCTION,IBINS
 ; IB*2.0*432 - CMS1500 no longer needs a claim level rendering
 ;S FUNCTION=$S($$FT^IBCEF(IBIFN)=3:4,1:3)
 S FUNCTION=$S(IBFT=3:4,1:3)
 ;JWS;IB*2.0*592:US1108 - Dental form check
 I IBFT'=2,IBFT'=7,IBER'["IB303;" D
 . F IBINS=1:1:3 D
 .. S Z=$$GETTYP^IBCEP2A(IBIFN,IBINS)
 .. I Z,$P(Z,U,2) D  ; Rendering/attending prov secondary id required
 ... N IBID,IBOK,Q0
 ... D PROVINF^IBCEF74(IBIFN,IBINS,.IBID,1,"C")  ; check all as though they were current
 ... S IBOK=0
 ... S Q0=0 F  S Q0=$O(IBID(1,FUNCTION,Q0)) Q:'Q0  I $P(IBID(1,FUNCTION,Q0),U,9)=+Z S IBOK=1 Q
 ... I 'IBOK S IBER=IBER_$S(IBINS=1:"IB236;",IBINS=2:"IB237;",IBINS=3:"IB238;",1:"")
 ;
 ; Patch 432 enh5:The IB system shall no longer prevent users from authorizing(fatal error message)a claim because the system cannot find the providersSSNorEIN
 ; D PRIIDCHK^IBCBB11
 ;
 N IBM,IBM1
 S IBM=$G(^DGCR(399,IBIFN,"M"))
 S IBM1=$G(^DGCR(399,IBIFN,"M1"))
 I $P(IBM,U),$P($G(^DIC(36,$P(IBM,U),4)),U,6),$P(IBM1,U,2)="" S IBER=IBER_"IB244;"
 I $P(IBM,U,2),$P($G(^DIC(36,$P(IBM,U,2),4)),U,6),$P(IBM1,U,3)="" S IBER=IBER_"IB245;"
 I $P(IBM,U,3),$P($G(^DIC(36,$P(IBM,U,3),4)),U,6),$P(IBM1,U,4)="" S IBER=IBER_"IB246;"
 ;
 ; If outside facility, check for ID and qualifier in 355.93
 ; 5/15/06 - esg - hard error IB243 turned into warning message instead
 S Z=$P($G(^DGCR(399,IBIFN,"U2")),U,10)
 I Z D
 . I $P($G(^IBA(355.93,Z,0)),U,9)=""!($P($G(^IBA(355.93,Z,0)),U,13)="") D
 .. N Z1,Z2
 .. S Z1="Missing Lab or Facility Primary ID for non-VA facility, "
 .. S Z2=$$EXTERNAL^DILFD(399,232,,Z)
 .. I $L(Z2)'>19 D WARN^IBCBB11(Z1_Z2) Q
 .. D WARN^IBCBB11(Z1),WARN^IBCBB11("     "_Z2)
 .. Q
 . Q
 ;
 ; Must be one and only one division on bill
 S IBZ=$$MULTDIV^IBCBB11(IBIFN,IBND0)
 ; I IBZ S IBER=IBER_$S(IBZ=1:"IB095;",IBZ=2:"IB104;",1:"IB105;")
 ; Allow multi-divisional for OP instutional claims
 I IBZ,$$INPAT^IBCEF(IBIFN)!'($$INSPRF^IBCEF(IBIFN)) S IBER=IBER_$S(IBZ=1:"IB095;",IBZ=2:"IB104;",1:"IB105;")
 ; Still need error msg on OP Institutional if No Default division
 I IBZ=3,'$$INPAT^IBCEF(IBIFN),$$INSPRF^IBCEF(IBIFN) S IBER=IBER_"IB105;"
 ; Division address must be defined in institution file
 I $P(IBND0,U,22) D
 . N Z,Z0,Z1
 . S Z0=$G(^DIC(4,+$P($G(^DG(40.8,+$P(IBND0,U,22),0)),U,7),0))
 . S Z1=$G(^DIC(4,+$P($G(^DG(40.8,+$P(IBND0,U,22),0)),U,7),1))
 . I $P(Z0,U,2)="" S IBER=IBER_"IB097;" Q
 . F Z=1,3,4 I $P(Z1,U,Z)="" S IBER=IBER_"IB097;" Q
 ;
 ; IB*2.0*432 Check ambulance addresses, COB Non-covered amt. & Attachment Control
 I $$AMBCK^IBCBB11(IBIFN)=1 S IBER=IBER_"IB329;"
 I $$COBAMT^IBCBB11(IBIFN)=1 S IBER=IBER_"IB330;"
 I $$TMCK^IBCBB11(IBIFN)=1 S IBER=IBER_"IB331;"
 I $$ACCK^IBCBB11(IBIFN)=1 S IBER=IBER_"IB332;"
 I $$COBMRA^IBCBB11(IBIFN)=1 S IBER=IBER_"IB342;"
 I $$COBSEC^IBCBB11(IBIFN)=1 S IBER=IBER_"IB343;"
 ;
 ;CHAMPVA Rate Type and Primary Insurance Carriers Type of Coverage must match
 S (IBRTCHV,IBPICHV)=0
 I $P($G(^DGCR(399.3,+IBAT,0)),U,1)="CHAMPVA" S IBRTCHV=1
 I $P($G(^IBE(355.2,+$P($G(^DIC(36,+IBNDMP,0)),U,13),0)),U,1)="CHAMPVA" S IBPICHV=1
 I (+IBRTCHV!+IBPICHV)&('IBRTCHV!'IBPICHV) S IBER=IBER_"IB085;"
 ;
 ;Non-VA bill must use FEE REIMB INS rate type; FEE REIMB INS rate type can only be used for Non-VA bill
 ;IB*2.0*554/DRF 10/9/2015
 ;N IBNVART,IBNVAST
 ;S (IBNVART,IBNVAST)=0
 ;I $P($G(^DGCR(399.3,+IBAT,0)),U,1)="FEE REIMB INS" S IBNVART=1
 ;S IBNVAST=$$NONVAFLG(IBIFN)
 ;I IBNVART,'IBNVAST S IBER=IBER_"IB360;"  ;Non-VA rate type used for bill that is not Non-VA
 ;I 'IBNVART,IBNVAST S IBER=IBER_"IB361;"  ;Non-VA rate type not used for bill that is Non-VA
 ;
 N IBZPRC,IBZPRCUB
 D F^IBCEF("N-ALL PROCEDURES","IBZPRC",,IBIFN)
 ; Procedure Clinic is required for Surgical Procedures Outpt Facility Charges
 I +$P(IBND0,U,27)'=2,$$BILLRATE^IBCRU3(IBAT,IBCL,IBEVDT,"RC OUTPATIENT") D
 . N Z,Z0,Z1,ZE S (ZE,Z)=0 F  S Z=$O(^DGCR(399,IBIFN,"CP",Z)) Q:'Z  D  I +ZE S IBER=IBER_"IB320;" Q
 .. S Z0=$G(^DGCR(399,IBIFN,"CP",Z,0)),Z1=+Z0 I Z0'[";ICPT(" Q
 .. I '((Z1'<10000)&(Z1'>69999))&'((Z1'<93501)&(Z1'>93533)) Q
 .. I '$P(Z0,U,7) S ZE=1
 ;
 ; Extract procedures for UB-04
 D F^IBCEF("N-UB-04 PROCEDURES","IBZPRCUB",,IBIFN)
 ; Does this bill have ANY prescriptions associated with it?
 ; Must bill prescriptions separately from other charges
 ;
 ; DEM;432 - Call line level provider edit checks.
 D LNPROV^IBCBB12(IBIFN)  ; DEM;432 - If there are line provider edits, then routine LNPROV^IBCBB12(IBIFN) updates IBER string.
 ; DEM;432 - Call to Other Operating/Operating Provider edit checks.
 I $$OPPROVCK^IBCBB12(IBIFN)=1 S IBER=IBER_"IB337;"  ; DEM;432
 ; DEM;432 - Line level Attachment Control edits.
 I $$LNTMCK^IBCBB11(IBIFN)=1 S IBER=IBER_"IB331;"  ; DEM;432
 I $$LNACCK^IBCBB11(IBIFN)=1 S IBER=IBER_"IB332;"  ; DEM;432
 ;
 ; vd/Beginning of IB*2*577 - Validate Line Level NDC edits.
 I $$LNNDCCK^IBCBB11(IBIFN)=1 S IBER=IBER_"IB365;"  ;IB*2*577;JWS;11/20/17 FIX
 ; vd/End of IB*2*577
 I $$ISRX^IBCEF1(IBIFN) D
 . N IBZ,IBRXDEF
 . S IBRXDEF=$P($G(^IBE(350.9,1,1)),U,30),IBZ=0
 . F  S IBZ=$O(IBZPRCUB(IBZ)) Q:'IBZ  I IBZPRCUB(IBZ),+$P(IBZPRCUB(IBZ),U)'=IBRXDEF S IBER=IBER_"IB102;" Q
 . K IBZ
 ;
 ; Check that COB sequences are not skipped
 K Z
 F Z=1:1:3 S:+$G(^DGCR(399,IBIFN,"I"_Z)) Z(Z)=""
 F Z=0:1:2 S Z0=$O(Z(Z)) Q:'Z0  I Z0'=(Z+1) S IBER=IBER_"IB322;" Q
 K Z
 ; HD64676  IB*2*371 - OK for payer sequence to be blank when the Rate
 ;    Type is either Interagency or Sharing Agreement
 I $P($G(^DGCR(399,IBIFN,0)),U,21)="",$P($G(^DGCR(399,IBIFN,0)),U,7)'=4,$P($G(^DGCR(399,IBIFN,0)),U,7)'=9 S IBER=IBER_"IB323;"
 K IBXDATA D F^IBCEF("N-PROCEDURE CODING METHD",,,IBIFN)
 ; Coding method should agree with types of procedure codes
 S IBOK=$S('$O(IBZPRC(0))!(IBXDATA=""):1,1:0)
 I 'IBOK S IBOK=1,IBZ=0 F  S IBZ=$O(IBZPRC(IBZ)) Q:'IBZ  I IBZPRC(IBZ),$P(IBZPRC(IBZ),U)'[$S(IBXDATA=9:"ICD",1:"ICP") S IBOK=0 Q
 I 'IBOK D WARN^IBCBB11("Coding Method does not agree with all procedure codes found on bill")
 D EDITMRA^IBCBB3(.IBQUIT,.IBER,IBIFN,IBFT)
 Q:$G(IBQUIT)
 ;
 ;Other things that could be added:  Rev Code - calculating charges
 ;        Diagnosis Coding, if MT copay - check for other co-payments
 ;
 I $P(IBNDTX,U,8),$$REQMRA^IBEFUNC(IBIFN) S IBER=IBER_"IB121;"   ; can't force MRAs to print
 I $P(IBNDTX,U,8)!$P(IBNDTX,U,9) D
 . Q:$P(IBNDTX,U,8)=2    ; Don't want to do this for option 2 any more.
 . D WARN^IBCBB11($S($$REQMRA^IBEFUNC(IBIFN)&($P(IBNDTX,U,9)):"MRA Secondary ",1:"")_"Bill has been forced to print "_$S($P(IBNDTX,U,8)=1!($P(IBNDTX,U,9)=1):"locally",1:"at clearinghouse"))
 N IBXZ,IBIZ F IBIZ=12,13,14 S IBXZ=$P(IBNDM,U,IBIZ) I +IBXZ S IBXZ=$P($G(^DPT(DFN,.312,IBXZ,0)),U,18) I +IBXZ S IBXZ=$G(^IBA(355.3,+IBXZ,0)) I +$P(IBXZ,U,12) D
 . D WARN^IBCBB11($P($G(^DIC(36,+IBXZ,0)),U,1)_" requires Amb Care Certification")
 ;
 D VALNDC^IBCBB11(IBIFN,DFN)  ;validate NDC#
 ;
 ;Build AR array if no errors and MRA not needed or already rec'd
 I IBER="",$S($$NEEDMRA^IBEFUNC(IBIFN)!($$REQMRA^IBEFUNC(IBIFN)):0,1:1) D ARRAY
 ;
 ;Check ROI
 N ROIERR
 ;/vd - IB*2.0*623 (US4995) - Modified the following 2 lines of code with the following conditional.
 ;S ROIERR=0 I $P($G(^DGCR(399,IBIFN,"U")),U,5)=1,+$P($G(^DGCR(399,IBIFN,"U")),U,7)=0 S ROIERR=1 ; screen 7 sensitive record and no ROI
 ;I $$ROICHK^IBCBB11(IBIFN,DFN,+IBNDMP) S ROIERR=1 ; check file for sensitive Rx and missing ROI
 S ROIERR=0
 I $$ROIDTCK^IBCEU7(IBIFN) D    ; ROI Eligible based upon Service Date of Claim
 . I $P($G(^DGCR(399,IBIFN,"U")),U,5)=1,+$P($G(^DGCR(399,IBIFN,"U")),U,7)=0 S ROIERR=1 ; screen 7 sensitive record and no ROI
 . I $$ROICHK^IBCBB11(IBIFN,DFN,+IBNDMP) S ROIERR=1 ; check file for sensitive Rx and missing ROI
 I ROIERR S IBER=IBER_"IB328;"
 ;
 ;Verify Line Charges Match Claim Total Charge. IB*2.0*447 BI
 I +$$GET1^DIQ(399,IBIFN_",",201)'=+$$IBLNTOT^IBCBB13(IBIFN) S IBER=IBER_"IB344;"
 ;
 ;Test for valid EIN/SY ID Values. IB*2.0*447 BI
 I $$IBSYEI^IBCBB13(IBIFN) S IBER=IBER_"IB345;"
 ;
 ;Test for a missing ICN. IB*2.0*447 BI
 I $$IBMICN^IBCBB13(IBIFN) S IBER=IBER_"IB346;"
 ;
 ;Test for a ZERO charge amounts. IB*2.0*447 BI
 I $$IBRCCHK^IBCBB13(IBIFN) D WARN^IBCBB11("Claim contains revenue codes with no associated charges.")
 ;
 ;Test for missing "Patient reason for visit". IB*2.0*447 BI
 I $$FT^IBCEF(IBIFN)=3,'$$INPAT^IBCEF(IBIFN),$$IBPRV3^IBCBB13(IBIFN) S IBER=IBER_"IB347;"
 ;
 ;Test for missing Payer ID. IB*2.0*447 BI
 ;I $$IBMPID^IBCBB13(IBIFN) S IBER=IBER_"IB348;"
 ;Changed Error to Warning. IB*2.0*447 TAZ
 I $$IBMPID^IBCBB13(IBIFN) D WARN^IBCBB11("Not all payers have Payer IDs.")
 ;
 ;Test for missing "Priority (Type) of Admission" for UB-04. IB*2.0*447 BI
 I $$FT^IBCEF(IBIFN)=3,$$GET1^DIQ(399,IBIFN_",",158)="" S IBER=IBER_"IB349;"
 ;
 I $$FT^IBCEF(IBIFN)=2 S IBER=IBER_$$CMNCHK^IBCBB13(IBIFN)  ;JRA;IB*2.0*608 Check for missing CMN info
 ;
END ;Don't kill IBIFN, IBER, DFN
 I $O(^TMP($J,"BILL-WARN",0)),$G(IBER)="" S IBER="WARN" ;Warnings only
 K IBBNO,IBEVDT,IBLOC,IBCL,IBTF,IBAT,IBWHO,IBST,IBFDT,IBTDT,IBTC,IBFY,IBFY1,IBAU,IBRU,IBEU,IBARTP,IBFYC,IBMRA,IBTOB,IBTOB12,IBNDU2,IBNDUF3,IBNDUF31,IBNDTX
 K IBNDS,IBND0,IBNDU,IBNDM,IBNDMP,IBNDU1,IBFFY,IBTFY,IBFT,IBRTCHV,IBPICHV,IBXDATA,IBOK
 I $D(IBER),IBER="" W !,"No Errors found for National edits"
 Q
 ;
ARRAY ;Build PRCASV(array)
 N IBCOBN,X
 K PRCASV
 Q:$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN))
 S IBCOBN=$$COBN^IBCEF(IBIFN)
 S X=IBIFN
 S PRCASV("BDT")=DT,PRCASV("ARREC")=IBIFN
 S PRCASV("APR")=DUZ
 S PRCASV("PAT")=DFN,PRCASV("CAT")=$P(^DGCR(399.3,IBAT,0),"^",6)
 I IBWHO="i" S PRCASV("DEBTOR")=+IBNDMP_";DIC(36,"
 S PRCASV("DEBTOR")=$S(IBWHO="p":DFN_";DPT(",IBWHO="o":$P(IBNDM,"^",11)_";DIC(4,",IBWHO="i":PRCASV("DEBTOR"),1:"")
 S PRCASV("CARE")=$E($$TOB^IBCEF1(IBIFN),1,2)
 S PRCASV("FY")=$$FY^IBOUTL(DT)_U_($P(IBNDU1,U)-$P(IBNDU1,U,2))
 ;S PRCASV("FY")=$P(IBNDU1,U,9)_U_$S($P(IBNDU1,U,2)]"":($P(IBNDU1,U,10)-$P(IBNDU1,U,2)),1:$P(IBNDU1,U,10))_$S($P(IBNDU1,U,11)]"":U_$P(IBNDU1,U,11)_U_$P(IBNDU1,U,12),1:"")
PLUS I IBWHO="i",$P(IBNDM,"^",2),$D(^DIC(36,$P(IBNDM,"^",2),0)) S PRCASV("2NDINS")=$P(IBNDM,"^",2)
 I IBWHO="i",$P(IBNDM,"^",3),$D(^DIC(36,$P(IBNDM,"^",3),0)) S PRCASV("3RDINS")=$P(IBNDM,"^",3)
 ;
 N IBX S IBX=$P(IBND0,U,21),IBX=$S(IBX="P":"I1",IBX="S":"I2",IBX="T":"I3",1:"") Q:IBX=""
 N IBNDI1
 Q:'$D(^DGCR(399,IBIFN,IBX))  S IBNDI1=^(IBX)
 S:$P(IBNDI1,"^",3)]"" PRCASV("GPNO")=$P(IBNDI1,"^",3)
 S:$P(IBNDI1,"^",15)]"" PRCASV("GPNM")=$P(IBNDI1,"^",15)
 S:$P(IBNDI1,"^",17)]"" PRCASV("INPA")=$P(IBNDI1,"^",17)
 S:$P(IBNDI1,"^",2)]"" PRCASV("IDNO")=$P(IBNDI1,"^",2),PRCASV("INID")=PRCASV("IDNO")
 ; Check that this is a secondary or tertiary bill and insurance for previous
 ; COB sequence is Medicare WNR and MRA is active --> send data elements to AR
 I IBCOBN>1,$$WNRBILL^IBEFUNC(IBIFN,IBCOBN-1),$$EDIACTV^IBCEF4(2) D MRA
 Q
 ;
MRA N IBEOB S IBEOB=0
 ;
 K PRCASV("MEDURE"),PRCASV("MEDCA")
 ; Get EOB data
 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D
 . D MRACALC^IBCEMU2(IBEOB,IBIFN,1,.PRCASV)
 Q  ;MRA
 ;
 ;; PREGNANCY DX CODES: V22**-V24**, V27**-V28**, 630**-677**
 ;; FLU SHOTS PROCEDURE CODES: 90724, G0008, 90732, G0009
 ;
NONVAFLG(IBIFN) ; Check if Non-VA bill
 ; Function returns 1 if Non-VA bill
 ; IB*2.0*554/DRF 10/9/2015
 N FLAG,PTF
 S FLAG=0
 I $P($G(^DGCR(399,IBIFN,"U2")),U,10)]"" S FLAG=1 ;Non-VA provider defined
 S PTF=$P($G(^DGCR(399,IBIFN,0)),U,8)
 I PTF,$P($G(^DGPT(PTF,0)),U,4)=1 S FLAG=1 ;PTF entry indicates Non-VA
 Q FLAG
