RCRCVL2 ;ALB/CMS - RC VIEW BILL LIST SORT BUILD ; 09-SEP-97
V ;;4.5;Accounts Receivable;**63,159**;MAR 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
BLDL ; - find data required for the report
 N DFN,PRCABN,PRCABN0,RCAGE,RCAMT,RCCNT,RCCUR,RCY
 I $O(RCSPT(0)) D BLDPT G BLDLQ Q
 S (RCCNT,PRCABN)=0 W !,"Searching Active Bills for match "
 F  S PRCABN=$O(^PRCA(430,"AC",16,PRCABN)) Q:'PRCABN  D GET
BLDLQ K RCSBN,RCCAT,RCCNT,RCSI,RCSIA,RCSIF,RCSPT,RCSIL,RCSAGN,RCSAGX,RCSAMT,RCSRC
 Q
 ;
BLDPT ;If pt. selection use E cross-ref
 N DFN,PRCABN S (RCCNT,DFN)=0
 W !,"Searching TP bills for match "
 F  S DFN=$O(RCSPT(DFN)) Q:'DFN  S PRCABN=0 D
 .F  S PRCABN=$O(^PRCA(430,"E",DFN,PRCABN)) Q:'PRCABN  D GET
 Q
 ;
GET ;
 N RCPDIV,RCDIV,RCX
 S PRCABN0=$G(^PRCA(430,PRCABN,0))
 ;  - check status must be active
 I $P(PRCABN0,U,8)'=16 Q
 ;  - check referral category
 S RCCAT="" D RCCAT^RCRCUTL(.RCCAT)
 I '$D(RCCAT(+$P(PRCABN0,U,2))) Q
 ;  - check division if necessary
 I +$G(RCDIV(0)),'$$DIV^RCRCDIV(PRCABN) Q
 ;  - check the receivable age if necessary
 I +$G(RCSAGN)=0,+$G(RCSAGX)=0 G AMT
 S RCAGE=$$ACTDT^RCRCUTL(PRCABN) Q:'RCAGE
 S RCAGE=$$FMDIFF^XLFDT(DT,RCAGE)
 I $G(RCSAGN),RCAGE<RCSAGN Q
 I $G(RCSAGX),RCAGE>RCSAGX Q
AMT ;  - check the cur bal of bill if necessary
 I $G(RCSAMT) S RCAMT=$$BILL^RCJIBFN2(PRCABN) I $P(RCAMT,U,3)<RCSAMT Q
 ;  - exclude receivables referred to Regional Counsel if necessary
 I '$G(RCSRC) I $P($G(^PRCA(430,PRCABN,6)),"^",4) Q
 ;  - check debtor insurance carrier
 I $D(RCSI),'$$INS Q
 S RCCNT=$G(RCCNT)+1 W "."
 D SCRN^RCRCVL1(PRCABN)
 Q
 ;
INS() ; Get the Insurance company and check to include
 ;
 N PRCA,RCIN
 I $G(RCSIA)="ALL" S Y=1 G INSQ
 I $G(RCSIA)="NULL",$P(PRCABN0,U,9)="" S Y=1 G INSQ
 I $G(RCSIA)="NULL",+$P(PRCABN0,U,9) S Y=0 G INSQ
 I $O(RCSI(0)),$D(RCSI(+$P(PRCABN0,U,9))) S Y=1 G INSQ
 I $O(RCSI(0)),'$D(RCSI(+$P(PRCABN0,U,9))) S Y=0 G INSQ
 D DEBT^RCRCUTL(PRCABN)
 I $G(PRCA("DEBTNM"))="",$G(RCSIF)='"@" S Y=0 G INSQ
 I PRCA("DEBTNM")]$G(RCSIL) S Y=0 G INSQ
 I $G(RCSIF)="" S Y=1 G INSQ
 I $G(RCSIF)]PRCA("DEBTNM") S Y=0 G INSQ
 S Y=1
INSQ Q Y
 ;RCRCVL2
