IBCBB13 ;ALB/BI - PROCEDURE AND LINE LEVEL PROVIDER EDITS ;5-OCT-2011
 ;;2.0;INTEGRATED BILLING;**447,608**;21-MAR-94;Build 90
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
IBLNTOT(IBIFN)   ; Calculate Line total charges.  IB*2.0*447 BI
 N X,SUM S SUM=0
 S X=0 F  S X=$O(^DGCR(399,IBIFN,"RC",X)) Q:+X=0  D
 . S SUM=SUM+$P($G(^DGCR(399,IBIFN,"RC",X,0)),"^",4)
 Q SUM
 ;
IBSYEI(IBIFN)   ; Test for valid EIN/SY ID Values. IB*2.0*447 BI
 N X12CODE,RESULT,IBPIEN,IBWIEN,IBLIEN
 S RESULT=0
 ; Check Claim Level Providers
 S IBWIEN=IBIFN_","
 S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399,IBWIEN,128,"I")_",",.03)
 I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399,IBWIEN,122),"-","")'?9N S RESULT=1 Q RESULT
 S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399,IBWIEN,129,"I")_",",.03)
 I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399,IBWIEN,123),"-","")'?9N S RESULT=1 Q RESULT
 S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399,IBWIEN,130,"I")_",",.03)
 I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399,IBWIEN,124),"-","")'?9N S RESULT=1 Q RESULT
 ; Check Claim Level Providers
 S IBPIEN=0 F  S IBPIEN=$O(^DGCR(399,IBIFN,"PRV",IBPIEN)) Q:+IBPIEN=0  Q:RESULT=1  D
 .S IBWIEN=IBPIEN_","_IBIFN_","
 .; Test for each provider listed.
 .S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399.0222,IBWIEN,.12,"I")_",",.03)
 .I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399.0222,IBWIEN,.05),"-","")'?9N S RESULT=1 Q
 .S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399.0222,IBWIEN,.13,"I")_",",.03)
 .I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399.0222,IBWIEN,.06),"-","")'?9N S RESULT=1 Q 
 .S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399.0222,IBWIEN,.14,"I")_",",.03)
 .I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399.0222,IBWIEN,.07),"-","")'?9N S RESULT=1 Q
 ; Check Line Level Providers
 ; For each charge code / line.
 S IBLIEN=0 F  S IBLIEN=$O(^DGCR(399,IBIFN,"CP",IBLIEN)) Q:+IBLIEN=0  Q:RESULT=1  D
 .; For each provider associated with the line.
 .S IBPIEN=0 F  S IBPIEN=$O(^DGCR(399,IBIFN,"CP",IBLIEN,"LNPRV",IBPIEN)) Q:+IBPIEN=0  Q:RESULT=1  D
 ..S IBWIEN=IBPIEN_","_IBLIEN_","_IBIFN_","
 ..; Test for each provider listed.
 ..S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399.0404,IBWIEN,.12,"I")_",",.03)
 ..I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399.0404,IBWIEN,.05),"-","")'?9N S RESULT=1 Q
 ..S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399.0404,IBWIEN,.13,"I")_",",.03)
 ..I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399.0404,IBWIEN,.06),"-","")'?9N S RESULT=1 Q
 ..S X12CODE=$$GET1^DIQ(355.97,$$GET1^DIQ(399.0404,IBWIEN,.14,"I")_",",.03)
 ..I ((X12CODE="SY")!(X12CODE="EI")),$TR($$GET1^DIQ(399.0404,IBWIEN,.07),"-","")'?9N S RESULT=1 Q
 Q RESULT
 ;
IBMICN(IBIFN)   ; Test for a missing ICN. IB*2.0*447 BI
 N IBTFOB ; TIMEFRAME OF BILL
 N IBCBPS ; CURRENT BILL PAYER SEQUENCE, P-PRI, S-SEC, T-TER, A-PATIENT
 S IBTFOB=$$GET1^DIQ(399,IBIFN_",",.06,"I")
 I '((IBTFOB=7)!(IBTFOB=8)) Q 0
 S IBCBPS=$$GET1^DIQ(399,IBIFN_",",.21,"I")
 I IBCBPS="P",$$GET1^DIQ(399,IBIFN_",",101)'="",$$GET1^DIQ(399,IBIFN_",",453)="" Q 1
 I IBCBPS="S",$$GET1^DIQ(399,IBIFN_",",102)'="",$$GET1^DIQ(399,IBIFN_",",454)="" Q 1
 I IBCBPS="T",$$GET1^DIQ(399,IBIFN_",",103)'="",$$GET1^DIQ(399,IBIFN_",",455)="" Q 1
 Q 0
 ;
IBRCCHK(IBIFN)   ; Test for a ZERO charge amounts. IB*2.0*447 BI
 N IBN0
 N IBRCCNT S IBRCCNT=0
 N IBRCCHG S IBRCCHG=0
 F  S IBRCCNT=$O(^DGCR(399,IBIFN,"RC",IBRCCNT)) Q:+IBRCCNT=0  Q:IBRCCHG=1  D
 .S IBN0=$G(^DGCR(399,IBIFN,"RC",IBRCCNT,0))
 .I $P(IBN0,U,1)'="",+$P(IBN0,U,4)=0 S IBRCCHG=1
 Q IBRCCHG
 ;
IBPRV3(IBIFN)   ; Test for missing "Patient reason for visit". IB*2.0*447 BI
 I $$GET1^DIQ(399,IBIFN_",",249)="",$$GET1^DIQ(399,IBIFN_",",250)="",$$GET1^DIQ(399,IBIFN_",",251)="" Q 1
 Q 0
 ;
IBMPID(IBIFN)   ; Test for multiple payers. IB*2.0*447 BI
 N IBPAY1 S IBPAY1=$$GET1^DIQ(399,IBIFN_",",101,"I")
 N IBPAY2 S IBPAY2=$$GET1^DIQ(399,IBIFN_",",102,"I")
 N IBPAY3 S IBPAY3=$$GET1^DIQ(399,IBIFN_",",103,"I")
 N IBCNT S IBCNT=0
 S:IBPAY1 IBCNT=IBCNT+1 S:IBPAY2 IBCNT=IBCNT+1 S:IBPAY3 IBCNT=IBCNT+1 I IBCNT<2 Q 0
 N IBINSTIT S IBINSTIT=$$INSPRF^IBCEF(IBIFN)
 I IBPAY1,$S(IBINSTIT:$$GET1^DIQ(36,IBPAY1_",",3.04),1:$$GET1^DIQ(36,IBPAY1_",",3.02))="" Q 1
 I IBPAY2,$S(IBINSTIT:$$GET1^DIQ(36,IBPAY2_",",3.04),1:$$GET1^DIQ(36,IBPAY2_",",3.02))="" Q 1
 I IBPAY3,$S(IBINSTIT:$$GET1^DIQ(36,IBPAY3_",",3.04),1:$$GET1^DIQ(36,IBPAY3_",",3.02))="" Q 1
 Q 0
 ;
CMNCHK(IBIFN) ;JRA;IB*2.0*608 Check for missing required Certificate of Medical Necessity (CMN) data
 ; Input : IBIFN = IEN of the Bill/Claim (D399)
 ; Output: IBER  = NULL if no errors      
 ;               = String of IB Error Message codes delimited by ';'
 ;               => Note that the return value is appended to the 'IBER' variable in routine ^IBCBB1
 Q:IBIFN="" ""
 N CERTYP,CMNNODE,CMNREQ,DA,DIE,ERR,FRMNAM,FRMIEN,FORM,FRMTYP,IBER,IBPROCP,PROCNUM
 S IBER=""
 ;Set up array of each existing Form Type (i.e. Form IENs) and associated ^DGCR data node.
 S FRMNAM="" F  S FRMNAM=$O(^IBE(399.6,"B",FRMNAM)) Q:FRMNAM=""  S FRMIEN=+$O(^IBE(399.6,"B",FRMNAM,"")) I FRMIEN D
 . S FORM(FRMIEN)=$P($G(^IBE(399.6,FRMIEN,0)),U,4)
 ;Loop thru all procedures on the claim searching for missing CMN data
 S IBPROCP=0 F  S IBPROCP=$O(^DGCR(399,IBIFN,"CP",IBPROCP)) Q:'IBPROCP  D  Q:IBER]""
 . ;If "CMN Required?" is NULL then QUIT w/out further checking
 . S CMNREQ=$$CVALCHK(IBPROCP,23,,"I") Q:CMNREQ=""
 . I 'CMNREQ,$D(FORM)>1 D  Q  ;"CMN Required?" flagged as "NO" so check if data node(s) exist anyway for at least 1 form
 . . S ERR=0,FRMIEN="" F  S FRMIEN=$O(FORM(FRMIEN)) Q:FRMIEN=""  I FORM(FRMIEN)]"" D  Q:ERR
 . . . S CMNNODE="^DGCR(399,"_IBIFN_",""CP"","_IBPROCP_","""_FORM(FRMIEN)_""")" I $D(@CMNNODE) S ERR=1,IBER=IBER_"IB901;"
 . S FRMTYP=$$CVALCHK(IBPROCP,24,"IB902","I") Q:'FRMTYP  ;Check for "CMN FORM TYPE" (Internal value)
 . I $G(FORM(FRMTYP))]"" D  Q:ERR
 . . ;Check if any data exists at the node specific to the Form Type
 . . S ERR=0,CMNNODE="^DGCR(399,"_IBIFN_",""CP"","_IBPROCP_","""_FORM(FRMTYP)_""")"
 . . I '$D(@CMNNODE) S ERR=1,IBER=IBER_"IB903;" Q
 . . Q:FORM(FRMTYP)'[10126
 . . N ND10126
 . . S ND10126=@CMNNODE
 . . I $P(ND10126,U,17)]"" S $P(ND10126,U,17)="" I $TR(ND10126,U)="" S ERR=1,IBER=IBER_"IB903;"
 . ;Check if any data exists for at least 1 node other than that associated with the Form Type 
 . S ERR=0,FRMIEN="" F  S FRMIEN=$O(FORM(FRMIEN)) Q:FRMIEN=""  I FRMIEN'=FRMTYP,FORM(FRMIEN)]"" D  Q:ERR
 . . S CMNNODE="^DGCR(399,"_IBIFN_",""CP"","_IBPROCP_","""_FORM(FRMIEN)_""")" I $D(@CMNNODE) S ERR=1,IBER=IBER_"IB904;"
 . ;Check for Required fields at the data node common to all forms (node 'CMN')
 . S CERTYP=$$CVALCHK(IBPROCP,24.01,"IB905","I") Q:CERTYP=""  ;Check for "CMN CERTIFICATION TYPE"
 . D CVALCHK(IBPROCP,24.05,"IB907","I")  ;Check for "CMN DATE THERAPY STARTED"
 . D CVALCHK(IBPROCP,24.06,"IB908","I")  ;Check for "CMN LAST CERTIFICATION DATE"
 . ;IF Certificate Type is "RENEWAL" (R) or "REVISED" (S) then "CMN RECERTIFICATION/REVISN DT" is Required.
 . I CERTYP="R"!(CERTYP="S") D CVALCHK(IBPROCP,24.07,"IB909","I")
 . ;
 . ;Check for required fields specific to the CMN-484 form
 . I FORM(FRMTYP)[484 D  ;Check for required fields/dates
 . . I $$CVALCHK(IBPROCP,24.1,,"I")]""!($$CVALCHK(IBPROCP,24.102,,"I")]"") D CVALCHK(IBPROCP,24.103,"IB912","I")
 . . I $$CVALCHK(IBPROCP,24.111,,"I")]""!($$CVALCHK(IBPROCP,24.113,,"I")]"") D CVALCHK(IBPROCP,24.114,"IB914","I")
 . ;
 . ;Check for required fields specific to the CMN-10126 form
 . I FORM(FRMTYP)[10126 D
 . . D CVALCHK(IBPROCP,24.217,"IB906","I")
 . . N PROCMSG
 . . S PROCMSG="CMN ""Procedure ",PROCMSG(1)=""" has no associated Calories."
 . . I $$CVALCHK(IBPROCP,24.204,,"I")]"",'$$CVALCHK(IBPROCP,24.203,,"I") D WARN^IBCBB11(PROCMSG_"A"_PROCMSG(1))
 . . I $$CVALCHK(IBPROCP,24.219,,"I")]"",'$$CVALCHK(IBPROCP,24.218,,"I") D WARN^IBCBB11(PROCMSG_"B"_PROCMSG(1))
 ;
 I IBER]"" S IBER="IB915;"_IBER
 Q IBER
 ;
CVALCHK(IBPROCP,FLD,ERROR,FLG) ;JRA;IB*2.0*608 Check value of CMN field & append Error Code (if any) to list of errors
 Q:($G(FLD)=""!('$G(IBPROCP)))
 N VAL
 S VAL=$$CMNDATA^IBCEF31(IBIFN,IBPROCP,FLD,$G(FLG))
 I $G(ERROR)]"",VAL="" S IBER=IBER_ERROR_";"
 Q VAL
 ;
