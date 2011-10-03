BPSECX0 ;BHAM ISC/FCS/DRS/VA/DLF - Retrieve Claim submission record ;05/17/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;----------------------------------------------------------------------
 ;Retrieve Claim submission record
 ;
 ;Input Variables:   CLAIMIEN -  Claim Submission IEN (9002313.02)
 ;                   .BPS     -  Pass by reference, output only
 ;
 ;Output Variables:  BPS(9002313.02,CLAIMIEN,<field #>,"I")  = Value
 ;----------------------------------------------------------------------
 ; IHS/SD/lwj  08/13/02  NCPDP 5.1 changes
 ; Many fields that were once a part of the "header" of the claim
 ; were shifted to appear on the "rx" or "detail" segments of the
 ; claim in 5.1. Additionally, MANY new fields were added beyond 499. 
 ; For these reasons, we had to change the GETBPS3
 ; subroutine to pull fields 308 through 600 rather than just 
 ; 402 - 499. The really cool thing is that because we are at the
 ; subfile level, the duplicated fields (between header and rx)
 ; will only pull at the appropriate level.  3.2 claims should
 ; be unaffected by this change, as the adjusted and new fields
 ; were not populated for 3.2
 ;
 ; New subroutine added GETBPS4 to pull out the repeating fields for
 ; the DUR/PPS records
 ;----------------------------------------------------------------------
 ; 
GETBPS2(CLAIMIEN,BPS) ;EP - from BPSECA1 from BPSOSQG from BPSOSQ2
 ;Manage local variables
 N DIC,DR,DA,DIQ,D0,DIQ2
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 ;
 ;Set input variables for FileMan data retrieval routine
 ;IHS/SD/lwj 9/9/02  need to expand the field range to include
 ; the "500" range fields now used in the header segments
 ; for NCPDP 5.1
 ;
 S DIC=9002313.02
 ; IHS/SD/lwj 9/9/02 NCPDP 5.1 changes
 S DR="101:600"
 S DA=CLAIMIEN
 S DIQ="BPS",DIQ(0)="I"
 ;
 ;Execute data retrieval routine
 D EN^DIQ1
 Q
 ;----------------------------------------------------------------------
 ;Retrieve Claim Submission, Prescription(s) multiple record
 ;
 ;Input Variables:   CLAIMIEN - Claim Submission IEN (9002313.02)
 ;                   CRXIEN   - Prescription Multiple IEN (9002313.0201)
 ;
 ;Output Variables:  BPS(9002313.0201,CRXIEN,<field #>,"I") = Value
 ;----------------------------------------------------------------------
GETBPS3(CLAIMIEN,CRXIEN,BPS) ;EP - from BPSECA1
 ;Manage local variables
 N DIC,DR,DA,DIQ,D0,DIQ2
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(CRXIEN)=""
 ;
 ;S input variables for FileMan data retrieval routine
 S DIC=9002313.02
 ;
 S DR="400",DR(9002313.0201)="308:600"  ;need new RX fields
 ;IHS/SD/lwj 8/13/02 end changes
 S DA=CLAIMIEN,DA(9002313.0201)=CRXIEN
 S DIQ="BPS",DIQ(0)="I"
 ;
 ;Execute data retrieval routine
 D EN^DIQ1
 Q
 ;----------------------------------------------------------------------
 ;Retrieve Claim Submission, Prescription(s) multiple, DUR/PPS multiple 
 ; record
 ;
 ;Input Variables:   CLAIMIEN - Claim Submission IEN (9002313.02)
 ;                   CRXIEN   - Prescription Multiple IEN (9002313.0201)
 ;                   CDURIEN  - DUR/PPS Multiple IEN (9002313.1001)
 ;
 ;Output Variables:  BPS(9002313.1001,CDURIEN,<field #>,"I") = Value
 ;----------------------------------------------------------------------
GETBPS4(CLAIMIEN,CRXIEN,CDURIEN,BPS) ;EP - from BPSECA1
 ;
 ;Manage local variables
 N DIC,DR,DA,DIQ,D0,DIQ2
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(CRXIEN)=""
 Q:$G(CDURIEN)=""
 ;
 ;S input variables for FileMan data retrieval routine
 S DIC=9002313.02
 ;
 S DR="400",DR(9002313.0201)=473.01  ;fields
 S DR(9002313.1001)=".01;439;440;441;474;475;476"  ;fields
 S DA=CLAIMIEN,DA(9002313.0201)=CRXIEN,DA(9002313.1001)=CDURIEN
 S DIQ="BPS",DIQ(0)="I"
 ;
 ;Execute data retrieval routine
 D EN^DIQ1
 ;
 Q
 ;----------------------------------------------------------------------
 ;Retrieve Claim Submission, Prescription(s) multiple, COB OTHER PAYMENTS 
 ; multiple record
 ;
 ;Input Variables:   CLAIMIEN - Claim Submission IEN (9002313.02)
 ;                   CRXIEN   - Prescription Multiple IEN (9002313.0201)
 ;                   BPCOBIEN  - COB OTHER PAYMENTS Multiple IEN (9002313.0401)
 ;
 ;Output Variables:  BPS(9002313.0401,BPCOBIEN,<field #>,"I") = Value
 ;----------------------------------------------------------------------
GETBPS5(CLAIMIEN,CRXIEN,BPCOBIEN,BPS) ;EP - from BPSECA1
 ;
 ;Manage local variables
 N DIC,DR,DA,DIQ,D0,DIQ2,BPSPAMT,BPREJCT,BPSCNT
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(CRXIEN)=""
 Q:$G(BPCOBIEN)=""
 ;
 ;S input variables for FileMan data retrieval routine
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=CRXIEN
 S DA(9002313.0401)=BPCOBIEN
 ;
 S DR="400" ;field (#400) MEDICATIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=".01;338;339;340;341;443;471"  ;fields
 S DIQ="BPS",DIQ(0)="I"
 ;
 ;Execute data retrieval routine
 D EN^DIQ1
 ;
 ; Loop through PAYER AMT and get the data
 S BPSPAMT=$P($G(^BPSC(CLAIMIEN,400,CRXIEN,337,BPCOBIEN,1,0)),U,4)
 F BPSCNT=1:1:BPSPAMT  D
 . D GETBPS6^BPSECX0(CLAIMIEN,CRXIEN,BPCOBIEN,BPSCNT,.BPS)
 ;
 ; Loop through OTHER PAYER REJECT CODE multiple and get the data
 S BPREJCT=$P($G(^BPSC(CLAIMIEN,400,CRXIEN,337,BPCOBIEN,2,0)),U,4)
 F BPSCNT=1:1:BPREJCT  D
 . D GETBPS7^BPSECX0(CLAIMIEN,CRXIEN,BPCOBIEN,BPSCNT,.BPS)
 ;
 Q
 ;
GETBPS6(CLAIMIEN,CRXIEN,BPCOBIEN,BPPAYAMT,BPS) ;EP - from GETBPS5
 ;
 ;Manage local variables
 N DIC,DR,DA,DIQ,D0,DIQ2
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(CRXIEN)=""
 Q:$G(BPCOBIEN)=""
 Q:$G(BPPAYAMT)=""
 ;
 ;S input variables for FileMan data retrieval routine
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=CRXIEN
 S DA(9002313.0401)=BPCOBIEN
 S DA(9002313.401342)=BPPAYAMT
 ;
 S DR="400" ;field (#400) MEDICATIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=342 ;(#342) OTHER PAYER AMT PAID QUALIFIER
 S DR(9002313.401342)=".01;431"  ;fields
 S DIQ="BPS",DIQ(0)="I"
 ;
 ;Execute data retrieval routine
 D EN^DIQ1
 Q
 ;
GETBPS7(CLAIMIEN,CRXIEN,BPCOBIEN,BPREJCT,BPS) ;EP - from GETBPS5
 ;
 ;Manage local variables
 N DIC,DR,DA,DIQ,D0,DIQ2
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(CRXIEN)=""
 Q:$G(BPCOBIEN)=""
 Q:$G(BPREJCT)=""
 ;
 ;S input variables for FileMan data retrieval routine
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=CRXIEN
 S DA(9002313.0401)=BPCOBIEN
 S DA(9002313.401472)=BPREJCT
 ;
 S DR="400" ;field (#400) MEDICATIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=472 ;(#472) OTHER PAYER REJECT CODE
 S DR(9002313.401472)=".01"  ;fields
 S DIQ="BPS",DIQ(0)="I"
 ;
 ;Execute data retrieval routine
 D EN^DIQ1
 Q
 ;
