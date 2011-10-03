IBCBB8 ;ALB/BGA - CON'T MEDICARE EDIT CHECKS ;08/12/98
 ;;2.0;INTEGRATED BILLING;**51,137,210,349,373**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; UB-04 CLAIM CERTIFICATE ID NUMBER
 I '$$VALID(IBIFN) S IBQUIT=$$IBER^IBCBB3(.IBER,215) Q:IBQUIT
 ;
 ; Req. on Primary Payor when Medicare is secondary and value 12-15,43
 I $$COBN^IBCEF(IBIFN)=2 D  Q:IBQUIT
 . I $O(IBVALCD(16),-1)'<12!$D(IBVALCD(43)) D 
 . . K IBXDATA D F^IBCEF("N-ALL INSURED EMPLOYER INFO",,,IBIFN)
 . . ; employer name^city^state abbreviation^state ien
 . . ;I '$O(IBXDATA(0)) S IBQUIT=$$IBER^IBCBB3(.IBER,222) Q
 . . ; Employer name missing
 . . ;I $P($G(IBXDATA(1)),U)="" S IBQUIT=$$IBER^IBCBB3(.IBER,222)
 . . ; Employer address missing
 . . ;I $TR($P($G(IBXDATA(1)),U,2,4),U)="" S IBQUIT=$$IBER^IBCBB3(.IBER,223)
 . ;
 . ; Insured's Group Number 
 . ;  if Medicare is secondary, need insurance group number for primary
 . K IBXDATA D F^IBCEF("N-ALL INSURANCE GROUP NUMBER",,,IBIFN)
 . I $P($G(IBXDATA(1)),U)="" S IBQUIT=$$IBER^IBCBB3(.IBER,225)
 ;
 ; UB-04 Diagnosis Codes
 K IBXDATA D F^IBCEF("N-DIAGNOSES",,,IBIFN)
 ;
 S IBI=0
 F  S IBI=$O(IBXDATA(IBI)) Q:'IBI  D  Q:IBQUIT
 . S IBDXC=$P($$ICD9^IBACSV(+$P(IBXDATA(IBI),U)),U)
 . ; no duplicate dx
 . I IBDXC'="",$D(IBDXARY(IBDXC)) S IBQUIT=$$IBER^IBCBB3(.IBER,227)
 . I IBDXC'="",'$D(IBDXARY(IBDXC)) S IBDXARY(IBDXC)=IBXDATA(IBI)
 Q:IBQUIT
 ;
 Q
 ;
VALID(IBIFN) ; Verify HIC # is valid
 N VAL,IBXDATA
 S VAL=1
 G:'$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN)) VALQ
 ;
 K IBXDATA D F^IBCEF("N-CURR INSURED ID",,,IBIFN)
 ;
 I $G(IBXDATA)="" S VAL=0 G VALQ
 ;
 S IBXDATA=$TR(IBXDATA,"-")
 ; HIC # must pass standard MEDICARE edits
 I '$$VALHIC^IBCNSMM(IBXDATA) S VAL=0
 ;
VALQ Q VAL
 ;
