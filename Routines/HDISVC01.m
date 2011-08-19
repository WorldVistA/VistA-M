HDISVC01 ;BPFO/JRP - PROCESS RECEIVED XML DATA;12/20/2004 ; 10 Mar 2005  11:23 AM
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
DOMAIN(PRSARR,ERRARR) ;Process XML data from VUID Server
 ; Input : PRSARR - Array containing parsed XML document (closed root)
 ;                  This is the output of SAX^HDISVM01
 ;         ERRARR - Array to output errors in (closed root)
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : ERRARR is initialized (KILLed) on input
 ;
 ;Processing of VUID data disabled - throw error and quit
 I $$GETVFAIL^HDISVF02() D  Q
 .N TMP
 .S TMP="DOMAIN^HDISVC01: Processing of VUID data from central server"
 .S TMP=TMP_" is currently disabled"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 N EINDX,ESUBS,AINDX,ASUBS,DATA,TMP,X,Y
 N DOMAIN,SOURCE,MAILMAN,INDX,OOPS
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
 .S TMP="DOMAIN^HDISVC01: Input parameter PRSARR was not passed"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 I '$D(@PRSARR) D  Q
 .S TMP="DOMAIN^HDISVC01: Input array "_PRSARR_" (PRSARR) does not exist"
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
 S MAILMAN=$G(@DATA@(INDX,1,@EINDX@("MailManDomain"),1,"V"))
 ;Validate elements
 F TMP="DOMAIN","SOURCE","MAILMAN" I $G(@TMP)="" D
 .S Y="DomainName"
 .I TMP="SOURCE" S Y="Source"
 .I TMP="MAILMAN" S Y="MailManDomain"
 .S X="XML element '"_TMP_"' did not have a value"
 .D ADDERR^HDISVC00(X,ERRARR)
 .S OOPS=1
 ;Ensure that 'Source' matches local number
 I SOURCE'="" I SOURCE'=$$FACNUM^HDISVF01() D
 .S TMP="Value of XML element 'Source' ("_SOURCE
 .S TMP=TMP_") does not match local facility number"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Ensure that 'MailManDomain' matches local domain
 I MAILMAN'="" I MAILMAN'=$G(^XMB("NETNAME")) D
 .S TMP="Value of XML element 'MailManDomain' ("_MAILMAN
 .S TMP=TMP_") does not match local domain"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 ;Errors found - quit
 I OOPS Q
 ;Process 'File' portion
 D FILE($NA(@DATA@(INDX,1)),EINDX,AINDX,ERRARR,DOMAIN)
 Q
 ;
FILE(DATA,EINDX,AINDX,ERRARR,DOMAIN) ;Process 'File' portion of XML document
 ; Input : DATA - Array reference from which the 'File' element
 ;                begins (closed root)
 ;         EINDX - Element index array (closed root)
 ;         AINDX - Attribute index array (closed root)
 ;         ERRARR - Error array (closed root)
 ;         DOMAIN - Value of 'DomainName' element
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : Existance/validity of input assumed (internal call)
 N INDX,REP,FILE,FIELD,OOPS,EXIST,LASTERR,X,Y,TMP
 N FACPTR,FACNAME,FACNUM,IPADD,SYSTYPE,FILENAME
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
 .;Errors found - quit
 .I OOPS Q
 .I '$$VFILE^DILFD(FILE) D
 ..S TMP="Repetition number "_REP_" of XML element 'FileNumber' "
 ..S TMP=TMP_"is not a valid file number"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 .I 'OOPS I '$$VFIELD^DILFD(FILE,FIELD) D
 ..S TMP="Repetition number "_REP_" of XML element 'FieldNumber' "
 ..S TMP=TMP_"is not a valid field number"
 ..D ADDERR^HDISVC00(TMP,ERRARR)
 ..S OOPS=1
 .;Errors found - quit
 .I OOPS Q
 .;Status update - VUIDs received
 .S TMP=$$STATUPD^HDISVCUT(FILE,FIELD,3)
 .;Make sure VUID and status fields are defined
 .I '$$SETCODE^HDISVC02(FILE,FIELD) S EXIST=$$FLDXST(FILE) I 'EXIST D
 ..F TMP=2:1:4 I '$P(EXIST,"^",TMP) D
 ...S X="File number "_FILE_" is missing field number "
 ...I TMP=2 S X=X_"99.99 (VUID)"
 ...I TMP=3 S X=X_"99.991 (EFFECTIVE DATE multiple)"
 ...I TMP=4 S X=X_".02 (STATUS) of EFFECTIVE DATE multiple (99.991)"
 ...D ADDERR^HDISVC00(X,ERRARR)
 ...I TMP=3 S TMP=4
 ..S OOPS=1
 .;Problem(s) found - don't continue
 .I OOPS D  Q
 ..;Status update (error)
 ..S TMP=$$STATUPD^HDISVCUT(FILE,FIELD,5)
 .;Remember last error number
 .S LASTERR=+$O(@ERRARR@(""),-1)
 .;Process 'Term' portion
 .D TERM^HDISVC02($NA(@DATA@(INDX,REP)),EINDX,AINDX,ERRARR,FILE,FIELD)
 .;Error(s) added - status update (error)
 .I LASTERR'=+$O(@ERRARR@(""),-1) S TMP=$$STATUPD^HDISVCUT(FILE,FIELD,5) Q
 .;Status update (VUIDs assigned)
 .S TMP=$$STATUPD^HDISVCUT(FILE,FIELD,4)
 .;Notify ERT that VUID's have been stored
 .K FACPTR,IPADD,SYSTYPE
 .I '$$GETFAC^HDISVF07(,.FACPTR) S FACPTR=$$FACPTR^HDISVF01()
 .I '$$GETDIP^HDISVF07(,.IPADD) S IPADD=$G(^XMB("NETNAME"))
 .I '$$GETTYPE^HDISVF07(,,.SYSTYPE) D
 ..S SYSTYPE=$$PROD^XUPROD()
 ..S SYSTYPE=$S(SYSTYPE:"PRODUCTION",1:"TEST")
 .S TMP=$$NS^XUAF4(FACPTR)
 .S FACNAME=$P(TMP,"^",1)
 .S FACNUM=$P(TMP,"^",2)
 .I (FACNAME="")!(FACNUM="") D
 ..S TMP=$$SITE^VASITE()
 ..S FACNAME=$P(TMP,"^",2)
 ..S FACNUM=$P(TMP,"^",3)
 .S FACNAME=FACNAME_" (#"_FACNUM_") with Domain/IP Address "_IPADD
 .S FILENAME=$$GET1^DID(FILE,,,"NAME")
 .S FILENAME=FILENAME_" (#"_FILE_")"
 .D ERTBULL^HDISVF09(FACNAME,FILENAME,$$NOW^XLFDT(),SYSTYPE,FACNUM,FILE)
 Q
 ;
FLDXST(FILE) ;Check for existance of VUID and status fields
 ; Input : FILE - File number
 ;Output : 1 = Required VUID and status fields exist
 ;         0^VUID^Status^StatusDate = One or more fields missing
 ;                                    0 put in piece of missing field
 ; Notes : Existance/validity of input assumed (internal call)
 N VUID,STAT,STDT,OUTPUT,SUBFILE
 S (OUTPUT,VUID,STAT,STDT)=1
 ;VUID field
 I '$$VFIELD^DILFD(FILE,99.99) D
 .S OUTPUT=0
 .S VUID=0
 ;EFFECTIVE DATE multiple
 I '$$VFIELD^DILFD(FILE,99.991) D
 .S OUTPUT=0
 .S (STAT,STDT)=0
 S SUBFILE=+$$GET1^DID(FILE,99.991,"","SPECIFIER")
 I 'SUBFILE D
 .S OUTPUT=0
 .S (STAT,STDT)=0
 ;STATUS sub-field
 I SUBFILE I '$$VFIELD^DILFD(SUBFILE,.02) D
 .S OUTPUT=0
 .S STDT=0
 I 'OUTPUT S OUTPUT=OUTPUT_"^"_VUID_"^"_STAT_"^"_STDT
 Q OUTPUT
 ;
ELEMENTS ;List of required elements in XML document
 ;;Domain
 ;;DomainName
 ;;Source
 ;;MailManDomain
 ;;File
 ;;FileNumber
 ;;FieldNumber
 ;;Term
 ;;TermName
 ;;VUID
 ;;NationalTerm
 ;;FacilityInternalReference
 ;;
