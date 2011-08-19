IBCEU2 ;ALB/TMP - EDI UTILITIES FOR AUTO ADD OF CODES ON BILL ;20-OCT-99
 ;;2.0;INTEGRATED BILLING;**51,137,155,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
AUTOCK(IBIFN,IBQUIET) ; Auto add any codes necessary based on data
 ; existing on bill, if needed.
 ; IBQUIET - optional parameter - equals 1 to suppress screen display
 ;
 N IBCOBN,IBFL,DIE,DA,DR
 S DR="",IBCOBN=$$COBN^IBCEF(IBIFN)
 ;
 ;Look for prior payments value codes A1, A2 and occur code 24, if needed
 ;I IBCOBN>1 D PRPAY(IBIFN,IBCOBN,$G(IBQUIET))
 ;
 ;Look for occur codes A1,B1,C1 for subscriber date of birth, if needed
 D SUBDOB(IBIFN,IBCOBN,$G(IBQUIET))
 ;
 ; If outpatient bill and no discharge status, add code 01 as default
 I '$$INPAT^IBCEF(IBIFN,1),$$FT^IBCEF(IBIFN)=3 D
 . ;Default discharge status for outpt UB to '01'
 . D F^IBCEF("N-PATIENT STATUS","IBZ",,IBIFN)
 . I IBZ="" D
 .. N Z S Z=0 F  S Z=$O(^DGCR(399.1,"C","01",Z)) Q:'Z  I $P($G(^DGCR(399.1,Z,0)),U,6) Q
 .. I Z S DR=DR_$S(DR'="":";",1:"")_"162////"_Z
 . ; Default admit source to 2
 . D F^IBCEF("N-SOURCE OF ADMISSION","IBZ",,IBIFN)
 . I IBZ="" S DR=DR_$S(DR'="":";",1:"")_"159///2"
 ;
 ; If inpatient bill and no 01 or 02 value code, add 01 value code with
 ; the highest value of all 101 entries
 I $$INPAT^IBCEF(IBIFN,1) D
 . N IBTOB,IBND0,IBFL,IBOK,Z,Z0,IBAMT,DIC,DR,DIE,DA,DO,DD,DLAYGO,X,Y
 . S IBND0=$G(^DGCR(399,IBIFN,0)),IBTOB=$P(IBND0,U,24)_$P($G(^DGCR(399.1,+$P(IBND0,U,25),0)),U,2)
 . I IBTOB'="11",IBTOB'="18",IBTOB'="21" Q
 . S IBOK=0
 . D F^IBCEF("N-VALUE CODES",,,IBIFN)
 . S Z=0 F  S Z=$O(IBFL(39,Z)) Q:'Z  I $P(IBFL(39,Z),U)="01"!($P(IBFL(39,Z),U)="02") S IBOK=1 Q
 . Q:IBOK
 . S Z=0,IBAMT=0
 . F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  S Z0=$P($G(^DGCR(399.2,+$G(^DGCR(399,IBIFN,"RC",Z,0)),0)),U) I Z0=101,IBAMT<$P($G(^DGCR(399,IBIFN,"RC",Z,0)),U,2) S IBAMT=$P(^(0),U,2)
 . I IBAMT D
 .. S DA(1)=IBIFN,DLAYGO=399.047,DIC(0)="L",DIC="^DGCR(399,"_DA(1)_",""CV"",",DIC("DR")=".02////"_IBAMT
 .. S X=0 F  S X=$O(^DGCR(399.1,"C","01",X)) Q:'X  I $P($G(^DGCR(399.1,X,0)),U,11) Q
 .. I X D FILE^DICN
 .. K DIC,DO,DD,DLAYGO
 I DR'="" S DA=IBIFN,DIE="^DGCR(399," D ^DIE
 Q
 ;
PRPAY(IBIFN,IBCOBN,IBQUIET) ; Output value cd A1 or A2 for prior payments, if needed
 ; IBIFN = ien of bill in file 399
 ; IBCOBN = the COB sequence number for bill (2=secondary, 3=tertiary)
 ; IBQUIET = 1 to suppress screen display
 ;
 N IBNEED,IBNEED24,IB24,IBV,IBVN,DIC,DA,DLAYGO,DD,DO,Z,Z0
 S (IBCT,IBNEED)=0,IBNEED24=1,(IB24(24),IB24("A1"),IB24("A2"))=0
 S Z=0 F  S Z=$O(^DGCR(399.1,"C1",24,Z)) Q:'Z  I $P($G(^DGCR(399.1,Z,0)),U,4) S IB24(24)=Z Q  ;Occurrence code 24
 F Z0="A1","A2" S Z=0 F  S Z=$O(^DGCR(399.1,"C1",Z0,Z)) Q:'Z  I $P($G(^DGCR(399.1,Z,0)),U,11) S IB24(Z0)=Z Q  ;Value codes A1 and A2
 F Z="A1","A2" I $D(^DGCR(399,IBIFN,"I"_$P(Z,"A",2)+1)),IB24(Z) D
 . I '$D(^DGCR(399,IBIFN,"CV","B",+IB24(Z))) S IBNEED(Z)="",IBNEED=IBNEED+1 Q
 . S Z0=0 F  S Z0=$O(^DGCR(399,IBIFN,"CV","B",+IB24(Z),Z0)) Q:'Z0  S IBV(Z)=$G(^DGCR(399,IBIFN,"CV",Z0,0)) I Z="A1" S IBNEED24=$S($P(IBV(Z),U,2):0,1:1)
 ;
 I $D(^DGCR(399,IBIFN,"OC","B",+IB24(24))) S IBNEED24=0
 I 'IBNEED24,'IBNEED Q
 I IBNEED D
 . N IBZ,IBXDATA
 . D F^IBCEF("N-OTH INSURANCE PRIOR PAYMENT","IBZ",,IBIFN) Q:'$O(IBZ(0))  ;No prior payment data found
 . F Z="A1","A2" I $D(IBNEED(Z)) S Z0=$TR(Z,"A"),IBNEED(Z)=$G(IBZ(Z0)) S:IBNEED(Z) IBCT=IBCT+1,IBVN(Z)="" I Z="A1",$P(IBNEED(Z),U,2) S IBNEED24=0
 ;
 I IBNEED24 D
 . N Z1,IBZ,IBXDATA
 . ; Get primary's EOB data if possible - find EOB reject date
 . D F^IBCEF("N-EOB ENTRIES","IBZ",,IBIFN)
 . Q:'$O(IBZ(1,0))  ;EOB entry not found for primary insurance
 . S (IB24,Z)=""
 . F  S Z=$O(IBZ(1,Z),-1) Q:'Z  S Z0=$G(^IBM(361.1,+IBZ(1,Z),0)),Z1=+$G(^(1)) I 'Z1 S IB24=$P(Z0,U,6)\1 Q:IB24
 . Q:'IB24
 . W:'$G(IBQUIET) !,"Adding occurrence code 24 and primary insurance rejection date to bill"
 . S DA(1)=IBIFN,DIC="^DGCR(399,"_IBIFN_",""OC"",",X=IB24(24),DLAYGO=399.041
 . S DIC("P")=$$GETSPEC^IBEFUNC(399,41),DIC(0)="L",DIC("DR")=".02////"_IB24
 . D FILE^DICN K DO,DD,DIC,DLAYGO
 ;
 I IBNEED D
 . W:'$G(IBQUIET) !!,"Adding value code",$S(IBCT=2:"s A1 and A2",1:$O(IBVN("")))," for reporting of bill's prior payments"
 . ; Adding codes to bill
 . F Z="A1","A2" I $D(IBVN(Z)) D
 .. S DA(1)=IBIFN,DIC="^DGCR(399,"_IBIFN_",""VC"",",X=IB24(Z),DLAYGO=399.047
 .. S DIC("P")=$$GETSPEC^IBEFUNC(399,47),DIC(0)="L",DIC("DR")=".02////"_+$P(IBNEED(Z),U,2)
 .. D FILE^DICN K DO,DD,DIC,DLAYGO
 ;
 Q
 ;
SUBDOB(IBIFN,IBCOBN,IBQUIET) ; Add occurrence codes A1,B1,C1 as needed for subscriber DOB
 ; IBIFN = ien of bill in file 399
 ; IBQUIET = 1 to suppress screen display
 ;
 N IBZ,Z,Z0,IBVOC,DR
 S (IBVOC("A1"),IBVOC("B1"),IBVOC("C1"))=0
 F Z0="A1","B1","C1" S Z=0 F  S Z=$O(^DGCR(399.1,"C1",Z0,Z)) Q:'Z  I $P($G(^DGCR(399.1,Z,0)),U,4) S IBVOC(Z0)=Z Q  ;Occurrence codes A1, B1, C1
 F Z=1,2,3 I $D(^DGCR(399,IBIFN,"I"_Z)) D
 . N IBZ1,IBZ2,IBOC,DIC,DA,DLAYGO,DO,DD,X,Y
 . S IBOC=$E("ABC",Z)_"1"
 . Q:'IBVOC(IBOC)
 . Q:$D(^DGCR(399,IBIFN,"OC","B",IBVOC(IBOC)))  ;Already there
 . I '$D(IBZ) D
 .. D F^IBCEF("N-CURR INSURED DEMOGRAPHICS","IBZ1",,IBIFN)
 .. D F^IBCEF("N-OTH INSURED DEMOGRAPHICS","IBZ2",,IBIFN)
 .. I IBCOBN=1 S IBZ(1)=+$G(IBZ1),IBZ(2)=+$G(IBZ2(1)),IBZ(3)=+$G(IBZ2(2)) Q
 .. I IBCOBN=2 S IBZ(1)=+$G(IBZ2(1)),IBZ(2)=+$G(IBZ1),IBZ(3)=+$G(IBZ2(2)) Q
 .. I IBCOBN=3 S IBZ(1)=+$G(IBZ2(1)),IBZ(2)=+$G(IBZ2(2)),IBZ(3)=+$G(IBZ1)
 . Q:'$G(IBZ(Z))!$D(^DGCR(399,IBIFN,"OC","B",IBOC(IBOC)))
 . W:'$G(IBQUIET) !,"Adding occurrence code '"_IBOC_"' for "_$P("primary^secondary^tertiary",U,Z)_" insurance subscriber's date of birth"
 . S DIC="^DGCR(399,"_IBIFN_",""OC"",",DA(1)=IBIFN,DLAYGO=399.041,DIC(0)="L",DIC("P")=$$GETSPEC^IBEFUNC(399,41),X=IBVOC(IBOC),DIC("DR")=".02////"_IBZ(Z)
 . D FILE^DICN K DO,DD
 Q
 ;
COMBO(IBXDATA,IBXTRA,IBINST) ; Determine the bundled/unbundled codes - add
 ; line items where needed to line item array IBXDATA(line #)
 ; Update referenced line in COB entries returned in IBXDATA
 ; IBXTR = array input with bundled/unbundled procedures
 ;      ("ALL",original line~original procedure~service date,
 ;          new procedure)=COB seq #^sequence # of adjustment in
 ;          IBXDATA(n,"COB",COB seq #,adj#)
 ; IBINST = 1 if institutional claim, 0 if professional
 N Z,Z0,Z1
 S Z="" F  S Z=$O(IBXTRA("ALL",Z)) Q:Z=""  S Z0=$O(IBXTRA("ALL",Z,"")) D
 . ; Unbundled procs will have multiple entries for the combination of
 . ; line~original procedure~service date - one for every new procedure
 . ; Bundled ones will have multiple entries for the same original
 . ; procedure~service date combination
 . ;
 . I $O(IBXTRA("ALL",Z,Z0))'="" S Z0="" F  S Z0=$O(IBXTRA("ALL",Z,Z0)) Q:Z0=""  S IBXTRA("U",Z,Z0)=IBXTRA("ALL",Z,Z0) Q
 . ; Must be bundled
 . S IBXTRA("B",Z0_"~"_$P(Z,"~",3),$P(Z,"~",1,2))=IBXTRA("ALL",Z,Z0)
 K IBXTRA("ALL")
 ;
 ; UNBUNDLED
 I $D(IBXTRA("U")) D  ; Add a new entry to IBXDATA for each new proc
 . S Z="" F  S Z=$O(IBXTRA("U",Z)) Q:Z=""  S Z0="" F  S Z0=$O(IBXTRA("U",Z,Z0)) Q:Z0=""  D
 .. ; Z0 = the new procedure, +Z = the original line to reference
 .. S Z1=+$O(IBXDATA(""),-1)+1,IBXDATA(Z1)=IBXDATA(+Z)
 .. I '$G(IBINST) S $P(IBXDATA(Z1),U,8)=0,$P(IBXDATA(Z1),U,5)=Z0,$P(IBXDATA(+Z,"COB",+IBXTRA("U",Z,Z0),$P(IBXTRA("U",Z,Z0),U,2)),U)=Z1
 .. I $G(IBINST) S $P(IBXDATA(Z1),U,3)=0,$P(IBXDATA(Z1),U,5,6)="0^0",$P(IBXDATA(Z1),U,2)=Z0
 ;
 ; BUNDLED
 I $D(IBXTRA("B")) D  ; Add a new entry to IBXDATA for the new proc
 . N PROC1
 . S Z0="" F  S Z0=$O(IBXTRA("B",Z0)) Q:Z0=""  S PROC1="",Z=$O(IBXTRA("B",Z0,"")) Q:Z=""  D
 .. ; $P(Z0,"~",1) = the new procedure, +Z = the original line to reference
 .. I 'PROC1 N ZP S PROC1=1,Z1=+$O(IBXDATA(""),-1)+1,IBXDATA(Z1)=IBXDATA(+Z),ZP=$P(Z0,"~") D
 ... I '$G(IBINST) S $P(IBXDATA(Z1),U,8)=0,$P(IBXDATA(Z1),U,5)=ZP,$P(IBXDATA(+Z,"COB",+IBXTRA("U",Z,Z0),$P(IBXTRA("U",Z,Z0),U,2)),U)=Z1
 .. I $G(IBINST) S $P(IBXDATA(Z1),U,3)=0,$P(IBXDATA(Z1),U,5,6)="0^0",$P(IBXDATA(Z1),U,2)=ZP
 .. S $P(IBXDATA(+Z,"COB",+IBXTRA("U",Z,Z0),$P(IBXTRA("U",Z,Z0),U,2)),U)=Z1 ;Update original line with reference to the new procedure line
 ;
 Q
 ;
MCRPT(DFN,IBDT) ; Determine if patient has MCRWNR insurance or if they
 ; are at least 65 yrs old, so should be MCR eligible as of IBDT (or DT)
 ; DFN = ien of patient
 N MCR,DOB,Z
 I '$G(IBDT) S IBDT=DT
 S (MCR,Z)=0
 F  S Z=$O(^DPT(2,DFN,2.312,Z)) Q:'Z  I $$MCRWNR^IBEFUNC(+$P($G(^(Z,0)),U)) S MCR=1 Q
 I 'MCR S DOB=+$P($G(^DPT(DFN,0)),U,3) I DOB,$E(DT,1,3)-$E(DOB,1,3)-($E(DT,4,7)<$E(DOB,4,7)) S MCR=1
 Q MCR
 ;
