PSSHRQ2O ;WOIFO/AV,TS,SG - Handles parsing a PEPS Drug Check Response ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 ; @authors - Chris Flegel, Alex Vazquez, Tim Sabat
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
OUT(DOCHAND,BASE) ;
 ; @DESC Parses the PEPSResponse XML and stores in object
 ;
 ; @DOCHAND Handle to XML document
 ; @BASE Base of output global
 ;
 NEW PSS,HASH,MESSAGE
 ;
 SET PSS("rootName")=$$NAME^MXMLDOM(DOCHAND,1)
 ;
 IF PSS("rootName")="exception" DO
 . ; Read error into hash variable
 . DO ERREAD(DOCHAND,.HASH)
 . ; Write hashed variable to output global
 . IF HASH("code")="FDBUPDATE" S MESSAGE="Vendor database updates are being processed."            ; HASH("message")
 . ELSE  IF $D(^TMP($J,BASE,"IN","DOSE"))>0 SET MESSAGE="Unexpected error has occurred."
 . ELSE  SET MESSAGE="Unexpected error has occurred."
 . SET ^TMP($JOB,BASE,"OUT",0)="-1^"_MESSAGE
 . ;
 . ; Cleanup the out.exception global
 . KILL ^TMP($JOB,"OUT","EXCEPTION")
 ;
 IF PSS("rootName")="PEPSResponse" DO HNDLCK(DOCHAND,BASE)
 ;
 ; Clean up after using the handle
 DO DELETE^MXMLDOM(DOCHAND)
 KILL ^TMP($J,"OUT XML")
 QUIT
 ;
HNDLCK(DOCHAND,BASE) ;
 ; @DESC This handles the parsing of the PEPSResponse XML element
 ;
 ; @DOCHAND Handle to XML document
 ; @BASE Base of output global
 ;
 ; @RETURNS Nothing
 ;
 NEW PSS
 ;
 ; if ping get the vendor database info and exit.
 IF $D(^TMP($JOB,BASE,"IN","PING")) SET ^TMP($JOB,BASE,"OUT",0)=0 DO GTDBINFO(DOCHAND,BASE) QUIT
 ;
 ; Get handle to drugCheck XML element
 SET PSS("drugCheck")=$$GTHANDLE(DOCHAND)
 SET PSS("child")=0
 ; Loop through elements of drugCheck
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,PSS("drugCheck"),PSS("child")) QUIT:PSS("child")=0  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . ;
 . ; Build executable string
 . SET PSS("tag")=$$SELTAG(PSS("childName"))
 . SET PSS("executable")="DO "_PSS("tag")_"(DOCHAND,PSS(""child""),BASE)"
 . ;
 . XECUTE PSS("executable")
 . QUIT
 ;
 ; Set top level node to 1 or 0
 IF $DATA(^TMP($JOB,BASE,"OUT"))>1 SET ^TMP($JOB,BASE,"OUT",0)=1
 IF $DATA(^TMP($JOB,BASE,"OUT"))<10 SET ^TMP($JOB,BASE,"OUT",0)=0
 QUIT
 ;
GTDBINFO(DOCHAND,BASE) ; get the Vendor database info. 
 ; @DOCHAND Handle to XML document
 ; @BASE Base of output global
 ;
 NEW PSS,HEADER
 SET PSS("child")=0
 SET PSS("childName")=""
 ; get <Header> child
 FOR  DO  QUIT:PSS("childName")="Header"
 . SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child"))
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 ;
 ; get <PEPSVersion> child of <Header> element
 SET HEADER=PSS("child")
 SET PSS("child")=0
 FOR  DO  QUIT:PSS("childName")="PEPSVersion"
 . SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,HEADER,PSS("child"))
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 ;
 SET ^TMP($JOB,BASE,"OUT","difIssueDate")=$$VALUE^MXMLDOM(DOCHAND,PSS("child"),"difIssueDate")
 SET ^TMP($JOB,BASE,"OUT","difBuildVersion")=$$VALUE^MXMLDOM(DOCHAND,PSS("child"),"difBuildVersion")
 SET ^TMP($JOB,BASE,"OUT","difDbVersion")=$$VALUE^MXMLDOM(DOCHAND,PSS("child"),"difDbVersion")
 SET ^TMP($JOB,BASE,"OUT","customIssueDate")=$$VALUE^MXMLDOM(DOCHAND,PSS("child"),"customIssueDate")
 SET ^TMP($JOB,BASE,"OUT","customBuildVersion")=$$VALUE^MXMLDOM(DOCHAND,PSS("child"),"customBuildVersion")
 SET ^TMP($JOB,BASE,"OUT","customDbVersion")=$$VALUE^MXMLDOM(DOCHAND,PSS("child"),"customDbVersion")
 QUIT
 ;
GTHANDLE(DOCHAND) ;
 ; @DESC Get handle to drugCheck element from PEPSResponse element
 ;
 ; @DOCHAND Handle to XML document
 ;
 ; @RETURNS Handle to drugCheck XML element
 ;
 NEW PSS
 ;
 SET PSS("child")=0
 ;
 ; Get next child of root element
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) QUIT:PSS("child")=0  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . SET:PSS("childName")="Body" PSS("drugCheckElement")=$$CHILD^MXMLDOM(DOCHAND,PSS("child"))
 ;
 QUIT PSS("drugCheckElement")
 ;
SELTAG(NAME) ;
 ; @DESC Returns the appropriate tag to handle the XML element
 ;
 ; @NAME Name of the current XML element
 ;
 ; @RETURNS Returns the appropriate tag to handle the XML element
 ;
 QUIT:NAME="drugsNotChecked" "DRGNTCK^PSSHRQ23"
 ;
 QUIT:NAME="drugDrugChecks" "DRUGDRUG^PSSHRQ21"
 ;
 QUIT:NAME="drugTherapyChecks" "THERAPY^PSSHRQ22"
 ;
 QUIT:NAME="drugDoseChecks" "DRGDOSE^PSSHRQ23"
 QUIT
 ;
ALTERROR(BASE) ;
 ; @DESC Handles alternate PEPS errors like being unable to
 ; connect to PEPS. Reads info from global in format
 ;
 ; ^TMP($JOB,"OUT","EXCEPTION")=MESSAGE
 ;
 ; @BASE Base of global to be written to
 ;
 ; @RETURNS Nothing
 ;
 SET ^TMP($JOB,BASE,"OUT",0)="-1^Vendor Database cannot be reached."
 ;
 ; Cleanup the out.exception global
 KILL ^TMP($JOB,"OUT","EXCEPTION")
 QUIT
 ;
ERREAD(DOCHAND,HASH) ;
 ; @DESC Handles parsing the exception XML element and storing it
 ; in a hash variable
 ;
 ; @DOCHAND Handle to XML document
 ; @HASH ByRef, Hash variable used to store error info
 ;
 ; @RETURNS Nothing. Info stored in HASH param.
 ;
 NEW PSS
 ;
 SET PSS("child")=0
 ;
 ; Get next child of root element
 FOR  SET PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) QUIT:PSS("child")=0  DO
 . SET PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 . SET:PSS("childName")="code" HASH("code")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 . SET:PSS("childName")="message" HASH("message")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 QUIT
 ;
