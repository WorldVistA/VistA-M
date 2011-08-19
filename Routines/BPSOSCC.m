BPSOSCC ;BHAM ISC/FCS/DRS/DLF - Set up BPS() ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; GETINFO - Create BPS array for non-repeating data
 ;    IEN59  - Pointer to BPS Transactions
 ;    IEN5902 - IEN for Insurance multiple of BPS Transactions
 ;
 ; Note that the BPS array is shared by all of the BPSOSC* routines and
 ;  is newed by BPSOSCA
 ; Note that VAINFO is newed/set in BPSOSCB
 Q
GETINFO(IEN59,IEN5902) ; EP - BPSOSCB
 ; Check parameters
 N BPPAYSEQ
 S BPPAYSEQ=$$COB59^BPSUTIL2(IEN59)
 I $G(IEN59)="" Q
 I $G(IEN5902)="" Q
 ;
 ; New variables and parse parameter data
 N RXIEN,IENS,XDATA,PHARMACY,DFN,VAPA,VADM,SITE,NPI
 ;
 ; Setup Prescription IEN and IENS for transaction multiple
 S RXIEN=$P(IEN59,".",1)
 S IENS=IEN5902_","_IEN59_","
 ;
 ; Site Information
 S PHARMACY=$P(^BPST(IEN59,1),U,7)
 S XDATA=^BPS(9002313.56,PHARMACY,0)
 S BPS("Site","NABP #")=$P(XDATA,U,2)
 S BPS("Site","Default DEA #")=$P(XDATA,U,3)
 S BPS("Site","Medicaid Pharmacy #")="" ; Referenced in payer sheet special code
 S BPS("Site","Pharmacy #")=BPS("Site","NABP #")
 S SITE=$P($G(^BPST(IEN59,1)),U,4)
 S NPI=$$NPI^BPSNPI("Pharmacy_ID",SITE)
 I +NPI=-1 S NPI=""
 S BPS("Site","NPI")=$P(NPI,U,1)
 ;
 ; Transaction Header Data
 S BPS("NCPDP","IEN")=$G(VAINFO(9002313.59902,IENS,902.02,"I"))
 S BPS("NCPDP","BIN Number")=$G(VAINFO(9002313.59902,IENS,902.03,"I"))
 S BPS("NCPDP","PCN")=$G(VAINFO(9002313.59902,IENS,902.04,"I"))
 I BPS("NCPDP","IEN")="" D IMPOSS^BPSOSUE("P","TI","Payer Sheet pointer missing from multiple",,1,$T(+0))
 I BPS("NCPDP","IEN") S XDATA=$G(^BPSF(9002313.92,BPS("NCPDP","IEN"),1))
 I XDATA="" D IMPOSS^BPSOSUE("DB","TI","VA - Payer sheet info missing.",,2,$T(+0))
 I BPS("NCPDP","BIN Number")="" S BPS("NCPDP","BIN Number")=$P(XDATA,U,1)
 S BPS("NCPDP","Version")=$P(XDATA,U,2)
 S BPS("NCPDP","# Meds/Claim")=$P(XDATA,U,3)
 S BPS("NCPDP","Software Vendor/Cert ID")=$G(VAINFO(9002313.59902,IENS,902.18,"I"))
 ;
 ; Patient Data
 S DFN=$P(^BPST(IEN59,0),U,6)
 I 'DFN D IMPOSS^BPSOSUE("DB","TI","DFN",,,$T(+0))
 I DFN,'$D(^DPT(DFN,0)) D IMPOSS^BPSOSUE("DB","TI","^DPT(DFN)",,,$T(+0))
 D DEM^VADPT,ADD^VADPT
 S BPS("Patient","IEN")=DFN
 S BPS("Patient","Name")=$G(VADM(1))
 S BPS("Patient","Sex")=$P($G(VADM(5)),"^",1)
 S BPS("Patient","DOB")=$P($G(VADM(3)),"^",1)
 S BPS("Patient","DOB")=($E(BPS("Patient","DOB"),1,3)+1700)_$E(BPS("Patient","DOB"),4,7)
 S BPS("Patient","SSN")=$P($G(VADM(2)),"^",1)
 S BPS("Patient","State")=$P($G(VAPA(5)),"^",1)
 I BPS("Patient","State")'="" S BPS("Patient","State")=$P($G(^DIC(5,BPS("Patient","State"),0)),"^",2)
 S BPS("Patient","Street Address")=$G(VAPA(1))
 S BPS("Patient","City")=$G(VAPA(4))
 S BPS("Patient","Zip")=$G(VAPA(6))
 S BPS("Patient","Phone #")=$TR($P($G(VAPA(8)),"^",1),"()-/*# ")
 S BPS("Patient","Plan ID")=$$GET1^DIQ(2.312,"1,"_DFN_",",.18)
 ;
 ; Insurer Data
 S BPS("Insurer","IEN")=$G(VAINFO(9002313.59902,IENS,.01,"I"))
 S BPS("Insurer","Relationship")=$G(VAINFO(9002313.59902,IENS,902.07,"I"))
 S BPS("Insurer","Administrative Fee")=$G(VAINFO(9002313.59902,IENS,902.16,"I"))
 I BPS("Insurer","Administrative Fee")'="",BPS("Insurer","Administrative Fee")'=0 S BPS("Insurer","Other Amt Claim Sub Qual")="04"
 E  S BPS("Insurer","Other Amt Claim Sub Qual")=""
 I BPS("Insurer","Relationship")="" S BPS("Insurer","Relationship")=0 ;if not there, mark it as unspecified.
 S BPS("Patient","Primary Care Prov Location Code")=$G(VAINFO(9002313.59902,IENS,902.11,"I"))
 S BPS("Insurer","Person Code")=$S(BPS("Insurer","Relationship")=1:"01",BPS("Insurer","Relationship")=2:"02",BPS("Insurer","Relationship")=3:03,1:"")
 S BPS("Insurer","Group #")=$G(VAINFO(9002313.59902,IENS,902.05,"I"))
 S BPS("Insurer","Policy #")=$G(VAINFO(9002313.59902,IENS,902.06,"I"))  ;CARDHOLDER ID
 S BPS("Insurer","Full Policy #")=BPS("Insurer","Policy #")
 S:'$D(BPS("Insurer","Percent Sales Tax Rate Sub")) BPS("Insurer","Percent Sales Tax Rate Sub")=""
 S:'$D(BPS("Insurer","Percent Sales Tax Basis Sub")) BPS("Insurer","Percent Sales Tax Basis Sub")=""
 S BPS("Insurer","Percentage Sales Tax Amt Sub")=0
 S BPS("Insurer","Flat Sales Tax Amount Sub")=0
 ;
 ; DMB - The next pair of lines may seem odd.  However, there was an error in the IHS code, so
 ;   this array element was always set to "".  I fixed the code, but do not want to implement the fix
 ;   until it can be determined whether the fix will not cause rejects
 S BPS("Insurer","Facility ID")=$$RXAPI1^BPSUTIL1(RXIEN,5,"E")
 S BPS("Insurer","Facility ID")=""
 ;
 ; Cardholder Data
 S BPS("Cardholder","First Name")=$G(VAINFO(9002313.59902,IENS,902.08,"I"))
 S BPS("Cardholder","Last Name")=$G(VAINFO(9002313.59902,IENS,902.09,"I"))
 S BPS("Home Plan")=$G(VAINFO(9002313.59902,IENS,902.11,"I"))
 ;
 ;set additional fields for secondary claim
 I BPPAYSEQ>1 D
 . N BPSECDAT
 . S BPSECDAT=$G(^BPST(IEN59,12))
 . S BPS("Patient","Other Coverage Code")=$P(BPSECDAT,U,5) ;NCPDP field 308-C8
 . Q
 Q
 ;
