VPSMRAR5  ;DALOI/KML,WOIFO/BT - Cont. Update of VPS MRAR PDO file ;1/15/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SUB55(PTIEN,INTERFC,DTIEN,FLD,DIEFLAG,DATA,REQFLDS) ; file the ADDITIONAL MEDICATIONS multiple (853.55)
 ; INPUTS
 ;   PTIEN   : Patient DFN for 853.5 entry
 ;   INTERFC : value of 'S' indicates that the entries in VPSMRAR coming from Staff-facing interface module.
 ;           : value of 'P' indicates that the entries in VPSMRAR coming from Patient-facing interface module.
 ;   DTIEN   : transaction date/time ien for 853.51 sub-entry
 ;   FLD     : Field # where the data will be filed
 ;   DIEFLAG : Filing Type (I = Internal, E = External)
 ;   DATA    : composite string assigned to a subscript in the local array passed in by Vecna for the specific field
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ; 
 N RESULT S RESULT=""
 ;
 ; -- Check requried Additional Medication fields
 S RESULT=$$CHKADMED(INTERFC,.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- Add Medication sub entry if it doesn't exist
 N MEDID S MEDID=$P($P(DATA,U,2),",",2) ;MEDICATIONS Entry #
 I '$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"MEDSADD","B",MEDID)) D  ; ADD MEDS sub-entry does not exist yet so create stub entry
 . N ADDOK S ADDOK=$$ADDMRAR^VPSMRAR0(853.55,DTIEN_","_PTIEN,MEDID,DIEFLAG)
 . I 'ADDOK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO. Failed to add Medications entry")
 Q:RESULT'="" RESULT
 ;
 ; -- Get Additional Medication IEN
 N MEDIEN S MEDIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"MEDSADD","B",MEDID,""))
 Q:MEDIEN="" $$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO")
 ;
 ; -- Store 853.55 field entries
 N WP S WP=FLD=7!(FLD=12)
 N IENS S IENS=MEDIEN_","_DTIEN_","_PTIEN_","
 S RESULT=$$FILE^VPSMRAR0(853.55,WP,IENS,FLD,DIEFLAG,DATA)
 ;
 Q RESULT
 ;
CHKADMED(INTERFC,REQFLDS,DATA) ;Check required Additional Medication fields
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
 ; -- Get Additional Medication Entry #
 N MEDID S MEDID=$P($P(DATA,U,2),",",2) ;MEDICATIONS Entry #
 I 'MEDID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Additional Medications Entry # is required")
 Q:RESULT'="" RESULT
 ; 
 ; -- Additional Medication Name must exist
 I INTERFC="P",'$D(REQFLDS("PATIENT-FACING ADD MEDICATION",MEDID)) S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Additional Medication Name (Patient Interface) is required")
 I INTERFC="S",'$D(REQFLDS("STAFF VIEW ADD MEDICATION",MEDID))&'$D(REQFLDS("VET VIEW ADD MEDICATION",MEDID)) S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Additional Medication Name (Staff Interface) is required")
 Q RESULT
