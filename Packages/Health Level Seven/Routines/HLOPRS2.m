HLOPRS2 ;ALB/CJM-HL7 - Developer API's for parsing messages(continued) ;05/12/2009
 ;;1.6;HEALTH LEVEL SEVEN;**131,146**;Oct 13, 1995;Build 16
 ;
GETTS(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets a segment value that is a timestamp in HL7 format and converts it 
 ;to FileMan format. IF the segment value included the timezone, it is
 ;the timestamp is converted to local time.
 ;
 ;IF the component is specified, then the component is parsed for data type rather than at the higher field level.
 ;
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a  call to $$NEXTSEG^HLOPRS.
 ;  FIELD - The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - The occurrence # (optional, defaults to 1).  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (pass-by-reference) The date/time in FileMan format.
 ;  VALUE("PRECISION") Expected values are:
 ;           "S" - second
 ;           "M" - minute
 ;           "H" - hour
 ;           "D" - day
 ;           "L" - month
 ;           "Y" - year
 ;           "" - precision not specified
 ;   Note:  FM does not allow greater precision than seconds, so this API will round off to the second.
 ;
 N TIME,PREC,VAR
 Q:'$G(FIELD)
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S:'$G(REP) REP=1
 S @VAR=1,TIME=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=2,PREC=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S VALUE=$$HL7TFM^XLFDT(TIME)
 I '$L(PREC) D
 .I $L(+TIME)>12 S PREC="S" Q
 .I $L(+TIME)>10 S PREC="M" Q
 .I $L(+TIME)>8 S PREC="H" Q
 .I $L(+TIME)>6 S PREC="D" Q
 .I $L(+TIME)>4 S PREC="L" Q
 .I $L(+TIME)=4 S PREC="Y" Q
 S VALUE("PRECISION")=PREC
 Q
 ;
GETDT(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets a segment value that is a date in HL7 format and converts it to FileMan format.
 ;IF the component is specified, then the component is parsed for data type rather than at the higher field level.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a  call to $$NEXTSEG^HLOPRS.
 ;  FIELD - The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (pass-by-reference) The date/time in FileMan format.
 ;  VALUE("PRECISION") - Expected values are:
 ;           "S" - second (not valid for DT)
 ;           "M" - minute (not valid for DT)
 ;           "H" - hour (not valid for DT)
 ;           "D" - day
 ;           "L" - month
 ;           "Y" - year
 ;           "" - not specified
 ;
 N TIME,PREC,VAR
 Q:'$G(FIELD)
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S:'$G(REP) REP=1
 S @VAR=1,TIME=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S VALUE=$$HL7TFM^XLFDT(TIME)
 S PREC=""
 D
 .I $L(+TIME)>12 S PREC="S" Q
 .I $L(+TIME)>10 S PREC="M" Q
 .I $L(+TIME)>8 S PREC="H" Q
 .I $L(+TIME)>6 S PREC="D" Q
 .I $L(+TIME)>4 S PREC="L" Q
 .I $L(+TIME)=4 S PREC="Y" Q
 S VALUE("PRECISION")=PREC
 Q
 ;
GETCE(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets an CE data type(Coded Element, HL7 Section Reference 2.9.8) from the specified field.
 ;IF the component is specified, then the component is parsed for data type rather than at the higher field level.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a call to NEXTSEG^HLOPRS.
 ;  FIELD (required) The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - The occurrence # (optional, defaults to 1).  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (required, pass-by-reference) These subscripts are returned:
 ;    "ID" - the identifier
 ;    "TEXT" - 
 ;    "SYSTEM" - name of the code system
 ;    "ALTERNATE ID" - alternate identifier
 ;    "ALTERNATE TEXT"
 ;    "ALTERNATE SYSTEM" - name of the alternate coding system
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S @VAR=1,VALUE("ID")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=2,VALUE("TEXT")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=3,VALUE("SYSTEM")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=4,VALUE("ALTERNATE ID")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=5,VALUE("ALTERNATE TEXT")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=6,VALUE("ALTERNATE SYSTEM")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 Q
 ;
GETHD(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets an HD data type (Hierarchic Designator, HL7 Section Reference 2.9.21) from the specified field.
 ;IF the component is specified, then the component is parsed for data type rather than at the higher field level.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a call to NEXTSEG^HLOPRS.
 ;  FIELD (required) The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - The occurrence # (optional, defaults to 1).  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (required, pass-by-reference) These subscripts are returned:
 ;    "NAMESPACE ID"
 ;    "UNIVERSAL ID"
 ;    "UNIVERSAL ID TYPE"
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S @VAR=1,VALUE("NAMESPACE ID")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=2,VALUE("UNIVERSAL ID")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=3,VALUE("UNIVERSAL ID TYPE")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 Q
 ;
GETCNE(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets an CNE data type (Coded With No Exceptions, HL7 Section Reference 2.9.8) from the specified field.
 ;IF the component is specified, then the component is parsed for data type rather than at the higher field level.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a call to NEXTSEG^HLOPRS.
 ;  FIELD (required) The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - The occurrence # (optional, defaults to 1).  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (required, pass-by-reference) These subscripts are returned:
 ;    "ID" - the identifier
 ;    "TEXT" - 
 ;    "SYSTEM" - name of the code system
 ;    "ALTERNATE ID" - alternate identifier
 ;    "ALTERNATE TEXT"
 ;    "ALTERNATE SYSTEM" - name of the alternate coding system
 ;    "SYSTEM VERSION" - version ID of the coding system
 ;    "ALTERNATE SYSTEM VERSION" - version ID of the alternate coding system
 ;    "ORIGINAL TEXT"
 ;
 D GETCODE^HLOPRS1(.SEG,.VALUE,.FIELD,.COMP,.REP)
 Q
 ;
GETCWE(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets an CWE data type (Coded With Exceptions, HL7 Section Reference 2.9.11) from the specified field.
 ;IF the component is specified, then the component is parsed for the data type rather than at the higher field level.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a call to NEXTSEG^HLOPRS.
 ;  FIELD (required) The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - The occurrence # (optional, defaults to 1).  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (required, pass-by-reference) These subscripts are returned:
 ;    "ID" - the identifier
 ;    "TEXT" - 
 ;    "SYSTEM" - name of the code system
 ;    "ALTERNATE ID" - alternate identifier
 ;    "ALTERNATE TEXT"
 ;    "ALTERNATE SYSTEM" - name of the alternate coding system
 ;    "SYSTEM VERSION" - version ID of the coding system
 ;    "ALTERNATE SYSTEM VERSION" - version ID of the alternate coding system
 ;    "ORIGINAL TEXT"
 D GETCODE^HLOPRS1(.SEG,.VALUE,.FIELD,.COMP,.REP)
 Q
 ;
GETAD(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets an AD data type (Address, HL7 Section Reference 2.9.1) from the specified field. It can also be used to get the 1st 8 components of the XAD (Extended Address) data type.
 ;IF the component is specified, then the component is parsed for the address rather than at the higher field level.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a call to NEXTSEG^HLOPRS.
 ;  FIELD (required) The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - The occurrence # (optional, defaults to 1).  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (required, pass-by-reference) These subscripts are returned:
 ;    "STREET1" -street address
 ;    "STREET2" - other designation
 ;    "CITY"
 ;    "STATE" - state or province
 ;    "ZIP" - zip or postal code
 ;    "COUNTRY"
 ;    "TYPE"  - address type
 ;    "OTHER" - other geographic designation
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S:'$G(REP) REP=1
 S @VAR=1,VALUE("STREET1")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=2,VALUE("STREET2")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=3,VALUE("CITY")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=4,VALUE("STATE")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=5,VALUE("ZIP")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=6,VALUE("COUNTRY")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=7,VALUE("TYPE")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=8,VALUE("OTHER")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 Q
 ;
 ;**P146 START CJM
GETXPN(SEG,VALUE,FIELD,COMP,REP) ;
 ;Gets an XPN data type (Extended Persons Name, HL7 Section Reference 2.9.1) from the specified field.
 ;IF the component is specified, then the component is parsed for the address rather than at the higher field level.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array returned by a call to NEXTSEG^HLOPRS.
 ;  FIELD (required) The sequence # of the field.
 ;  COMP (optional) If specified, the data type is parsed as a component  value.
 ;  REP - The occurrence # (optional, defaults to 1).  For a non-repeating fields, this parameter is not necessary.
 ;Output:
 ;  VALUE  (required, pass-by-reference) These subscripts are returned:
 ;    "FAMILY"
 ;    "GIVEN" first name
 ;    "SECOND" second and further names or initials
 ;    "SUFFIX" (e.g., JR)
 ;    "PREFIX" (e.g., DR)
 ;    "DEGREE" (e.g., MD)
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S:'$G(REP) REP=1
 S @VAR=1,VALUE("FAMILY")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=2,VALUE("GIVEN")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=3,VALUE("SECOND")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=4,VALUE("SUFFIX")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=5,VALUE("PREFIX")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=6,VALUE("DEGREE")=$$GET^HLOPRS(.SEG,FIELD,COMP,SUB,REP)
 Q
 ;** P146 END CJM
