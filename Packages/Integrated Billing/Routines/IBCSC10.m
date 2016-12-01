IBCSC10 ;ALB/MJB - MCCR SCREEN 10 (UB-82 BILL SPECIFIC INFO)  ;27 MAY 88 10:20
 ;;2.0;INTEGRATED BILLING;**432,547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRSC8
 ;
 ; DEM;432 - Moved IBCSC8* billing screen routines to IBCSC10* billing screen
 ;           routines and created a new billing screen 8 routine IBCSC8.
 ;
EN S IBCUBFT=$$FT^IBCU3(IBIFN) I IBCUBFT=2 K IBCUBFT G ^IBCSC10H ; hcfa 1500
 I IBCUBFT=3 K IBCUBFT G ^IBCSC102 ; ub-92
 ;I $P(^DGCR(399,IBIFN,0),"^",19)=2 G ^IBCSC10H ;hcfa 1500
 D ^IBCSCU S IBSR=10,IBSR1="",IBV1="000000000" S:IBV IBV1="111111111" F I="U","U1",0 S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 D H^IBCSCU
 S Z=1,IBW=1 X IBWW W " Bill Remark    : ",$S($P(IB("U1"),U,8)]"":$P(IB("U1"),U,8),1:IBUN)
 S IBX="^^^2^9^27^45" F I=4:1:7 S Z=(I-2),IBW=1 X IBWW W " Form Locator ",$P(IBX,U,I),$S($E($P(IBX,U,I),2)="":" : ",1:": "),$S($P(IB("U1"),U,I)]"":$P(IB("U1"),U,I),1:IBUN)
 S IBX=91 F I=13,14 S Z=(I-7),IBW=1,IBX=IBX+1 X IBWW W " Form Locator ",IBX,": ",$S($P(IB("U1"),U,I)]"":$P(IB("U1"),U,I),1:IBUN)
 S Z=8,IBW=1 X IBWW W " Tx Auth. Code  : ",$S($P(IB("U"),U,13)]"":$P(IB("U"),U,13),1:IBUN)
 G ^IBCSCP
Q Q
 ;
 ;WCJ;IB*2.0*547
ACINTEL(IBINSDAT,IBNEXT) ; build some intelligence in this Alternate ID branching logic called from both screen 10 templates.
 ;
 ; Input:
 ; IBINSDAT - INS DATA node
 ; IBNEXT -where to branch if not correct plan
 ;
 ; Returns - where to branch to
 ;
 N IBPLAN,IBEPT,IBINSPRF
 S IBPLAN=$P(IBINSDAT,U,18)
 I IBPLAN=""  Q IBNEXT
 S IBPLAN=$G(^IBA(355.3,+IBPLAN,0))
 I IBPLAN="" Q IBNEXT
 S IBEPT=$P(IBPLAN,U,15)
 I IBEPT="" Q IBNEXT
 I IBEPT="MX" Q:'$D(^IBE(350.9,1,81,"B")) IBNEXT  ; no medicare set up in site parameters
 I IBEPT'="MX" Q:'$D(^IBE(350.9,1,82,"B")) IBNEXT   ; no commercial set up in site parameters
 S IBINSPRF=$$INSPRF^IBCEF(IBIFN)
 ;
 ; Institutional
 I IBINSPRF=1 Q:'$D(^DIC(36,+IBINSDAT,15,"B")) IBNEXT   ; this insurance company has no institutional set up
 ;
 ; Professional
 I IBINSPRF=0 Q:'$D(^DIC(36,+IBINSDAT,16,"B")) IBNEXT  ; this insurance company has no professional set up
 ;
 ; now it gets complicated :)
 ; there needs to be one set up for this form type in the ins comp file
 ; and also set up for medicare/commercial in the site parameter file
 N IBTMPINS,IBTMPSP,IBLOOP,IBFOUND
 M IBTMPINS=^DIC(36,+IBINSDAT,$S(IBINSPRF=1:15,1:16),"B")
 M IBTMPSP=^IBE(350.9,1,$S(IBEPT="MX":81,1:82),"B")
 S IBLOOP="",IBFOUND=0
 F  S IBLOOP=$O(IBTMPINS(IBLOOP)) Q:IBLOOP=""  D  Q:IBFOUND
 . Q:'$D(IBTMPSP(IBLOOP))
 . S IBFOUND=1
 I IBFOUND Q ""
 Q IBNEXT
 ;IBCSC10
