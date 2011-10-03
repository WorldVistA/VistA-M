IBTRKR ;ALB/AAS - CLAIMS TRACKER - AUTO-ENROLLER ; 4-AUG-93
 ;;2.0;INTEGRATED BILLING;**23,43,45,56,214**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
INP ; -- Inpatient Tracker
 ;    called by ibamtd  from DGPM MOVEMENT EVENTS
 ;                                               add   edit   delete
 ;  dgpma = after movement 0th node file 405  : data   data   null
 ;  dgpmp = prior movement 0th node file 405  : null   data   data
 ;  dfn   = ien of patient
 ;  
 N %,%H,%I,IBMVAD,IBMVTP,IBTRKR
 ;
 ;  inpatient claims tracking turned off
 S IBTRKR=$G(^IBE(350.9,1,6)) I '$P(IBTRKR,"^",2) Q
 ;
 ;  movement type 1=admission, 2=transfer, 3=discharge, 6=specialty chg
 S IBMVTP=$S($P(DGPMA,"^",2):$P(DGPMA,"^",2),1:$P(DGPMP,"^",2)) I 'IBMVTP Q
 ;
 ;  $p(14)=admission movement ptr entry in file 405
 S IBMVAD=$S(DGPMA'="":$P(DGPMA,"^",14),1:$P(DGPMP,"^",14)) I 'IBMVAD Q
 ;
 D WRITE("Updating claims tracking ... ",2)
 ;
 I '$D(VAIN(1)) D INP^VADPT
 ;
 ;  add/edit admission
 I IBMVTP=1 D ADMIT Q
 ;
 ;  transfer to asih (patch 23)
 I $P($G(^DGPM(+$P(DGPMA,"^",15),0)),"^",2)=1 S IBMVAD=$P(DGPMA,"^",15) D ADMIT Q
 ;
 ;  specialty change
 I IBMVTP=6 D SPECIAL Q
 ;
 D WRITE("completed.")
 Q
 ;
 ;
WRITE(MSG,FF)         ;  write message on screen if not silent
 ;  write 'F'orm 'F'eeds count followed by msg (optional)
 N %
 I '$D(IB20),'$G(DGQUIET) D
 .   F %=1:1:$G(FF) W !
 .   W MSG
 Q
 ;
 ;
ADMIT ; -- process admission movements
 ;  ibmvad is admission movement pointer to file 405
 ;  dgpma  is movement entry from file 405
 N %,%H,%I,IBCTFLAG,IBNEW,IBRANDOM,IBTRN,LASTADM,LASTDA,LASTDATA
 ;
 ;  this is a deleted admission from file 405, dgpma=null
 I DGPMA="" D DELADMIT Q
 ;
 ;  try and relink to existing entry if already there
 ;  find the last admission, check to make sure its inactive and there
 ;  is not a pointer to the movement file ($p(5)).  if the current
 ;  admission date is within 5 days, update the entry.
 S LASTADM=$O(^IBT(356,"APTY",DFN,+$O(^IBE(356.6,"AC",1,0)),9999999),-1)
 I LASTADM S LASTDA=+$O(^IBT(356,"APTY",DFN,1,LASTADM,0)),LASTDATA=$G(^IBT(356,LASTDA,0)) I $P(LASTDATA,"^",20)=0,$P(LASTDATA,"^",5)="" D  Q:$G(IBCTFLAG)
 .   S %=$$FMDIFF^XLFDT($P(DGPMA,"."),$P(LASTADM,"."))
 .   I %>-5,%<5 D RELINK^IBTRKRU(LASTDA,IBMVAD,$P(DGPMA,"^")),RELBULL^IBTRKRBR(DFN,LASTDA,DGPMA,+$G(VAIN(3))),WRITE("entry re-linked.") S IBCTFLAG=1
 ;
 ;  random sampler, admission date must equal today (dt)
 I +$G(VAIN(3)),($E(+DGPMA,1,7)=DT) S IBRANDOM=$$RANDOM^IBTRKR1(+VAIN(3))
 ;
 N D,D0,DI,DIG,DIH,DIU,DIV,DQ,IBADMDT,IBETYP  ; variables left by ibtutl
 ;  inpatient claims tracking = all patients
 I $P(IBTRKR,"^",2)=2 D  Q
 .   D ADM^IBTUTL(IBMVAD,+$E(+DGPMA,1,12),$G(IBRANDOM),$P(DGPMA,"^",27))
 .   D WRITE("entry "_$S($G(IBNEW):"added.",1:"edited."))
 .   I $G(IBRANDOM),$G(IBTRN) D ADMTBULL^IBTRKRBA(DFN,IBTRN,DGPMA,+$G(VAIN(3)))
 ;
 ;  inpatient claims tracking = insured and ur only
 I $P(IBTRKR,"^",2)=1,$S($G(IBRANDOM):1,'$$INSURED^IBCNS1(DFN,+DGPMA):0,1:$$PTCOV^IBCNSU3(DFN,+DGPMA,"INPATIENT")) D  Q
 .   D ADM^IBTUTL(IBMVAD,+$E(+DGPMA,1,12),$G(IBRANDOM),$P(DGPMA,"^",27))
 .   D WRITE("entry "_$S($G(IBNEW):"added.",1:"edited."))
 .   I $G(IBRANDOM),$G(IBTRN) D ADMTBULL^IBTRKRBA(DFN,IBTRN,DGPMA,+$G(VAIN(3)))
 ;
 ;  inpatient claims tracking = insured and ur only, but not insurred
 ;  need to send off RDV in background
 N IBT
 I $P(IBTRKR,"^",2)=1,'$$INSURED^IBCNS1(DFN,+DGPMA),$$TFL^IBARXMU(DFN,.IBT),'$D(^IBT(356,"ARDV",DFN)) D ADM^IBCNRDV(DFN,IBMVAD,+$E(+DGPMA,1,12),$G(IBRANDOM),$P(DGPMA,"^",27)) D WRITE("Remote Query for insurance sent.") Q
 ;
 ;
 D WRITE("no action taken.")
 Q
 ;
 ;
DELADMIT ;  deleted admission
 N DA,FILE,IBDATE,IBTRN,SPECALTY
 S IBTRN=$O(^IBT(356,"AD",+IBMVAD,0)) I IBTRN D  Q
 .   S SPECALTY=+$P($G(^UTILITY($J,"ATS",+$P(DGPMP,"^"),+$O(^UTILITY($J,"ATS",+$P(DGPMP,"^"),0)))),"^",9)
 .   ;  send information bulletin
 .   D DELBULL^IBTRKRBD(DFN,IBTRN,DGPMP,SPECALTY)
 .   ;  clean up files pointing to 405
 .   F FILE=356.9,356.91,356.94 S DA=0 F  S DA=$O(^IBT(FILE,"C",+IBMVAD,DA)) Q:'DA  D DELETE^IBTRKRU(FILE,DA)
 .   S IBDATE=0 F  S IBDATE=$O(^IBT(356.93,"AMVD",+IBMVAD,IBDATE)) Q:'IBDATE  S DA=0 F  S DA=$O(^IBT(356.93,"AMVD",+IBMVAD,IBDATE,DA)) Q:'DA  D DELETE^IBTRKRU(356.93,DA)
 .   ;  inactivate entry in ct 356
 .   D INACTIVE^IBTRKRU(IBTRN)
 .   D WRITE("entry inactivated.")
 D WRITE("no action taken.")
 Q
 ;
 ;
SPECIAL ;  specialty change
 ;  deleted movement
 I DGPMA="" D WRITE("no action taken.") Q
 ;
 ;  if specialty change is past 7 days, quit
 I +DGPMA<$$FMADD^XLFDT(+DT,-7) D WRITE("no action taken.") Q
 ;
 N IBDT,IBTSA,IBTSP,IBTRC,IBTRN,IBTRV
 ;  treating specialty after
 S IBTSA=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P(DGPMA,"^",9),0)),"^",2),0)),"^",3)
 ;
 ;  treating specialty before
 I DGPMP'="" S IBTSP=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P(DGPMP,"^",9),0)),"^",2),0)),"^",3)
 ;
 I DGPMP="" D
 .   S IBDT=9999999.9999999-$P(DGPMA,"^")
 .   S IBTSP=$P($G(^DIC(45.7,+$O(^(+$O(^DGPM("ATS",+DFN,+IBMVAD,+IBDT)),0)),0)),"^",2)
 .   S IBTSP=$P($G(^DIC(42.4,+IBTSP,0)),"^",3)
 ;
 ;  no change in major bed section
 I IBTSA=IBTSP D WRITE("no action taken.") Q
 ;
 S IBTRN=$O(^IBT(356,"AD",+IBMVAD,0))
 ;
 ;  tracked as hospital review
 I $O(^IBT(356.1,"C",+IBTRN,0)) D
 .   I $$ALREADY(356.1,+DGPMA) Q
 .   D PRE^IBTUTL2($E(+DGPMA,1,7),IBTRN,30)
 .   I $G(IBTRV) D COMMENT^IBTRKRU(356.1,+IBTRV)
 ;
 ;  tracked as insurance review
 I $O(^IBT(356.2,"C",+IBTRN,0)) D
 .   I $$ALREADY(356.2,+DGPMA) Q
 .   I $P($G(^IBT(356,+IBTRN,0)),"^",24) D COM^IBTUTL3($E(+DGPMA,1,12),IBTRN,30)
 .   I $G(IBTRC) D COMMENT^IBTRKRU(356.2,+IBTRC)
 ;
 D WRITE("completed.")
 Q
 ;
 ;
ALREADY(FILE,DATE) ; -- see if already is review for date
 N X,Y,IBX
 S IBX=0
 S X=$P(DATE,".")+.25
 S Y=$O(^IBT(FILE,"ATIDT",+IBTRN,-X)) S Y=-Y I Y,$P(Y,".")=$P(DATE,".") S IBX=1
 Q IBX
 ;
 ;
NIGHTLY ; -- nightly job for claims tracking, called by IBAMTC
 ;
 D UPDATE^IBTRKR1 ; update claims tracking site parameters (random sampler)
 D ^IBTRKR2 ;       add scheduled admissions to tracking
 D ^IBTRKR3 ;       add rx refill to outpatient encounters
 D ^IBTRKR4 ;       add outpatient encounters to tracking
 D ^IBTRKR5 ;       add outpatient prosthetics item to tracking
 Q
