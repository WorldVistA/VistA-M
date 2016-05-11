BPSOSCD ;BHAM ISC/FCS/DRS/DLF - Set BPS() "RX" nodes for current medication ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,7,8,10,11,15,19**;JUN 2004;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; reference to $$ACPHONE^IBNCPDPI supported by DBIA 4721
 ; reference to $$MADD^XUAF4 supported by DBIA 2171
 ; reference to $$GET1^DIQ(200,field) supported by DBIA 10060
 ; reference to $$GET1^DIQ(5,field) supported by DBIA 10056
 ; reference to PSS^PSO59 supported by DBIA 4827
 ; reference to $$SITE^VASITE supported by DBIA 10112
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
 N %,BPS0,DRUGIEN,IENS,J,NDC,NPI,OSITEIEN,PRICING,PROVIEN,RTN,RXI,RXIEN,RXRFIEN,VANATURE,VAOIEN,X,ADFEE
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
 .S BPS("RX",MEDN,"Prescriber Street Address")=$P(X,U)_$S($P(X,U,5)]"":" ",1:"")_$P(X,U,5)  ; NCPDP field 365-2K
 .S BPS("RX",MEDN,"Prescriber Street Address Line 1")=$P(X,U)  ; NCPDP field B27-7U
 .S BPS("RX",MEDN,"Prescriber Street Address Line 2")=$P(X,U,5)  ; NCPDP field B28-8U
 .S BPS("RX",MEDN,"Prescriber City Address")=$P(X,U,2)  ; NCPDP field 366-2M
 .S BPS("RX",MEDN,"Prescriber State/Province Address")=$P(X,U,3)  ; NCPDP field 367-2N
 .S BPS("RX",MEDN,"Prescriber Zip/Postal Zone")=$TR($P(X,U,4)," -")  ; NCPDP field 368-2P
 .S BPS("RX",MEDN,"Prescriber Country")=$$COUNTRY($P(X,U,3),$P(X,U,6))    ;NCPDP field B42-3C
 ;
 ; Stop if Eligibility as we do not need any of the claim data below
 I BPS("Transaction Code")="E1" Q
 ;
 ; Basic Prescription Info
 S BPS("RX",MEDN,"Date Written")=$$RXAPI1^BPSUTIL1(RXIEN,1,"I")
 ; SLT - BPS*1.0*11
 ; if the RX Issue Date is in the future, set it to the current date
 I BPS("RX",MEDN,"Date Written")>DT S BPS("RX",MEDN,"Date Written")=DT
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
 ; Calculate date/time for Time of Service 678-Y6 - BPS*1*15
 ; using SUBMIT REQUEST DATE TIME field #17 from earliest transmission log entry
 N FDTIME,IEN57 S IEN57=$O(^BPSTL("B",IEN59,0)) I IEN57 S FDTIME=$P($G(^BPSTL(IEN57,0)),U,13)
 ; Otherwise use current time
 I $G(FDTIME)="" S FDTIME=$$NOW^XLFDT
 ; Save time as HHMMSS
 S BPS("Claim",MEDN,"Time of Service")=$$LJ^XLFSTR($P(FDTIME,".",2),6,0) ; 678-Y6 Time of Service
 ;
 ; NDC = NDC number drug, try transaction 1st, if null get it from Rx/refill
 S BPS("RX",MEDN,"Product ID Qualifier")="03"
 S NDC=$P(^BPST(IEN59,1),U,2)
 I NDC="" S NDC=$$GETNDC^PSONDCUT(RXIEN,RXRFIEN) D LOG^BPSOSL(IEN59,RTN_"-NDC sent as "_NDC)
 S BPS("RX",MEDN,"NDC")=NDC
 ;
 ; Prescription Data dependent on original vs. refill
 D:'RXRFIEN  ; 1st fill
 .S BPS("RX",MEDN,"Days Supply")=$$RXAPI1^BPSUTIL1(RXIEN,8,"I")
 .S BPS("RX",MEDN,"DAW")=$$RXAPI1^BPSUTIL1(RXIEN,81,"I")
 .;Use FINISHING PERSON field as pharmacist identifier for Initials and ID - BPS*1*15 - DBIA 10112 for $$SITE
 .S BPS("Provider",MEDN,"Pharmacist Initials")=$$GET1^DIQ(200,+$$RXAPI1^BPSUTIL1(RXIEN,38,"I"),1)
 .S BPS("Provider",MEDN,"Pharmacist ID")=$P($$SITE^VASITE,U,3)_$$RJ^XLFSTR(+$$RXAPI1^BPSUTIL1(RXIEN,38,"I"),15,0)
 D:RXRFIEN  ; refill
 .S BPS("RX",MEDN,"Days Supply")=$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,RXRFIEN,1.1,"I")
 .S BPS("RX",MEDN,"DAW")=$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,RXRFIEN,81,"I")
 .;Use FILLING PERSON field as pharmacist identifier for Initials and ID - BPS*1*15 - DBIA 10112 for $$SITE
 .S BPS("Provider",MEDN,"Pharmacist Initials")=$$GET1^DIQ(200,+$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,RXRFIEN,19,"I"),1)
 .S BPS("Provider",MEDN,"Pharmacist ID")=$P($$SITE^VASITE,U,3)_$$RJ^XLFSTR(+$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,RXRFIEN,19,"I"),15,0)
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
 S PRICING=$G(^BPST(IEN59,5))
 S BPS("RX",MEDN,"Quantity")=$P(PRICING,U)
 S BPS("RX",MEDN,"Unit Price")=$P(PRICING,U,2)
 S BPS("RX",MEDN,"Unit of Measure")=$P(PRICING,U,8)
 S BPS("RX",MEDN,"Basis of Cost Determination")=$G(VAINFO(9002313.59902,IENS,902.13,"I"))
 S BPS("RX",MEDN,"Usual & Customary")=$G(VAINFO(9002313.59902,IENS,902.14,"I"))
 S BPS("RX",MEDN,"Gross Amount Due")=$G(VAINFO(9002313.59902,IENS,902.15,"I"))
 S BPS("RX",MEDN,"Ingredient Cost")=$G(VAINFO(9002313.59902,IENS,902.2,"I"))
 S BPS("RX",MEDN,"Dispensing Fee")=$G(VAINFO(9002313.59902,IENS,902.12,"I"))
 S ADFEE=+$G(VAINFO(9002313.59902,IENS,902.16,"I"))
 I ADFEE'=0 D
 . S BPS("RX",MEDN,"Other Amt Qual",1)="04"
 . S BPS("RX",MEDN,"Other Amt Value",1)=ADFEE
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
 N COBPIEN,APDIEN,REJIEN,DATA
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
 .. S DATA=$G(^BPST(IEN59,14,COBPIEN,1,APDIEN,0))
 .. S BPS("RX",MEDN,"OTHER PAYER",COBPIEN,"P",APDIEN,0)=$P(DATA,"^",1)_"^"_$$GET1^DIQ(9002313.2,$P(DATA,"^",2),.01)
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
 I '$G(IEN59) Q ""
 I '$G(PRVIEN) Q ""
 ;
 N BPSND,F,IPTR,IEN,OPSITE,PRVADDR,PRVNVA,RSLT,AD2
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
 .S:IPTR RSLT=$$MADD^XUAF4(IPTR)_U_$$GET1^DIQ(4,IPTR_",",4.02)_U_$$GET1^DIQ(4,IPTR_",",4.04,"I")
 .K ^TMP($J,BPSND)
 ;
 ; Non-VA prescriber - address data found in file 200
 F F=.111,.112,.113,.114,.115,.116 S PRVADDR(F)=$$GET1^DIQ(200,PRVIEN_",",F)
 ; Get State info
 S PRVADDR(.115,"ABBR")="",IEN=$$GET1^DIQ(200,PRVIEN_",",.115,"I"),PRVADDR(.115,"ABBR")=$$GET1^DIQ(5,+IEN_",",1)
 ; Build Address Line 2
 S AD2=PRVADDR(.112) I PRVADDR(.113)]"" S AD2=AD2_$S(AD2]"":" ",1:"")_PRVADDR(.113)
 ; Build result string
 S RSLT=PRVADDR(.111)_U_PRVADDR(.114)_U_PRVADDR(.115,"ABBR")_U_PRVADDR(.116)_U_AD2_U_IEN
 ;
PRVADX ;
 Q RSLT
 ;
COUNTRY(STATE,IEN) ;
 ; Convert STATE abbreviation into a ISO-3166-1 country code
 ; Input:
 ;    STATE: State Abbreviation
 ; Output: ISO-3166-1 Country Code
 ;
 I $G(STATE)="" Q ""
 I '$G(IEN) Q ""
 I ",BC,MB,NB,NF,NS,NT,ON,PE,QC,SK,YT,CANAD,NU,"[(","_STATE_",") Q "CA" ; Canada
 I STATE="FG"!(STATE="EU")!(STATE="UN") Q ""  ; Foreign Country, Europe, Unknown
 I STATE="AS" Q "AS"  ; American Samoa
 I STATE="FM" Q "FM"  ; Federated States of Micronesia
 I STATE="GU" Q "GU"  ; Guam
 I STATE="MH" Q "MH"  ; Marshall Islands
 I STATE="MP" Q "MP"  ; Northern Mariana Islands
 I STATE="MX" Q "MX"  ; Mexico
 I STATE="PH" Q "PH"  ; Philippines
 I STATE="PR" Q "PR"  ; Puerto Rico
 I STATE="PW" Q "PW"  ; Palau
 I STATE="VI" Q "VI"  ; Virgin Islands
 I $$GET1^DIQ(5,IEN_",",2.2,"I")=1 Q "US"
 Q ""
