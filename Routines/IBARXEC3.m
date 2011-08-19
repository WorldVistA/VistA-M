IBARXEC3 ;ALB/AAS -RX CO-PAY INCOME EXEMPTION CONVERSION ; 2-NOV-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DQ ; -- run background sweep
 ;
 U IO
 S IBJOB=11
 I $G(IBDONE)=1 G REPORT
 S (IBTCNT,IBTECNT,IBTNCNT,IBTAMT,IBTEAMT,IBTNAMT,IBTCECNT,IBTCEAMT,IBTNECNT,IBTBCNT,IBTCBCNT,IBQUIT)=0
 I IBARXJOB>1 S X=^IBE(350.9,1,3) D GET ; -- set variables to previous amounts
 ;
 ; -- Don't allow multiple conversion to run
 D CHK G:IBQUIT DQEND
 ;
 ; -- Start with last patient processed
 S DFN=+$P(^IBE(350.9,1,3),"^",4)
 ;
 S IBDT=$S(IBDT<$$STDATE^IBARXEU:$$STDATE^IBARXEU,1:IBDT)
 F  S DFN=$O(^IB("APTDT",DFN)) Q:'DFN  D CHK Q:IBQUIT  I $O(^IB("APTDT",DFN,(IBDT-.01)))'>IBEDT D PAT I '$D(ZTQUEUED),'(IBTCNT#10) D READ W "."
 I DFN="" S IBDONE=1 D 
 .; --set done flag once completed
 .D NOW^%DTC S $P(^IBE(350.9,1,3),"^",14)=%
 .;
 .D ^IBARXEC2 ;send mail message if done
 .Q
 ;
REPORT ; -- start the report process here
 D:$G(IBDONE)=1 REPORT^IBARXEC1
DQEND D END^IBARXEC ;conversion all done
 Q
 ;
PAT ; -- process one patient
 ;
 K ^TMP($J,"IBARRY") D KVAR^VADPT
 S (IBCNT,IBECNT,IBCECNT,IBNCNT,IBAMT,IBEAMT,IBCEAMT,IBNAMT,IBNECNT,IBBCNT,IBCBCNT)=0
 S IBCNT=1 ;one patient checked
 S IBSTAT=$$RXEXMT^IBARXEU0(DFN,DT) ;get current status
 S:IBSTAT IBECNT=1 S:'IBSTAT IBNCNT=1 ; current status count
 ;
 ; -- must check each charge even if patient is exempt
 D CANCEL^IBARXECA(DFN,IBDT,IBEDT) ;cancel IB charges for patient from beg to end
 D COUNTS
 D CANDT^IBARXEU4 ;see if converted on the fly
 D ARCAN^IBARXEU4(DFN,IBSTAT,$P(IBCANDT,"^"),$P(IBCANDT,"^",2))
 ;
PATQ Q
 ;
 ;
COUNTS ; -- update the counts  -  Variables by:
 ;
 ;      Patient    Totals       Represents
 ;      -------    ------       ----------
 ;  5   ibcnt      ibtcnt   = : total patient count checked
 ;  6   ibecnt     ibtecnt  = : total exempt patients
 ;  7   ibncnt     ibtncnt  = : total non-exempt patients
 ;  8   ibcecnt    ibtcecnt = : total count of exempt charges (rx's)
 ;  9   ibamt      ibtamt   = : total dollar amount checked
 ; 10   ibeamt     ibteamt  = : total exempt dollar amount
 ; 11   ibnamt     ibtnamt  = : total non-exempt dollar amount
 ; 12   ibceamt    ibtceamt = : total cancelled charges amount
 ; 15   ibnecnt    ibtnecnt = : total non-exempt count
 ; 16   ibbcnt     ibtbcnt  = : total bills checked
 ; 17   ibcbcnt    ibtcbcnt = : total number of cancelled bills
 ;
 S IBTCNT=IBTCNT+IBCNT
 S IBTECNT=IBTECNT+IBECNT
 S IBTNCNT=IBTNCNT+IBNCNT
 S IBTCECNT=IBTCECNT+IBCECNT
 S IBTAMT=IBTAMT+IBAMT
 S IBTEAMT=IBTEAMT+IBEAMT
 S IBTNAMT=IBTNAMT+IBNAMT
 S IBTCEAMT=IBTCEAMT+IBCEAMT
 S IBTNECNT=IBTNECNT+IBNECNT
 S IBTBCNT=IBTBCNT+IBBCNT
 S IBTCBCNT=IBTCBCNT+IBCBCNT
 Q:'$D(IBCONVER)
 ;
 ; -- set run paramters for conversion
 S $P(^IBE(350.9,1,3),"^",4,12)=DFN_U_IBTCNT_U_IBTECNT_U_IBTNCNT_U_IBTCECNT_U_IBTAMT_U_IBTEAMT_U_IBTNAMT_U_IBTCEAMT,$P(^(3),"^",15,17)=IBTNECNT_U_IBTBCNT_U_IBTCBCNT
 Q
 ;
CHK ; -- Don't allow multiple conversion to run
 I IBARXJOB'=$P(^IBE(350.9,1,3),"^",3)  W !!,"The Integrated Billing Check of Pharmacy Copay Exemption due to Income",!,"was terminated.  Appears to be already running!" S IBQUIT=1
 Q
 ;
READ ; -- pause, check for an excape
 N X,IBSHOW F  R X:1 Q:'$T  I X["^" D:'$D(IBSHOW) QUIC^IBARXEC1 S IBSHOW=""
 Q
 ;
GET ; -- set initialization variable if restarting
 S IBTCNT=$P(X,"^",5)
 S IBTECNT=$P(X,"^",6)
 S IBTNCNT=$P(X,"^",7)
 S IBTCECNT=$P(X,"^",8)
 S IBTAMT=$P(X,"^",9)
 S IBTEAMT=$P(X,"^",10)
 S IBTNAMT=$P(X,"^",11)
 S IBTCEAMT=$P(X,"^",12)
 S IBTNECNT=$P(X,"^",15)
 S IBTBCNT=$P(X,"^",16)
 S IBTCBCNT=$P(X,"^",17)
 Q
