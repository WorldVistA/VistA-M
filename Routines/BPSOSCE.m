BPSOSCE ;BHAM ISC/FCS/DRS/DLF - New entry in 9002313.02 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;----------------------------------------------------------------------
 ;Creates an Electronic Claim Submission record
 ;
 ;Parameters:  START     - START Medication Number
 ;             END       - END Medication Number
 ;             TOTAL     - TOTAL Medications in Claim
 ;                       - The BPS(*) array pointed to by START, END
 ;
 ; Note that the BPS array is shared by all of the BPSOSC* routines
 ;----------------------------------------------------------------------
 ; NEWCLAIM^BPSOSCE called from BPSOSCA from BPSOSQG from BPSOSQ2
 ;
 ; This routine is responsible for creating a new entry in the
 ; claims file, and for calling the routines that then populate
 ; that new entry.
 ;
 Q
 ;
NEWCLAIM(START,END,TOTAL) ;EP
 ;
 ;Manage local variables
 N CLAIMID,DIC,DLAYGO,X,Y,COUNT,INDEX,DIK,DA,NODE0,ROU,ERROR,SEG
 S ROU=$T(+0),START=+$G(START),END=+$G(END),TOTAL=+$G(TOTAL)
 ;
 ;Create new record in Claim Submission File (9002313.02)
L L +^TMP($J,"BPSOSCE"):300 I '$T G L:$$IMPOSS^BPSOSUE("L","RTI","Single-threaded routine",,,$T(+0))
 ;
 ; Generate Claim ID
 S CLAIMID=$$CLAIMID^BPSECX1($G(BPS("RX",START,"IEN59")))
 I CLAIMID="" D  Q ERROR
 . S ERROR="320^VA Claim ID not created"
 . D LOG(ROU_"-Failed to create Claim ID")
 ;
 ; Create claim record
 S DLAYGO=9002313.02,DIC="^BPSC(",DIC(0)="LXZ",X=CLAIMID
 D ^DIC S Y=+Y
 L -^TMP($J,"BPSOSCE")
 I Y<1 D  Q ERROR
 . S ERROR="321^Failed to create claim record"
 . D LOG(ROU_"-Failed to create an entry in file 9002313.02")
 ;
 ; Update BPS and Log it
 S BPS(9002313.02)=Y
 ;
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG(ROU_"-Created claim ID "_CLAIMID_" (IEN "_BPS(9002313.02)_")")
 ;
 ; Update the zero node of the claim
 S NODE0=$G(^BPSC(BPS(9002313.02),0))
 S $P(NODE0,U,2)=$G(BPS("NCPDP","IEN")) ; Electronic Payor (Payer Sheet)
 S $P(NODE0,U,4)=2 ; Transmit Flag - 2 is 'Yes (Point of Sale)'
 S $P(NODE0,U,6)=$$NOWFM^BPSOSU1() ; Created On
 S ^BPSC(BPS(9002313.02),0)=NODE0
 ;
 ; Update Patient Name
 S $P(^BPSC(BPS(9002313.02),1),U,1)=$G(BPS("Patient","Name"))
 S $P(^BPSC(BPS(9002313.02),1),U,4)=$G(BPS("Insurer","IEN"))
 ;
 ;update TRANSACTION field
 S $P(^BPSC(BPS(9002313.02),0),U,8)=$G(BPS("RX",START,"IEN59"))
 ;
 ; Only Billing Request call this routine so the transaction code
 ;   is always "B1"
 S BPS("Transaction Code")="B1"
 S BPS("Transaction Count")=TOTAL
 ;
 ; Process the 'non-multiple' segments (Header, Patient, Cardholder)
 F SEG=100:10:120 D XLOOP^BPSOSCF(BPS("NCPDP","IEN"),SEG)
 ;
 ; Create the definition node for the multiple
 S ^BPSC(BPS(9002313.02),400,0)="^9002313.0201PA^^"
 ;
 S COUNT=0
 F INDEX=START:1:END D
 . ;
 . ;Create node zero of the medication multiple
 . S COUNT=COUNT+1
 . S NODE0=""
 . S $P(NODE0,U,1)=INDEX
 . S $P(NODE0,U,4)=$G(BPS("RX",INDEX,"Drug Name"))
 . S $P(NODE0,U,5)=$G(BPS("RX",INDEX,"RX IEN"))
 . S ^BPSC(BPS(9002313.02),400,INDEX,0)=NODE0
 . ;
 . ;
 . I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S INDEX=1 ;LJE
 . S $P(^BPSC(BPS(9002313.02),400,INDEX,400),U,1)=BPS("RX",INDEX,"Date Filled")
 . S BPS(9002313.0201)=INDEX ;07/28/96.
 . ;
 . ; Process multiples in the medication multiple
 . F SEG=130:10:230 D XLOOP^BPSOSCF(BPS("NCPDP","IEN"),SEG,INDEX)
 . ;
 . ; Update the indices
 . S ^BPSC(BPS(9002313.02),400,"B",INDEX,INDEX)=""
 . S NODE0=$G(^BPSC(BPS(9002313.02),400,0))
 . ;
 . ; Update the definition node of the multiple
 . S $P(NODE0,U,4)=COUNT
 . S ^BPSC(BPS(9002313.02),400,0)=NODE0
 . ;
 ;
 ; Cross-Reference Claim Submission Record
 S DIK="^BPSC("
 S DA=BPS(9002313.02)
 D IX1^DIK
 Q ""
 ;
 ; LOG - Write the message to all of transactions that are
 ; being bundled into this 9002313.02 claim
LOG(MSG) ;
 N IEN59,I
 F I=START:1:END D
 . S IEN59=$G(BPS("RX",I,"IEN59"))
 . I IEN59 D LOG^BPSOSL(IEN59,MSG)
 Q
