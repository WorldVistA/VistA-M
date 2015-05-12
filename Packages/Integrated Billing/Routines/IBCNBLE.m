IBCNBLE ;ALB/ARH - Ins Buffer: LM buffer entry screen ;1-Jun-97
 ;;2.0;INTEGRATED BILLING;**82,231,184,251,371,416,435,452,497,519**;21-MAR-94;Build 56
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; - main entry point for list manager display
 N DFN
 D EN^VALM("IBCNB INSURANCE BUFFER ENTRY")
 Q
 ;
HDR ; - header code for list manager display
 N IBX,IB0,VADM,VA,VAERR S IBX=""
 I +$G(DFN) D DEM^VADPT S IBX=$E(VADM(1),1,28),IBX=IBX_$J("",35-$L(IBX))_$P(VADM(2),U,2)_"    DOB: "_$P(VADM(3),U,2)_"    AGE: "_VADM(4)
 S VALMHDR(1)=IBX
 S IB0=$G(^IBA(355.33,+$G(IBBUFDA),0))
 S IBX=$E($P($G(^VA(200,+$P(IB0,U,2),0)),U,1),1,27)_" ("_$E($$EXPAND^IBTRE(355.33,.03,$P(IB0,U,3)),1,11)_")"
 S IBX="Buffer entry created on "_$$DATE(+IB0)_" by "_IBX,IBX=$J("",40-($L(IBX)\2))_IBX
 S VALMHDR(2)=IBX
 S IBX="" I +$P(IB0,U,10) S IBX="Buffer entry verified on "_$$DATE(+$P(IB0,U,10))_" by "_$E($P($G(^VA(200,+$P(IB0,U,11),0)),U,1),1,27),IBX=$J("",40-($L(IBX)\2))_IBX
 S VALMHDR(3)=IBX
 Q
 ;
INIT ; - initialization of list manager screen, ifn of record to display required IBBUFDA
 K ^TMP("IBCNBLE",$J)
 I '$G(IBBUFDA) S VALMQUIT="" Q
 S DFN=+$G(^IBA(355.33,IBBUFDA,60))
 D BLD
 Q
 ;
HELP ; - help text for list manager screen
 D FULL^VALM1
 W !!,"This screen displays all data in a Buffer File entry."
 W !!,"The actions allow editing of all data and verification of coverage."
 W !!,"It is not necessary to use the Verify Entry action, this action is optional.",!,"If the Verify Entry action is not used, the policy will be automatically flagged",!,"as verified when it is Accepted and stored in the main Insurance files."
 D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
EXIT ; - exit list manager screen
 K ^TMP("IBCNBLE",$J)
 D CLEAR^VALM1
 Q
 ;
BLD ; display buffer entry
 N DFN,CLIEN,CLDT,IB0,IB20,IB40,IB60,IB61,IB62,IB90,IB91,IBL,IBLINE,ADDR,IBI,IBY,SRVARRAY
 S VALMCNT=0
 S IB0=$G(^IBA(355.33,IBBUFDA,0)),IB20=$G(^IBA(355.33,IBBUFDA,20)),IB40=$G(^IBA(355.33,IBBUFDA,40))
 S IB60=$G(^IBA(355.33,IBBUFDA,60)),IB61=$G(^IBA(355.33,IBBUFDA,61)),IB62=$G(^IBA(355.33,IBBUFDA,62))
 S IB90=$G(^IBA(355.33,IBBUFDA,90)),IB91=$G(^IBA(355.33,IBBUFDA,91))
 ; check if we are coming from appointments view
 I $G(AVIEW) D
 .D SET(" ") S IBY=$J("",26)_"Appointment Information" D SET(IBY,"B") S IBLINE=""
 .S DFN=+IB60
 .S CLIEN="" F  S CLIEN=$O(^TMP($J,"IBCNAPPTS",DFN,CLIEN)) Q:CLIEN=""  D
 ..S CLDT="" F  S CLDT=$O(^TMP($J,"IBCNAPPTS",DFN,CLIEN,CLDT)) Q:CLDT=""  D
 ...S IBL="Clinic: ",IBY=$P($P(^TMP($J,"IBCNAPPTS",DFN,CLIEN,CLDT),U,2),";",2)
 ...S IBLINE=$$SETL(IBLINE,IBY,IBL,10,30)
 ...S IBL="Appt. D/T: ",IBY=$$FMTE^XLFDT(CLDT)
 ...S IBLINE=$$SETL(IBLINE,IBY,IBL,50,22)
 ...D SET(IBLINE) S IBLINE=""
 ...Q
 ..Q
 .Q
 ;
 I +$P(IB0,U,17) D EN^IBCNBLE2    ; IB*2*435 - Display e-Pharmacy ELIG response data
 ;
 D SET(" ") S IBY=$J("",26)_"Insurance Company Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Name: ",IBY=$P(IB20,U,1) S IBLINE=$$SETL("",IBY,IBL,10,30)
 S IBL="Reimburse?: ",IBY=$$EXPAND^IBTRE(355.33,20.05,$P(IB20,U,5)) S IBLINE=$$SETL(IBLINE,IBY,IBL,57,20)
 D SET(IBLINE) S IBLINE=""
 S IBL="Phone: ",IBY=$P(IB20,U,2) S IBLINE=$$SETL(IBLINE,IBY,IBL,10,20)
 S IBL="Billing Phone: ",IBY=$P(IB20,U,3) S IBLINE=$$SETL(IBLINE,IBY,IBL,57,20)
 D SET(IBLINE) S IBLINE=""
 S IBL="Precert Phone: ",IBY=$P(IB20,U,4) S IBLINE=$$SETL(IBLINE,IBY,IBL,57,20)
 D SET(IBLINE) S IBLINE=""
 S IBL="Remote Query From: ",IBY=$$EXTERNAL^DILFD(355.33,.14,"",$P(IB0,"^",14)) S IBLINE=$$SETL(IBLINE,IBY,IBL,57,20)
 D SET(IBLINE) S IBLINE="" D ADDR(21,1)
 S IBL="Address: ",IBY=ADDR(1) S IBLINE=$$SETL(IBLINE,IBY,IBL,10,69)
 D SET(IBLINE) S IBLINE=""
 F IBI=2:1:9 S IBL="",IBY=$G(ADDR(IBI)) Q:IBY=""  S IBLINE=$$SETL(IBLINE,IBY,IBL,10,69) D SET(IBLINE) S IBLINE=""
 D SET(" ") S IBY=$J("",29)_"Group/Plan Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Group Plan?: ",IBY=$$YN($P(IB40,U,1)) S IBLINE=$$SETL("",IBY,IBL,16,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="Group Name: ",IBY=$P(IB90,U,1) S IBLINE=$$SETL("",IBY,IBL,16,58) D SET(IBLINE) S IBLINE=""
 I $TR($E(IBY,59,80)," ","")'="" S IBLINE=$$SETL("",$E(IBY,59,80),"",16,22) D SET(IBLINE) S IBLINE=""
 ;
 S IBL="Group Number: ",IBY=$P(IB90,U,2) S IBLINE=$$SETL("",IBY,IBL,16,55)
 ;;Daou/EEN - Adding BIN and PCN
 D SET(IBLINE) S IBLINE=""
 S IBL="BIN: ",IBY=$P(IB40,U,10) S IBLINE=$$SETL("",IBY,IBL,16,10)
 S IBL="Require UR: ",IBY=$$YN($P(IB40,U,4)) S IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="PCN: ",IBY=$P(IB40,U,11) S IBLINE=$$SETL("",IBY,IBL,16,20)
 S IBL="Require Amb Cert: ",IBY=$$YN($P(IB40,U,6)) S IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="Require Pre-Cert: ",IBY=$$YN($P(IB40,U,5)) S IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 ;
 S IBL="Type of Plan: ",IBY=$P($G(^IBE(355.1,+$P(IB40,U,9),0)),U,1) S IBLINE=$$SETL("",IBY,IBL,16,25)
 S IBL="Exclude Pre-Cond: ",IBY=$$YN($P(IB40,U,7)) S IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="Benefits Assignable: ",IBY=$$YN($P(IB40,U,8)) S IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 ;
 D SET(" ") S IBY=$J("",26)_"Policy/Subscriber Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Whose Insurance: ",IBY=$$EXPAND^IBTRE(355.33,60.05,$P(IB60,U,5)) S IBLINE=$$SETL("",IBY,IBL,18,7)
 S IBL="Effective: ",IBY=$$DATE($P(IB60,U,2)) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,8)
 D SET(IBLINE) S IBLINE=""
 S IBL="Expiration: ",IBY=$$DATE($P(IB60,U,3)) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,13)
 D SET(IBLINE) S IBLINE=""
 S IBL="Insured's Name: ",IBY=$P(IB91,U,1) S IBLINE=$$SETL("",IBY,IBL,18,56) D SET(IBLINE) S IBLINE=""
 I $TR($E(IBY,57,130)," ","")'="" S IBLINE=$$SETL("",$E(IBY,57,130),"",18,56) D SET(IBLINE) S IBLINE=""
 I $TR($E(IBY,113,130)," ","")'="" S IBLINE=$$SETL("",$E(IBY,113,130),"",18,18) D SET(IBLINE) S IBLINE=""
 S IBL="Subscriber Id: ",IBY=$P(IB90,U,3) S IBLINE=$$SETL("",IBY,IBL,18,56) D SET(IBLINE) S IBLINE=""
 I $TR($E(IBY,57,80)," ","")'="" S IBLINE=$$SETL("",$E(IBY,57,80),"",18,24) D SET(IBLINE) S IBLINE=""
 ;
 S IBL="Relationship: ",IBY=$$EXPAND^IBTRE(355.33,60.06,$P(IB60,U,6)) S IBLINE=$$SETL("",IBY,IBL,18,16)
 S IBL="Primary Provider: ",IBY=$P(IB60,U,10) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,17)
 D SET(IBLINE) S IBLINE=""
 S IBL="Provider Phone: ",IBY=$P(IB60,U,11) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,16)
 D SET(IBLINE) S IBLINE=""
 I $P(IB60,U,6)'="01"!($P(IB60,U,8)'="") S IBL="Insured's DOB: ",IBY=$$DATE($P(IB60,U,8)) S IBLINE=$$SETL("",IBY,IBL,18,8)
 S IBL="Coord of Benefits: ",IBY=$$EXPAND^IBTRE(355.33,60.12,$P(IB60,U,12)) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,16)
 D SET(IBLINE) S IBLINE=""
 ;
 I $P(IB60,U,15)'=""!($P(IB60,U,16)'="") D      ; IB*2*452 - esg - display Pharmacy fields if they exist
 . S IBL="Rx Relationship: ",IBY=""
 . N G S G=+$P(IB60,U,15)
 . I G S IBY=$$GET1^DIQ(9002313.19,G_",",.01)_" - "_$$GET1^DIQ(9002313.19,G_",",.02)
 . S IBLINE=$$SETL("",IBY,IBL,18,20)
 . S IBL="Rx Person Code: ",IBY=$P(IB60,U,16),IBLINE=$$SETL(IBLINE,IBY,IBL,62,10)
 . D SET(IBLINE) S IBLINE=""
 . Q
 ;
 I $P(IB62,U,1)'="" S IBL="Patient Id: ",IBY=$P(IB62,U,1) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,13)
 I IBLINE'="" D SET(IBLINE) S IBLINE=""
 ;
 I '$P(IB61,U,1) D SET(" ") S IBL="Employer Sponsored Group Health Plan?: ",IBY=$$YN($P(IB61,U,1)) S IBLINE=$$SETL("",IBY,IBL,40,3) D SET(IBLINE) S IBLINE="" G NXT
 ;
 D ADDR(61,6)
 D SET(" ") S IBY=$J("",24)_"Subscriber's Employer Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Employer Sponsored?: ",IBY=$$YN($P(IB61,U,1)) S IBLINE=$$SETL("",IBY,IBL,22,3)
 S IBL="Employment Status: ",IBY=$$EXPAND^IBTRE(355.33,61.03,$P(IB61,U,3)) S IBLINE=$$SETL(IBLINE,IBY,IBL,64,15)
 D SET(IBLINE) S IBLINE=""
 S IBL="Claim to Employer: ",IBY=$$YN($P(IB61,U,5)) S IBLINE=$$SETL("",IBY,IBL,22,3)
 S IBL="Retirement Date: ",IBY=$$DATE($P(IB61,U,4)) S IBLINE=$$SETL(IBLINE,IBY,IBL,64,8)
 D SET(IBLINE) S IBLINE=""
 S IBL="Employer Name: ",IBY=$P(IB61,U,2) S IBLINE=$$SETL("",IBY,IBL,16,30)
 S IBL="Employer Phone: ",IBY=$P(IB61,U,12) S IBLINE=$$SETL(IBLINE,IBY,IBL,64,15)
 D SET(IBLINE) S IBLINE=""
 S IBL="Address: ",IBY=ADDR(1) S IBLINE=$$SETL(IBLINE,IBY,IBL,16,64)
 D SET(IBLINE) S IBLINE=""
 F IBI=2:1:9 S IBL="",IBY=$G(ADDR(IBI)) Q:IBY=""  S IBLINE=$$SETL(IBLINE,IBY,IBL,16,64) D SET(IBLINE) S IBLINE=""
 ;
NXT ;
 D SET(" ") S IBY=$J("",26)_"Buffer Entry Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Date Entered: ",IBY=$$FMTE^XLFDT($P(IB0,U,1),2) S IBLINE=$$SETL("",IBY,IBL,18,17)
 S IBL="Date Verified: ",IBY=$$FMTE^XLFDT($P(IB0,U,10),2) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,17)
 D SET(IBLINE) S IBLINE=""
 S IBL="Entered By: ",IBY=$$EXPAND^IBTRE(355.33,.02,$P(IB0,U,2)) S IBLINE=$$SETL("",IBY,IBL,18,40)
 S IBL="Verified By: ",IBY=$$EXPAND^IBTRE(355.33,.11,$P(IB0,U,11)) S IBLINE=$$SETL(IBLINE,IBY,IBL,62,17)
 D SET(IBLINE) S IBLINE=""
 ; service date / service code
 D SERVLN(IBBUFDA,.SRVARRAY) I SRVARRAY F IBI=1:1:SRVARRAY D SET(SRVARRAY(IBI))
 K SRVARRAY
 ;
 S IBLINE=$$TRACE(IBLINE,IBBUFDA)       ; eIIV trace #
 S IBL="eIV Processed Date: ",IBY=$S($P(IB0,U,15)="":"",1:$$FMTE^XLFDT($P(IB0,U,15),"2M"))
 S IBLINE=$$SETL(IBLINE,IBY,IBL,62,17)
 D SET(IBLINE) S IBLINE=""
 S IBL="Source: ",IBY=$$EXPAND^IBTRE(355.33,.03,$P(IB0,U,3))
 S IBLINE=$$SETL("",IBY,IBL,18,17)
 D SET(IBLINE) S IBLINE=""
 ;
 ; Call another routine for continuation of list build
 D BLD^IBCNBLE1
 ;
BLDQ Q
 ;
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ;
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
SET(LINE,SPEC) ;
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCNBLE",$J,VALMCNT,0)=LINE
 I $G(SPEC)="B" D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 Q
 ;
DATE(X) ;
 N Y S Y="" I X?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
YN(X) ;
 N Y S X=$G(X),Y=$S(X=1:"Yes",X=0:"No",1:"")
 Q Y
 ;
ADDR(NODE,FLD) ; format address for output
 N IBY,IB0,IBCS,IBST,IBZIP,IBJ,IBZ,IBX K ADDR S ADDR(1)=""
 S IB0=$G(^IBA(355.33,IBBUFDA,NODE))
 S IBCS=$P(IB0,U,FLD+3),IBST=$P($G(^DIC(5,+$P(IB0,U,FLD+4),0)),U,2),IBZIP=$P(IB0,U,FLD+5)
 S IBZIP=$E(IBZIP,1,5)_$S($E(IBZIP,6,9)'="":"-"_$E(IBZIP,6,9),1:"")
 S IBST=IBST_$S(IBST=""!(IBZIP=""):"",1:"  ")_IBZIP
 S IBCS=IBCS_$S(IBCS=""!(IBST=""):"",1:", ")_IBST
 ;
 S IBJ=1 F IBY=$P(IB0,U,FLD),$P(IB0,U,(FLD+1)),$P(IB0,U,(FLD+2)),IBCS I IBY'="" S IBX=$G(ADDR(IBJ)),IBZ=", " D
 . S:IBX="" IBZ="" S:($L(IBX)+2+$L(IBY))>64 IBZ="",IBJ=IBJ+1
 . S ADDR(IBJ)=$G(ADDR(IBJ))_IBZ_IBY
 Q
 ;
TRACE(IBLINE,IBBUFDA) ; Add the eIIV Trace Number to the display
 NEW RESP,TRACENUM,IBL,IBY
 I '$G(IBBUFDA) G TRACEX
 S RESP=$O(^IBCN(365,"AF",IBBUFDA,""),-1)          ; response ien
 S TRACENUM=""
 I RESP S TRACENUM=$P($G(^IBCN(365,RESP,0)),U,9)   ; trace# field
 S IBL="eIV Trace #: ",IBY=TRACENUM               ; field label/data
 S IBLINE=$$SETL("",IBY,IBL,18,17)             ; add it
TRACEX ;
 Q IBLINE
 ;
SERVLN(IBBUFDA,SRVARRAY) ; create a service date/service type line for the display
 N NODE0,RIEN,SRVCODE,SRVDT,SRVSTR,TQIEN
 S SRVSTR=""
 I '$G(IBBUFDA) G SERVLNX
 ;IB*2.0*519 Start: Fix retrieving RIEN and TQIEN so display gets correct values
 S RIEN=+$O(^IBCN(365,"AF",IBBUFDA,""))
 S TQIEN=+$O(^IBCN(365.1,"D",IBBUFDA,""),-1)
 I TQIEN=0 S TQIEN=$P($G(^IBCN(365,RIEN,0)),U,5)
 ;IB*2.0*519 End: Fix retrieving RIEN and TQIEN so display gets correct values
 ;
 S (SRVDT,SRVCODE)="" I TQIEN D
 .S NODE0=$G(^IBCN(365.1,TQIEN,0)),SRVCODE=$P(NODE0,U,20)
 .;S RIEN=+$O(^IBCN(365,"AF",IBBUFDA,""))  ;IB*2.0*519: RIEN already retrieved above
 .I RIEN S SRVDT=$P($G(^IBCN(365,RIEN,1)),U,10) ; try to get service date from file 365
 .I SRVDT="" S SRVDT=$P(NODE0,U,12) ; if unsuccessful, get it from file 365.1
 .Q
 S SRVSTR="** This response is based on service date "_$S(SRVDT:$$FMTE^XLFDT(SRVDT,"5Z"),1:"UNKNOWN")
 S SRVSTR=SRVSTR_" and service type: "_$S(SRVCODE:$P($G(^IBE(365.013,SRVCODE,0)),U,2),1:"UNKNOWN")_" **"
SERVLNX ;
 D FSTRNG^IBJU1(SRVSTR,79,.SRVARRAY)
 Q
