IBCNBMN ;ALB/ARH-Ins Buffer: add new insurance file entrys ; 4/22/03 10:00am
 ;;2.0;INTEGRATED BILLING;**82,211**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
NEWINS(IBBUFDA) ; add new insurance carrier entry in Insurance Company (#36) file
 ;
 N DIC,DA,DIE,DR,X,Y,DLAYGO,IBINSDA,IB20,IBINSNM,IBREIMB S IBINSDA=0,IB20=$G(^IBA(355.33,+$G(IBBUFDA),20))
 S IBINSNM=$P(IB20,U,1) I IBINSNM="" G NIQ
 ;
 S IBREIMB=$P(IB20,U,5) I IBREIMB'="" S DIC("DR")="1///"_IBREIMB ;                     will reimburse?
 K DD,DO S DIC="^DIC(36,",DIC(0)="L",X=IBINSNM,DLAYGO=36 D FILE^DICN I +Y>0  S IBINSDA=+Y
 ;
NIQ Q IBINSDA
 ;
NEWGRP(IBBUFDA,IBINSDA) ; add a new group/plan to the Group Insurance Plan (#355.3) file, also add standard fields
 ;
 N DIC,DA,DR,DIE,X,Y,DLAYGO,IBGRPDA,IB40,IBFIELDS,IBERR,IBXIFN S IBGRPDA=0,IB40=$G(^IBA(355.33,+$G(IBBUFDA),40))
 I '$D(^DIC(36,+$G(IBINSDA),0)) G NGQ
 I $P(IB40,U,1)=0,'$G(^IBA(355.33,+$G(IBBUFDA),60)) G NGQ
 ;
 K DA,DO S DIC="^IBA(355.3,",DIC(0)="L",X=IBINSDA,DLAYGO=355.3 D FILE^DICN I +Y'>0 G NGQ
 S IBGRPDA=+Y,IBXIFN=IBGRPDA_","
 ;
 S IBFIELDS(355.3,IBXIFN,.02)=$P(IB40,U,1) ;                                           group plan?
 I $P(IB40,U,1)=0 S IBFIELDS(355.3,IBXIFN,.1)=+$G(^IBA(355.33,+$G(IBBUFDA),60)) ;   individual plan patient
 D FILE^DIE("","IBFIELDS","IBERR")
 ;
NGQ Q IBGRPDA
 ;
NEWPOL(IBBUFDA,IBINSDA,IBGRPDA) ; add a new patient policy to the Patient's Insurance Policys (2.312), also add standard fields
 ;
 N DIC,DA,DR,DIE,X,Y,IBPOLDA,IBFIELDS,IBERR,DFN,IBGRP,IBXIFN S IBPOLDA=0
 I '$D(^DIC(36,+$G(IBINSDA),0)) G NPQ
 S IBGRP=$G(^IBA(355.3,+$G(IBGRPDA),0)) I +IBGRP'=IBINSDA G NPQ
 S DFN=+$G(^IBA(355.33,+$G(IBBUFDA),60)) I 'DFN G NPQ
 I $P(IBGRP,U,10)'="",$P(IBGRP,U,10)'=DFN G NPQ
 ;
 ; IB*2*211
 L +^DPT(DFN,.312):5 I '$T D LOCKED^IBTRCD1 G NPQ
 I $G(^DPT(DFN,.312,0))="" S ^DPT(DFN,.312,0)="^2.312PAI^^"
 ;
 K DA,DO S DIC="^DPT("_DFN_",.312,",DIC(0)="L",X=IBINSDA,DA(1)=DFN D FILE^DICN I +Y'>0 G NPQ
 S IBPOLDA=+Y,IBXIFN=IBPOLDA_","_DFN_","
 ;
 S IBFIELDS(2.312,IBXIFN,.18)=IBGRPDA ;                                                 policy's group/plan
 S IBFIELDS(2.312,IBXIFN,1.09)=$P($G(^IBA(355.33,+$G(IBBUFDA),0)),U,3) ;                source
 S IBFIELDS(2.312,IBXIFN,1.1)=+$G(^IBA(355.33,+$G(IBBUFDA),0)) ;                        source date
 D FILE^DIE("","IBFIELDS","IBERR")
 L -^DPT(DFN,.312)
 ;
NPQ Q IBPOLDA
