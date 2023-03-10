BPSRPC01 ;AITC/PD - ECME TAS RPC - Extract Txn IENs;7/30/2018
 ;;1.0;E CLAIMS MGMT ENGINE;**27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RPC2(RESULT,ARGS) ; RPC: BPS TAS TXN IENS NEW
 ;
 ; At the TAS level, a Process Manager will be continually executing.
 ; The Process Manager will execute specific RPCs in each VistA. The
 ; purpose of this RPC is to transmit BPS Log of Transaction IENs to be
 ; stored in the WorkQueue on TAS.  Another RPC will process the IENs
 ; from the WorkQueue, transmitting the data to be used by Power BI to TAS.
 ;
 ; RESULT - Output - JSON formatted array of transaction IENs
 ;
 N BPS57,BPSCNT,BPSCOUNT,BPSFLAG,BPSTMP,BPSTMP1
 ;
 S BPSTMP="^TMP($J,""BPSRPC2"",""IENS"")"
 S BPSTMP1="^TMP($J,""BPSRPC2"")"
 K @BPSTMP1
 S RESULT=$NA(^TMP("JSON",$J)) K @RESULT
 ;
 ; Create log if requested
 I $G(ARGS("LOG")) D LOG^BPSRPC02("ARGS")
 S BPSCOUNT=$G(ARGS("COUNT"))
 I BPSCOUNT="" S BPSCOUNT=2500
 ;
 S BPSCNT=0
 ;
 ; Loop through Claims identified as needing to be transmitted to TAS
 ;
 ; Loop through BPS LOG OF TRANSACTIONS file - "C" index
 ; Loop through entries with flag set as 2 first to pick up entries
 ; that previously transmitted but didn't receive a successful writeback
 ; indicator.
 ;
 F BPSFLAG=2,1 D
 . S BPS57=""
 . F  S BPS57=$O(^BPSTL("C",BPSFLAG,BPS57),-1) Q:'BPS57!(BPSCNT>(BPSCOUNT-1))  D
 . . I $D(@BPSTMP@("B",BPS57)) Q
 . . S BPSCNT=$G(BPSCNT)+1
 . . S @BPSTMP@(BPSCNT,"TxnIEN")=BPS57
 . . S @BPSTMP@("B",BPS57)=""
 . . ;
 . . I BPSFLAG=2 Q
 . . ; Update MCCF EDI TAS Progress flag to be 2
 . . ; 2 = SENT
 . . N BPSA,BPSFN,BPSREC
 . . S BPSFN=9002313.57
 . . S BPSREC=BPS57_","
 . . S BPSA(BPSFN,BPSREC,20)=2
 . . D FILE^DIE("","BPSA","") 
 ;
 ; No Txns Found - Set ^TMP array to show nothing found before calling
 ; ENCODE logic.
 I BPSCNT=0 S @BPSTMP@(1,"TxnIEN")=""
 ;
 ; Remove "B" index before creating JSON file
 K @BPSTMP@("B")
 ;
 ; Encode ^TMP array data into JSON formatted array (RESULT)
 D ENCODE^XLFJSON(BPSTMP1,RESULT)
 S @RESULT@(1)="["_@RESULT@(1)
 S LAST=$O(@RESULT@(""),-1)
 S @RESULT@(LAST)=@RESULT@(LAST)_"]"
 ;
 K @BPSTMP1
 ;
 Q
