IB20P533 ;ALB/RRA - UPDATE IIV TRANSMISSION QUEUE ; 11/5/14 9:28am
 ;;2.0;INTEGRATED BILLING;**533**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
PRE ;  
 ; Update IIV TRANSMISSION QUEUE file (#365.1)
 D MES^XPDUTL("Starting IB*2*533 Pre-Install....")
 D UPDATE
 D MES^XPDUTL("Patch Pre-Install is complete.")
 Q
 ;
UPDATE ; 
 N IBCN0,IBINS,IBWE,IBCNO,IBSD,IBCNT,IBNOW,IBX,IBQF
 S IBX=0,IBCNT=0
 ;LOOP THROUGH TRANSMISSION STATUS TO FIND RECORDS "READY TO TRASMIT"
 D MES^XPDUTL(""),MES^XPDUTL(">>>Processing records.....""")
 F  S IBX=$O(^IBCN(365.1,"AC",1,IBX)) Q:IBX=""  D
 . S IBCN0=$G(^IBCN(365.1,IBX,0)),IBQF=$P($G(IBCN0),"^",11)
 . I IBQF="I" D FILE Q
 . S IBINS=$P($G(IBCN0),"^",13),IBWE=$P($G(IBCN0),"^",10),IBSD=$P($G(IBCN0),"^",12),IBNOW=$$NOW^XLFDT
 . ;QUIT UNLESS THE EXTRACT IS FOR APPOINTMENT (2)
 . Q:IBWE'=2
 . ;QUIT UNLESS THE SERVICE DATE IS IN PAST
 . Q:IBSD>IBNOW
 . ;THE REMAINING RECORDS NEED TO BE CANCELLED AND UPDATED WITH A STATUS DATE OF "NOW" 
 . D FILE Q
 ;process "Hold" records with query flag = Identification
 S IBX=0
 F  S IBX=$O(^IBCN(365.1,"AC",4,IBX)) Q:IBX=""  D
 . I $P($G(^IBCN(365.1,IBX,0)),"^",11)="I" D FILE
 . Q
 ;process "Retry" records with query flag = Identification
 S IBX=0
 F  S IBX=$O(^IBCN(365.1,"AC",6,IBX)) Q:IBX=""  D
 . I $P($G(^IBCN(365.1,IBX,0)),"^",11)="I" D FILE
 . Q
 ;
 D MES^XPDUTL("Total of "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the IIV TRANSMISSION QUEUE file (#365.1)")
 D MES^XPDUTL("")
 Q
 ;FILE UPDATE
FILE ;
 N DA,DIE,DR,X,Y
 S IBNOW=$$NOW^XLFDT
 S DIE="^IBCN(365.1,",DA=IBX,DR=".04///"_"Cancelled"_";.15///"_IBNOW D ^DIE
 S IBCNT=IBCNT+1
 Q
