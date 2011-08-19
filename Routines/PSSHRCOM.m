PSSHRCOM ;WOIFO/AV,TS - Handles common PRE PEPS interface functionality ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89;
 ;
 ; @authors - Alex Vazquez, Tim Sabat
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
PARSEMSG(DOCHAND,NODE,HASH,COUNT) ;
 ; @DESC Parses the message XML element and stores
 ; severity, type, drugName and text in HASH parameter
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @HASH Passed by ref. Used to store return values
 ; @COUNT Count of messages
 ;
 ; @RETURNS Nothing, Values stored in HASH variable
 ;
 NEW PSS,NAME
 ;
 SET PSS("child")=0
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")<1  DO
 . SET NAME=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . ;
 . DO:NAME="drug"
 . . DO PARSEDRG(DOCHAND,PSS("child"),.HASH,COUNT)
 . . QUIT
 . DO:NAME="severity"
 . . SET HASH(COUNT,"severity")=$$GETTEXT(DOCHAND,PSS("child"))
 . . QUIT
 . DO:NAME="type"
 . . SET HASH(COUNT,"type")=$$GETTEXT(DOCHAND,PSS("child"))
 . . QUIT
 . DO:NAME="drugName"
 . . SET HASH(COUNT,"drugName")=$$GETTEXT(DOCHAND,PSS("child"))
 . . QUIT
 . DO:NAME="text"
 . . SET HASH(COUNT,"text")=$$GETTEXT(DOCHAND,PSS("child"))
 . . QUIT
 . QUIT
 QUIT
 ;;
DRUGLIST(DOCHAND,NODE,HASH,COUNT) ;
 ; @DESC Handles reading the interacted drug list and stores to a Hash
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Represents the interactedDrugList XML element
 ; @HASH Passed by ref. Used to store return values
 ; @COUNT Count of drugs
 ;
 ; @RETURNS Nothing, Values stored in HASH variable
 ;
 NEW PSS,VAL,DRUGS
 SET PSS("child")=0
 SET PSS("interactedCount")=1
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")=0  DO
 . ; Renew the DRUGS variable before passing in again
 . KILL DRUGS
 . DO PARSEDRG(DOCHAND,PSS("child"),.DRUGS,PSS("interactedCount"))
 . SET VAL=""
 . FOR  SET VAL=$ORDER(DRUGS(VAL)) QUIT:VAL=""  DO
 . . SET HASH(COUNT,"drugList",PSS("interactedCount"),"vuid")=DRUGS(VAL,"vuid")
 . . SET HASH(COUNT,"drugList",PSS("interactedCount"),"ien")=DRUGS(VAL,"ien")
 . . SET HASH(COUNT,"drugList",PSS("interactedCount"),"gcn")=DRUGS(VAL,"gcn")
 . . SET HASH(COUNT,"drugList",PSS("interactedCount"),"orderNumber")=DRUGS(VAL,"orderNumber")
 . . SET HASH(COUNT,"drugList",PSS("interactedCount"),"drugName")=DRUGS(VAL,"drugName")
 . . SET HASH(COUNT,"drugList",PSS("interactedCount"),"cprsOrderNumber")=$GET(DRUGS(VAL,"cprsOrderNumber"))
 . . SET HASH(COUNT,"drugList",PSS("interactedCount"),"package")=$GET(DRUGS(VAL,"package"))
 . SET PSS("interactedCount")=PSS("interactedCount")+1
 . QUIT
 QUIT
 ;;
PARSEDRG(DOCHAND,NODE,HASH,COUNT) ;
 ; @DESC Parses a drug element and stores values in HASH parameter
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @HASH Passed by ref. Used to store return values.
 ; @COUNT Count of drugs
 ;
 ; @RETURNS Nothing, Values stored in HASH values
 ;
 SET HASH(COUNT,"vuid")=$$VALUE^MXMLDOM(DOCHAND,NODE,"vuid")
 SET HASH(COUNT,"ien")=$$VALUE^MXMLDOM(DOCHAND,NODE,"ien")
 SET HASH(COUNT,"gcn")=$$VALUE^MXMLDOM(DOCHAND,NODE,"gcnSeqNo")
 SET HASH(COUNT,"drugName")=$$VALUE^MXMLDOM(DOCHAND,NODE,"drugName")
 ;
 ; Split the order number that is in the format 'orderNumber|cprsOrderNumber|package'
 ; Get the cprsOrderNumber and package from order number and order number
 SET HASH(COUNT,"orderNumber")=$PIECE($$VALUE^MXMLDOM(DOCHAND,NODE,"orderNumber"),"|",1)
 SET HASH(COUNT,"cprsOrderNumber")=$PIECE($$VALUE^MXMLDOM(DOCHAND,NODE,"orderNumber"),"|",2)
 SET HASH(COUNT,"package")=$PIECE($$VALUE^MXMLDOM(DOCHAND,NODE,"orderNumber"),"|",3)
 ;
 QUIT
 ;;
UPPER(PSSTEXT) ;
 ; @DESC Converts lowercase characters to uppercase
 ;
 ; @PSSTEXT Text to be converted
 ;
 ; @RETURNS Text in all UPPPERCASE
 ;
 NEW PSS
 ;
 SET PSS("lower")="abcdefghijklmnopqrstuvwxyz"
 SET PSS("upper")="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 SET PSS("upperText")=$TR(PSSTEXT,PSS("lower"),PSS("upper"))
 QUIT PSS("upperText")
 ;;
GETTEXT(DOCHAND,NODE) ;
 ; @DESC Gets text from XML element as a single string
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ;
 ; @RETURNS Text of XML element as a single string
 ;
 NEW TEXT
 ;
 DO TEXT^MXMLDOM(DOCHAND,NODE,$NA(TEXT))
 ; Store array values in string
 SET TEXT=$$UNPARSE(.TEXT)
 ;
 QUIT TEXT
 ;;
UNPARSE(ARRY) ;
 ; @DESC Creates a single string from an array
 ;
 ; @ARRY Array to be looped through for text
 ;
 ; @RETURNS Text of array as a single string
 ;
 NEW VAL,STRING
 ;
 SET VAL=""
 SET STRING=""
 ;
 FOR  SET VAL=$ORDER(ARRY(VAL)) QUIT:VAL=""  DO
 . SET STRING=STRING_ARRY(VAL)
 QUIT STRING
 ;;
ATRIBUTE(NAME,VALUE) ;
 ; @DESC Builds a valid encoded attribute from the name/value pair passed in
 ;
 ; @NAME The left side of the "name=value" relationship
 ; @VALUE The right side of the "name=value" relationship
 ;
 ; @RETURNS A valid/encoded name value pair
 NEW PSS,QT
 SET QT=""""
 SET PSS("attribute")=NAME_"="_QT_$$SYMENC^MXMLUTL($GET(VALUE))_QT
 QUIT PSS("attribute")
 ;;
ISPROF(ORDERNUM) ;
 ; @DESC Determines if a drug is a profile drug according to
 ; its orderNumber
 ;
 ; @RETURNS 1 if is a profile, 0 if not a profile
 NEW PSS
 ;
 SET PSS("isProfile")=$$UPPER^PSSHRCOM(ORDERNUM)["PROFILE"
 ;
 QUIT PSS("isProfile")
 ;;
STACK ;
 ; @DESC Prints a stack trace
 ;
 ; @RETURNS Nothing
 NEW PSSLOOP
 FOR PSSLOOP=0:1:$STACK(-1)  DO
 . WRITE !,"Context level:",PSSLOOP,?25,"Context type: ",$STACK(PSSLOOP)
 . WRITE !,?5,"Current place: ",$STACK(PSSLOOP,"PLACE")
 . WRITE !,?5,"Current source: ",$STACK(PSSLOOP,"MCODE")
 . WRITE !
 . QUIT
 QUIT
 ;;
