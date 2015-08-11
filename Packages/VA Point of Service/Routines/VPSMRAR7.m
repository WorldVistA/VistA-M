VPSMRAR7  ;DALOI/KML,WOIFO/BT - Cont. Update of VPS MRAR PDO file ;1/15/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SUB57(PTIEN,DTIEN,FLD,DIEFLAG,DATA,REQFLDS) ; file the ALLERGY REACTIONS multiple (853.57)
 ; INPUTS
 ;   PTIEN   : Patient DFN for 853.5 entry
 ;   DTIEN   : transaction date/time ien for 853.51 sub-entry
 ;   FLD     : Field # where the data will be filed
 ;   DIEFLAG : Filing Type (I = Internal, E = External)
 ;   DATA    : composite string assigned to a subscript in the local array passed in by Vecna for the specific field
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ;
 ; -- Check required Allergy fields
 S RESULT=$$CHKALR^VPSMRAR2(.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- Check required Allergy Reaction fields
 S RESULT=$$CHKREACT(.REQFLDS,DATA)
 Q:RESULT'="" RESULT
 ;
 ; -- retrieve the allergy ien
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2)
 N AIEN S AIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGY","B",ALLERID,""))
 Q:AIEN="" $$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO")
 ;
 ; -- Add Allergy Reactions sub entry if it doesn't exist
 N REACTID S REACTID=$P($P(DATA,U,2),",",3)
 ;I $P(DATA,U,3)'=REACTID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Value does not match third index")
 ;Q:RESULT'="" RESULT
 I '$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGY",AIEN,"REACTIONS","B",REACTID)) D  ; REACTIONS sub-entry not yet created for this allergy
 . N ADDOK S ADDOK=$$ADDMRAR^VPSMRAR0(853.57,AIEN_","_DTIEN_","_PTIEN,REACTID,DIEFLAG)
 . I 'ADDOK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO. Failed to add Allergy Reactions entry")
 Q:RESULT'="" RESULT
 ;
 ; -- Get Allergy Reactions IEN
 N REACTIEN S REACTIEN=$O(^VPS(853.5,PTIEN,"MRAR",DTIEN,"ALLERGY",AIEN,"REACTIONS","B",REACTID,""))
 Q:REACTIEN="" $$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO")
 ;
 ; -- Store 853.57 field entries
 N IENS S IENS=REACTIEN_","_AIEN_","_DTIEN_","_PTIEN_","
 S RESULT=$$FILE^VPSMRAR0(853.57,0,IENS,FLD,DIEFLAG,DATA)
 ;
 Q RESULT
 ;
CHKREACT(REQFLDS,DATA) ;Check required Allergy Reaction fields
 ; INPUTS 
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ;   DATA    : Field Name^IENS^Field Value
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ; -- Allergy Reaction Entry # is required field
 N ALLERID S ALLERID=$P($P(DATA,U,2),",",2)
 N REACTID S REACTID=$P($P(DATA,U,2),",",3)
 I 'REACTID S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Allergy Reaction Entry # is required")
 Q:RESULT'="" RESULT
 ; 
 ; -- For Local VistA, Local Reaction ID is required
 ; -- For Remote (CDW), Remote Reaction ID and Remote Reaction Name are required
 N ISLOCAL S ISLOCAL=$D(REQFLDS("LOCAL REACTION ID",ALLERID,REACTID))
 N ISREMOTE S ISREMOTE=$D(REQFLDS("REMOTE REACTION ID",ALLERID,REACTID))&$D(REQFLDS("REMOTE REACTION NAME",ALLERID,REACTID))
 I 'ISLOCAL&'ISREMOTE S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Local Reaction ID or Remote Reaction ID and Remote Reaction Name are required")
 Q RESULT
