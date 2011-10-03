IBCF13 ;ALB/AAS - PRINT UB-82 FROM A ;8/2/90
 ;;2.0;INTEGRATED BILLING;**63,363**;21-MAR-94;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;MAP TO DGCRP3
 ;
 ;Entry point for AR to print 2nd and 3rd Notice UB-82's
 ;Device handling to be done by calling routine
 ;Requires input  - PRCASV("ARREC") = internal number of bill
 ;                - PRCASV("NOTICE")= number of notice
 ;ouputs          - IBAR("ERR")    = error message
 ;                - IBAR("OKAY")   = 1 normal finish, 0 not finished
 ;
REPRNT N I,J,DFN ;AR variables that need newing
 N IBECME
 K IBAR("ERR")
 S IBAR("OKAY")=0 I '$D(PRCASV("ARREC"))!('$D(PRCASV("NOTICE"))) S IBAR("ERR")="MISSING INPUT VARIABLES" Q
 S IBIFN=PRCASV("ARREC"),IB0=$S($D(^DGCR(399,IBIFN,0)):^(0),1:"") I IB0="" S IBAR("ERR")="BILL NON-EXISTANT" Q
 S DGSTAT=$P(IB0,"^",13) I $S(DGSTAT=3:0,DGSTAT=4:0,1:1) S IBAR("ERR")=$S(DGSTAT=7:"BILL CANCELLED",1:"BILL STATUS INAPPROPRIATE") Q
 ; IB*2*363 next line was added to prevent the print of forms for ePharmacy bills
 Q:$P($G(^DGCR(399,IBIFN,"M1")),"^",8)]""  ;ECME number exists so the bill was electronically submitted
 ; S DFN=$P(IB0,"^",2),IBPNT=PRCASV("NOTICE"),IBAC=4 D ENP^IBCF1
 ; replaced above line with following 2 lines 4/28/92 RLW
 ;S DFN=$P(IB0,"^",2),IBAC=4 I $P(^DGCR(399,IBIFN,0),"^",19)>1 D EN2^IBCF G REPRNTQ
 S DFN=$P(IB0,"^",2),IBAC=4 I $$FT^IBCU3(IBIFN)>1 D EN2^IBCF,EN5^IBCF G REPRNTQ
 S IBPNT=PRCASV("NOTICE") D ENP^IBCF1
 S IBAR("OKAY")=1
REPRNTQ K DFN,I,J
 K M,X,X2,Y,Z,VADM,VAERR,DR,DA,D1,DGBS,DGCNT,IB,IBBILL,IBBNO,IBBT,IBC,IBCPT,IBEPAR,IBDPT,IBDT,IBF,IBIP,IBLS,IBO,IBPNT,DGSTAT,IBAC,IBIFN,IB0
 K IBPTF,IBRATY,IBREV,IBREVC,IBST,IBTF,IBU,IBUTL,DGDA,DGLCNT,DGPAG,DGPT,DGRVC,DGRV,DGTOTPAG,DGTEXT,DGTEXT1,IBDI,IBDIN,IBBS,IBCC,IBPT,DGREVC,DGRSPAC,DGSM
 Q
 ;
PRINT ;Entry for A/R to create option to print bills.
 S IBVIEW=1 D KILL^IBCMENU,GEN^IBCB,KILL^IBCMENU
 Q
