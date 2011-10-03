HDISVS02 ;BPFO/JRP - PROCESS RECEIVED XML DATA;12/20/2004
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
TERM(DATA,EINDX,AINDX,SYSPTR,FFPTR,ERRARR) ;Process 'Term' portion of XML document
 ; Input : DATA - Array reference from which the 'File' element
 ;                begins (closed root)
 ;         EINDX - Element index array (closed root)
 ;         AINDX - Attribute index array (closed root)
 ;         SYSPTR - Pointer to HDIS SYSTEM file (#7118.21)
 ;         FFPTR - Pointer to HDIS FILE/FIELD file (#7115.6)
 ;                 Derived from 'FileNumber' & 'FieldNumber' element
 ;         ERRARR - Error array (closed root)
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : Existance/validity of input assumed (internal call)
 N INDX,REP,TERM,IREF,VUID,TMP,OOPS,TERMPTR,FILEARR,X
 S INDX=@EINDX@("Term")
 S REP=0
 F  S REP=+$O(@DATA@(INDX,REP)) Q:'REP  D
 .S OOPS=0
 .S TERMPTR=0
 .;Get elements
 .S TERM=$G(@DATA@(INDX,REP,@EINDX@("TermName"),1,"V"))
 .S IREF=$G(@DATA@(INDX,REP,@EINDX@("FacilityInternalReference"),1,"V"))
 .S VUID=$G(@DATA@(INDX,REP,@EINDX@("VUID"),1,"V"))
 .;Validate elements
 .;VUID allowed to be null (in most cases they are)
 .F TMP="TERM","IREF" I $G(@TMP)="" D
 ..S Y="TermName"
 ..I TMP="IREF" S Y="FacilityInternalReference"
 ..S X="XML element '"_Y_"' for repetition number "_REP_" of 'Term' "
 ..I TMP="TERM" S X="Repetition number "_REP_" of XML element 'Term' "
 ..I TMP'="TERM" S X=X_"("_TERM_") "
 ..S X=X_"did not have a value"
 ..D ADDERR^HDISVC00(X,ERRARR)
 ..S OOPS=1
 .;Problem found - quit
 .I OOPS Q
 .;VUID passed - ignore
 .I VUID'="" Q
 .;Convert term to upper case
 .S TERM=$$UP^XLFSTR(TERM)
 .;Known term/concept
 .K FILEARR
 .S FILEARR(FFPTR)=""
 .K TERMPTR
 .I $$GETTERM^HDISVF04(TERM,.FILEARR,.TERMPTR) D
 ..;Get VUID
 ..S VUID=""
 ..S X=$$GETVUID^HDISVF04(TERMPTR,.VUID)
 ..;Make sure VUID has a value
 ..I VUID="" D
 ...S X="Entry number "_TERMPTR_" in HDIS TERM/CONCEPT VUID "
 ...S X=X_"ASSOCIATION file (#7118.11) does not have a VUID."
 ...S X=X_"  Repetition "_REP_" of 'Term' ("_TERM_")."
 ...D ADDERR^HDISVC00(X,ERRARR)
 ...S OOPS=1
 .;Problem found - quit
 .I OOPS Q
 .;Assign non-standard VUID
 .I VUID="" D
 ..;Calculate non-standard VUID
 ..S VUID=$$CALCNSV^HDISVF03()
 ..I VUID="" D  Q
 ...S TMP="Unable to calculate non-standard VUID for repetition number "
 ...S TMP=TMP_REP_" of 'Term' ("_TERM_")"
 ...D ADDERR^HDISVC00(TMP,ERRARR)
 ...S OOPS=1
 ..;Create entry in Term/Concept file
 ..K FILEARR
 ..S FILEARR(FFPTR)=""
 ..K TERMPTR
 ..I '$$ADDTERM^HDISVF04(TERM,VUID,.FILEARR,0,1,$$NOW^XLFDT(),0,.TERMPTR) D
 ...S TMP="Unable to create entry in HDIS TERM/CONCEPT VUID "
 ...S TMP=TMP_"ASSOCIATION file (#7118.11) for repetition number "
 ...S TMP=TMP_REP_" of 'Term' ("_TERM_").  VUID was "_VUID_"."
 ...D ADDERR^HDISVC00(TMP,ERRARR)
 ...S OOPS=1
 ..;Wait 1 second - resolve global cache problem
 ..H 1
 .;Problem found - quit
 .I OOPS Q
 .;Create entry in Facility Term/Concept file
 .I '$$FINDFAC^HDISVF08(SYSPTR,FFPTR,TERMPTR,IREF,1) D
 ..S TMP="Unable to create entry in HDIS FACILITY TERM/CONCEPT "
 ..S TMP="ASSOCIATION file (#7118.22) for repetition number "_REP
 ..S TMP=TMP_" of 'Term' ("_TERM_").  VUID was "_VUID_"."
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 .;Problem found - quit
 .I OOPS Q
 Q
