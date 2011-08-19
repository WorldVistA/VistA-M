HDISVS01 ;BPFO/JRP - PROCESS RECEIVED XML DATA;12/20/2004
 ;;1.0;HEALTH DATA & INFORMATICS;**1**;Feb 22, 2005
 ;
VUID(PRSARR,ERRARR) ;Process XML data from VistA system
 ; Input : PRSARR - Array containing parsed XML document (closed root)
 ;                  This is the output of SAX^HDISVM01
 ;         ERRARR - Array to output errors in (closed root)
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : ERRARR is initialized (KILLed) on input
 ;
 ;Processing of all VUID requests disabled - throw error and quit
 I $$GETVFAIL^HDISVF02() D  Q
 .N TMP
 .S TMP="VUID^HDISVS01: Processing of VUID requests by central server"
 .S TMP=TMP_" is currently disabled"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 N EINDX,ESUBS,AINDX,ASUBS,DATA,TMP,FFPTR,DOMPTR,XMLDOC
 N DOMAIN,SOURCE,MAILMAN,INDX,OOPS,SYSPTR,SRCTYPE,FILE,FIELD
 S EINDX=$NA(@PRSARR@("EINDX"))
 S ESUBS=$NA(@PRSARR@("ESUBS"))
 S AINDX=$NA(@PRSARR@("AINDX"))
 S ASUBS=$NA(@PRSARR@("ASUBS"))
 S DATA=$NA(@PRSARR@("DATA"))
 S FFARR=$NA(^TMP("HDISVS01",$J,"FFARR"))
 S XMLDOC=$NA(^TMP("HDISVS01",$J,"XMLDOC"))
 K @FFARR,@XMLDOC
 S OOPS=0
 S ERRARR=$G(ERRARR)
 I ERRARR'="" K @ERRARR
 S PRSARR=$G(PRSARR)
 I PRSARR="" D  Q
 .S TMP="VUID^HDISVS01: Input parameter PRSARR was not passed"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 I '$D(@PRSARR) D  Q
 .S TMP="VUID^HDISVS01: Input array "_PRSARR_" (PRSARR) does not exist"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Ensure all elements are indexed
 F X=1:1 S TMP=$P($T(ELEMENTS+X),";;",2) Q:TMP=""  D
 .I '$D(@EINDX@(TMP)) D
 ..S TMP="XML element '"_TMP_"' was not found in the XML document"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 ;Ensure that 'Domain' is the root element
 I $G(@ESUBS@(1))'="Domain" D
 .S TMP="'Domain' was not the root element in the XML document"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Errors found - quit
 I OOPS Q
 ;Process 'Domain' portion of XML doc
 S INDX=@EINDX@("Domain")
 ;Get elements
 S DOMAIN=$G(@DATA@(INDX,1,@EINDX@("DomainName"),1,"V"))
 S SOURCE=$G(@DATA@(INDX,1,@EINDX@("Source"),1,"V"))
 S SRCTYPE=$G(@DATA@(INDX,1,@EINDX@("SourceType"),1,"V"))
 S MAILMAN=$G(@DATA@(INDX,1,@EINDX@("MailManDomain"),1,"V"))
 ;Validate elements
 F TMP="DOMAIN","SOURCE","MAILMAN","SRCTYPE" I $G(@TMP)="" D
 .S Y="DomainName"
 .I TMP="SOURCE" S Y="Source"
 .I TMP="SRCTYPE" S Y="SourceType"
 .I TMP="MAILMAN" S Y="MailManDomain"
 .S X="XML element '"_TMP_"' did not have a value"
 .D ADDERR^HDISVC00(X,ERRARR)
 .S OOPS=1
 ;Validate facility number
 I SOURCE'="" I '$$FACPTR^HDISVF01(SOURCE) D
 .S TMP="Value of XML element 'Source' ("_SOURCE
 .S TMP=TMP_") is not a valid facility number"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Errors found - quit
 I OOPS Q
 ;Get pointers
 I '$$GETIEN^HDISVF09(DOMAIN,.DOMPTR) D
 .S TMP="Entry for XML element 'DomainName' ("_DOMAIN_") could not be "
 .S TMP=TMP_"found in HDIS DOMAIN file (#7115.1)"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 I '$$FINDSYS^HDISVF07(MAILMAN,SOURCE,SRCTYPE,1,.SYSPTR) D
 .S TMP="Entry for XML elements 'Source' ("_SOURCE_"), MailManDomain "
 .S TMP=TMP_"("_MAILMAN_"), and 'SourceType' ("_SRCTYPE_") could not "
 .S TMP=TMP_"be found/created in HDIS SYSTEM file (#7718.21)"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Make sure entry in HDIS Parameter file exists for system
 I 'OOPS I '$$GETPTR^HDISVF10(SYSPTR) I '$$PARAMINI^HDISVF10(SYSPTR,"","","",1) D
 .S TMP="Entry for XML elements 'Source' ("_SOURCE_"), 'MailManDomain' "
 .S TMP=TMP_"("_MAILMAN_"), and 'SourceType' ("_SRCTYPE_") could not "
 .S TMP=TMP_"be found/created in HDIS PARAMETER file (#7718.29)"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Processing of VUID requests from specific system disabled
 I 'OOPS I $$GETVFAIL^HDISVF02(SYSPTR) D
 .S TMP="Processing of VUID requests from 'Source' ("_SOURCE_"), "
 .S TMP=TMP_"'MailManDomain' ("_MAILMAN_"), and 'SourceType' ("
 .S TMP=TMP_SRCTYPE_") currently disabled"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Errors found - quit
 I OOPS Q
 ;Process 'File' portion
 D FILE($NA(@DATA@(INDX,1)),EINDX,AINDX,SYSPTR,FFARR,ERRARR)
 ;Error - don't continue
 I +$O(@ERRARR@(0)) K @FFARR Q
 ;Build/send return XML document(s)
 S FFPTR=""
 F  S FFPTR=+$O(@FFARR@(FFPTR)) Q:'FFPTR  D
 .S TMP=$$GETFF^HDISVF05(FFPTR,.FILE,.FIELD)
 .K @XMLDOC
 .;Status update (building msg)
 .D ADDSTAT^HDISVF01(FFPTR,SYSPTR,102,2)
 .;Build XML document
 .I $$FILE^HDISVSFX(DOMPTR,SYSPTR,FFPTR,XMLDOC)<1 D  Q
 ..;Error
 ..S TMP="Unable to build XML document containing VUID information for"
 ..S TMP=TMP_" file "_FILE_" (field "_FIELD_") in the "_DOMAIN
 ..S TMP=TMP_" domain to facility "_SOURCE_" ("_MAILMAN_")"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..;Status update (error)
 ..D ADDSTAT^HDISVF01(FFPTR,SYSPTR,104,2)
 .;Send XML document
 .I $$SNDXML^HDISVM02(XMLDOC,1,,SYSPTR)<1 D  Q
 ..;Error
 ..S TMP="Unable to send XML document containing VUID information for"
 ..S TMP=TMP_" file "_FILE_" (field "_FIELD_") in the "_DOMAIN
 ..S TMP=TMP_" domain to facility "_SOURCE_" ("_MAILMAN_")"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..;Status update (error)
 ..D ADDSTAT^HDISVF01(FFPTR,SYSPTR,104,2)
 .;Status update (msg sent)
 .D ADDSTAT^HDISVF01(FFPTR,SYSPTR,103,2)
 K @FFARR,@XMLDOC
 Q
 ;
FILE(DATA,EINDX,AINDX,SYSPTR,FFARR,ERRARR) ;Process 'File' portion of XML document
 ; Input : DATA - Array reference from which the 'File' element
 ;                begins (closed root)
 ;         EINDX - Element index array (closed root)
 ;         AINDX - Attribute index array (closed root)
 ;         SYSPTR - Pointer to HDIS SYSTEM file (#7118.21)
 ;         FFARR - Array to output File/Field values (closed root)
 ;         ERRARR - Error array (closed root)
 ;Output : None
 ;         @FFARR@(Ptr) = ""
 ;            Ptr - Pointer to HDIS FILE/FIELD file (#7115.6)
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : Existance/validity of input assumed (internal call)
 N INDX,REP,FILE,FIELD,OOPS,FFPTR,LASTERR
 S INDX=@EINDX@("File")
 S REP=0
 F  S REP=+$O(@DATA@(INDX,REP)) Q:'REP  D
 .S OOPS=0
 .;Get elements
 .S FILE=$G(@DATA@(INDX,REP,@EINDX@("FileNumber"),1,"V"))
 .S FIELD=$G(@DATA@(INDX,REP,@EINDX@("FieldNumber"),1,"V"))
 .;Validate elements
 .F TMP="FILE","FIELD" I $G(@TMP)="" D
 ..S Y="FileNumber"
 ..I TMP="FIELD" S Y="FieldNumber"
 ..S X="XML element '"_TMP_"' did not have a value"
 ..D ADDERR^HDISVC00(X,ERRARR)
 ..S OOPS=1
 .;Convert file & field to pointer
 .I FILE I FIELD I '$$GETIEN^HDISVF05(FILE,FIELD,.FFPTR) D
 ..S TMP="Values of XML elements 'FileNumber' ("_FILE
 ..S TMP=TMP_") and 'FieldNumber ("_FIELD_") not found in HDIS"
 ..S TMP=TMP_" FILE/FIELD file (#7115.6)"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 .;Problem(s) found - don't continue
 .I OOPS Q
 .;Add File/Field to output array
 .S @FFARR@(FFPTR)=""
 .;Status update (start VUID assign)
 .D ADDSTAT^HDISVF01(FFPTR,SYSPTR,101,2)
 .;Remember last error number
 .S LASTERR=+$O(@ERRARR@(""),-1)
 .;Process 'Term' portion
 .D TERM^HDISVS02($NA(@DATA@(INDX,REP)),EINDX,AINDX,SYSPTR,FFPTR,ERRARR)
 .;Error(s) added - status update (error)
 .I LASTERR'=+$O(@ERRARR@(""),-1) D ADDSTAT^HDISVF01(FFPTR,SYSPTR,104,2)
 Q
 ;
ELEMENTS ;List of required elements in XML document
 ;;Domain
 ;;DomainName
 ;;Source
 ;;SourceType
 ;;MailManDomain
 ;;File
 ;;FileNumber
 ;;FieldNumber
 ;;Term
 ;;TermName
 ;;VUID
 ;;FacilityInternalReference
 ;;
