IBCEMSR6 ;ALB/VAD - IB PRINTED CLAIMS REPORT - Sort ;09-SEP-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
SRCH ; Collect Information
 ; Use the existing AP x-ref to narrow down the list of claims by date,
 ; then check field 27 to see if it's appropriate to put it on the report (1=LOCAL PRINT)
 ;The following line is used to find Bills in the Printed Date Range and the FORCE TO PRINT field
 N BILLNO,IBBILZ,IBDV,IBDT,IBIFN,IBFTYP,IBTOP,IBRTN,IBRVCDS,IBSRT,IBTYPE,INSADD,LOCCNT,RCX,TOTCNT
 N INSCO,IBSFLD,IBULD,IBINS,X,RTDSC,IBRVCD,IBTOPN,VARRAY,IBRTDS,IBPTYP,IBBLLR
 K ^TMP($J,"IBCEMSRP-DATA")
 D INIT
 S IBDT=IBBDT-.1,IBSRT=$P(IBSORT,U)
 S (TOTCNT,LOCCNT)=0
 F  S IBDT=$O(^DGCR(399,"AP",IBDT)) Q:'IBDT!(IBDT>IBEDT)  D   ; Identify those claims within the selected date range
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AP",IBDT,IBIFN)) Q:'IBIFN  D
 . . S IBBILZ=$G(^DGCR(399,IBIFN,0)),IBRTN=$P(IBBILZ,U,7),IBDV=+$P(IBBILZ,U,22)  ; Get Rate Type and division
 . . Q:$P(IBBILZ,U,13)'=4  ; don't include canceled claims
 . . Q:'$D(IBDIVS(IBDV))  ; Not one of the selected Divisions
 . . S TOTCNT=TOTCNT+1  ; Accumulate Total Printed for selected divisions.
 . . I $P($G(^DGCR(399,IBIFN,"TX")),U,8)'=1 Q   ; Is the Bill "FORCE LOCAL PRINT"?
 . . ; don't include US Labor Dept claims
 . . S IBINS=$$CURR^IBCEF2(IBIFN) Q:$D(VARRAY("IBULD",IBINS))
 . . ; don't count claims where EDI is inactive (user has to print those)
 . . Q:$$INSOK^IBCEF4(IBINS)'=1
 . . Q:'$D(VARRAY("RTYPES",IBRTN))  ;Is this one of the selected Rate Types?
 . . S IBTOP=+$P($G(^IBA(355.3,+$$POLICY^IBCEF(IBIFN,18),0)),U,9)  ; Get Plan Type
 . . Q:'$D(VARRAY("IBTOP",IBTOP))   ;Is this one of the selected Plan Types?
 . . S RCX=0
 . . S (IBRVCDS,X)="" F  S X=$O(^DGCR(399,IBIFN,"RC","B",X)) Q:X=""  D  Q:RCX
 . . . I $D(VARRAY("XRVCDS",X)) S RCX=1 Q   ; Bill contains a Revenue Code Exclusion.
 . . . S IBRVCDS=$S(IBRVCDS="":X,1:IBRVCDS_","_X)  ; Get Revenue Codes.
 . . Q:RCX=1  ; bill contains at least one of the excluded revenue codes
 . . S LOCCNT=LOCCNT+1  ; Accumulate Only Locally Printed that could have gone electronically and meet all the search criteria.
 . . S IBRTDS=$G(VARRAY("RTYPES",IBRTN)) ; Get the Rate Type Description
 . . S IBPTYP=$G(VARRAY("IBTOP",IBTOP))  ; Get Plan Type name
 . . S BILLNO=$$BN1^PRCAFN(IBIFN)   ; Get external CLAIM # DBIA #380
 . . S INSCO=$P($G(^DIC(36,IBINS,0)),U)  ; Get Insurance Company Name
 . . S INSADD=$$CURRINS^IBCEPTC2(IBIFN)  ; Get Insurance Company Address
 . . S IBFTYP=$P($G(^IBE(353,+$P(IBBILZ,U,19),0)),U) I IBFTYP="" S IBFTYP="UNKNOWN"  ; Get the Bill's Form Type.
 . . S IBTYPE=$S($P(IBBILZ,U,5)>2:"O",1:"I")_"/"_$S($P(IBBILZ,U,27)=1:"I",$P(IBBILZ,U,27)=2:"P",1:"")  ; Patient Status / Bill Charge Type
 . . S IBBLLR=$P($$BILLER^IBCIUT5(IBIFN),U,2)   ; Get Biller
 . . ; GATHER REPORTABLE DATA AND STORE ACCORDING TO THE VALUE OF IBSORT INTO ^TMP($J,"IBCEMSRP-DATA")!!!
 . . S IBSFLD=$S(IBSRT="I":INSCO,IBSRT="R":IBRTDS,IBSRT="F":IBFTYP,IBSRT="P":IBPTYP,1:IBBLLR)
 . . ; if sorted by insurance company, add address to subheader
 . . S:IBSRT="I" ^TMP($J,"IBCEMSRP-DATA",INSCO)=INSADD
 . . S ^TMP($J,"IBCEMSRP-DATA",IBSFLD,BILLNO)=IBTYPE_U_IBRTDS_U_IBPTYP_U_$G(IBDIVS(IBDV))_U_IBBLLR_U_INSCO_U_INSADD
 . . S ^TMP($J,"IBCEMSRP-DATA",IBSFLD,BILLNO,"RVCDS")=IBRVCDS
 S ^TMP($J,"IBCEMSRP-DATA")=LOCCNT_U_TOTCNT
 Q
 ;
INIT ; come here to set up search criteria
 ; Get ien of US Labor Department payer (cover all possible name variations)
 S IBULD=$O(^DIC(36,"B","US LABOR DEPARTMENT","")) S:IBULD'="" VARRAY("IBULD",IBULD)=""
 S IBULD=$O(^DIC(36,"B","US DEPT OF LABOR","")) S:IBULD'="" VARRAY("IBULD",IBULD)=""
 S IBULD=$O(^DIC(36,"B","US DEPARTMENT OF LABOR","")) S:IBULD'="" VARRAY("IBULD",IBULD)=""
 ; handle claims that do not have a type of plan
 S VARRAY("IBTOP",0)="UNKNOWN"
 ; Claim does not contain excluded revenue codes from IB Site parameters
 S IBRVCD="" F  S IBRVCD=$O(^IBE(350.9,1,15,"B",IBRVCD)) Q:'IBRVCD  S VARRAY("XRVCDS",IBRVCD)=""
 ; Tricare Rate Type is one of the following and type of plan is one of the following:
 I IBCOT="T" D  Q
 .F RTDSC="CHAMPVA REIMB. INS.","CHAMPVA","TRICARE REIMB. INS.","TRICARE" S IBRTN=$O(^DGCR(399.3,"B",RTDSC,"")) I IBRTN S VARRAY("RTYPES",IBRTN)=RTDSC
 .F IBTOPN="TRICARE","CHAMPVA","TRICARE SUPPLEMENTAL" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 ; CPAC Rate Type is one of the following and type of plan is one of the following:
 I IBCOT="C" D  Q
 .F RTDSC="CRIME VICTIM","NO FAULT INS.","REIMBURSABLE INS.","TORT FEASOR","WORKERS' COMP." S IBRTN=$O(^DGCR(399.3,"B",RTDSC,"")) I IBRTN S VARRAY("RTYPES",IBRTN)=RTDSC
 .F IBTOPN="ACCIDENT AND HEALTH INSURANCE","AUTOMOBILE","CARVE-OUT","CATASTROPHIC INSURANCE","COMPREHENSIVE MAJOR MEDICAL" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 .F IBTOPN="HEALTH MAINTENANCE ORGANIZ","INCOME PROTECTION (INDEMNITY)","INDIVIDUAL PRACTICE ASSOCATION (IPA)" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 .F IBTOPN="INPATIENT (BASIC HOSPITAL)","LABS, PROCEDURES, X-RAY, ETC. (ONLY)","MANAGED CARE SYSTEM (MCS)","MEDI-CAL","MEDICAID" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 .F IBTOPN="MEDICAL EXPENSE (OPT/PROF)","MEDICARE SECONDARY (B EXC)","MEDICARE SECONDARY (NO B EXC)","MEDICARE SUPPLEMENTAL" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 .F IBTOPN="MEDICARE/MEDICAID (MEDI-CAL)","MEDIGAP PLAN A","MEDIGAP PLAN B","MEDIGAP PLAN C","MEDIGAP PLAN D","MEDIGAP PLAN F" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 .F IBTOPN="MEDIGAP PLAN G","MEDIGAP PLAN K","MEDIGAP PLAN L","MEDIGAP PLAN M","MEDIGAP PLAN N","MENTAL HEALTH","POINT OF SERVICE" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 .F IBTOPN="PREFERRED PROVIDER ORGANIZATION (PPO)","PREPAID GROUP PRACTICE PLAN","PRESCRIPTION","RETIREE","SPECIAL CLASS INSURANCE" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 .F IBTOPN="SPECIAL RISK INSURANCE","SPECIFIED DISEASE INSURANCE","SURGICAL EXPENSE INSURANCE","WORKERS' COMPENSATION INSURANCE" S IBTOP=$O(^IBE(355.1,"B",IBTOPN,"")) I IBTOP S VARRAY("IBTOP",IBTOP)=IBTOPN
 Q
 ;
