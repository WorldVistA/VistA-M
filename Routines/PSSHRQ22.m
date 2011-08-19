PSSHRQ22 ;WOIFO/AV,TS - Handles parsing a PEPS drugTherapyChecks XML element ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 ; @authors - Alex Vazquez, Tim Sabat
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
THERAPY(DOCHAND,NODE,BASE) ;
 ; @DRIVER
 ; @DESC Parses the drugTherapyChecks XML elements
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @PSSHAND Handle to DrugOrderChecks object
 ;
 ; @RETURNS Nothing
 ;
 NEW PSS,MSGHASH,DRUGHASH,PSMSGCNT
 ;
 SET PSS("child")=0
 SET PSS("therapyCount")=0
 SET PSMSGCNT=0
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")=0  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . ;
 . ;XML allows messages within both drugTherapyChecks and drugTherapyCheck
 . SET:PSS("childName")="message" PSMSGCNT=PSMSGCNT+1
 . DO:PSS("childName")="message" MSGREAD(DOCHAND,PSS("child"),.MSGHASH,PSMSGCNT)
 . ;
 . SET:PSS("childName")="drugTherapyCheck" PSS("therapyCount")=PSS("therapyCount")+1
 . DO:PSS("childName")="drugTherapyCheck" THERREAD(DOCHAND,PSS("child"),.DRUGHASH,PSS("therapyCount"),.MSGHASH,PSMSGCNT)
 ;
 ;MSGHASH is set in THEREAD
 DO MSGWRITE^PSSHRQ21(.MSGHASH,BASE,"THERAPY")
 DO THERWRIT(.DRUGHASH,BASE)
 ;
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
 ;
 ;
THERREAD(DOCHAND,NODE,HASH,COUNT,MSGHASH,MSGCNT) ;
 ; @DESC Handles parsing and storage of drugTherapyCheck element
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @COUNT Count of drug sections
 ; @HASH Where to store info
 ; @MSGHASH Where message (alert)from FDB is stored
 ; @MSGCNT-The current count of the number of messages (messages can occur in both places)
 ; @RETURNS Nothing
 NEW PSS
 NEW INTDRUG   ;FOR TEST
 SET PSS("child")=0
 SET PSS("messageCount")=MSGCNT
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")=0  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . 
 . I PSS("childName")="message" D  Q
 . .S PSS("messageCount")=PSS("messageCount")+1
 . .D MSGREAD(DOCHAND,PSS("child"),.MSGHASH,PSS("messageCount"))
 . ;
 . DO:PSS("childName")="interactedDrugList"
 . . ; Store the interacted drug list
 . . DO DRUGLIST^PSSHRCOM(DOCHAND,PSS("child"),.HASH,COUNT)
 . DO:PSS("childName")="classification"
 . . SET HASH(COUNT,"classification")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="duplicateAllowance"
 . . SET HASH(COUNT,"duplicateAllowance")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="shortText"
 . . SET HASH(COUNT,"shortText")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . QUIT
 QUIT
 ;;
THERWRIT(HASH,BASE) ;
 ; @DESC Handles writing drugDrugChecks drugTherapy section of the XML document
 ;
 ; @HASH ByRef, Hash used to store response
 ; @BASE Base of output global
 ;
 ; @RETURNS Nothing. Stores values in output global.
 ;
 NEW PSS,I,DRUGNUM,NODE,COUNT,INDX
 ;
 SET I=""
 SET COUNT=0
 ;
 ; Creates the index of drug combinations
 ; Each unique drug combination has the corresponding count
 DO MAKEINDX(.INDX,.HASH)
 ;
 FOR  SET I=$ORDER(HASH(I)) QUIT:I=""  DO
 . ; Get the drugList identifier,
 . ; Then get the count, count will be used to write global
 . SET COUNT=INDX($$DLISTID(.HASH,I))
 . ;
 . ; Create the node to be used with subscript indirection
 . SET NODE="^TMP($JOB,BASE,""OUT"",""THERAPY"",COUNT)"
 . ; Write out the drug list to the global
 . SET DRUGNUM=""
 . FOR  SET DRUGNUM=$ORDER(HASH(I,"drugList",DRUGNUM)) QUIT:DRUGNUM=""  DO
 . . DO TMPGLOB(.HASH,I,COUNT,DRUGNUM,BASE)
 . . QUIT
 . ;
 . ; Write out the nodes to the correct subcount
 . ; Get the correct subcount number first
 . ; Get last count, then add 1 to move to next counter
 . SET PSS("subCount")=$$SUBCOUNT(COUNT,BASE)
 . SET @NODE@(PSS("subCount"),"ALLOW")=HASH(I,"duplicateAllowance")
 . SET @NODE@(PSS("subCount"),"CLASS")=HASH(I,"classification")
 . SET @NODE@(PSS("subCount"),"SHORT")=HASH(I,"shortText")
 . ;
 . QUIT
 ;
 QUIT
 ;;
SUBCOUNT(COUNT,BASE) ;
 ; @DESC Returns the next subcount for drug therapy output global
 ; Format is ^TMP($JOB,BASE,"OUT","THERAPY",COUNT,SUBCOUNT)
 ;
 ; @COUNT The main count of drug therapy
 ; @BASE The base of output global
 ;
 ; @RETURNS The last subcount of drug therapy output global.
 ;
 NEW PSS
 ;
 ; loop through the subcounts of the current count, store highest
 ; subcount and return it
 SET PSS("subCount")=""
 SET PSS("highCount")=0
 FOR  SET PSS("subCount")=$ORDER(^TMP($JOB,BASE,"OUT","THERAPY",COUNT,PSS("subCount"))) QUIT:PSS("subCount")=""  DO
 . IF +PSS("subCount")>PSS("highCount") SET PSS("highCount")=+PSS("subCount")
 . QUIT
 ;
 QUIT PSS("highCount")+1
 ;;
MAKEINDX(INDX,HASH) ;
 ; @DESC Creates index of drug list combinations. Uses gcn as the
 ; unique identifier of drug.
 ;
 ; @HASH ByRef, Holds the list of drugs
 ; @INDX ByRef, Used to store count of drug list
 ;
 ; @RETURNS Nothing.  Values returned in INDX hash
 ;
 NEW I,PSS
 ;
 SET PSS("uniqueDrugCombinationCount")=0
 ;
 SET I=""
 FOR  SET I=$ORDER(HASH(I)) QUIT:I=""  DO
 . ; Get the uniqueDrugCombinationId, i.e. gcn's strung together
 . SET PSS("uniqueDrugCombination")=$$DLISTID(.HASH,I)
 . ;
 . ; Check to see if drug combination already exist
 . ; If it does not exist increase the unique drug count
 . IF $DATA(INDX(PSS("uniqueDrugCombination")))=0 DO
 . . SET PSS("uniqueDrugCombinationCount")=PSS("uniqueDrugCombinationCount")+1
 . . SET INDX(PSS("uniqueDrugCombination"))=PSS("uniqueDrugCombinationCount")
 . QUIT
 ;
 QUIT
 ;;
DLISTID(HASH,I) ;
 ; @DESC Returns the id of the drug list. The id of the drug list
 ; consist of the gcn in sorted order separated by '^'.
 ;
 ; @HASH ByRef, Holds the list of drugs
 ; @I    The current count on the hash
 ;
 ; @RETURNS Id of drug list.
 NEW J,K,PSS,ARRAY
 ; loop through the drug therapy checks count
 ; Create a temp array to sort the gcns in the ascending order
 SET J=""
 FOR  SET J=$ORDER(HASH(I,"drugList",J)) QUIT:J=""  DO
 . ;SET PSS("uniqueDrugID")=HASH(I,"drugList",J,"orderNumber")
 . SET PSS("uniqueDrugID")=HASH(I,"drugList",J,"gcn")   ;PO: get GCN
 . SET ARRAY(PSS("uniqueDrugID"))=1
 . QUIT
 ;
 ; Create a uniqueDrugCombination from temp array
 SET K=""
 SET PSS("tempCount")=0
 SET PSS("uniqueDrugCombination")=""
 FOR  SET K=$ORDER(ARRAY(K)) QUIT:K=""  DO
 . IF PSS("tempCount")>0 DO
 . . SET PSS("uniqueDrugCombination")=PSS("uniqueDrugCombination")_"^"_K
 . ;
 . ; For first loop do no attach ^ before setting
 . IF PSS("tempCount")=0 DO
 . . SET PSS("tempCount")=PSS("tempCount")+1
 . . SET PSS("uniqueDrugCombination")=K
 . ;
 . QUIT
 ;
 QUIT PSS("uniqueDrugCombination")
 ;;
TMPGLOB(HASH,MAINCNT,CHEKCNT,DRUGNUM,BASE) ;
 ; @DESC Writes the drugList to the proper global
 ;
 ; @HASH ByRef, Has used to store response
 ; @CHECKCNT The current TherapyCheck result
 ; @DRUGNUM The current drug interaction
 ; @BASE Base of the output global
 ;
 ; @RETURNS Nothing.  Stores values in output global.
 ;
 NEW NODE
 SET NODE="^TMP($JOB,BASE,""OUT"",""THERAPY"",CHEKCNT,""DRUGS"",DRUGNUM)"
 SET @NODE=$$VALUE(.HASH,MAINCNT,DRUGNUM)
 QUIT
 ;;
VALUE(HASH,MAINCNT,DRUGNUM) ;
 ; @DESC Provides the ""piece" data we use when creating the output global.
 ;
 ; @HASH ByRef, Has used to store response
 ; @MAINCNT The current TherapyCheck result
 ; @DRUGNUM The current drug interaction
 ;
 ; @RETURNS The right side of the global for therapy.
 ;
 ; PharmacyOrderNumber ^
 ; Drug IEN ^
 ; Drug Name ^
 ; CPRS Order Number ^
 ; Package
 ;
 NEW OUT
 SET OUT=HASH(MAINCNT,"drugList",DRUGNUM,"orderNumber")_"^"
 SET OUT=OUT_HASH(MAINCNT,"drugList",DRUGNUM,"ien")_"^"
 SET OUT=OUT_HASH(MAINCNT,"drugList",DRUGNUM,"drugName")_"^"
 SET OUT=OUT_HASH(MAINCNT,"drugList",DRUGNUM,"cprsOrderNumber")_"^"
 SET OUT=OUT_HASH(MAINCNT,"drugList",DRUGNUM,"package")
 QUIT OUT
 ;;
