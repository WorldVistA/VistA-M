BPSRPC03 ;AITC/PD - ECME TAS RPC - Write Back;02/08/2019
 ;;1.0;E CLAIMS MGMT ENGINE;**27,34**;JUN 2004;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PUT(RESULT,ARGS) ; RPC: BPS TAS CLAIM WRITE BACK
 ; Update BPSTL entry successfully written to TAS
 ;
 ; Required Input: BPS57 - IEN for BPS LOG OF TRANSACTIONS FILE (#9002313.57)
 ;                 BPS57 = ARGS("IEN")
 ;
 ; Once a transaction has successfully be written to the TAS database,
 ; the record id is returned to VistA to update the MCCF EDI TAS PROGRESS
 ; field in BPS LOG OF TRANSACTIONS file.
 ;
 ; MCCF EDI TAS PROGRESS Values:
 ;  '1' FOR READY TO SEND
 ;  '2' FOR SENT
 ;  '3' FOR WRITTEN
 ;
 N BPS57,BPSFLAG,BPSPC,BPSRES,BPSVALUE
 K RESULT
 ;
 ; BPSRES indicates if the Write Back is successful or not.
 ; 0=Unsuccessful 1=Successful
 S BPSRES=0
 S BPS57=ARGS("IEN")
 ;
 ; If no Txn IEN was passed in or a Txn IEN that doesn't
 ; exist in the ^BPSTL file, exit RPC with the RESULT
 ; JSON indicating Unsuccessful
 I BPS57="" G RESULT
 I '$D(^BPSTL(BPS57)) G RESULT
 ;
 ; --------------------------------------------------------
 ;
 ; Initialize fields
 ;
 ; CLAIM - Field 3 - Pointer to BPS CLAIMS FILE #9002313.02
 S BPSPC=$$GET1^DIQ(9002313.57,BPS57,3,"I")
 ;
 ; MCCF EDI TAS PROGRESS - Field 20
 S BPSFLAG=$$GET1^DIQ(9002313.57,BPS57,20,"I")
 ;
 ; --------------------------------------------------------
 ;
 ; The only Txn IENs that should be receiving a write back
 ; are ones that previously had the MCCF EDI TAS PROGRESS
 ; flag set with the value 2, meaning "SENT".
 I BPSFLAG'=2 G RESULT
 ;
 ; --------------------------------------------------------
 ;
 ; Update MCCF EDI TAS PROGRESS flag to 3, indicating the record
 ; was successfully transmitted to TAS.
 ;
 N BPSA,BPSFN,BPSREC
 S BPSFN=9002313.57
 S BPSREC=BPS57_","
 S BPSA(BPSFN,BPSREC,20)=3
 D FILE^DIE("","BPSA","")
 ;
 S BPSRES=1
 ;
RESULT ; setup JSON result
 ;
 S RESULT(1)="[{"_"""ien"""_":"_BPS57_","_"""status"""_":"_BPSRES_"}]"
 ;
 ; On rare occasions, the MCCF EDI TAS PROGRESS index gets an extra entry.
 ; e.g.:
 ; ^BPSTL("C",1,IEN)=""
 ; ^BPSTL("C",3,IEN)=""
 ;
 ; When this happens, TAS attempts to transmit the transaction over and over.
 ; The following code checks if the IEN is in the 3 index and also in the 1 or 2 index.
 ; If so, the MCCF EDI TAS PROGRESS field is reset to 1.  This forces the
 ; transaction to be succesfully transmitted, allowing the index issue to be resolved.
 ;
 I $D(^BPSTL("C",3,BPS57))&(($D(^BPSTL("C",1,BPS57))!($D(^BPSTL("C",2,BPS57))))) D
 . N BPSA,BPSFN,BPSREC
 . S BPSFN=9002313.57
 . S BPSREC=BPS57_","
 . S BPSA(BPSFN,BPSREC,20)=1
 . D FILE^DIE("","BPSA","")
 ;
 Q
 ;
 ; ========================================================
 ;
CLOSE(BPS02) ; Entry point when a claim is closed
 ;
 ; Changes to BPS Claims File (9002313.02) field 901 (CLOSED)
 ; will trigger this code to execute. This code will loop
 ; through associated BPS LOG OF TRANSACTIONS entries and
 ; update field 20 (MCCF EDI TAS PROGRESS). Field 20 only
 ; needs to be updated if the transaction was previously
 ; successfully transmitted to TAS. This is indicated by 
 ; a value of 3.
 ;
 I BPS02="" Q
 ;
 ; Get IEN for associated BPS TRANSACTION file (#9002313.59)
 S BPS59=$$GET1^DIQ(9002313.02,BPS02,.08,"I")
 I BPS59="" Q
 ;
 ; Loop through BPS LOG OF TRANSACTIONS file (#9002313.57)
 ; using the IEN from #9002313.59.
 S BPS57=0
 F  S BPS57=$O(^BPSTL("B",BPS59,BPS57)) Q:'BPS57  D
 . S BPSFLAG=$$GET1^DIQ(9002313.57,BPS57,20,"I")
 . ;
 . ; QUIT if MCCF EDI TAS PROGRESS field does not exist
 . I BPSFLAG="" Q
 . ;
 . ; QUIT if MCCF EDI TAS PROGRESS field is not 3.
 . I BPSFLAG'=3 Q
 . ;
 . ; Setting field 20 to 1 will place the IEN back in the
 . ; queue to be transmitted to TAS again.
 . N BPSA,BPSFN,BPSREC
 . S BPSFN=9002313.57
 . S BPSREC=BPS57_","
 . S BPSA(BPSFN,BPSREC,20)=1
 . D FILE^DIE("","BPSA","")
 ;
 Q
