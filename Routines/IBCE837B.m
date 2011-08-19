IBCE837B ;ALB/TMP - OUTPUT FOR 837 TRANSMISSION (cont) ;24-APR-01
 ;;2.0;INTEGRATED BILLING;**137,191,197,320**;21-MAR-94
 ;
QTXMT(IBSITE8) ; Run now or queue EDI bill transmit (part of nightly job)
 ; IBSITE8 = the '8' node of the site parameters file (350.9)
 I $P(IBSITE8,U,6)="" D
 . D EN1("",1)
 E  D
 . N Z,Z0
 . F Z=1:1:4 S Z0=$P($P(IBSITE8,U,6),";",Z) Q:Z0=""  D
 .. S IBQDT=$S($E(($$NOW^XLFDT()#1*10000\1)_"0000",1,4)>Z0:$$FMADD^XLFDT(DT,1),1:DT)_"."_Z0  ; If time to queue is after the current time, queue for the next day
 .. D EN1("",1,+IBQDT)
 Q
 ;
EN1(IBZTSK,IBNOASK,IBQDT,IBABORT) ;Txmit 837's for bills waiting transmission
 ; Pass IBZTSK by ref to get task # if job is tasked
 ; IBNOASK = flag: 0 = ask to queue,  1 = no ask to queue
 ; IBQDT = if IBNOASK=1, this can be the date/time to queue the job
 ; Pass IBABORT by reference to determine if user aborted process
 N Z S Z=$O(^IBE(353,"B","IB 837 TRANSMISSION",0)),Z=$S($P($G(^IBE(353,+Z,2)),U,8):$P(^(2),U,8),1:Z)
 I Z D
 . I $D(^TMP("IBRESUBMIT",$J))!($G(IBNOASK)) D FORM^IBCEFG7(Z,$P($G(^IBE(350.9,1,8)),U),+$G(IBNOASK),$S($G(IBNOASK):$G(IBQDT),1:""),.IBZTSK,.IBABORT) Q
 . D FORM^IBCEFG7(Z,$P($G(^IBE(350.9,1,8)),U),+$G(IBNOASK),$S($G(IBNOASK):$G(IBQDT),1:""),"",.IBABORT)
 Q
 ;
