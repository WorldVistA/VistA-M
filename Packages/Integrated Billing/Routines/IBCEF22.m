IBCEF22 ;ALB/TMP - FORMATTER SPECIFIC BILL FUNCTIONS ;06-FEB-96
 ;;2.0;INTEGRATED BILLING;**51,137,135,155,309,349,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  OVERFLOW FROM ROUTINE IBCEF2
HOS(IBIFN) ; Extract rev codes for episode billed on a UB-04 into IBXDATA
 ; IBIFN = bill ien
 ; Format: IBXDATA(n) =
 ;  rev cd ptr ^ CPT CODE ptr ^ unit chg ^ units ^ tot charge
 ;    ^ tot uncov^ FL49 value ^ ien of rev code multiple entry(s)
 ;      (separated by ";")
 ;    ^ modifiers specific to rev code/proc (separated by ",")
 ;    ^ rev code date, if it can be determined by a corresponding proc
 ;
 ;   Also Returns IBXDATA(IBI,"COB",COB,m) with COB data for each line
 ;      item found in an accepted EOB for the bill and = the reference
 ;      line in the first '^' piece followed by the '0' node of file
 ;      361.115 (LINE LEVEL ADJUSTMENTS)
 ;       COB = COB seq # of adjustment's ins co, m = seq #
 ;         -- AND --
 ;    IBXDATA(IBI,"COB",COB,m,z,p)=
 ;           the '0' node for each subordinate entry of file
 ;           361.11511 (REASONS) (Only first 3 pieces for 837)
 ;       z = group code, sometimes preceeded by a space   p = seq #
 ;
 N IBDA,IBCOMB,IBINPAT,IBLN,IBX,IBY,IBZ,IBS,IBSS,IBXTRA,IBX1,IBXS,IBP,IBPO,IBP1,IBDEF,Z,Z0,Z1,ZX,QQ,IBMOD
 S IBINPAT=$$INPAT^IBCEF(IBIFN,1)
 I 'IBINPAT D F^IBCEF("N-STATEMENT COVERS FROM DATE","IBZ",,IBIFN)
 S IBDEF=$G(IBZ)
 ; loop through all proc codes - sort by procedure, modifiers and print order
 S IBDA=0 F  S IBDA=$O(^DGCR(399,IBIFN,"CP",IBDA)) Q:'IBDA  S IBZ=$G(^(IBDA,0)) I IBZ D
 . S IBP(+$P(IBZ,U)_U_$$GETMOD^IBEFUNC(IBIFN,IBDA,1),$S($P(IBZ,U,4):$P(IBZ,U,4),1:999),IBDA)=$P(IBZ,U,2)
 ; loop through all rev codes - sort by rev code
 S IBDA=0 F  S IBDA=$O(^DGCR(399,IBIFN,"RC",IBDA)) Q:'IBDA  S IBZ=$G(^(IBDA,0)) I IBZ S IBMOD="" D
 . S IBX=$G(^DGCR(399.2,+IBZ,0)),IBX1="",IBPO=0
 . ; Auto-added procedure charge
 . I $P(IBZ,U,10)=4,$P(IBZ,U,11) D  ; Soft link to proc
 .. S Z=$G(^DGCR(399,IBIFN,"CP",$P(IBZ,U,11),0))
 .. Q:Z=""
 .. S ZX=+Z_U_$$GETMOD^IBEFUNC(IBIFN,$P(IBZ,U,11),1)
 .. Q:'$O(IBP(ZX,0))&'$O(IBP1(ZX,0))
 .. I $P(IBZ,U,6) Q:$S($P(Z,U)'["ICPT":1,1:+$P(Z,U)'=$P(IBZ,U,6))
 .. S Z0=$S($D(IBP(ZX)):$O(IBP(ZX,0)),1:$O(IBP1(ZX,0)))
 .. S:'Z0 Z0=999
 .. Q:'$D(IBP(ZX,+Z0,$P(IBZ,U,11)))&'$D(IBP1(ZX,+Z0,$P(IBZ,U,11)))
 .. I '$D(IBP1(ZX,+Z0,$P(IBZ,U,11))) S IBP1(ZX,+Z0,$P(IBZ,U,11))=IBP(ZX,+Z0,$P(IBZ,U,11)) K IBP(ZX,+Z0,$P(IBZ,U,11))
 .. S IBX1=$P(Z,U,2),IBPO=+Z0,IBMOD=$P(ZX,U,2)
 . ; Manually added charge with a procedure
 . I $P(IBZ,U,6),$S($P(IBZ,U,10)=4:'$P(IBZ,U,11),1:1),+$O(IBP($P(IBZ,U,6)))=$P(IBZ,U,6) D
 .. ; No direct link, but a proc exists on rev code and in procedure mult without and then with modifiers
 .. S ZX=$O(IBP($P(IBZ,U,6)))
 .. F QQ=1,2 Q:IBPO  S Z="" F  S Z=$O(IBP(ZX,Z),-1) Q:'Z!(IBPO)  S Z0=0 F  S Z0=$O(IBP(ZX,Z,Z0)) Q:'Z0  S Z1=$G(^DGCR(399,IBIFN,"CP",Z0,0)) D  Q:IBPO
 ... ; Ignore if not a CPT or a modifier exists and this is first pass
 ... S IBMOD=$$GETMOD^IBEFUNC(IBIFN,Z0,1)
 ... Q:$S($P(Z1,U)'["ICPT":1,QQ=1:IBMOD'="",1:0)
 ... S IBPO=+$P(Z1,U,4),IBX1=$P(Z1,U,2)
 ... K IBP(+Z1_U_IBMOD,Z,Z0)
 . ;
 . I IBX'="" D  ; revenue code is valid
 .. F Z=900:1 S Z0=$S(IBPO:IBPO,$D(IBX(" "_$P(IBX,U),Z)):0,1:Z) I Z0 S IBPO=Z0 Q
 .. S IBX(" "_$P(IBX,U),IBPO,IBDA)=IBX,IBX(" "_$P(IBX,U),IBPO,IBDA,"DT")=$S(IBX1:IBX1,1:IBDEF),IBX(" "_$P(IBX,U),IBPO,IBDA,"MOD")=IBMOD
 ;
 S IBS="" F  S IBS=$O(IBX(IBS)) Q:IBS=""  S IBPO=0 F  S IBPO=$O(IBX(IBS,IBPO)) Q:'IBPO  D
 . S IBDA=0 F  S IBDA=$O(IBX(IBS,IBPO,IBDA)) Q:'IBDA  S IBX=$G(IBX(IBS,IBPO,IBDA)),IBZ=$G(^DGCR(399,IBIFN,"RC",IBDA,0)) I IBX'="" D
 .. ;S IBXS=$P(IBZ,U,2)_U_$P(IBZ,U,6)_U_$G(IBX(IBS,IBPO,IBDA,"MOD"))
 .. S IBXS=U_$P(IBZ,U,6)_U_$G(IBX(IBS,IBPO,IBDA,"MOD")) ;combine same proc and modifiers regardless of rate
 .. S:IBPO'<900&'$$ACCRV($P(IBS," ",2))&$S(IBINPAT:$P(IBZ,U,6),1:1) IBCOMB(IBS,IBXS,IBPO)=IBDA
 .. S:'$D(IBX1(IBS,IBPO,IBXS,1)) IBX1(IBS,IBPO,IBXS,1)=IBX,IBX1(IBS,IBPO,IBXS,2)=IBZ
 .. S $P(IBX1(IBS,IBPO,IBXS),U)=$P($G(IBX1(IBS,IBPO,IBXS)),U)+$P(IBZ,U,3)
 .. S $P(IBX1(IBS,IBPO,IBXS),U,2)=$P($G(IBX1(IBS,IBPO,IBXS)),U,2)+$P(IBZ,U,4)
 .. S IBX1(IBS,IBPO,IBXS,"DT")=$G(IBX(IBS,IBPO,IBDA,"DT")),IBX1(IBS,IBPO,IBXS,"IEN")=$G(IBX1(IBS,IBPO,IBXS,"IEN"))_$S($G(IBX1(IBS,IBPO,IBXS,"IEN")):";",1:"")_IBDA
 ;
 S IBS="" F  S IBS=$O(IBX1(IBS)) Q:IBS=""  S IBPO=899 F  S IBPO=$O(IBX1(IBS,IBPO)) Q:'IBPO  D  ; Check to combine like rev codes without print order
 . N Q,Q0,Q1,Z,Z0,Z1,Z2,IBZ1,IBZ2
 . S Z=""
 . N IBACC
 . F  S Z=$O(IBX1(IBS,IBPO,Z)) Q:Z=""  S Q=IBPO F  S Q=$O(IBCOMB(IBS,Z,Q)) Q:'Q  I Q'=IBPO S IBZ1=$G(IBX1(IBS,IBPO,Z,1)),IBZ2=$G(IBX1(IBS,IBPO,Z,2)) D
 .. Q:$G(IBX1(IBS,IBPO,Z,1))'=$G(IBX1(IBS,Q,Z,1))
 .. S Q1=1,IBACC=$$ACCRV(+$P(IBS," ",2))
 .. F Q0=1,5:1:7,10:1:13,15 D  Q:'Q1
 ... I IBACC Q:Q0=5!(Q0>6)
 ... I (Q0=11!(Q0=15))&($P($G(IBX1(IBS,Q,Z,2)),U,10)=3) Q
 ... I Q0=5,'IBINPAT Q
 ... I $P($G(IBX1(IBS,IBPO,Z,2)),U,Q0)'=$P($G(IBX1(IBS,Q,Z,2)),U,Q0) S Q1=0
 .. Q:'Q1
 .. S $P(IBX1(IBS,IBPO,Z,2),U,3)=$P(IBX1(IBS,IBPO,Z,2),U,3)+$P(IBX1(IBS,Q,Z,2),U,3)
 .. S $P(IBX1(IBS,IBPO,Z,2),U,4)=$P(IBX1(IBS,IBPO,Z,2),U,4)+$P(IBX1(IBS,Q,Z,2),U,4)
 .. S $P(IBX1(IBS,IBPO,Z,2),U,9)=$P(IBX1(IBS,IBPO,Z,2),U,9)+$P(IBX1(IBS,Q,Z,2),U,9)
 .. S IBX1(IBS,IBPO,Z)=$P(IBX1(IBS,IBPO,Z,2),U,3)_U_$P(IBX1(IBS,IBPO,Z,2),U,4)
 .. S IBX1(IBS,IBPO,Z,"IEN")=IBX1(IBS,IBPO,Z,"IEN")_";"_IBX1(IBS,Q,Z,"IEN")
 .. K IBX1(IBS,Q,Z)
 ;
 S IBS="",IBLN=0
 F  S IBS=$O(IBX1(IBS)) Q:IBS=""  S IBPO=0 F  S IBPO=$O(IBX1(IBS,IBPO)) Q:'IBPO  S IBSS="" F  S IBSS=$O(IBX1(IBS,IBPO,IBSS)) Q:IBSS=""  D
 . S IBX=$G(IBX1(IBS,IBPO,IBSS,1)),IBZ=$G(IBX1(IBS,IBPO,IBSS,2))
 . S IBLN=$G(IBLN)+1,IBXDATA(IBLN)=$P(IBX,U)_U_$P(IBZ,U,6)_U_$P(IBZ,U,2)_U_+IBX1(IBS,IBPO,IBSS)_U_+$P(IBX1(IBS,IBPO,IBSS),U,2),$P(IBXDATA(IBLN),U,10)=$G(IBX1(IBS,IBPO,IBSS,"DT"))
 . S $P(IBXDATA(IBLN),U,6)=$P(IBZ,U,9),$P(IBXDATA(IBLN),U,7)=$P(IBZ,U,13),$P(IBXDATA(IBLN),U,8)=$G(IBX1(IBS,IBPO,IBSS,"IEN")),$P(IBXDATA(IBLN),U,9)=$P($P(IBSS,U,3),",",1,2)
 . ; Extract line lev COB data for sec or tert bill
 . I $$COBN^IBCEF(IBIFN)>1 D COBLINE^IBCEU6(IBIFN,IBLN,.IBXDATA,,.IBXTRA) I $D(IBXTRA) D COMBO^IBCEU2(.IBXDATA,.IBXTRA,1) ;Handle bundled/unbundled
 I $D(^IBA(362.4,"AIFN"_IBIFN))!$D(^IBA(362.5,"AIFN"_IBIFN)) D
 . N IBARRAY,IBX,IBZ,IBRX,IBLCNT
 . S IBLCNT=0
 . ; Print prescriptions, prosthetics on front of UB-04
 . D SET^IBCSC5A(IBIFN,.IBARRAY)
 . I $P(IBARRAY,U,2) D
 .. S IBX=+$P(IBARRAY,U,2)+2
 .. S IBLCNT=IBLCNT+1,IBXSAVE("RX-UB-04",IBLCNT)=""
 .. S IBLCNT=IBLCNT+1,IBXSAVE("RX-UB-04",IBLCNT)="PRESCRIPTION REFILLS:",IBLCNT=2
 .. S IBX=0 F  S IBX=$O(IBARRAY(IBX)) Q:IBX=""  S IBY=0 F  S IBY=$O(IBARRAY(IBX,IBY)) Q:'IBY  S IBRX=IBARRAY(IBX,IBY) D
 ... D ZERO^IBRXUTL(+$P(IBRX,U,2))
 ... S IBLCNT=IBLCNT+1,IBXSAVE("RX-UB-04",IBLCNT)=IBX_$J(" ",(11-$L(IBX)))_" "_$J($S($P(IBRX,U,6):"$"_$FN($P(IBRX,U,6),",",2),1:""),10)_"  "_$J($$FMTE^XLFDT(IBY,2),8)_"  "_$G(^TMP($J,"IBDRUG",+$P(IBRX,U,2),.01))
 ... S IBZ=$S(+$P(IBRX,U,4):"QTY: "_$P(IBRX,U,4)_" ",1:"")_$S(+$P(IBRX,U,3):"for "_$P(IBRX,U,3)_" days supply ",1:"") I IBZ'="" S IBLCNT=IBLCNT+1,IBXSAVE("RX-UB-04",IBLCNT)=$J(" ",35)_IBZ
 ... S IBZ=$S($P(IBRX,U,5)'="":"NDC #: "_$P(IBRX,U,5),1:"") I IBZ'="" S IBLCNT=IBLCNT+1,IBXSAVE("RX-UB-04",IBLCNT)=$J(" ",35)_IBZ
 ... K ^TMP($J,"IBDRUG")
 ... Q
 . ;
 . D SET^IBCSC5B(IBIFN,.IBARRAY)
 . I $P(IBARRAY,U,2) D
 .. S IBLCNT=0
 .. S IBX=+$P(IBARRAY,U,2)+2
 .. S IBLCNT=IBLCNT+1,IBXSAVE("PROS-UB-04",IBLCNT)=""
 .. S IBLCNT=IBLCNT+1,IBXSAVE("PROS-UB-04",IBLCNT)="PROSTHETIC REFILLS:",IBLCNT=2
 .. S IBX=0 F  S IBX=$O(IBARRAY(IBX)) Q:IBX=""  S IBY=0 F  S IBY=$O(IBARRAY(IBX,IBY)) Q:'IBY  D
 ... S IBLCNT=IBLCNT+1,IBXSAVE("PROS-UB-04",IBLCNT)=$$FMTE^XLFDT(IBX,2)_" "_$J($S($P(IBARRAY(IBX,IBY),U,2):"$"_$FN($P(IBARRAY(IBX,IBY),U,2),",",2),1:""),10)_"  "_$E($$PINB^IBCSC5B(+IBARRAY(IBX,IBY)),1,54)
 Q
 ;
ACCRV(X) ; Returns 1 if X is an accomodation RC, 0 if not
 Q ((X'<100&(X'>219))!(X=224))
 ;
