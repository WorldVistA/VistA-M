HDISVC02 ;BPFO/JRP - PROCESS RECEIVED XML DATA;12/20/2004
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
TERM(DATA,EINDX,AINDX,ERRARR,FILE,FIELD) ;Process 'Term' portion of XML document
 ; Input : DATA - Array reference from which the 'File' element
 ;                begins (closed root)
 ;         EINDX - Element index array (closed root)
 ;         AINDX - Attribute index array (closed root)
 ;         ERRARR - Error array (closed root)
 ;         FILE - Value of 'FileNumber' element
 ;         FIELD - Value of 'FieldNumber' element
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : Existance/validity of input assumed (internal call)
 N INDX,REP,TERM,IREF,VUID,TMP,OOPS,DATE,NTNL
 S INDX=@EINDX@("Term")
 S REP=0
 F  S REP=+$O(@DATA@(INDX,REP)) Q:'REP  D
 .S OOPS=0
 .;Get elements
 .S TERM=$G(@DATA@(INDX,REP,@EINDX@("TermName"),1,"V"))
 .S IREF=$G(@DATA@(INDX,REP,@EINDX@("FacilityInternalReference"),1,"V"))
 .S VUID=$G(@DATA@(INDX,REP,@EINDX@("VUID"),1,"V"))
 .S NTNL=$G(@DATA@(INDX,REP,@EINDX@("NationalTerm"),1,"V"))
 .;Validate elements
 .F TMP="TERM","VUID","IREF","NTNL" I $G(@TMP)="" D
 ..S Y="TermName"
 ..I TMP="VUID" S Y="VUID"
 ..I TMP="IREF" S Y="FacilityInternalReference"
 ..I TMP="NTNL" S Y="NationalTerm"
 ..S X="XML element '"_Y_"' for repetition number "_REP_" of 'Term' "
 ..I TMP="TERM" S X="Repetition number "_REP_" of XML element 'Term' "
 ..I TMP'="TERM" S X=X_"("_TERM_") "
 ..S X=X_"did not have a value"
 ..D ADDERR^HDISVC00(X,ERRARR)
 ..S OOPS=1
 .;Problem found - quit
 .I OOPS Q
 .;Does entry exist
 .I '$$EXISTS(FILE,FIELD,IREF) D
 ..S TMP="Value for 'FacilityInternalReference' ("_IREF_") not valid "
 ..S TMP=TMP_"for repetition number "_REP_" of 'Term' ("_TERM_")"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 .;Does received term match stored term
 .I 'OOPS I '$$VALMATCH(FILE,FIELD,IREF,TERM) D
 ..S TMP="Local value does not match received value for repetition "
 ..S TMP=TMP_"number "_REP_" of 'Term' ("_TERM_")"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 .;Is 'NationalTerm; valid value
 .I NTNL'=0 I NTNL'=1 D
 ..S TMP="Value for 'NationalTerm' ("_NTNL_") not valid for "
 ..S TMP=TMP_"repetition number "_REP_" of 'Term' ("_TERM_")"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 .;Problem found - don't continue
 .I OOPS Q
 .;Store/update VUID (inactivates term when appropriate)
 .D STOREIT(FILE,FIELD,IREF,VUID,NTNL,ERRARR)
 Q
 ;
EXISTS(FILE,FIELD,IREF) ;Does entry exist
 ; Input : FILE - File number
 ;         FIELD - Field number
 ;         IREF - Internal reference
 ;Output : 1 if entry exists
 ;         0 if entry doesn't exist
 ; Notes : Existance/validity of input assumed (internal call)
 N EXIST,CODES
 S EXIST=0
 S CODES=$$SETCODE(FILE,FIELD)
 ;Set of codes
 I CODES I $$EXTERNAL^DILFD(FILE,FIELD,"",IREF) S EXIST=1
 ;Entry in file
 I 'CODES D
 .S IREF="`"_(+IREF)
 .I $$FIND1^DIC(FILE,"","",IREF) S EXIST=1
 D CLEAN^DILF
 Q EXIST
 ;
VALMATCH(FILE,FIELD,IREF,VALUE) ;Check input value against stored value
 ; Input : FILE - File number
 ;         FIELD - Field number
 ;         IREF - Internal reference
 ;         VALUE - Value to verify
 ;Output : 1 if stored value equals input VALUE
 ;         0 if stored value does not equal input VALUE
 ; Notes : Existance/validity of input assumed (internal call)
 N MATCH,CODES,LOCVAL
 S MATCH=0
 S CODES=$$SETCODE(FILE,FIELD)
 ;Set of codes
 I CODES S LOCVAL=$$EXTERNAL^DILFD(FILE,FIELD,"",IREF)
 ;Entry in file
 I 'CODES S LOCVAL=$$GET1^DIQ(FILE,IREF,FIELD)
 ;Case insensitive compare
 I $$UP^XLFSTR(LOCVAL)=$$UP^XLFSTR(VALUE) S MATCH=1
 D CLEAN^DILF
 Q MATCH
 ;
SETCODE(FILE,FIELD) ;Is field a set of codes
 ; Input : FILE - File number
 ;         FIELD - Field number
 ;Output : 1 if field is a set of codes
 ;         0 if field is not a set of codes
 ; Notes : Existance/validity of input assumed (internal call)
 N CODES
 S CODES=0
 I $$GET1^DID(FILE,FIELD,"","TYPE")="SET" S CODES=1
 Q CODES
 ;
STOREIT(FILE,FIELD,IREF,VUID,NTNL,ERRARR) ;Store VUID
 ; Input : FILE - File number
 ;         FIELD - Field number
 ;         IREF - Internal reference
 ;         VUID - VUID
 ;         NTNL - National term
 ;                0 = No (default)     1 = Yes
 ;         ERRARR - Error array (closed root)
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : Existance/validity of input assumed (internal call)
 ;       : Call will automatically inactivate terms when appropriate
 ;
 N TMP,MASTER
 S NTNL=+$G(NTNL)
 ;Store VUID (also sets master entry flag, if appropriate)
 I '$$SETVUID^XTID(FILE,FIELD,IREF,VUID) D  Q
 .S TMP="Unable to store "_VUID_" as the VUID for internal reference '"
 .S TMP=TMP_IREF_"' of field number "_FIELD_" in file number "_FILE
 .D ADDERR^HDISVC00(TMP,ERRARR)
 ;Get master entry flag
 S MASTER=$$GETMASTR^XTID(FILE,FIELD,IREF)
 ;Don't inactivate national terms that are the master entry
 I NTNL I MASTER Q
 ;Inactivate
 I '$$SETSTAT^XTID(FILE,FIELD,IREF,0,$$NOW^XLFDT()) D  Q
 .S TMP="Unable to inactivate internal reference "_IREF_" of field "
 .S TMP=TMP_"number "_FIELD_" in file number "_FILE_".  VUID for the"
 .S TMP=TMP_" "_$S(NTNL:"",1:"non-")_"standard term was "_VUID_"."
 .D ADDERR^HDISVC00(TMP,ERRARR)
 Q
