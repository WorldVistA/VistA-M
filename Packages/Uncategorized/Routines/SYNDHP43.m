SYNDHP43 ; HC/fjf/art - HealthConcourse - validate a patient's traits ;07/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
PATVAL(RETSTA,NAME,SSN,DOB,GENDER,MMDNM) ; validate patient for DHP
 ;
 ; this API validates a patient
 ; all the input criteria must be satisfied for the patient to be identified as a valid patient
 ;
 ; Input:
 ; NAME is the patient Name                   - REQUIRED
 ; SSN is the patient Social Security Number  - REQUIRED
 ; DOB is the patient Date of Birth           - REQUIRED
 ; GENDER is the patient gender               - REQUIRED
 ; MMDNM is the patient Mother's Maiden Name  - optional
 ;
 ; Output:
 ; RETSTA is the name of the return array
 ;   RETSTA(0)=STATUS^REASON^ICN
 ;             STATUS = 1 - valid match found
 ;             STATUS = 0 - no match found
 ;
 N SSNA,RZN,N,TX,IEN
 I $G(NAME)="" S RETSTA="-1^Patient Name not specified" Q
 I $G(SSN)="" S RETSTA="-1^Patient SSN not specified" Q
 I $G(DOB)="" S RETSTA="-1^Patient DOB not specified" Q
 I $G(GENDER)="" S RETSTA="-1^Patient Gender not specified" Q
 ;I $G(MMDNM)="" S RETSTA="-1^Mother's Maiden Name not specified" Q
 S MMDNM=$G(MMDNM)
 ;
 ; do some validation for above traits and determine if patient is valid
 ;
 ; check to see if SSN is recognised by VistA system
 I '+$$SSNCHK(SSN) S RETSTA="-1^Patient SSN not recognised" Q
 ;
 ; otherwise we have at least one patient for the SSN
 ; check each patient for a match
 S N=""
 S RETSTA="0^Invalid patient"
 F  S N=$O(SSNA(N)) Q:N=""  D
 .S TX=SSNA(N)
 .S IEN=$P(TX,"^",2)
 .I $$NAMCHK(IEN),$$DOBCHK(IEN),$$GENCHK(IEN),$$MDNCHK(IEN) S RETSTA="1^Valid patient^"_$$ICN(IEN)
 I +RETSTA Q
 I $D(RZN) S RETSTA="-1^Invalid "_RZN Q
 Q
 ;
SSNCHK(SSN) ; SSN check
 ; find all patients that match SSN
 K SSNA
 N IEN S IEN=""
 F  S IEN=$O(^DPT("SSN",SSN,IEN)) Q:IEN=""  D
 .S SSNA(IEN)=SSN_U_IEN
 I '$D(SSNA) Q 0
 Q 1
 ;
NAMCHK(IEN) ; name check
 I $P(NAME," ")'=$P($$GET1^DIQ(2,IEN_",",.01,"I")," ") S RZN="patient name" Q 0
 Q 1
 ;
DOBCHK(IEN) ; DOB check
 I $$HL7TFM^XLFDT(DOB)'=$$GET1^DIQ(2,IEN_",",.03,"I") S RZN="DOB" Q 0
 Q 1
 ;
GENCHK(IEN) ; gender check
 I GENDER'=$$GET1^DIQ(2,IEN_",",.02,"I") S RZN="gender" Q 0
 Q 1
 ;
MDNCHK(IEN) ; mother's maiden name check
 Q:MMDNM="" 1
 I MMDNM'=$P($$GET1^DIQ(2,IEN_",",.2403),",") S RZN="mother maiden name" Q 0
 Q 1
 ;
ICN(IEN) ; obtain ICN
 N ICN
 S ICN=$$GET1^DIQ(2,IEN_",",991.1)
 I ICN="" D
 . S ICN=$$GET1^DIQ(2,IEN_",",991.01)_"V"_$$GET1^DIQ(2,IEN_",",991.02)
 Q ICN
 ;
TESTP ;
 D PATVAL(.RETSTA,"ZERO,PATIENT",666000000,19350505,"M","SCHMIDT")
 W $$ZW^SYNDHPUTL("RETSTA")
 Q
 ;
TESTF1 ; SSN fail
 D PATVAL(.RETSTA,"ZERO,PATIENT",566000000,19350505,"M","SCHMIDT")
 W $$ZW^SYNDHPUTL("RETSTA")
 Q
 ;
TESTF2 ; name fail
 D PATVAL(.RETSTA,"FRAUNOFER,PATIENT",666000000,19350505,"M","SCHMIDT")
 W $$ZW^SYNDHPUTL("RETSTA")
 Q
 ;
TESTF3 ; DOB fail
 D PATVAL(.RETSTA,"ZERO,PATIENT",666000000,19270928,"M","SCHMIDT")
 W $$ZW^SYNDHPUTL("RETSTA")
 Q
 ;
TESTF4 ; gender fail
 D PATVAL(.RETSTA,"ZERO,PATIENT",666000000,19350505,"F","SCHMIDT")
 W $$ZW^SYNDHPUTL("RETSTA")
 Q
 ;
TESTF5 ; mother's maiden name fail
 D PATVAL(.RETSTA,"ZERO,PATIENT",666000000,19350505,"M","SCHROEDINGER")
 W $$ZW^SYNDHPUTL("RETSTA")
 Q
 ;
T3 ;
 S NAME="COPD,PATIENT MALE"
 S SSN=666111957
 S DOB=19800530
 S GENDER="M"
 N RETSTA
 D PATVAL(.RETSTA,NAME,SSN,DOB,GENDER)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
