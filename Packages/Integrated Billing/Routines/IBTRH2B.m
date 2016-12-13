IBTRH2B ;ALB/JWS - HCSR worklist expand entry, send 215 ;18-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SEND215 ; send 278X215 inquiry ; JWS 10/17/14 add ability to manually submit a 278x215 Inquiry
 N ADMIEN,DDT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EDT,DISIEN,IENS,STATUS,X,Y,NEWIEN
 N IBRESP,ERROR,IBFDA,TTYPE
 S IBRESP=0
 S VALMBCK="R"
 ; if no valid 356.22 ien, complain and bail out
 I +$G(IBTRIEN)'>0 D MSG215^IBTRH2A(1) Q
 I $P(^IBT(356.22,IBTRIEN,0),"^",19) D MSG215^IBTRH2A(5) Q
 S STATUS=$$STATUS^IBTRH2(IBTRIEN)
 ; don't send an inquiry if status of 217 is not 07 Pending
 I STATUS'="07" D MSG215^IBTRH2A(3) Q
 ; Create the 278 request to be sent
 ; S DIR("A")="Send Inquiry? (Y/N): ",DIR("B")="Y",DIR(0)="YAO" D ^DIR K DIR
 S DIR("A")="Send (I)nquiry or (C)ancel? ",DIR("B")="I",DIR(0)="SAO^I:Inquiry;C:Cancel" D ^DIR K DIR
 ;I $G(DTOUT)!$G(DUOUT)!$G(DIROUT)!($G(Y)'=1) Q
 I $G(DTOUT)!$G(DUOUT)!$G(DIROUT) Q
 S TTYPE=Y,NEWIEN=$$CRTENTRY^IBTRH5C(IBTRIEN,$P(^IBT(356.22,IBTRIEN,0),"^",14),$P(^IBT(356.22,IBTRIEN,0),"^",3),"",0,"",1,Y)  ;create 215 entry from original 217
 I 'NEWIEN D MSG215^IBTRH2A(4) Q
 S IBFDA(356.22,NEWIEN_",",.2)=1
 S IBFDA(356.22,NEWIEN_",",.26)=1  ;flag indicating manual 215
 D FILE^DIE(,"IBFDA","ERROR")
 D EN^IBTRHLO(NEWIEN,1)
 S IBFDA(356.22,IBTRIEN_",",.19)=1  ;flag request/inquiry as having already had a 215 generated
 S IBFDA(356.22,IBTRIEN_",",.08)="09"  ;set status to 215 inquiry sent, so skipped by worklist
 D FILE^DIE(,"IBFDA","ERROR") Q:$D(ERROR)
 ; check if message id got populated and display appropriate message
 H 2
 D MSG215^IBTRH2A($S($P($G(^IBT(356.22,NEWIEN,0)),U,12)="":2,1:0),TTYPE)
 ;I $P($G(^IBT(356.22,NEWIEN,0)),"^",12)'="" D
 ;. S IBFDA(356.22,IBTRIEN_",",.19)=1  ;flag request/inquiry as having already had a 215 generated
 ;. S IBFDA(356.22,IBTRIEN_",",.08)="09"  ;set status to 215 inquiry sent, so skipped by worklist
 ;. D FILE^DIE(,"IBFDA","ERROR") Q:$D(ERROR)
 ; refresh display
 D INIT^IBTRH2
 Q
