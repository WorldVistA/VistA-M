IBTRC3 ;ALB/AAS - CLAIMS TRAINING INS. REV DEFAULTS ; 29-SEP-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LAST(IBTRN,IBTRC) ; -- return last insurance review
 ; -- Input  IBTRN  = claims tracking id
 ;           IBTRC  = ins. review being edited (option)
 ;                    (if hip is defined for ibtrc will use last review
 ;                     for that policy)
 ;
 N X,Y,IBHIP,IBQUIT
 S Y="",IBQUIT=0
 I '$G(IBTRN) G LASTQ
 S IBHIP=$P($G(^IBT(356.2,+$G(IBTRC),1)),"^",5)
 S X=-$G(^IBT(356.2,+IBTRC,0)) F  S X=$O(^IBT(356.2,"ATIDT",IBTRN,X)) Q:'X!(IBQUIT)  D
 .S Y="" F  S Y=$O(^IBT(356.2,"ATIDT",IBTRN,X,Y)) Q:'Y!('IBHIP)  D  Q:IBQUIT
 ..I $P($G(^IBT(356.2,+Y,1)),"^",5)=IBHIP S IBQUIT=1 Q
LASTQ Q $S(+Y<1:"",Y:Y,1:"")
 ;
HIP(IBTRC) ; -- compute default health insurance policy for claims tracking
 ; -- called by trigger on patient field (.05) of file 356.2
 ; -- output pointer to subfile (2.312)^insurnace co name
 N X,IBDD,IBINDT,DFN
 S X=""
 S DFN=$P($G(^IBT(356.2,+$G(IBTRC),0)),"^",5)
 G:'DFN HIPQ
 S IBINDT=$S($P($G(^IBT(356,+$P($G(^IBT(356.2,+IBTRC,0)),U,2),0)),U,6):$P(^(0),U,6),1:DT)
 D ALL^IBCNS1(DFN,"IBDD",1,IBINDT)
 I $G(IBDD(0))=1 S X=+$O(IBDD(0))
 ;
 ; -- if more than one look for primary
 I 'X,$G(IBDD(0))>1 D
 .S IBX=0
 .F  S IBX=$O(IBDD(IBX)) Q:'IBX  I $P($G(IBDD(IBX,0)),"^",20)=1 S X=IBX Q
 I X S X=X_"^"_$P($G(^DIC(36,+$G(IBDD(X,0)),0)),"^")
HIPQ Q X
 ;
HIPD(DA,IBTLST) ; -- compute default health insurance policy from last review
 ; -- called from input templates
 ;    input da     = current entry being edited
 ;          ibtlst = last entry for this review as determine by $$LAST
 ;
 N X,DFN
 S X="" I $P($G(^IBT(356.2,DA,1)),"^",5) G HIPDQ
 G:'$G(IBTLST) HIPDQ
 S X=$P($G(^IBT(356.2,+IBTLST,1)),"^",5),DFN=$P(^(0),"^",5)
HIPDQ Q $S(+X<1:"",1:$P($G(^DIC(36,+$G(^DPT(DFN,.312,X,0)),0)),"^",1))
 ;
PC(DA,IBTLST) ; -- compute default person contacted from last review
 ; -- called from input templates
 ;    input da     = current entry being edited
 ;          ibtlst = last entry for this review as determine by $$LAST
 ;
 Q $P($G(^IBT(356.2,+$G(IBTLST),0)),"^",6)
 ;
MC(DA,IBTLST) ; -- compute default method of contact from last review
 ; -- called from input templates
 ;    input da     = current entry being edited
 ;
 ;          ibtlst = last entry for this review as determine by $$LAST
 ;
 N X
 S X=$P($G(^IBT(356.2,+$G(IBTLST),0)),"^",17)
 Q $S(+X>0:$$EXPAND^IBTRE(356.2,.17,X),1:"PHONE")
 ;
CP(DA,IBTLST) ; -- compute default contact phone number from last review
 ; -- called from input templates
 ;    input da     = current entry being edited
 ;          ibtlst = last entry for this review as determine by $$LAST
 ;
 Q $P($G(^IBT(356.2,+$G(IBTLST),0)),"^",7)
 ;
AN(DA,IBTLST) ; -- compute default authorization number policy
 ; -- called from input templates
 ;    input da     = current entry being edited
 ;          ibtlst = last entry for this review as determine by $$LAST
 N X
 S X=$P(^IBT(356.2,DA,0),"^",9)
 Q $E($S($L(X):X,1:$P($G(^IBT(356.2,+$G(IBTLST),0)),"^",28)),1,10)
 ;
APPEAL ; -- called from IBTRC, needed more room to compute
 ;    info if an appeal
 N DAYS S DAYS=""
 S X=$$SETFLD^VALM1($$EXPAND^IBTRE(356.2,.29,$P(IBTRCD,"^",29)),X,"ACTION")
 S DAYS=$P(IBTRCD,"^",25) I $P(IBTRCD,"^",29)=1,$P(IBTRCD,"^",10)=3,$O(^IBT(356.2,+IBTRC,14,0)) S DAYS=$$AP^IBTODD1(IBTRC)
 S X=$$SETFLD^VALM1($J(DAYS,3),X,"DAYS")
 S X=$$SETFLD^VALM1($$TPE(),X,"TYPE")
 Q
 ;
TPE() ; -- add appeal type to type of action
 N X
 S X=$P(IBETYP,"^",3)
 I $P(IBTRCD,"^",23) S X=X_"-"_$S($P(IBTRCD,"^",23)=1:"Clin",$P(IBTRCD,"^",23)=2:"Admin",1:"")
 Q X
