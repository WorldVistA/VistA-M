IBCAMS ;ALB/AAS - DETERMINE AMIS SEGMENT FOR REIMBURSABLE INS BILLS ; 10-SEP-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRAMS
 ;
AMIS ;  - calculate AMIS segment for insurance bills.
 ;    249 = NSC - outpatient
 ;    292 = SC  - inpatient
 ;    293 = SC  - outpatient
 ;    297 = NSC - inpatient
 ;  - input
 ;       x = internal number of entry in 399
 ;
 ;  - output
 ;       y = amis segment number or -1 if can't determine
 ;
% S Y=-1
 I '$D(^DGCR(399,+X,0)) G AMISQ
 S IBX=^DGCR(399,+X,0)
 N DFN
 ;
 ;  - make sure is RI bill
 ;S R=$P(IBX,"^",7),R=$S('$D(^DGCR(399.3,+R,0)):0,1:$P(^(0),"^",6)) G:'R AMISQ S R=$S('$D(^PRCA(430.2,+R,0)):0,1:$P(^(0),"^",7)) G:R'=21 AMISQ
 G:+$$CAT^PRCAFN(X)'=21 AMISQ
 ;
 S IBI=$P(IBX,"^",5),IBI=$S('IBI:0,IBI>2:2,IBI<3:1,1:0) G:'IBI AMISQ ; 0=err, 1=inpatient, 2=outpatient
 ;
 N X
 S IBSC=$P(IBX,"^",18),DFN=$P(IBX,"^",2) I IBSC="" D ELIG^VADPT S IBSC=+VAEL(3)
 ;
 ;  - compute amis segment
 S:+IBSC Y=$S(IBI=1:292,IBI=2:293,1:-1) ;sc amis segments
 S:'IBSC Y=$S(IBI=1:297,IBI=2:249,1:-1) ;nsc amis segments
 ;
AMISQ K IBSC,IBX,IBI,VAEL,VAERR
 Q
