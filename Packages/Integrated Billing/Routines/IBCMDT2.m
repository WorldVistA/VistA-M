IBCMDT2 ;ALB/VD - INSURANCE PLANS MISSING DATA REPORT (COMPILE) ; 10-APR-15
 ;;2.0;INTEGRATED BILLING ;**549**; 10-APR-15;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Queued Entry Point for Report.
 ;  Required variable input:  FLTRS,IBAI, IBAPL, IBGRN, IBPTY, IBTFT, IBEPT,
 ;                            IBCLM, IBBIN, IBNMSPC,IBPCN
 ;  ^TMP("IBCMDT",IBNMSPC) required if all companies and plans not selected
 ;
 ; - compile report data
 N IBI,IBIC1,IBCNS
 S IBI=0 K ^TMP($J,"PR")
 S IBIC1=""
 F  S IBIC1=$O(^TMP("IBCMDT",IBNMSPC,IBIC1)) Q:IBIC1=""  D
 . S IBCNS=0
 . F  S IBCNS=$O(^TMP("IBCMDT",IBNMSPC,IBIC1,IBCNS)) Q:'IBCNS  D
 . . D GATH
 Q
 ;
GATH ; Gather all data for a company.
 N IBCPS,IBCPT,IBCST
 S IBI=IBI+1,(IBCPT,IBCPS,IBCST)=0 ; initialize counters
 D PLAN ; gather plan info
 ;
 ; - set final company info
 S ^TMP($J,"PR",IBI)=$$COMPINF(IBCNS)_"^"_IBCPT_"^"_IBCPS
 Q
 ;
PLAN ; Gather Insurance Plan information, if necessary
 ;  Input:  IBCNS -- Pointer to the insurance company in file #36
 ;         initialized counters, plus the 'Plan' array (^TMP("IBINC",$J))
 ;
 N FNDONE,IBPTR,PLNDATA,POSWT
 S IBPTR=0
 S POSWT=$S($$GET1^DIQ(36,IBCNS,.13)="PRESCRIPTION ONLY":1,1:0)
 F  S IBPTR=$O(^IBA(355.3,"B",IBCNS,IBPTR)) Q:'IBPTR  D
 . S PLNDATA=$$PLANINF(IBPTR,POSWT)
 . Q:(+PLNDATA=-2)                          ; Skip inactive plans.
 . ;
 . ; If there's no Missing Plan Data & not looking for coverage limitations.
 . I (+PLNDATA=-1),'+$G(IBMDTSPC("IBCLM")) Q
 . S ^TMP($J,"PR",IBI,IBPTR)=PLNDATA
 . I +$G(IBMDTSPC("IBCLM")) D
 . . S FNDONE=+$$GCVLIMS(IBI,IBPTR,1)  ; This will create the cov. limit. nodes
 . . ;
 . . ; No missing coverage limitations AND no other missing data on requested
 . . ; Filters found, kill reference to the plan.
 . . I '+FNDONE,+PLNDATA=-1 K ^TMP($J,"PR",IBI,IBPTR)
 Q
 ;
COMPINF(IBCNS) ; Return formatted Insurance Company information
 ;  Input:  IBCNS  --  Pointer to the insurance company in file #36
 ; Output:  company name ^ addr ^ city/st/zip
 ;
 N POSWT,ST,X
 S POSWT=$S($$GET1^DIQ(36,IBCNS,.13)="PRESCRIPTION ONLY":1,1:0)
 S ST=$P($G(^DIC(5,+$$GET1^DIQ(36,IBCNS,.115,"I"),0)),U,2)
 S X=POSWT_U_$$GET1^DIQ(36,IBCNS,.01)_U_$$GET1^DIQ(36,IBCNS,.111)
 S X=X_U_$$GET1^DIQ(36,IBCNS,.114)_", "_ST_" "_$$GET1^DIQ(36,IBCNS,.116)
 Q X
 ;
PLANINF(PLAN,POSWT) ; Return formatted Insurance Plan information.
 ; Input:   PLAN    - Pointer to the plan in file #355.3
 ;          POSWT   -  PRESCRIPTION ONLY indicator
 ; Returns: A1^A2^A3^...^A8 Where
 ;           A1 - -2 if inactive plan, -1 if no missing data found, else 0
 ;           A2 - Plan Number
 ;           A3 - Plan Name
 ;           A4 - Type of Plan (Group or Individual
 ;           A5 - Electronic Plan Type
 ;           A6 - Timely filing Time Frame
 ;           A7 - Banking Identification Number
 ;           A8 - Process Control Number
 ;
 N BIN,EPT,NAME,NUM,PCN,TFTF,TYP,VAL
 S VAL=-2
 I +$$GET1^DIQ(355.3,+PLAN,.11,"I") Q VAL       ; INACTIVE Plan, skip
 S VAL=-1
 S NAME=$E($$GET1^DIQ(355.3,+PLAN,.03),1,45)    ; 45 Chars max
 S NUM=$$GET1^DIQ(355.3,+PLAN,.04)              ; 17 Chars max
 S:'$L(NUM) NUM="#######"
 I +$G(IBMDTSPC("IBGRN")),NUM="#######" S VAL=0 ; Found Missing data for a Filter
 S TYP=$$GET1^DIQ(355.3,+PLAN,.09)              ; 40 Chars max
 S:'$L(TYP) TYP="#######"
 I +$G(IBMDTSPC("IBPTY")),TYP="#######" S VAL=0 ; Found Missing data for a Filter
 S EPT=$$GET1^DIQ(355.3,+PLAN,.15)              ; 26 Chars max
 S:'$L(EPT) EPT="#######"
 I +$G(IBMDTSPC("IBEPT")),EPT="#######" S VAL=0 ; Found Missing data for a Filter
 S TFTF=$$FTFGP^IBCNEUT7(PLAN,1)                ; Around 30 Chars max
 I +$G(IBMDTSPC("IBTFT")),TFTF["###" S VAL=0    ; Found Missing data for a Filter
 S BIN=$$GET1^DIQ(355.3,+PLAN,6.02)             ; 10 Chars max
 ;
 ; If the plan is Prescription Only AND the Banking Identifier is blank, indicate it
 I +POSWT,'$L(BIN) S BIN="#######"
 I +$G(IBMDTSPC("IBBIN")),+POSWT,BIN="#######" S VAL=0  ; Found Missing data for a Filter
 S PCN=$$GET1^DIQ(355.3,+PLAN,6.03)             ; 20 Chars max
 ;
 ; If the plan is Prescription Only AND the Process Control Number is blank, indicate it
 I +POSWT,'$L(PCN) S PCN="#######"
 I +$G(IBMDTSPC("IBPCN")),+POSWT,PCN="#######" S VAL=0    ; Found Missing data for a Filter
 Q VAL_U_NUM_U_$E(NAME,1,12)_U_$E(TYP,1,12)_U_$E(EPT,1,12)_U_TFTF_U_BIN_U_PCN
 ;
GCVLIMS(IBI,PLAN,RECIND) ; Obtain Plans that may have Coverage Limits missing.
 ;  Input:  IBI    --  Line counter
 ;          IBCNS  --  Pointer to the insurance company in file #36
 ;          RECIND --  Indicator to determine if header record for plan is already set
 ;                     0 means ^TMP($J,"PR",IBI,IBPTR) is already set.
 ;                     1 means ^TMP($J,"PR",IBI,IBPTR) is not set yet.
 ;  Output: This will create the ^TMP($J,"PR",IBI,IBPTR,IBCVLM) node
 ;          FOUND  --  0 means a missing data coverage limitation was not found.
 ;                     1 means a missing data coverage limitation was found.
 ;
 N FOUND,IBCAT,IBCOV,IBCPTR,IBCSTA,IBCVDAT,IBEFDT,IBRECDT,IBRECN,IBREC,VAL
 S (FOUND,IBCPTR)=0
 I '$D(^IBA(355.32,"APCD",PLAN)) D  Q +FOUND
 . I '+$G(IBMDTSPC("IBCLM")) Q
 . S FOUND=1,IBCPTR=IBCPTR+1
 . S ^TMP($J,"PR",IBI,IBPTR,IBCPTR)="This plan has no coverage limitations defined."
 S IBCAT=0
 F  S IBCAT=$O(^IBE(355.31,IBCAT)) Q:'+IBCAT  D
 . I '$D(^IBA(355.32,"APCD",PLAN,IBCAT)) D  Q
 . . S IBCOV=$$GET1^DIQ(355.31,IBCAT,.01)
 . . S IBEFDT="#######",IBCSTA="#######"
 . . S IBCVDAT=IBCOV_U_IBEFDT_U_IBCSTA,FOUND=1
 . . S IBCPTR=IBCPTR+1
 . . S ^TMP($J,"PR",IBI,IBPTR,IBCPTR)=IBCVDAT
 F  S IBCAT=$O(^IBA(355.32,"APCD",PLAN,IBCAT)) Q:IBCAT=""  D
 . S IBRECDT=""
 . F  S IBRECDT=$O(^IBA(355.32,"APCD",PLAN,IBCAT,IBRECDT)) Q:IBRECDT=""  D
 . . S IBRECN=""
 . . F  S IBRECN=$O(^IBA(355.32,"APCD",PLAN,IBCAT,IBRECDT,IBRECN)) Q:IBRECN=""  D
 . . . S IBEFDT=$$DAT1^IBOUTL($$GET1^DIQ(355.32,IBRECN,.03,"I"))
 . . . I +$G(IBMDTSPC("IBCLM")) S IBEFDT=$S(+$L(IBEFDT):IBEFDT,1:"#######")   ; Effective Date
 . . . S IBCOV=$$GET1^DIQ(355.32,IBRECN,.02)
 . . . I +$G(IBMDTSPC("IBCLM")) S IBCOV=$S(+$L(IBCOV):IBCOV,1:"#######")      ; Coverage Category
 . . . S IBCSTA=$$GET1^DIQ(355.32,IBRECN,.04)
 . . . I +$G(IBMDTSPC("IBCLM")) S IBCSTA=$S(+$L(IBCSTA):IBCSTA,1:"#######")   ; Coverage Status
 . . . S IBCVDAT=IBCOV_U_IBEFDT_U_IBCSTA
 . . . I IBCVDAT["#######" S FOUND=1
 . . . S IBCPTR=IBCPTR+1
 . . . I +FOUND S ^TMP($J,"PR",IBI,IBPTR,IBCPTR)=IBCVDAT
 Q +FOUND
 ;
