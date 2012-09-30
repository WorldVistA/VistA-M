BPSOSCC ;BHAM ISC/FCS/DRS/DLF - Set up BPS() ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,8,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; GETINFO - Create BPS array for non-repeating data
 ;    IEN59  - Pointer to BPS Transactions
 ;    IEN5902 - IEN for Insurance multiple of BPS Transactions
 ;
 ; BPS array is shared by all of the BPSOSC* routines, created in BPSOSCA
 ; VAINFO is created in BPSOSCB
 Q
 ;
GETINFO(IEN59,IEN5902) ; EP - BPSOSCB
 ; both parameters required
 Q:$G(IEN59)=""
 Q:$G(IEN5902)=""
 ;
 N BPPAYSEQ,DFN,IENS,NPI,SITE,VADM,VAPA,X
 ;
 S BPPAYSEQ=$$COB59^BPSUTIL2(IEN59)  ; COB payer sequence
 ; Setup IENS for transaction multiple
 S IENS=IEN5902_","_IEN59_","
 ; Site Information
 S SITE=$P($G(^BPST(IEN59,1)),U,4)
 S NPI=$$NPI^BPSNPI("Pharmacy_ID",SITE)
 I +NPI=-1 S NPI=""
 S BPS("Site","NPI")=$P(NPI,U)
 ;
 ; Get Transaction Code
 S BPS("Transaction Code")=$S($P($G(^BPST(IEN59,0)),U,15)="E":"E1",1:"B1")
 ;
 ; Transaction Header Data
 S BPS("NCPDP","IEN")=$G(VAINFO(9002313.59902,IENS,$S(BPS("Transaction Code")="E1":902.34,1:902.02),"I"))
 S BPS("NCPDP","BIN Number")=$G(VAINFO(9002313.59902,IENS,902.03,"I"))
 S BPS("NCPDP","PCN")=$G(VAINFO(9002313.59902,IENS,902.04,"I"))
 S BPS("NCPDP","Software Vendor/Cert ID")=$G(VAINFO(9002313.59902,IENS,902.18,"I"))
 I BPS("NCPDP","IEN")="" D IMPOSS^BPSOSUE("P","TI","Payer Sheet pointer missing from multiple",,1,$T(+0))
 I BPS("NCPDP","IEN") S BPS("NCPDP","Version")=$P($G(^BPSF(9002313.92,BPS("NCPDP","IEN"),1)),U,2)
 I $G(BPS("NCPDP","Version"))="" D IMPOSS^BPSOSUE("DB","TI","Payer sheet version missing.",,2,$T(+0))
 S BPS("NCPDP","# Meds/Claim")=$G(VAINFO(9002313.59902,IENS,902.32,"I"))
 I BPS("Transaction Code")="E1"!('BPS("NCPDP","# Meds/Claim")) S BPS("NCPDP","# Meds/Claim")=1
 S BPS("NCPDP","DOS")=$$FMTHL7^XLFDT($P($G(^BPST(IEN59,12)),U,2))
 ;
 ; Patient Data
 S DFN=$P(^BPST(IEN59,0),U,6)
 I 'DFN D IMPOSS^BPSOSUE("DB","TI","DFN",,,$T(+0))
 I DFN,'$D(^DPT(DFN,0)) D IMPOSS^BPSOSUE("DB","TI","^DPT(DFN)",,,$T(+0))
 D DEM^VADPT,ADD^VADPT
 S BPS("Patient","IEN")=DFN
 S (X,BPS("Patient","Name"))=$G(VADM(1))
 D NAMECOMP^XLFNAME(.X)
 S BPS("Patient","Last Name")=$G(X("FAMILY"))
 S BPS("Patient","First Name")=$G(X("GIVEN"))
 S BPS("Patient","Sex")=$P($G(VADM(5)),"^",1)
 S X=$P($G(VADM(3)),"^")  ; date of birth, FM format
 S BPS("Patient","DOB")=($E(X,1,3)+1700)_$E(X,4,7)
 S BPS("Patient","SSN")=$P($G(VADM(2)),"^",1)
 S BPS("Patient","State")=$P($G(VAPA(5)),"^",1)
 I BPS("Patient","State")'="" S BPS("Patient","State")=$P($G(^DIC(5,BPS("Patient","State"),0)),"^",2)
 S BPS("Patient","Street Address")=$G(VAPA(1))
 S BPS("Patient","City")=$G(VAPA(4))
 S BPS("Patient","Zip")=$G(VAPA(6))
 S BPS("Patient","Phone #")=$TR($P($G(VAPA(8)),"^",1),"()-/*# ")
 S BPS("Patient","Place of Service")=$S($G(BPS("NCPDP","Version"))=51:0,1:1)  ; NCPDP field 307-C7 default to 1 for vD.0
 S BPS("Patient","Patient Residence")=1  ; NCPDP field 384-4X, 1 for "Home"
 S BPS("Patient","Patient E-Mail Address")=$$GET1^DIQ(2,DFN,.133)  ; NCPDP field 350-HN
 ;
 ; Insurer Data
 S BPS("Insurer","IEN")=$G(VAINFO(9002313.59902,IENS,.01,"I"))
 S BPS("Patient","Primary Care Prov Location Code")=$G(VAINFO(9002313.59902,IENS,902.11,"I"))
 S BPS("Insurer","Relationship")=$G(VAINFO(9002313.59902,IENS,902.07,"I"))
 S:BPS("Insurer","Relationship")="" BPS("Insurer","Relationship")=0 ; if null set to unspecified
 S BPS("Insurer","Person Code")=$G(VAINFO(9002313.59902,IENS,902.1,"I"))
 ;
 ; If 303-C3 Person Code has no value from patient insurance policy field, then continue to 
 ; calculate the value based upon the 306-C6 Patient Relationship Code field
 I BPS("Insurer","Person Code")="" D
 . N REL S REL=BPS("Insurer","Relationship")
 . S BPS("Insurer","Person Code")=$S(REL=1:"01",REL=2:"02",REL=3:"03",1:"")
 . Q
 ;
 S BPS("Insurer","Plan ID")=$G(VAINFO(9002313.59902,IENS,902.24,"I"))
 S BPS("Insurer","Group #")=$G(VAINFO(9002313.59902,IENS,902.05,"I"))
 S BPS("Insurer","Policy #")=$G(VAINFO(9002313.59902,IENS,902.06,"I"))  ;CARDHOLDER ID
 S BPS("Insurer","Full Policy #")=BPS("Insurer","Policy #")
 S BPS("Insurer","Percent Sales Tax Rate Sub")=""  ; 483-HE Percentage Sales Tax Rate Submitted
 S BPS("Insurer","Percent Sales Tax Basis Sub")=""  ; 484-JE Percentage Sales Tax Basis Submitted
 S BPS("Insurer","Percentage Sales Tax Amt Sub")=0  ; 482-GE Percentage Sales Tax Amount Submitted
 S BPS("Insurer","Flat Sales Tax Amount Sub")=0  ; 481-HA Flat Sales Tax Amount Submitted
 ;
 ; Cardholder Data
 S BPS("Cardholder","First Name")=$G(VAINFO(9002313.59902,IENS,902.08,"I"))
 S BPS("Cardholder","Last Name")=$G(VAINFO(9002313.59902,IENS,902.09,"I"))
 S BPS("Home Plan")=$G(VAINFO(9002313.59902,IENS,902.11,"I"))
 ;
 ; set additional fields for secondary claim
 S:BPPAYSEQ>1 BPS("Patient","Other Coverage Code")=$P($G(^BPST(IEN59,12)),U,5)  ; NCPDP field 308-C8 Other Coverage Code
 ;
 Q
 ;
