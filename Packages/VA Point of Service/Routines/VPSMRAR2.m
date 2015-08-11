VPSMRAR2  ;DALOI/KML,WOIFO/BT - Cont. Update of VPS MRAR PDO file ;1/15/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SUB52(PTIEN,DTIEN,FLD,DIEFLAG,DATA,REQFLDS) ; file the ALLERGY multiple (853.52)
 ; INPUTS 
 ;   PTIEN   : D0 - Patient DFN for 853.5 entry1
 ;   DTIEN   : D1 - transaction date/time ien for 853.51 sub-entry
 ;   FLD     : Field # where the data will be filed
 ;   DIEFLAG : Filing Type (I = Internal, E = External)
 ;   DATA    : Field Name^IENS^Field Value
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ;
 ; -- Check required Allergy fields
 S RESULT=$$CHKALR(.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- Add Allergy sub entry if it doesn't exist
 ;N ALLERID S ALLERID=$P(DATA,U,3) ;Allergy Entry #
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2) ;Allergy Entry #
 I '$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGY","B",ALLERID)) D
 . N ADDOK S ADDOK=$$ADDMRAR^VPSMRAR0(853.52,DTIEN_","_PTIEN,ALLERID,DIEFLAG)
 . I 'ADDOK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO. Failed to add Allergy entry")
 Q:RESULT'="" RESULT
 ;
 ; -- Get Allergy IEN
 N ALLERIEN S ALLERIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGY","B",ALLERID,""))
 I ALLERIEN="" S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO")
 Q:RESULT'="" RESULT
 I FLD=.02,$$GET1^DIQ(120.8,$P(DATA,U,3)_",",.01,"I")'=PTIEN S RESULT=$$RESULT^VPSMRAR0(DATA,99,"DFN does not match DFN associated with PATIENT ALLERGIES")
 Q:RESULT'="" RESULT
 ;
 ; -- Store 853.52 field entries
 N WP S WP=FLD="1"!(FLD=2)!(FLD=3)
 N IENS S IENS=ALLERIEN_","_DTIEN_","_PTIEN_","
 S RESULT=$$FILE^VPSMRAR0(853.52,WP,IENS,FLD,DIEFLAG,DATA)
 ;
 Q RESULT
 ;
SUB52X(SUBFIL,SUBS,PTIEN,DTIEN,DATA,REQFLDS,DIEFLAG) ; file the ALLERGY CHANGED INDICATORS (853.525)
 ; INPUTS 
 ;   SUBFIL  : Sub File# : 853.525, 853.526, or 853.527
 ;   SUBS    : Subscript associated with the Sub File : ACHG, ACNFR, ADISCR
 ;   PTIEN   : D0 - Patient DFN for 853.5 entry1
 ;   DTIEN   : D1 - transaction date/time ien for 853.51 sub-entry
 ;   DATA    : Field Name^IENS^Field Value
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ;   DIEFLAG : Filing Type (I = Internal, E = External)
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ;
 ; -- Check required Allergy fields
 S RESULT=$$CHKALC(.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- Add Allergy changed/confirmed/discrepancy sub entry if it doesn't exist
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2)
 N AIEN S AIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGY","B",ALLERID,0))
 I 'AIEN S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Corrupted Allergy entry")
 Q:RESULT'="" RESULT
 ;
 N ALLCHGID S ALLCHGID=$P($P(DATA,U,2),",",3)
 ;I $P(DATA,U,3)'=ALLCHGID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Value does not match third index")
 ;Q:RESULT'="" RESULT
 N EXIST S EXIST=$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGY",AIEN,SUBS,"B",ALLCHGID))
 I EXIST S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Duplicate Allergy Changed/Confirmed/Discrepancy entry")
 Q:RESULT'="" RESULT
 ;
 N OK S OK=$$ADDMRAR^VPSMRAR0(SUBFIL,AIEN_","_DTIEN_","_PTIEN,ALLCHGID)
 I 'OK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Unable to file Allergy Changed/Confirmed/Discrepancy entry")
 I OK S RESULT=$$RESULT^VPSMRAR0(DATA,1,"") ; data for specific field was filed successfully into PDO record
 ;
 Q RESULT
  ;
CHKALR(REQFLDS,DATA) ;Check required Allergy fields
 ; INPUTS 
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ;   DATA    : Field Name^IENS^Field Value
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ; -- Allergy Entry # is required field
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2)
 I 'ALLERID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Allergy Entry # is required")
 Q:RESULT'="" RESULT
 ;
 ; -- For Local VistA, Local Allergy ID is required
 ; -- For Remote (CDW), Remote Allergy ID and Remote Allergy Name are required
 N ISLOCAL S ISLOCAL=$D(REQFLDS("LOCAL ALLERGY ID",ALLERID))
 N ISREMOTE S ISREMOTE=$D(REQFLDS("REMOTE ALLERGY ID",ALLERID))&$D(REQFLDS("REMOTE ALLERGY NAME",ALLERID))
 I 'ISLOCAL&'ISREMOTE S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Local Allergy ID or Remote Allergy ID and Remote Allergy Name are required")
 Q RESULT
 ;
CHKALC(REQFLDS,DATA) ;Check required Allergy Changed/confirmed/discrepancy fields
 ; INPUTS 
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ;   DATA    : Field Name^IENS^Field Value
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ; -- Allergy Entry # is required field
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2)
 I 'ALLERID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Allergy Entry # is required")
 Q:RESULT'="" RESULT
 ;
 N ALLCHGID S ALLCHGID=$P($P(DATA,U,2),",",3)
 I 'ALLCHGID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Allergy Changed/Confirmed/Discrepancy is required")
 Q:RESULT'="" RESULT
 ;
 I '$D(^VPS(853.3,ALLCHGID)) S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Invalid Allergy Changed/Confirmed/Discrepancy")
 Q RESULT
