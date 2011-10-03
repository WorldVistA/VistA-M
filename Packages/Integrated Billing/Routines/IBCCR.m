IBCCR ;ALB/EJK - CLAIM CANCEL AND RESUBMIT INFORMATION ;23-FEB-2005
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine can be invoked from any function that displays
 ;or reviews claim information. Using the current IBIFN,
 ;cancelled bill information and new bill information is returned.
 ;
 ;OUTPUT:
 ;  IBCCR array (pass by reference)
 ;  IBCCR(FM date cloned,bill#) [1] FM date cloned
 ;                              [2] external claim#
 ;                              [3] user who cloned (external)
 ;                              [4] reason cloned
 ;   old bill and new bill information is returned.
 ;   As much as possible in both directions.
 ;
EN(IBIFN,IBCCR) ;
 N IBOB,IBUSER,IBBCT,IBRSN,IBXDATA,IBDBC
 KILL IBCCR
 S IBXDATA("S1")=$G(^DGCR(399,IBIFN,"S1"))
 I $P($G(IBXDATA("S1")),U,2)'="" S IBOB=$P($G(IBXDATA("S1")),U,2) D OBINFO      ;THIS BILL IS A CLONE.
 I $P($G(IBXDATA("S1")),U,1)'="" S IBBCT=$P($G(^DGCR(399,IBIFN,"S1")),U,1) D CLONE       ;GET CLONE INFO.
 Q
 ;
OBINFO ;This claim is a clone of an old one. 
 ;Per E-Claims+ Iteration II requirement 3.2.12
 ;we want to find and return the entire cloning history as far back
 ;as we can go. 
 ;
 S IBDBC=$P($G(^DGCR(399,IBOB,"S1")),U,3)
 S IBUSER=+$P($G(^DGCR(399,IBOB,"S1")),U,4)
 S IBUSER=$P($G(^VA(200,IBUSER,0)),U,1)
 S IBRSN=$P($G(^DGCR(399,IBOB,"S1")),U,5)
 S IBCCR(+IBDBC,IBOB)=IBDBC_U_$P($G(^DGCR(399,IBOB,0)),U,1)_U_IBUSER_U_IBRSN
 I $P($G(^DGCR(399,IBOB,"S1")),U,2) S IBOB=$P($G(^DGCR(399,IBOB,"S1")),U,2) G OBINFO      ;THIS BILL IS A CLONE.
 Q
 ;
CLONE ;This claim has been cancelled and cloned to a newer claim.
 ;This function gets all pertinent data of who, why and when the
 ;current claim was cancelled, then jumps forward to the next claim
 ;to see if that was copy/cancelled as well. 
 ;
 S IBDBC=$P($G(^DGCR(399,IBIFN,"S1")),U,3)
 S IBUSER=+$P($G(^DGCR(399,IBIFN,"S1")),U,4)
 S IBUSER=$P($G(^VA(200,IBUSER,0)),U,1)
 S IBRSN=$P($G(^DGCR(399,IBIFN,"S1")),U,5)
 S IBCCR(+IBDBC,IBBCT)=IBDBC_U_$P($G(^DGCR(399,IBBCT,0)),U,1)_U_IBUSER_U_IBRSN
 S IBIFN=IBBCT
 S IBBCT=$P($G(^DGCR(399,IBIFN,"S1")),U,1)
 I IBIFN<IBBCT G CLONE
 Q
 ;
