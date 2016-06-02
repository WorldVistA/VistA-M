IBCNGPF2 ;ALB/CJS - LIST GRP. PLANS W/O ANNUAL BENEFITS (COMPILE) ;21-JAN-15
V ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Queued Entry Point for Report.
 ;  Required variable input:  IBAI, IBAPL, IBABY, IBAIF, IBAPF, IBOUT
 ;  ^TMP("IBINC",$J) required if not all companies and plans selected
 ;
 N IBABN,IBCN,IBCNS,IBEND,IBFOUND,IBI,IBIC1,IBIP1,IBSEL,IBXREF,IBGPN,IBQ3,IBQ4
 ;
 ; - compile report data
 S IBI=0,IBEND=-$E($G(IBABY),1,3)_"0101"
 ;
 K ^TMP($J,"IBGP"),^TMP($J,"IBGPL")
 ;
 ; - user wanted all companies and plans
 I +$G(IBAI),+$G(IBAPL) D  G PRINT
 . S IBIP1=0 F  S IBFOUND=0,IBIP1=$O(^IBA(355.3,IBIP1)) Q:'IBIP1  S IBIC1=$$GET1^DIQ(355.3,IBIP1,.01,"I") I +IBIC1 D  I 'IBFOUND S IBGPN=$E($$GET1^DIQ(355.3,IBIP1,.01),1,25) I IBGPN]"" S ^TMP($J,"IBGPL",IBGPN,IBIC1,IBIP1)=""
 . . ; - check against active/inactive selection
 . . I +$$GET1^DIQ(355.3,IBIP1,.11,"I")'=$G(IBAPF) S IBFOUND=1 Q
 . . I +$$GET1^DIQ(36,IBIC1,.05,"I")'=$G(IBAIF) S IBFOUND=1 Q
 . . ; - traverse Annual Benefits APY cross-reference:
 . . ;    ^IBA(355.4,"APY",Group Insurance Plan IEN,-AB date,AB IEN)
 . . S IBXREF="^IBA(355.4,""APY"","_IBIP1_")" F  S IBXREF=$Q(@IBXREF) Q:(IBXREF="")!($QS(IBXREF,2)'="APY")!($QS(IBXREF,3)'=IBIP1)!($QS(IBXREF,4)>IBEND)  I $QS(IBXREF,4)>-IBABY D  Q:IBFOUND
 . . . S IBABN=$QS(IBXREF,5) I $D(^IBA(355.4,IBABN)) D ABCHK Q
 ;
 ; - user selected companies or plans
 ;    ^TMP("IBINC",$J,Ins. Co. Name,Ins. Co. IEN,Group Plan IEN)
 S IBSEL=$NA(^TMP("IBINC",$J)) F  S IBFOUND=0,IBSEL=$Q(@IBSEL) Q:(IBSEL="")!($QS(IBSEL,2)'=$J)  S IBIP1=$QS(IBSEL,5)  I +IBIP1 D  I 'IBFOUND S IBQ3=$QS(IBSEL,3),IBQ4=$QS(IBSEL,4) I IBQ3]""&(IBQ4]"") S ^TMP($J,"IBGPL",IBQ3,IBQ4,IBIP1)=""
 . ; - traverse Annual Benefits APY cross-reference:
 . ;    ^IBA(355.4,"APY",Group Insurance Plan IEN,-AB date,AB IEN)
 . S IBXREF="^IBA(355.4,""APY"","_IBIP1_")" F  S IBXREF=$Q(@IBXREF) Q:(IBXREF="")!($QS(IBXREF,2)'="APY")!($QS(IBXREF,3)'=IBIP1)!($QS(IBXREF,4)>IBEND)  I $QS(IBXREF,4)>-IBABY D  Q:IBFOUND
 . . S IBABN=$QS(IBXREF,5) I $D(^IBA(355.4,IBABN)) D ABCHK Q
 ;
PRINT ; - print report
 D GATH
 K ^TMP("IBINC",$J)
 K IBABN,IBCNS,IBEND,IBFOUND,IBI,IBIC1,IBIP1
 Q
 ;
 ;
ABCHK ; Check for existing AB values
 N FLD
 F FLD=.05,.06 I $$GET1^DIQ(355.4,IBABN,FLD)]"" S IBFOUND=1 Q
 Q:IBFOUND
 F FLD=2:1:6 I $TR($G(^IBA(355.4,IBABN,FLD)),"^","")]"" S IBFOUND=1 Q
 Q
 ;
 ;
GATH ; Gather all data for a company.
 S IBCN="" F  S IBCN=$O(^TMP($J,"IBGPL",IBCN)) Q:IBCN=""  D
 .S IBCNS="" F  S IBCNS=$O(^TMP($J,"IBGPL",IBCN,IBCNS)) Q:'IBCNS  D
 ..S IBI=IBI+1 D PLAN ; gather plan info
 ..; - set final company info
 ..S ^TMP($J,"IBGP",IBI)=$$COMPINF(IBCNS),^TMP($J,"IBGP")=$G(^TMP($J,"IBGP"))+1
 ;
 K ^TMP($J,"IBGPL")
 Q
 ;
 ;
COMPINF(IBCNS) ; Return formatted Insurance Company information
 ;  Input:  IBCNS  --  Pointer to the insurance company in file #36
 ; Output:  company name ^ addr ^ city/st/zip ^ phone ^ precert ^ reimburse? ^ type of coverage
 ;
 N ACT,ADDR,CSTZ,CTYPE,NAME,PHONE,PRECERT,REIMB,ST,Z
 S NAME=$$GET1^DIQ(36,IBCNS,.01)
 S ADDR=$$GET1^DIQ(36,IBCNS,.111) I ADDR="" S ADDR="<Street Addr. 1 Missing>"
 S Z=$$GET1^DIQ(36,IBCNS,.116)
 S ST=$$GET1^DIQ(36,IBCNS,.115,"I") D
 . I ST']"" S ST="<STATE MISSING>" Q
 . S ST=$$GET1^DIQ(5,ST,1) I ST']"" S ST="<STATE MISSING>"
 S CSTZ=$$GET1^DIQ(36,IBCNS,.114)_", "_ST_"  "_$E(Z,1,5)_$S($E(Z,6,9)]"":"-"_$E(Z,6,9),1:"")
 S PHONE=$$GET1^DIQ(36,IBCNS,.131)
 S PRECERT=$$GET1^DIQ(36,IBCNS,.133)
 S REIMB=$$GET1^DIQ(36,IBCNS,1)
 S CTYPE=$$GET1^DIQ(36,IBCNS,.13)
 Q NAME_U_ADDR_U_CSTZ_U_PHONE_U_PRECERT_U_REIMB_U_CTYPE
 ;
 ;
PLAN ; Gather Insurance Plan information
 ;  Input: ^TMP($J,"IBGPL",Ins. Co. Name,Ins. Co. IEN,Plan IEN) -- Selected plans with no Annual Benefits
 ;         IBCNS -- Pointer to the insurance company in file #36
 ;         initialized counters
 ; 
 N IBPTR
 I $G(IBCN)]"",$G(IBCNS)]"" S IBPTR=0 F  S IBPTR=$O(^TMP($J,"IBGPL",IBCN,IBCNS,IBPTR)) Q:'IBPTR  D
 . I +$G(IBI) S ^TMP($J,"IBGP",IBI,IBPTR)=$$PLANINF(IBPTR)
 Q
 ;
PLANINF(PLAN) ; Return formatted Insurance Plan information.
 ;  Input:  PLAN  --  Pointer to the plan in file #355.3
 ; Output:  plan name ^ number ^ act/inact ^ last edited by ^ plan type
 ;
 N ACT,NAME,NUM,TY,USER
 S NAME=$$GET1^DIQ(355.3,PLAN,2.01) S:NAME="" NAME="<NO GROUP NAME>"
 S NUM=$$GET1^DIQ(355.3,PLAN,2.02) S:NUM="" NUM="<NO GROUP NUMBER>"
 S ACT=$S($$GET1^DIQ(355.3,PLAN,.11,"I"):"IN",1:"")_"ACTIVE"
 S USER=$$GET1^DIQ(355.3,PLAN,1.06)
 S TY=$$GET1^DIQ(355.3,PLAN,.09)
 Q NAME_U_NUM_U_ACT_U_USER_U_TY
