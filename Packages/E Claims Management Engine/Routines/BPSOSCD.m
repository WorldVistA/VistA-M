BPSOSCD ;BHAM ISC/FCS/DRS/DLF - Set BPS() "RX" nodes for current medication ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;----------------------------------------------------------------------
 ;Set BPS() "RX" nodes for current medication:
 ;
 ;Parameters:   IEN59   - Pointer to BPS Transactions
 ;              IEN5902 - IEN for Insurance multiple of BPS Transactions
 ;              MEDN    - Index number indicating what medication is
 ;                        being processed
 ;
 ; Note that the BPS array is shared by all of the BPSOSC* routines and
 ;  is newed by BPSOSCA
 ; Note that VAINFO is newed/set in BPSOSCB
 ;----------------------------------------------------------------------
 ; Called from BPSOSCA for every prescription in the multiple
MEDINFO(IEN59,IEN5902,MEDN) ;
 ; Verify Parameters
 I $G(IEN59)="" Q
 I $G(IEN5902)="" Q
 I $G(MEDN)="" Q
 ;
 ; New variables and basic setup
 N RXIEN,RXRFIEN,IENS,DRUGIEN,PROVIEN,RXI,FILLDT,NDC,NPI
 S RXIEN=$P(IEN59,".",1)
 S RXRFIEN=+$E($P(IEN59,".",2),1,4)
 S IENS=IEN5902_","_IEN59_","
 ;
 ; Get any user-entered overrides stored in BPS NCPDP OVERRIDES
 D OVERRIDE(IEN59,MEDN)
 ;
 ; Retrieve DUR values
 D DURVALUE(IEN59,MEDN)
 ;
 ; Build COB array for secondary claims
 I $$COB59^BPSUTIL2(IEN59)>1 D COB(IEN59,MEDN)
 ;
 ; Get Drug and Prescriber IEN
 S DRUGIEN=$$RXAPI1^BPSUTIL1(RXIEN,6,"I")
 S PROVIEN=$$RXAPI1^BPSUTIL1(RXIEN,4,"I")
 ;
 ; Basic RX info
 S BPS("RX",MEDN,"IEN59")=IEN59
 S BPS("RX",MEDN,"RX IEN")=RXIEN
 S BPS("RX",MEDN,"RX Number")=RXIEN
 S BPS("RX",MEDN,"Date Written")=$$RXAPI1^BPSUTIL1(RXIEN,1,"I")
 S BPS("RX",MEDN,"New/Refill")=$S(RXRFIEN="":"N",1:"R")
 ;
 ; Get/format the Service Date - It should be in BPS Transaction.  If not,
 ;   use the established algorithm, which is $$DOSDATE^BPSSCRRS
 S FILLDT=$P($G(^BPST(IEN59,12)),U,2)
 I FILLDT="" S FILLDT=$$DOSDATE^BPSSCRRS(RXIEN,RXRFIEN) D LOG^BPSOSL(IEN59,$T(+0)_"-Fill Date sent as "_FILLDT)
 S BPS("RX",MEDN,"Date Filled")=$$FMTHL7^XLFDT(FILLDT)
 ;
 ; PreAuth and Prior Auth (use same fields)
 S BPS("RX",MEDN,"Preauth #")=$P(^BPST(IEN59,1),U,15)_$P(^BPST(IEN59,1),U,9)
 S BPS("Claim",MEDN,"Prior Auth Type")=$P(^BPST(IEN59,1),U,15)
 S BPS("Claim",MEDN,"Prior Auth Num Sub")=$P(^BPST(IEN59,1),U,9)
 ;
 ; NDC - Get from transaction first.  If not there (which should not happen),
 ;   get it from the RX/Fill
 S NDC=$P(^BPST(IEN59,1),U,2)
 I NDC="" S NDC=$$GETNDC^PSONDCUT(RXIEN,RXRFIEN) D LOG^BPSOSL(IEN59,$T(+0)_"-NDC sent as "_NDC)
 S BPS("RX",MEDN,"NDC")=NDC
 ;
 ; Prescription Data
 S BPS("RX",MEDN,"# Refills")=$$RXAPI1^BPSUTIL1(RXIEN,9,"I")
 S BPS("RX",MEDN,"Refill #")=+RXRFIEN
 ;
 ; Prescription Data dependent on original vs. refill
 I 'RXRFIEN D  ; first fill
 . S BPS("RX",MEDN,"Days Supply")=$$RXAPI1^BPSUTIL1(RXIEN,8,"I")
 . S BPS("RX",MEDN,"DAW")=$$RXAPI1^BPSUTIL1(RXIEN,81,"I")
 E  D  ; refill
 . S BPS("RX",MEDN,"Days Supply")=$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,+RXRFIEN,1.1,"I")
 . S BPS("RX",MEDN,"DAW")=$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,+RXRFIEN,81,"I")
 ;
 ; Provider Info
 S BPS("RX",MEDN,"Prescriber IEN")=+PROVIEN
 I PROVIEN'="" D
 . S BPS("RX",MEDN,"Prescriber Name")=$$GET1^DIQ(200,+PROVIEN,.01)
 . S BPS("RX",MEDN,"Prescriber Phone #")=$$ACPHONE^IBNCPDPI() ; Agent Cashier Phone Number)
 . I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S BPS("RX",MEDN,"Prescriber DEA #")=$G(BPS("RX",1,"Provider ID"))
 . S BPS("RX",MEDN,"Prescriber DEA #")=$$GET1^DIQ(200,+PROVIEN,53.2)
 . S BPS("RX",MEDN,"Prescriber CAID #")=""
 . S BPS("RX",MEDN,"Prescriber UPIN #")=""
 . S BPS("RX",MEDN,"Prescriber Billing Location")=""
 . S NPI=$$NPI^BPSNPI("Individual_ID",+PROVIEN)
 . I +NPI=-1 S NPI=""
 . S BPS("RX",MEDN,"Prescriber NPI")=$P(NPI,U,1)
 . S BPS("RX",MEDN,"Primary Care Provider NPI")=$P(NPI,U,1)
 . S BPS("RX",MEDN,"Provider NPI")=$P(NPI,U,1)
 ;
 ; Set Prescriber ID field to individual DEA if it exists, else default DEA
 N %
 S %=$G(BPS("RX",MEDN,"Prescriber DEA #"))
 I %="" S %=$G(BPS("Site","Default DEA #"))
 S BPS("RX",MEDN,"Prescriber ID")=%
 ;
 ; Get State IDs for providers
 D STLIC^BPSJPAY(MEDN,PROVIEN,BPS("RX",MEDN,"Date Filled"))
 ;
 ; Origin Code
 N VANATURE,VAOIEN
 S (VANATURE,VAOIEN)="",VAOIEN=+$$RXAPI1^BPSUTIL1(RXIEN,39.3,"I"),VANATURE=$$GET1^DIQ(100.008,"1,"_VAOIEN_",","12")
 S BPS("RX",MEDN,"Origin Code")=$S(VANATURE="AUTO":2,VANATURE["ELECTRONIC":3,VANATURE="DUPLICATE":0,VANATURE["TELEPHONE":2,1:1)
 ;
 ;Submission Clarification Code
 S BPS("RX",MEDN,"Clarification")=$P($G(^BPST(IEN59,12)),U,3)
 ;
 ; Drug Info
 I DRUGIEN'="" D
 . S BPS("RX",MEDN,"Drug IEN")=DRUGIEN
 . S BPS("RX",MEDN,"Drug Name")=$$DRUGDIE^BPSUTIL1(DRUGIEN,.01,"E")
 ;
 ; Pricing Info
 S BPS("RX",MEDN,"Alt. Product Type")="03"
 S BPS("RX",MEDN,"Gross Amount Due")=$G(VAINFO(9002313.59902,IENS,902.15,"I"))
 S BPS("RX",MEDN,"Usual & Customary")=$G(VAINFO(9002313.59902,IENS,902.14,"I"))
 S BPS("RX",MEDN,"Basis of Cost Determination")=$G(VAINFO(9002313.59902,IENS,902.13,"I"))
 ;
 ; More pricing info
 N PRICING
 S PRICING=^BPST(IEN59,5)
 S BPS("RX",MEDN,"Quantity")=$P(PRICING,U) ; 01/31/2001
 S BPS("RX",MEDN,"Unit Price")=$P(PRICING,U,2)
 S BPS("RX",MEDN,"Ingredient Cost")=$J($P(PRICING,U,2),0,2)
 S BPS("RX",MEDN,"Dispensing Fee")=$J($P(PRICING,U,4),0,2)
 S BPS("Site","Dispensing Fee")=BPS("RX",MEDN,"Dispensing Fee")
 S BPS("RX",MEDN,"Usual & Customary")=$J($P(PRICING,U,5),0,2)
 S BPS("RX",MEDN,"Unit of Measure")=$P(PRICING,U,8)
 I $G(BPS("NCPDP","Add Disp. Fee to Ingr. Cost")) D
 . S BPS("RX",MEDN,"Ingredient Cost")=BPS("RX",MEDN,"Ingredient Cost")+BPS("RX",MEDN,"Dispensing Fee")
 ;
 Q
 ;
 ; OVERRIDE - Retrieve OVERRIDE nodes and put into BPS array
 ; They will be fetched from BPS("OVERRIDE"
 ;   during low-level construction of the actual encoded claim packet.
 ; BPS("OVERRIDE",field)=value  for fields 101-401
 ; BPS("OVERRIDE","RX",MEDN,field) for med #N, fields 402+
 ; Note that if you have multiple prescriptions bundled, the
 ;   union of overrides from 101-401 apply to all; and if there's a
 ;   conflict, the last one overwrites the previous ones.
OVERRIDE(IEN59,MEDN) ;
 N IEN511 S IEN511=$P(^BPST(IEN59,1),U,13) Q:'IEN511
 N RETVAL S RETVAL=$$GET511^BPSOSO2(IEN511,"BPS(""OVERRIDE"")","BPS(""OVERRIDE"",""RX"","_MEDN_")")
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
 F  S DCNT=$O(^BPST(IEN59,13,DCNT)) Q:'+DCNT  D
 . S DURREC=$G(^BPST(IEN59,13,DCNT,0))
 . I DURREC="" Q
 . S DUR=DUR+1
 . S BPS("RX",MEDN,"DUR",DUR,473)=DUR  ;dur/pps cntr
 . S BPS("RX",MEDN,"DUR",DUR,439)=$P(DURREC,U,3) ;Reason Srv Cd
 . S BPS("RX",MEDN,"DUR",DUR,440)=$P(DURREC,U,2) ;Prof Srv Cd
 . S BPS("RX",MEDN,"DUR",DUR,441)=$P(DURREC,U,4) ;Result Src Cd
 . S BPS("RX",MEDN,"DUR",DUR,474)=""             ;Level of Effort
 . S BPS("RX",MEDN,"DUR",DUR,475)=""             ;Co-agent Qual
 . S BPS("RX",MEDN,"DUR",DUR,476)=""             ;Co-agent ID
 Q
 ;
COB(IEN59,MEDN) ; process the COB fields and build the COB array
 ;
 ; build array of COB secondary claim data from the BPS Transaction file - esg - 6/16/10
 N COBPIEN,APDIEN,REJIEN
 K BPS("RX",MEDN,"OTHER PAYER")
 ;
 ; Field 337-4C COB OTHER PAYMENTS COUNT (9002313.59,1204)  moved into [1] below
 S BPS("RX",MEDN,"OTHER PAYER",0)=$P($G(^BPST(IEN59,12)),U,4)
 ;
 S COBPIEN=0 F  S COBPIEN=$O(^BPST(IEN59,14,COBPIEN)) Q:'COBPIEN  D
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
 .. Q
 . Q
 ;
COBX ;
 Q
 ;
