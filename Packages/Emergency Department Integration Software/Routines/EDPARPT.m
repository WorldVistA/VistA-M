EDPARPT ;SLC/BWF - Ad Hoc Reports ;5/16/2012 11:51am
 ;;2.0;EMERGENCY DEPARTMENT;**6**;Feb 24, 2012;Build 200
 ;
GETREPL(EDPXML,P1,P2) ; get report list
 N IEN,CNT,ARRAY,EDPRES
 S EDPRES=$NA(^TMP("EDPARPT",$J)) K @EDPRES
 S ARRAY=$NA(^TMP("EDPARPT",$J,"reports",1)) K @ARRAY
 S IEN=$G(P1("id")) I 'IEN S IEN=$G(P1("id",1))
 I IEN D  Q
 .D BLDRITEM(1,IEN,ARRAY,.P1)
 .D TOXMLG^EDPXML(EDPRES,EDPXML) K @ARRAY,@EDPRES
 S (IEN,CNT)=0 F  S IEN=$O(^EDPB(232.1,IEN)) Q:'IEN  D
 .S CNT=CNT+1
 .D BLDRITEM(CNT,IEN,ARRAY,.P1)
 D TOXMLG^EDPXML(EDPRES,EDPXML)
 K @ARRAY,@EDPRES
 Q
BLDRITEM(CNT,IEN,ARRAY,PARAM) ;
 N X0,RIEN,RID,RNAME,RABBR,EIEN,ESEQ,EPTR,E0
 S X0=$G(^EDPB(232.1,IEN,0))
 S @ARRAY@("report",CNT,"name")=$P(X0,U,1)
 S @ARRAY@("report",CNT,"id")=IEN
 S @ARRAY@("report",CNT,"inactive")=$S($P(X0,U,2)>0:"true",1:"false")
 S RIEN=0 F  S RIEN=$O(^EDPB(232.1,IEN,2,RIEN)) Q:'RIEN  D
 .S RID=+$G(^EDPB(232.1,IEN,2,RIEN,0))
 .S RNAME=$$GET1^DIQ(232.5,RID,.01,"E")
 .S RABBR=$$GET1^DIQ(232.5,RID,.02,"E")
 .S @ARRAY@("report",CNT,"role",RID,"id")=RID
 .S @ARRAY@("report",CNT,"role",RID,"name")=RNAME
 .S @ARRAY@("report",CNT,"role",RID,"abbreviation")=RABBR
 I $G(PARAM("elements"))="true"!($G(PARAM("id"))>0) D
 .S EIEN=0 F  S EIEN=$O(^EDPB(232.1,IEN,1,EIEN)) Q:'EIEN  D
 ..S E0=$G(^EDPB(232.1,IEN,1,EIEN,0))
 ..S ESEQ=$P(E0,U),EPTR=$P(E0,U,2)
 ..S @ARRAY@("report",CNT,"element",EIEN,"sequence")=ESEQ
 ..S @ARRAY@("report",CNT,"element",EIEN,"id")=EPTR
 ..S @ARRAY@("report",CNT,"element",EIEN,"name")=$$GET1^DIQ(232.11,EPTR,.01,"E")
 Q 
SAVE(EDPXML,P1,P2) ; save report definition
 N X,ID,NAME,REMOVE,IENS,INACTIVE,EDITABLE,ELEM,EIENS,ROLE,RIENS,ERR,NEWIEN,NIEN
 I '$D(P1) Q
 S ID=$G(P1("id")),NAME=$G(P1("name"))
 S REMOVE=$G(P1("remove")),REMOVE=$S(REMOVE="true":1,1:0)
 ; convert inactive and editable values to internal
 S INACTIVE=$G(P1("inactive")),INACTIVE=$S(INACTIVE="true":1,1:0)
 S EDITABLE=$G(P1("editable")),EDITABLE=$S(INACTIVE="true":1,1:0)
 ; if remove and an id is sent, delete the entry and quit
 I ID'="",REMOVE S FDA(232.1,ID_",",.01)="@" D FILE^DIE(,"FDA") K FDA D SUCCESS(EDPXML,"<status>deleted</status>") Q
 S IENS=$S(ID="":"+1,",1:ID_",")
 K FDA
 S FDA(232.1,IENS,.01)=NAME
 S FDA(232.1,IENS,.02)=INACTIVE
 S FDA(232.1,IENS,.03)=EDITABLE
 ; if there is no id, then we are adding a new entry
 I 'ID D  Q
 .D UPDATE^DIE(,"FDA","NEWIEN","ERR")
 .I $D(ERR) D WSERR^EDPBWS("An error occured while filing a new entry.") Q
 .S NIEN=$O(NEWIEN(0)),NIEN=$G(NEWIEN(NIEN))
 .D REPMULTS(NIEN,.P2)
 .S P1("id")=NIEN,P1("elements")="true" D GETREPL(EDPXML,.P1)
 ; if editing an entry (ID is defined), loop through the multiples and clear them out so they can be rebuilt
 S ELEM=0 F  S ELEM=$O(^EDPB(232.1,ID,1,ELEM)) Q:'ELEM  D
 .S EIENS=ELEM_","_ID_","
 .S FDA(232.12,EIENS,.01)="@" D FILE^DIE(,"FDA") K FDA
 S ROLE=0 F  S ROLE=$O(^EDPB(232.1,ID,1,ROLE)) Q:'ROLE  D
 .S RIENS=ROLE_","_ID_","
 .S FDA(232.13,RIENS,.01)="@" D FILE^DIE(,"FDA") K FDA
 ; now file the data for 232.1 main file
 D FILE^DIE(,"FDA") K FDA
 D REPMULTS(NIEN,.P2)
 S P1("id")=NIEN,P1("elements")="true" D GETREPL(EDPXML,.P1)
 Q
REPMULTS(IEN,PARAMS) ; update the 'display elements' and 'roles multiples
 N ROLES,ELEMS,SEQ,LSEQ,ID,X,RLOOP
 ; loop through elements and order them in an array
 S X=0 F  S X=$O(PARAMS("element",X)) Q:'X  D
 .S ID=$P(PARAMS("element",X),U),SEQ=$P(PARAMS("element",X),U,2)
 .S ELEMS(SEQ)=ID
 S LSEQ=0 F  S LSEQ=$O(ELEMS(LSEQ)) Q:'LSEQ  D
 .S FDA(232.12,"+1,"_IEN_",",.01)=LSEQ
 .S FDA(232.12,"+1,"_IEN_",",.02)=$G(ELEMS(LSEQ))
 .D UPDATE^DIE(,"FDA") K FDA
 ; order of the roles are not important, we can just file them
 S RLOOP=0 F  S RLOOP=$O(PARAMS("role",RLOOP)) Q:'RLOOP  D
 .S FDA(232.13,"+1,"_IEN_",",.01)=$G(PARAMS("role",RLOOP))
 .D UPDATE^DIE(,"FDA") K FDA
 Q
SUCCESS(EDPXML,DATA) ;
 N EDPCNT
 S EDPCNT=0 D XMLG^EDPX(DATA,EDPCNT,EDPXML)
 Q
GETELM(EDPXML,P1,P2) ; get report element list
 N IEN,EDPRES,ARRAY,CNT
 S EDPRES=$NA(^TMP("EDPARPT",$J)) K @EDPRES
 S ARRAY=$NA(^TMP("EDPARPT",$J,"reportElements",1)) K @ARRAY
 S (IEN,CNT)=0 F  S IEN=$O(^EDPB(232.11,IEN)) Q:'IEN  D
 .S CNT=CNT+1
 .S @ARRAY@("element",CNT,"id")=IEN
 .S @ARRAY@("element",CNT,"name")=$$GET1^DIQ(232.11,IEN,.01,"E")
 D TOXMLG^EDPXML(EDPRES,EDPXML)
 Q
TESTEXE ;
 S P1("start")=2980101
 S P1("id")=1
 S EDPSITE=807
 S EDPXML=$NA(^TMP("EDPGLOB",$J)) K @EDPXML
 D EXE^EDPARPT(EDPXML,.P1)
 Q
 ; input
 ;    EDPXML   - $NA of global array where XML will be stored
 ;    P1       - single diminsional array that contains top level data
 ;    P2       - multiple diminsion array that contains 'custom' report structure
EXE(EDPXML,P1,P2) ; execute a report
 N RID,EDPRES,ARRAY,EID,E0,ESEQ,EPTR,EARRY,CSV,CSVARRY,ELOOP
 S EDPRES=$NA(^TMP("EDPARPT",$J)) K @EDPRES
 S ARRAY=$NA(^TMP("EDPARPT",$J,"records",1)) K @ARRAY
 S XMLARRY=$NA(^TMP("EDPARPT",$J,"logEntries",1)) K @XMLARRY
 S CSVARRY=$NA(^TMP("EDPARPT",$J,"CSV")) K @CSVARRY
 S RID=$G(P1("id")) ; set report id
 S CSV=$G(P1("csv")),CSV=$S(CSV="true":1,1:0),CNT=0
 ; if report 'id' is passed in, build the sequence and definition information
 I RID D
 .S EID=0 F  S EID=$O(^EDPB(232.1,RID,1,EID)) Q:'EID  D
 ..S E0=$G(^EDPB(232.1,RID,1,EID,0)),ESEQ=$P(E0,U),EPTR=$P(E0,U,2)
 ..S EARRY(ESEQ)=EPTR_U_$$EDAT(EPTR)
 ; loop through 'custom' definition (P2) and build EARRY(SEQ)
 I 'RID D
 .S ELOOP=0 F  S ELOOP=$O(P2("element",ELOOP)) Q:'ELOOP  D
 ..S EPTR=$P(P2("element",ELOOP),U)
 ..S ESEQ=$P(P2("element",ELOOP),U,2)
 ..S EARRY(ESEQ)=EPTR_U_$$EDAT(EPTR)
 D SRCH(EDPXML,XMLARRY,CSVARRY,EDPRES,ARRAY,.EARRY,.P1,CSV)
 I '$G(CSV) D TOXMLG^EDPXML(XMLARRY,EDPXML)
 ;I $G(CSV) D TOXMLG^EDPXML(CSVARRY,EDPXML)
 K @EDPRES,@ARRAY,@XMLARRY,@CSVARRY
 Q
 ; using search criteria (from parameters), search the ED log entries.
SRCH(EDPXML,XMLARRY,CSVARRY,EDPRES,ARRAY,EARRY,P1,CSV) ;
 N LOGTIME,LOGID,START,STOP,RES,PROV,PAT,CNT,AREA
 ; check for parameters
 ;S CSV=$G(P1,"csv"),CSV=$S(CSV="true":1,1:0),CNT=0
 ; if no start date is passed, look back 30 days???
 S START=$G(P1("start")) I 'START S START=$$FMADD^XLFDT(DT,-30)
 ; if no stop date is passed, set the stop to NOW
 S STOP=$G(P1("stop")) I 'STOP S STOP=$$NOW^XLFDT
 S RES=$G(P1("resident")),PROV=$G(P1("provider")),PAT=$G(P1("patient"))
 S AREA=$G(P1("area"))
 ; loop through the ED LOG file to get the needed data
 S LOGTIME=START-.000001 F  S LOGTIME=$O(^EDP(230,"ATI",EDPSITE,LOGTIME)) Q:'LOGTIME  D
 .S LOGID=0 F  S LOGID=$O(^EDP(230,"ATI",EDPSITE,LOGTIME,LOGID)) Q:'LOGID  D
 ..; if patient is passed as a parameter, and it doesn't match, quit
 ..I PAT,PAT'=$$GET1^DIQ(230,LOGID,.06,"I") Q
 ..; if provider or resident are passed and this entry is not for the provider/resident, quit
 ..;I PROV,'$$CHKHLOG(LOGID,3.5,PROV) Q
 ..;I RES,'$$CHKHLOG(LOGID,3.7,RES) Q
 ..S CNT=$G(CNT)+1
 ..D BUILD(EDPXML,XMLARRY,CSVARRY,LOGID,CNT,EDPRES,ARRAY,.EARRY,CSV,AREA)
 Q
BUILD(EDPXML,XMLARRY,CSVARRY,LOGID,CNT,EDPRES,ARRAY,EARRY,CSV,AREA) ; Output requested fields from log ID.
 N ESEQ,EPTR,LFIL,HFIL,LFLD,HFLD,TAB,SARRY,E0,LOOP,ICNT,EXE,IARRY,VAL,XHDR,DCNT,XMLLINE,XMLCNT,FHDR,DCNT,HDR,LOGIEN,FORMAT
 ; if there is a reportID, grab the structure for the EDP REPORT TEMPLATE file and process
 S LFIL=230,HFIL=230.1,TAB=$C(9),CSVCNT=0
 ; create temporary storage array for data. this will be used to aggregate the data
 S SARRY=$NA(^TMP("EDPARPT",$J,"BUILD")) K @SARRY
 ; get the main ED LOG (#230) ien
 I $G(CSV) S $P(FHDR,TAB,1)="logID"
 S ESEQ=0 F  S ESEQ=$O(EARRY(ESEQ)) Q:'ESEQ  D
 .S E0=$G(EARRY(ESEQ))
 .S EIEN=$P(E0,U),LFLD=$P(E0,U,4),HFLD=$P(E0,U,5),HDR=$P(E0,U,6)
 .S EXE=$$GET1^DIQ(232.11,EIEN,2,"E"),EXE=$TR(EXE,"|","^")
 .S FORMAT=$$GET1^DIQ(232.11,EIEN,1,"E"),FORMAT=$TR(FORMAT,"|","^")
 .I $G(CSV) S $P(FHDR,TAB,ESEQ+1)=HDR ; set up header if CSV
 .; if EXE is defined, use it. If it is not defined for this element, a simple $$GET1^DIQ will suffice
 .; EXE is intended for complex elements, such as data that can be a multiple or needs to be calculated.
 .; EXE has two values that can be potentially returned. VAL and IARRAY
 .; after EXE has been executed, FORMAT may be used (if available and applicable) to properly format the data for display to the UI.
 .I '$L(EXE) D
 ..S VAL=$$GET1^DIQ(230,LOGID,LFLD,"E")
 ..I $L(FORMAT) X FORMAT
 ..S @SARRY@(LOGID,EIEN,ESEQ,1)=$$ESC^EDPX(VAL) K VAL
 .; if there is executable logic, run it and process results
 .I $L(EXE) D
 ..K IARRY,VAL X EXE
 ..I $D(VAL) D  Q
 ...; format the data if there is formatting logic
 ...I $L(FORMAT) X FORMAT
 ...S @SARRY@(LOGID,EIEN,ESEQ,1)=$$ESC^EDPX($G(VAL)) K VAL
 ..I $O(IARRY(0)) D
 ...S ICNT=0,LOOP=0 F  S LOOP=$O(IARRY(LOOP)) Q:'LOOP  D
 ....S ICNT=ICNT+1
 ....; format the data if there is formatting logic
 ....S VAL=$G(IARRY(LOOP)) I $L(FORMAT) X FORMAT
 ....S @SARRY@(LOGID,EIEN,ESEQ,ICNT)=$$ESC^EDPX(VAL) K VAL
 ..; if no data is returned, we need to at least set the 1 node to null so the header will appear
 ..I '$O(IARRY(0)) S @SARRY@(LOGID,EIEN,ESEQ,1)=""
 ..K IARRY
 ; if CSV, build it, clean up and quit
 I $G(CSV) D BLDCSV(EDPXML,SARRY,CSVARRY,TAB,FHDR) K @SARRY Q
 ; if not CSV, build XML
 S LOGIEN=0 F  S LOGIEN=$O(@SARRY@(LOGIEN)) Q:'LOGIEN  D
 .;I $G(CSV) S CSVCNT=$G(CSVCNT)+1
 .S EIEN=0 F  S EIEN=$O(@SARRY@(LOGIEN,EIEN)) Q:'EIEN  D
 ..S ESEQ=0 F  S ESEQ=$O(@SARRY@(LOGIEN,EIEN,ESEQ)) Q:'ESEQ  D
 ...S XHDR=$P(EARRY(ESEQ),U,6)
 ...S @XMLARRY@("logEntries",1,"logEntry",LOGIEN,"id")=LOGIEN
 ...S @XMLARRY@("logEntries",1,"logEntry",LOGIEN,"elements",1,"element",ESEQ,"sequence")=ESEQ
 ...S @XMLARRY@("logEntries",1,"logEntry",LOGIEN,"elements",1,"element",ESEQ,"header")=XHDR
 ...S DCNT=0 F  S DCNT=$O(@SARRY@(LOGIEN,EIEN,ESEQ,DCNT)) Q:'DCNT  D
 ....S @XMLARRY@("logEntries",1,"logEntry",LOGIEN,"elements",1,"element",ESEQ,"data",DCNT,"value")=$G(@SARRY@(LOGIEN,EIEN,ESEQ,DCNT))
 ; kill off the aggregation global array
 K @SARRY
 Q
 ;
BLDCSV(EDPXML,SARRY,CSVARRY,TAB,FHDR) ;
 N LIEN,EIEN,ESEQ,CSVCNT,ECNT
 S CSVCNT=0
 D ADDG^EDPCSV(FHDR_$C(13)_$C(10),.CSVCNT,EDPXML) ; build the header and include CR/LF
 S LIEN=0 F  S LIEN=$O(@SARRY@(LIEN)) Q:'LIEN  D
 .S EIEN=0 F  S EIEN=$O(@SARRY@(LIEN,EIEN)) Q:'EIEN  D
 ..S ESEQ=0 F  S ESEQ=$O(@SARRY@(LIEN,EIEN,ESEQ)) Q:'ESEQ  D
 ...S ECNT=0 F  S ECNT=$O(@SARRY@(LIEN,EIEN,ESEQ,ECNT)) Q:'ECNT  D
 ....S $P(@CSVARRY@(LIEN,ECNT),TAB,1)=LIEN
 ....S $P(@CSVARRY@(LIEN,ECNT),TAB,ESEQ+1)=$G(@SARRY@(LIEN,EIEN,ESEQ,ECNT))
 S LIEN=0 F  S LIEN=$O(@CSVARRY@(LIEN)) Q:'LIEN  D
 .S ECNT=0 F  S ECNT=$O(@CSVARRY@(LIEN,ECNT)) Q:'ECNT  D
 ..D ADDG^EDPCSV($G(@CSVARRY@(LIEN,ECNT))_$C(13)_$C(10),.CSVCNT,EDPXML) ; build the line and include CR/LF
 Q
 ;
 ; check to see if a resident or provider has ever been assigned to this patient
 ; input
 ;         LOGID - log entry id from file 230
 ;         FLD   - cooresponding field to check data against.
 ;         VAL   - value to test for
CHKHLOG(LOGID,FLD,VAL) ;
 N LTIME,FOUND,HLID
 S FOUND=0
 S LTIME=0 F  S LTIME=$O(^EDP(230.1,"ADF",LOGID,LTIME)) Q:'LTIME  D
 .S HLID=0 F  S HLID=$O(^EDP(230.1,"ADF",LOGID,LTIME,HLID)) Q:'HLID  D
 ..I $$GET1^DIQ(230.1,HLID,FLD,"I")=VAL S FOUND=1
 Q FOUND
 ;
EDAT(IEN) ; return element zero node data
 Q:'IEN ""
 Q $G(^EDPB(232.11,IEN,0))
