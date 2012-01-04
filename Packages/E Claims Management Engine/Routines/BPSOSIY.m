BPSOSIY ;BHAM ISC/FCS/DRS/DLF - Updating BPS Transaction record ;11/7/07  17:29
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,6,7,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; INIT - Update BPS Transaction
 ; Input
 ;   IEN59 - BPS Transaction
 ;   MOREDATA is not passed but assumed to exist
 ;   BP77 - BPS REQUEST ien
 ; Returns
 ;   ERROR - 0 or error number
INIT(IEN59,BP77) ;EP - from BPSOSIZ
 N BPCOB,BPSTIME
 ;
 ; Update the BPS Request with the Transaction IEN
 I $G(BP77)>0 D UPD7759^BPSOSRX4(BP77,IEN59)
 ;
 ; Initialize variables
 N FDA,MSG,FN,IENS,REC,B1,X1,X2,X3,ERROR,SEQ,X4
 N DIV,RXI,RXR
 S FN=9002313.59,REC=IEN59_",",ERROR=0
 ;
 ; Change status to 0% (Waiting to Start), which will reset START TIME,
 ;   and then to 10% (Building transaction)
 D SETSTAT^BPSOSU(IEN59,0)
 D SETSTAT^BPSOSU(IEN59,10)
 ;
 ; Get the Outpatient Site
 S DIV=MOREDATA("DIVISION")
 I 'DIV,MOREDATA("REQ TYPE")="C" S RXI=$P(IEN59,".",1),RXR=+$E($P(IEN59,".",2),1,4),DIV=$$GETDIV^BPSOSQC(RXI,RXR)
 ;
 ; If there are Prior Auth or Sub Clar Code override, create override
 ;   record.  Note that setting of MOREDATA("BPOVRIEN") in this routine
 ;   will not conflict with prior setting of this value of BPOVRIEN
 ;   since BPOVRIEN and BPSAUTH/BPSCLARF are mutually exclusive
 I $G(MOREDATA("BPSAUTH"))]""!($G(MOREDATA("BPSCLARF"))]"")!($G(MOREDATA("BPSDELAY"))]"") S MOREDATA("BPOVRIEN")=$$OVERRIDE(IEN59)
 ;
 ; Set BPSDATA into local variable
 S B1=$G(MOREDATA("BPSDATA",1))
 ;
 ; Get first record from MOREDATA("IBDATA") as there are some
 ;   non-multiple fields that need it
 S X2="",SEQ=$O(MOREDATA("IBDATA",""))
 I SEQ S X2=$G(MOREDATA("IBDATA",SEQ,2))
 ;
 ; Set non-multiple fields
 S FDA(FN,REC,1.05)=$G(MOREDATA("POLICY"))  ; Policy Number
 S FDA(FN,REC,1.07)=$$GETPHARM^BPSUTIL(DIV) ;BPS Pharmacy
 S FDA(FN,REC,1.08)=1   ;PINS piece
 S FDA(FN,REC,1.11)=$G(MOREDATA("RX"))  ;Prescription
 I $P($G(^BPST(IEN59,1)),U,12)=1 S FDA(FN,REC,1.12)=2 ;Resubmit after reversal
 S FDA(FN,REC,1.13)=$G(MOREDATA("BPOVRIEN"))  ;NCPDP Overrides
 S FDA(FN,REC,5)=$G(MOREDATA("PATIENT")) ;Patient
 I '$P($G(^BPST(IEN59,1)),U,12) S FDA(FN,REC,6)=$G(MOREDATA("SUBMIT TIME")) ;Submit Date/Time
 S FDA(FN,REC,9)=$P(B1,U,4)   ;Fill
 S FDA(FN,REC,10)=$P(B1,U,3)  ;NDC
 S FDA(FN,REC,11)=DIV ;Outpatient Site
 S FDA(FN,REC,13)=$G(MOREDATA("USER"))           ;User
 S FDA(FN,REC,16)=$G(MOREDATA("REQ IEN"))        ;Request IEN
 S FDA(FN,REC,17)=$G(MOREDATA("REQ DTTM"))       ;Request Date/Time
 S FDA(FN,REC,18)=$G(MOREDATA("PAYER SEQUENCE")) ;COB Indicator
 S FDA(FN,REC,19)=$G(MOREDATA("REQ TYPE"))       ;Transaction Type
 S FDA(FN,REC,501)=$P(B1,U,1) ;Drug Quantify
 S FDA(FN,REC,502)=$P(B1,U,2) ;Ingredient Cost
 S FDA(FN,REC,504)=$P(X2,U,1) ;Dispense Fee
 S FDA(FN,REC,505)=$P(X2,U,3) ;Total Price
 S FDA(FN,REC,507)=$P(X2,U,5) ;Administrative Fee
 S FDA(FN,REC,508)=$E($P(B1,U,7),1,2) ;Dispense Unit
 S FDA(FN,REC,901)=1          ;Current VA Insurer
 S FDA(FN,REC,1201)=$G(MOREDATA("RX ACTION")) ;RX Action
 S FDA(FN,REC,1202)=$G(MOREDATA("DATE OF SERVICE")) ;Date of Service
 S FDA(FN,REC,901.04)=$G(MOREDATA("ELIG")) ;Eligibility info returned from billing determination
 ;
 ; File secondary billing fields
 I $$COB59^BPSUTIL2(IEN59)=2 D SECBIL59^BPSPRRX6(.MOREDATA,IEN59)
 ; File non-multiple fields - Record is already defined
 D FILE^DIE("","FDA","MSG")
 I $D(MSG) D  Q ERROR
 . S ERROR=12
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Non-multiple fields did not file")
 . D LOG^BPSOSL(IEN59,"MSG Array:")
 . D LOGARRAY^BPSOSL(IEN59,"MSG")
 . D LOG^BPSOSL(IEN59,"FDA Array:")
 . D LOGARRAY^BPSOSL(IEN59,"FDA")
 ;
 ; Build Multiple
 S SEQ=""
 F  S SEQ=$O(MOREDATA("IBDATA",SEQ)) Q:SEQ=""  D  I ERROR Q
 . K FDA,MSG,IENS
 . S FN=9002313.59902,IENS="+1,"_REC,IENS(1)=SEQ
 . S X1=$G(MOREDATA("IBDATA",SEQ,1)),X2=$G(MOREDATA("IBDATA",SEQ,2)),X3=$G(MOREDATA("IBDATA",SEQ,3)),X4=$G(MOREDATA("IBDATA",SEQ,4))
 . ;
 . ; Update fields
 . S FDA(FN,IENS,.01)=$P(X1,U,1)    ;Plan ID
 . S FDA(FN,IENS,902.02)=$P(X1,U,16) ;B1 Payer Sheet (Billing Request)
 . S FDA(FN,IENS,902.03)=$P(X1,U,2) ;BIN
 . S FDA(FN,IENS,902.04)=$P(X1,U,3) ;PCN
 . S FDA(FN,IENS,902.05)=$P(X1,U,5) ;Group ID
 . S FDA(FN,IENS,902.06)=$P(X1,U,6) ;Cardholder ID
 . S FDA(FN,IENS,902.07)=$S(+$P(X1,U,7)>4:4,1:+$P(X1,U,7)) ;Patient Relationship Code
 . S FDA(FN,IENS,902.08)=$P($P(X1,U,8)," ") ;Cardholder First Name
 . S FDA(FN,IENS,902.09)=$P(X1,U,9)  ;Cardholder Last Name
 . S FDA(FN,IENS,902.11)=$P(X1,U,10) ;Home Plan State
 . S FDA(FN,IENS,902.12)=$P(X2,U,1)  ;Dispense Fee
 . S FDA(FN,IENS,902.13)=$P(X2,U,2)  ;Basis of Cost Determination
 . S FDA(FN,IENS,902.14)=$P(X2,U,3)  ;Usual & Customary Charge
 . S FDA(FN,IENS,902.15)=$P(X2,U,4)  ;Gross Amt Due
 . S FDA(FN,IENS,902.16)=$P(X2,U,5)  ;Administrative Fee
 . S FDA(FN,IENS,902.17)=$P(B1,U,4)  ;Fill Number
 . S FDA(FN,IENS,902.18)=$P(X1,U,13) ;Software/Vendor Cert ID
 . S FDA(FN,IENS,902.19)=$P(X1,U,17) ;B2 Payer Sheet (Reversal)
 . S FDA(FN,IENS,902.21)=$P(X1,U,18) ;B3 Payer Sheet (Rebill)
 . S FDA(FN,IENS,902.22)=$P(B1,U,5)  ;Certify Mode
 . S FDA(FN,IENS,902.23)=$P(B1,U,6)  ;Certification IEN
 . S FDA(FN,IENS,902.24)=$P(X1,U,14) ;Plan Name
 . S FDA(FN,IENS,902.25)=$P(X3,U,1)  ;Group Name
 . S FDA(FN,IENS,902.26)=$P(X3,U,2)  ;Insurance Co Phone #
 . S FDA(FN,IENS,902.27)=$P(X3,U,3)  ;Pharmacy Plan ID
 . S FDA(FN,IENS,902.28)=$P(X3,U,4)  ;Eligibility
 . S FDA(FN,IENS,902.32)=$P(X3,U,6)  ;COB Indicator
 . S FDA(FN,IENS,902.33)=$P(X3,U,5)  ;Insurance Co IEN
 . S FDA(FN,IENS,902.34)=$P(X1,U,19) ;E1 Payer Sheet (Eligibility)
 . S FDA(FN,IENS,902.35)=$P(X3,U,7)  ;Policy Number
 . S FDA(FN,IENS,902.36)=$P(X3,U,8)  ;Max Transactions/Transmission
 . ;the following fields are used only for secondary billing and for primary Tricare billing
 . ;in both cases only entry = 1 in the multiple will be created EVEN if the sequence is 2 (for secondary)
 . ;Note: actually only the entry = 1 is used for primary billing as well, others are never used
 . I SEQ=1 D
 . . S FDA(FN,IENS,902.29)=$G(MOREDATA("RTYPE"))  ;Rate Type
 . . S FDA(FN,IENS,902.3)=$G(MOREDATA("PRIMARY BILL"))  ;Primary bill ien
 . . S FDA(FN,IENS,902.31)=$G(MOREDATA("PRIOR PAYMENT"))  ;Prior payment amount
 . ;
 . ; File the data
 . D UPDATE^DIE("","FDA","IENS","MSG")
 . I $D(MSG) D
 .. S ERROR=13
 .. D LOG^BPSOSL(IEN59,$T(+0)_"-Multiple fields did not file, SEQ="_SEQ)
 .. D LOG^BPSOSL(IEN59,"MSG Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"MSG")
 .. D LOG^BPSOSL(IEN59,"IENS Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"IENS")
 .. D LOG^BPSOSL(IEN59,"FDA Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"FDA")
 ;
 ; Quit if there was an error filing the Insurance multiple
 I ERROR Q ERROR
 ;
 ; Store DUR multiple if it exists
 N DUR,DURREC
 S FN=9002313.5913,DUR=0
 F  S DUR=$O(MOREDATA("DUR",DUR)) Q:DUR=""  D  I ERROR Q
 . K FDA,MSG,IENS
 . S DURREC=$G(MOREDATA("DUR",DUR,0))
 . S IENS="+1,"_REC,IENS(1)=DUR
 . S FDA(FN,IENS,.01)=DUR  ; DUR Counter
 . S FDA(FN,IENS,1)=$P(DURREC,U,1)    ; DUR Professional Service Code
 . S FDA(FN,IENS,2)=$P(DURREC,U,2)    ; DUR Reason for Service Code
 . S FDA(FN,IENS,3)=$P(DURREC,U,3)    ; DUR Result of Service Code
 . D UPDATE^DIE("","FDA","IENS","MSG")
 . I $D(MSG) D
 .. S ERROR=15
 .. D LOG^BPSOSL(IEN59,$T(+0)_"-DUR fields did not file, DUR="_DUR)
 .. D LOG^BPSOSL(IEN59,"DURREC="_DURREC)
 .. D LOG^BPSOSL(IEN59,"MSG Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"MSG")
 .. D LOG^BPSOSL(IEN59,"IENS Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"IENS")
 .. D LOG^BPSOSL(IEN59,"FDA Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"FDA")
 ;
 Q ERROR
 ;
 ; OVERRIDE - Function to create override record
OVERRIDE(IEN59) ;
 ;Save values into BPS NCPDP OVERRIDES (#9002313.511)
 N BPSFDA,BPSFLD,BPOVRIEN,BPSMSG,BPSQ,BPSVALUE
 ;
 ; Set Name (.01) to transaction number
 S BPSFDA(9002313.511,"+1,",.01)=IEN59
 ;
 ; Set Created On (.02) to current date/time
 S BPSFDA(9002313.511,"+1,",.02)=$$NOW^BPSOSRX()
 ;
 ; Submission Clarification Code
 I $G(MOREDATA("BPSCLARF"))]"" D
 . S BPSFLD=$O(^BPSF(9002313.91,"B",420,""))
 . I BPSFLD]"" S BPSFDA(9002313.5111,"+2,+1,",.01)=BPSFLD,BPSFDA(9002313.5111,"+2,+1,",.02)=$E(MOREDATA("BPSCLARF"),1,8)
 ;
 ; Prior Auth Fields (Code and Number)
 I $G(MOREDATA("BPSAUTH"))]"" D
 . S BPSFLD=$O(^BPSF(9002313.91,"B",461,""))
 . I BPSFLD]"" S BPSFDA(9002313.5111,"+3,+1,",.01)=BPSFLD,BPSFDA(9002313.5111,"+3,+1,",.02)=$E($P(MOREDATA("BPSAUTH"),U,1),1,2)
 . S BPSFLD=$O(^BPSF(9002313.91,"B",462,""))
 . I BPSFLD]"" S BPSFDA(9002313.5111,"+4,+1,",.01)=BPSFLD,BPSFDA(9002313.5111,"+4,+1,",.02)=$E($P(MOREDATA("BPSAUTH"),U,2),1,11)
 ;
 ; Delay Reason Code - This is the IEN of the database
 I $G(MOREDATA("BPSDELAY"))]"" D
 . S BPSVALUE=$P($G(^BPS(9002313.29,MOREDATA("BPSDELAY"),0)),U,1)
 . I BPSVALUE="" Q
 . S BPSFLD=$O(^BPSF(9002313.91,"B",357,""))
 . I BPSFLD]"" S BPSFDA(9002313.5111,"+5,+1,",.01)=BPSFLD,BPSFDA(9002313.5111,"+5,+1,",.02)=$E(MOREDATA("BPSDELAY"),1,2)
 ;
 ; Create the record
 D UPDATE^DIE("","BPSFDA","BPOVRIEN","BPSMSG")
 ;
 I $G(BPOVRIEN(1))]"" S BPSQ=BPOVRIEN(1)
 E  S BPSQ=""
 Q BPSQ
