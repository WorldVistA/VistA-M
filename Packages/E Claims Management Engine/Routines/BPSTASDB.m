BPSTASDB ;AITC/PD - ECME TAS BPSTL Utility; 12/16/2019
 ;;1.0;E CLAIMS MGMT ENGINE;**27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; RPC to reset or add entries to the queue used for
 ; transmitting claims to TAS. Queue = ^BPSTL("C")
 ; Database: BPS LOG OF TRANSACTIONS (#9002313.57)
 ;    Field: MCCF EDI TAS PROGRESS (#20)
 ; 
 ; Inputs: FLAG (Required)
 ;            1 = Reset Existing Entries to 1
 ;            2 = Add New Entries
 ;         DATE (optional)
 ;            Date to be used if input parameter FLAG = 2 (ADD)
 ;            Starting date for adding new entries to the queue
 ;
EN(RESULT,ARGS) ; RPC Entry Point
 ;
 N BPSDATE,BPSFLAG,COUNT
 K RESULT
 ;
 S BPSFLAG=$G(ARGS("FLAG"))
 I BPSFLAG="" S COUNT=-1 G RESULT
 I (BPSFLAG'=1)&(BPSFLAG'=2) S COUNT=-3 G RESULT
 S BPSDATE=$G(ARGS("DATE"))
 I BPSFLAG=2,$G(BPSDATE)="" S COUNT=-1 G RESULT
 ;
 S COUNT=0
 I BPSFLAG=1 D RESET
 I BPSFLAG=2 D ADD(BPSDATE)
 ;
RESULT ; setup JSON result
 ; Result will return variable COUNT
 ; COUNT = # of records reset or added
 ; COUNT = -1 indicates an input parameter was missing
 ; COUNT = -2 indicates the date passed in for ADD was invalid
 ; COUNT = -3 indicates input FLAG was not 1 or 2
 S RESULT(1)="[{"_"""updates"""_":"_COUNT_"}]"
 ;
 Q
 ;
RESET ; Reset existing entries in ^BPSTL("C") to 1
 ; Only entries that currently have a defined value for field #20
 ; will be reset.  Value will be reset to 1 (READY TO SEND (OPEN))
 ;
 N BPS57,BPSINDX
 ;
 S BPSINDX=1
 F  S BPSINDX=$O(^BPSTL("C",BPSINDX)) Q:'BPSINDX  D
 . S BPS57=0
 . F  S BPS57=$O(^BPSTL("C",BPSINDX,BPS57)) Q:'BPS57  D
 . . N BPSA,BPSFN,BPSREC
 . . S BPSFN=9002313.57
 . . S BPSREC=BPS57_","
 . . S BPSA(BPSFN,BPSREC,20)=1
 . . D FILE^DIE("","BPSA","")
 . . S COUNT=COUNT+1
 Q
 ;
ADD(BPSDATE) ; Add new entries to ^BPSTL("C")
 ; Using the AH index and the date passed in, add entries
 ; to the queue that are not already in the queue. Set
 ; the value to 1.
 ;
 N BPS57
 ;
 S BPSDATE=$$DATE(BPSDATE)
 I BPSDATE=-1 S COUNT=-2 Q
 ;
 F  S BPSDATE=$O(^BPSTL("AH",BPSDATE)) Q:'BPSDATE  D
 . S BPS57=0
 . F  S BPS57=$O(^BPSTL("AH",BPSDATE,BPS57)) Q:'BPS57  D
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
 Q
 ;
DATE(X) ; Convert Date to FileMan format
 ;
 N %DT,Y
 D ^%DT
 Q Y
 ;
