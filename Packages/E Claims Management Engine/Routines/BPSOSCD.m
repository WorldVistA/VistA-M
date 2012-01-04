BPSOSCD ;BHAM ISC/FCS/DRS/DLF - Set BPS() "RX" nodes for current medication ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,7,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; reference to $$ACPHONE^IBNCPDPI supported by DBIA 4721
 ; reference to $$MADD^XUAF4 supported by DBIA 2171
 ; reference to $$GET1^DIQ(200,field) supported by DBIA 10060
 ; reference to $$GET1^DIQ(5,field) supported by DBIA 10056
 ; reference to PSS^PSO59 supported by DBIA 4827
 ;
 Q
 ;
 ;MEDINFO, Set BPS("RX)" nodes for current medication
 ; Called from BPSOSCA for every transaction in the multiple
 ; IEN59 = IEN in BPS TRANSACTION (#9002313.59)
 ; IEN5902 = IEN for Insurance multiple of BPS Transactions
 ; MEDN = Index number of medication being processed
 ; BPS array shared by all of the BPSOSC* routines, created in BPSOSCA
 ; VAINFO created in BPSOSCB
MEDINFO(IEN59,IEN5902,MEDN) ;
 ; Verify Parameters
 I $G(IEN59)="" Q
 I $G(IEN5902)="" Q
 I $G(MEDN)="" Q
 ;
 N %,BPS0,DRUGIEN,FILLDT,IENS,J,NDC,NPI,OSITEIEN,PRICING,PROVIEN,RTN,RXI,RXIEN,RXRFIEN,VANATURE,VAOIEN,X
 ;
 ;RXIEN=Rx IEN, RXRFIEN=Fill Number, IENS=FileMan style IENS
 S BPS0=$G(^BPST(IEN59,1)),RXIEN=$P(BPS0,U,11),RXRFIEN=$P(BPS0,U,1),IENS=IEN5902_","_IEN59_","
 ;
 S RTN=$T(+0)  ; for log
 ; Get any user-entered overrides stored in BPS NCPDP OVERRIDES
 D OVERRIDE(IEN59,MEDN)
 ;
 ; Retrieve DUR values
 D DURVALUE(IEN59,MEDN)
 ;
 ; Build COB array for secondary claims
 I $$COB59^BPSUTIL2(IEN59)>1 D COB(IEN59,MEDN)
 ;
 ; Basic RX info
 S BPS("RX",MEDN,"IEN59")=IEN59
 S BPS("RX",MEDN,"RX IEN")=RXIEN
 S BPS("RX",MEDN,"RX Number")=RXIEN
 ;
 ; Get/format Service Date from BPS TRANSACTION, if null use $$DOSDATE^BPSSCRRS
 S FILLDT=$P($G(^BPST(IEN59,12)),U,2)
 ; Note that $$DOSDATE returns the current date if RXIEN and RXRIEN are null so this works
 ;   for Eligibility even if there is no RX/Fill.
 I FILLDT="" S FILLDT=$$DOSDATE^BPSSCRRS(RXIEN,RXRFIEN) D LOG^BPSOSL(IEN59,RTN_"-Fill Date sent as "_FILLDT)
 S BPS("RX",MEDN,"Date Filled")=$$FMTHL7^XLFDT(FILLDT)
 ;
 ; Stop if the transaction code is "E1" and there is no Prescription IEN
 I BPS("Transaction Code")="E1",RXIEN="" Q
 ;
 ; Get Provider Info
 S PROVIEN=+$$RXAPI1^BPSUTIL1(RXIEN,4,"I")
 S BPS("RX",MEDN,"Prescriber IEN")=PROVIEN
 I PROVIEN'="" D
 .S X=$$GET1^DIQ(200,PROVIEN,.01)
 .D NAMECOMP^XLFNAME(.X)
 .S BPS("RX",MEDN,"Prescriber Last Name")=X("FAMILY")
 .S BPS("RX",MEDN,"Prescriber First Name")=X("GIVEN")  ; NCPDP field 364-2J
 .S BPS("RX",MEDN,"Prescriber Phone #")=$$ACPHONE^IBNCPDPI ; DBIA 4721, Agent Cashier Phone Number
 .S BPS("RX",MEDN,"Prescriber Billing Location")=""
 .S NPI=$$NPI^BPSNPI("Individual_ID",+PROVIEN)
 .I NPI<0 S NPI=""
 .S BPS("RX",MEDN,"Prescriber NPI")=$P(NPI,U)
 .S BPS("RX",MEDN,"Primary Care Provider NPI")=$P(NPI,U)
 .S BPS("RX",MEDN,"Provider NPI")=$P(NPI,U)
 .;
 .S X=$$PRVADRS(IEN59,PROVIEN)  ; provide address info
 .S BPS("RX",MEDN,"Prescriber Street Address")=$P(X,U)  ; NCPDP field 365-2K
 .S BPS("RX",MEDN,"Prescriber City Address")=$P(X,U,2)  ; NCPDP field 366-2M
 .S BPS("RX",MEDN,"Prescriber State/Province Address")=$P(X,U,3)  ; NCPDP field 367-2N
 .S BPS("RX",MEDN,"Prescriber Zip/Postal Zone")=$TR($P(X,U,4)," -")  ; NCPDP field 368-2P
 ;
 ; Stop if Eligibility as we do not need any of the claim data below
 I BPS("Transaction Code")="E1" Q
 ;
 ; Basic Prescription Info
 S BPS("RX",MEDN,"Date Written")=$$RXAPI1^BPSUTIL1(RXIEN,1,"I")
 S BPS("RX",MEDN,"New/Refill")=$S(RXRFIEN="":"N",1:"R")
 S BPS("RX",MEDN,"# Refills")=$$RXAPI1^BPSUTIL1(RXIEN,9,"I")
 S BPS("RX",MEDN,"Refill #")=+RXRFIEN
 S BPS("RX",MEDN,"Pharmacy Service Type")="01"  ; 147-U7 Pharmacy Service Type, 1=Community/Retail Pharmacy Services
 ;
 ; PreAuth and Prior Authorization
 ; #1.09 Prior Authorization Number, #1.15 Prior Auth Type Code
 S X=$G(^BPST(IEN59,1))
 S BPS("RX",MEDN,"Preauth #")=$P(X,U,15)_$P(X,U,9)
 S BPS("Claim",MEDN,"Prior Auth Type")=$P(X,U,15)
 S BPS("Claim",MEDN,"Prior Auth Num Sub")=$P(X,U,9)
 ;
 ; delay reason code not sent unless user specifies a code
 S BPS("Claim",MEDN,"Delay Reason Code")=""  ; 357-NV Delay Reason Code
 ;
 ; NDC = NDC number drug, try transaction 1st, if null get it from Rx/refill
 S NDC=$P(^BPST(IEN59,1),U,2)
 I NDC="" S NDC=$$GETNDC^PSONDCUT(RXIEN,RXRFIEN) D LOG^BPSOSL(IEN59,RTN_"-NDC sent as "_NDC)
 S BPS("RX",MEDN,"NDC")=NDC
 ;
 ; Prescription Data dependent on original vs. refill
 D:'RXRFIEN  ; 1st fill
 .S BPS("RX",MEDN,"Days Supply")=$$RXAPI1^BPSUTIL1(RXIEN,8,"I")
 .S BPS("RX",MEDN,"DAW")=$$RXAPI1^BPSUTIL1(RXIEN,81,"I")
 D:RXRFIEN  ; refill
 .S BPS("RX",MEDN,"Days Supply")=$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,RXRFIEN,1.1,"I")
 .S BPS("RX",MEDN,"DAW")=$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,RXRFIEN,81,"I")
 ;
 ; Origin Code, VAOIEN=PLACER ORDER # from file 52, VANATURE=NATURE OF ORDER in sub-file 100.008
 S VAOIEN=+$$RXAPI1^BPSUTIL1(RXIEN,39.3,"I"),VANATURE=$$GET1^DIQ(100.008,"1,"_VAOIEN_",","12")
 S BPS("RX",MEDN,"Origin Code")=$S(VANATURE="AUTO":2,VANATURE["ELECTRONIC":3,VANATURE="DUPLICATE":0,VANATURE["TELEPHONE":2,1:1)
 ;
 ; NCPDP field 420-DK Submission Clarification Code, default to "01" for vD.0, "00" for v5.1
 ;   note: this is a multiple (#9002313.02354), additional codes may be added by other routines
 S %=$P($G(^BPST(IEN59,12)),U,3),BPS("RX",MEDN,"Submission Clarif Code",1)=$S(%]"":%,$G(BPS("NCPDP","Version"))=51:"00",1:"01")
 ;
 ; Drug Info
 S DRUGIEN=$$RXAPI1^BPSUTIL1(RXIEN,6,"I")
 D:DRUGIEN'=""
 .S BPS("RX",MEDN,"Drug IEN")=DRUGIEN
 .S BPS("RX",MEDN,"Drug Name")=$$DRUGDIE^BPSUTIL1(DRUGIEN,.01,"E")
 ;
 ; Pricing Info
 S BPS("RX",MEDN,"Alt. Product Type")="03"
 S BPS("RX",MEDN,"Gross Amount Due")=$G(VAINFO(9002313.59902,IENS,902.15,"I"))
 S BPS("RX",MEDN,"Usual & Customary")=$G(VAINFO(9002313.59902,IENS,902.14,"I"))
 S BPS("RX",MEDN,"Basis of Cost Determination")=$G(VAINFO(9002313.59902,IENS,902.13,"I"))
 ;
 ; More pricing info
 S PRICING=$G(^BPST(IEN59,5))
 S BPS("RX",MEDN,"Quantity")=$P(PRICING,U) ; 01/31/2001
 S BPS("RX",MEDN,"Unit Price")=$P(PRICING,U,2)
 S BPS("RX",MEDN,"Ingredient Cost")=$J($P(PRICING,U,2),0,2)
 S BPS("RX",MEDN,"Dispensing Fee")=$J($P(PRICING,U,4),0,2)
 S BPS("Site","Dispensing Fee")=BPS("RX",MEDN,"Dispensing Fee")
 S BPS("RX",MEDN,"Usual & Customary")=$P(PRICING,U,5)
 S BPS("RX",MEDN,"Unit of Measure")=$P(PRICING,U,8)
 S:$G(BPS("NCPDP","Add Disp. Fee to Ingr. Cost")) BPS("RX",MEDN,"Ingredient Cost")=BPS("RX",MEDN,"Ingredient Cost")+BPS("RX",MEDN,"Dispensing Fee")
 ;
 Q
 ;
 ; OVERRIDE - Retrieve OVERRIDE nodes and put into BPS array
 ; They will be fetched from BPS("OVERRIDE"
 ;   during low-level construction of the actual encoded claim packet.
 ; BPS("OVERRIDE",field)=value  for fields 101-401
 ; BPS("OVERRIDE","RX",MEDN,field) for med #N, fields 402+
 ; Note that if you have multiple transactions bundled, the
 ;   union of overrides from 101-401 apply to all; and if there's a
 ;   conflict, the last one overwrites the previous ones.
OVERRIDE(IEN59,MEDN) ;
 N IEN511,RETVAL
 S IEN511=$P(^BPST(IEN59,1),U,13) Q:'IEN511
 S RETVAL=$$GET511^BPSOSO2(IEN511,"BPS(""OVERRIDE"")","BPS(""OVERRIDE"",""RX"","_MEDN_")")
 Q
 ;
 ; DURVALUE - Will read in the DUR data from the DUR multiple
 ;   in BPS Transactions and store the values into BPS("RX",MEDN,DUR,....)
 ; NOTE - unlike most values, these fields are stored by their
 ;   field number.  Since they are repeating, it will ease the
 ;   retrieval of them, when we populate the claim.
DURVALUE(IEN59,MEDN) ;
 N DUR,DCNT,DURREC
 ;
 S (DUR,DCNT)=0
 F  S DCNT=$O(^BPST(IEN59,13,DCNT)) Q:'DCNT  D
 .S DURREC=$G(^BPST(IEN59,13,DCNT,0))
 .I DURREC="" Q
 .S DUR=DUR+1
 .S BPS("RX",MEDN,"DUR",DUR,473)=DUR            ;473-7E DUR/PPS Code Counter
 .S BPS("RX",MEDN,"DUR",DUR,439)=$P(DURREC,U,3) ;439-E4 Reason For Service Code
 .S BPS("RX",MEDN,"DUR",DUR,440)=$P(DURREC,U,2) ;440-E5 Professional Service Code
 .S BPS("RX",MEDN,"DUR",DUR,441)=$P(DURREC,U,4) ;441-E6 Result of Service Code
 .S BPS("RX",MEDN,"DUR",DUR,474)=""             ;474-8E DUR/PPS Level Of Effort
 .Q:$G(BPS("NCPDP","Version"))'=51  ; fields 475&476 not used in vD.0
 .S BPS("RX",MEDN,"DUR",DUR,475)=""             ;475-J9 DUR Co-Agent ID Qualifier
 .S BPS("RX",MEDN,"DUR",DUR,476)=""             ;476-H6 DUR Co-Agent ID
 ;
 Q
 ;
COB(IEN59,MEDN) ; process the COB fields and build the COB array
 ; Code for Payer-Patient Responsibility and Benefit Stages multiples
 ;  not implemented yet (except by certification)
 ;
 ; build array of COB secondary claim data from the BPS Transaction file - esg - 6/16/10
 N COBPIEN,APDIEN,REJIEN
 K BPS("RX",MEDN,"OTHER PAYER")
 ;
 ; Field 337-4C COB OTHER PAYMENTS COUNT (9002313.59,1204)  moved into [1] below
 S BPS("RX",MEDN,"OTHER PAYER",0)=$P($G(^BPST(IEN59,12)),U,4)
 ;
 S COBPIEN=0 F  S COBPIEN=$O(^BPST(IEN59,14,COBPIEN)) Q:'COBPIEN  D
 . ; Note that this will set pieces 1-7.  Piece 8 is reserved for
 . ;  Payer-Patient Responsibility Count and is set by the certification code
 . S BPS("RX",MEDN,"OTHER PAYER",COBPIEN,0)=$G(^BPST(IEN59,14,COBPIEN,0))
 . ;
 . ; retrieve data from other payer amount paid multiple
 . S APDIEN=0 F  S APDIEN=$O(^BPST(IEN59,14,COBPIEN,1,APDIEN)) Q:'APDIEN  D
 .. S BPS("RX",MEDN,"OTHER PAYER",COBPIEN,"P",APDIEN,0)=$G(^BPST(IEN59,14,COBPIEN,1,APDIEN,0))
 .. Q
 . ;
 . ; retrieve data from other payer reject multiple
 . S REJIEN=0 F  S REJIEN=$O(^BPST(IEN59,14,COBPIEN,2,REJIEN)) Q:'REJIEN  D
 .. S BPS("RX",MEDN,"OTHER PAYER",COBPIEN,"R",REJIEN,0)=$G(^BPST(IEN59,14,COBPIEN,2,REJIEN,0))
 Q
 ;
PRVADRS(IEN59,PRVIEN) ; site address for a provider
 ; returns "street address^city^st^zip"
 ; IEN59=BPS TRANSACTION (#9002313.59) ien
 ; PRVIEN=provider IEN in NEW PERSON file (#200)
 ;
 N BPSND,F,IPTR,J,OPSITE,PRVADDR,PRVNVA,RSLT,X
 S RSLT=""
 ;
 S PRVNVA=+$$GET1^DIQ(200,PRVIEN_",",53.91,"I")  ; NON-VA PRESCRIBER
 ;
 ; if false, it's a VA prescriber - address data found in file 4 for the VA pharmacy
 I 'PRVNVA D  G PRVADX
 .S OPSITE=$P($G(^BPST(IEN59,1)),U,4)  ; OUTPATIENT SITE ptr
 .Q:'OPSITE
 .S BPSND="BPS59" K ^TMP($J,BPSND)
 .D PSS^PSO59(OPSITE,"",BPSND)
 .S IPTR=$P($G(^TMP($J,BPSND,OPSITE,101)),U)  ; INSTITUTION ptr
 .S:IPTR RSLT=$$MADD^XUAF4(IPTR)
 .K ^TMP($J,BPSND)
 ;
 ; non-VA prescriber - address data found in file 200
 F F=.111,.112,.113,.114,.115,.116 S PRVADDR(F)=$$GET1^DIQ(200,PRVIEN_",",F)
 S PRVADDR(.115,"ABBR")="",X=PRVADDR(.115) ; state abbreviation
 S:X]"" J=$$GET1^DIQ(200,PRVIEN_",",.115,"I"),PRVADDR(.115,"ABBR")=$$GET1^DIQ(5,J_",",1)
 S X=PRVADDR(.111) F F=.112,.113 I PRVADDR(F)]"" S X=X_$S(X]"":" ",1:"")_PRVADDR(F)  ; street address
 S RSLT=X_U_PRVADDR(.114)_U_PRVADDR(.115,"ABBR")_U_PRVADDR(.116)
 ;
PRVADX ;
 Q RSLT
 ;
