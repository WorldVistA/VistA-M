IBCBB2 ;ALB/ARH - CONTINUATION OF EDIT CHECKS ROUTINE (CMS-1500) ;04/14/92
 ;;2.0;INTEGRATED BILLING;**51,137,210,245,232,296,320,349,371,403,432,447,473,488,461,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRBB2
 ;
EN ;
 N IBI,IBJ,IBN,IBY,IBDX,IBDXO,IBDXL,IBDXTYP,IBDXVER,IBCPT,IBCPTL,IBOLAB,Z,IBXSAVE,IBLOC,IBTX,IBPS,IBSP,IBLCT,IBNVFLG,IBU3
 I '$D(IBER) S IBER=""
 S IBTX=$$TXMT^IBCEF4(IBIFN)
 ;
 ; Max 4 modifiers per CPT code allowed before warning
 K IBXDATA
 D F^IBCEF("N-HCFA 1500 MODIFIERS",,,IBIFN) ;Get modifiers
 ;
 S Z=0 F  S Z=$O(IBZPRC92(Z)) Q:'Z  I $P(IBZPRC92(Z),U)["ICPT(",$L($P(IBZPRC92(Z),U,15),",")>4 S IBI="Proc "_$$PRCD^IBCEF1($P(IBZPRC92(Z),U))_" has > 4 modifiers - only first 4 will be used" D WARN^IBCBB11(IBI)
 ;
 ; ICD diagnosis, at least 1 required
 D SET^IBCSC4D(IBIFN,.IBDX,.IBDXO) I '$P(IBDX,U,2) S IBER=IBER_"IB071;"
 ;
 ; Principle diagnosis - updated for ICD-10 **461
 S IBI=$O(IBDXO(0)) I IBI S IBDXTYP=$$ICD9^IBACSV(+$P(IBDXO(IBI),U),$$BDATE^IBACSV(IBIFN)) D
 . S IBDXVER=$P(IBDXTYP,U,19),IBDXTYP=$E(IBDXTYP)
 . I IBDXVER=1,IBDXTYP="E" S IBER=IBER_"IB117;"
 . I IBDXVER=1,$$INPAT^IBCEF(IBIFN,1),IBDXTYP="V" S Z="Principal Dx V-code may not be valid" D WARN^IBCBB11(Z)
 . I IBDXVER=30,"VWXY"[IBDXTYP S IBER=IBER_"IB355;"
 . I IBDXVER=30,$$INPAT^IBCEF(IBIFN,1),IBDXTYP="Z" S Z="Principal Dx Z-code may not be valid" D WARN^IBCBB11(Z)
 ;
 I '$$OCC10(IBIFN,.IBDX,2) S IBER=IBER_"IB093;"
 ;
 ; CPT procs must be associated with a dx, must have a defined provider
 S (IBLOC,IBN,IBI,IBY)=0 F  S IBI=$O(^DGCR(399,IBIFN,"CP",IBI)) Q:IBI'?1N.N  S IBCPT=^(IBI,0) D  I +IBY S IBN=1
 . I 'IBLOC,$P(IBCPT,U,15)'="",IBTX S Z="At least 1 charge has local box 24K data that will not be transmitted - " S IBLOC=1 D WARN^IBCBB11(Z) S Z="  This data will only print locally" D WARN^IBCBB11(Z)
 . I $P(IBCPT,U)'["ICPT(" S:IBER'["IB092" IBER=IBER_"IB092;" Q
 . S IBY=1 F IBJ=11:1:14 I +$P(IBCPT,"^",IBJ) S IBCPTL(+$P(IBCPT,"^",IBJ))="",IBY=0
 I +IBN S IBER=IBER_"IB072;"
 ;
 ; CMS-1500: dxs associated with procs must be defined dxs for the bill
 S IBI=0 F  S IBI=$O(IBDX(IBI))  Q:'IBI  S IBDXL(IBDX(IBI))=""
 S (IBN,IBI)=0 F  S IBI=$O(IBCPTL(IBI)) Q:'IBI  I '$D(IBDXL(IBI)) S IBN=1 Q
 I +IBN S IBER=IBER_"IB073;"
 ; ejk *296* Change # of diagnoses codes from 4 to 8 on CMS-1500 Claims. 
 ; baa *488* Change # of diagnoses codes from 8 to 12.
 ; vd *623-US4055* Modified the logic for dental claims to check for # of diagnosis codes greater than 4.
 I IBTX,$$FT^IBCEF(IBIFN)'=7 S IBI=12 F  S IBI=$O(IBDXO(IBI)) Q:'IBI  S Z=+$G(IBDX(+$G(IBDXO(IBI)))) I Z,$D(IBCPTL(Z)) D WARN^IBCBB11("Too many diagnoses for claim & will be rejected - consider printing locally")
 I $$FT^IBCEF(IBIFN)=7,$P($G(IBDXO),U,2)>4 D WARN^IBCBB11("Only 4 diagnosis codes are allowed on a dental transaction")
 ;
 I $$WNRBILL^IBEFUNC(IBIFN),$$MRATYPE^IBEFUNC(IBIFN)'="B" S IBER=IBER_"IB087;"
 ;
 ; IB*320 - CLIA# error/warning - error msg for MRA claims, else warning
 I $P(IBNDU2,U,13)="",$$CLIAREQ^IBCEP8A(IBIFN) D
 . I $$REQMRA^IBEFUNC(IBIFN) S IBER=IBER_"IB235;" Q
 . D WARN^IBCBB11("Claim contains laboratory services. The payer may require a CLIA #.")
 . Q
 ;
 ; Only one occurrence code can be present for event date for box 14
 S Z=$$EVENT^IBCF22(IBIFN,.IBXSAVE,.IBI)
 I IBI S IBER=IBER_"IB099;"
 ;
 ; esg - 6/6/07 - warning if missing non-VA care type for outside facility
 S IBNVFLG=0
 I $P(IBNDU2,U,10),'$P(IBNDU2,U,11) D WARN^IBCBB11("Non-VA facility indicated, but the Non-VA Care Type field is not defined") S IBNVFLG=1
 ;
 ; unit/charge limits
 K IBXDATA
 D F^IBCEF("N-HCFA 1500 SERVICES (PRINT)",,,IBIFN) ;Get charge lines
 S (IBLCT,IBOLAB)=0,IBPS="",IBSP=$$BILLSPEC^IBCEU3(IBIFN)
 S IBI=0 F  S IBI=$O(IBXDATA(IBI)) Q:'IBI  D  Q:IBER["IB310"!(IBER["IB311")
 . S IBLCT=IBLCT+1
 . I $P(IBNDU2,U,11) D
 .. I '$P(IBXDATA(IBI),U,11) S IBPS=IBPS_$S(IBPS'="":",",1:"")_IBI Q
 .. I $P(IBXDATA(IBI),U,14),"24"'[$P(IBNDU2,U,11) D WARN^IBCBB11("Outside lab charges exist on a non-lab NON-VA bill")
 . ; Start IB*2.0*473 Changed the following two warnings to errors.
 . ;I '$P(IBNDU2,U,11),$P(IBXDATA(IBI),U,11) D WARN^IBCBB11("Purchased service amounts are invalid unless this is a NON-VA bill")
 . ;I IBNVFLG,'$P(IBXDATA(IBI),U,11) D WARN^IBCBB11("Non-VA facility indicated, but no purchased service charge on line# "_IBI)
 . I $G(IBER)'["IB350" I '$P(IBNDU2,U,11),$P(IBXDATA(IBI),U,11) S IBER=IBER_"IB350;"
 . I $G(IBER)'["IB351" I IBNVFLG,'$P(IBXDATA(IBI),U,11) S IBER=IBER_"IB351;"
 . ; End IB*2.0*473
 . I $G(IBER)'["IB310" I $D(IBXDATA(IBI,"A")) S IBER=IBER_"IB310;" Q
 . I $D(IBXDATA(IBI,"ARX")),IBER'["311;" S IBER=IBER_"IB311;" Q
 . I $P(IBXDATA(IBI),U,14) S IBOLAB=IBOLAB+1
 . ; Place of service required => remove edit below for IB*2.0*488 ; baa
 . ;I $G(IBER)'["IB314;",$P(IBXDATA(IBI),U,3)="" S IBER=IBER_"IB314;"
 . ; Type of service required => remove edit below for IB*2.0*488 ; baa
 . ;I $G(IBER)'["IB313;",$P(IBXDATA(IBI),U,4)="" S IBER=IBER_"IB313;"
 . ; 43 and 53 are invalid types of service
 . I $G(IBER)'["IB110;",($P(IBXDATA(IBI),U,4)=43!($P(IBXDATA(IBI),U,4)=53)) S IBER=IBER_"IB110;"
 . ; Units for the line item must be less than 100/1000 => Remove edit baa *488
 . ;I IBER'["IB088",$P(IBXDATA(IBI),U,9)'<100 D
 . ;. I $P(IBXDATA(IBI),U,4)'=7 S IBER=IBER_"IB088;" Q
 . ;. I $P(IBXDATA(IBI),U,9)'<1000 S IBER=IBER_"IB088;"
 . ; Line item total charge must be less than $10,000.00, greater than 0
 . ; IB*2.0*432 - The IB system shall provide the ability for users to enter maximum line item dollar amounts of 9999999.99.
 . ; I IBER'["IB090",$P(IBXDATA(IBI),U,9)'<10000 S IBER=IBER_"IB090;"
 . I IBER'["IB090",$P(IBXDATA(IBI),U,9)'<10000000 S IBER=IBER_"IB090;"
 . ; IB*2.0*447 BI Removed individual warning replaced by a claim level warning.
 . ; I '($P(IBXDATA(IBI),U,9)*$P(IBXDATA(IBI),U,8)),$$COBN^IBCEF(IBIFN)'>1 S Z="Procedure "_$P(IBXDATA(IBI),U,5)_" has a 0-charge and will not be transmitted" D WARN^IBCBB11(Z)
 I IBTX,IBLCT>50 D
 . I $G(IBER)'["IB308" I '$$REQMRA^IBEFUNC(IBIFN) S IBER=IBER_"IB308;" Q
 . I $G(IBER)'["IB325" I '$P(IBNDTX,U,9) S IBER=IBER_"IB325;"
 S IBU3=$P($G(^DGCR(399,IBIFN,"U3")),U,4,7) I $TR(IBU3,U)'="" D
 .; ib*2.0*432 add line-level check
 .;I +IBSP'=35 D WARN^IBCBB11("Chiropractic service details only valid if provider specialty is '35'")
 .I $$LINSPEC^IBCEU3(IBIFN)'[35 D WARN^IBCBB11("Chiropractic service details only valid if provider specialty is '35'")
 .I $G(IBER)'["IB137" I $P(IBU3,U,2)="" S IBER=IBER_"IB137;"
 .I $G(IBER)'["IB338" I $P(IBU3,U,4)="" S IBER=IBER_"IB138;" Q
 .I $G(IBER)'["IB139" I $P(IBU3,U,3)="","AM"[$P(IBU3,U,4) S IBER=IBER_"IB139;"
 .Q
 ; IB*2.0*473 BI Changed the following warning to an error.
 ;I IBPS'="" D WARN^IBCBB11("NON-VA facility indicated, but no purchased service charge on line item"_$S(IBPS[",":"s",1:"")_" #"_IBPS)
 I $G(IBER)'["IB351" I IBPS'="" S IBER=IBER_"IB351;"
 I $P(IBNDU2,U,11),$P(IBNDU2,U,11)=4,IBOLAB>1 D WARN^IBCBB11("For proper payment, you must bill each outside lab on a separate claim form")
 K IBXDATA
 ;
 ;       ; Check for Physician Name
 D F^IBCEF("N-REFERRING PROVIDER NAME",,,IBIFN)
 I $P($G(IBXDATA),U)]"" D
 .N IBZ,FUNCTION,IBINS
 .S FUNCTION=1
 .F IBINS=1:1:3 D
 .. S Z=$$GETTYP^IBCEP2A(IBIFN,IBINS,FUNCTION)
 .. I Z,$P(Z,U,2) D  ; Rendering/attending prov secondary id required
 ... N IBID,IBOK,Q0
 ... D PROVINF^IBCEF74(IBIFN,IBINS,.IBID,1,"C")  ; check all as though they were current
 ... S IBOK=0
 ... S Q0=0 F  S Q0=$O(IBID(1,FUNCTION,Q0)) Q:'Q0  I $P(IBID(1,FUNCTION,Q0),U,9)=+Z S IBOK=1 Q
 ... I 'IBOK S IBER=IBER_$S(IBINS=1:"IB239;",IBINS=2:"IB240;",IBINS=3:"IB241;",1:"")
 ;
 Q
 ;
OCC10(IBIFN,IBARR,IBFT) ; Determine if occurrence code 10 exists for pregnancy dx
 ; IBARR=array subscripted by ien of DX code if IBFT=2 (CMS-1500 form)
 ;                         by seq # and = ien of DX code if IBFT'=2
 ;
 N IBN,IBI,IBXDATA,IBXSAVE,IBDX,Z
 S IBN=1
 ;
 ; If a pregnancy DX exists, must be an occurrence code 10 for LMP date
 ; ICD-9  dx ranges are: V22*-V24*, V27*-V28*, 630*-677*
 ; ICD-10 dx ranges are: O00.*-O9A.*, Z34.*-Z36.*, Z37.*-Z39.*, Z3A.*
 ;
 I '$D(^TMP($J,"LMD")) D
 . D F^IBCEF("N-OCCURRENCE CODES",,,IBIFN)
 . S ^TMP($J,"LMD")=""
 . S Z=0 F  S Z=$O(IBXSAVE("OCC",Z)) Q:'Z  I +IBXSAVE("OCC",Z)=10 S ^TMP($J,"LMD")=1 Q
 ;
 I '^TMP($J,"LMD") S IBI=0 F  S IBI=$O(IBARR(IBI))  Q:'IBI  D  Q:'IBN
 . N Z,Z1,ZC
 . S IBDX=$S($G(IBFT)'=2:+IBARR(IBI),1:IBI)
 . S ZC=$$ICD9^IBACSV(IBDX,$$BDATE^IBACSV(IBIFN)),Z=$E(ZC,1,3),Z1=$E(Z,2,3) ; Pregnancy Dx exists
 . I $P(ZC,U,19)=1,$S(Z'<630&(Z<678):1,$E(Z)="V":$S(Z1'<22&(Z1<25):1,1:Z1'<27&(Z1<28)),1:0) S IBN=0 ; ICD-9 Dx
 . I $P(ZC,U,19)=30,$S(Z?1"O"2N:1,Z="O9A":1,$E(Z)="Z"&(Z1'<34)&(Z1<40):1,Z="Z3A":1,1:0) S IBN=0 ; ICD-10 Dx
 ;
OCC10Q K ^TMP($J,"LMD")
 Q IBN
 ;
