BPSNCPD3 ;BHAM ISC/LJE - Continuation of BPSNCPDP - DUR HANDLING ;06/16/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,6,7,8,10,11,15,19,20,22,29,40**;JUN 2004;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DUR1 is called by PSO to get the reject information
 ;
 ; Function call for DUR INFORMATION 
 ; Parameters: BRXIEN = Prescription IEN
 ;             BFILL = fill number
 ;             DUR = DUR info passed back
 ;             ERROR = error passed back
 ;             BPRXCOB = payer sequence
 ; Note:
 ;    DUR("BILLED")=0 if ecme off for pharmacy or no transaction in ECME
 ;    DUR(<Insurance counter>,"BILLED")=1 if billed through ecme
DUR1(BRXIEN,BFILL,DUR,ERROR,BPRXCOB) ;
 N SITE,IEN59,DUR1,DURIEN
 I '$G(BRXIEN) S DUR("BILLED")=0 Q
 I $G(BFILL)="" S DUR("BILLED")=0 Q
 S BPRXCOB=+$G(BPRXCOB)
 I BPRXCOB=0 S BPRXCOB=1 ;default is Primary
 ;
 ; Get Site info and check is ECME is turned on
 ; If not, set DUR("BILLED")=0 and quit
 I '$G(BFILL) S SITE=$$RXAPI1^BPSUTIL1(BRXIEN,20,"I")
 I $G(BFILL) S SITE=$$RXSUBF1^BPSUTIL1(BRXIEN,52,52.1,BFILL,8,"I")
 I '$$ECMEON^BPSUTIL(SITE) S DUR("BILLED")=0 Q
 ;
 ; Set up the Transaction IEN
 S IEN59=$$IEN59^BPSOSRX(BRXIEN,BFILL,BPRXCOB)
 I IEN59="" S DUR("BILLED")=0 Q
 ;
 ; If the transaction record does not exist, set DUR("BILLED")=0 and quit
 I '$D(^BPST(IEN59)) S DUR("BILLED")=0 Q
 I $$GET1^DIQ(9002313.59,IEN59,301)="NOT INSURED" S DUR("BILLED")=0 Q
 ;
 S DUR(BPRXCOB,"BILLED")=1
 ;
 S DUR(BPRXCOB,"ELIGBLT")=$P($G(^BPST(IEN59,9)),U,4)
 ; Get Insurance Info and set into DUR array
 S DUR(BPRXCOB,"INSURANCE POINTER")=$$GET1^DIQ(9002313.59902,"1,"_IEN59_",",902.33,"I") ; Insurance Company IEN
 D GETS^DIQ(9002313.59902,"1,"_IEN59_",","902.05;902.06;902.24;902.25;902.26","E","DUR1","ERROR")
 S DUR(BPRXCOB,"INSURANCE NAME")=$G(DUR1(9002313.59902,"1,"_IEN59_",",902.24,"E"))  ; Insurance Company Name
 S DUR(BPRXCOB,"GROUP NUMBER")=$G(DUR1(9002313.59902,"1,"_IEN59_",",902.05,"E"))    ; Insurance Group Number
 S DUR(BPRXCOB,"GROUP NAME")=$G(DUR1(9002313.59902,"1,"_IEN59_",",902.25,"E"))      ; Insurance Group Name
 S DUR(BPRXCOB,"PLAN CONTACT")=$G(DUR1(9002313.59902,"1,"_IEN59_",",902.26,"E"))    ; Insurance Contact Number
 S DUR(BPRXCOB,"CARDHOLDER ID")=$G(DUR1(9002313.59902,"1,"_IEN59_",",902.06,"E"))   ; Cardholder ID
 ;
 ; Get Response IEN and Data
 S DURIEN="",DURIEN=$P(^BPST(IEN59,0),"^",5)
 D DURRESP(DURIEN,.DUR,BPRXCOB) ; Note: In the future, we may need to get/store DURIEN for each COB
 Q
 ;
DURRESP(DURIEN,DUR,BPRXCOB) ;
 ;Input Variables:
 ; DURIEN - Claim Response IEN. Pointer to the BPS RESPONSES File #9002313.03
 ; BPRXCOB - (Optional) The Payer Sequence:
 ;   1 - Primary (default)
 ;   2 - Secondary
 ;
 ;Output Variables:
 ; DUR - Array of DUR related information for a specific claim response in the
 ;   BPS RESPONSES file in the following format (INSN is the Payer Sequence):
 ;
 ; DUR(INSN,"RESPONSE IEN") - Pointer to the RESPONSE file (#9002313.03) for
 ;   the claim submission
 ; DUR(INSN,"PCN") - Processor Control Number
 ; DUR(INSN,"MESSAGE") - The Transmission level specific data, Message field 504
 ; DUR(INSN,"PAYER MESSAGE") - Message returned from the payer in the Transaction
 ;   level
 ; DUR(INSN,"STATUS") - Status of the claim (i.e. REJECTED CLAIM, PAYABLE)
 ;
 ; The following four fields are redundant with the fields in the DUR PPS
 ; array but are provided for backwards compatibility.
 ; DUR(INSN,"REASON") - Reason for Service Code pointer to BPS NCPDP REASON FOR
 ;   SERVICE CODE file (#9002313.23)
 ; DUR(INSN,"PREV FILL DATE") - Plan's Previous Fill Date
 ; DUR(INSN,"DUR FREE TEXT DESC") - Drug Utilization Review (DUR) description
 ;   and/or claims rejection free text information from the payer
 ; DUR(INSN,"DUR ADD MSG TEXT") - Drug Utilization Review (DUR) additional free
 ;   text information from the payer
 ;
 ; The following fields are from the DUR PPS RESPONSE multiple.
 ; DUR(INSN,"DUR PPS",SEQ,"DUR PPS RESPONSE") - Total number of DUR PPS
 ;   responses from the payer
 ; DUR(INSN,"DUR PPS",SEQ,"REASON FOR SERVICE CODE") - Code identifying the
 ;   type of utilization conflict detected or the reason for the pharmacist
 ;   professional service
 ; DUR(INSN,"DUR PPS",SEQ,"CLINICAL SIGNIFICANCE CODE") - Code identifying
 ;   the significance or severity level of a clinical event as contained
 ;   in the originating data base
 ; DUR(INSN,"DUR PPS",SEQ,"OTHER PHARMACY INDICATOR") - Code for the type of
 ;   pharmacy dispensing the conflicting drug
 ; DUR(INSN,"DUR PPS",SEQ,"PREVIOUS DATE OF FILL") - Date prescription was
 ;   previously filled
 ; DUR(INSN,"DUR PPS",SEQ,"QUANTITY OF PREVIOUS FILL") - Amount expressed in
 ;   metric decimal units of the conflicting agent that was previously filled
 ; DUR(INSN,"DUR PPS",SEQ,"DATABASE INDICATOR") - Code identifying the source
 ;   of drug information used for DUR processing
 ; DUR(INSN,"DUR PPS",SEQ,"OTHER PRESCRIBER INDICATOR") - Code comparing the
 ;   prescriber of the current prescription to the prescriber of the previously
 ;   filled conflicting prescription
 ; DUR(INSN,"DUR PPS",SEQ,"DUR FREE TEXT MESSAGE") - Text that provides
 ;   additional detail regarding a DUR conflict
 ; DUR(INSN,"DUR PPS",SEQ,"DUR ADDITIONAL TEXT") - Descriptive information that
 ;   further defines the referenced DUR alert
 ; DUR(INSN,"REJ CODE LST") - List of rejection code(s) returned by the payer
 ;   separated by commas (i.e. 79,14)
 ; DUR(INSN,"REJ CODES",SEQ,REJ CODE) - Array of rejection code descriptions
 ;   where REJ CODE correlates to DUR(INSN,"REJ CODE LST") value(s) and SEQ
 ;   equals a sequential number
 ;
 I '$G(DURIEN) Q
 S BPRXCOB=+$G(BPRXCOB)
 I BPRXCOB=0 S BPRXCOB=1 ;default is Primary
 N ADDMESS,I,DUR1,CLMIEN
 S DUR(BPRXCOB,"RESPONSE IEN")=DURIEN
 ;
 ;Get BIN from claim
 S CLMIEN=$$GET1^DIQ(9002313.03,DURIEN,.01,"I")
 S DUR(BPRXCOB,"BIN")=$$GET1^DIQ(9002313.02,CLMIEN_",",101) ; BIN Number
 ;
 ;Get PCN from claim
 S DUR(BPRXCOB,"PCN")=$$GET1^DIQ(9002313.02,CLMIEN_",",104) ; PCN Number
 ;
 ; Get the Transmission specific data (Message)
 S DUR(BPRXCOB,"MESSAGE")=$$GET1^DIQ(9002313.03,DURIEN_",",504,"E")
 ;
 ; Get the Additional Message Information from the transaction
 D ADDMESS^BPSSCRLG(DURIEN,1,.ADDMESS)
 M DUR(BPRXCOB,"PAYER MESSAGE")=ADDMESS
 ;
 ; Get the other transaction level data
 D GETS^DIQ(9002313.0301,"1,"_DURIEN_",","501;567.01*","E","DUR1","ERROR")
 S DUR(BPRXCOB,"STATUS")=$G(DUR1(9002313.0301,"1,"_DURIEN_",",501,"E"))                  ;Status of Response
 ;
 ; The following four fields are redundant with the fields in the DUR PPS 
 ;   multiple but are needed for backwards compatibility with the OP code
 S DUR(BPRXCOB,"REASON")=$G(DUR1(9002313.1101,"1,1,"_DURIEN_",",439,"E"))                ;Reason for Service Code
 S DUR(BPRXCOB,"PREV FILL DATE")=$G(DUR1(9002313.1101,"1,1,"_DURIEN_",",530,"E"))        ;Previous Date of Fill
 S DUR(BPRXCOB,"DUR FREE TEXT DESC")=$G(DUR1(9002313.1101,"1,1,"_DURIEN_",",544,"E"))    ;DUR Free Text Message from Payer
 S DUR(BPRXCOB,"DUR ADD MSG TEXT")=$G(DUR1(9002313.1101,"1,1,"_DURIEN_",",570,"E"))      ;DUR Additional Message Text from Payer
 ;
 ; Get DUR PPS RESPONSE multiple values
 S DUR(BPRXCOB,"DUR PPS RESPONSE")=""
 F I=1:1 Q:'$D(DUR1(9002313.1101,I_",1,"_DURIEN_",",.01))  D
 . S DUR(BPRXCOB,"DUR PPS RESPONSE")=I
 . S DUR(BPRXCOB,"DUR PPS",I,"DUR PPS RESPONSE")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",.01,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"REASON FOR SERVICE CODE")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",439,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"CLINICAL SIGNIFICANCE CODE")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",528,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"OTHER PHARMACY INDICATOR")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",529,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"PREVIOUS DATE OF FILL")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",530,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"QUANTITY OF PREVIOUS FILL")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",531,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"DATABASE INDICATOR")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",532,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"OTHER PRESCRIBER INDICATOR")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",533,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"DUR FREE TEXT MESSAGE")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",544,"E"))
 . S DUR(BPRXCOB,"DUR PPS",I,"DUR ADDITIONAL TEXT")=$G(DUR1(9002313.1101,I_",1,"_DURIEN_",",570,"E"))
 ;
 ; Get DUR reject codes and description and store in DUR 
 D GETS^DIQ(9002313.0301,"1,"_DURIEN_",","511*","I","DUR1","ERROR") ;get DUR codes and descriptions
 S DUR(BPRXCOB,"REJ CODE LST")=""
 F I=1:1 Q:'$D(DUR1(9002313.03511,I_",1,"_DURIEN_","))  D
 . N REJX,REJN
 . S REJX=$G(DUR1(9002313.03511,I_",1,"_DURIEN_",",.01,"I")) Q:REJX=""     ; external reject code
 . S REJN=+$O(^BPSF(9002313.93,"B",REJX,0)) Q:'REJN                        ; internal reject code ien
 . S DUR(BPRXCOB,"REJ CODES",I,REJX)=$P($G(^BPSF(9002313.93,REJN,0)),U,2)  ; reject code description
 . S DUR(BPRXCOB,"REJ CODE LST")=DUR(BPRXCOB,"REJ CODE LST")_","_REJX
 S DUR(BPRXCOB,"REJ CODE LST")=$E(DUR(BPRXCOB,"REJ CODE LST"),2,9999)
 Q
