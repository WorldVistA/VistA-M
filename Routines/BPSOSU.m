BPSOSU ;BHAM ISC/FCS/DRS/FLS - Common utilities ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Common utilities called a lot.
 ;
 ; SETSTAT - set status field for ^BPST(IEN59,
 ; Input:
 ;   IEN59   - BPS Transaction
 ;   STATUS  - Value to set into BPS Transaction
SETSTAT(IEN59,STATUS) ; EP - from many places
 ;
 ; Lock the record - something is very wrong if you can't get the lock
 F  L +^BPST(IEN59):300 Q:$T  Q:'$$IMPOSS^BPSOSUE("L","RTI","LOCK +^BPST",,"SETSTAT",$T(+0))
 N DIE,DA,DR,X
 S DIE=9002313.59,DA=IEN59,DR="1///"_STATUS_";7///NOW" ; Status and Last Update
 I STATUS=0 S DR=DR_";15///NOW" ; If Status is 0, init START TIME
 D ^DIE
 ;
 ; Verify that there no other statuses in the X-ref
 S X=""
 F  S X=$O(^BPST("AD",X)) Q:X=""  D
 . I X'=STATUS K ^BPST("AD",X,IEN59)
 I STATUS=99 D STATUS99(IEN59)
 L -^BPST(IEN59)
 Q
 ;
 ; STATUS99 - Special activity when a claim reaches status 99
 ; Input:
 ;   IEN59 - BPS Transaction IEN
STATUS99(IEN59) ;
 N CLMSTAT,BPS57,BPNXTREQ,BPRQUSED
 N BPSCLNOD,BPTYPE
 ;
 ; Get status of the claim
 S CLMSTAT=$$CATEG^BPSOSUC(IEN59)
 ;
 S BPS57=$$NEW57(IEN59)
 D LOG^BPSOSL(IEN59,$T(+0)_"-Created BPS Log of Transaction record "_BPS57)
 ;
 ;
 ; check if BPS REQUEST is used then see if the next request needs to be activated
 S BPRQUSED=+$P($G(^BPST(IEN59,0)),U,12)
 S BPSCLNOD=$G(^BPS(9002313.77,BPRQUSED,7))
 S BPTYPE=$P($G(^BPS(9002313.77,BPRQUSED,1)),U,4)
 D LOG^BPSOSL(IEN59,$T(+0)_"-Claim of the request "_BPRQUSED_" has reached 99%")
 ;
 S BPNXTREQ=$$REQST99^BPSOSRX5(IEN59,CLMSTAT)
 ;
 I +BPSCLNOD=1,$P(BPSCLNOD,U,2)>0 D
 . N BPSCLA,BPLCK,BPDROP,ERROR,DA,DR,DIE
 . ;if reversal was not accepted
 . I $$SUCCESS^BPSOSRX7(BPTYPE,CLMSTAT)=0 Q
 . I BPNXTREQ>0 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot close after reversal due to sequential requests in the queue") Q
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Closing the claim after accepted reversal")
 . S BPSCLA=$$GET1^DIQ(9002313.59,IEN59,3,"I"),BPLCK=0,BPDROP="N"
 . L +^BPSC(BPSCLA):0 I '$T D  Q
 . . D LOG^BPSOSL(IEN59,$T(+0)_"-Unable to close claim. Could not lock BPS CLAIMS file.") Q
 . D CLOSE^BPSBUTL(BPSCLA,IEN59,$P(^IBE(356.8,$P(BPSCLNOD,U,2),0),U),0,1,$P(BPSCLNOD,U,3),.ERROR)
 . I $D(ERROR) D  Q
 . . D LOG^BPSOSL(IEN59,$T(+0)_"Unable to close Bill in IB. "_ERROR)
 . . L -^BPSC(BPSCLA)
 . S DIE="^BPSC(",DA=BPSCLA,DR="901///1;902///"_$$NOW^XLFDT()_";903////"_DUZ_";904///"_$P(BPSCLNOD,U,2)_";905////"_BPDROP D ^DIE
 . L -^BPSC(BPSCLA)
 . Q
 ;
 ;
 ; If claims completed normally, log its completion.
 ; Do not log error'ed or stranded claims as we don't want to show these in the
 ;   turn-around stats
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 I CLMSTAT'["E OTHER",CLMSTAT'["E UNSTRANDED",CLMSTAT'["E REVERSAL UNSTRANDED" D LOG^BPSOSL(IEN59,$T(+0)_"-Claim Complete")
 Q
 ;
 ; NEW57 - Copy the BPS Transaction into BPS Log of Transaction
 ;  Input
 ;    IEN59 - BPS Transaction
 ;  Returns
 ;    BPS Log of Transaction IEN
NEW57(IEN59) ;
 F  L +^BPSTL:300 Q:$T  Q:'$$IMPOSS^BPSOSUE("L","RTI","LOCK ^BPSTL",,"NEW57",$T(+0))
 ;
 ; Get next record number in BPS Log of Transactions
NEW57A N N,C
 S N=$P(^BPSTL(0),U,3)+1
 S C=$P(^BPSTL(0),U,4)+1
 S $P(^BPSTL(0),U,3,4)=N_U_C
 I $D(^BPSTL(N)) G NEW57A ; should never happen
 L -^BPSTL
 ;
 ; Merge BPS Transaction into Log of Transactions
 M ^BPSTL(N)=^BPST(IEN59)
 ;
 ; Indexing - First, fileman indexing
 D
 . N DIK,DA S DIK="^BPSTL(",DA=N N N D IX1^DIK
 ;
 ; Setup the NON-FILEMAN index on RX and Fill
 N A,B
 S A=$P(^BPSTL(N,1),U,11)
 S B=$P(^BPSTL(N,1),U)
 S ^BPSTL("NON-FILEMAN","RXIRXR",A,B,N)=""
 ;
 ; Quit with the new record number
 Q N
 ;
 ; ISREVES - Is this a reversal claim
 ; Input
 ;   CLAIMIEN - Pointer to BPS Claims
 ;
 ; Return Value
 ;   1 - Reversal claim
 ;   0 - Not a reversal claim
ISREVERS(CLAIM) ;
 Q $P($G(^BPSC(CLAIM,100)),"^",3)="B2"
 ;
 ; SETCSTAT - Set the status for every transaction associated with
 ;   this claim
SETCSTAT(CLAIM,STATUS) ;
 N IEN59,INDEX
 ;
 ; Determine correct index
 I $$ISREVERS(CLAIM) S INDEX="AER"
 E  S INDEX="AE"
 ;
 ; Loop through the transactions and set the status
 S IEN59=""
 F  S IEN59=$O(^BPST(INDEX,CLAIM,IEN59)) Q:IEN59=""  D SETSTAT(IEN59,STATUS)
 Q
 ;
 ; ERROR - Handle any errors
 ;   Log them into BPS Transactions
 ;   Change status to 99
 ;   Update the LOG
 ;   Increment the statistics
 ;   We should be okay for the resubmit flag since the STATUS
 ;     will be E OTHER instead of E REVERSAL ACCEPTED
 ; Input
 ;   RTN     - Routine reporting the error
 ;   IEN59   - BPS Transaction
 ;   ERROR   - Error Number (goes in RESULT CODE)
 ;   ERRTEXT - Error Text (goes in RESULT TEXT)
 ;
 ; To prevent conflicts, set the error number to the first digit of
 ;   Status and a unique number for the status.
ERROR(RTN,IEN59,ERROR,ERRTEXT) ;
 ;
 ; Check parameters
 I '$G(IEN59) Q
 I '$G(ERROR) S ERROR=0
 I $G(ERRTEXT)="" S ERRTEXT="ERROR - see LOG"
 ;
 ; Set Error and Error Text in BPS Transaction
 D SETRESU(IEN59,ERROR,ERRTEXT)
 ;
 ; Log Message
 D LOG^BPSOSL(IEN59,RTN_" returned error - "_ERRTEXT)
 ;
 ; Update unbillable count in stats
 D INCSTAT^BPSOSUD("R",1)
 ;
 ; Update Status to complete
 D SETSTAT(IEN59,99)
 Q
 ;
 ; SETRESU - Set Result into ^BPST(IEN59,2)
 ; Input
 ;   IEN59 - BPS Transaction IEN
 ;   RESULT - Result Code
 ;   TEXT   - Result Text.  Semi-colons (";") should not in the text data as
 ;            this is used as a separator between current and previous text
 ;            messages.  If there is a semi-colon, it is converted to a dash.
SETRESU(IEN59,RESULT,TEXT) ;
 ;
 ; First, store the Result Code
 S $P(^BPST(IEN59,2),U)=$G(RESULT)
 ;
 ; Second, store the Result Text
 ; Considerations:
 ;   Convert any semi-colons to dashes
 ;   Add semi-colon delimiter if needed
 ;   Truncate data if needed
 I $G(TEXT)]"" D
 . N X
 . S TEXT=$TR(TEXT,";","-")
 . S X=$P(^BPST(IEN59,2),U,2,99)
 . I X]"",$E(X)'=";" S X=";"_X
 . S X=$E(TEXT_X,1,255-$L(RESULT)-1)
 . S $P(^BPST(IEN59,2),U,2)=X
 Q
 ;
 ; SETCRESU - set the result code for every transaction assoc'd with
 ;   this claim.  Note that this will only work for billing requests (B1)
 ; Input
 ;   CLAIMIEN - BPS Claim IEN
 ;   RESULT   - Result Code
 ;   TEXT     - Result Text
SETCRESU(CLAIM,RESULT,TEXT) ;
 N IEN59
 S IEN59=""
 F  S IEN59=$O(^BPST("AE",CLAIM,IEN59)) Q:IEN59=""  D SETRESU(IEN59,RESULT,$G(TEXT))
 Q
 ;
 ; STATI(X) gives a text version of what status code X means.
 ;   For effeciency, put more common ones at the top.
 ; Also note that you should check the display on the stats screen if you
 ;   modify any of these.
STATI(X) ;
 I X=99 Q "Done"
 I X=60 Q "Transmitting"
 I X=0 Q "Waiting to start"
 I X=40 Q "Building the HL7 packet"
 I X=70 Q "Parsing response"
 I X=30 Q "Building the claim"
 I X=10 Q "Building the transaction"
 I X=90 Q "Processing response"
 I X=98 Q "Resubmitting" ; Used only by STATUS^BPSOSRX (Not stored in BPS Transactions)
 I X=50 Q "Preparing for transmit"
 I X=31 Q "Wait for retry (insurer asleep)"
 I X=80 Q "Waiting to process response"
 I X=-99 Q "Waiting for activation (scheduled)" ; Used only by STATUS^BPSOSRX (Not stored in BPS Transactions)
 I X=-98 Q "Cancelled" ; Used only by STATUS^BPSOSRX (Not stored in BPS Transactions)
 I X=-97 Q "Inactive" ; Used only by STATUS^BPSOSRX (Not stored in BPS Transactions)
 I X=-96 Q "Processing request" ; Used only by STATUS^BPSOSRX (Not stored in BPS Transactions)
 Q "?"_X_"?"
