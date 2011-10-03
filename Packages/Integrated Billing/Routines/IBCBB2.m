IBCBB2 ;ALB/ARH - CONTINUATION OF EDIT CHECKS ROUTINE (CMS-1500) ;04/14/92
 ;;2.0;INTEGRATED BILLING;**51,137,210,245,232,296,320,349,371,403**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRBB2
 ;
EN ;
 N IBI,IBJ,IBN,IBY,IBDX,IBDXO,IBDXL,IBDXTYP,IBCPT,IBCPTL,IBOLAB,Z,IBXSAVE,IBLOC,IBTX,IBPS,IBSP,IBLCT,IBNVFLG,IBU3
 I '$D(IBER) S IBER=""
 S IBTX=$$TXMT^IBCEF4(IBIFN)
 ;
 ; Max 4 modifiers per CPT code allowed before warning
 K IBXDATA
 D F^IBCEF("N-HCFA 1500 MODIFIERS",,,IBIFN) ;Get modifiers
 ;
 S Z=0 F  S Z=$O(IBZPRC92(Z)) Q:'Z  I $P(IBZPRC92(Z),U)["ICPT(",$L($P(IBZPRC92(Z),U,15),",")>4 S IBI="Proc "_$$PRCD^IBCEF1($P(IBZPRC92(Z),U))_" has > 4 modifiers - only first 4 will be used" D WARN^IBCBB11(IBI)
 ; ICD-9 diagnosis, at least 1 required
 D SET^IBCSC4D(IBIFN,.IBDX,.IBDXO) I '$P(IBDX,U,2) S IBER=IBER_"IB071;"
 S IBI=$O(IBDXO(0))
 I IBI D
 .S IBDXTYP=$E($$ICD9^IBACSV(+$P(IBDXO(IBI),U)))
 .S:IBDXTYP="E" IBER=IBER_"IB117;"
 .I $$INPAT^IBCEF(IBIFN,1),IBDXTYP="V" S Z="Principal Dx V-code may not be valid" D WARN^IBCBB11(Z)
 .Q
 ;
 ; CPT procs must be associated with a dx, must have a defined provider
 S (IBLOC,IBN,IBI,IBY)=0 F  S IBI=$O(^DGCR(399,IBIFN,"CP",IBI)) Q:IBI'?1N.N  S IBCPT=^(IBI,0) D  I +IBY S IBN=1
 . I 'IBLOC,$P(IBCPT,U,15)'="",IBTX S Z="At least 1 charge has local box 24K data that will not be transmitted - " S IBLOC=1 D WARN^IBCBB11(Z) S Z="  This data will only print locally" D WARN^IBCBB11(Z)
 . I $P(IBCPT,U)'["ICPT(" S:IBER'["IB092" IBER=IBER_"IB092;" Q
 . S IBY=1 F IBJ=11:1:14 I +$P(IBCPT,"^",IBJ) S IBCPTL(+$P(IBCPT,"^",IBJ))="",IBY=0
 I +IBN S IBER=IBER_"IB072;"
 ;
 I '$$OCC10(IBIFN,.IBDX,2) S IBER=IBER_"IB093;"
 ; CMS-1500: dxs associated with procs must be defined dxs for the bill
 S IBI=0 F  S IBI=$O(IBDX(IBI))  Q:'IBI  S IBDXL(IBDX(IBI))=""
 S (IBN,IBI)=0 F  S IBI=$O(IBCPTL(IBI)) Q:'IBI  I '$D(IBDXL(IBI)) S IBN=1 Q
 I +IBN S IBER=IBER_"IB073;"
 ; ejk *296* Change # of diagnoses codes from 4 to 8 on CMS-1500 Claims. 
 I IBTX S IBI=8 F  S IBI=$O(IBDXO(IBI)) Q:'IBI  S Z=+$G(IBDX(+$G(IBDXO(IBI)))) I Z,$D(IBCPTL(Z)) D WARN^IBCBB11("Too many diagnoses for claim & will be rejected - consider printing locally")
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
 . I '$P(IBNDU2,U,11),$P(IBXDATA(IBI),U,11) D WARN^IBCBB11("Purchased service amounts are invalid unless this is a NON-VA bill")
 . I IBNVFLG,'$P(IBXDATA(IBI),U,11) D WARN^IBCBB11("Non-VA facility indicated, but no purchased service charge on line# "_IBI)
 . I $D(IBXDATA(IBI,"A")) S IBER=IBER_"IB310;" Q
 . I $D(IBXDATA(IBI,"ARX")),IBER'["311;" S IBER=IBER_"IB311;" Q
 . I $P(IBXDATA(IBI),U,14) S IBOLAB=IBOLAB+1
 . ; Place of service required
 . I $G(IBER)'["IB314;",$P(IBXDATA(IBI),U,3)="" S IBER=IBER_"IB314;"
 . ; Type of service required
 . I $G(IBER)'["IB313;",$P(IBXDATA(IBI),U,4)="" S IBER=IBER_"IB313;"
 . ; 43 and 53 are invalid types of service
 . I $G(IBER)'["IB110;",($P(IBXDATA(IBI),U,4)=43!($P(IBXDATA(IBI),U,4)=53)) S IBER=IBER_"IB110;"
 . ; Units for the line item must be less than 100/1000
 . I IBER'["IB088",$P(IBXDATA(IBI),U,9)'<100 D
 .. I $P(IBXDATA(IBI),U,4)'=7 S IBER=IBER_"IB088;" Q
 .. I $P(IBXDATA(IBI),U,9)'<1000 S IBER=IBER_"IB088;"
 . ; Line item total charge must be less than $10,000.00, greater than 0
 . I IBER'["IB090",$P(IBXDATA(IBI),U,9)'<10000 S IBER=IBER_"IB090;"
 . I '($P(IBXDATA(IBI),U,9)*$P(IBXDATA(IBI),U,8)),$$COBN^IBCEF(IBIFN)'>1 S Z="Procedure "_$P(IBXDATA(IBI),U,5)_" has a 0-charge and will not be transmitted" D WARN^IBCBB11(Z)
 I IBTX,IBLCT>50 D
 . I '$$REQMRA^IBEFUNC(IBIFN) S IBER=IBER_"IB308;" Q
 . I '$P(IBNDTX,U,9) S IBER=IBER_"IB325;"
 S IBU3=$P($G(^DGCR(399,IBIFN,"U3")),U,4,7) I $TR(IBU3,U)'="" D
 .I +IBSP'=35 D WARN^IBCBB11("Chiropractic service details only valid if provider specialty is '35'")
 .I $P(IBU3,U,2)="" S IBER=IBER_"IB137;"
 .I $P(IBU3,U,4)="" S IBER=IBER_"IB138;" Q
 .I $P(IBU3,U,3)="","AM"[$P(IBU3,U,4) S IBER=IBER_"IB139;"
 .Q
 I IBPS'="" D WARN^IBCBB11("NON-VA facility indicated, but no purchased service charge on line item"_$S(IBPS[",":"s",1:"")_" #"_IBPS)
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
 I '$D(^TMP($J,"LMD")) D
 . D F^IBCEF("N-OCCURRENCE CODES",,,IBIFN)
 . S ^TMP($J,"LMD")=""
 . S Z=0 F  S Z=$O(IBXSAVE("OCC",Z)) Q:'Z  I +IBXSAVE("OCC",Z)=10 S ^TMP($J,"LMD")=1 Q
 ;
 I '^TMP($J,"LMD") S IBI=0 F  S IBI=$O(IBARR(IBI))  Q:'IBI  D  Q:'IBN
 . N Z,Z1
 . ; If a pregnancy DX exists, must be an occurrence code 10 for LMP date
 . ; dx ranges are: V22*-V24*, V27*-V28*, 630*-677*
 . S IBDX=$S($G(IBFT)'=2:+IBARR(IBI),1:IBI)
 . S Z=$E($P($$ICD9^IBACSV(IBDX),U),1,3),Z1=$E(Z,2,3)
 . I $S(Z'<630&(Z<678):1,$E(Z)="V":$S(Z1'<22&(Z1<25):1,1:Z1'<27&(Z1<28)),1:0) S IBN=0 ;Pregnancy Dx exists
 ;
OCC10Q K ^TMP($J,"LMD")
 Q IBN
 ;
