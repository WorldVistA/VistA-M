IBCNETST ;DAOU/ALA - eIV Gate-keeper test scenarios ;11-OCT-2017
 ;;2.0;INTEGRATED BILLING;**601**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program contains some general utilities or functions
 ; IB*2*601/DM XMITOK() Gate-keeper routine moved from IBCNEUT7
 ;
 Q
 ;
XMITOK(TQIEN) ;EP
 ; Checks if the site is a test site (not a production site) and if so
 ; only allows transactions in the eIV queue that meet specific criteria
 ; to be transmitted to FSC. Prevents invalid transmissions from a test
 ; site to FSC which blocks the interface and need to be manually resolved
 ; at FSC.
 ; Input:   TQIEN   - IEN of the IIV Transmission Queue entry
 ; Returns: 1       - Ok to add item to the eIV queue
 ;          0       - Not ok to add item to the eIV queue
 N GOOD,GRPNUM,IBIEN,IBCNMPI,IENS,IVPIEN,MCARE,PATDOB,PATID,PATNM,PATSEX,PAYRNM,PIEN
 N SUBID,SUBNM,TSITE,XX
 S MCARE=$$GET1^DIQ(350.9,"1,",51.25,"E")    ; Medicare Payer Name
 S XX=$G(^IBCN(365.1,TQIEN,0))
 S (GRPNUM,PATID,SUBID,SUBNM)=""
 S DFN=$$GET1^DIQ(365.1,TQIEN_",",.02,"I")   ; Patient IEN                   
 S IBCNMPI=$$GET1^DIQ(2,DFN_",",991.01,"I")  ; Integration Control Number MPI
 S PIEN=$$GET1^DIQ(365.1,TQIEN_",",.03,"I")  ; Payer IEN
 S IBIEN=$$GET1^DIQ(365.1,TQIEN_",",.13,"I") ; Insurance multiple number
 ;
 ; If the insurance multiple is not in the transmission queue, get the
 ; following fields from the Insurance Verification Processor file
 I IBIEN="" D
 . S IVPIEN=$$GET1^DIQ(365.1,TQIEN_",",.05,"I") ; IVP file IEN
 . S GRPNUM=$$GET1^DIQ(355.33,IVPIEN_",",90.02) ; Group Plan Number
 . S PATID=$$GET1^DIQ(355.33,IVPIEN_",",62.01)  ; Group Plan Number
 . S SUBID=$$GET1^DIQ(355.33,IVPIEN_",",90.03)  ; Subscriber ID
 . S SUBNM=$$GET1^DIQ(355.33,IVPIEN_",",91.01)  ; Subscriber Name
 E  D
 . S IENS=IBIEN_","_DFN_","
 . S XX=$$GET1^DIQ(2.312,IENS,.18,"I")       ; IEN of the Group Plan
 . S GRPNUM=$$GET1^DIQ(355.3,XX_",",2.02)    ; Group Plan Number
 . S PATID=$$GET1^DIQ(2.312,IENS,5.01)       ; Patient ID
 . S SUBID=$$GET1^DIQ(2.312,IENS,1)          ; Subscriber ID
 . S SUBNM=$$GET1^DIQ(2.312,IENS,7.01)       ; Subscriber NM
 ;
 ; First check to see if the site is a test or a production site
 S TSITE=$S($$PROD^XUPROD(1):0,1:1)
 Q:'TSITE 1                                  ; Production site no checks done
 ;
 ; Quit if the Integration Control Number MPI is null - MUST be present
 Q:IBCNMPI="" 0
 ;
 I (SUBID="")!(SUBNM="") Q 0                 ; Key elements not defined
 S XX=$$GET1^DIQ(2,DFN_",",.03,"I")          ; Internal Patient DOB
 S PATDOB=$TR($$FMTE^XLFDT(XX,"7DZ"),"/","") ; YYYYMMDD format
 S PATSEX=$$GET1^DIQ(2,DFN_",",.02,"I")      ; Patient Sex
 S PATNM=$$GET1^DIQ(2,DFN_",",.01,"I")       ; Patient Name
 S PAYRNM=$$GET1^DIQ(365.12,PIEN_",",.01)    ; Payer Name
 S PAYRNM=$$UP^XLFSTR(PAYRNM)
 S GOOD=0
 ;
 I PAYRNM="CMS MBI ONLY" G MBI ; this is an MBI test 
 ;
 I PAYRNM="AETNA",GRPNUM="GRP NUM 13805",SUBID="111111AE" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,ACTIVE"
 . Q:PATDOB'="19220202"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="AETNA",GRPNUM="GRP NUM 13188",SUBID="111111FG" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,INACTIVE"
 . Q:PATDOB'="19480101"
 . Q:PATSEX'="F"
 . S GOOD=1
 ;
 I PAYRNM="CIGNA",GRPNUM="GRP NUM 5442",SUBID="012345678" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,AAAERROR"
 . Q:PATDOB'="19470211"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="AETNA",GRPNUM="AET1234",SUBID="W1234561111" D  Q:GOOD 1
 . Q:SUBNM'="IBINS,ACTIVE"                  ; Note this patient is male
 . Q:PATID'="W123452222"
 . Q:PATNM'="IBDEP,ACTIVE"
 . Q:PATDOB'="19900304"
 . Q:PATSEX'="F"                            ; Note this is subscriber's spouse
 . S GOOD=1
 ;
 I MCARE'="",PAYRNM=MCARE,SUBID="333113333A",SUBNM="IB,PATIENT" D  Q:GOOD 1
 . Q:PATDOB'="19350309"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I MCARE'="",PAYRNM=MCARE,SUBID="111223333A",SUBNM="IBSUB,TWOTRLRS" D  Q:GOOD 1
 . Q:PATDOB'="19550505"
 . Q:PATSEX'="M"
 . S GOOD=1
 ; 
 ; Added for testing "Stop trigger of EIV Response"
 I PAYRNM="AETNA",GRPNUM="GRP NUM 13805",SUBID="222222AE" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,CANNOTFIND"
 . Q:PATDOB'="19220707"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 ; Added for testing payers that begin with numeric values
 I PAYRNM="CIGNA",GRPNUM="GRP NUM 5442",SUBID="222222CI" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,ACTIVE"
 . Q:PATDOB'="19220202"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 Q 0
 ;
MBI ;
 ; IB*2*601//DM - MBI testing scenarios
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTONE"
 . Q:PATDOB'="19380311"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTTWO"
 . Q:PATDOB'="19381110"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTTHREE"
 . Q:PATDOB'="19470530"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTFOUR"
 . Q:PATDOB'="19500130"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,"   ;Q:SUBNM'="IB,MBIPATIENTFIVE"   ;** melanie needed request w/ missing first name to go to FSC at FSC's request
 . Q:PATDOB'="19500827"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTSIX"
 . Q:PATDOB'="19471022"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTSEVEN"
 . Q:PATDOB'="19490603"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTEIGHT"
 . Q:PATDOB'="19470921"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTNINE"
 . Q:PATDOB'="19430301"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTTEN"
 . Q:PATDOB'="19580129"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 Q 0
 ;
