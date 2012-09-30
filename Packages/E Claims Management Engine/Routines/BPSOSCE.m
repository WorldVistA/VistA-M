BPSOSCE ;BHAM ISC/FCS/DRS/DLF - New entry in 9002313.02 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Create an Electronic Claim Submission record
 ; the BPS array is shared by all of the BPSOSC* routines
 ; BPS is created in BPSOSCA
 ;
 Q
 ;
 ;NEWCLAIM^BPSOSCE called from BPSOSCA from BPSOSQG from BPSOSQ2
 ; create /update an entry in BPS CLAIMS (#9002313.02)
 ; then call the code that populates the entry
 ; START = START Medication Number
 ; END = END Medication Number
 ; TOTAL = TOTAL Medications in Claim
 ; process from BPS("RX",START) through BPS("RX",END)
NEWCLAIM(START,END,TOTAL) ; function, returns null on success, else error
 ;
 N CLAIMID,COUNT,DA,DIC,DIK,DLAYGO,ERROR,INDEX,NODE0,ROU,SEG,X,Y
 S ROU=$T(+0),START=+$G(START),END=+$G(END),TOTAL=+$G(TOTAL)
 ;
 ;Create new record in Claim Submission File (9002313.02)
 ; try for exclusive access for 1 min. before logging error
 F  L +^XTMP(ROU,"NEWCLAIM"):60 Q:$T  D
 .N A S A=$$IMPOSS^BPSOSUE("L","RTI","Single-threaded routine",,,ROU)
 ; Generate Claim ID
 S CLAIMID=$$CLAIMID^BPSECX1($G(BPS("RX",START,"IEN59")))
 I CLAIMID="" D
 .S ERROR="320^VA Claim ID not created"
 .D LOG(ROU_"-Failed to create Claim ID")
 ;
 ; Create claim record
 D:'$G(ERROR)
 .S DLAYGO=9002313.02,DIC="^BPSC(",DIC(0)="LXZ",X=CLAIMID
 .D ^DIC Q:Y>0  ; less than zero is error
 .S ERROR="321^Failed to create claim record"
 .D LOG(ROU_"-Failed to create an entry in file 9002313.02")
 ;
 L -^XTMP(ROU,"NEWCLAIM")
 ;
 Q:$G(ERROR) ERROR
 ;
 ; Update BPS and Log it
 S BPS(9002313.02)=+Y
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG(ROU_"-Created claim ID "_CLAIMID_" (IEN "_BPS(9002313.02)_")")
 ;
 ; Update zero node of the claim
 S NODE0=$G(^BPSC(BPS(9002313.02),0))
 S $P(NODE0,U,2)=$G(BPS("NCPDP","IEN")) ; Electronic Payor (Payer Sheet)
 S $P(NODE0,U,4)=2 ; Transmit Flag - 2 is 'Yes (Point of Sale)'
 S $P(NODE0,U,6)=$$NOWFM^BPSOSU1() ; Created On
 S ^BPSC(BPS(9002313.02),0)=NODE0
 ;
 ; Update Patient Name
 S $P(^BPSC(BPS(9002313.02),1),U,1)=$G(BPS("Patient","Name"))
 S $P(^BPSC(BPS(9002313.02),1),U,4)=$G(BPS("Insurer","IEN"))
 ; Update TRANSACTION field
 S $P(^BPSC(BPS(9002313.02),0),U,8)=$G(BPS("RX",START,"IEN59"))
 ;
 ; Count of meds in claim
 S BPS("Transaction Count")=TOTAL
 ;
 ; Process the 'non-multiple' segments (Header, Patient, Cardholder)
 F SEG=100:10:120 D XLOOP^BPSOSCF(BPS("NCPDP","IEN"),SEG)
 ;
 ; zero node for MEDICATIONS SUB-FIELD (#9002313.0201)
 S:'$D(^BPSC(BPS(9002313.02),400,0)) ^(0)="^9002313.0201PA^^"
 S COUNT=0 F INDEX=START:1:END D
 .; Create zero node for entry in multiple
 .S COUNT=COUNT+1,NODE0=""
 .S $P(NODE0,U)=INDEX,$P(NODE0,U,4)=$G(BPS("RX",INDEX,"Drug Name")),$P(NODE0,U,5)=$G(BPS("RX",INDEX,"RX IEN"))
 .S ^BPSC(BPS(9002313.02),400,INDEX,0)=NODE0
 .S BPS(9002313.0201)=INDEX
 .; Process entries in medication multiple
 .F SEG=130:10:260 D XLOOP^BPSOSCF(BPS("NCPDP","IEN"),SEG,INDEX)
 .; Update the indices
 .S ^BPSC(BPS(9002313.02),400,"B",INDEX,INDEX)=""
 .; Update top-level node of the multiple
 .S NODE0=$G(^BPSC(BPS(9002313.02),400,0))
 .S $P(NODE0,U,3)=COUNT,$P(NODE0,U,4)=COUNT,^BPSC(BPS(9002313.02),400,0)=NODE0
 ;
 ; Cross-Reference Claim Submission Record
 S DIK="^BPSC(",DA=BPS(9002313.02) D IX1^DIK
 ;
 Q ""  ; Return null on success
 ;
LOG(MSG) ;log the message for all the transactions in this 9002313.02 claim
 N I,IEN59
 F I=START:1:END S IEN59=$G(BPS("RX",I,"IEN59")) D:IEN59 LOG^BPSOSL(IEN59,MSG)
 Q
 ;
