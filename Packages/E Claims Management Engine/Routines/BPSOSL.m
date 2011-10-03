BPSOSL ;BHAM ISC/FCS/DRS/DLF - Logging ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Entry Points:
 ;   LOG  - Log a message
 ;   LOG2CLM - Log a message to all transactions associated with a claim
 ;   LOG2LIST - Log a message to all transactions in RXILIST
 ;   LOGARRAY - Log array data into the transaction
 ;   LOGARAY2 - Log array data into all transactions associated with a claim
 ;
 ; SLOT is usually a BPS Transaction, but can also be a communication log
 ;   The only communication log currently is for purging (format is DT+.5)
 ;
 ; LOG - Add an entry to BPS LOG
 ; Input
 ;   SLOT - Slot to write message (required)
 ;   TEXT - Message text (required)
 ;   SPECIAL - Special processing (add date and/or time to TEXT
 ;             If it contains a 'D', add Date
 ;             If it contains a 'T', add time
LOG(SLOT,TEXT,SPECIAL) ;
 ; Check parameters
 I $G(SLOT)="" Q
 I $G(TEXT)="" Q
 ;
 ; Do SPECIAL processing
 I $G(SPECIAL)]"",SPECIAL["D"!(SPECIAL["T") D
 . N %,%H,%I,X,Y D NOW^%DTC S Y=% X ^DD("DD")
 . I SPECIAL'["D" S Y=$P(Y,"@",2)
 . I SPECIAL'["T" S Y=$P(Y,"@")
 . S TEXT=TEXT_" - "_Y
 ;
 ; Initialize variables
 N FN,FDA,LOGIEN,IEN,MSG,NOW
 S FN=9002313.12,NOW=$$NOW^XLFDT()
 ;
 ; If SLOT not defined, create it and then check for errors
 S LOGIEN=$O(^BPS(FN,"B",SLOT,""))
 I 'LOGIEN D
 . S FDA(FN,"+1,",.01)=SLOT
 . D UPDATE^DIE("","FDA","IEN","MSG")
 . S LOGIEN=$G(IEN(1))
 I 'LOGIEN!$D(MSG) Q
 ;
 ; Update LAST UPDATE field
 K FDA,MSG
 S FDA(FN,LOGIEN_",",.02)=NOW
 D FILE^DIE("","FDA","MSG")
 I $D(MSG) Q
 ;
 ; Create the multiple
 K FDA
 S FN=9002313.1201
 S FDA(FN,"+1,"_LOGIEN_",",.01)=NOW
 S FDA(FN,"+1,"_LOGIEN_",",1)=$TR($E(TEXT,1,200),"^","~")
 D UPDATE^DIE("","FDA")
 Q
 ;
 ; LOG2CLM - Write MSG to log file for all BPS Transactions associated
 ;   with the claim
LOG2CLM(IEN02,MSG) ;
 N IEN59 S IEN59=0
 F  S IEN59=$O(^BPST("AE",IEN02,IEN59)) Q:'IEN59  D LOG(IEN59,MSG)
 Q
 ;
 ; LOG2LIST - Write MSG to the log files of all in RXILIST(*)
 ; Assumes RXILIST exists
LOG2LIST(MSG) ;
 N IEN59
 S IEN59=0
 F  S IEN59=$O(RXILIST(IEN59)) Q:'IEN59  D LOG(IEN59,MSG)
 Q
 ;
 ; LOGARRAY - Log an array
LOGARRAY(SLOT,ROOT,MAX) ;
 N REF S REF=ROOT
 N COUNT S COUNT=0
 I '$D(MAX) S MAX=100
 I $D(@REF)#10'=1 S REF=$Q(@REF)
 F  Q:REF=""  D  Q:'MAX
 . D LOG(SLOT,REF_"="_@REF)
 . S COUNT=COUNT+1
 . S REF=$Q(@REF)
 . S MAX=MAX-1
 I 'MAX,REF]"" D LOG(SLOT,"More of "_ROOT_" to log, but max reached")
 I 'COUNT D LOG(SLOT,"Nothing found in "_ROOT)
 Q
 ;
 ; LOGARAY2 - Log an array to the BPS Transactions associated with a claim
LOGARAY2(IEN02,ROOT,MAX) ;
 N IEN59
 S IEN59=0
 F  S IEN59=$O(^BPST("AE",IEN02,IEN59)) Q:'IEN59  D LOGARRAY(IEN59,ROOT,MAX)
 Q
