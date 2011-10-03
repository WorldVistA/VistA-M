IBCSC8 ;ALB/MJB - MCCR SCREEN 8 (UB-82 BILL SPECIFIC INFO)  ;27 MAY 88 10:20
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRSC8
 ;
EN S IBCUBFT=$$FT^IBCU3(IBIFN) I IBCUBFT=2 K IBCUBFT G ^IBCSC8H ; hcfa 1500
 I IBCUBFT=3 K IBCUBFT G ^IBCSC82 ; ub-92
 ;I $P(^DGCR(399,IBIFN,0),"^",19)=2 G ^IBCSC8H ;hcfa 1500
 D ^IBCSCU S IBSR=8,IBSR1="",IBV1="00000000" S:IBV IBV1="11111111" F I="U","U1",0 S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 D H^IBCSCU
 S Z=1,IBW=1 X IBWW W " Bill Remark    : ",$S($P(IB("U1"),U,8)]"":$P(IB("U1"),U,8),1:IBUN)
 S IBX="^^^2^9^27^45" F I=4:1:7 S Z=(I-2),IBW=1 X IBWW W " Form Locator ",$P(IBX,U,I),$S($E($P(IBX,U,I),2)="":" : ",1:": "),$S($P(IB("U1"),U,I)]"":$P(IB("U1"),U,I),1:IBUN)
 S IBX=91 F I=13,14 S Z=(I-7),IBW=1,IBX=IBX+1 X IBWW W " Form Locator ",IBX,": ",$S($P(IB("U1"),U,I)]"":$P(IB("U1"),U,I),1:IBUN)
 S Z=8,IBW=1 X IBWW W " Tx Auth. Code  : ",$S($P(IB("U"),U,13)]"":$P(IB("U"),U,13),1:IBUN)
 G ^IBCSCP
Q Q
 ;IBCSC8
