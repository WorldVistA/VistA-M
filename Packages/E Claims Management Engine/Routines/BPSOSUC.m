BPSOSUC ;BHAM ISC/FCS/DRS/FLS - ECME utilities ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10,11,14,20,27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; CATEG returns the status of a Transaction or Log of Transaction
 ;   entry.  It is used mainly by STATUS^BPSOSRX but is also
 ;   called by some other routines as well as computed fields of BPS Log
 ;   of Transactions and BPS Tranasctions
CATEG(N,WANTREV) ;
 ; N - If decimal, IEN from BPS Transaction
 ;   - If integer, IEN from BPS Log of Transactions
 ; $G(WANTREV) = true if you care about reversals
 ;      (that's the default if lookup is on IEN59)
 ; $G(WANTREV) = false if you want to ignore reversals
 ;      (that's the default if lookup is on IEN57)
 ;
 ; Many routines rely on these exact return values; do not change them:
 ; Return values:
 ;     For all submissions:
 ;       CORRUPT - Should never happen
 ;
 ;     For Billing Requests:
 ;       E PAYABLE, E CAPTURED, E DUPLICATE, E REJECTED, E OTHER, and
 ;       E UNSTRANDED
 ;
 ;     For Reversals:
 ;       E REVERSAL ACCEPTED, E REVERSAL REJECTED, E REVERSAL OTHER, and
 ;       E REVERSAL UNSTRANDED
 ;
 ;     For Eligibility:
 ;       E ELIGIBILITY ACCEPTED, E ELIGIBILITY REJECTED, E ELIGIBILITY OTHER, and
 ;       E ELIGIBILITY UNSTRANDED
 ;
 ;     For Non-Billable Entries:
 ;       ""
 ;
 I N<1 Q "" ; Should not happen
 N FILENUM,RETVAL,CLAIM,RESP,X,RESP500,TRANTYPE,STAT,DISYS
 S FILENUM=$S(N[".":9002313.59,1:9002313.57)
 I '$D(WANTREV) S WANTREV=$S(FILENUM=9002313.57:0,FILENUM=9002313.59:1)
 I '$$GET1^DIQ(FILENUM,N_",",.01) Q "CORRUPT"
 S CLAIM=$$GET1^DIQ(FILENUM,N_",",3,"I")
 S RESP=$$GET1^DIQ(FILENUM,N_",",4,"I")
 S TRANTYPE=$$GET1^DIQ(FILENUM,N_",",19,"I")
 ;
 I TRANTYPE="N" Q ""    ; BPS*1*20.  quit with "" for TRI/CVA non-billable entries
 ;
 S STAT=$$GET1^DIQ(FILENUM,N_",",202,"I")
 ; Stranded statuses
 I $P(STAT,";")="E REVERSAL UNSTRANDED" Q "E REVERSAL UNSTRANDED"
 I $P(STAT,";")="E UNSTRANDED" Q "E UNSTRANDED"
 I $P(STAT,";")="E ELIGIBILITY UNSTRANDED" Q "E ELIGIBILITY UNSTRANDED"
 ; Eligibility Statuses
 I TRANTYPE="E" D  Q RETVAL
 . I 'CLAIM!'RESP S RETVAL="E ELIGIBILITY OTHER" Q
 . S RESP500=$$RESP500^BPSOSQ4(RESP,"I")
 . S X=$$RESP1000^BPSOSQ4(RESP,1,"I")
 . S RETVAL="E ELIGIBILITY "
 . I RESP500="R"!(X="R") S RETVAL=RETVAL_"REJECTED" Q
 . I RESP500="A",X="A" S RETVAL=RETVAL_"ACCEPTED" Q
 . S RETVAL=RETVAL_"OTHER"
 ; During a reversal/resubmit, you may get the next line between the reversal and
 ;   and the resubmit
 I 'CLAIM S RETVAL="E OTHER" Q RETVAL
 I WANTREV,TRANTYPE="U" D  Q RETVAL
 . S RESP=$$GET1^DIQ(FILENUM,N_",",402,"I")
 . S RETVAL="E REVERSAL "
 . I 'RESP S RETVAL=RETVAL_"OTHER" Q
 . S RESP500=$$RESP500^BPSOSQ4(RESP,"I")
 . S X=$$RESP1000^BPSOSQ4(RESP,1,"I")
 . I RESP500="R"!(X="R") S RETVAL=RETVAL_"REJECTED" Q
 . ; Treat Duplicate of Accepted Reversal ("S") as Accepted
 . I RESP500="A",X="A"!(X="S") S RETVAL=RETVAL_"ACCEPTED" Q
 . S RETVAL=RETVAL_"OTHER"
 ; Response not received yet
 I 'RESP S RETVAL="E OTHER" Q RETVAL
 S RESP500=$$RESP500^BPSOSQ4(RESP,"I")
 N POS S POS=$$GET1^DIQ(FILENUM,N_",",14)
 ;if POS comes back null set equal to 1 - BPS*14 ticket 367742 RRA
 S:'POS POS=1
 S X=$$RESP1000^BPSOSQ4(RESP,POS,"I")
 I X="P"!(X="DP") Q "E PAYABLE"
 I X="D"!(X="S")!(X="Q") Q "E DUPLICATE"
 I X="R" Q "E REJECTED"
 I X="C"!(X="DC") Q "E CAPTURED"
 ; 1000 indefinite, fall back to 500
 I RESP500="R" Q "E REJECTED"
 Q "E OTHER" ; corrupt?
