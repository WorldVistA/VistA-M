RCRCAL2 ;ALB/CMS - RC ACTION BILL LIST SORT BUILD ; 16-JUN-00
V ;;4.5;Accounts Receivable;**63,159**;MAR 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
BLDL ; - find data required for the report
 N DFN,PRCABN,PRCABN0,RCAGE,RCAMT,RCCNT,RCCUR,RCRDT,RCY
 I $O(RCSPT(0)) D BLDPT G BLDLQ Q
 S (RCCNT,RCRDT)=0 W !,"Searching Referred Bills for match "
 F  S RCRDT=$O(^PRCA(430,"AD",RCRDT)) Q:'RCRDT  D
 .S PRCABN=0 F  S PRCABN=$O(^PRCA(430,"AD",RCRDT,PRCABN)) Q:'PRCABN  D GET
BLDLQ K RCSBN,RCCAT,RCCNT,RCSI,RCSIA,RCSIF,RCSPT,RCSIL
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
 S PRCABN0=$G(^PRCA(430,PRCABN,0))
 ;  - check status must be active
 I $P(PRCABN0,U,8)'=16 Q
 ;  - check referral category
 S RCCAT="" D RCCAT^RCRCUTL(.RCCAT)
 I '$D(RCCAT(+$P(PRCABN0,U,2))) Q
 ;  - check division
 I +$G(RCDIV(0)),'$$DIV^RCRCDIV(PRCABN) Q
 ;  - check debtor insurance carrier
 I $D(RCSI),'$$INS Q
 S RCCNT=$G(RCCNT)+1 W "."
 D SCRN^RCRCAL1(PRCABN)
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
 ;RCRCAL2
