HDISVF02 ;BPFO/JRP - FILE UTILITIES/API;12/20/2004
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---------- Begin HDIS PARAMETER file (#7118.29) APIs ----------
 ;
GETTYPE(SYSPTR) ;Get value of SYSTEM TYPE field (#.02)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Internal Value ^ External Value
 ; Notes : If no value found, values for client system type returned
 N FAC,ARR,NTRNL,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "1^CLIENT"
 S XTRNL=$$GET(7118.29,.02,(FAC_","),"B",.ARR)
 I XTRNL="" Q "1^CLIENT"
 Q ARR("I")_"^"_XTRNL
 ;
SETTYPE(VALUE,SYSPTR) ;Set value of SYSTEM TYPE field (#.02)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X,HDIVAL,HDIERR
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 ;Convert VALUE to internal - allows changing of uneditable field
 D CHK^DIE(7118.29,.02,"",$G(VALUE),.HDIVAL,"HDIERR")
 I HDIVAL="^" Q
 S X=$$SET(7118.29,.02,(FAC_","),HDIVAL,0)
 Q
 ;
GETVFAIL(SYSPTR) ;Get value of DISABLE VUID ACTIVITY field (#11)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Internal Value ^ External Value
 ; Notes : If no value found, values for OFF are returned
 N FAC,ARR,NTRNL,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "0^OFF"
 S XTRNL=$$GET(7118.29,11,(FAC_","),"B",.ARR)
 I XTRNL="" Q "0^OFF"
 Q ARR("I")_"^"_XTRNL
 ;
SETVFAIL(VALUE,SYSPTR) ;Set value of DISABLE VUID ACTIVITY field (#11)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET(7118.29,11,(FAC_","),$G(VALUE),1)
 Q
 ;
GETVLOC(SYSPTR) ;Get value of VUID SERVER LOCATION field (#12)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Value of field
 ; Notes : If no value found, domain for FORUM returned
 N FAC,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "FORUM.VA.GOV"
 S XTRNL=$$GET(7118.29,12,(FAC_","),"E")
 I XTRNL="" Q "FORUM.VA.GOV"
 Q XTRNL
 ;
SETVLOC(VALUE,SYSPTR) ;Set value of VUID SERVER LOCATION field (#12)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET(7118.29,12,(FAC_","),$G(VALUE),1)
 Q
 ;
GETVCON(SYSPTR) ;Get value of VUID SERVER CONNECTION TYPE field (#13)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Internal Value ^ External Value
 ; Notes : If no value found, values for MailMan connection returned
 N FAC,ARR,NTRNL,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "1^MAILMAN"
 S XTRNL=$$GET(7118.29,13,(FAC_","),"B",.ARR)
 I XTRNL="" Q "1^MAILMAN"
 Q ARR("I")_"^"_XTRNL
 ;
SETVCON(VALUE,SYSPTR) ;Set value of VUID SERVER CONNECTION TYPE field (#13)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET(7118.29,13,(FAC_","),$G(VALUE),1)
 Q
 ;
GETVSRV(SYSPTR) ;Get value of VUID SERVER OPTION field (#21)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Value of field
 ; Notes : If no value found, HDIS-FACILITY-DATA-SERVER returned
 N FAC,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "HDIS-FACILITY-DATA-SERVER"
 S XTRNL=$$GET(7118.29,21,(FAC_","),"E")
 I XTRNL="" Q "HDIS-FACILITY-DATA-SERVER"
 Q XTRNL
 ;
SETVSRV(VALUE,SYSPTR) ;Set value of VUID SERVER OPTION field (#21)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET(7118.29,21,(FAC_","),$G(VALUE),1)
 Q
 ;
 ;---------- End HDIS PARAMETER file APIs ----------
 ;
SET(FILE,FIELD,IENS,VALUE,XTRNL) ;Store value into a field
 ; Input : FILE - File number
 ;         FIELD - Field number
 ;         IENS - IENS of entry
 ;         VALUE - Value to store
 ;         XTRNL - Flag indicating if VALUE is in external format
 ;                 1 = Yes (external)     0 = No (internal) (default)
 ;Output : Flag indicating if storing of value was done
 ;         1 = OK     0 = Error
 ; Notes : Assumes input values are valid and exist
 ;       : Does not support word processing fields
 N HDISFDA,HDISMSG,FLAGS
 S HDISFDA(FILE,IENS,FIELD)=VALUE
 S FLAGS=$S(XTRNL:"E",1:"")
 D FILE^DIE(FLAGS,"HDISFDA","HDISMSG")
 Q $D(HDISMSG)
 ;
GET(FILE,FIELD,IENS,HOW,OUTPUT) ;Get value for a field
 ; Input : FILE - File number
 ;         FIELD - Field number
 ;         IENS - IENS of entry
 ;         HOW - Flag indicating how value should be returned
 ;               I - Return internal value
 ;               E - Return external value
 ;               B - Return internal and external value
 ;         OUTPUT - Output array (pass by reference - dot notation)
 ;                  Only set if HOW = B (both)
 ;                  OUTPUT("I") = Internal value
 ;                  OUTPUT("E") = External value
 ;Output : If HOW = I, internal value
 ;         If HOW = E, external value
 ;         If HOW = B, external value
 ; Notes : Assumes input values are valid and exist
 ;       : Does not support word processing fields
 ;       : Null ("") returned on error
 N FLAGS,HDISTRG,HDISMSG
 S FLAGS=$S(HOW="I":"I",HOW="E":"E",1:"IE")
 D GETS^DIQ(FILE,IENS,FIELD,FLAGS,"HDISTRG","HDISMSG")
 I $D(HDISMSG) K OUTPUT Q ""
 I HOW'="B" Q $G(HDISTRG(FILE,IENS,FIELD,HOW))
 S OUTPUT("I")=$G(HDISTRG(FILE,IENS,FIELD,"I"))
 S OUTPUT("E")=$G(HDISTRG(FILE,IENS,FIELD,"E"))
 Q OUTPUT("E")
