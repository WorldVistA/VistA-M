IBCNETST ;DAOU/ALA - eIV Gate-keeper test scenarios ; 11-OCT-2017
 ;;2.0;INTEGRATED BILLING;**601,732,778,822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;This program serves as a gate-keeper to protect FSC from receiving unexpected
 ;transmissions from a test account via the electronic Insurance Verification
 ;interface. Unexpected transmission have been known to take down their test
 ;systems. DO NOT alter or remove this routine.
 ;
 ; IB*2*601/DM XMITOK() Gate-keeper routine moved from IBCNEUT7
 ; IB*2*732/TZ added Test patients for auto-update with no group number
 ; IB*2*732/CKB added Test patients for 'Blues'
 ; IB*2*778/DJW changed acceptable SUBSCRIBER ID for 2 of the scenarios
 ; IB*2*822/CKB added functionality for IBMEDICARE,xxx patients
 ;              added E1 tag for IBEONE,xxx patients (NCPDP E1 Transactions)
 ;              Fine tuned - dropped DOB and SEX check for most as FSC doesn't need it
 ;                           for subscriber 270s. Dependent 270s, only the SEX was removed
 ;
 ;
 ;******************
 ; Changes made after the release of IB*822
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
 ;
 N DFN,GOOD,GRPNUM,IBIEN,IBCNMPI,IENS,IVPIEN,MCARE,PATDOB,PATID,PATNM,PATSEX,PAYRNM,PIEN
 N SUBID,SUBNM,TSITE,XX
 ;
 ; First check to see if the site is a test or a production site
 S TSITE=$S($$PROD^XUPROD(1):0,1:1)
 Q:'TSITE 1                                  ; Production site no checks done
 ;Q 0 ;Don't send anything
 ;
 S MCARE=$$GET1^DIQ(350.9,"1,",51.25,"E")    ; Medicare Payer Name
 S (GRPNUM,PATID,SUBID,SUBNM)=""
 S DFN=$$GET1^DIQ(365.1,TQIEN_",",.02,"I")   ; Patient IEN
 S PATNM=$$GET1^DIQ(2,DFN_",",.01,"I")       ; Patient Name
 S IBCNMPI=$$GET1^DIQ(2,DFN_",",991.01,"I")  ; Integration Control Number MPI
 ; Quit if the Integration Control Number MPI is null - MUST be present
 Q:IBCNMPI="" 0
 ;
 ; If the patient name contains "EICD" they are test scenario's for the "EICD" process.
 I PATNM["EICD" Q 1
 I PATNM["IBMEDICARE" Q 1   ; Allow IBMEDICARE,xxx patients
 ;
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
 . ;Q:PATDOB'="19220202"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="AETNA",GRPNUM="GRP NUM 13188",SUBID="111111FG" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,INACTIVE"
 . ;Q:PATDOB'="19480101"
 . ;Q:PATSEX'="F"
 . S GOOD=1
 ;
 ; IB*778/DJW SUBID below is more generic
 I PAYRNM="CIGNA",GRPNUM="GRP NUM 5442",SUBID="87654321CI" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,AAAERROR"
 . ;Q:PATDOB'="19470211"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="AETNA",GRPNUM="AET1234",SUBID="W1234561111" D  Q:GOOD 1
 . Q:SUBNM'="IBINS,ACTIVE"                  ; Note this patient is male
 . Q:PATID'="W123452222"
 . Q:PATNM'="IBDEP,ACTIVE"
 . Q:PATDOB'="19900304"
 . ;Q:PATSEX'="F"                            ; Note this is subscriber's spouse
 . S GOOD=1
 ;
 I MCARE'="",PAYRNM=MCARE,SUBID="333113333A" D  Q:GOOD 1
 . Q:SUBNM'="IB,PATIENT"
 . ;Q:PATDOB'="19350309"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I MCARE'="",PAYRNM=MCARE,SUBID="111223333A" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,TWOTRLRS"
 . ;Q:PATDOB'="19550505"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ; 
 ; Added for testing "Stop trigger of EIV Response", FSC's initial response
 ; indicates no insurance identified therefore there are no policies to reverify
 ; automatically.
 I PAYRNM="AETNA",GRPNUM="GRP NUM 13805",SUBID="222222AE" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,CANNOTFIND"
 . ;Q:PATDOB'="19220707"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CIGNA",GRPNUM="GRP NUM 5442",SUBID="222222CI" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,ACTIVE"
 . ;Q:PATDOB'="19220202"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 ; IB*2*732/TAZ - Added Non-medicare patient scenario for auto-update, no group number
 I PAYRNM="CIGNA",GRPNUM="GRP NUM 5337",SUBID="555555NO" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,NOGROUPNUM"
 . ;Q:PATDOB'="19380311"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 ; IB*2*732/TAZ - Added Medicare patient scenario for auto-update, no group number
 ; IB*778/DJW SUBID below is more generic
 I PAYRNM="CMS",GRPNUM="PART A",SUBID="12345678ME" D  Q:GOOD 1
 . Q:SUBNM'="IB,MEDICARENOGRP"
 . ;Q:PATDOB'="19381110"
 . ;Q:PATSEX'="F"
 . S GOOD=1
 ;
 ; IB*2*732/CKB - Added patient scenario for 'Blues' testing
 I PAYRNM="BCBS OF COLORADO",GRPNUM="BLU1234",SUBID="COL98765" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,BLUECROSS WGRP"
 . ;Q:PATDOB'="19420826"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 ; IB*2*732/CKB - Added patient scenario for 'Blues' testing
 I PAYRNM="BCBS OF COLORADO",GRPNUM="BLU1234",SUBID="COL56789" D  Q:GOOD 1
 . Q:SUBNM'="IBSUB,BLUECROSS WOGRP"
 . ;Q:PATDOB'="19420101"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 Q 0
 ;
MBI ;
 ; IB*2*601//DM - MBI testing scenarios
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTONE"
 . ;Q:PATDOB'="19380311"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTTWO"
 . ;Q:PATDOB'="19381110"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTTHREE"
 . ;Q:PATDOB'="19470530"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTFOUR"
 . Q:PATDOB'="19500130"
 . Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTFIVE"
 . ;Q:PATDOB'="19500827"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTSIX"
 . ;Q:PATDOB'="19471022"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTSEVEN"
 . ;Q:PATDOB'="19490603"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTEIGHT"
 . ;Q:PATDOB'="19470921"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTNINE"
 . ;Q:PATDOB'="19430301"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 I PAYRNM="CMS MBI ONLY",SUBID="MBIrequest" D  Q:GOOD 1
 . Q:SUBNM'="IB,MBIPATIENTTEN"
 . ;Q:PATDOB'="19580129"
 . ;Q:PATSEX'="M"
 . S GOOD=1
 ;
 Q 0
 ;
E1(DFN,BPRIEN) ;IB*822/DG - added to handle NCPDP E1 test patients IBEONE,xxx
 N CLAIM,IBA,IBSDT,PATDOB,PATNM
 ;
 ; First check to see if the site is a test or a production site
 I '$S($$PROD^XUPROD(1):0,1:1) Q    ; Production site no overwriting the E1 BPS Response !!!
 ;
 S PATNM=$$GET1^DIQ(2,DFN_",",.01,"I")       ; Patient Name
 S IBA=$$GET1^DIQ(2,DFN_",",.03,"I")          ; Internal Patient DOB
 S PATDOB=$TR($$FMTE^XLFDT(IBA,"7DZ"),"/","") ; YYYYMMDD format
 S CLAIM=$P(^BPSR(BPRIEN,0),U),CLAIM=$P(^BPSC(CLAIM,0),U)
 S IBSDT=$TR($$FMTE^XLFDT(DT,"7Z"),"/","")  ; service date
 ;
 I PATNM="IBEONE,REJECT NCPDP" D  Q
 . ; Don't change zero node
 . K ^BPSR(BPRIEN,504),^BPSR(BPRIEN,1000),^BPSR(BPRIEN,"M")
 . ;
 . S ^BPSR(BPRIEN,100)="^D0^E1^^^^^^1"
 . S ^BPSR(BPRIEN,200)="1790743797     ^01"
 . S ^BPSR(BPRIEN,400)=IBSDT
 . S ^BPSR(BPRIEN,500)="R"
 . S ^BPSR(BPRIEN,504)="NC1-Could not receive the response from the clearinghouse. The connection failed."
 . S ^BPSR(BPRIEN,1000,0)="^9002313.0301A^1^1"
 . S ^BPSR(BPRIEN,1000,1,0)=1
 . S ^BPSR(BPRIEN,1000,1,110)="^R"
 . S ^BPSR(BPRIEN,1000,1,500)="R^^^^^^^^^1"
 . S ^BPSR(BPRIEN,1000,1,511,0)="^9002313.03511A^1^1"
 . S ^BPSR(BPRIEN,1000,1,511,1,0)="07"
 . S ^BPSR(BPRIEN,1000,1,511,"B","07",1)=""
 . S ^BPSR(BPRIEN,1000,"B",1,1)=""
 . S ^BPSR(BPRIEN,"M",0)="^^3^3^"_DT
 . S ^BPSR(BPRIEN,"M",1,0)=CLAIM_"D0E11R011790743797     "_DT_"\X1E\\X1C\AM20\X"
 . S ^BPSR(BPRIEN,"M",2,0)="1C\F4NC1-Could not receive the response from the clearing house. The connection "
 . S ^BPSR(BPRIEN,"M",3,0)="failed.\X1D\\X1E\\X1C\AM21\X1C\ANR\X1C\FA1\X1C\FBNN"
 ;
 I PATNM="IBEONE,REJECT NOTFOUND" D  Q
 . ; Don't change zero node
 . K ^BPSR(BPRIEN,504),^BPSR(BPRIEN,1000),^BPSR(BPRIEN,"M")
 . ;
 . S ^BPSR(BPRIEN,100)="^D0^E1^^^^^^1"
 . S ^BPSR(BPRIEN,200)="1295793248     ^01"
 . S ^BPSR(BPRIEN,400)=IBSDT
 . S ^BPSR(BPRIEN,500)="A"
 . S ^BPSR(BPRIEN,504)="ERX108Patient Not Found"
 . S ^BPSR(BPRIEN,1000,0)="^9002313.0301A^1^1"
 . S ^BPSR(BPRIEN,1000,1,0)=1
 . S ^BPSR(BPRIEN,1000,1,110)="^R"
 . S ^BPSR(BPRIEN,1000,1,500)="R^^^^^^^^^1"
 . S ^BPSR(BPRIEN,1000,1,511,0)="^9002313.03511A^1^1"
 . S ^BPSR(BPRIEN,1000,1,511,1,0)=65
 . S ^BPSR(BPRIEN,1000,1,511,"B",65,1)=""
 . S ^BPSR(BPRIEN,1000,"B",1,1)=""
 . S ^BPSR(BPRIEN,"M",0)="^^2^2^"_DT
 . S ^BPSR(BPRIEN,"M",1,0)=CLAIM_"D0E11A011295793248     "_DT_"\X1E\\X1C\AM20\X"
 . S ^BPSR(BPRIEN,"M",2,0)="1C\F4ERX108Patient Not Found\X1D\\X1E\\X1C\AM21\X1C\ANR\X1C\FA1\X1C\FB65"
 ;
 ;
 I PATNM="IBEONE,REJECT NOTCOVERED" D  Q
 . ; Don't change zero node
 . K ^BPSR(BPRIEN,504),^BPSR(BPRIEN,1000),^BPSR(BPRIEN,"M")
 . ;
 . S ^BPSR(BPRIEN,100)="^D0^E1^^^^^^1"
 . S ^BPSR(BPRIEN,200)="1295793248     ^01"
 . S ^BPSR(BPRIEN,400)=IBSDT
 . S ^BPSR(BPRIEN,500)="A"
 . S ^BPSR(BPRIEN,504)="ERX180Patient Found Coverage Not Active On Submitted Date of Service"
 . S ^BPSR(BPRIEN,1000,0)="^9002313.0301A^1^1"
 . S ^BPSR(BPRIEN,1000,1,0)=1
 . S ^BPSR(BPRIEN,1000,1,110)="^R"
 . S ^BPSR(BPRIEN,1000,1,500)="R^^^^^^^^^1"
 . S ^BPSR(BPRIEN,1000,1,511,0)="^9002313.03511A^1^1"
 . S ^BPSR(BPRIEN,1000,1,511,1,0)=85
 . S ^BPSR(BPRIEN,1000,1,511,"B",85,1)=""
 . S ^BPSR(BPRIEN,1000,"B",1,1)=""
 . S ^BPSR(BPRIEN,"M",0)="^^3^3^"_DT
 . S ^BPSR(BPRIEN,"M",1,0)=CLAIM_"D0E11A011295793248     "_DT_"\X1E\\X1C\AM20\X"
 . S ^BPSR(BPRIEN,"M",2,0)="1C\F4ERX180Patient Found Coverage Not Active On Submitted Date of Service\X1D\\"
 . S ^BPSR(BPRIEN,"M",3,0)="X1E\\X1C\AM21\X1C\ANR\X1C\FA1\X1C\FB85"
 ;
 ;
 I PATNM="IBEONE,REJECT MEDPARTD" D  Q
 . ; Don't change zero node
 . K ^BPSR(BPRIEN,504),^BPSR(BPRIEN,1000),^BPSR(BPRIEN,"M")
 . ;
 . S ^BPSR(BPRIEN,100)="^D0^E1^^^^^^1"
 . S ^BPSR(BPRIEN,200)="1295793248     ^01"
 . S ^BPSR(BPRIEN,400)=IBSDT
 . S ^BPSR(BPRIEN,500)="A"
 . S ^BPSR(BPRIEN,504)="ERX128: COMMERCIAL ELIGIBILITY PARTNER HAS INDICATED PRIMARY COVERAGE AS MEDICARE PART D"
 . S ^BPSR(BPRIEN,1000,0)="^9002313.0301A^1^1"
 . S ^BPSR(BPRIEN,1000,1,0)=1
 . S ^BPSR(BPRIEN,1000,1,110)="^A"
 . S ^BPSR(BPRIEN,1000,1,350)="^^^^1"
 . S ^BPSR(BPRIEN,1000,1,355.01,0)="^9002313.035501A^1^1"
 . S ^BPSR(BPRIEN,1000,1,355.01,1,0)="1^001^0^^^8009221557"
 . S ^BPSR(BPRIEN,1000,1,355.01,1,1)="01^03^610014^^089999943110^GA23BLE"
 . S ^BPSR(BPRIEN,1000,1,355.01,"B",1,1)=""
 . S ^BPSR(BPRIEN,1000,1,500)="A"
 . S ^BPSR(BPRIEN,1000,"B",1,1)=""
 . S ^BPSR(BPRIEN,"M",0)="^^5^5^"_DT
 . S ^BPSR(BPRIEN,"M",1,0)=CLAIM_"D0E11A011295793248     "_DT_"\X1E\\X1C\AM20\X"
 . S ^BPSR(BPRIEN,"M",2,0)="1C\F4ERX128: COMMERCIAL ELIGIBILITY PARTNER HAS INDICATED PRIMARY COVERAGE AS M"
 . S ^BPSR(BPRIEN,"M",3,0)="EDICARE PART D\X1E\\X1C\AM29\X1C\CAREJECT\X1C\CBIBEONE\X1C\C4"_PATDOB_"\X1D\\X1"
 . S ^BPSR(BPRIEN,"M",4,0)="E\\X1C\AM21\X1C\ANA\X1E\\X1C\AM28\X1C\NT1\X1C\5C01\X1C\6C03\X1C\7C610014\X1C\NU"
 . S ^BPSR(BPRIEN,"M",5,0)="089999943110\X1C\MJGA23BLE\X1C\UV001\X1C\UW0\X1C\UB8009221557"
 ;
 I PATNM="IBEONE,APPROVE TWO" D  Q
 . ; Don't change zero node
 . K ^BPSR(BPRIEN,504),^BPSR(BPRIEN,1000),^BPSR(BPRIEN,"M")
 . ;
 . S ^BPSR(BPRIEN,100)="^D0^E1^^^^^^1"
 . S ^BPSR(BPRIEN,200)="1295793248     ^01"
 . S ^BPSR(BPRIEN,400)=IBSDT
 . S ^BPSR(BPRIEN,500)="A"
 . S ^BPSR(BPRIEN,1000,0)="^9002313.0301A^1^1"
 . S ^BPSR(BPRIEN,1000,1,0)=1
 . S ^BPSR(BPRIEN,1000,1,110)="^A"
 . S ^BPSR(BPRIEN,1000,350)="^^^^2"
 . S ^BPSR(BPRIEN,1000,1,355.01,0)="^9002313.035501A^2^2"
 . S ^BPSR(BPRIEN,1000,1,355.01,1,0)="1^001^0^^^8008240898"
 . S ^BPSR(BPRIEN,1000,1,355.01,1,1)="01^03^003858^A4^00999930300^DODA"
 . S ^BPSR(BPRIEN,1000,1,355.01,2,0)="2^05^1^20151019^20391231^8004212342"
 . S ^BPSR(BPRIEN,1000,1,355.01,2,1)="02^03^610239^FEPRX^R6999992105^65006500"
 . S ^BPSR(BPRIEN,1000,1,355.01,"B",1,1)=""
 . S ^BPSR(BPRIEN,1000,1,355.01,"B",2,2)=""
 . S ^BPSR(BPRIEN,1000,1,500)="A"
 . S ^BPSR(BPRIEN,1000,"B",1,1)=""
 . S ^BPSR(BPRIEN,1000,"B",2,2)=""
 . S ^BPSR(BPRIEN,"M",0)="^^6^6^"_DT
 . S ^BPSR(BPRIEN,"M",1,0)=CLAIM_"D0E11A011295793248     "_DT_"\X1E\\X1C\AM29\X"
 . S ^BPSR(BPRIEN,"M",2,0)="1C\CAAPPROVE\X1C\CBIBEONE\X1C\C4"_PATDOB_"\X1D\\X1E\\X1C\AM21\X1C\ANA\X1E\\X1C\AM28\"
 . S ^BPSR(BPRIEN,"M",3,0)="X1C\NT2\X1C\5C01\X1C\6C03\X1C\7C003858\X1C\MHA4\X1C\NU00999930300\X1C\MJDODA\X1"
 . S ^BPSR(BPRIEN,"M",4,0)="C\UV001\X1C\UW0\X1C\UB8008240898\X1C\5C02\X1C\6C03\X1C\7C610239\X1C\MHFEPRX\X1C"
 . S ^BPSR(BPRIEN,"M",5,0)="\NUR6999992105\X1C\MJ65006500\X1C\UV05\X1C\UW0\X1C\UB8004212342\X1C\UX20151019\"
 . S ^BPSR(BPRIEN,"M",6,0)="X1C\UY20391231"
 ;
 I PATNM="IBEONE,APPROVE ONE" D  Q
 . ; Don't change zero node
 . K ^BPSR(BPRIEN,504),^BPSR(BPRIEN,1000),^BPSR(BPRIEN,"M")
 . ;
 . S ^BPSR(BPRIEN,100)="^D0^E1^^^^^^1"
 . S ^BPSR(BPRIEN,200)="1295793248     ^01"
 . S ^BPSR(BPRIEN,400)=IBSDT
 . S ^BPSR(BPRIEN,500)="A"
 . S ^BPSR(BPRIEN,1000,0)="^9002313.0301A^1^1"
 . S ^BPSR(BPRIEN,1000,1,0)=1
 . S ^BPSR(BPRIEN,1000,1,110)="^A"
 . S ^BPSR(BPRIEN,1000,1,350)="^^^^1"
 . S ^BPSR(BPRIEN,1000,1,355.01,0)="^9002313.035501A^1^1"
 . S ^BPSR(BPRIEN,1000,1,355.01,1,0)="1^00^0^20250101^20391231^8004212342"
 . S ^BPSR(BPRIEN,1000,1,355.01,1,1)="01^03^004336^ADV^8LM9999974300^RX4097"
 . S ^BPSR(BPRIEN,1000,1,355.01,"B",1,1)=""
 . S ^BPSR(BPRIEN,1000,1,500)="A"
 . S ^BPSR(BPRIEN,1000,"B",1,1)=""
 . S ^BPSR(BPRIEN,"M",0)="^^4^4^"_DT
 . S ^BPSR(BPRIEN,"M",1,0)=CLAIM_"D0E11A011295793248     "_DT_"\X1E\\X1C\AM29\X"
 . S ^BPSR(BPRIEN,"M",2,0)="1C\CAAPPROVE\X1C\CBIBEONE\X1C\C4"_PATDOB_"\X1D\\X1E\\X1C\AM21\X1C\ANA\X1E\\X1C\AM2"
 . S ^BPSR(BPRIEN,"M",3,0)="8\X1C\NT1\X1C\5C01\X1C\6C03\X1C\7C004336\X1C\MHADV\X1C\NU8LM9999974300\X1C\MJRX"
 . S ^BPSR(BPRIEN,"M",4,0)="4097\X1C\UV00\X1C\UW0\X1C\UB8004212342\X1C\UX20250101\X1C\UY20391231"
 ;
 Q
