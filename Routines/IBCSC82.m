IBCSC82 ;ALB/MJB - MCCR SCREEN 8 (UB-04 BILL SPECIFIC INFO) ;27 MAY 88 10:20
 ;;2.0;INTEGRATED BILLING;**51,137,210,232,155,343,349,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN S IBCUBFT=$$FT^IBCU3(IBIFN) I IBCUBFT=2 K IBCUBFT G ^IBCSC8H ;CMS-1500
 ;
 N FIRSTPRV,I,IB,IBINP,IBX,PRV,PRVS,Z
 S IBINP=$$INPAT^IBCEF(IBIFN)
 D ^IBCSCU
 S IBSR=8,IBSR1=2,IBV1="0000000" S:IBINP $E(IBV1,2)=1 S:IBV IBV1="1111111"
 F I="U","U1",0,"UF3","UF31","U2","TX","U3" S IB(I)=$G(^DGCR(399,IBIFN,I))
 N IBZ,IBPRV,IBREQ,IBMRASEC,TEXT,BPZ,TXMT
 D GETPRV^IBCEU(IBIFN,"ALL",.IBPRV)
 K IB("PRV")
 S IBZ=0 F  S IBZ=$O(IBPRV(IBZ)) Q:'IBZ  I $O(IBPRV(IBZ,0))!$D(IBPRV(IBZ,"NOTOPT")) M IB("PRV",IBZ)=IBPRV(IBZ)
 ;
 D H^IBCSCU
 ;
 ; Section 1
 S Z=1,IBW=1 X IBWW W " Bill Remarks",!?5,"- FL-80",?22,": "
 S TEXT=$P($G(^DGCR(399,IBIFN,"UF2")),U,3)  ; field# 402
 I TEXT="" W IBUN                           ; unspecified [not required]
 I TEXT'="" D
 . N IBZ,Z
 . D REMARK^IBCEF77(IBIFN,.IBZ)
 . S Z=0 F  S Z=$O(IBZ(Z)) Q:'Z  D
 .. W ?24,$G(IBZ(Z))
 .. I Z>4 W ?48,$G(IBVI)," <--- This Line Will Not Print ",$G(IBVO)
 .. I $O(IBZ(Z)) W !
 .. Q
 . Q
 ;
 S IBZ="",IBZ=$S($P(IB("UF3"),U,4)]"":"Pri: "_$P(IB("UF3"),U,4),1:"")_$S($P(IB("UF3"),U,5)'="":"  Sec: "_$P(IB("UF3"),U,5),1:"")_$S($P(IB("UF3"),U,6)'="":" Ter: "_$P(IB("UF3"),U,6),1:"")
 S:IBZ="" IBZ=IBUN
 W !,?3," ICN/DCN(s)        : ",IBZ
 S IBZ="",IBZ=$S($P(IB("U"),U,13)]"":"Pri: "_$P(IB("U"),U,13),1:"")_$S($P(IB("U2"),U,8)'="":"  Sec: "_$P(IB("U2"),U,8),1:"")_$S($P(IB("U2"),U,9)'="":"  Ter: "_$P(IB("U2"),U,9),1:"")
 S:IBZ="" IBZ=IBUN
 W !,?3," Tx Auth. Code(s)  : ",IBZ
 ;
 ; IB*2*400 - Admitting diagnosis only for inpatients
 I IBINP W !,?3," Admitting Dx      : " S IBX=$$ICD9^IBACSV(+IB("U2"),$$BDATE^IBACSV(IBIFN)) W $S(IBX'="":$P(IBX,U)_" - "_$P(IBX,U,3),1:IBU)
 ;
 ; IB*2*400 - esg - display PPS (DRG) info for inpatient, UB claims
 I IBINP D
 . N PPS,PPSDISP
 . S PPS=+$P(IB("U1"),U,15)
 . I 'PPS S PPSDISP=IBUN
 . I PPS S PPSDISP=$$FO^IBCNEUT1(PPS,4,"R",0)_" - "_$$DRGTD^IBACSV(PPS,$$BDATE^IBACSV(IBIFN))
 . W !?4,"PPS (DRG)",?22,": ",$E(PPSDISP,1,56)
 . Q
 ;
 I 'IBINP W !,?3," Admission Source  : " S IBX=$$EXTERNAL^DILFD(399,159,,$P(IB("U"),U,9)) W $S(IBX'="":IBX,1:IBU)   ; Outpatient only
 ;
 ; Section 2
 S Z=2,IBW=1 X IBWW
 S PRVS=$TR($P(IB("U3"),U,8,10),U) W " Pt Reason f/Visit : " I PRVS="" W IBU_$S(IBINP:" [NOT USED]",1:"")
 I PRVS'="" S FIRSTPRV=1 F I=8:1:10 D
 .S PRV=$$ICD9^IBACSV($P(IB("U3"),U,I),$$BDATE^IBACSV(IBIFN)) I PRV'="" W:'FIRSTPRV !,?24 W $P(PRV,U,3)_" - "_$P(PRV,U) S FIRSTPRV=0
 .Q
 ;
 ; Section 3
 S Z=3,IBW=1 X IBWW
 W " Providers         : ",$S('$O(IB("PRV",0)):IBU,1:"")
 I $D(IB("PRV")) D
 . N Z,IBT,IBQ,IBARR,IBTAX,IBNOTAX,IBSPEC,IBNOSPEC
 . S IBZ=0
 . D DEFSEC^IBCEF74(IBIFN,.IBARR)
 . ; PRXM/KJH - Add Taxonomy code to display for patch 343. Moved secondary IDs slightly (below).
 . S IBTAX=$$PROVTAX^IBCEF73A(IBIFN,.IBNOTAX)
 . S IBSPEC=$$SPECTAX^IBCEF73A(IBIFN,.IBNOSPEC)
 . F  S IBZ=$O(IB("PRV",IBZ)) Q:'IBZ  D
 .. N A,A1
 .. S IBQ=""
 .. W !,?5,"- "
 .. S A=$$EXPAND^IBTRE(399.0222,.01,IBZ)
 .. I $P($G(IB("PRV",IBZ,1)),U,4)'="" S A1=" ("_$E($P(IB("PRV",IBZ,1),U,4),1,3)_")",A=$E(A,1,15-$L(A1))_A1
 .. W $E(A_$J("",15),1,15),": "
 .. I '$P($G(IB("PRV",IBZ,1)),U,3),$P($G(IB("PRV",IBZ,1)),U)="" W IBU Q
 .. I $P($G(IB("PRV",IBZ,1)),U)'="" W:'$G(IB("PRV",IBZ)) $E($P(IB("PRV",IBZ,1),U)_$J("",20),1,20) W:$G(IB("PRV",IBZ)) "(OLD PROV DATA) "_$P(IB("PRV",IBZ,1),U)
 .. I $P($G(IB("PRV",IBZ,1)),U)="",$P($G(IB("PRV",IBZ)),U)'="" W $E($P(IB("PRV",IBZ),U)_$J("",20),1,20)
 .. W "    Taxonomy: ",$S($P(IBTAX,U,IBZ)'="":$P(IBTAX,U,IBZ),1:IBU),$S($P(IBSPEC,U,IBZ)'="":" ("_$P(IBSPEC,U,IBZ)_")",1:"")
 .. F A=1:1:3 I $G(IBARR(IBZ,A))'="" S IBQ=IBQ_"["_$E("PST",A)_"]"_IBARR(IBZ,A)_" "
 .. I $L(IBQ) W !,?30,$E(IBQ,1,49)
 K IB("PRV")
 ;
 ; Section 4
 S Z=4,IBW=1 X IBWW
 W " Other Facility (VA/non): " S IBZ=$$EXPAND^IBTRE(399,232,+$P(IB("U2"),U,10))
 W $S(IBZ'="":$E(IBZ,1,23),$$PSRV^IBCEU(IBIFN):IBU,1:IBUN)
 I IBZ'="" D
 . ; PRXM/KJH - Add Taxonomy code to display for patch 343.
 . W ?53,"Taxonomy: "
 . S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,3),"X12 CODE") W $S(IBZ'="":IBZ,1:IBU)
 . S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,3),"SPECIALTY CODE") W $S(IBZ'="":" ("_IBZ_")",1:"")
 . Q
 ;
 ; Section 5
 S Z=5,IBW=1 X IBWW
 W " Billing Provider  : "
 K IBZ
 S BPZ=+$$B^IBCEF79(IBIFN)
 D GETBP^IBCEF79(IBIFN,"",BPZ,"UB SCREEN 8",.IBZ)
 S TXMT=$$TXMT^IBCEF4(IBIFN)    ; transmittable?  variable also used in next section
 I TXMT S IBZ=$G(IBZ("UB SCREEN 8","NAME"))     ; this is the BP name used in the PRV segment
 I 'TXMT S IBZ=$$GETFAC^IBCEP8(BPZ,0,0)         ; this is the BP name printed in FL-1
 W $S(IBZ'="":IBZ,1:IBU)                        ; billing provider name
 W !?3," Taxonomy Code     : "
 S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,11),"X12 CODE") W $S(IBZ'="":IBZ,1:IBU)
 S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,11),"SPECIALTY CODE") W $S(IBZ'="":" ("_IBZ_")",1:"")
 ;
 ; Section 6
 S IBREQ=+$$REQMRA^IBEFUNC(IBIFN) S:IBREQ IBREQ=1
 S IBMRASEC=$$MRASEC^IBCEF4(IBIFN)
 S Z=6,IBW=1 X IBWW W " ",$S('IBREQ:"Force To Print?   : ",1:"Force MRA Sec Prt?: ")
 S IBZ=$$EXTERNAL^DILFD(399,27+IBREQ,,+$P(IB("TX"),U,8+IBREQ))
 I IBMRASEC,'$P(IB("TX"),U,8),$P(IB("TX"),U,9) S IBZ="FORCED TO PRINT BY MRA PRIMARY",$P(IB("TX"),U,8)=0
 W $S(IBZ'=""&($P(IB("TX"),U,8+IBREQ)'=""):IBZ,'TXMT:"[NOT APPLICABLE - NOT TRANSMITTABLE]",IBREQ:"NO FORCED PRINT",1:IBZ)
 ;
 ; Section 7
 S Z=7,IBW=1 X IBWW
 W " Provider ID Maint : (Edit Provider ID information)"
 ;
 G ^IBCSCP
Q Q
 ;IBCSC82
