BPSECX0 ;BHAM ISC/FCS/DRS/VA/DLF - Retrieve Claim submission record ;05/17/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8,10,15,19,23,24,27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used to pull data from BPS Claims and its multiples
 ; GETBPS2 - BPS Claims level
 ; GETBPS3 - Transaction subfile
 ; GETBPS4 - DUR subfile
 ; GETBPS5 - COB subfile.  GETBPS5 calls the following
 ;    GETBPS6 - Other Payer Amount Paid subfile
 ;    GETBPS7 - Other Payer Reject Code subfile
 ;    GETBPS8 - Other Payer Patient Responsibility subfile
 ;    GETBPS9 - Benefits Stage subfile
 ;
 Q
 ;
 ; Retrieve BPS CLAIMS data
 ; CLAIMIEN = ien in BPS CLAIMS (#9002313.02)
 ; BPS - Passed by reference
 ; returns:  BPS(9002313.02,CLAIMIEN,field #,"I")  = internal format value
GETBPS2(CLAIMIEN,BPS) ; called from BPSECA1 > BPSOSQG > BPSOSQ2
 ;
 Q:$G(CLAIMIEN)=""  ; must have claim IEN
 ;
 N D0,DA,DIC,DIQ,DIQ2,DR
 ;
 S DIC=9002313.02,DR="101:899;980:997"  ; all fields from 101-899 and 990-997, skip 901-908 (used for BPS overhead)
 S DR=DR_";1022;1043;1045" ;Get alphanumeric NCPDP fields 1022 (A22), 1043 (A23) and 1045 (A45)- BPS*1*15
 S DR=DR_";2008;2009;2038" ;Get alphanumeric NCPDP fields 2008 (B08), 2009 (B09) and 2038 (B38) - BPS*1*19
 S DR=DR_";2306;2309:2311" ;Get alphanumeric NCPDP fields 2306 (E06), 2309 (E09), 2310 (E10) and 2311 (E11) - BPS*1*27
 S DA=CLAIMIEN,DIQ="BPS",DIQ(0)="I"  ; "I" for internal format
 D EN^DIQ1
 Q
 ;
 ;Retrieve data in TRANSACTIONS multiple in BPS CLAIMS
 ; CLAIMIEN = ien in BPS CLAIMS (#9002313.02)
 ; TRXIEN = ien in TRANSACTIONS (#9002313.0201)
 ; BPS - Passed by reference
 ; returns: BPS(9002313.0201,TRXIEN,field #,"I") = internal format value
GETBPS3(CLAIMIEN,TRXIEN,BPS) ;called from BPSECA1
 ;
 Q:$G(CLAIMIEN)=""  Q:$G(TRXIEN)=""  ; must have both
 ;
 N D0,DA,DIC,DIQ,DIQ2,DR
 ;
 ; There are other alphanumeric fields that could be added but since they are for segments that are not
 ;  supported by E1, B1, B3 transactions and/or not segments not used by VA.  These can be added later, if
 ;  needed for those segments.
 S DIC=9002313.02,DR="400",DR(9002313.0201)="113:996"  ; all TRANSACTION fields
 S DR(9002313.0201)=DR(9002313.0201)_";1023:1032"
 S DR(9002313.0201)=DR(9002313.0201)_";2024:2032;2039:2043"
 S DR(9002313.0201)=DR(9002313.0201)_";1093;2013:2021;2034;2035;2037"
 S DR(9002313.0201)=DR(9002313.0201)_";2056:2061;2095:2097;2101;2102"
 ; new fields added in 2017 NCPDP updates
 S DR(9002313.0201)=DR(9002313.0201)_";2147;2149;2150;2151;2160;2190;2191"
 S DR(9002313.0201)=DR(9002313.0201)_";2192;2198;2199;2201;2202;2214;2216"
 S DR(9002313.0201)=DR(9002313.0201)_";2217;2218;2221;2222;2251;2252;2253"
 S DR(9002313.0201)=DR(9002313.0201)_";2257;2260;2261;2263;2312"
 ;
 S DA=CLAIMIEN,DA(9002313.0201)=TRXIEN  ; IEN and sub-file IEN
 S DIQ="BPS",DIQ(0)="I"  ; "I" for internal format
 D EN^DIQ1
 ;
 ; Copy Prescriber Phone Number (498.12) to field 498 as this is where BPSOSH2
 ;   expects to find it.  This works for now but if we implement the Prior Auth
 ;   segment (which has multiple field labelled 498), a more complete solution
 ;   will need to be found
 S BPS(9002313.0201,TRXIEN,498,"I")=$G(BPS(9002313.0201,TRXIEN,498.12,"I"))
 Q
 ;
 ;Retrieve DUR/PPS multiple data
 ; CLAIMIEN = ien in BPS CLAIMS (#9002313.02)
 ; TRXIEN = ien in TRANSACTIONS (#9002313.0201)
 ; CDURIEN= DUR/PPS Multiple IEN (9002313.1001)
 ; BPS - Passed by reference
 ; returns: BPS(9002313.1001,CDURIEN,field #,"I") = Value
GETBPS4(CLAIMIEN,TRXIEN,CDURIEN,BPS) ;EP - from BPSECA1
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(TRXIEN)=""
 Q:$G(CDURIEN)=""
 ;
 N D0,DA,DIC,DIQ,DIQ2,DR
 S DIC=9002313.02
 S DR="400",DR(9002313.0201)=473.01  ;fields
 S DR(9002313.1001)=".01;439;440;441;474;475;476"  ;fields
 S DA=CLAIMIEN,DA(9002313.0201)=TRXIEN,DA(9002313.1001)=CDURIEN
 S DIQ="BPS",DIQ(0)="I"
 D EN^DIQ1
 ;
 Q
 ;
 ;Retrieve COB OTHER PAYMENTS multiple data
 ; CLAIMIEN = ien in BPS CLAIMS (#9002313.02)
 ; TRXIEN = ien in TRANSACTIONS (#9002313.0201)
 ; BPCOBIEN= ien in COB OTHER PAYMENTS (#9002313.0401)
 ; BPS - Passed by reference
 ; Output: BPS(9002313.0401,BPCOBIEN,field #,"I") = Value
GETBPS5(CLAIMIEN,TRXIEN,BPCOBIEN,BPS) ;EP - from BPSECA1
 ;
 Q:$G(CLAIMIEN)=""  Q:$G(TRXIEN)=""  Q:$G(BPCOBIEN)=""
 ;
 N BPREJCT,BPSCNT,BPSPAMT,BPSOTHR,D0,DA,DIC,DIQ,DIQ2,DR
 ;
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=TRXIEN
 S DA(9002313.0401)=BPCOBIEN
 S DR="400" ; field (#400) TRANSACTIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=".01;338;339;340;341;443;471;353;392;993;2149"  ; fields
 S DIQ="BPS",DIQ(0)="I"
 D EN^DIQ1
 ;
 ; Loop through PAYER AMT and get the data
 S BPSPAMT=$P($G(^BPSC(CLAIMIEN,400,TRXIEN,337,BPCOBIEN,1,0)),U,4)
 F BPSCNT=1:1:BPSPAMT D GETBPS6(CLAIMIEN,TRXIEN,BPCOBIEN,BPSCNT,.BPS)
 ;
 ; Loop through OTHER PAYER REJECT CODE multiple and get the data
 S BPREJCT=$P($G(^BPSC(CLAIMIEN,400,TRXIEN,337,BPCOBIEN,2,0)),U,4)
 F BPSCNT=1:1:BPREJCT D GETBPS7(CLAIMIEN,TRXIEN,BPCOBIEN,BPSCNT,.BPS)
 ;
 ; Loop through PAYER-PATIENT RESP and get the data
 S BPSPAMT=$P($G(^BPSC(CLAIMIEN,400,TRXIEN,337,BPCOBIEN,3,0)),U,4)
 F BPSCNT=1:1:BPSPAMT D GETBPS8(CLAIMIEN,TRXIEN,BPCOBIEN,BPSCNT,.BPS)
 ;
 ; Loop through BENEFIT STAGES and get the data
 S BPSPAMT=$P($G(^BPSC(CLAIMIEN,400,TRXIEN,337,BPCOBIEN,4,0)),U,4)
 F BPSCNT=1:1:BPSPAMT D GETBPS9(CLAIMIEN,TRXIEN,BPCOBIEN,BPSCNT,.BPS)
 Q
 ;
 ; Other Payer Amt Paid multiple (#9002313.401342)
GETBPS6(CLAIMIEN,TRXIEN,BPCOBIEN,BPPAYAMT,BPS) ;EP - from GETBPS5
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(TRXIEN)=""
 Q:$G(BPCOBIEN)=""
 Q:$G(BPPAYAMT)=""
 ;
 N D0,DA,DIC,DIQ,DIQ2,DR
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=TRXIEN
 S DA(9002313.0401)=BPCOBIEN
 S DA(9002313.401342)=BPPAYAMT
 S DR="400" ; field (#400) TRANSACTIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=342 ;(#342) OTHER PAYER AMT PAID MULTIPLE
 S DR(9002313.401342)=".01;431"  ;fields
 S DIQ="BPS",DIQ(0)="I"
 D EN^DIQ1
 ;
 Q
 ;
 ; Other Payer Reject Code multiple (#9002313.401472)
GETBPS7(CLAIMIEN,TRXIEN,BPCOBIEN,BPREJCT,BPS) ;EP - from GETBPS5
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(TRXIEN)=""
 Q:$G(BPCOBIEN)=""
 Q:$G(BPREJCT)=""
 ;
 N D0,DA,DIC,DIQ,DIQ2,DR
 ;
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=TRXIEN
 S DA(9002313.0401)=BPCOBIEN
 S DA(9002313.401472)=BPREJCT
 S DR="400" ; field (#400) TRANSACTIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=472 ;(#472) OTHER PAYER REJECT CODE MLTPL
 S DR(9002313.401472)=".01"  ;fields
 S DIQ="BPS",DIQ(0)="I"
 D EN^DIQ1
 Q
 ;
 ; Other Payer-Patient Resp Amt multiple (#9002313.401353)
GETBPS8(CLAIMIEN,TRXIEN,BPCOBIEN,BPPAYAMT,BPS) ;EP - from GETBPS5
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(TRXIEN)=""
 Q:$G(BPCOBIEN)=""
 Q:$G(BPPAYAMT)=""
 ;
 N D0,DA,DIC,DIQ,DIQ2,DR
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=TRXIEN
 S DA(9002313.0401)=BPCOBIEN
 S DA(9002313.401353)=BPPAYAMT
 S DR="400" ; field (#400) TRANSACTIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=353.01  ;field (#353.01) OTHER PAYER-PATIENT RESP MLTPL
 S DR(9002313.401353)=".01;351;352"  ;fields
 S DIQ="BPS",DIQ(0)="I"
 D EN^DIQ1
 ;
 Q
 ;
 ; Benefit Stages multiple (#9002313.401392)
GETBPS9(CLAIMIEN,TRXIEN,BPCOBIEN,BPPAYAMT,BPS) ;EP - from GETBPS5
 ;
 ;Make sure input variables are defined
 Q:$G(CLAIMIEN)=""
 Q:$G(TRXIEN)=""
 Q:$G(BPCOBIEN)=""
 Q:$G(BPPAYAMT)=""
 ;
 N D0,DA,DIC,DIQ,DIQ2,DR
 S DIC=9002313.02
 S DA=CLAIMIEN
 S DA(9002313.0201)=TRXIEN
 S DA(9002313.0401)=BPCOBIEN
 S DA(9002313.401392)=BPPAYAMT
 S DR="400" ; field (#400) TRANSACTIONS
 S DR(9002313.0201)=337.01  ;field (#337.01) COB OTHER PAYMENTS
 S DR(9002313.0401)=392.01  ;field (#392.01) BENEFIT STAGE MLTPL
 S DR(9002313.401392)=".01;393;394"  ;fields
 S DIQ="BPS",DIQ(0)="I"
 D EN^DIQ1
 ;
 Q
