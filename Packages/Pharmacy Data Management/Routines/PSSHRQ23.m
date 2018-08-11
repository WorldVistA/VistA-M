PSSHRQ23 ;WOIFO/AV,TS,SG - Parses out drugsNotChecked and DrugDoseCheck XML ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,178,206,224**;9/30/97;Build 3
 ;
 ; @authors - Alex Vazquez, Tim Sabat, Steve Gordon
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
DRGNTCK(DOCHAND,NODE,BASE) ;
 ; @DESC Handles the drugsNotChecked section
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @BASE Base of output global
 ;
 ; @RETURNS Nothing
 ;
 NEW HASH
 ;
 ; Read error into hash variable
 DO NOTREAD(DOCHAND,NODE,.HASH)
 ;
 ; Write hashed variable to output global
 DO NOTWRITE(.HASH,BASE)
 ;
 QUIT
 ;;
NOTREAD(DOCHAND,NODE,HASH) ;
 ; @DESC Handles reading drugsNotChecked section of the XML document
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with drugsNotChecked XML element
 ; @HASH ByRef, Hash used to store response
 ;
 ; @RETURNS Variables in hash
 ;
 NEW PSS
 ;
 SET PSS("child")=0
 SET PSS("count")=0
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")<1  DO
 . SET HASH(PSS("count"),"reason")=$$VALUE^MXMLDOM(DOCHAND,PSS("child"),"status")
 . SET HASH(PSS("count"),"reasonCode")=""
 . SET HASH(PSS("count"),"reasonText")=""
 . SET HASH(PSS("count"),"reasonSource")="PEPS" ; Always PEPS if returned from XML
 . ; Get drug element of drugNotChecked
 . ; No need to iterate over drug subelements because only 1 possible
 . DO PARSEDRG^PSSHRCOM(DOCHAND,$$CHILD^MXMLDOM(DOCHAND,PSS("child")),.HASH,PSS("count"))
 . SET PSS("count")=PSS("count")+1
 . QUIT
 QUIT
 ;;
NOTWRITE(HASH,BASE) ;
 ; @DESC Handles writing drugsNotChecked section of the XML document and
 ; and drugs pulled by validation logic as uncheckable (i.e. no gcn).
 ;
 ; @HASH ByRef, Hash used to store response
 ; @BASE Base of output global
 ;
 ; @RETURNS Nothing. Stores values in output global.
 ;
 NEW I,DATASTR,MESSAGE,PSS,PSSHASH
 S PSSHASH("Base")=BASE  ;FOR NEXTEX CALL
 S I=""
 F  S I=$O(HASH(I)) Q:I=""  D
 .S PSS("PharmOrderNo")=HASH(I,"orderNumber")  ;for nextex call below
 .S MESSAGE=$$GCNREASN^PSSHRVL1(HASH(I,"ien"),HASH(I,"drugName"),HASH(I,"orderNumber"),1)
 .Q:+$P(MESSAGE,U,3)=1
 .S REASON=$P(MESSAGE,U,2),MESSAGE=$P(MESSAGE,U)
 .S DATASTR=HASH(I,"gcn")_U_HASH(I,"vuid")_U_HASH(I,"ien")_U_HASH(I,"drugName")_U_HASH(I,"cprsOrderNumber")
 .S DATASTR=DATASTR_U_HASH(I,"package")_U_MESSAGE_U_U_HASH(I,"reasonSource")_U_REASON
 .S ^TMP($J,BASE,"OUT","EXCEPTIONS",HASH(I,"orderNumber"),$$NEXTEX^PSSHRVL1(.PSS,.PSSHASH))=DATASTR
 Q
 ;
WRTNODE(I,SUB,HASH) ;
 ;sets up the error node for a message
 ;inputs:
 ;  I-Counter for the hash array
 ;  SUB-subscript--either drugdrug, therapy or dose
 ;  HASH-array containing the information for the global
 ;outputs: ^TMP error global
 ;
 N NODECNT,NODE
 ;
 SET NODE="^TMP($JOB,BASE,""OUT"",SUB,""ERROR"",HASH(I,""orderNumber""))"
 ;gets next error number
 S NODECNT=$O(@NODE@(":"),-1)+1
 SET NODE="^TMP($JOB,BASE,""OUT"",SUB,""ERROR"",HASH(I,""orderNumber""),NODECNT)"
 ;I $G(HASH(I,"severity"))="Information" Q   ;If severity="information" don't save
 SET @NODE@(0)=HASH(I,"drugName")_"^"_HASH(I,"ien")_"^"_HASH(I,"cprsOrderNumber")_"^"_HASH(I,"package")
 SET @NODE@("SEV")=$G(HASH(I,"severity"))
 SET @NODE@("TYPE")=$G(HASH(I,"type"))
 ;SET @NODE@("NAME")=HASH(I,"drugName")
 SET @NODE@("TEXT")=HASH(I,"text")
 ;Message node to display to user
 S @NODE@("MSG")=HASH(I,"msg")
 QUIT
 ;
NEXTCNT(BASE,ORDR) ;
 ; @DESC Returns the next counter for the exceptions output global
 ;
 ; @ORDR Order number being counted on
 ;
 ; @RETURNS The next counter for the exceptions output global
 ;
 NEW I
 ;
 SET I=0
 SET I=$ORDER(^TMP($JOB,BASE,"OUT","EXCEPTIONS",ORDR,I),-1)
 SET I=I+1
 QUIT I
 ;;
DRGDOSE(DOCHAND,NODE,BASE) ;
 ; @DESC Handles the drugDoseChecks element
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @BASE name to use for return global
 ;
 ; @RETURNS Nothing
 ;
 NEW PSS,MSGHASH,DOSEHASH,PSMSGCNT
 ;
 SET PSS("child")=0
 SET PSS("doseCount")=0
 SET PSMSGCNT=0
 ;
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")<1  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . ;
 . ; Delegate to appropriate function
 . ; xml can have message at the drugDoseChecks level and at the drugDoseCheck level.
 . SET:PSS("childName")="message" PSMSGCNT=PSMSGCNT+1
 . DO:PSS("childName")="message" MSGREAD(DOCHAND,PSS("child"),.MSGHASH,PSMSGCNT)
 . ;
 . SET:PSS("childName")="drugDoseCheck" PSS("doseCount")=PSS("doseCount")+1
 . DO:PSS("childName")="drugDoseCheck" DOSEREAD(DOCHAND,PSS("child"),.DOSEHASH,PSS("doseCount"),.MSGHASH,PSMSGCNT,BASE)
 . ;
 . QUIT
 ; Write to globals  .MSGHASH AND DOSEHASH ARE SET IN DOSEREAD
 DO MSGWRITE^PSSHRQ21(.MSGHASH,BASE,"DOSE")
 DO DOSEWRIT^PSSHRQ24(.DOSEHASH,BASE)
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
DOSEREAD(DOCHAND,NODE,HASH,COUNT,MSGHASH,MSGCNT,BASE) ;
 ;
 ; @DESC Reads in the drugDoseCheck XML element
 ;
 ; @DOCHAND Handle to XML document
 ; @NODE Node associated with XML element
 ; @BASE Name for return array
 ; @MSGHASH-array of messages about drug
 ; @MSGCNT-a counter on the messages (they can occur at the drugDosechecks or drugDoseCheck level)
 ; @RETURNS Nothing, values stored in hash
 ;
 NEW PSS
 S PSS("messageCount")=MSGCNT
 ;
 ; need drugname and drugien for return node, get them first
 SET PSS("child")=0
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) QUIT:PSS("child")<1  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . ;
 . I PSS("childName")="message" D  Q
 . .S PSS("messageCount")=PSS("messageCount")+1
 . .D MSGREAD(DOCHAND,PSS("child"),.MSGHASH,PSS("messageCount"))
 . ;
 . DO:PSS("childName")="drug"
 . . DO PARSEDRG^PSSHRCOM(DOCHAND,PSS("child"),.HASH,COUNT)
 . . QUIT
 . DO:PSS("childName")="singleDoseStatus"
 . . SET HASH(COUNT,"singleDoseStatus")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 .  DO:PSS("childName")="singleDoseStatusCode"
 . . SET HASH(COUNT,"singleDoseStatusCode")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="singleDoseMessage"
 . . SET HASH(COUNT,"singleDoseMessage")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . ;Need both message and code (5) for the "unable to check" condition"
 . . I HASH(COUNT,"singleDoseStatusCode")=5 D MSG(.HASH,COUNT,"S")
 . . QUIT
 . DO:PSS("childName")="singleDoseMax"
 . . SET HASH(COUNT,"singleDoseMax")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="rangeDoseStatus"
 . . SET HASH(COUNT,"rangeDoseStatus")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="rangeDoseStatusCode"
 . . SET HASH(COUNT,"rangeDoseStatusCode")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="rangeDoseMessage"
 . . SET HASH(COUNT,"rangeDoseMessage")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . ;Need both message and code (5) for the "unable to check" condition"
 . . ;I HASH(COUNT,"rangeDoseStatusCode")=5,HASH(COUNT,"chemoInjectable")="false" D MSG(.HASH,COUNT,"R")
 . . QUIT
 . DO:PSS("childName")="rangeDoseLow"
 . . SET HASH(COUNT,"rangeDoseLow")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="rangeDoseHigh"
 . . SET HASH(COUNT,"rangeDoseHigh")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseHigh"
 . . SET HASH(COUNT,"doseHigh")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseHighUnit"
 . . SET HASH(COUNT,"doseHighUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseLow"
 . . SET HASH(COUNT,"doseLow")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseLowUnit"
 . . SET HASH(COUNT,"doseLowUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseRouteDescription"
 . . SET HASH(COUNT,"doseRouteDescription")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child")) I HASH(COUNT,"doseRouteDescription")="" D
 . . . N PSSNORTE
 . . . F PSSNORTE=6,7,31 S $P(PSSDBCAR(HASH(COUNT,"orderNumber")),"^",PSSNORTE)=1
 . . . S $P(PSSDBCAR(HASH(COUNT,"orderNumber")),"^",32)=" for "_$P(PSSDBCAR(HASH(COUNT,"orderNumber")),"^",9)_" route: "
 . . QUIT
 . DO:PSS("childName")="doseFormHigh"
 . . SET HASH(COUNT,"doseFormHigh")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseFormHighUnit"
 . . SET HASH(COUNT,"doseFormHighUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseFormLow"
 . . SET HASH(COUNT,"doseFormLow")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="doseFormLowUnit"
 . . SET HASH(COUNT,"doseFormLowUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="chemoInjectable"
 . . SET HASH(COUNT,"chemoInjectable")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . ;
 . DO:PSS("childName")="dailyDoseStatus"
 . . SET HASH(COUNT,"dailyDoseStatus")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 .  DO:PSS("childName")="dailyDoseStatusCode"
 . . SET HASH(COUNT,"dailyDoseStatusCode")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="dailyDoseMessage"
 . . SET HASH(COUNT,"dailyDoseMessage")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . ;Need both message and code (5) for the "unable to check" condition"
 . . ;I HASH(COUNT,"dailyDoseStatusCode")=5,HASH(COUNT,"chemoInjectable")="true" D MSG(.HASH,COUNT,"D")
 . . QUIT
 . ;
 . DO:PSS("childName")="maxDailyDoseStatus"
 . . SET HASH(COUNT,"maxDailyDoseStatus")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 .  DO:PSS("childName")="maxDailyDoseStatusCode"
 . . SET HASH(COUNT,"maxDailyDoseStatusCode")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxDailyDoseMessage"
 . . SET HASH(COUNT,"maxDailyDoseMessage")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . ;Need both message and code (5) for the "unable to check" condition"
 . . I HASH(COUNT,"maxDailyDoseStatusCode")=5 D MSG(.HASH,COUNT,"M")
 . . QUIT
 . ;
 . DO:PSS("childName")="maxLifetimeDose"
 . . SET HASH(COUNT,"maxLifetimeDose")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . ;
 . DO:PSS("childName")="frequencyStatus"
 . . SET HASH(COUNT,"frequencyStatus")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="frequencyStatusCode"
 . . SET HASH(COUNT,"frequencyStatusCode")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="frequencyMessage"
 . . SET HASH(COUNT,"frequencyMessage")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="frequencyHigh"
 . . SET HASH(COUNT,"frequencyHigh")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="frequencyLow"
 . . SET HASH(COUNT,"frequencyLow")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxLifetimeOrderMessage" 
 . . SET HASH(COUNT,"maxLifetimeOrderMessage")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxLifetimeOrderStatus"
 . . SET HASH(COUNT,"maxLifetimeOrderStatus")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxLifetimeOrderStatusCode"
 . . SET HASH(COUNT,"maxLifetimeOrderStatusCode")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxSingleNTEDose"
 . . SET HASH(COUNT,"maxSingleNTEDose")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxSingleNTEDoseUnit"
 . . SET HASH(COUNT,"maxSingleNTEDoseUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxSingleNTEDoseForm"
 . . SET HASH(COUNT,"maxSingleNTEDoseForm")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxSingleNTEDoseFormUnit"
 . . SET HASH(COUNT,"maxSingleNTEDoseFormUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxDailyDose"
 . . SET HASH(COUNT,"maxDailyDose")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxDailyDoseUnit" 
 . . SET HASH(COUNT,"maxDailyDoseUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxDailyDoseForm"
 . . SET HASH(COUNT,"maxDailyDoseForm")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . DO:PSS("childName")="maxDailyDoseFormUnit"
 . . SET HASH(COUNT,"maxDailyDoseFormUnit")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . . QUIT
 . ;;
 . DO:PSS("childName")="single"
 . . D PARSEDSP^PSSHRQ2D(DOCHAND,PSS("child"),.HASH,COUNT)
 . . Q
 . ;;
 . DO:PSS("childName")="rangeLow"
 . . D PARSEDSP^PSSHRQ2D(DOCHAND,PSS("child"),.HASH,COUNT)
 . . Q
 . ;;
 . DO:PSS("childName")="rangeHigh"
 . . D PARSEDSP^PSSHRQ2D(DOCHAND,PSS("child"),.HASH,COUNT)
 . . Q
 . ;;
 . DO:PSS("childName")="daily"
 . . D PARSEDSP^PSSHRQ2D(DOCHAND,PSS("child"),.HASH,COUNT)
 . . Q
 . ;;
 . DO:PSS("childName")="maxDaily"
 . . D PARSEDSP^PSSHRQ2D(DOCHAND,PSS("child"),.HASH,COUNT)
 . . Q
 . ;;
 . DO:PSS("childName")="maxLifetime"
 . . D PARSEDSP^PSSHRQ2D(DOCHAND,PSS("child"),.HASH,COUNT)
 . . Q
 . ;;
 . DO:PSS("childName")="maxLifetimeOrder"
 . . D PARSEDSP^PSSHRQ2D(DOCHAND,PSS("child"),.HASH,COUNT)
 . . Q
 . ;;
 . QUIT
 ;
 I $G(HASH(COUNT,"orderNumber"))="" Q
 I '$P($G(PSSDBCAR($G(HASH(COUNT,"orderNumber")))),"^",33) D  ;No dummy data, check FDB data for frequency check failure
 .I $G(HASH(COUNT,"maxDailyDoseStatusCode"))=5,$G(HASH(COUNT,"maxDailyDoseMessage"))["frequency check failed" S $P(PSSDBCAR($G(HASH(COUNT,"orderNumber"))),"^",29)=1
 Q:$P($G(PSSDBCAR($G(HASH(COUNT,"orderNumber")))),"^",29)
 I $G(HASH(COUNT,"frequencyLow"))'>0!($G(HASH(COUNT,"frequencyHigh"))'>0) Q
 N PSSLFREQ,PSSHFREQ,PSSOFREQ
 S PSSOFREQ=$$ORDFREQ^PSSDSUTL($P($G(PSSDBAR("FREQZZ")),"^",2)) Q:'PSSOFREQ  ;PSSOFREQ = Order Frequency
 I PSSOFREQ["." S PSSOFREQ=$$ROUNDNUM^PSSDSUTL(PSSOFREQ)
 S PSSLFREQ=$G(HASH(COUNT,"frequencyLow")) S:PSSLFREQ["." PSSLFREQ=$$ROUNDNUM^PSSDSUTL(PSSLFREQ)
 S PSSHFREQ=$G(HASH(COUNT,"frequencyHigh")) S:PSSHFREQ["." PSSHFREQ=$$ROUNDNUM^PSSDSUTL(PSSHFREQ)
 I (PSSLFREQ<.01!(PSSHFREQ<.01)),((PSSOFREQ<PSSLFREQ)!(PSSOFREQ>PSSHFREQ)) S $P(PSSDBCAR($G(HASH(COUNT,"orderNumber"))),"^",29)=1 Q
 I PSSOFREQ<1,PSSLFREQ'<1,PSSHFREQ'<1 S $P(PSSDBCAR($G(HASH(COUNT,"orderNumber"))),"^",29)=1 Q
 I PSSOFREQ'<1,PSSLFREQ<1,PSSHFREQ<1 S $P(PSSDBCAR($G(HASH(COUNT,"orderNumber"))),"^",29)=1
 ;
 QUIT
 ;;
MSG(HASH,COUNT,TYPE) ;
 ;INPUTS:
 ;  HASH-array of data 
 ;  COUNT-Current subscript of the HASH array
 ;  TYPE-Either "R" for Daily dose Range or "S" for maximum single dose
 ;
 ;returns: ^TMP error global
 N MSG,REASON
 S MSG=$$DOSEMSG^PSSHRVL1(HASH(COUNT,"drugName"),TYPE)
 D
 .I TYPE="R" D  Q
 ..S REASON=$G(HASH(COUNT,"rangeDoseMessage"))
 .I TYPE="S" D  Q
 ..S REASON=$G(HASH(COUNT,"singleDoseMessage"))
 .I TYPE="D" D  Q
 ..S REASON=$G(HASH(COUNT,"dailyDoseMessage"))
 .I TYPE="M" D  Q
 ..S REASON=$G(HASH(COUNT,"maxDailyDoseMessage"))
 S HASH(COUNT,"msg")=MSG
 S HASH(COUNT,"text")=$S(REASON="":"Unavailable",1:REASON)
 D WRTNODE(COUNT,"DOSE",.HASH)
 Q
 ;
CHKVAL(HASH,I,SUB) ;
 ;INPUTS: HASH array (by ref)
 ;        I-Index of current array
 ;        SUB-subscript
 ;Returns: If node has value
 ;
 Q $L($G(HASH(I,SUB)))
