PSSHRQ21 ;WOIFO/AV,TS - Parses a PEPS drugDrugChecks XML element ; 08 Jun 2016  5:49 PM
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,160,184**;9/30/97;Build 14
 ;
 ; @authors - Alex Vazquez, Tim Sabat
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
DRUGDRUG(DOCHAND,NODE,BASE) ;
 ; @DESC Handles putting the drugDrugChecks XML element into
 ;       the DrugOrderChecks object
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @PSSHAND Handle to DrugOrderChecks object
 ;
 ; @RETURNS Nothing
 NEW PSS,MSGHASH,DRUGHASH,PSMSGCNT
 ;
 SET PSS("child")=0
 SET PSS("drugCount")=0
 SET PSMSGCNT=0
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")=0  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . ;xml can have message at the top level of drugDrugCheck as well as within drugDrugChecks
 . SET:PSS("childName")="message" PSMSGCNT=PSMSGCNT+1
 . DO:PSS("childName")="message" MSGREAD(DOCHAND,PSS("child"),.MSGHASH,PSMSGCNT)
 . ;
 . SET:PSS("childName")="drugDrugCheck" PSS("drugCount")=PSS("drugCount")+1
 . DO:PSS("childName")="drugDrugCheck" DRUGREAD(DOCHAND,PSS("child"),.DRUGHASH,PSS("drugCount"),.MSGHASH,PSMSGCNT)
 . QUIT
 ;
 ; Write to globals
 ; MSGHASH is populated within DRUGREAD if a message exists
 DO MSGWRITE(.MSGHASH,BASE,"DRUGDRUG")
 DO DRUGWRIT(.DRUGHASH,BASE)
 QUIT
 ;;
MSGREAD(DOCHAND,NODE,HASH,COUNT) ;
 ; @DESC Handles parsing message section
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @COUNT Count of message sections
 ; @HASH Where to store info
 ;
 ; @RETURNS Nothing
 ;
 ; Parse the message and store in hash
 DO PARSEMSG^PSSHRCOM(DOCHAND,NODE,.HASH,COUNT)
 ;
 QUIT
 ;;
MSGWRITE(HASH,BASE,SUB) ;
 ; @DESC Handles writing message section of the XML document
 ; @NOTE:Error nodes for drugsnotchecked and for drug dosing messages are set 
 ; in PSSHRQ23
 ; @HASH ByRef, Hash used to store response
 ; @BASE Base of output global
 ; @SUB Type of message --DRUGDRUG, THERAPY OR DOSE
 ; @RETURNS Nothing. Stores values in output global.
 NEW PSS,I,NODE,WARNFLG,NODECNT
 ;
 SET I=""
 FOR  SET I=$ORDER(HASH(I)) QUIT:I=""  DO
 . ; Create the node to be used with subscript indirection
 . ;
 . SET NODE="^TMP($JOB,BASE,""OUT"",SUB,""ERROR"",HASH(I,""orderNumber""))"
 . ;gets next error number
 . S NODECNT=$O(@NODE@(":"),-1)+1
 . SET NODE="^TMP($JOB,BASE,""OUT"",SUB,""ERROR"",HASH(I,""orderNumber""),NODECNT)"
 . ;Need to $G several hash entries because they are undefined coming from NOTWRITE^PSSHRQ23
 . I $G(HASH(I,"severity"))="Information" Q   ;If severity="information" don't save
 . SET @NODE@(0)=HASH(I,"drugName")_"^"_HASH(I,"ien")_"^"_HASH(I,"cprsOrderNumber")_"^"_HASH(I,"package")
 . SET @NODE@("SEV")=$G(HASH(I,"severity"))
 . SET @NODE@("TYPE")=$G(HASH(I,"type"))
 . ;SET @NODE@("NAME")=HASH(I,"drugName")
 . SET @NODE@("TEXT")=HASH(I,"text")
 . S WARNFLG=$S($G(HASH(I,"severity"))="Warning":1,1:0)
 . ;Message node to display to user
 . S @NODE@("MSG")=$$ERRMSG^PSSHRVL1(SUB,HASH(I,"drugName"),HASH(I,"orderNumber"),WARNFLG)
 . ;D
 . ;.I $D(HASH(I,"msg")) S @NODE@("MSG")=HASH(I,"msg") Q
 . ;.S @NODE@("MSG")=$$ERRMSG^PSSHRVL1(SUB,HASH(I,"drugName"),HASH(I,"orderNumber"),WARNFLG)
 . QUIT
 QUIT
 ;;
DRUGREAD(DOCHAND,NODE,HASH,COUNT,MSGHASH,MSGCNT) ;
 ; @DESC Handles parsing and storage of drugDrugCheck element
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @COUNT Count of message sections
 ; @HASH Where to store info (by ref)
 ; @MSGHASH-Where message information is stored (by ref)
 ; @MSGCNT-counter for messages
 ; 
 ; @RETURNS Nothing
 NEW PSS
 ;
 SET PSS("child")=0
 ;
 SET PSS("messageCount")=MSGCNT
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")=0  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . ;
 . I PSS("childName")="message" D  Q
 . .S PSS("messageCount")=PSS("messageCount")+1
 . .D MSGREAD(DOCHAND,PSS("child"),.MSGHASH,PSS("messageCount"))
 . ;
 . DO:PSS("childName")="interactedDrugList"
 . . DO DRUGLIST^PSSHRCOM(DOCHAND,PSS("child"),.HASH,COUNT)
 . . QUIT
 . DO:PSS("childName")="severity"
 . . ; Translate the peps severity into a vista specific severity
 . . SET HASH(COUNT,"severity")=$$TRANSEV($$GETTEXT^PSSHRCOM(DOCHAND,PSS("child")))
 . . QUIT
 . DO:PSS("childName")="interaction"
 . . SET HASH(COUNT,"interaction")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="shortText"
 . . SET HASH(COUNT,"shortText")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="professionalMonograph"
 . . DO MONOGRAF(DOCHAND,PSS("child"),.HASH,"ProfessionalMonograph",COUNT)
 . . QUIT
 . DO:PSS("childName")="consumerMonograph"
 . . DO MONOGRAF(DOCHAND,PSS("child"),.HASH,"ConsumerMonograph",COUNT)
 . . QUIT
 . QUIT
 QUIT
 ;;
MONOGRAF(DOCHAND,NODE,HASH,MONOTYPE,COUNT) ;
 ; @DESC Parses and stores the monograph of the monograph type
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @HASH Handle to DrugOrderChecks object
 ; @MONOTYPE Type of monograph either ProfessionalMonograph or ConsumerMonograph
 ;
 ; @RETURNS Nothing
 ;
 NEW PSS
 ;
 SET PSS("child")=0
 SET PSS("i")=0
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")=0  DO
 . ; Get the sub elements of the monograph type section
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . I PSS("childName")="monographSource" D  Q
 . .S HASH(COUNT,"monographSource")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . SET PSS("i")=PSS("i")+1
 . 
 . ;if this is references element get reference sub-element.
 . I PSS("childName")="references" D  Q
 . . D REF(DOCHAND,PSS("child"),.HASH,MONOTYPE,COUNT)
 . ; Get text of element
 . SET PSS("sectionText")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . SET HASH(COUNT,MONOTYPE,PSS("childName"))=PSS("sectionText")
 . QUIT
 ;
 ; Set the total count of monograph sections
 SET HASH(COUNT,MONOTYPE,0)=PSS("i")
 ;
 QUIT
 ;;
REF(DOCHAND,NODE,HASH,MONOTYPE,COUNT) ;
 ; @DESC Parses and stores the reference element of references element.
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @HASH Handle to DrugOrderChecks object
 ; @MONOTYPE Type of monograph either ProfessionalMonograph or ConsumerMonograph
 ;
 ; @RETURNS Nothing
 ;
 NEW PSS
 ;
 SET PSS("child")=0
 SET PSS("i")=0
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")=0  DO
 . ; Get the sub elements of the references type section
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . I PSS("childName")="reference" D
 . .S HASH(COUNT,MONOTYPE,"references",PSS("i"))=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . .SET PSS("i")=PSS("i")+1
 . QUIT
 S:PSS("i")>0 HASH(COUNT,MONOTYPE,"references")=PSS("i")  ; if >0 means references have reference elements
 QUIT
 ;;
DRUGWRIT(HASH,BASE) ;
 ; @DESC Handles writing drugDrugChecks drugDrugCheck section of the XML document
 ;
 ; @HASH ByRef, Hash used to store response
 ; @BASE Base of output global
 ;
 ; @RETURNS Nothing. Stores values in output global.
 ;
 NEW I,PSS,NODE,FIRST,SECOND,SUB,IPMON,L,PSSCLIN,PSSDRGNM,PSSCHK
 SET SUB="ProfessionalMonograph"
 ;
 ; Loop through the drugDrugCheck elements
 SET I=""
 FOR  SET I=$ORDER(HASH(I)) QUIT:I=""  DO
 . ; If Severity equals 0 ignore this drug drug check and move onto next
 . IF +HASH(I,"severity")=-1 QUIT
 . S IPMON=16  ; PMON index before starting to write references
 . ; A profile drug should always take precedent in the subscript over a prospective drug
 . ; If two prospective or two profile drugs then precedence doesn't matter
 . ; Set the values to default values
 . SET FIRST=1
 . SET SECOND=2
 . IF $$ISPROF^PSSHRCOM(HASH(I,"drugList",2,"orderNumber"))=1  DO
 . . SET FIRST=2
 . . SET SECOND=1
 . . QUIT
 . ;
 . ; Create the node to use with subscript indirection
 . SET NODE="^TMP($JOB,BASE,""OUT"",""DRUGDRUG"",$$SEVCODE(HASH(I,""severity""))"
 . SET NODE=NODE_",HASH(I,""drugList"",FIRST,""drugName""),HASH(I,""drugList"",FIRST,""orderNumber""),I)"
 .
 . ; Value on right of = should be as follows
 . ; 2nd Order Number^2nd Drug IEN^1st Drug IEN^2nd Drug Name^CPRS Order Number^Package
 . SET PSS("value")=HASH(I,"drugList",SECOND,"orderNumber")_"^"_HASH(I,"drugList",SECOND,"ien")_"^"_HASH(I,"drugList",FIRST,"ien")
 . SET PSS("value")=PSS("value")_"^"_HASH(I,"drugList",SECOND,"drugName")_"^"_HASH(I,"drugList",FIRST,"cprsOrderNumber")_"^"_HASH(I,"drugList",FIRST,"package")
 . SET @NODE=PSS("value")
 . ;
 . I $$CHKHASH(.HASH,I,"severity") SET @NODE@("SEV")=HASH(I,"severity")
 . I $$CHKHASH(.HASH,I,"shortText") SET @NODE@("SHORT")=HASH(I,"shortText")
 . I $$CHKHASH(.HASH,I,"interaction") SET @NODE@("INT")=HASH(I,"interaction")
 . I $$CHKHASH(.HASH,I,SUB,"clinicalEffects") D
 . . ;prevent string length error due to message being duplicated when same drug ordered multiple times
 . . S PSSCLIN=HASH(I,"ProfessionalMonograph","clinicalEffects")
 . . S PSSDRGNM=HASH(I,"drugList",FIRST,"drugName")
 . . Q:PSSDRGNM=""!(PSSCLIN="")
 . . ;Do not repeat text if drug is ordered multiple times
 . . Q:$D(PSSCHK(PSSDRGNM,$E(PSSCLIN,1,500)))
 . . ;save text for drug if being checked again in this session
 . . S PSSCHK(PSSDRGNM,$E(PSSCLIN,1,500))=""
 . . S @NODE@("CLIN")=HASH(I,"ProfessionalMonograph","clinicalEffects")
 . ;
 . ; Write professional monograph
 . ; Professional monograph MUST be in order specified by code with a single
 . ; line of space between each section
 . I $$CHKHASH(.HASH,I,SUB,0) SET @NODE@("PMON")=HASH(I,"ProfessionalMonograph",0)
 . I $$CHKHASH(.HASH,I,SUB,"disclaimer") D
 . .SET @NODE@("PMON",1,0)=HASH(I,"ProfessionalMonograph","disclaimer")
 . .SET @NODE@("PMON",2,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"monographTitle") D
 . .SET @NODE@("PMON",3,0)=HASH(I,"ProfessionalMonograph","monographTitle")
 . .SET @NODE@("PMON",4,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"severityLevel") D
 . .SET @NODE@("PMON",5,0)=HASH(I,"ProfessionalMonograph","severityLevel")
 . .SET @NODE@("PMON",6,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"mechanismOfAction") D
 . .SET @NODE@("PMON",7,0)=HASH(I,"ProfessionalMonograph","mechanismOfAction")
 . .SET @NODE@("PMON",8,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"clinicalEffects") D
 . .SET @NODE@("PMON",9,0)=HASH(I,"ProfessionalMonograph","clinicalEffects")
 . .SET @NODE@("PMON",10,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"predisposingFactors") D
 . .SET @NODE@("PMON",11,0)=HASH(I,"ProfessionalMonograph","predisposingFactors")
 . .SET @NODE@("PMON",12,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"patientManagement") D
 . .SET @NODE@("PMON",13,0)=HASH(I,"ProfessionalMonograph","patientManagement")
 . .SET @NODE@("PMON",14,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"discussion") D
 . .SET @NODE@("PMON",15,0)=HASH(I,"ProfessionalMonograph","discussion")
 . .SET @NODE@("PMON",16,0)=""
 . I $$CHKHASH(.HASH,I,SUB,"references") D
 . . S L=""
 . . F  S L=$O(HASH(I,"ProfessionalMonograph","references",L)) Q:L=""  D
 . . .S IPMON=IPMON+1
 . . .S @NODE@("PMON",IPMON,0)=HASH(I,"ProfessionalMonograph","references",L)
 . . ;
 . . S IPMON=IPMON+1
 . . SET @NODE@("PMON",IPMON,0)=""
 . ;
 . I $$CHKHASH(.HASH,I,"monographSource") SET IPMON=IPMON+1 SET @NODE@("PMON",IPMON,0)=$$COPYRITE(HASH(I,"monographSource"))
 . ;
 . ; Write consumer monograph
 . ; consumer monograph NOT currently available TODO add when available
 . QUIT
 K PSSCLIN,PSSDRGNM,PSSCHK
 QUIT
 ;;
CHKHASH(HASH,CNT,SUB1,SUB2) ;
 ;CHECKS if hash node has data
 ;inputs: HASH-ARRAY PASSED IN BY REF
 ;        CNT-The hash number passed in
 ;        SUB1--First subscript
 ;        SUB2 (OPTIONAL)-SECOND SUBSCRIPT
 ;RETURNS LENGTH OF DATA IN NODE OR 0 IF DOESN'T EXIST
 N RESULT
 D
 .I $L($G(SUB2)) D  Q
 ..S RESULT=$L($G(HASH(CNT,SUB1,SUB2)))
 .S RESULT=$L($G(HASH(CNT,SUB1)))
 Q RESULT
 ;
TRANSEV(SEV) ;
 ; @DESC Translates the severity attribute returned by the XML into
 ; a VistA specific severity
 ;
 ; @SEV Severity returned from the XML
 ;
 ; @RETURNS VistA specific severity
 ;
 ; DrugDrugChecks with an FDB severity of "Contraindicated Drug Combination"
 ; will be displayed as "Critical".
 ; DrugDrugChecks with an FDB severity of "Severe Interaction" will be displayed as "Significant".
 ; IMPORTANT:
 ; DrugDrugChecks that are not 'critical' or 'significant' are not included in output global.
 QUIT $SELECT(SEV="Contraindicated Drug Combination":"Critical",SEV="Severe Interaction":"Significant",1:-1)
 ;;
SEVCODE(SEV) ;
 ; @DESC Returns the proper severity code depending on the VistA specific severity
 ;
 ; @SEV VistA specific severity.
 ;
 ; @RETURNS Returns severity code. 'C' for Critical. 'S' for Significant.
 ;
 QUIT $SELECT(SEV="Critical":"C",SEV="Significant":"S")
 ;;
COPYRITE(SOURCE) ;
 ; @DESC Returns correct copyright disclaimer for FDB OR VA PBM in format
 ; @Copyright [Current Year] First DataBank, Inc.
 ; @Information provided by VA PBM-SHG
 ; @INPUT: source FDB OR Custom
 ; @RETURNS FDB copyright OR va pbm information
 ;
 NEW PSS
 ;
 N %I
 DO NOW^%DTC
 SET PSS("fileManYear")=%I(3)
 ; File man years begin at 1700
 SET PSS("year")=PSS("fileManYear")+1700
 ;
 D  ;Case on Source
 .I SOURCE="Custom" S PSS("source")="Information provided by VA PBM-SHG" Q
 .S PSS("source")="Copyright "_PSS("year")_" First Databank, Inc."
 QUIT PSS("source")
 ;;
 ;;
