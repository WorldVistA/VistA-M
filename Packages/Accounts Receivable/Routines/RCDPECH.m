RCDPECH ;ALB/PJH - RECEIPT COMMENT HISTORY ;24-FEB-03
 ;;4.5;Accounts Receivable;**173,276,321**;Mar 20, 1995;Build 48
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
AUDIT(RCRCPT,RCLINE,RCZ,RCR) ;EP store entry in RCDPE COMMENT HISTORY
 ;Input
 ; RCRCPT - Receipt IEN #344
 ; RCLINE - Receipt line number
 ; RCZ    - Scratchpad IEN (optional)
 ; RCR    - Scratchpad line number (optional)
 ;Output
 ; Write record to #344.73 - RCDPE COMMENT HISTORY
 ;
 Q:'$G(RCRCPT)
 Q:'$G(RCLINE)
 ;
 N RCCOM,RCDATE,RCUSER
 ; Use scratchpad as data source if passed
 I $G(RCZ),$G(RCR) D  Q:RCCOM=""
 . S RCCOM=$$GET1^DIQ(344.491,RCR_","_RCZ_",",.1)
 . S RCUSER=$$GET1^DIQ(344.491,RCR_","_RCZ_",",2.03,"I")
 . S RCDATE=$$GET1^DIQ(344.491,RCR_","_RCZ_",",2.04,"I")
 ; Otherwise use receipt fields and current user/time
 E  D  Q:RCCOM=""
 . S RCDATE=$$NOW^XLFDT
 . S RCCOM=$$GET1^DIQ(344.01,RCLINE_","_RCRCPT_",",1.02)
 . S RCUSER=DUZ
 ; Use current date if original date is not found
 I 'RCDATE S RCDATE=$$NOW^XLFDT
 ; Use current user if original user not found
 I 'RCUSER S RCUSER=DUZ
 ;
 N RCAUDIT
 ;
 ; Set up array for UPDATE^DIE
 S RCAUDIT(344.73,"+1,",.01)=RCRCPT ;Receipt
 S RCAUDIT(344.73,"+1,",1)=RCLINE   ;Receipt line number
 S RCAUDIT(344.73,"+1,",2)=RCUSER   ;User
 S RCAUDIT(344.73,"+1,",3)=RCDATE   ;Date
 S RCAUDIT(344.73,"+1,",4)=RCCOM    ;Comment
 ;
 ; Update file
 D UPDATE^DIE(,"RCAUDIT")
 Q
 ;
GET(RETURN,RCRCPT,RCLINE) ;EP Get comment history for a receipt
 ;Input
 ; RCRCPT - Receipt IEN
 ; RCLINE - Receipt line number
 ;Output
 ; RETURN(N) = Date ^ User Name ^ Comment text
 ;
 Q:'$G(RCRCPT)  Q:'$G(RCLINE)
 ;
 N RCCOMM,RCDA,RCDATE,RCCDT,RCUSER
 ; Return comments - most recent first in return array
 S RETURN=0,RCCDT=9999999
 F  S RCCDT=$O(^RCY(344.73,"AC",RCRCPT,RCLINE,RCCDT),-1) Q:'RCCDT  D
 . S RCDA=$G(^RCY(344.73,"AC",RCRCPT,RCLINE,RCCDT)) Q:'RCDA
 . ; Get comments and user details
 . S RCCOM=$$GET1^DIQ(344.73,RCDA_",",4)
 . S RCUSER=$$GET1^DIQ(344.73,RCDA_",",2,"E")
 . S RCDATE=$$GET1^DIQ(344.73,RCDA_",",3,"E")
 . S RETURN=RETURN+1,RETURN(RETURN)=RCDATE_U_RCUSER_U_RCCOM
 Q
 ;
COM() ;EP Receipt line comment entry
 ;
 ;Output
 ; Y - Comment text (3 - 60 characters)
 ;     or -1 = abort/timeout
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="COMMENT: "
 S DIR(0)="SA^1:Collected/Closed;2:Cancelled;3:Returned refund;4:Overpayment;5:Inactive bill;"
 S DIR(0)=DIR(0)_"6:Duplicate payment;7:Policy termed;8:Service connected;9:Other"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT) -1
 ; If selection is not 'Other' use selection as comment text
 I Y'=9 S Y=Y(0) Q Y
 ; Otherwise force entry of free text comment of 3 to 60 characters 
 F  D  Q:Y'=""
 . S DIR(0)="344.491,.1A",DIR("A")=" COMMENT TEXT: "
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S Y=-1 Q
 . ; Remove leading or trailing spaces
 . S Y=$$TRIM^XLFSTR(X)
 . I (Y="")!(Y="@") D
 . . W !,"A comment is required when changing the status of an item in suspense, Please"
 . . W !,"try again"
 . . S:Y="@" Y=""
 Q Y
