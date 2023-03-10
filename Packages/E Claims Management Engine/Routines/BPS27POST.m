BPS27POST ;AITC/PD - Post-install for BPS*1.0*27; 01/15/2020
 ;;1.0;E CLAIMS MGMT ENGINE;**27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; Post-install to add entries to the queue used for
 ; transmitting claims to TAS. Queue = ^BPSTL("C")
 ; Database: BPS LOG OF TRANSACTIONS (#9002313.57)
 ;    Field: MCCF EDI TAS PROGRESS (#20)
 ;
 ; Routine will calculate the starting date to be 10/01
 ; of the current fiscal year.  
 ;
 ;
EN ; Post-install Entry Point
 ;
 D MES^XPDUTL(" Starting post-install of BPS*1.0*27")
 ;
 ; Initialize ^BPSTL("C") index
 I $D(^BPSTL("C")) D INIT
 ; Add entries to ^BPSTL("C")
 D ADD
 ; Add proxy users
 D PROXY
 ;
 D MES^XPDUTL(" Finished post-install of BPS*1.0*27")
 Q
 ;
INIT ; Clear ^BPSTL("C") index
 ;
 N BPS1,BPS57
 ;
 S BPS1=""
 F  S BPS1=$O(^BPSTL("C",BPS1)) Q:'BPS1  D
 . S BPS57=0
 . F  S BPS57=$O(^BPSTL("C",BPS1,BPS57)) Q:'BPS57  D
 . . N BPSA,BPSFN,BPSREC
 . . S BPSFN=9002313.57
 . . S BPSREC=BPS57_","
 . . S BPSA(BPSFN,BPSREC,20)=""
 . . D FILE^DIE("","BPSA","") 
 Q
 ; 
ADD ; Add new entries to ^BPSTL("C")
 ; Using the AH index and the calculated date, add entries
 ; to the queue that are not already in the queue. Set
 ; the value to 1.
 ;
 N BPS57,BPSDATE,COUNT
 ;
 S BPSDATE=3191001
 ;
 D MES^XPDUTL("    - Updating BPS LOG OF TRANSACTIONS")
 S COUNT=0
 ;
 F  S BPSDATE=$O(^BPSTL("AH",BPSDATE)) Q:'BPSDATE  D
 . S BPS57=0
 . F  S BPS57=$O(^BPSTL("AH",BPSDATE,BPS57)) Q:'BPS57  D
 . . ; Don't include entries where SUBMIT DATE is less than 3191001
 . . I $$GET1^DIQ(9002313.57,BPS57,6,"I")<3191001 Q
 . . ; Don't include entries with Field #20 already set
 . . I $$GET1^DIQ(9002313.57,BPS57,20)'="" Q
 . . ; Don't include non-billable transactions
 . . I $$GET1^DIQ(9002313.57,BPS57,19,"I")'="N" D
 . . . N BPSA,BPSFN,BPSREC
 . . . S BPSFN=9002313.57
 . . . S BPSREC=BPS57_","
 . . . S BPSA(BPSFN,BPSREC,20)=1
 . . . D FILE^DIE("","BPSA","") 
 . . . S COUNT=COUNT+1
 ;
 D MES^XPDUTL("      - "_COUNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS LOG OF TRANSACTIONS")
 D MES^XPDUTL(" ")
 ;
 Q
 ;
PROXY ; Add proxy users if they don't already exist
 ;
 I '$O(^VA(200,"B","BPSTAS,APPLICATION PROXY",0)) D
 . N X
 . S X=$$CREATE^XUSAP("BPSTAS,APPLICATION PROXY","","BPS EPHARMACY RPCS")
 ;
 I '$O(^VA(200,"B","IBTAS,APPLICATION PROXY",0)) D
 . N X
 . S X=$$CREATE^XUSAP("IBTAS,APPLICATION PROXY","","IBTAS EBILLING RPCS")
 ;
 Q
 ;
