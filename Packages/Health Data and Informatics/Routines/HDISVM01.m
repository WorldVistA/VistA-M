HDISVM01 ;BPFO/JRP - PARSE XML DOCUMENT USING SAX;12/20/2004
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
SAX(XMLARR,PRSARR) ;Parse XML document using SAX interface
 ; Input: XMLARR - Global array containing XML document (closed root)
 ;        PRSARR - Array to output parsed XML document (closed root)
 ;Output: None
 ;        @PRSARR@("ESUBS",ESN) = Element name
 ;        @PRSARR@("EINDX",ElementName) = Subscript number (ESN)
 ;        @PRSARR@("ASUBS",ESN,ASN) = Attribute name
 ;        @PRSARR@("AINDX",ESN,AttributeName) = Subscript number (ASN)
 ;        @PRSARR@("DATA",ESN,Repetition,"V") = Value of element
 ;        @PRSARR@("DATA",ESN,Repetition,"A",ASN) = Value of attribute
 ;        @PRSARR@("DATA",ESN1,Rep1,ESN2,Rep2,"V") = Value of child
 ;                                                   element
 ;        @PRSARR@("DATA",ESN1,Rep1,ESN2,Rep2,"A",ASN) = Value of child
 ;                                                       attribute
 ; Notes : XMLARR must be a global array (i.e. no local arrays)
 ;       : PRSARR is initialized (i.e KILLed) on input
 Q:$G(XMLARR)=""
 Q:'$D(@XMLARR)
 Q:$G(PRSARR)=""
 N HDICBK,SUBNUM,TAGNAME
 N ESUBS,EINDX,ASUBS,AINDX,DATA
 S ESUBS=$NA(@PRSARR@("ESUBS"))
 S EINDX=$NA(@PRSARR@("EINDX"))
 S ASUBS=$NA(@PRSARR@("ASUBS"))
 S AINDX=$NA(@PRSARR@("AINDX"))
 S DATA=$NA(@PRSARR@("DATA"))
 ;Set callbacks
 S HDICBK("STARTDOCUMENT")="STRTDOC^HDISVM01"
 S HDICBK("ENDDOCUMENT")="ENDDOC^HDISVM01"
 S HDICBK("DOCTYPE")="DOCTYPE^HDISVM01"
 S HDICBK("STARTELEMENT")="STRTLMNT^HDISVM01"
 S HDICBK("ENDELEMENT")="ENDLMNT^HDISVM01"
 S HDICBK("CHARACTERS")="CHARS^HDISVM01"
 S HDICBK("PI")="PI^HDISVM01"
 S HDICBK("EXTERNAL")="EXTERN^HDISVM01"
 S HDICBK("NOTATION")="NOTATION^HDISVM01"
 S HDICBK("COMMENT")="COMMENT^HDISVM01"
 S HDICBK("ERROR")="ERROR^HDISVM01"
 ;Parse XML document using SAX
 K @PRSARR
 D EN^MXMLPRSE(XMLARR,.HDICBK,"")
 Q
 ;
STRTDOC ;Start document
 Q
 ;
ENDDOC ;End document
 Q
 ;
DOCTYPE(ROOT,PUBID,SYSID) ;DOCTYPE declaration
 Q
 ;
STRTLMNT(NAME,ATTRLIST) ;Start element
 N ESN,REP,ATTR,ASN,TMPREF
 ;Determine element subscript number
 S ESN=+$G(@EINDX@(NAME))
 I 'ESN D
 .S ESN=1+$O(@ESUBS@(""),-1)
 .S @ESUBS@(ESN)=NAME
 .S @EINDX@(NAME)=ESN
 ;Determine repetition number
 S REP=1+$O(@DATA@(ESN,""),-1)
 ;Add element subscript number and repetition number to output array
 S TMPREF=$$OREF^DILF(DATA)
 S TMPREF=TMPREF_ESN_","_REP_","
 S DATA=$$CREF^DILF(TMPREF)
 ;Store attributes
 S ATTR=""
 F  S ATTR=$O(ATTRLIST(ATTR)) Q:ATTR=""  D
 .;Get attribute subscript number
 .S ASN=+$G(@AINDX@(ESN,ATTR))
 .I 'ASN D
 ..S ASN=1+$O(@ASUBS@(""),-1)
 ..S @ASUBS@(ESN,ASN)=ATTR
 ..S @AINDX@(ESN,ATTR)=ASN
 .;Store value
 .S @DATA@("A",ASN)=ATTRLIST(ATTR)
 Q
 ;
ENDLMNT(NAME) ;End element
 N TMPREF,SUBCNT,SUBCHK
 ;Remove element subscript number and repition number from output array
 S TMPREF=$$OREF^DILF(DATA)
 S SUBCNT=$L(TMPREF,",")
 S SUBCHK=SUBCNT-3
 I SUBCHK>0 S TMPREF=$P(TMPREF,",",1,SUBCHK)_","
 I SUBCHK<1 S TMPREF=$P(TMPREF,"(",1)_"("
 S DATA=$$CREF^DILF(TMPREF)
 Q
 ;
CHARS(TEXT) ;Non-markup content
 ;Store element value
 S @DATA@("V")=TEXT
 Q
 ;
PI(TARGET,TEXT) ;Processing instruction
 Q
 ;
EXTERN(SYSID,PUBID,GLOBAL) ;External entity reference
 Q
 ;
NOTATION(NAME,SYSID,PUBID) ;Notation declaration
 Q
 ;
COMMENT(TEXT) ;Comment
 Q
 ;
ERROR(ERR) ;Error
 Q
 ;
UNESC(TEXT) ;Convert escaped characters
 ;Assumes TEXT is not corrupt
 N ESCBEG,ESCEND,ESCTXT,ESCCHAR,OUTPUT
 S TEXT=$G(TEXT)
 I TEXT="" Q TEXT
 I TEXT'["&" Q TEXT
 ;Do conversion
 S OUTPUT=""
 F  Q:TEXT'["&"  D
 .;Find escaped character
 .S ESCBEG=$F(TEXT,"&")
 .S ESCEND=$F(TEXT,";",ESCBEG)
 .S ESCTXT=$E(TEXT,ESCBEG,ESCEND-2)
 .;Convert escaped character
 .S ESCCHAR=""
 .I ESCTXT="amp" S ESCCHAR="&"
 .I ESCTXT="lt" S ESCCHAR="<"
 .I ESCTXT="gt" S ESCCHAR=">"
 .I ESCTXT="apos" S ESCCHAR="'"
 .I ESCTXT="quot" S ESCCHAR=$C(34)
 .;Replace escaped character with actual character
 .S OUTPUT=OUTPUT_$E(TEXT,1,ESCBEG-2)_ESCCHAR
 .;Continue processing rest of string
 .S TEXT=$E(TEXT,ESCEND,$L(TEXT))
 ;Add on remainder of text
 S OUTPUT=OUTPUT_TEXT
 Q OUTPUT
