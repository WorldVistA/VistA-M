HLOAPI4 ;ALB/CJM-HL7 - Developer API's for sending & receiving messages(continued) ;08/19/2009
 ;;1.6;HEALTH LEVEL SEVEN;**131,134,146**;Oct 13, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SETTS(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets a value that is a timestamp in FM format into the segment in HL7
 ;format. The degree of precision may be optionally specified. The
 ;inserted value will include the timezone if the input included the time.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required)to be set into the segment
 ;  VALUE("PRECISION") (optional) If included, VALUE must be passed by
 ;       reference.  Allowed values are:
 ;           "S" - seconds (default value)
 ;           "M" - minutes
 ;           "H" - hours
 ;           "D" - days
 ;  FIELD - the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating.
 ;Output: 
 ;   SEG array
 ;
 ;Example:
 ;    D SETTS^HLOAPI4(.SEG,$$NOW^XLFDT,1) will place the current date/time into the segment in the 1st field,1st occurence.  The timezone is included.
 ;
 ;
 N TIME
 Q:'$G(FIELD)
 Q:'$G(VALUE)
 S:'$G(REP) REP=1
 S:'$G(COMP) COMP=1
 S TIME=$$FMTHL7^XLFDT(VALUE)
 I $D(VALUE("PRECISION")) D
 .N TZ
 .S TZ=""
 .I TIME["+" S TZ="+"_$P(TIME,"+",2)
 .E  I TIME["-" S TZ="-"_$P(TIME,"-",2)
 .I VALUE("PRECISION")="D" D
 ..S TIME=$E(TIME,1,8)_TZ
 .E  I VALUE("PRECISION")="H" D
 ..S TIME=$E($$LJ^XLFSTR(+TIME,10,0),1,10)_TZ
 .E  I VALUE("PRECISION")="M" D
 ..S TIME=$E($$LJ^XLFSTR(+TIME,12,0),1,12)_TZ
 .E  I VALUE("PRECISION")="S" D
 ..S TIME=$E($$LJ^XLFSTR(+TIME,14,0),1,14)_TZ
 S SEG(FIELD,REP,COMP,1)=TIME
 Q
 ;
SETDT(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets a value that is a date in FM format into the segment in HL7 format.  The degree of precision may be optionally specified.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required)the date to be set into the segment
 ;  VALUE("PRECISION") (optional) If included, VALUE must be passed by
 ;       reference.  Allowed values are:
 ;           "D" - day (default value)
 ;           "L" - month
 ;           "Y" - year
 ;  FIELD - the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating.
 ;Output:
 ;   SEG - segment that is being built
 ;
 ;Example:
 ;    D SETDT^HLOAPI4(.SEG,$$TODAY^XLFDT,1) will place the current date into segment in the 1st field,1st occurence.
 ;
 ;
 N TIME
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 S:'$G(COMP) COMP=1
 S TIME=$$FMTHL7^XLFDT(VALUE)
 I $D(VALUE("PRECISION")) D
 .I VALUE("PRECISION")="Y" D
 ..S TIME=$E(TIME,1,4)
 .E  I VALUE("PRECISION")="L" D
 ..S TIME=$E(TIME,1,6)
 .E  I VALUE("PRECISION")="D" D
 ..S TIME=$E(TIME,1,8)
 S SEG(FIELD,REP,COMP,1)=TIME
 Q
 ;
SETCE(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets a value that is an HL7 Coded Element data type (HL7 Section Reference 2.9.3) into the segment in the specified field.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required, pass-by-reference) These subscripts may be passed:
 ;    "ID" - the identifier
 ;    "TEXT" - 
 ;    "SYSTEM" - name of the code system
 ;    "ALTERNATE ID" - alternate identifier
 ;    "ALTERNATE TEXT"
 ;    "ALTERNATE SYSTEM" - name of the alternate coding system
 ;  FIELD (required) the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating fields, this parameter is not necessary.
 ;Output: 
 ;   SEG - segment that is being built
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S @VAR=1,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ID"))
 S @VAR=2,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("TEXT"))
 S @VAR=3,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("SYSTEM"))
 S @VAR=4,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ALTERNATE ID"))
 S @VAR=5,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ALTERNATE TEXT"))
 S @VAR=6,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ALTERNATE SYSTEM"))
 Q
 ;
SETHD(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets a value that is an HL7 Hierarchic Designator data type (HL7 Section Reference 2.9.21) into the segment in the specified field.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required, pass-by-reference) These subscripts may be passed:
 ;    "NAMESPACE ID"
 ;    "UNIVERSAL ID"
 ;    "UNIVERSAL ID TYPE"
 ;  FIELD (required) the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating fields, this parameter is not necessary.
 ;Output: 
 ;   SEG - segment that is being built
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S @VAR=1,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("NAMESPACE ID"))
 S @VAR=2,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("UNIVERSAL ID"))
 S @VAR=3,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("UNIVERSAL ID TYPE"))
 Q
 ;
SETCNE(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets a value that is an HL7 Coded With No Exceptions  data type (HL7 Section Reference 2.9.8) into the segment in the specified field.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required, pass-by-reference) These subscripts may be passed:
 ;    "ID" - the identifier
 ;    "TEXT" - 
 ;    "SYSTEM" - name of the code system
 ;    "ALTERNATE ID" - alternate identifier
 ;    "ALTERNATE TEXT"
 ;    "ALTERNATE SYSTEM" - name of the alternate coding system
 ;    "SYSTEM VERSION" - version ID of the coding system
 ;    "ALTERNATE SYSTEM VERSION" - version ID of the alternate coding system
 ;    "ORIGINAL TEXT"
 ;  FIELD (required) the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating fields, this parameter is not necessary.
 ;Output: 
 ;   SEG - segment that is being built
 D SETCODE^HLOAPI2(.SEG,.VALUE,.FIELD,.COMP,.REP)
 Q
 ;
SETCWE(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets a value that is an HL7 Coded With Exceptions  data type (HL7 Section Reference 2.9.11) into the segment in the specified field.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required, pass-by-reference) These subscripts may be passed:
 ;    "ID" - the identifier
 ;    "TEXT" - 
 ;    "SYSTEM" - name of the code system
 ;    "ALTERNATE ID" - alternate identifier
 ;    "ALTERNATE TEXT"
 ;    "ALTERNATE SYSTEM" - name of the alternate coding system
 ;    "SYSTEM VERSION" - version ID of the coding system
 ;    "ALTERNATE SYSTEM VERSION" - version ID of the alternate coding system
 ;    "ORIGINAL TEXT"
 ;  FIELD (required) the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating fields, this parameter is not necessary.
 ;Output: 
 ;   SEG - segment that is being built
 D SETCODE^HLOAPI2(.SEG,.VALUE,.FIELD,.COMP,.REP)
 Q
 ;
SETAD(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets an AD data type (Address, HL7 Section Reference 2.9.1) into the segment in the specified field. It can also be used to set the 1st 8 components of the XAD (Extended Address) data type.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required, pass-by-reference) These subscripts may be passed:
 ;    "STREET1" -street address
 ;    "STREET2" - other designation
 ;    "CITY"
 ;    "STATE" - state or province
 ;    "ZIP" - zip or postal code
 ;    "COUNTRY"
 ;    "TYPE"  - address type
 ;    "OTHER" - other geographic designation
 ;  FIELD (required) the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating fields, this parameter is not necessary.
 ;Output: 
 ;   SEG - segment that is being built
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S @VAR=1,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("STREET1"))
 S @VAR=2,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("STREET2"))
 S @VAR=3,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("CITY"))
 S @VAR=4,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("STATE"))
 S @VAR=5,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ZIP"))
 S @VAR=6,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("COUNTRY"))
 S @VAR=7,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("TYPE"))
 S @VAR=8,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("OTHER"))
 Q
 ;
 ;** P146 START CJM
SETXPN(SEG,VALUE,FIELD,COMP,REP) ;
 ;Sets an XPN data type (extended person name) into the segment in the specified field.
 ;IF the component is specified, then the data type is 'demoted' to a component, and its components are 'demoted' to subcomponents.
 ;
 ;Input:
 ;  SEG - (required, pass by reference) The array where the seg is being built.
 ;  VALUE  (required, pass-by-reference) These subscripts may be passed:
 ;    "FAMILY"
 ;    "GIVEN" first name
 ;    "SECOND" second and further names or initials
 ;    "SUFFIX" (e.g., JR)
 ;    "PREFIX" (e.g., DR)
 ;    "DEGREE" (e.g., MD)
 ;  FIELD (required) the sequence # of the field
 ;  COMP (optional) If specified, the data type is 'demoted' to a component value.
 ;  REP - the occurrence# (optional, defaults to 1)  For a non-repeating fields, this parameter is not necessary.
 ;Output: 
 ;   SEG - segment that is being built
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S @VAR=1,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("FAMILY"))
 S @VAR=2,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("GIVEN"))
 S @VAR=3,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("SECOND"))
 S @VAR=4,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("SUFFIX"))
 S @VAR=5,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("PREFIX"))
 S @VAR=6,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("DEGREE"))
 Q
 ;**P146 END CJM
