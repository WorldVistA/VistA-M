IBCEMSR5  ;BI/ALB - non-MRA PRODUCTIVITY REPORT ;02/14/11
 ;;2.0;INTEGRATED BILLING;**447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
CALCPCT  ; Calculate final percentages for the Summary Report
 N IBDIV,IBACCUM,IBFT,IBPERCENT
 S IBDIV=""
 F  S IBDIV=$O(IBLTMP(IBDIV)) Q:IBDIV=""  D
 . F IBACCUM="SPAA","SPAB","SSAA","SSAB" F IBFT=2,3 D
 .. S IBLTMP(IBDIV,IBACCUM,IBFT)="0%"
 . F IBFT=2,3 D
 .. I +$G(IBLTMP(IBDIV,"SPA",IBFT)) D
 ... S IBPERCENT=$G(IBLTMP(IBDIV,"SPAC",IBFT))*100/IBLTMP(IBDIV,"SPACL",IBFT)
 ... S IBLTMP(IBDIV,"SPAA",IBFT)=$S(((IBPERCENT>0)&(IBPERCENT<1)):"<1",1:$J(IBPERCENT,0,0))_"%"
 ... S IBPERCENT=$G(IBLTMP(IBDIV,"SPACA",IBFT))*100/IBLTMP(IBDIV,"SPACL",IBFT)
 ... S IBLTMP(IBDIV,"SPAB",IBFT)=$S(((IBPERCENT>0)&(IBPERCENT<1)):"<1",1:$J(IBPERCENT,0,0))_"%"
 .. I +$G(IBLTMP(IBDIV,"SSA",IBFT)) D
 ... S IBPERCENT=$G(IBLTMP(IBDIV,"SSAC",IBFT))*100\IBLTMP(IBDIV,"SSACL",IBFT)
 ... S IBLTMP(IBDIV,"SSAA",IBFT)=$S(((IBPERCENT>0)&(IBPERCENT<1)):"<1",1:$J(IBPERCENT,0,0))_"%"
 ... S IBPERCENT=$G(IBLTMP(IBDIV,"SSACA",IBFT))*100\IBLTMP(IBDIV,"SSACL",IBFT)
 ... S IBLTMP(IBDIV,"SSAB",IBFT)=$S(((IBPERCENT>0)&(IBPERCENT<1)):"<1",1:$J(IBPERCENT,0,0))_"%"
 Q
 ;
NOSUB(IBIFN)  ; Check for subsequent payer or balance due.
 N IBPY,IBOAM,IBX,IBTXT
 I $P($$BILL^RCJIBFN2(IBIFN),U,2)=22 D
 . S IBPY=$$TPR^PRCAFN(IBIFN)             ; payment on this bill from A/R  IA#380
 . S IBOAM=+$G(^DGCR(399,IBIFN,"U1"))     ; total charges for bill
 . S IBX=$$EOB^IBCNSBL2(IBIFN,IBOAM,IBPY,.IBTXT)
 Q '$D(IBTXT)
 ;
PROCSSED(IBIFN) ;CLAIM/BILL Requests Processed?
 ; Search dictionary 361.1 for this CLAIM/BILL#
 ; If at least one request is 'processed' the CLAIM/BILL is considered processed.
 N IBPSD,IEN,IBZ
 S IBPSD=0
 S IEN=0 F  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  D  Q:IBPSD
 . S IBZ=$G(^IBM(361.1,IEN,0))
 . I $P(IBZ,U,4)'=0 Q  ; Scan for only Normal EOBs (Non-MRA)
 . I $P(IBZ,U,13)=1 S IBPSD=1
 Q IBPSD
 ;
DENIED(IBIFN) ;CLAIM/BILL Requests Denied?
 ; Search dictionary 361.1 for this CLAIM/BILL#
 ; If all request are 'denied' the CLAIM/BILL is considered denied.
 N IBDEN,IEN,IBZ
 S IBDEN=1
 S IEN=0 F  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  D  Q:'IBDEN
 . S IBZ=$G(^IBM(361.1,IEN,0))
 . I $P(IBZ,U,4)'=0 Q  ; Scan for only Normal EOBs (Non-MRA)
 . I $P(IBZ,U,13)'=2 S IBDEN=0
 Q IBDEN
