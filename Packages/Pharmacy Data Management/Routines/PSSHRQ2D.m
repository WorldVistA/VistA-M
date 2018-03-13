PSSHRQ2D ;BIRM/CMF - extension of PSSHRQ23 ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**178**;9/30/97;Build 14
 ;;
 ; @authors - Chris Flegel
 ; @date    - 25 February 2014
 ; @version - 1.0
 ;;
 QUIT
 ;;
PARSEDSP(DOCHAND,NODE,HASH,COUNT) ;
 ; @DESC Parses a dose percent element and stores values in HASH parameter
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @HASH Passed by ref. Used to store return values.
 ; @COUNT Count of drugs
 ;
 ; @RETURNS Nothing, Values stored in HASH values
 ;
 N NAME
 S NAME=$$NAME^MXMLDOM(DOCHAND,NODE)
 D:$$NAME^MXMLDOM(DOCHAND,NODE+1)="databaseValue" 
 .S HASH(COUNT,NAME,"databaseValue")=$$GETTEXT^PSSHRCOM(DOCHAND,NODE+1)
 .Q
 D:$$NAME^MXMLDOM(DOCHAND,NODE+2)="doseValue" 
 .S HASH(COUNT,NAME,"doseValue")=$$GETTEXT^PSSHRCOM(DOCHAND,NODE+2)
 .Q
 D:$$NAME^MXMLDOM(DOCHAND,NODE+3)="percentError" 
 .S HASH(COUNT,NAME,"percentError")=$$GETTEXT^PSSHRCOM(DOCHAND,NODE+3)
 .Q
 D:$$NAME^MXMLDOM(DOCHAND,NODE+4)="unitOfMeasure" 
 .S HASH(COUNT,NAME,"unitOfMeasure")=$$GETTEXT^PSSHRCOM(DOCHAND,NODE+4)
 .Q
 Q
 ;;
WRITEDSP(NODE,HASH,COUNT,IEN,NAME,ALTNAME,ALTNODE) ;
 ; @DESC Writes a dose percent element from HASH parameter to output global
 ;
 ; @NODE Node associated with XML element
 ; @HASH Passed by ref. Used to store return values.
 ; @COUNT Count of drugs
 ;
 ; @RETURNS Nothing, Values stored in HASH values
 ;
 S ALTNAME=$G(ALTNAME)
 S ALTNAME=$S(ALTNAME'="":ALTNAME,1:NAME)
 S ALTNODE=$G(ALTNODE)
 N SUB
 F SUB="databaseValue","doseValue","percentError","unitOfMeasure" D 
 .Q:$G(HASH(COUNT,NAME,SUB))=""
 .I ALTNODE'="" S @NODE@(ALTNODE,$$UP^XLFSTR(ALTNAME),$$UP^XLFSTR(SUB),IEN)=$G(HASH(COUNT,NAME,SUB))
 .E  S @NODE@($$UP^XLFSTR(ALTNAME),$$UP^XLFSTR(SUB),IEN)=$G(HASH(COUNT,NAME,SUB))
 .Q
 Q
 ;;
