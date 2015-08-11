VPSMRAR3  ;DALOI/KML,WOIFO/BT - Cont. Update of VPS MRAR PDO file ;1/15/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SUB53(PTIEN,INTERFC,DTIEN,FLD,DIEFLAG,DATA,REQFLDS) ; file the ADDITIONAL ALLERGIES multiple (853.53)
 ; INPUTS
 ;   PTIEN   : Patient DFN for 853.5 entry
 ;   INTERFC : value of 'S' indicates that the entries in VPSMRAR coming from Staff-facing interface module.
 ;           : value of 'P' indicates that the entries in VPSMRAR coming from Patient-facing interface module.
 ;   DTIEN   : transaction date/time ien for 853.51 sub-entry
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
 ; -- Check required Additional Allergy fields
 S RESULT=$$CHKADALR(INTERFC,.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- Add Allergy additional sub entry if it doesn't exist
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2) ;Additional Allergy Entry #
 I '$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGYADD","B",ALLERID)) D  ; allergy sub-entry does not exist yet so create stub entry
 . N ADDOK S ADDOK=$$ADDMRAR^VPSMRAR0(853.53,DTIEN_","_PTIEN,ALLERID,DIEFLAG)
 . I 'ADDOK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO. Failed to add Allergy entry")
 Q:RESULT'="" RESULT
 ;
 ; -- Get Allergy additional IEN
 N ALLERIEN S ALLERIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGYADD","B",ALLERID,""))
 Q:ALLERIEN="" $$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO")
 ;
 ; -- Store 853.53 field entries
 N WP S WP=FLD="1"!(FLD=1.5)
 N IENS S IENS=ALLERIEN_","_DTIEN_","_PTIEN_","
 S RESULT=$$FILE^VPSMRAR0(853.53,WP,IENS,FLD,DIEFLAG,DATA)
 ;
 Q RESULT
 ;
CHKADALR(INTERFC,REQFLDS,DATA) ;Check required Additional Allergy fields
 ; INPUTS 
 ;   INTERFC : value of 'S' indicates that the entries in VPSMRAR coming from Staff-facing interface module.
 ;           : value of 'P' indicates that the entries in VPSMRAR coming from Patient-facing interface module.
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ;   DATA    : Field Name^IENS^Field Value
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ; -- Get Additional Allergy Entry #
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2) ;Additional Allergy Entry #
 I 'ALLERID S RESULT="99^Additional Allergy Entry # is required"
 Q:RESULT'="" RESULT
 ; 
 ; -- Additional Allergy Name must exist
 I INTERFC="P",'$D(REQFLDS("ADD ALLERGY-VET",ALLERID)) S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Additional Allergy Name (Patient Interface) is required")
 I INTERFC="S",'$D(REQFLDS("ADD ALLERGY-PROVIDER",ALLERID)) S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Additional Allergy Name (Staff Interface) is required")
 Q RESULT
