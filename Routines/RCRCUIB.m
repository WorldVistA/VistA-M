RCRCUIB ;ALB/CMS-RC REFERRAL UTILITY IB INTERFACE PROGRAM ;
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
HD(PRCABN) ;Return 1 if bill has Charges on hold
 Q $$IB^IBRUTL(PRCABN,0)
 ;
MINS(PRCABN) ;Return 1 if bill has multiple Insurance Policies
 Q $$MINS^IBJTU31(PRCABN)
 ;
 ;RCRCUIB
