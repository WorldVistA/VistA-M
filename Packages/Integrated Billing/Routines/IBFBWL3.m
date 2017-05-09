IBFBWL3 ;ALB/PAW-IB BILLING Worklist Actions  ;30-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IB BILLING WORKLIST ACTIONS
 ; add code to do filters here
 ;
 D EN^VALM("IB BILLING WORKLIST ACTIONS")
 Q
 ;
HDR ; -- header code
 ;
 N IBSS,IBSSX,IBSSLE,IBSSLS
 S VALM("TITLE")=" Worklist Actions"
 S IBSSX=$$GET1^DIQ(2,DFN,.09,"I"),IBSSLE=$L(IBSSX),IBSSLS=6 I $E(IBSSX,IBSSLE)="P" S IBSSLS=5
 S IBSS=$E(IBNAME,1)_$E(IBSSX,IBSSLS,IBSSLE)
 S VALMHDR(2)=" PATIENT: "_IBNAME_" (ID: "_IBSS_")"
 Q
 ;
INIT ; -- init variables and list array
 ; input - ^TMP("IBFBWA",$J)=DFN^IBNAME^IBAUTH
 ; output - none
 N DFN,ECNT,IBAUTH,IBFBA,IBNAME,IBFIRST
 I '$D(^TMP("IBFBWA",$J)) Q
 S ECNT=$G(^TMP("IBFBWA",$J))
 S DFN=$P(ECNT,U,1),IBNAME=$P(ECNT,U,2),IBAUTH=$P(ECNT,U,3),IBFBA=$P(ECNT,U,4)
 D BLD
 Q
 ;
BLD ; Build data to display
 N IBGRPX,VALMY
 I $G(IBFIRST)'="" S IBFIRST="" Q
 D FULL^VALM1
 S IBGRPX=$S(IBGRP=1:"Facility Revenue Review",IBGRP=2:"RUR SC/SA Review",1:"Billing Review")
 I IBGRP'=2 D
 . D SET^VALM10(1,"","")
 . D SET^VALM10(2," Available Actions:")
 . D SET^VALM10(3,"","")
 . D SET^VALM10(4,"   Enter 1 to COMPLETE the "_IBGRPX_" process (Billable)")
 . D SET^VALM10(5,"   Enter 2 to REMOVE an item from the worklist (Not Billable)")
 I IBGRP=2 D
 . D SET^VALM10(1,"","")
 . D SET^VALM10(2," Available Actions:")
 . D SET^VALM10(3,"","")
 . D SET^VALM10(4,"   Enter 1 to COMPLETE to send item to billing worklist (Billable)")
 . D SET^VALM10(5,"   Enter 2 to REMOVE from billing worklist (Non Billable)")
 I IBGRP=2 D RURRC
 Q
 ; 
DONE ; Review is complete (for IBGRP)
 N IBBILL,IBEVENT,IBIEN,IBSCSA,IBRC,IENROOT,FDA,IBGRPX
 I $G(IBFIRST)'="" S IBFIRST="" Q
 S IENROOT=""
 D FIND
 I IBGRP=2 D RURRC  ; Additional prompt for RUR reason codes
 I IBGRP=1 D
 . D SCSA  ; Determine if Service Connected or Special Treatment Authority Exists
 . S FDA(360,IBIEN_",",2.03)="XX"
 . D UPDATE^DIE("","FDA","IENROOT")
 . I IBSCSA D  ; If SC/STA move to RUR-SC queue
 .. S FDA(360,IBIEN_",",2.04)="SC"
 . I 'IBSCSA D  ; If no SC/STA move to billing queue
 .. S FDA(360,IBIEN_",",2.05)="BI"
 . D UPDATE^DIE("","FDA","IENROOT")
 I IBGRP=2 D  ; If RUR-SC/SA Completion
 . S FDA(360,IBIEN_",",2.04)="XX"
 . D UPDATE^DIE("","FDA","IENROOT")
 . S FDA(360,IBIEN_",",2.05)="BI"
 . D UPDATE^DIE("","FDA","IENROOT")
 I IBGRP=3 D  ; If Billing Completion
 . D BILLING  ; Prepare a bill
 . S FDA(360,IBIEN_",",2.05)="XX"
 . D UPDATE^DIE("","FDA","IENROOT")
 D RESET
 I IBGRP=2 D RURRCPR
 S IBEVENT=$S(IBGRP=1:"Fac Rev",IBGRP=2:"RUR-SC/SA",1:"Billing")_"-Completed|"_$G(IBRC)
 I IBGRP=3,$G(IBBILL)'="" S IBEVENT="Bill "_IBBILL_" Created"
 D LOGUPD
 S IBGRPX=$S(IBGRP=1:"Facility Revenue Review",IBGRP=2:"RUR SC/SA Review",1:"Billing Review")
 W !," Item for "_IBNAME_" has completed "_IBGRPX_"."
 S IBFIRST=1
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
REM ; Remove Item from Worklist (log IBGRP)
 N IBEVENT,IBIEN,IENROOT
 I $G(IBFIRST)'="" S IBFIRST="" Q
 S IENROOT=""
 D FIND
 I IBGRP=2 D RURRC  ; Additional prompt for RUR reason codes
 I IBGRP=1 D
 . S FDA(360,IBIEN_",",2.03)="XX"
 . D UPDATE^DIE("","FDA","IENROOT")
 I IBGRP=2 D
 . S FDA(360,IBIEN_",",2.04)="XX"
 . D UPDATE^DIE("","FDA","IENROOT")
 I IBGRP=3 D
 . S FDA(360,IBIEN_",",2.05)="XX"
 . D UPDATE^DIE("","FDA","IENROOT")
 D RESET
 I IBGRP=2 D RURRCPR
 S IBEVENT=$S(IBGRP=1:"Fac Rev",IBGRP=2:"RUR-SC/SA",1:"Billing")_"-Item removed|"_$G(IBRC)
 D LOGUPD
 W !," Item for "_IBNAME_" has been removed from the worklist."
 S IBFIRST=1
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
FIND ; Find Auth Match
 I IBFBA'="" S IBIEN=IBFBA Q
 N IBX
 S IBX="" F  S IBX=$O(^IBFB(360,"C",DFN,IBX)) Q:IBX=""  D
 . I $P(^IBFB(360,IBX,0),U,3)=IBAUTH S IBIEN=IBX
 Q
 ;
LOGUPD ; Update Log 
 N FDA,IBDT,IBLOG
 S IBDT=$$NOW^XLFDT()
 S FDA(360.04,"+1,"_IBIEN_",",.01)=IBDT,FDA(360.04,"+1,"_IBIEN_",",.03)=DUZ
 S IBLOG=$P($G(^IBFB(360,IBIEN,4,0)),U,3)
 S IBLOG=IBLOG+1
 S FDA(360.04,"+1,"_IBIEN_",",.02)=IBEVENT
 D UPDATE^DIE("","FDA")
 S ^IBFB(360,"DFN",DFN,DT,IBIEN,IBLOG)=""
 S ^IBFB(360,"DT",DT,DFN,IBIEN,IBLOG)=""
 Q
 ;
SCSA ; Determine Service Connected or Special Authority Eligibility Status
 N IBARR,IBSC,IBSTA,VAEL
 S (IBSC,IBSCSA,IBSTA)=1
 D ELIG^VADPT
 I VAEL(3)=0 S IBSC=0
 D GETST^IBFBUTIL(IBIEN)
 I $G(IBST)="" S IBST=DT
 D CL^IBACV(DFN,IBST,"",.IBARR)
 I '$D(IBARR) S IBSTA=0
 I 'IBSC,'IBSTA S IBSCSA=0
 Q
 ;
RURRC ; Comments for RUR only
 ; Option 3 (internal comment 15) was removed - Need Addl Info - Refer to FR - and renumbered
 D SET^VALM10(6,"","")
 D SET^VALM10(7," At the second prompt, you may enter one of the following:","")
 D SET^VALM10(8,"","")
 D SET^VALM10(9," 1. Episode of Care SC/SA","")
 D SET^VALM10(10," 2. Episode of Care non SC/SA","")
 ; D SET^VALM10(11," 3. Need additional information - refer to Facility Revenue","")
 D SET^VALM10(11," 3. Episode of Care related to legal","")
 D SET^VALM10(12," 4. Episode of Care not related to legal - no OHI","")
 D SET^VALM10(13," 5. Episode of Care not related to legal - OHI SC/SA","")
 D SET^VALM10(14," 6. Episode of Care not related to legal - OHI non SC/SA","")
 Q
 ;
RURRCPR ; RUR Comment Prompt
 N X,Y
 S IBRC=""
 K DIR S DIR(0)="NO^1:6"
 S DIR("A")="Enter NUMBER (1-6) or return: "
 S DIR("?",1)="Enter a number between 1 and 6 or Enter if no comment."
 D ^DIR K DIR
 S IBRC=$G(Y)
 I IBRC="^" W !,"This response must be a number." G RURRCPR
 S IBRC=$S(IBRC=1:13,IBRC=2:14,IBRC=3:16,IBRC=4:17,IBRC=5:18,IBRC=6:19,1:"")
 Q
 ;  
RESET ; Reset ^TMP global
 N IBDOS,IBTYP
 S IBDOS=""
 F  S IBDOS=$O(^TMP("IBFBWL",$J,IBDOS)) Q:IBDOS=""  D
 . S IBTYP=""
 . F  S IBTYP=$O(^TMP("IBFBWL",$J,IBDOS,IBTYP)) Q:IBTYP=""  D
 .. I $D(^TMP("IBFBWL",$J,IBDOS,IBTYP,IBNAME,DFN,IBAUTH,IBFBA)) D
 ... K ^TMP("IBFBWL",$J,IBDOS,IBTYP,IBNAME,DFN,IBAUTH,IBFBA)
 Q
 ;
BILLING ; After final review by billing department, prepare to bill
 N IBARRAY,IBBC,IBDD,IBFPNUM,IBIFN,IBIDS,IBLOC,IBNPI,IBPAID,IBPAYX,IBREND,IBRET,IBRT,IBSER,IBSITE,IBST,IBTAX,PRCASV
 N IBFBVND,IBA,IBIBA,IBHIT,IBIBANPI,IBDR,IBTOT,IBSVC,IBPAYY,IBFBDX,IBFBDXX
 D DEM^VADPT
 D GETST^IBFBUTIL(IBIEN)  ; Get Invoice, Start Date, Fee Program
 I '$D(IBFPNUM) Q
 S IBIDS(".03")=$G(IBST)  ; Start Date of Care
 S IBLOC=$S(IBFPNUM=7:2,1:1)
 S IBIDS(".04")=IBLOC  ; Location of Care 1 Hospital 2 Skilled Nursing
 S IBBC=$S(IBFPNUM=2:3,IBFPNUM=3:3,1:1)
 S IBIDS(".05")=IBBC  ; Bill Classification 1 Inpatient 3 Outpatient
 S IBIDS(".06")=1  ; Timeframe of Bill Set to 1 Admit through Discharge
 S IBRT=""
 S IBRT=$O(^DGCR(399.3,"B","FEE REIMB INS",IBRT))
 S IBIDS(".07")=IBRT  ; Rate Type Must be Fee Reimbursable Insurance
 S IBIDS(".11")="i"  ; Who is Responsible This is always set to "i" initially
 S IBDD=$P($G(^IBE(350.9,1,1)),"^",25)
 S IBIDS(".22")=IBDD  ; Default Division - From IB Site Parameter File
 S IBIDS(".27")=""  ; Bill Charge Type - This is always set to null initially
 S IBIDS("151")=$G(IBST)  ; Statement Covers From Date 
 S IBIDS("152")=$G(IBST)  ; Statement Covers To Date 
 S IBIDS("155")=0  ; Sensitive Record - 0 is No
 S IBSER=$P(^IBE(350.9,1,1),U,14)
 S PRCASV("SER")=IBSER  ; MAS Service Pointer - From IB Site Parameter File 
 D GETPAY^IBFBUTIL(IBIEN)
 I '$D(IBRET) Q  ; Invoice does not exist (issue with index)
 S IBPAYX=""
 S IBPAYX=$O(IBRET(162.03,IBPAYX))
 S IBSITE=IBRET(162.03,IBPAYX,26,"I")  ; Get site from invoice
 S IBSVC=IBRET(162.03,IBPAYX,.01,"I")  ; Get CPT from invoice
 S IBTOT=0  ; Calculate total charges from invoice
 S IBPAYY=""
 F  S IBPAYY=$O(IBRET(162.03,IBPAYY)) Q:IBPAYY=""  D
 . S IBTOT=IBTOT+(IBRET(162.03,IBPAYY,2,"I"))
 S PRCASV("SITE")=IBSITE  ; Site
 D ^IBCA2  ; This call completes initial bill and AR set up
 S IBBILL=$P($G(IBDR("0")),U,1)
 K IBDR
 K FDA
 S FDA(360,IBIEN_",",1.02)=IBBILL  ; Save Bill Number on Tracking File
 D UPDATE^DIE("","FDA")
 ;
 S IBIFN=""
 S IBIFN=$O(^DGCR(399,"B",IBBILL,IBIFN))  ; Get Bill IEN using external number
 S IBNPI=IBRET(162.03,IBPAYX,64,"I")  ; Non-VA Care Facility NPI from Invoice
 D GETAUTH^IBFBUTIL(IBAUTH_","_DFN_",","IBARRAY")  ; Get Auth Data
 I IBNPI="" D  ; See if NPI can be found via Auth and FB side
 . S IBFBVND=$G(IBARRAY(161.01,IBAUTH_","_DFN_",",.04,"I"))
 . I IBFBVND'="" S IBNPI=$$GET1^DIQ(161.2,IBFBVND_",",41.01,"I")
 K FDA
 I IBNPI'="" D  ; Match FB Non-VA NPI with IB Non-VA NPI
 . S (IBIBA,IBHIT)=""
 . F  S IBIBA=$O(^IBA(355.93,IBIBA)) Q:IBIBA=""  D
 .. S IBIBANPI=""
 .. F  S IBIBANPI=$O(^IBA(355.93,IBIBA,"NPISTATUS","C",IBIBANPI)) Q:IBIBANPI=""!(IBHIT)  D
 ... I IBIBANPI=IBNPI S IBHIT=1 D
 .... S FDA(399,IBIFN_",",232)=IBIBA
 ; S FDA(399,IBIFN_",",161)=30  ; Discharge Bedsection
 S FDA(399,IBIFN_",",201)=IBTOT  ; Total Charges VA Paid from Invoice
 S FDA(399,IBIFN_",",51)=IBSVC  ; Service CPT from Invoice
 D UPDATE^DIE("","FDA")
 ;
 S IBFBDX=$G(IBRET(162.03,IBPAYX,28,"I"))  ; Get Primary Dx from invoice
 I IBFBDX="" S IBFBDX=$G(IBARRAY(161.01,IBAUTH_","_DFN_",",.087,"I"))  ; Primary Dx from Auth, if available
 I IBFBDX'="" S IBFBDXX=$$ADD^IBCSC4D(IBFBDX,IBIFN,"")
 ;
 W !,"Bill "_IBBILL_" created for "_IBNAME_"."
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ; 
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D ^%ZISC
 S VALMBCK="R"
 Q
