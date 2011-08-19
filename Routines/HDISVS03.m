HDISVS03 ;BPFO/JRP - PROCESS RECEIVED XML DATA;1/6/2005 ; 08 Mar 2005  9:10 AM
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
STATUS(PRSARR,ERRARR) ;Process status update from VistA system
 ; Input : PRSARR - Array containing parsed XML document (closed root)
 ;                  This is the output of SAX^HDISVM01
 ;         ERRARR - Array to output errors in (closed root)
 ;Output : None
 ;         ERRARR(x) = Error text (if applicable)
 ; Notes : ERRARR is initialized (KILLed) on input
 ;
 ;Processing of all status updates disabled - throw error and quit
 I $$GETSDIS^HDISVF03() D  Q
 .N TMP
 .S TMP="STATUS^HDISVS03: Processing of status updates by central "
 .S TMP=TMP_"server is currently disabled"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 N EINDX,ESUBS,AINDX,ASUBS,DATA,TMP,DATE,STATPTR,SRCTYPE,SYSPTR
 N SOURCE,MAILMAN,FILE,FIELD,STAT,STATDT,INDX,OOPS,CODE,CODEPTR
 S EINDX=$NA(@PRSARR@("EINDX"))
 S ESUBS=$NA(@PRSARR@("ESUBS"))
 S AINDX=$NA(@PRSARR@("AINDX"))
 S ASUBS=$NA(@PRSARR@("ASUBS"))
 S DATA=$NA(@PRSARR@("DATA"))
 S OOPS=0
 S ERRARR=$G(ERRARR)
 I ERRARR'="" K @ERRARR
 S PRSARR=$G(PRSARR)
 I PRSARR="" D  Q
 .S TMP="SATUS^HDISVS03: Input parameter PRSARR was not passed"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 I '$D(@PRSARR) D  Q
 .S TMP="STATUS^HDISVS0S: Input array "_PRSARR_" (PRSARR) does not exist"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Ensure all elements are indexed
 F X=1:1 S TMP=$P($T(ELEMENTS+X),";;",2) Q:TMP=""  D
 .I '$D(@EINDX@(TMP)) D
 ..S TMP="XML element '"_TMP_"' was not found in the XML document"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 ;Ensure that 'HDISParameters' is the root element
 I $G(@ESUBS@(1))'="HDISParameters" D
 .S TMP="'HDISParameters' was not the root element in the XML document"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Errors found - quit
 I OOPS Q
 ;Process 'HDISParameters' portion of XML doc
 S INDX=@EINDX@("HDISParameters")
 ;Get elements
 S SOURCE=$G(@DATA@(INDX,1,@EINDX@("Source"),1,"V"))
 S SRCTYPE=$G(@DATA@(INDX,1,@EINDX@("SourceType"),1,"V"))
 S MAILMAN=$G(@DATA@(INDX,1,@EINDX@("MailManDomain"),1,"V"))
 S FILE=$G(@DATA@(INDX,1,@EINDX@("FileNumber"),1,"V"))
 S FIELD=$G(@DATA@(INDX,1,@EINDX@("FieldNumber"),1,"V"))
 S STAT=$G(@DATA@(INDX,1,@EINDX@("StatusCode"),1,"V"))
 S STATDT=$G(@DATA@(INDX,1,@EINDX@("StatusDateTime"),1,"V"))
 ;Validate elements
 F TMP="SOURCE","MAILMAN","FILE","FIELD","STAT","STATDT","SRCTYPE" I $G(@TMP)="" D
 .S Y="Source"
 .I TMP="SRCTYPE" S Y="SourceType"
 .I TMP="MAILMAN" S Y="MailManDomain"
 .I TMP="FILE" S Y="FileNumber"
 .I TMP="FIELD" S Y="FieldNumber"
 .I TMP="STAT" S Y="StatusCode"
 .I TMP="STATDT" S Y="StatusDateTime"
 .S X="XML element '"_TMP_"' did not have a value"
 .D ADDERR^HDISVC00(X,ERRARR)
 .S OOPS=1
 ;Validate facility number
 I SOURCE'="" I '$$FACPTR^HDISVF01(SOURCE) D
 .S TMP="Value of XML element 'Source' ("_SOURCE
 .S TMP=TMP_") is not a valid facility number"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Get pointer to system
 I 'OOPS I '$$FINDSYS^HDISVF07(MAILMAN,SOURCE,SRCTYPE,1,.SYSPTR) D
 .S TMP="Entry for XML elements 'Source' ("_SOURCE_"), MailManDomain "
 .S TMP=TMP_"("_MAILMAN_"), and 'SourceType' ("_SRCTYPE_") could not "
 .S TMP="be found/created in HDIS SYSTEM file (#7718.21)"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Make sure entry in HDIS Parameter file exists for system
 I 'OOPS I '$$GETPTR^HDISVF10(SYSPTR) I '$$PARAMINI^HDISVF10(SYSPTR,"","","",1) D
 .S TMP="Entry for XML elements 'Source' ("_SOURCE_"), 'MailManDomain' "
 .S TMP=TMP_"("_MAILMAN_"), and 'SourceType' ("_SRCTYPE_") could not "
 .S TMP="be found/created in HDIS PARAMETER file (#7718.29)"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Processing of status updates from specific system disabled
 I 'OOPS I $$GETSDIS^HDISVF03(SYSPTR) D
 .S TMP="Processing of status udpates from 'Source' ("_SOURCE_"), "
 .S TMP=TMP_"'MailManDomain' ("_MAILMAN_"), and 'SourceType' ("
 .S TMP=TMP_SRCTYPE_") currently disabled"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Errors found - quit
 I OOPS Q
 ;Translate client's status code to a server status code
 ;  Server status codes currently mirror the client status codes
 S CODEPTR=0
 I STAT'="" I '$$GETIEN^HDISVF06(STAT,2,.CODEPTR) D
 .S TMP="Unable to convert value of 'StatusCode' ("_STAT
 .S TMP=TMP_") to it's server side equivalent"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 .S CODEPTR=0
 I CODEPTR I '$$GETCODE^HDISVF06(CODEPTR,.CODE) D
 .S TMP="Unable to convert value of 'StatusCode' ("_STAT
 .S TMP=TMP_") to it's server side equivalent"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Convert status date/time to FileMan format
 I STATDT'="" S DATE=$$XMLTFM^HDISVU01(STATDT,1) I DATE="" D
 .S TMP="Unable to convert value of 'StatusDateTime' ("_STATDT
 .S TMP=TMP_") to FileMan format"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Errors found - quit
 I OOPS Q
 ;Store status
 D SETSTAT^HDISVF01(FILE,FIELD,CODE,DATE,2,SOURCE,MAILMAN,SRCTYPE)
 Q
 ;
ELEMENTS ;List of required elements in XML document
 ;;HDISParameters
 ;;Source
 ;;SourceType
 ;;MailManDomain
 ;;FileNumber
 ;;FieldNumber
 ;;StatusCode
 ;;StatusDateTime
 ;;
