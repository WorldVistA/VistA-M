IBCNEKI2 ;DAOU/BHS - PURGE eIV DATA FILES CONT'D ;11-JUL-2002
 ;;2.0;INTEGRATED BILLING;**271,316,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine holds additional procedures for purging the eIV data
 ; from the Trans Queue file (365.1) and the Response file (365).
 ;
 ; ---------------------------------------------------
MMPURGE ; This procedure is responsible for the creation and
 ; sending of the MailMan message on the first day of the month
 ; if the site has data eligible to be purged and if the mail group is
 ; defined appropriately in the eIV site parameters.
 ;
 ; Identify records eligible to be purged
 NEW ENDDT,STATLIST,DATE,TQIEN,TOTTQ,PURTQ,TQS
 NEW HLIEN,RPIEN,RPS,TOTRP,PURRP,MSG,MGRP
 ;
 ; default end date, Today minus 182 days (approx 6 months)
 S ENDDT=$$FMADD^XLFDT(DT,-182)
 S (TOTTQ,PURTQ,TOTRP,PURRP)=0
 ;
 ; This is the list of statuses that are OK to purge
 ;   3=Response Received
 ;   5=Communication Failure
 ;   7=Cancelled
 S STATLIST=",3,5,7,"
 ;
 S DATE=""
 F  S DATE=$O(^IBCN(365.1,"AE",DATE)) Q:'DATE  S TQIEN=0 F  S TQIEN=$O(^IBCN(365.1,"AE",DATE,TQIEN)) Q:'TQIEN  S TOTTQ=TOTTQ+1 I $P(DATE,".")'>ENDDT D
 . S TQS=$P($G(^IBCN(365.1,TQIEN,0)),U,4)    ; status
 . I '$F(STATLIST,","_TQS_",") Q
 . S PURTQ=PURTQ+1
 . ; Loop thru responses to count them, too
 . S HLIEN=0
 . F  S HLIEN=$O(^IBCN(365.1,TQIEN,2,HLIEN)) Q:'HLIEN  D
 . .  I $P($G(^IBCN(365.1,TQIEN,2,HLIEN,0)),U,3) S PURRP=PURRP+1
 ;
 S DATE=""
 F  S DATE=$O(^IBCN(365,"AE",DATE)) Q:'DATE  S RPIEN=0 F  S RPIEN=$O(^IBCN(365,"AE",DATE,RPIEN)) Q:'RPIEN  S TOTRP=TOTRP+1 I $P(DATE,".")'>ENDDT D
 . I $P($G(^IBCN(365,RPIEN,0)),U,5) Q    ; include only unsolicited
 . S PURRP=PURRP+1
 ;
 ; Do not send message if no records are eligible
 I 'PURTQ,'PURRP G MMPURGX
 ;
 ; Send a MailMan message with Eligible Purge counts
 S MSG(1)="ATTENTION IRM:  There are eIV TRANSMISSION QUEUE and"
 S MSG(2)="eIV RESPONSE records eligible to be purged."
 S MSG(3)=""
 S MSG(4)="File                                  Eligible   Total  "
 S MSG(5)="                                       Count     Count  "
 S MSG(6)="------------------------------------  --------  --------"
 S MSG(7)="eIV RESPONSE FILE (#365)              "_$J(PURRP,8)_"  "_$J(TOTRP,8)
 S MSG(8)="eIV TRANSMISSION QUEUE FILE (#365.1)  "_$J(PURTQ,8)_"  "_$J(TOTTQ,8)
 S MSG(9)="====================================  ========  ========"
 S MSG(10)="Total                                 "_$J(PURTQ+PURRP,8)_"  "_$J(TOTTQ+TOTRP,8)
 S MSG(11)=""
 S MSG(12)="Please run option IBCNE PURGE IIV DATA - Purge eIV Transactions,"
 S MSG(13)="if you would like to purge the eligible records."
 ; Set to IB site parameter MAILGROUP
 S MGRP=$$MGRP^IBCNEUT5()
 D MSG^IBCNEUT5(MGRP,"eIV Data Eligible for Purge","MSG(")
 ;
MMPURGX ;
 Q
 ;
