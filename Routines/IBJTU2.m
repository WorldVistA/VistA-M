IBJTU2 ;ALB/ARH - TPI UTILITIES ;6/6/03 1:05pm
 ;;2.0;INTEGRATED BILLING;**39,106,199,211,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PAT() ; select patient, only allows patient's that have bills - returns DFN^NAME if patient selected, 0 otherwise
 N X,Y,DFN,DTOUT,DUOUT,DA
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DFN=0,DIC(0)="AEQM",DIC="^DPT(",DIC("S")="I $D(^DGCR(399,""C"",Y))" D ^DIC K DIC I Y'<1 S DFN=Y
 Q DFN
 ;
BILL() ; select bill, returns bill IFN^BILL NUMBER or 0 if none selected
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 N X,Y,DTOUT,DUOUT,DA,IBY S IBY=0,DIC="^DGCR(399,",DIC(0)="AEMQ" D ^DIC K DIC I Y'<1 S IBY=Y
 Q IBY
 ;
PB() ; select either a patient name (must have a bill) or bill number
 ; if patient chosen: returns "1^"_DFN, if bill chosen: returns "2^"_IBIFN, 0 otherwise
 N IBX,IBY,DIC,DTOUT,DUOUT,DA,X,Y,DPTNOFZY,IBSTR
 S IBY=0
 ;
PB1 R !!,"Enter BILL NUMBER or PATIENT NAME: ",IBX:DTIME I IBX["^"!(IBX="") G PBQ
 ;
 I $E(IBX)="?" D  G PB1
 . W !
 . W !,"   Enter one of following: Patient Name, Bill Number,"
 . W !,"   ECME Number or Prescription Number."
 . W !,"   You may also use prefixes: 'E.' for ECME# or 'R.' for Prescription."
 . W !
 ;
 ; search for patient name
 I IBX?1A4N!(IBX?2A.AP)!(IBX?2.A1",".AP)!(IBX?1A1P.AP) D  I IBY G PBQ
 . S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 . S DIC="^DPT(",DIC(0)="EQM",DIC("S")="I $D(^DGCR(399,""C"",Y))",X=IBX D ^DIC K DIC I Y'<1 S IBY="1^"_+Y
 ;
 ; search for bill number
 I (IBX?1A1.7AN)!(IBX?3N1"-"1A1.7AN)!(IBX?1"`"1.15N)!(IBX=" ") D  I IBY G PBQ
 . S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 . S IBSTR=IBX
 . I $L(IBSTR,"-")=2,$P(IBSTR,"-")?3N S IBSTR=$P(IBX,"-",2,255)
 . S DIC="^DGCR(399,",DIC(0)="EQ",X=IBSTR D ^DIC K DIC I Y'<1 S IBY="2^"_+Y
 ;
 ; search for ECME number REC^IBRFN()
 S IBSTR=IBX
 I IBSTR?1.7N S IBSTR="E."_IBSTR
 I IBSTR?1"E."1.7N S Y=$$REC^IBRFN(IBSTR) I Y>0 S IBY="2^"_+Y G PBQ
 ;
 ; search for RX number REC^IBRFN()
 S IBSTR=IBX
 I IBSTR?1N1.10AN S IBSTR="R."_IBSTR
 I IBSTR?1"R."1N1.10AN S Y=$$REC^IBRFN(IBSTR) I Y>0 S IBY="2^"_+Y G PBQ
 ;
 W "??"
 G PB1
PBQ Q IBY
 ;
RCANC(IBIFN,ARR,WDTH) ; if bill cancelled returns ARR = IBIFN ^ PTR TO 200 ^ INITIALS OF WHO CANCELLED IN IB
 ;                                        ARR(X) = REASON CANCELLED   with line width passed in
 N X,DIWL,DIWR,DIWF,IBDS,IBCNT,IBI,IBD K ARR
 S ARR=0,IBIFN=+$G(IBIFN),IBDS=$G(^DGCR(399,IBIFN,"S"))
 S X=$P(IBDS,U,18) G:'X RCANCQ
 S ARR=IBIFN_U_X_U_$P($G(^VA(200,+X,0)),U,2)
 S X=$P(IBDS,U,19) G:X="" RCANCQ
 S DIWL=1,DIWR=$G(WDTH),DIWF="" D ^DIWP
 S (IBCNT,IBI)=0,DIWL=1 F  S IBI=$O(^UTILITY($J,"W",DIWL,IBI)) Q:'IBI  D
 . S IBD=$G(^UTILITY($J,"W",DIWL,IBI,0)) I IBD'="" S IBCNT=IBCNT+1,ARR(IBCNT)=IBD
 K ^UTILITY($J,"W")
RCANCQ Q
 ;
DR(DB,DE) ; get a date range from the user, DB is default begin date (FM), DE is default end date
 ; returns "begin dt ^ end dt" in FM format, or "" if two valid dates are not entered
 N IBY,IBX,%DT,X,Y S (IBX,IBY)="" I $G(DB)?7N S %DT("B")=$$FMTE^XLFDT(DB,2)
 S %DT="AEX",%DT("A")="Start Date: " D ^%DT K %DT G:Y<0 DRQ S IBX=Y
 S %DT(0)=IBX,%DT("B")=$$FMTE^XLFDT($S(IBX>$G(DE):IBX,1:DE),2)
 S %DT="AEX",%DT("A")="End Date: " D ^%DT K %DT G:Y<0 DRQ S IBY=IBX_U_Y
DRQ Q IBY
