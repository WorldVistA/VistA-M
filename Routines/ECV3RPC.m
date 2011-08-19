ECV3RPC ;ALB/ACS;Event Capture Spreadsheet Data Validation ;Oct 13, 2000
 ;;2.0; EVENT CAPTURE ;**25,47,49,61,72**;8 May 96
 ;
 ;-----------------------------------------------------------------------
 ;  Validates the following Event Capture Spreadsheet Upload fields:
 ;    1. DSS UNIT IEN, DSS UNIT NUMBER, DSS UNIT NAME
 ;    2. ORDERING SECTION
 ;    3. PROCEDURE CODE
 ;    4. CATEGORY
 ;
 ;-----------------------------------------------------------------------
 ;
 ;--Set up error flag
 S ECERRFLG=0
 ;
 ;--GET DSS Unit IEN--
 S ECDSSIEN=""
 ; -Check for DSS Unit IEN first
 I ECUNITV'="",(ECUNITV'=+ECUNITV) D
 . S ECERRMSG=$P($T(DSS1^ECV3RPC),";;",2)
 . S ECCOLERR=ECUNITPC
 . D ERROR
 I ECUNITV,'ECERRFLG,$D(^ECD(ECUNITV,0)) S ECDSSIEN=ECUNITV
 I ECUNITV,'ECERRFLG,'$D(^ECD(ECUNITV,0)) D
 . ; DSS unit ien not found on VistA
 . S ECERRMSG=$P($T(DSS1^ECV3RPC),";;",2)
 . S ECCOLERR=ECUNITPC
 . D ERROR
 . Q
 ; -Check for DSS Unit Number
 I ECDCMV'="",'$D(^ECD("C",ECDCMV)) D
 . ; DSS Unit Number not found on VistA
 . S ECERRMSG=$P($T(DSS2^ECV3RPC),";;",2)
 . S ECCOLERR=ECDCMPC
 . D ERROR
 I 'ECERRFLG,ECDCMV'="",$D(^ECD("C",ECDCMV)) S ECDSSIEN=$O(^ECD("C",ECDCMV,0))
 ;Check if the next record is a match
 I 'ECERRFLG,'ECDSSIEN,ECDCMV'="",$D(^ECD("C",ECDCMV)) D
 . S ECDSSIEN=$O(^ECD("C",ECDCMV,0))
 . I '$D(^ECD("C",ECDCMV)) D
 . . ; DSS Unit Number not found on VistA
 . . S ECERRMSG=$P($T(DSS2^ECV3RPC),";;",2)
 . . S ECCOLERR=ECDCMPC
 . . D ERROR
 . . Q
 ; -Check for DSS Unit Name
 I ECDSSV'="",'$D(^ECD("B",ECDSSV)) D
 . S ECERRMSG=$P($T(DSS3^ECV3RPC),";;",2)
 . S ECCOLERR=ECDSSPC
 . D ERROR
 ; 
 I 'ECERRFLG,'ECDSSIEN,ECDSSV'="",$D(^ECD("B",ECDSSV)) S ECDSSIEN=$O(^ECD("B",ECDSSV,0))
 I 'ECERRFLG,'ECDSSIEN,ECDSSV'="",'$D(^ECD("B",ECDSSV)) D
 . N ECNXTDSS
 . S ECNXTDSS=$O(^ECD("B",ECDSSV))
 . I ECDSSV=$E(ECNXTDSS,1,$L(ECDSSV)) S ECDSSIEN=$O(^ECD("B",ECNXTDSS,0))
 . ;
 . I ECDSSV'=$E(ECNXTDSS,1,$L(ECDSSV)) D
 . . ; DSS unit name not found on VistA
 . . S ECERRMSG=$P($T(DSS3^ECV3RPC),";;",2)
 . . S ECCOLERR=ECDSSPC
 . . D ERROR
 . . Q
 . Q
 ;
 ;--Validate Ordering section or derive from DSS Unit IEN--
 I ECOSV'="" D
 . S ECOSIEN=$O(^ECC(723,"B",ECOSV,0))
 . I ECOSIEN="" D
 . . ; Ordering Section "B" x-ref doesn't exist
 . . S ECERRMSG=$P($T(ORDSEC1^ECV3RPC),";;",2)
 . . S ECCOLERR=ECOSPC
 . . D ERROR
 . . Q
 . Q
 I ECOSV="" D
 . I 'ECDSSIEN D
 . . ; Unable to derive Ordering section from DSS Unit
 . . S ECERRMSG=$P($T(ORDSEC2^ECV3RPC),";;",2)
 . . S ECCOLERR=ECOSPC
 . . D ERROR
 . . Q
 . I ECDSSIEN D
 . . S ECOSIEN=$P(^ECD(ECDSSIEN,0),U,3)
 . . I ECOSIEN="" D
 . . . ; Unable to derive Ordering section from DSS Unit
 . . . S ECERRMSG=$P($T(ORDSEC2^ECV3RPC),";;",2)
 . . . S ECCOLERR=ECOSPC
 . . . D ERROR
 . . . Q
 . . Q
 ;
 ;--Procedure must be a National Procedure, Local Procedure,   --
 ;--or a CPT code, and the EC Event Code Screen must be active --
 N ECFOUND,ECPI,ECDT
 S ECERRFLG=0,ECFOUND=0
 S %DT="XST",X=$G(ECENCV,"NOW") D ^%DT S ECDT=+Y
 ; Check for National Procedure code (D x-ref)
 I $D(^EC(725,"D",ECPROCV)) D
 . S ECPROCV=$O(^EC(725,"D",ECPROCV,0))_";EC(725,"
 . S ECPI=$P($G(^EC(725,ECPROCV,0)),"^",5)
 . I ECPI="" S ECFOUND=1 Q
 . S ECPI=$$CPT^ICPTCOD(ECPI,ECDT) I +ECPI>0,$P(ECPI,"^",7) S ECFOUND=1
 ; Check for local procedure code (DL x-ref)
 I 'ECFOUND,$D(^EC(725,"DL",ECPROCV)) D
 . S ECPROCV=$O(^EC(725,"DL",ECPROCV,0))_";EC(725,"
 . S ECPI=$P($G(^EC(725,ECPROCV,0)),"^",5)
 . I ECPI="" S ECFOUND=1 Q
 . S ECPI=$$CPT^ICPTCOD(ECPI,ECDT) I +ECPI>0,$P(ECPI,"^",7)  S ECFOUND=1
 ; Check for CPT code (B x-ref)
 I 'ECFOUND S ECPI=$$CPT^ICPTCOD(ECPROCV,ECDT) I +ECPI>0,$P(ECPI,"^",7) D
 . S ECPROCV=$P(ECPI,"^")_";ICPT("
 . S ECFOUND=1
 ;
 I 'ECFOUND D
 . ; Invalid procedure code
 . S ECERRMSG=$P($T(PROC1^ECV3RPC),";;",2)
 . S ECCOLERR=ECPROCPC
 . D ERROR
 . Q
 ;
 ; -Category must exist on the Event Capture Category file
 I ECCATV="" S ECCATIEN=0
 I ECCATV'="" D
 . I $D(^EC(726,"B",ECCATV)) S ECCATIEN=$O(^EC(726,"B",ECCATV,0))
 . I '$D(^EC(726,"B",ECCATV)) D
 . . ; B cross reference not found for category
 . . S ECERRMSG=$P($T(CAT1^ECV3RPC),";;",2)
 . . S ECCOLERR=ECCATPC
 . . D ERROR
 . . Q
 ;
 ; -check for active Event Code screen
 N ECEVNT,ECSNODE,ECSDATA,ECSFOUND
 I 'ECERRFLG D
 . S ECEVNT=ECSTAV_"-"_ECDSSIEN_"-"_ECCATIEN_"-"_ECPROCV
 . S (ECSNODE,ECSFOUND)=0
 . F  S ECSNODE=$O(^ECJ(ECSNODE)) Q:ECSNODE=""  D
 . . S ECSDATA=$G(^ECJ(ECSNODE,0))
 . . I ECEVNT=$P(ECSDATA,U,1) D
 . . . S ECSFOUND=1
 . . . I $P(ECSDATA,U,2)'="" D
 . . . . ; Event Code screen inactive
 . . . . S ECERRMSG=$P($T(PROC2^ECV3RPC),";;",2)
 . . . . S ECCOLERR=ECPROCPC
 . . . . D ERROR
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 ;Generate error if event code screen not found
 I 'ECERRFLG,'ECSFOUND,ECDSSIEN D
 . ; Event Code screen not found
 . S ECERRMSG=$P($T(PROC3^ECV3RPC),";;",2)
 . S ECCOLERR=ECPROCPC
 . D ERROR
 . Q
 ;
 I 'ECERRFLG,'ECFILDUP D
 .;Check for duplicate uploaded record base on Loc_DSS Unit_Category_Proc
 .;Date_Procedure
 . N ECDUP,ECNAM,ECPNAM,ECI,ECX,Y,ECPRV,ECPROV
 . S (ECDA,ECDUP)=0
 . F  S ECDA=$O(^ECH("ADT",ECSTAV,ECSSNIEN,ECDSSIEN,ECDT,ECDA)) Q:'ECDA  D  I ECDUP Q
 . . S ECX=$G(^ECH(ECDA,0)) I ECX="" Q
 . . I $P(ECX,U,8)'=ECCATIEN Q
 . . I $P(ECX,U,9)'=ECPROCV Q
 . . S ECPNAM="",ECDUP=1
 . . K ECPRV S ECPROV=$$GETPRV^ECPRVMUT(ECDA,.ECPRV)
 . . F ECI=1:1:3 S Y=$O(ECPRV("")) I Y'="" D
 . . . S ECNAM=$P(ECPRV(Y),U,2) K ECPRV(Y)
 . . . S ECPNAM=ECPNAM_" "_$P(ECNAM,",")_","_$E($P(ECNAM,",",2))
 . . S ECERRMSG="**DUPLICATE** "
 . . S ECERRMSG=ECERRMSG_" Clinic: "_$$GET1^DIQ(44,$P(ECX,U,19),.01,"I")
 . . S ECERRMSG=ECERRMSG_" Order Sect: "_$$GET1^DIQ(723,$P(ECX,U,12),.01,"I")
 . . S ECERRMSG=ECERRMSG_" Provider: "_ECPNAM
 . . S ECNAM=$$GET1^DIQ(200,$P(ECX,U,13),.01,"I")
 . . S ECERRMSG=ECERRMSG_" Entered: "_$P(ECNAM,",")_","_$E($P(ECNAM,",",2))
 . . S ECCOLERR=ECSTAPC    ;(???)
 . . D ERROR
 Q
ERROR ;--Set up array entry to contain the following:
 ;1. record number
 ;2. column number on spreadsheet containing the record number
 ;3. column number on spreadsheet containing the data in error
 ;4. error message
 ;
 S ECINDEX=ECINDEX+1
 S RESULTS(ECINDEX)=ECRECV_"^"_ECRECPC_"^"_ECCOLERR_"^"_ECERRMSG_"^"
 S ECERRFLG=1
 Q
 ;
DSS1 ;;Invalid DSS Unit IEN
DSS2 ;;Invalid DSS Unit Number
DSS3 ;;Invalid DSS Unit Name
ORDSEC1 ;;Ordering Section "B" x-ref not on Med Specialty file(#723)
ORDSEC2 ;;Unable to derive Ordering Section from DSS Unit
PROC1 ;;Procedure/CPT invalid
PROC2 ;;Procedure/CPT invalid for this Station and DSS Unit
PROC3 ;;Event Code screen not found
CAT1 ;;Category "B" x-ref not on EC Category file(#726)
