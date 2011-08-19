HDISVS00 ;BPFO/JRP - PROCESS XML DOCS ON CENTRAL SERVER;1/4/2005
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
MAIN(PRSARR,ERRARR) ;Main entry point for processing XML document
 ; Input : PRSARR - Array containing parsed XML document (closed root)
 ;                  This is the output of SAX^HDISVM01
 ;         ERRARR - Array to output errors in (closed root)
 ;Output : None
 ;         @ERRARR@(x) = Error text (if applicable)
 ; Notes : ERRARR is initialized (KILLed) on input
 N ROOT,TMP,OOPS,CODE,DESC
 ;Check input
 I $G(PRSARR)="" D  Q
 .S TMP="MAIN^HDISVS00: Input parameter PRSARR was not passed"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 I '$D(@PRSARR) D  Q
 .S TMP="MAIN^HDISVS00: Input array "_PRSARR_" (PRSARR) does not exist"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 ;Make sure data structure of parsed document exists
 S OOPS=0
 F X=1:1 S TMP=$P($T(SUBS+X),";;",2) Q:TMP=""  D
 .I $D(@PRSARR@(TMP)) Q
 .S TMP="MAIN^HDISVS00: Subscript "_TMP_" missing from input array "_PRSARR_" (PRSARR)"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 .S OOPS=1
 I OOPS Q
 ;Get root element name
 S ROOT=$G(@PRSARR@("ESUBS",1))
 I ROOT="" D  Q
 .S TMP="Root element of XML document could not be determined"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 ;Check for supported root element
 S OOPS=1
 F X=1:1 S TMP=$P($T(ROOTS+X),";;",2) Q:TMP=""  D  Q:'OOPS
 .I $P(TMP,"~",1)'=ROOT Q
 .S CODE=$P(TMP,"~",2)
 .S DESC=$P(TMP,"~",3)
 .S OOPS=0
 ;Unsupported root element
 I OOPS D  Q
 .S TMP="'"_ROOT_"' is not a supported root element (don't know how to process it)"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 ;Code to process document not set
 I CODE="" D  Q
 .S TMP="Code to process root element '"_ROOT_"' has not been established"
 .D ADDERR^HDISVC00(TMP,ERRARR)
 ;Process XML document
 X CODE
 ;Done
 Q
 ;
SUBS ;Required subscripts in parse array (attributes aren't required)
 ;;EINDX
 ;;ESUBS
 ;;DATA
 ;;
 ;
ROOTS ;Root element name~Processing code for root element~Description
 ;;Domain~D VUID^HDISVS01(PRSARR,ERRARR)~Request for VUID data from VistA system
 ;;HDISParameters~D STATUS^HDISVS03(PRSARR,ERRARR)~Status update from VistA system
 ;;
