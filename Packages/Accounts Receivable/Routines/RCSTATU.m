RCSTATU ;EDE/YMG - AR PERFORMACE METRICS UTILITIES;02/03/2021  8:40 AM
 ;;4.5;Accounts Receivable;**378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
UPDMET(RCFIELD,RCVALUE) ; Update the AR Metrics file.
 ;INPUT:  RCFIELD = The field # in the AR Metrics File to Update
 ;        RCVALUE = Amount to add to the data already in the field
 ;
 N RCSTIEN,RCDATE,RCCURAMT,RCNEWAMT,Y,DLAYGO,DIC,DIK,DR,DA,X
 ;
 ;Lock the AR Metrics file until daily entry is confirmed to exist or is created.
 L +^RCSTAT(340.7):5
 S RCDATE=$$DT^XLFDT
 S RCSTIEN=$O(^RCSTAT(340.7,"B",RCDATE,""))
 S DLAYGO=340.7,DIC="^RCSTAT(340.7,",DIC(0)="L",X=RCDATE
 ;
 ;Create new entry if necessary
 I 'RCSTIEN D
 .  D FILE^DICN
 .  S RCSTIEN=+Y
 .  K DIC,DINUM,DLAYGO
 .  ;Ensure it is indexed
 .  S DA=RCSTIEN,DIK="^RCSTAT(340.7,"
 .  D IX^DIK
 .  K DR
 ;Unlock the file
 L -^RCSTAT(340.7):5
 ;
 ; File the update along with inactivate the ACTION TYPE
 S RCCURAMT=$$GET1^DIQ(340.7,RCSTIEN_",",RCFIELD,"I")
 S RCNEWAMT=RCCURAMT+RCVALUE
 S DR=RCFIELD_"///"_RCNEWAMT   ;Update the amount
 ;
 S DIE="^RCSTAT(340.7,",DA=RCSTIEN
 D ^DIE
 ;
 Q
 ;
CSALERT(RCBILLDA,RCIEN) ;Send a bulletin to alert staff if a Debtor has a bill sent to Cross Servicing if they also have an active Repayment Plan.
 ;
 ;INPUT: RCBILLDA - AR Bill IEN for file 430
 ;       RCIEN    - Repayment Plan IEN for fiel 340.5
 ;
 N %,RCBILL,XMY,RCRPID
 K ^TMP($J,"RCRPPALERT")   ; used to store message to send
 ;
 S LINE=0
 S RCBILL=$$GET1^DIQ(430,RCBILLDA_",",.01,"E")
 S RCRPID=$$GET1^DIQ(340.5,RCIEN_",",.01,"E")
 D SET("Bill "_RCBILL_" was referred to the Treasury Cross Servicing (CS) Referral")
 D SET("Program when it should have been added to the Debtor's Active Repayment Plan,")
 D SET(RCRPID_".")
 D SET("")
 D SET("Please investigate and recall from CS if necessary.")
 ;
 S XMY("G.RC REPAY PLAN EXTERNAL")=""
 S %=$$SENDMSG("ALERT: Bill sent to Cross Servicing for Debtor with Repayment Plan",.XMY)
 K ^TMP($J,"RCRPPALERT")   ; used to store message to send
 Q
 ;
 ;
SET(DATA)          ;  store report
 S LINE=LINE+1,^TMP($J,"RCRPPALERT",LINE)=DATA
 Q
 ;
 ;
SENDMSG(XMSUB,XMY) ;  send message with subject and recipients
 N %X,D0,D1,D2,DIC,DICR,DIW,X,XCNP,XMDISPI,XMDUN,XMDUZ,XMTEXT,XMZ,ZTPAR
 S XMDUZ="AR PACKAGE",XMTEXT="^TMP($J,""RCRPPALERT"","
 D ^XMD
 Q +$G(XMZ)
 ;
CLEANUP ; Remove entries from the AR Metrics File that are older than the METRICS RETENTION DAYS paramenter (#.16, file 342) allows.
 ;
 N RCSITE,RCNUMDAY,DIK,DA,RCI,RCDT,RCMAXDT,RCNUMDY
 ;
 ;Get the oldest date to keep.
 S RCNUMDY=$$GET1^DIQ(342,"1,",.16,"I")   ;METRICS RETENTION DAYS PARAMETER
 S RCMAXDT=$$FMADD^XLFDT($$DT^XLFDT,-RCNUMDY)
 ;Loop through all of the entry older than RCMAXDT and delete
 S RCI=0
 F  S RCI=$O(^RCSTAT(340.7,RCI)) Q:'RCI  D
 . S RCDT=$G(^RCSTAT(340.7,RCI,0))
 . Q:RCDT'<RCMAXDT
 . S DIK="^RCSTAT(340.7,",DA=RCI
 . D ^DIK
 . K DIK,DA
 ;
 Q
