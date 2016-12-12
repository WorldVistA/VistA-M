VPSRPC16  ;BPOIFO/EL,WOIFO/BT - Patient Demographic (continue);07/31/14 13:07
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4,14**;Jul 31, 2014;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #10035 - ^DPT( references       (Supported)
 ; #2462  - ^DGEN( reference       (Controlled Sub) 
 ; #2056  - DIQ call               (Supported)
 ; #3402  - PTSEC^DGSEC4 call      (Supported)
 ; #3403  - NOTICE^DGSEC4 call     (Supported)
 ; #3812  - GET^DGENA              (Controlled Subs)
 ; #2701  - MPIF001 call           (Supported)
 ; #10061 - VADPT call             (Supported)
 ; #10103 - XLFDT call             (Supported)
 ; #6098  - Read-Only access to ^DGMT(408.31,"C",DFN) and FIELD HARDSHIP (Controlled Sub)
 QUIT
 ;
GETDEM(VPSARR,DFN) ;given DFN, returns the patient demographics, insurance, and up-coming appointments.
 ; OUTPUT
 ;   VPSARR - passed in by reference; this is the output array to store patient demographics
 ; INPUT
 ;   DFN    - patient DFN (This value must be validated before calling this procedure)
 ;
 D DEM(.VPSARR,DFN) ; Store Patient Demographic Data
 D SENLOG(.VPSARR,DFN) ; Store Patient Sensitive Record File-38.1
 D ELIG(.VPSARR,DFN) ; Store Patient Eligibily
 ;D ENR(.VPSARR,DFN) ; Store Patient Enrollment
 N X,Y
 S X="",X=$O(^DGEN(27.11,"C",DFN,X),-1) Q:$G(X)=""
 S Y="",Y=$$GET1^DIQ(27.11,X_",",.04,"E")
 I $G(Y)'="" D SET(.VPSARR,27.11,DFN,".04",Y)
 D ADD(.VPSARR,DFN) ; Store Patient Address
 D OAD(.VPSARR,DFN) ; Store Other Patient Variables
 D INP(.VPSARR,DFN) ; Inpatient information
 D IBB^VPSRPC26(.VPSARR,DFN) ; Store Patient Insurance Info
 D REC^VPSRPC26(.VPSARR,DFN) ; Store Patient Record Flag
 D DGS^VPSRPC26(.VPSARR,DFN) ; Store Pre-Registration Audit
 D BAL^VPSRPC26(.VPSARR,DFN) ; Store Balance
 ;D OTH^VPSRPC26(.VPSARR,DFN) ; Store Other information not in KNOWN API
 ;D POW^VPSRPC26(.VPSARR,DFN) ; Store POW
 ;D PH^VPSRPC26(.VPSARR,DFN) ; Store Purple Heart
 ;D MP^VPSRPC26(.VPSARR,DFN) ; Store Missing Person
 ;D SVC^VPSRPC26(.VPSARR,DFN) ; Store Service Connected and Rated Disabilities
 ;D CHG^VPSRPC26(.VPSARR,DFN) ; Store Change DT/TM
 ;D BLPAT^VPSRPC26(.VPSARR,DFN) ; Store Billing Patient
 ;D PCT^VPSRPC26(.VPSARR,DFN) ; Primary Care Team
 Q
 ;
DEM(VPSARR,DFN) ; Store Patient Demographic Data
 ; -- Store patient DFN
 D SET(.VPSARR,2,DFN,".001",DFN,"DFN")
 ;
 ; -- Store Patient ICN if exist
 N VPSICN S VPSICN=$$GETICN^MPIF001(DFN)
 N ICN S ICN=$P(VPSICN,"V")
 I $G(ICN)'="" D SET(.VPSARR,2,DFN,"991.01",ICN)
 ;
 ; -- Retrieve patient demographics data
 N VADM D DEM^VADPT
 ;
 ; -- Store patient demographics
 N VAL
 S VAL=$G(VADM(1)) D SET(.VPSARR,2,DFN,".01",VAL) ; patient name
 S VAL=$P($G(VADM(2)),U) D SET(.VPSARR,2,DFN,".09",VAL) ; SSN
 S VAL=$P($G(VADM(3)),U) D SET(.VPSARR,2,DFN,".03",VAL) ; DOB - kiosk needs internal (FM) format for all dates
 S VAL=$P($G(VADM(5)),U,2) D SET(.VPSARR,2,DFN,".02",VAL) ; SEX
 S VAL=$P($G(VADM(9)),U,2) D SET(.VPSARR,2,DFN,".08",VAL)
 S VAL=$P($G(VADM(10)),U,2) D SET(.VPSARR,2,DFN,".05",VAL)
 ;
 ; -- Store patient ethnicity
 N SEQ,VPSFL,VPSIEN
 ;
 I $G(VADM(11))'="" D
 . N VPSFL S VPSFL="2.06",SEQ=""
 . F  S SEQ=$O(VADM(11,SEQ)) QUIT:SEQ=""  D
 . . S VAL=$P(VADM(11,SEQ),U,2)
 . . S VPSIEN=DFN_";"_SEQ D SET(.VPSARR,VPSFL,VPSIEN,".01",VAL)
 ;
 ; -- Store patient race
 I $G(VADM(12))'="" D
 . S VPSFL="2.02",SEQ=""
 . F  S SEQ=$O(VADM(12,SEQ)) QUIT:SEQ=""  D
 . . S VAL=$P(VADM(12,SEQ),U,2)
 . . S VPSIEN=DFN_";"_SEQ D SET(.VPSARR,VPSFL,VPSIEN,".01",VAL)
 ;
 QUIT
 ;
SENLOG(VPSARR,DFN) ; Check Patient Sensitive Record File-38.1
 N DGRES
 N VAL S VAL=""
 N DGOPT S DGOPT=U_"VPS KIOSK-PATIENT-SELF-CHECKIN"
 N DGMSG S DGMSG=1
 D PTSEC^DGSEC4(.DGRES,DFN,DGMSG,DGOPT)
 N RES S RES=$G(DGRES(1))
 ;
 I RES=2 D  QUIT
 . N ACTION S ACTION=1
 . D NOTICE^DGSEC4(.DGRES,DFN,DGOPT,ACTION)
 . S VAL="2;SENSITIVE & SEC-AUDIT LOG & KIOSK MACHINE LOGIN-DUZ HOLDING NOSECURITY KEY"
 . D SET(.VPSARR,38.1,DFN,"IA3403",VAL,"SENSITIVE")
 ;
 S:RES=0 VAL="0;NON-SENSITIVE"
 S:RES=1 VAL="1;SENSITIVE & SEC-AUDIT LOG & KIOSK MACHINE LOGIN-DUZ HOLDING SECURITY KEY"
 S:RES=3 VAL="3;CANNOT CHECK SENSITIVE DUE TO KIOSK MACHINE LOGIN-DUZ ACCESSING OWN RECORD"
 S:RES=4 VAL="4;CANNOT CHECK SENSITIVE DUE TO KIOSK MACHINE LOGIN-DUZ MISSING SSN"
 S:VAL="" VAL="-1;MISSING DFN IN SENSITIVE CHECK"
 D SET(.VPSARR,38.1,DFN,"IA3402",VAL,"SENSITIVE")
 ;
 QUIT
 ;
ELIG(VPSARR,DFN) ; Eligibily
 N VAEL D ELIG^VADPT
 N VAL
 S VAL=$P($G(VAEL(6)),U,2) D SET(.VPSARR,2,DFN,391,VAL) ; Patient Type
 S VAL=$$GET1^DIQ(2,DFN_",",.381,"E") D SET(.VPSARR,2,DFN,.381,VAL) ;Eligibility for Medicare
 ;
 ; --- Primary Eligibility Code
 N PELIG S PELIG=$P($G(VAEL(1)),U)
 S VAL=$P($G(VAEL(1)),U,2) D SET(.VPSARR,2,DFN,.361,VAL)
 ;
 S VAL=$P($G(VAEL(5,1)),U) D SET(.VPSARR,2,DFN,.152,VAL) ;InEligible Date
 S VAL=$P($G(VAEL(8)),U,2) D SET(.VPSARR,2,DFN,.3611,VAL) ;Eligibility Status
 S VAL=$$GET1^DIQ(2,DFN_",",.3612,"I") D SET(.VPSARR,2,DFN,.3612,VAL) ; Eligibility Status Date
 S VAL=$P($G(VAEL(9)),U,2) D SET(.VPSARR,2,DFN,.14,VAL) ; Means Test Status
 ;
 ; --- Secondary Eligibility codes
 N ELIG,ELIGNAM S ELIG=0
 F  S ELIG=$O(^DPT("AEL",DFN,ELIG)) Q:'ELIG  D
 . I ELIG'=PELIG S ELIGNAM=$$GET1^DIQ(8,ELIG_",",.01) D SET(.VPSARR,8,DFN_";"_ELIG,.01,ELIGNAM,"SECONDARY ELIGIBILITY CODE")
 ;
 ; --- Annual Mean Test
 N MTIEN S MTIEN=$O(^DGMT(408.31,"C",DFN,0))
 I MTIEN S VAL=$$GET1^DIQ(408.31,MTIEN_",",.2,"E") D SET(.VPSARR,408.31,DFN_";"_MTIEN,.2,VAL) ; HARDSHIP?
 QUIT
 ;
INP(VPSARR,DFN) ;
 N VAIP
 D IN5^VADPT
 D SET(.VPSARR,2,DFN,"",$S(VAIP(5)]"":"YES",1:"NO"),"INPATIENT STATUS") ; Inpatient Status
 D SET(.VPSARR,2,DFN,.1,$P(VAIP(5),U,2),"") ; Patient Ward Location
 D SET(.VPSARR,2,DFN,.101,$P(VAIP(6),U,2),"") ; Patient Bed Assignment
 D SET(.VPSARR,2,DFN,.109,$P(VAIP(19,1),U,2),"") ; Facility Directory Preference
 QUIT
 ;
ENR(VPSARR,DFN) ; Enrollment
 N ENRIEN S ENRIEN=$O(^DGEN(27.11,"C",DFN,""),-1)
 QUIT:ENRIEN=""
 N DGENR D GET^DGENA(ENRIEN,.DGENR)
 N VAL
 S VAL=$G(DGENR("STATUS")),VAL=$$GET1^DIQ(27.11,ENRIEN_",",.04,"E") D SET(.VPSARR,27.11,DFN_";"_ENRIEN,.04,VAL) ;ENROLLMENT STATUS
 S VAL=$G(DGENR("ELIG","CODE")),VAL=$$GET1^DIQ(27.11,ENRIEN_",",50.01,"E") D SET(.VPSARR,27.11,DFN_";"_ENRIEN,50.01,VAL) ;ELIGIBILITY CODE
 S VAL=$G(DGENR("ELIG","SC")) D SET(.VPSARR,27.11,DFN_";"_ENRIEN,50.02,VAL) ;SERVICE CONNECTED
 S VAL=$G(DGENR("ELIG","SCPER")) D SET(.VPSARR,27.11,DFN_";"_ENRIEN,50.03,VAL) ;SERVICE CONNECTED PERCENTAGE
 S VAL=$G(DGENR("DATE")) D SET(.VPSARR,27.11,DFN_";"_ENRIEN,.1,VAL) ;ENROLLMENT DATE
 S VAL=$G(DGENR("EFFDATE")) D SET(.VPSARR,27.11,DFN_";"_ENRIEN,.08,VAL) ;EFFECTIVE DATE
 S VAL=$G(DGENR("PRIORITY")) D SET(.VPSARR,27.11,DFN_";"_ENRIEN,.07,VAL) ;ENROLLMENT PRIORITY
 S VAL=$G(DGENR("ELIG","EC")) D SET(.VPSARR,27.11,DFN_";"_ENRIEN,50.13,VAL) ;SOUTH WEST ASIA CONDITION
 ;
 ; -- Enrollment Clinic
 N ENRCLN,ENRDATE,VAL
 N ECLNSEQ S ECLNSEQ=0
 N EDTSEQ S EDTSEQ=0
 ;
 F  S ECLNSEQ=$O(^DPT(DFN,"DE",ECLNSEQ)) QUIT:'ECLNSEQ  D
 . S ENRCLN=$G(^DPT(DFN,"DE",ECLNSEQ,0)) QUIT:ENRCLN=""
 . S VAL=$$GET1^DIQ(2.001,ECLNSEQ_","_DFN_",",.01,"E") ; enrollment clinic
 . D SET(.VPSARR,2.001,DFN_";"_ECLNSEQ,.01,VAL)
 . N VAL S VAL=$$GET1^DIQ(2.001,ECLNSEQ_","_DFN_",",2,"E") ; current status
 . D SET(.VPSARR,2.001,DFN_";"_ECLNSEQ,2,VAL)
 . ;
 . ; -- Enrollment Data
 . S EDTSEQ=0
 . F  S EDTSEQ=$O(^DPT(DFN,"DE",ECLNSEQ,1,EDTSEQ)) Q:'EDTSEQ  D
 . . S ENRDATE=$G(^DPT(DFN,"DE",ECLNSEQ,1,EDTSEQ,0)) QUIT:ENRDATE=""
 . . S VAL=$$GET1^DIQ(2.011,EDTSEQ_","_ECLNSEQ_","_DFN_",",.01,"I") ; Date of Enrollment
 . . D SET(.VPSARR,2.011,DFN_";"_ECLNSEQ_";"_EDTSEQ,.01,VAL)
 . . S VAL=$$GET1^DIQ(2.011,EDTSEQ_","_ECLNSEQ_","_DFN_",",1,"E") ; opt or ac
 . . D SET(.VPSARR,2.011,DFN_";"_ECLNSEQ_";"_EDTSEQ,1,VAL)
 . . S VAL=$$GET1^DIQ(2.011,EDTSEQ_","_ECLNSEQ_","_DFN_",",2,"E") ; Service
 . . D SET(.VPSARR,2.011,DFN_";"_ECLNSEQ_";"_EDTSEQ,2,VAL)
 . . S VAL=$$GET1^DIQ(2.011,EDTSEQ_","_ECLNSEQ_","_DFN_",",3,"I") ; Date of Discharge
 . . D SET(.VPSARR,2.011,DFN_";"_ECLNSEQ_";"_EDTSEQ,3,VAL)
 . . S VAL=$$GET1^DIQ(2.011,EDTSEQ_","_ECLNSEQ_","_DFN_",",4,"E") ; Reason of Discharge
 . . D SET(.VPSARR,2.011,DFN_";"_ECLNSEQ_";"_EDTSEQ,4,VAL)
 . . S VAL=$$GET1^DIQ(2.011,EDTSEQ_","_ECLNSEQ_","_DFN_",",5,"I") ; Review Date
 . . D SET(.VPSARR,2.011,DFN_";"_ECLNSEQ_";"_EDTSEQ,5,VAL)
 ;
 QUIT
 ;
ADD(VPSARR,DFN) ; Addresses
 N VAPA D ADD^VADPT
 N VAL,TODAY S TODAY=$$DT^XLFDT()
 ;
 S VAL=$P($G(VAPA(9)),U)
 I VAL=""!(TODAY<VAL) D SETPERM(.VPSARR,DFN,.VAPA) QUIT
 ;
 S VAL=$P($G(VAPA(10)),U)
 I VAL=""!(TODAY'>VAL) D SETMP(.VPSARR,DFN,.VAPA) QUIT
 ;
 D SETPERM(.VPSARR,DFN,.VAPA)
 QUIT
 ;
SETPERM(VPSARR,DFN,VAPA) ;  PERM ADDRESS
 N VAL
 S VAL=$G(VAPA(1)) D SET(.VPSARR,2,DFN,".111",VAL)
 S VAL=$G(VAPA(2)) D SET(.VPSARR,2,DFN,".112",VAL)
 S VAL=$G(VAPA(3)) D SET(.VPSARR,2,DFN,".113",VAL)
 S VAL=$G(VAPA(4)) D SET(.VPSARR,2,DFN,".114",VAL)
 S VAL=$P($G(VAPA(5)),U,2) D SET(.VPSARR,2,DFN,".115",VAL)
 S VAL=$P($G(VAPA(7)),U,2) D SET(.VPSARR,2,DFN,".117",VAL)
 S VAL=$G(VAPA(8)) D SET(.VPSARR,2,DFN,".131",VAL)
 S VAL=$P($G(VAPA(11)),U,2) D SET(.VPSARR,2,DFN,".1112",VAL)
 S VAL=$P($G(VAPA(25)),U,2) D SET(.VPSARR,2,DFN,".1173",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.1171,"E") D SET(.VPSARR,2,DFN,".1171",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.1172,"E") D SET(.VPSARR,2,DFN,".1172",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.121,"E") D SET(.VPSARR,2,DFN,".121",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.132,"E") D SET(.VPSARR,2,DFN,".132",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.134,"E") D SET(.VPSARR,2,DFN,".134",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.133,"E") D SET(.VPSARR,2,DFN,".133",VAL)
 D SETCONF(.VPSARR,DFN,.VAPA)
 QUIT
 ;
SETMP(VPSARR,DFN,VAPA) ; SET TEMP ADD
 N VAL
 S VAL=$G(VAPA(1)) D SET(.VPSARR,2,DFN,".1211",VAL)
 S VAL=$G(VAPA(2)) D SET(.VPSARR,2,DFN,".1212",VAL)
 S VAL=$G(VAPA(3)) D SET(.VPSARR,2,DFN,".1213",VAL)
 S VAL=$G(VAPA(4)) D SET(.VPSARR,2,DFN,".1214",VAL)
 S VAL=$P($G(VAPA(5)),U,2) D SET(.VPSARR,2,DFN,".1215",VAL)
 S VAL=$P($G(VAPA(7)),U,2) D SET(.VPSARR,2,DFN,".12111",VAL)
 S VAL=$G(VAPA(8)) D SET(.VPSARR,2,DFN,".1219",VAL)
 S VAL=$P($G(VAPA(9)),U,2) D SET(.VPSARR,2,DFN,".1217",VAL)
 S VAL=$P($G(VAPA(10)),U,2) D SET(.VPSARR,2,DFN,".1218",VAL)
 S VAL=$P($G(VAPA(11)),U,2) D SET(.VPSARR,2,DFN,".12112",VAL)
 S VAL=$P($G(VAPA(25)),U,2) D SET(.VPSARR,2,DFN,".1223",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.1221,"E") D SET(.VPSARR,2,DFN,".1221",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.1222,"E") D SET(.VPSARR,2,DFN,".1222",VAL)
 ;
 K VAPA S VAPA("P")="" D ADD^VADPT
 D SETPERM(.VPSARR,DFN,.VAPA)
 ;
 QUIT
 ;
SETCONF(VPSARR,DFN,VAPA) ;Confindential address
 N VAL
 S VAL=$G(VAPA(13)) D SET(.VPSARR,2,DFN,".1411",VAL) ; CONFIDENTIAL STREET [LINE 1]
 S VAL=$G(VAPA(14)) D SET(.VPSARR,2,DFN,".1412",VAL) ; CONFIDENTIAL STREET [LINE 2]
 S VAL=$G(VAPA(15)) D SET(.VPSARR,2,DFN,".1413",VAL) ; CONFIDENTIAL STREET [LINE 2]
 S VAL=$G(VAPA(16)) D SET(.VPSARR,2,DFN,".1414",VAL) ; CONFIDENTIAL ADDRESS CITY
 S VAL=$G(VAPA(17)) S VAL=$P(VAL,U,2) D SET(.VPSARR,2,DFN,".1415",VAL) ; CONFIDENTIAL ADDRESS STATE
 S VAL=$G(VAPA(18)) S VAL=$P(VAL,U,2) D SET(.VPSARR,2,DFN,".1416",VAL) ; CONFIDENTIAL ADDRESS ZIP CODE
 S VAL=$G(VAPA(19)) D SET(.VPSARR,2,DFN,".14111",VAL) ; CONFIDENTIAL ADDRESS COUNTY
 S VAL=$G(VAPA(20)) I +VAL D SET(.VPSARR,2,DFN,".1417",+VAL) ; CONFIDENTIAL START DATE
 S VAL=$G(VAPA(21)) I +VAL D SET(.VPSARR,2,DFN,".1418",+VAL) ; CONFIDENTIAL END DATE
 S VAL=$$GET1^DIQ(2,DFN_",",.14105,"E") D SET(.VPSARR,2,DFN,".14105",VAL) ; CONFIDENTIAL ADDRESS ACTIVE?
 S VAL=$P($G(VAPA(28)),U,2) D SET(.VPSARR,2,DFN,".14116",VAL) ; CONFIDENTIAL ADDRESS COUNTRY
 S VAL=$G(VAPA(29)) D SET(.VPSARR,2,DFN,".1315",VAL) ; CONFIDENTIAL PHONE NUMBER
 ;
 ; -- Confidential Address categories
 N TYP S TYP=0
 F  S TYP=$O(VAPA(22,TYP)) Q:'TYP  D
 . S VAL=$P(VAPA(22,TYP),U,2)
 . D SET(.VPSARR,2.141,DFN_";"_TYP,".01",VAL) ; CONFIDENTIAL ADDRESS CATEGORY
 ;
 QUIT
 ;
OAD(VPSARR,DFN) ; Other Patient Variables
 N VAL,VAOA S VAOA("A")=7 D OAD^VADPT    ; NOK
 S VAL=$G(VAOA(1)) D SET(.VPSARR,2,DFN,".213",VAL)
 S VAL=$G(VAOA(2)) D SET(.VPSARR,2,DFN,".214",VAL)
 S VAL=$G(VAOA(3)) D SET(.VPSARR,2,DFN,".215",VAL)
 S VAL=$G(VAOA(4)) D SET(.VPSARR,2,DFN,".216",VAL)
 S VAL=$P(VAOA(5),U,2) D SET(.VPSARR,2,DFN,".217",VAL)
 S VAL=$G(VAOA(11)) S VAL=$P(VAL,U,2) D SET(.VPSARR,2,DFN,".2207",VAL)
 S VAL=$G(VAOA(8)) D SET(.VPSARR,2,DFN,".219",VAL)
 S VAL=$G(VAOA(9)) D SET(.VPSARR,2,DFN,".211",VAL)
 S VAL=$G(VAOA(10)) D SET(.VPSARR,2,DFN,".212",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.21011,"E") D SET(.VPSARR,2,DFN,".21011",VAL)
 ;
 K VAOA S VAOA("A")=3 D OAD^VADPT    ; Second NOK
 S VAL=$G(VAOA(1)) D SET(.VPSARR,2,DFN,".2193",VAL)
 S VAL=$G(VAOA(2)) D SET(.VPSARR,2,DFN,".2194",VAL)
 S VAL=$G(VAOA(3)) D SET(.VPSARR,2,DFN,".2195",VAL)
 S VAL=$G(VAOA(4)) D SET(.VPSARR,2,DFN,".2196",VAL)
 S VAL=$P($G(VAOA(5)),U,2) D SET(.VPSARR,2,DFN,".2197",VAL)
 S VAL=$G(VAOA(11)) S VAL=$P(VAL,U,2) D SET(.VPSARR,2,DFN,".2203",VAL)
 S VAL=$G(VAOA(8)) D SET(.VPSARR,2,DFN,".2199",VAL)
 S VAL=$G(VAOA(9)) D SET(.VPSARR,2,DFN,".2191",VAL)
 S VAL=$G(VAOA(10)) D SET(.VPSARR,2,DFN,".2192",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.211011,"E") D SET(.VPSARR,2,DFN,".211011",VAL)
 ;
 K VAOA S VAOA("A")=1 D OAD^VADPT    ; Emergency Contact
 S VAL=$G(VAOA(1)) D SET(.VPSARR,2,DFN,".333",VAL)
 S VAL=$G(VAOA(2)) D SET(.VPSARR,2,DFN,".334",VAL)
 S VAL=$G(VAOA(3)) D SET(.VPSARR,2,DFN,".335",VAL)
 S VAL=$G(VAOA(4)) D SET(.VPSARR,2,DFN,".336",VAL)
 S VAL=$P($G(VAOA(5)),U,2) D SET(.VPSARR,2,DFN,".337",VAL)
 S VAL=$P($G(VAOA(11)),U,2) D SET(.VPSARR,2,DFN,".2201",VAL)
 S VAL=$G(VAOA(8)) D SET(.VPSARR,2,DFN,".339",VAL)
 S VAL=$G(VAOA(9)) D SET(.VPSARR,2,DFN,".331",VAL)
 S VAL=$G(VAOA(10)) D SET(.VPSARR,2,DFN,".332",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.33011,"E") D SET(.VPSARR,2,DFN,".33011",VAL)
 ;
 K VAOA S VAOA("A")=4 D OAD^VADPT    ; Second Emergency Contact
 S VAL=$G(VAOA(1)) D SET(.VPSARR,2,DFN,".3313",VAL)
 S VAL=$G(VAOA(2)) D SET(.VPSARR,2,DFN,".3314",VAL)
 S VAL=$G(VAOA(3)) D SET(.VPSARR,2,DFN,".3315",VAL)
 S VAL=$G(VAOA(4)) D SET(.VPSARR,2,DFN,".3316",VAL)
 S VAL=$P($G(VAOA(5)),U,2) D SET(.VPSARR,2,DFN,".3317",VAL)
 S VAL=$P($G(VAOA(11)),U,2) D SET(.VPSARR,2,DFN,".2204",VAL)
 S VAL=$G(VAOA(8)) D SET(.VPSARR,2,DFN,".3319",VAL)
 S VAL=$G(VAOA(9)) D SET(.VPSARR,2,DFN,".3311",VAL)
 S VAL=$G(VAOA(10)) D SET(.VPSARR,2,DFN,".3312",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.331011,"E") D SET(.VPSARR,2,DFN,".331011",VAL)
 ;
 K VAOA S VAOA("A")=5 D OAD^VADPT    ; Patient Employer
 S VAL=$G(VAOA(8)) D SET(.VPSARR,2,DFN,".3119",VAL)
 S VAL=$G(VAOA(9)) D SET(.VPSARR,2,DFN,".3111",VAL)
 ;
 N VAPD D OPD^VADPT
 S VAL=$P($G(VAPD(7)),U,2) D SET(.VPSARR,2,DFN,".31115",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.31116,"E") D SET(.VPSARR,2,DFN,".31116",VAL)
 ;
 K VAOA S VAOA("A")=6 D OAD^VADPT    ; Spouse's Employer
 S VAL=$G(VAOA(8)) D SET(.VPSARR,2,DFN,".258",VAL)
 S VAL=$G(VAOA(9)) D SET(.VPSARR,2,DFN,".251",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.2515,"E") D SET(.VPSARR,2,DFN,".2515",VAL)
 S VAL=$$GET1^DIQ(2,DFN_",",.2516,"E") D SET(.VPSARR,2,DFN,".2516",VAL)
 ;
 QUIT
 ;
SET(VPSARR,VPSFL,VPSIEN,VPSFLD,VPSDA,VPSDS) ;Set line item to output array
 I VPSDA'="" D SET^VPSRPC1(.VPSARR,VPSFL,VPSIEN,VPSFLD,VPSDA,$G(VPSDS),6) ;Set line item to output array
 QUIT