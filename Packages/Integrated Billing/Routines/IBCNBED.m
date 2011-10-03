IBCNBED ;ALB/ARH-Ins Buffer: delete existing entries in buffer ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DELDATA(IBBUFDA) ; delete all insurance/group/policy data from buffer file entry, leaving stub entry
 ; deletes all data with field numbers 1 or greater and blank nodes
 ;
 Q:'$G(^IBA(355.33,+$G(IBBUFDA),0))
 N DR,DA,DIE,DIC,X,Y,IBFLDS,IBIFN,IBFLD,IBCNT,IBI,IBX S IBIFN=IBBUFDA_",",DR="",IBCNT=1
 ;
 D GETS^DIQ(355.33,IBIFN,"1:999","IN","IBFLDS") ; returns all non-blank fields
 ;
 S IBFLD=0 F  S IBFLD=$O(IBFLDS(355.33,IBIFN,IBFLD)) Q:'IBFLD  D  ; set up DR string
 . I $L(DR)>200 S DR(1,355.33,IBCNT)=DR,DR="",IBCNT=IBCNT+1
 . S DR=DR_IBFLD_"///@;"
 ;
 I DR'="" D  ; delete data then nodes
 . S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DA,DIC,DIE,DR
 . ;
 . ; if Status is Entered, change it to Rejected, there should be no entry with a status of Entered without data
 . I $P(^IBA(355.33,IBBUFDA,0),U,4)="E" D STATUS^IBCNBEE(IBBUFDA,"R")
 ;
 ; kill blank nodes since DIE doesn't
 S IBI=0 F  S IBI=$O(^IBA(355.33,IBBUFDA,IBI)) Q:'IBI  S IBX=$G(^IBA(355.33,IBBUFDA,IBI)) I IBX?."^" K ^IBA(355.33,IBBUFDA,IBI)
 Q
