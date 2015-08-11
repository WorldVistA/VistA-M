VPSMRAR4  ;DALOI/KML,WOIFO/BT - Update of VPS MRAR PDO file ;1/15/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SUB54(PTIEN,DTIEN,FLD,DIEFLAG,DATA,REQFLDS) ; file the MEDICATIONS multiple (853.54)
 ; INPUTS
 ;   PTIEN   : Patient DFN for 853.5 entry
 ;   DTIEN   : transaction date/time ien for 853.51 sub-entry
 ;   FLD     : Field # where the data will be filed
 ;   DIEFLAG : Filing Type (I = Internal, E = External)
 ;   DATA    : composite string assigned to a subscript in the local array passed in by Vecna for the specific field
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ; 
 N RESULT S RESULT=""
 ;
 S RESULT=$$CHKMED(.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- Add Medication sub entry if it doesn't exist
 N MEDID S MEDID=$P($P(DATA,U,2),",",2) ;MEDICATIONS Entry #
 I '$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"MEDS","B",MEDID)) D  ; MEDS sub-entry does not exist yet so create stub entry
 . N ADDOK S ADDOK=$$ADDMRAR^VPSMRAR0(853.54,DTIEN_","_PTIEN,MEDID,DIEFLAG)
 . I 'ADDOK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO. Failed to add Medications entry")
 Q:RESULT'="" RESULT
 ;
 ; -- Get Medication IEN
 N MEDIEN S MEDIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"MEDS","B",MEDID,""))
 Q:MEDIEN="" $$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO")
 ;
 ; -- Store 853.54 field entries
 N WP S WP=FLD=23!(FLD=24)!(FLD=25)
 N IENS S IENS=MEDIEN_","_DTIEN_","_PTIEN_","
 S RESULT=$$FILE^VPSMRAR0(853.54,WP,IENS,FLD,DIEFLAG,DATA)
 ;
 Q RESULT
 ;
SUB54X(SUBFIL,SUBS,PTIEN,DTIEN,DATA,REQFLDS,DIEFLAG) ; file the MED CHANGED/CONFIRMED/DISCREPANCY INDICATORS
 ; INPUTS 
 ;   SUBFIL  : Sub File# : 853.5454, 853.5455, or 853.5452
 ;   SUBS    : Subscript associated with the Sub File : MCHG, MCNFR, MDISCR
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
 ; -- Check required Medication fields
 S RESULT=$$CHKALM(.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- Add Medication changed/confirmed/discrepancy sub entry if it doesn't exist
 N MEDID S MEDID=$P($P(DATA,U,2),",",2)
 N MIEN S MIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"MEDS","B",MEDID,0))
 I 'MIEN S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Corrupted Medication entry")
 Q:RESULT'="" RESULT
 ;
 N MEDCHGID S MEDCHGID=$P($P(DATA,U,2),",",3)
 ;I $P(DATA,U,3)'=MEDCHGID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Value does not match third index")
 ;Q:RESULT'="" RESULT
 N EXIST S EXIST=$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"MEDS",MIEN,SUBS,"B",MEDCHGID))
 I EXIST S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Duplicate Medication Changed/Confirmed/Discrepancy entry")
 Q:RESULT'="" RESULT
 ;
 N OK S OK=$$ADDMRAR^VPSMRAR0(SUBFIL,MIEN_","_DTIEN_","_PTIEN,MEDCHGID,"")
 I 'OK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Unable to file Medication Changed/Confirmed/Discrepancy entry")
 I OK S RESULT=$$RESULT^VPSMRAR0(DATA,1,"") ; data for specific field was filed successfully into PDO record
 ;
 Q RESULT
 ;
CHKMED(REQFLDS,DATA) ;Check required Medication fields
 ; INPUTS 
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ;   DATA    : Field Name^IENS^Field Value
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ; -- Medication Entry # is required field
 N MEDID S MEDID=$P($P(DATA,U,2),",",2) ;MEDICATIONS Entry #
 I 'MEDID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Medication Entry # is required")
 Q:RESULT'="" RESULT
 ;
 ; -- Medication ID and Name must exist
 N REQEXIST S REQEXIST=$D(REQFLDS("MED ID",MEDID))&$D(REQFLDS("MEDICATION NAME",MEDID))
 I 'REQEXIST S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Med ID and Medication Name are required")
 Q RESULT
 ;
CHKALM(REQFLDS,DATA) ;Check required Med Changed/confirmed/discrepancy fields
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
 N MEDID S MEDID=$P($P(DATA,U,2),",",2)
 I 'MEDID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Medication Entry # is required")
 Q:RESULT'="" RESULT
 ;
 N MEDCHGID S MEDCHGID=$P($P(DATA,U,2),",",3)
 I 'MEDCHGID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Medication Changed/Confirmed/Discrepancy is required")
 Q:RESULT'="" RESULT
 ;
 I '$D(^VPS(853.7,MEDCHGID)) S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Invalid Medication Changed/Confirmed/Discrepancy")
 Q RESULT
