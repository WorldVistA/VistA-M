PSOERXI1 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581,617,692,706**;DEC 1997;Build 1
 ;
 Q
 ; File incoming XML into appropriate file
 ; XML - xml text
 ; PRCHK - provider check information
 ; PACHK - patient check information
 ; DACHK - drug auto check
 ; STATION - station #
 ; DIV - institution name^NPI
 ; ERXHID - eRx processing hub id^CANCEL/CHANGE REQUEST DENIED BY HUB (1=YES)^relates to hub ID
 ; ERXVALS - code values for NIST codes (potency unit code^form code^strength code^prohibit renewals - change response (y/n))
 ; XML2 - structured sig from the medication prescribed segment
 ; VADAT - DUZ^RXIEN
 ; XML3 - third stream of XML
INCERX(RES,XML,PRCHK,PACHK,DACHK,STATION,DIV,ERXHID,ERXVALS,XML2,VADAT,XML3) ;
 N CURREC,FDA,EIEN,ERRTXT,ERRSEQ,PACNT,PASCNT,PAICN,PAIEN,VAINST,NPI,VAOI,VPATINST
 S NPI=$P($G(DIV),U,2)
 S CURREC=$$PARSE(.XML,.ERXVALS,NPI,.XML2,.XML3)
 I $P(CURREC,U)<1 D  Q
 .I $L($P(CURREC,U,2)) S RES=CURREC Q
 .S RES="0^XML received. Error creating or finding associated record in the ERX Holding queue." Q
 S EIEN=CURREC
 S CURREC=CURREC_","
 ; if this is an outbound message, file the users DUZ and quit back the response. no drug, patient, or provider auto checks will occur
 I $G(VADAT)]"" D  Q
 .I $P($G(VADAT),U)>1 D
 ..S FDA(52.49,CURREC,51.1)=DUZ D FILE^DIE(,"FDA") K FDA
 .I $P(VADAT,U,2) D
 ..S FDA(52.49,CURREC,.13)=$P(VADAT,U,2) D FILE^DIE(,"FDA") K FDA
 .S RES="1^Erx Received."
 ; Process auto-validation results. only log positive results for now
 K FDA
 I $P($G(VADAT),U) S RES="1^Message Filed." Q
 ;
 ; Drug Auto-Check (Moved from Hub to VistA - P-692)
 I $G(DACHK("success"))="false" D
 . N MSGTYPE,MTCHDRUG,PRDCODE,PRDCOQL,DRGNAME
 . S MSGTYPE=$O(^TMP($J,"PSOERXO1","Message",0,"Body",0,"")) I MSGTYPE="" Q
 . S PRDCODE=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,"MedicationPrescribed",0,"DrugCoded",0,"ProductCode",0,"Code",0)) I PRDCODE="" Q
 . S PRDCOQL=$E($G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,"MedicationPrescribed",0,"DrugCoded",0,"ProductCode",0,"Qualifier",0)),1)
 . I PRDCOQL'="N",PRDCOQL'="U" Q
 . S DRGNAME=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,"MedicationPrescribed",0,"DrugDescription",0))
 . D DRGMTCH^PSOERXA0(.MTCHDRUG,PRDCOQL_"^"_PRDCODE,DRGNAME)
 . I +$G(MTCHDRUG) D
 . . K DACHK S DACHK("success")="true",DACHK("IEN")=+MTCHDRUG
 ;
 I $G(DACHK("success"))="true" D
 .I $G(DACHK("IEN")) D
 ..;Saving the eRx Audit Log For Auto-Matched Drug
 ..S NEWVAL(1)=$$GET1^DIQ(50,DACHK("IEN"),.01)_" (NDC#: "_$$GETNDC^PSSNDCUT(DACHK("IEN"))_")"
 ..D AUDLOG^PSOERXUT(+CURREC,"DRUG",$$PROXYDUZ^PSOERXUT(),.NEWVAL)
 ..;Setting Matched Drug and Auto Match info
 ..S FDA(52.49,CURREC,1.4)=1
 ..S FDA(52.49,CURREC,3.2)=DACHK("IEN")
 ..S FDA(52.49,CURREC,44)=1
 ..S VAOI=$$GET1^DIQ(50,DACHK("IEN"),2.1,"I")
 ..S VPATINST=$$GET1^DIQ(50.7,VAOI,7,"E")
 ..I $L(VPATINST) S FDA(52.49,CURREC,27)=VPATINST
 I $G(DACHK("success"))="false" D
 .S ERRTXT=$G(DACHK("error"))
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 .D FILERR^PSOERXU1(CURREC,ERRSEQ,"D","E",ERRTXT)
 ;
 ; Provider Auto-Check (Moved from Hub to VistA - P-692)
 I $G(PRCHK("success"))="false" D
 . N TMP,MSGTYPE,MTCHPROV,TMP,NPI,DEA,CS
 . S MSGTYPE=$O(^TMP($J,"PSOERXO1","Message",0,"Body",0,"")) I MSGTYPE="" Q
 . S DEA=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,"Prescriber",0,"NonVeterinarian",0,"Identification",0,"DEANumber",0))
 . S NPI=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,"Prescriber",0,"NonVeterinarian",0,"Identification",0,"NPI",0))
 . S CS=($G(^TMP($J,"PSOERXO1","Message",0,"Header",0,"DigitalSignature",0,"SignatureValue",0))'="")
 . D PRVMTCH^PSOERXA0(.MTCHPROV,NPI,DEA,CS)
 . I +$G(MTCHPROV) D
 . . K PRCHK S PRCHK("success")="true",PRCHK("IEN")=+MTCHPROV
 ;
 I $G(PRCHK("success"))="true" D
 .I PRCHK("IEN") D
 ..S FDA(52.49,CURREC,1.2)=1
 ..S FDA(52.49,CURREC,2.3)=PRCHK("IEN")
 ..;Saving the eRx Audit Log for the Auto-Matched Provider
 ..S NEWVAL(1)=$$GET1^DIQ(200,PRCHK("IEN"),.01)_" (DEA#: "_$$DEA^XUSER(0,PRCHK("IEN"))_")"
 ..D AUDLOG^PSOERXUT(+CURREC,"PROVIDER",$$PROXYDUZ^PSOERXUT(),.NEWVAL)
 I $G(PRCHK("success"))="false" D
 .S ERRTXT=$G(PRCHK("error"))
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 .D FILERR^PSOERXU1(CURREC,ERRSEQ,"PR","E",ERRTXT)
 ;
 I $G(PACHK("MVIerror"))']"" D
 .S PAICN=+$P($G(PACHK("ICN")),"V")
 .I PAICN D
 ..S (PAIEN,PACNT)=0 F  S PAIEN=$O(^DPT("AICN",PAICN,PAIEN)) Q:'PAIEN  D
 ...S PACNT=PACNT+1
 ...; revisit in future build - if we find more than one match in the local system, do we log some sort of an error?
 .I $G(PACNT)=1 D  Q
 ..S FDA(52.49,CURREC,1.6)=1
 ..S FDA(52.49,CURREC,.05)=$O(^DPT("AICN",PAICN,0))
 .I $L(PACHK("ssn")) D
 ..S (PASCNT,PAIEN)=0 F  S PAIEN=$O(^DPT("SSN",$TR(PACHK("ssn"),"-",""),PAIEN)) Q:'PAIEN  D
 ...S PASCNT=PASCNT+1
 .I $G(PASCNT)=1 D  Q
 ..S FDA(52.49,CURREC,1.6)=1
 ..S FDA(52.49,CURREC,.05)=$O(^DPT("SSN",$TR(PACHK("ssn"),"-",""),0))
 ;
 ;Saving the eRx Audit Log For Auto-Matched Patient
 I $G(FDA(52.49,CURREC,.05)) D
 .N DFN,VADM S DFN=+FDA(52.49,CURREC,.05) D DEM^VADPT
 .S NEWVAL(1)=$$GET1^DIQ(2,DFN,.01)_" (L4SSN: "_$P($P(VADM(2),"^",2),"-",3)_" | DOB: "_$P(VADM(3),"^",2)_")"
 .D AUDLOG^PSOERXUT(+CURREC,"PATIENT",$$PROXYDUZ^PSOERXUT(),.NEWVAL)
 ;
 I $D(FDA) D FILE^DIE(,"FDA") K FDA
 I $G(PACHK("success"))="false" D
 .; file e&e error
 .S ERRTXT=$G(PACHK("EandEerror")) I ERRTXT]"" D
 ..S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 ..D FILERR^PSOERXU1(CURREC,ERRSEQ,"PA","E",ERRTXT)
 .; file mvi error
 .S ERRTXT=$G(PACHK("MVIerror")) I ERRTXT]"" D
 ..S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 ..D FILERR^PSOERXU1(CURREC,ERRSEQ,"PA","E",ERRTXT)
 S RES="1^Erx Received."
 Q
PARSE(STREAM,ERXVALS,NPI,STREAM2,STREAM3) ;
 N %XML,GL,VAINST,MTYPE,HUBDENY,PROHIBIT
 S GL=$NA(^TMP($J,"PSOERXO1"))
 K @GL
 N STATUS,READER,XOBERR,S,ATTR,READER2,XOBERR2,STATUS2,READER3,STATUS3,XOBERR3
 S STREAM=$TR(STREAM,"^","")
 I $L(STREAM2) S STREAM2=$TR(STREAM2,"^","")
 I $L(STREAM3) S STREAM3=$TR(STREAM3,"^","")
 S STATUS=##class(%XML.TextReader).ParseStream(STREAM,.READER,,,,,1)
 I $L(STREAM2) S STATUS2=##class(%XML.TextReader).ParseStream(STREAM2,.READER2,,,,,1)
 I $L(STREAM3) S STATUS3=##class(%XML.TextReader).ParseStream(STREAM3,.READER3,,,,,1)
 I $$STATCHK^XOBWLIB(STATUS,.XOBERR,1) D
 .N BREAK
 .S BREAK=0 F  Q:BREAK||READER.EOF||'READER.Read()  D
 ..N X,PUSHED,PARENT
 ..I READER.AttributeCount D
 ...S PARENT=READER.LocalName
 ...D SPUSH(.S,PARENT) S PUSHED=1
 ...F ATTR=1:1:READER.AttributeCount D
 ....D READER.MoveToAttributeIndex(ATTR)
 ....I READER.NodeType="attribute" D APUT(.S,READER.Value,READER.LocalName)
 ..I READER.NodeType="element",'$G(PUSHED) D SPUSH(.S,READER.LocalName)
 ..; PSO*7*508 - if the type is an element, and is an empty element, put it in the global.
 ..I READER.NodeType="element",READER.IsEmptyElement D SPUT(.S,"")
 ..I READER.NodeType="endelement" D SPOP(.S,.X)
 ..I READER.NodeType="chars" D SPUT(.S,READER.Value)
 I $D(STATUS2) D
 .I $$STATCHK^XOBWLIB(STATUS2,.XOBERR2,1) D
 ..N BREAK,S
 ..S BREAK=0 F  Q:BREAK||READER2.EOF||'READER2.Read()  D
 ...N X,PUSHED,PARENT
 ...I READER2.AttributeCount D
 ....S PARENT=READER2.LocalName
 ....D SPUSH(.S,PARENT) S PUSHED=1
 ....F ATTR=1:1:READER2.AttributeCount D
 .....D READER2.MoveToAttributeIndex(ATTR)
 .....I READER2.NodeType="attribute" D APUT(.S,READER2.Value,READER2.LocalName)
 ...I READER2.NodeType="element",'$G(PUSHED) D SPUSH(.S,READER2.LocalName)
 ...; PSO*7*508 - if the type is an element, and is an empty element, put it in the global.
 ...I READER2.NodeType="element",READER2.IsEmptyElement D SPUT(.S,"")
 ...I READER2.NodeType="endelement" D SPOP(.S,.X)
 ...I READER2.NodeType="chars" D SPUT(.S,READER2.Value)
 ; STREAM 3
 I $D(STATUS3) D
 .I $$STATCHK^XOBWLIB(STATUS3,.XOBERR3,1) D
 ..N BREAK,S
 ..S BREAK=0 F  Q:BREAK||READER3.EOF||'READER3.Read()  D
 ...N X,PUSHED,PARENT
 ...I READER3.AttributeCount D
 ....S PARENT=READER3.LocalName
 ....D SPUSH(.S,PARENT) S PUSHED=1
 ....F ATTR=1:1:READER3.AttributeCount D
 .....D READER3.MoveToAttributeIndex(ATTR)
 .....I READER3.NodeType="attribute" D APUT(.S,READER3.Value,READER3.LocalName)
 ...I READER3.NodeType="element",'$G(PUSHED) D SPUSH(.S,READER3.LocalName)
 ...; PSO*7*508 - if the type is an element, and is an empty element, put it in the global.
 ...I READER3.NodeType="element",READER3.IsEmptyElement D SPUT(.S,"")
 ...I READER3.NodeType="endelement" D SPOP(.S,.X)
 ...I READER3.NodeType="chars" D SPUT(.S,READER3.Value)
 S MTYPE=$O(^TMP($J,"PSOERXO1","Message",0,"Body",0,"")) Q:MTYPE']"" "0^Message type could not be identified."
 I '$L(NPI) S NPI=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Pharmacy",0,"Identification",0,"NPI",0))
 I '$L(NPI) Q "0^Missing NPI. Institution could not be resolved. eRx not filed."
 S VAINST=$$FIND1^DIC(4,,"O",NPI,"ANPI")
 I '$G(VAINST) Q "0^Institution could not be resolved. eRx not filed."
 N NERXIEN,ERR,PATIEN
 S NERXIEN=$$HDR(MTYPE)
 I $P(NERXIEN,U)<1 Q NERXIEN
 I $G(VAINST) S FDA(52.49,NERXIEN_",",24.1)=VAINST D FILE^DIE(,"FDA") K FDA
 ; if message type is 'Error', do not try to file the other components.
 I MTYPE["Error" D  Q NERXIEN
 .S PATIEN=$$GETPAT^PSOERXU5(NERXIEN) Q:'PATIEN
 .S FDA(52.49,NERXIEN_",",.04)=PATIEN D FILE^DIE(,"FDA") K FDA
 ; NEW PARSING HERE
 ;potential BP - globals are populated
 D ALLERGY^PSOERXID(NERXIEN,MTYPE),BENEFITS^PSOERXID(NERXIEN,MTYPE),FACILITY^PSOERXID(NERXIEN,MTYPE)
 D PAT^PSOERXIA(NERXIEN,MTYPE),PHR^PSOERXIC(NERXIEN,MTYPE)
 N IPR,IMTYP
 F IPR="PR","S","FP" D
 .D PRE^PSOERXIB(NERXIEN,MTYPE,IPR)
 D OBSERV^PSOERXID(NERXIEN,MTYPE)
 F IMTYP="MedicationDispensed","MedicationPrescribed","MedicationRequested" D
 .D MEDS^PSOERXIE(NERXIEN,MTYPE,IMTYP)
 I MTYPE="RxChangeResponse" D
 .S PROHIBIT=$G(ERXVALS("PRRFlag"))
 .;/JSG/ PSO*7.0*581 - BEGIN CHANGE (Fix PROHIBIT value)
 .S FDA(52.49,NERXIEN_",",301.3)=$S(PROHIBIT="true":1,PROHIBIT="false":0,1:"")
 .;/JSG/ - END CHANGE
 .D FILE^DIE(,"FDA") K FDA
 .D CHMESREQ^PSOERXIA(NERXIEN,MTYPE)
 .D CHRESP^PSOERXA6(NERXIEN,MTYPE,VAINST)
 .; AUTO PROCESSING OCCURS HERE
 I MTYPE="RxChangeRequest" D
 .D CHMESREQ^PSOERXIA(NERXIEN,MTYPE)
 I MTYPE="RxRenewalResponse" D
 .D MEDS^PSOERXIE(NERXIEN,MTYPE,"MedicationResponse")
 .D REFRESP^PSOERXA5(NERXIEN,MTYPE)
 I MTYPE["Cancel" D
 .S HUBDENY=$P(ERXHID,U,2)
 .D CANRX^PSOERXA5(NERXIEN,MTYPE,HUBDENY,VAINST)
 Q NERXIEN
HDR(MTYPE) ; header information
 N GL,GL2,FQUAL,TQUAL,FROM,TO,MID,PONUM,SRTID,SSTID,SENTTIME,RTMID,FDA,ERXIEN,FMID,NEWERX,MES,ERXIENS,SSSID,SRSID,MTVALS
 N UPMTYPE,DONE,I,ERXISTAT,MTCODE,COMPSTR,RTHID,RTHIEN,RTMIEN,SIGVAL,X509DATA
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Header",0))
 S GL2=$NA(^TMP($J,"PSOERXO1","Message","A","Qualifier","Header","A","Qualifier"))
 ; from and to qualifiers
 S FQUAL=$G(@GL2@("From","A","Qualifier"))
 S TQUAL=$G(@GL2@("To","A","Qualifier"))
 ; from, to, message id, prescriber order number
 S FROM=$G(@GL@("From",0))
 S TO=$G(@GL@("To",0))
 S MID=$G(@GL@("MessageID",0))
 ; set up the full message id
 S FMID=MID
 S ERXIENS="+1,"
 ; quit and return a message back if this eRx exists.
 I $D(^PS(52.49,"FMID",$P(ERXHID,U))) D  Q MES
 .S MES="0^This message already exists. Changes must occur via a change request XML message."
 ; SCRIPT VERSION
 N DTVER,ECLVER,STRUCTV,TRANDOM,TRANSVER,TPRTVER,SSDEV,SSPROD,SSVER
 S DTVER=$G(^TMP($J,"PSOERXO1","Message","A","DatatypesVersion")),FDA(52.49,ERXIENS,313.1)=DTVER
 S ECLVER=$G(^TMP($J,"PSOERXO1","Message","A","ECLVersion")),FDA(52.49,ERXIENS,313.2)=ECLVER
 S STRUCTV=$G(^TMP($J,"PSOERXO1","Message","A","StructuresVersion")),FDA(52.49,ERXIENS,313.3)=STRUCTV
 S TRANDOM=$G(^TMP($J,"PSOERXO1","Message","A","TransactionDomain")),FDA(52.49,ERXIENS,313.4)=TRANDOM
 S TRANSVER=$G(^TMP($J,"PSOERXO1","Message","A","TransactionVersion")),FDA(52.49,ERXIENS,313.5)=TRANSVER
 S TPRTVER=$G(^TMP($J,"PSOERXO1","Message","A","TransportVersion")),FDA(52.49,ERXIENS,313.6)=TPRTVER
 ; Set the 2017 script standard field to true
 S FDA(52.49,ERXIENS,312.1)=1
 ; Sender software
 ;/JSG/ POS*7.0*581 - BEGIN CHANGE (Changed @GL...Developer to 3 separate fields)
 S SSDEV=$G(@GL@("SenderSoftware",0,"SenderSoftwareDeveloper",0)),FDA(52.49,ERXIENS,314.1)=SSDEV
 S SSPROD=$G(@GL@("SenderSoftware",0,"SenderSoftwareProduct",0)),FDA(52.49,ERXIENS,314.2)=SSPROD
 S SSVER=$G(@GL@("SenderSoftware",0,"SenderSoftwareVersionRelease",0)),FDA(52.49,ERXIENS,314.3)=SSVER
 ;/JSG/ - END CHANGE
 S PONUM=$G(@GL@("PrescriberOrderNumber",0))
 ; security receiver tertiary identification
 S SRSID=$G(@GL@("Security",0,"Receiver",0,"SecondaryIdentification",0))
 S SRTID=$G(@GL@("Security",0,"Receiver",0,"TertiaryIdentification,",0))
 ; security sender tertiary identification
 S SSSID=$G(@GL@("Security",0,"Sender",0,"SecondaryIdentification",0))
 S SSTID=$G(@GL@("Security",0,"Sender",0,"TertiaryIdentification,",0))
 ; convert senttime to file manager dt/tm
 S SENTTIME=$G(@GL@("SentTime",0)),SENTTIME=$$CONVDTTM^PSOERXA1(SENTTIME)
 S RTMID=$G(@GL@("RelatesToMessageID",0))
 S RTHID=$P(ERXHID,U,3)
 S RTHIEN=""
 I $L(RTHID) S RTHIEN=$O(^PS(52.49,"FMID",RTHID,0))
 D FIELD^DID(52.49,.08,"","POINTER","MTVALS")
 S UPMTYPE=$$UP^XLFSTR(MTYPE)
 S DONE=0
 F I=1:1 D  Q:DONE
 .S COMPSTR=$P(MTVALS("POINTER"),";",I)
 .I COMPSTR="" S DONE=1 Q
 .I COMPSTR[UPMTYPE S MTCODE=$P(COMPSTR,":"),DONE=1
 I $G(MTCODE)']"" Q "0^Message type could not be resolved."
 S FDA(52.49,ERXIENS,.08)=MTCODE
 ; erx hub message id
 S FDA(52.49,ERXIENS,.01)=$P(ERXHID,U)
 ; change healthcare message id
 S FDA(52.49,ERXIENS,25)=FMID
 S FDA(52.49,ERXIENS,.02)=RTMID
 S FDA(52.49,ERXIENS,.03)=$$NOW^XLFDT
 S FDA(52.49,ERXIENS,.09)=PONUM
 ;RELATES TO HUB ID
 S FDA(52.49,ERXIENS,.14)=RTHID
 S ERXISTAT=$$GETSTAT^PSOERXU2(MTCODE,RTHIEN,RTMID)
 S FDA(52.49,ERXIENS,1)=ERXISTAT
 S FDA(52.49,ERXIENS,22.1)=FROM
 S FDA(52.49,ERXIENS,22.2)=FQUAL
 S FDA(52.49,ERXIENS,22.3)=TO
 S FDA(52.49,ERXIENS,22.4)=TQUAL
 S FDA(52.49,ERXIENS,22.5)=SENTTIME
 S FDA(52.49,ERXIENS,24.3)=SSSID
 S FDA(52.49,ERXIENS,24.4)=SSTID
 S FDA(52.49,ERXIENS,24.5)=SRSID
 S FDA(52.49,ERXIENS,24.6)=SRTID
 ; Controlled Substance eRx
 S FDA(52.49,ERXIENS,95.1)=$$CSERX^PSOERXA1()
 I $$CSERX^PSOERXA1() D
 . S FDA(52.49,ERXIENS,95.2)=$G(@GL@("DigitalSignature",0,"DigestMethod",0))
 . S FDA(52.49,ERXIENS,95.3)=$G(@GL@("DigitalSignature",0,"DigestValue",0))
 . K SIGVAL S SIGVAL(1)=$G(@GL@("DigitalSignature",0,"SignatureValue",0))
 . S FDA(52.49,ERXIENS,95.4)="SIGVAL"
 . K X509DAT S X509DAT(1)=$G(@GL@("DigitalSignature",0,"X509Data",0))
 . S FDA(52.49,ERXIENS,95.5)="X509DAT"
 ; if this is an existing record, file the updates to the erx and return the IEN
 D UPDATE^DIE(,"FDA","NEWERX","EERR") K FDA
 S ERXIEN=""
 S ERXIEN=$O(NEWERX(0)),ERXIEN=$G(NEWERX(ERXIEN))
 I 'ERXIEN Q ""
 I $G(RTHIEN)]"" D
 .N REFREQ,NRXIEN
 .S NRXIEN=$$FINDNRX^PSOERXU6(ERXIEN)
 .I MTCODE="RE"!(MTCODE="CX") D
 ..S REFREQ=$$GETREQ^PSOERXU2(ERXIEN)
 ..I REFREQ S NRXIEN=$$FINDNRX^PSOERXU6(REFREQ)
 ..I $D(^PS(52.49,NRXIEN,201,"B",ERXIEN)) Q
 ..I $G(NRXIEN) S FDA2(52.49201,"+1,"_NRXIEN_",",.01)=ERXIEN D UPDATE^DIE(,"FDA2") K FDA2
 .; link this message to the original
 .I $G(NRXIEN) D
 ..I $D(^PS(52.49,NRXIEN,201,"B",ERXIEN)) Q
 ..S FDA2(52.49201,"+1,"_NRXIEN_",",.01)=ERXIEN D UPDATE^DIE(,"FDA2") K FDA2
 .I '$D(^PS(52.49,RTHIEN,201,"B",ERXIEN)) D
 ..S FDA2(52.49201,"+1,"_RTHIEN_",",.01)=ERXIEN D UPDATE^DIE(,"FDA2") K FDA2
 .; link original message to this erxien
 .I '$D(^PS(52.49,ERXIEN,201,"B",RTHIEN)) D
 ..S FDA2(52.49201,"+1,"_ERXIEN_",",.01)=RTHIEN D UPDATE^DIE(,"FDA2") K FDA2
 I MTYPE["Error" D ERR^PSOERXU2(ERXIEN,MTYPE)
 Q ERXIEN
SPUSH(S,X) ;places X on the stack S and returns the current level of the stack
 N I S I=$O(S(""),-1)+1,S(I)=X
 Q I
 ;
SPOP(S,X) ;removes the top item from the stack S and put it into the variable X and returns the level that X was at
 N I S I=$O(S(""),-1)
 I I S X=S(I) K S(I)
 N J S J=$O(S(I),-1) I J S S(J,X)=$G(S(J,X))+1
 Q I
 ;
SPEEK(S,X) ;same as SPOP except the top item is not removed
 N I S I=$O(S(""),-1)
 I I S X=S(I)
 Q I
 ;
SPUT(S,X) ;implementation specific, uses the stack to form a global node
 N I,STR
 S X=$TR(X,";","")
 S STR=$P(GL,")")
 S I=0 F  S I=$O(S(I)) Q:'I  D
 .S STR=STR_","_""""_S(I)_""""_","
 .N NUM S NUM=0
 .I $D(S(I-1,S(I))) S NUM=+$G(S(I-1,S(I)))
 .S STR=STR_NUM
 S STR=STR_")"
 I $D(@STR) S @STR=@STR_X
 I '$D(@STR) S @STR=X
 Q STR
APUT(S,X,LN) ;
 N I,STR
 S X=$TR(X,";","")
 S STR=$P(GL,")")
 S I=0 F  S I=$O(S(I)) Q:'I  D
 .S STR=STR_","_""""_S(I)_""""_","
 .N NUM S NUM="""A"""
 .;I $D(S(I-1,S(I))) S NUM=+$G(S(I-1,S(I)))
 .;S STR=STR_NUM
 .S STR=STR_NUM_","_""""_LN_""""
 S STR=STR_")"
 I $D(@STR) S @STR=@STR_X
 I '$D(@STR) S @STR=X
 Q STR
 ;
 ; VAL - value to resolve
 ; TYPE - This is the code type, which will tell which 'C' index type to get the code from
PRESOLV(VAL,TYPE) ;
 N MATCH
 S MATCH=""
 Q:'$L(TYPE)!('$L(VAL)) "" ; avoid null subscript
 S MATCH=$O(^PS(52.45,"C",TYPE,VAL,0))
 ; return the match found, null if no match
 Q MATCH
CONVDTTM(VAL) ;
 N EDATE,ETIME,X,ETZ,Y
 I '$L(VAL) Q ""
 S EDATE=$P(VAL,"T"),ETIME=$P(VAL,"T",2)
 ; split off time zone
 S ETZ=$P(ETIME,".",2)
 S ETIME=$P(ETIME,".")
 S X=EDATE D ^%DT I 'Y Q ""
 S VAL=Y_$S($L(ETIME):"."_$TR(ETIME,":",""),1:"")
 Q VAL
