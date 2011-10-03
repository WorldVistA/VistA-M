PRCASVC1 ;SF-ISC/YJK-ACCEPT, AMMEND AND CANCEL AR BILL ;5/1/95  3:05 PM
 ;;4.5;Accounts Receivable;**1,68,48,84,157**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
AMEND ;  amend the bill in AR
 D CANCEL
 Q
 ;
 ;
CANCEL ;  cancel the bill in AR
 N X
 S X=$$CANCEL^RCBEIB($G(PRCASV("ARREC")),$G(PRCASV("DATE")),$G(PRCASV("BY")),$G(PRCASV("AMT")),$G(PRCASV("COMMENT")))
 Q
 ;
 ;
STATUS ;Change the current status of a bill
 S DIE="^PRCA(430,",DA=PRCASV("ARREC"),DR="[PRCASV STATUS]" D ^DIE K DR,DIE
 I $D(^PRCA(430,+DA,0)),("^27^31^"[("^"_$P(^(0),"^",2)_"^")) D EN^PRCACPV(+DA)
 I $D(^PRCA(430,+DA,0)),($P(^(0),"^",2)=30),'$$AUD^IBRFN(+DA) D EN^PRCACPV(+DA)
 K DA
 Q
