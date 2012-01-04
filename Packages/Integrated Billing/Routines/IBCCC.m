IBCCC ;ALB/AAS - CANCEL AND CLONE A BILL ;25-JAN-90
 ;;2.0;INTEGRATED BILLING;**80,109,106,51,320,433,432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRCC
 ;
 ;STEP 1 - cancel bill
 ;STEP 1.5 - entry to clone previously cancelled bill.  (must be cancel)
 ;STEP 2 - build array of IBIDS call screen that asks ok
 ;STEP 3 - pass stub entry to ar
 ;STEP 4 - store stub data in MCCR then x-ref
 ;STEP 4.5 - store claim clone info on "S1" node.
 ;STEP 5 - get remainder of data to move and store in MCCR then x-ref
 ;STEP 6 - go to screens, come out to IBB1 
EN ;
 N IBBCF,IBBCT,IBBCB,IBCCR,IBDBC,IBCNCOPY
 S IBDBC=DT    ;date claim was cloned
 S IBBCB=DUZ   ;user-id of person cloning the claim.
 S IBCNCOPY=1 ; flag indicating this function is entered as the copy/cancel option
 ;
STEP1 I $G(IBCE("EDI"))>1 G END1
 S IBCAN=2,IBQUIT=0,IBAC=6,IBU="UNSPECIFIED"
 I '$G(IBCE("EDI")) D ASK^IBCC
 I $G(IBCE("EDI"))=1 S IB364="" D NOPTF^IBCC
 G:IBQUIT END1
 I 'IBCCCC!('$D(IBIFN)) G STEP1:'$G(IBCE("EDI")),END1
 I $G(IBCE("EDI")) S IBCE("EDI")=2
EN1 ;
STEP1P5 I '$D(IBIFN) S IBCAN=2,IBQUIT=0,IBAC=6 W !,"Copy Previously Cancelled Bill.",!! S DIC="^DGCR(399,",DIC("S")="I $P(^(0),U,13)=7",DIC(0)="AEMQZ",DIC("A")="Enter BILL NUMBER or Patient NAME: " D ^DIC G:Y<1 END S IBIFN=+Y
 ;
 S IBBCF=IBIFN    ;this is the claim we are copying FROM
 S IBIDS(.15)=IBIFN K IBIFN
STEP2 S IBND0=^DGCR(399,IBIDS(.15),0) I $D(^("U")) S IBNDU=^("U")
 ; *** Note - all these fields should also be included in WHERE^IBCCC1
 ; IB*2.0*432 added check of variable IBSILENT to allow COB copy in background mode
 F I=2:1:12 S:$P(IBND0,"^",I)]"" IBIDS(I/100)=$P(IBND0,"^",I)
 F I=16:1:19,21:1:27 S:$P(IBND0,"^",I)]"" IBIDS(I/100)=$P(IBND0,"^",I)
 F I=151,152,155 S IBIDS(I)=$P(IBNDU,"^",(I-150))
 S IBIDS(159.5)=$P(IBNDU,U,20)
 ; ***
 D:$G(IBSILENT)="" HOME^%ZIS
 S DFN=IBIDS(.02) D DEM^VADPT
 I +$G(IBCTCOPY)!$G(IBCE("EDI")) G STEP3
 D ^IBCA1
ASK S IBYN=0 W !!,"IS THE ABOVE INFORMATION CORRECT AS SHOWN" S %=1 D YN^DICN G END:%=2,STEP3:%=1 I % G END
 W !!?4,"YES - If this information is correct as shown and you wish to file the bill.",!?4,"NO  - If you wish to change this information prior to filing."
 W !?4,"'^' - Enter the up-arrow character to DELETE this Bill at this time." G ASK
 ;
STEP3 ;
 S PRCASV("SER")=$P($G(^IBE(350.9,1,1)),"^",14)
 S PRCASV("SITE")=$P($$SITE^VASITE,"^",3),IBNWBL="",PRCASV("ARCRD")=$G(IBCNCRD)
 ; IA#386 & 1992  If user came from CRD option, need to pass old bill # and claim ien, as well as new iteration number
 I $G(IBCNCRD)=1 S PRCASV("ARREC")=IBBCF,PRCASV("ARBIL")=PRCASV("SITE")_"-"_$P(IBITN,"-"),PRCASV("ARITN")=PRCASV("SITE")_"-"_IBITN
 W:$G(IBSILENT)="" !,"Passing bill to Accounts Receivable Module..." D SETUP^PRCASVC3 I $S($P(PRCASV("ARREC"),"^")=-1:1,$P(PRCASV("ARBIL"),"^")=-1:1,1:0) W:$G(IBSILENT)="" *7,"  ",$P(PRCASV("ARREC"),"^",2),$P(PRCASV("ARBIL"),"^",2) G END
 S IBIDS(.01)=$P(PRCASV("ARBIL"),"-",2),IBIDS(.17)=$S($D(IBIDS(.17)):IBIDS(.17),1:PRCASV("ARREC"))
 I '$G(IBCE("EDI")) W !,"Billing Record #",IBIDS(.01)," being established for '",VADM(1),"'..." S IBIDS(.02)=DFN,IBHV("IBIFN")=$S($G(IBIFN):IBIFN,1:$G(IBIDS(.15)))
 G ^IBCCC1 ;go to step4
 Q
 ;
END W:$G(IBSILENT)="" !!,"No Billing Record Set up.  You must manually enter the bill."
END1 K %,%DT,IBCAN,IBAC,IBND0,IBNDU,IBYN,IBCCCC,IBIFN,IB,IBA,IBNWBL,IBBT,IBIDS,IBU,I,J,VA,VADM,X,X1,X2,X3,X4,D,Y
 ;I '$G(IBQUIT),$S(+$G(IBCNCOPY):1,1:'$G(IBCE("EDI"))) G STEP1
 I '$G(IBQUIT),$S(+$G(IBCNCOPY)!(+$G(IBCNCRD)):1,1:'$G(IBCE("EDI"))) G STEP1
 K IBQUIT,IBCNCOPY,IBCNCRD
 Q
 ;
ITN(IBX) ; determine iteration # for rejected or denied claim
 N IBCF,IBCL
 S IBCF=$P($G(^DGCR(399,IBX,"S1")),U,2)
 ; if this claim has never been cloned, iteration # is -01
 Q:IBCF="" $P($G(^DGCR(399,IBX,0)),U)_"-01"
 S IBCL=$P($G(^DGCR(399,IBCF,0)),U)
 ; if claim was a CLON 1st and now a CORRECT, this is the 1st iteration
 I $P(IBCL,"-")'=$P($P($G(^DGCR(399,IBX,0)),U),"-") Q $P($G(^DGCR(399,IBX,0)),U)_"-01"
 ; to determine iteration#, need to incriment from claim that was cloned from
 S IBITN=$P(IBCL,"-",2),IBITN=IBITN+1 I $L(IBITN)=1 S IBITN="0"_IBITN
 Q $P(IBCL,"-")_"-"_IBITN
 ;
CRD ; new entry point if user comes from CRD option instead of CLON  
 N IBBCF,IBBCT,IBBCB,IBCCR,IBDBC,IBCNCRD,IBITN
 S IBDBC=DT    ;date claim was cloned
 S IBBCB=DUZ   ;user-id of person cloning the claim.
 S IBCNCRD=1 ; flag indicating this function is entered as the CRD option
 G STEP1
 Q
 ;
