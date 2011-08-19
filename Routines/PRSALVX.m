PRSALVX ;HISC/REL - Cancel Leave Request ;12/15/04
 ;;4.0;PAID;**61,93,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 N SKIP,ZOLD
 S DFN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9) I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0))
 I 'DFN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" G EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8) S:TLE="" TLE="   " S TLI=+$O(^PRST(455.5,"B",TLE,0))
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?29,"CANCEL LEAVE REQUESTS"
 S X=$G(^PRSPC(DFN,0)) W !!,$P(X,"^",1) S X=$P(X,"^",9) I X W ?50,"XXX-XX-",$E(X,6,9)
 K %DT S %DT="AEFX",%DT("A")="Begin with Date: ",%DT("B")="T" W ! D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 EX S EDT=9999999-Y
 W ! S NUM=1 D DISP^PRSALVS
 G:'CNT EX
X1 R !!,"Cancel Which Request #? ",X:DTIME G:'$T!("^"[X) EX I X'?1N.N!(X<1)!(X>CNT) W *7," Enter # of Request to Cancel" G X1
 S X=+X,DA=R(X)
 ;
 ; if request is approved and employee has any part-time physician memos
 ; then lock appropriate pay periods
 K PPLCK,PPLCKE
 S SKIP=0
 S ZOLD=$G(^PRST(458.1,DA,0))
 I $P(ZOLD,U,12),$$PTP^PRSPUT3($P(ZOLD,U,2)) D
 . ; lock applicable time cards
 . D LCK^PRSPAPU($P(ZOLD,U,2),$$FMADD^XLFDT($P(ZOLD,U,3),-1),$P(ZOLD,U,5),.PPLCK,.PPLCKE)
 . ; if problem locking time cards
 . I $D(PPLCKE) D
 . . S SKIP=1 ; set flag to skip cancel of leave
 . . D TCULCK^PRSPAPU($P(ZOLD,U,2),.PPLCK) ; unlock any locked PP
 . . D RLCKE^PRSPAPU(.PPLCKE) ; report problems
 . . K PPLCK,PPLCKE
 Q:SKIP  ; don't proceed with cancel
 ;
 ; cancel leave request
 S $P(^PRST(458.1,DA,0),"^",9)="X" K ^PRST(458.1,"AR",DFN,DA)
 ;
 ; if timecards were locked (PTP), unpost the leave and remove the locks
 I $D(PPLCK) D
 . D ULR^PRSPLVA(ZOLD)
 . D TCULCK^PRSPAPU($P(ZOLD,U,2),.PPLCK)
 . K PPLCK
 ;
 ; update T&L action counts
 D UPD^PRSASAL W "  ... done"
EX G KILL^XUSCLEAN
