PSOERXA1 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,520**;DEC 1997;Build 52
 ;
 Q
 ; File incoming XML into appropriate file
 ; XML - xml text
 ; PRCHK - provider check information
 ; PACHK - patient check information
 ; DACHK - drug auto check
 ; STATION - station #
 ; DIV - division
 ; ERXHID - eRx processing hub id
 ; ERXVALS - code values for NIST codes
INCERX(RES,XML,PRCHK,PACHK,DACHK,STATION,DIV,ERXHID,ERXVALS,XML2) ;
 N CURREC,FDA,EIEN,ERRTXT,ERRSEQ,PACNT,PASCNT,PAICN,PAIEN,VAINST,NPI,VAOI,VPATINST
 ; meds by mail modification. Same institution pointed to by multiple outpatient pharmacy systems.
 ; additionally, 741CHEY and 741DUB are not associated with an institution in file 4.
 S NPI=$P($G(DIV),U,2)
 S CURREC=$$PARSE(.XML,.ERXVALS,NPI,.XML2)
 I $P(CURREC,U)<1 D  Q
 .I $L($P(CURREC,U,2)) S RES=CURREC Q
 .S RES="0^XML received. Error creating or finding associated record in the ERX Holding queue." Q
 S EIEN=CURREC
 S CURREC=CURREC_","
 ; Process auto-validation results. only log positive results for now - bwf 2/1/2017
 K FDA
 I DACHK("success")="true" D
 .I $G(DACHK("IEN")) D
 ..S FDA(52.49,CURREC,1.4)=1
 ..S FDA(52.49,CURREC,3.2)=DACHK("IEN")
 ..S FDA(52.49,CURREC,44)=1
 ..S VAOI=$$GET1^DIQ(50,DACHK("IEN"),2.1,"I")
 ..S VPATINST=$$GET1^DIQ(50.7,VAOI,7,"E")
 ..I $L(VPATINST) S FDA(52.49,CURREC,27)=VPATINST
 I DACHK("success")="false" D
 .S ERRTXT=$G(DACHK("error"))
 .S ERRSEQ=$$ERRSEQ^PSOERXU1() Q:'ERRSEQ
 .D FILERR^PSOERXU1(CURREC,ERRSEQ,"D","E",ERRTXT)
 I $G(PRCHK("success"))="true" D
 .I PRCHK("IEN") D
 ..S FDA(52.49,CURREC,1.2)=1
 ..S FDA(52.49,CURREC,2.3)=PRCHK("IEN")
 I $G(PRCHK("success"))="false" D
 .S ERRTXT=$G(PRCHK("error"))
 .S ERRSEQ=$$ERRSEQ^PSOERXU1() Q:'ERRSEQ
 .D FILERR^PSOERXU1(CURREC,ERRSEQ,"PR","E",ERRTXT)
 ; replacing below line with the one that follows for patient matching
 ; if there is no MVIerror, the MVI check was successful, so we need to try to auto-match the patient
 ;I PACHK("success")="true" D
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
 I $D(FDA) D FILE^DIE(,"FDA") K FDA
 I $G(PACHK("success"))="false" D
 .; file e&e error
 .S ERRTXT=$G(PACHK("EandEerror")) I ERRTXT]"" D
 ..S ERRSEQ=$$ERRSEQ^PSOERXU1() Q:'ERRSEQ
 ..D FILERR^PSOERXU1(CURREC,ERRSEQ,"PA","E",ERRTXT)
 .; file mvi error
 .S ERRTXT=$G(PACHK("MVIerror")) I ERRTXT]"" D
 ..S ERRSEQ=$$ERRSEQ^PSOERXU1() Q:'ERRSEQ
 ..D FILERR^PSOERXU1(CURREC,ERRSEQ,"PA","E",ERRTXT)
 S RES="1^Erx Received."
 Q
PARSE(STREAM,ERXVALS,NPI,STREAM2) ;
 N %XML,GL,VAINST
 S GL=$NA(^TMP($J,"PSOERXO1"))
 K @GL
 N STATUS,READER,XOBERR,S,ATTR,READER2,XOBERR2,STATUS2
 S STREAM=$TR(STREAM,"^","")
 I $L(STREAM2) S STREAM2=$TR(STREAM2,"^","")
 S STATUS=##class(%XML.TextReader).ParseStream(STREAM,.READER,,,,,1)
 I $L(STREAM2) S STATUS2=##class(%XML.TextReader).ParseStream(STREAM2,.READER2,,,,,1)
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
 ..I READER.NodeType="endelement" D SPOP(.S,.X)
 ..I READER.NodeType="chars" D SPUT(.S,READER.Value)
 I $$STATCHK^XOBWLIB(STATUS2,.XOBERR2,1) D
 .N BREAK,S
 .S BREAK=0 F  Q:BREAK||READER2.EOF||'READER2.Read()  D
 ..N X,PUSHED,PARENT
 ..I READER2.AttributeCount D
 ...S PARENT=READER2.LocalName
 ...D SPUSH(.S,PARENT) S PUSHED=1
 ...F ATTR=1:1:READER2.AttributeCount D
 ....D READER2.MoveToAttributeIndex(ATTR)
 ....I READER2.NodeType="attribute" D APUT(.S,READER2.Value,READER2.LocalName)
 ..I READER2.NodeType="element",'$G(PUSHED) D SPUSH(.S,READER2.LocalName)
 ..I READER2.NodeType="endelement" D SPOP(.S,.X)
 ..I READER2.NodeType="chars" D SPUT(.S,READER2.Value)
 I '$L(NPI) S NPI=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Pharmacy",0,"Identification",0,"NPI",0))
 I '$L(NPI) Q "0^Missing NPI. Institution could not be resolved. eRx not filed."
 S VAINST=$$FIND1^DIC(4,,"O",NPI,"ANPI")
 I '$G(VAINST) Q "0^Institution could not be resolved. eRx not filed."
 N NERXIEN,ERR
 S NERXIEN=$$HDR()
 I $P(NERXIEN,U)<1 Q NERXIEN
 I $G(VAINST) S FDA(52.49,NERXIEN_",",24.1)=VAINST D FILE^DIE(,"FDA") K FDA
 D PAT(NERXIEN),BFC(NERXIEN),PHR^PSOERXA2(NERXIEN),PRE^PSOERXA2(NERXIEN)
 D MED^PSOERXA3(NERXIEN,.ERXVALS),OBS(NERXIEN),SUP^PSOERXA2(NERXIEN)
 ; facility/request have no where to go at this point in time??
 ;/BLB/ PSO*7.0*520 - BEGIN CHANGE
 D FAC^PSOERXA2(NERXIEN)
 ;/BLB/ - END CHANGE
 Q NERXIEN
HDR() ; header information
 N GL,GL2,FQUAL,TQUAL,FROM,TO,MID,PONUM,SRTID,SSTID,SENTTIME,RTMID,FDA,ERXIEN,FMID,NEWERX,MES,ERXIENS,SSSID,SRSID
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
 ; This logic was intended to handle 'updates' to and existing message if the same message id was received
 ; however, updates should probably occur through a change request, so if the same message id is received, we
 ; are returning an error.
 ;I $D(^PS(52.49,"FMID",FMID)) D
 ;.S ERXIEN=$O(^PS(52.49,"FMID",FMID,0)),UPDATE=1
 ;I '$G(ERXIEN) S ERXIEN="+1"
 S ERXIENS="+1,"
 ; quit and return a message back if this eRx exists.
 I $D(^PS(52.49,"FMID",ERXHID)) D  Q MES
 .S MES="0^This message already exists. Changes must occur via a change request XML message."
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
 ; erx hub message id
 S FDA(52.49,ERXIENS,.01)=ERXHID
 ; change healthcare message id
 S FDA(52.49,ERXIENS,25)=FMID
 S FDA(52.49,ERXIENS,.02)=RTMID
 S FDA(52.49,ERXIENS,.03)=$$NOW^XLFDT
 S FDA(52.49,ERXIENS,.09)=PONUM
 S FDA(52.49,ERXIENS,1)=$$PRESOLV^PSOERXA1("N","ERX")
 S FDA(52.49,ERXIENS,22.1)=FROM
 S FDA(52.49,ERXIENS,22.2)=FQUAL
 S FDA(52.49,ERXIENS,22.3)=TO
 S FDA(52.49,ERXIENS,22.4)=TQUAL
 S FDA(52.49,ERXIENS,22.5)=SENTTIME
 S FDA(52.49,ERXIENS,24.3)=SSSID
 S FDA(52.49,ERXIENS,24.4)=SSTID
 S FDA(52.49,ERXIENS,24.5)=SRSID
 S FDA(52.49,ERXIENS,24.6)=SRTID
 ; if this is an existing record, file the updates to the erx and return the IEN
 ;I $G(UPDATE) D FILE^DIE(,"FDA") K FDA Q ERXIEN
 D UPDATE^DIE(,"FDA","NEWERX","EERR") K FDA
 S ERXIEN=""
 S ERXIEN=$O(NEWERX(0)),ERXIEN=$G(NEWERX(ERXIEN))
 I 'ERXIEN Q ""
 ; Future consideration - XSD shows digital signature. Do we need to collect this?
 Q ERXIEN
BFC(ERXIEN) ; benefits coordination
 N GL,BFCCNT,CHFN,CHLN,CHMN,CHPRE,CHSUFF,CHID,GRPID,PIDTYP,PIDVAL,CHFN,F,PIEN,NEWPAYER,BFCERR,IENS,CHFULLN,FDA,BSEQ,PNAME,PIDCNT
 S F=52.4918
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"BenefitsCoordination"))
 ; cannot start at 0, since the first entry is on the 0 subscript.
 S BSEQ=0
 S BFCCNT=-1 F  S BFCCNT=$O(@GL@(BFCCNT)) Q:BFCCNT=""  D
 .S BSEQ=BSEQ+1
 .S CHFN=$$UP^XLFSTR($G(@GL@(BFCCNT,"CardHolderName",0,"FirstName",0)))
 .S CHLN=$$UP^XLFSTR($G(@GL@(BFCCNT,"CardHolderName",0,"LastName",0)))
 .S CHMN=$$UP^XLFSTR($G(@GL@(BFCCNT,"CardHolderName",0,"MiddleName",0)))
 .; set up full name - last, first, mi
 .S CHFULLN=CHLN_","_CHFN_$S(CHMN]"":" "_CHMN,1:"")
 .S CHPRE=$$UP^XLFSTR($G(@GL@(BFCCNT,"CardHolderName",0,"Prefix",0)))
 .S CHSUFF=$$UP^XLFSTR($G(@GL@(BFCCNT,"CardHolderName",0,"Suffix",0)))
 .S CHID=$G(@GL@(BFCCNT,"CardholderID",0))
 .S GRPID=$G(@GL@(BFCCNT,"GroupID",0))
 .;/BLB/ PSO*7.0*520
 .S PNAME=$G(@GL@(BFCCNT,"PayerName",0))
 .S IENS="+1,"_ERXIEN_","
 .S FDA(F,IENS,.01)=BSEQ,FDA(F,IENS,7)=CHID,FDA(F,IENS,.02)=GRPID,FDA(F,IENS,.03)=PNAME
 .S FDA(F,IENS,1)=CHLN,FDA(F,IENS,2)=CHFN,FDA(F,IENS,3)=CHMN,FDA(F,IENS,4)=CHSUFF,FDA(F,IENS,5)=CHPRE
 .K NEWPAYER
 .D UPDATE^DIE(,"FDA","NEWPAYER") K FDA
 .;/BLB/ - END CHANGE
 .S PIEN=$O(NEWPAYER(0)),PIEN=$G(NEWPAYER(PIEN)) Q:'PIEN
 .S PIDCNT=-1 F  S PIDCNT=$O(@GL@(BFCCNT,"PayerIdentification",PIDCNT)) Q:PIDCNT=""  D
 ..S PIDTYP="" F  S PIDTYP=$O(@GL@(BFCCNT,"PayerIdentification",PIDCNT,PIDTYP)) Q:PIDTYP=""  D
 ...S PIDVAL=$G(@GL@(BFCCNT,"PayerIdentification",PIDCNT,PIDTYP,0))
 ...S FDA(52.49186,"+1,"_PIEN_","_ERXIEN_",",.01)=PIDTYP
 ...S FDA(52.49186,"+1,"_PIEN_","_ERXIEN_",",.02)=PIDVAL
 ...D UPDATE^DIE(,"FDA") K FDA
 .K NEWPAYER,PIEN
 Q
OBS(ERXIEN) ; Observation
 N GL,I,LAST,DIM,MSOURCE,MUNIT,OBSDT,MVAL,OBSNOTE,OBSCNT,F,EIENS,FDA
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Observation",0))
 S F=52.4914,EIENS=ERXIEN_","
 S I=-1,OBSCNT=0 F  S I=$O(@GL@("Measurement",I)) Q:I=""  D
 .S OBSCNT=OBSCNT+1,FDA(F,"+1,"_EIENS,.01)=OBSCNT
 .S DIM=$G(@GL@("Measurement",I,"Dimension",0)),FDA(F,"+1,"_EIENS,.02)=DIM
 .S MSOURCE=$G(@GL@("Measurement",I,"MeasurementSourceCode",0)),FDA(F,"+1,"_EIENS,.06)=MSOURCE
 .S MUNIT=$G(@GL@("Measurement",I,"MeasurementUnitCode",0)),FDA(F,"+1,"_EIENS,.07)=MUNIT
 .; Future enhancement - we have a field for MeasurementDataQualifier (.05) - is this valid?
 .S OBSDT=$G(@GL@("Measurement",I,"ObservationDate",0,"Date",0)),OBSDT=$$CONVDTTM^PSOERXA1(OBSDT),FDA(F,"+1,"_EIENS,.04)=OBSDT
 .S MVAL=$G(@GL@("Measurement",I,"Value",0)),FDA(F,"+1,"_EIENS,.03)=MVAL
 .D UPDATE^DIE(,"FDA") K FDA
 S OBSNOTE=$G(@GL@("ObservationNotes",0)),FDA(52.49,EIENS,15)=OBSNOTE D FILE^DIE(,"FDA") K FDA
 Q
PAT(ERXIEN) ; patient
 N GL,AL1,AL2,CITY,STATE,ZIP,LN,FN,MN,PREF,SUFF,COMQUAL,COMVAL,PLQUAL,DOB,GEN,PRELATE,IDDONE,CDONE,I,C,CQUAL,CVAL
 N IDNM,IDVAL,PFN,ERXPAT,NEWPAT,F,EIENS,FDA,IDFND,SRCH,PIENS,NPIEN,PATSSN,PREL
 S F=52.46
 S EIENS=ERXIEN_","
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Patient",0))
 S PREL=$G(@GL@("PatientRelationship",0))
 S FN=$$UP^XLFSTR($G(@GL@("Name",0,"FirstName",0)))
 S LN=$$UP^XLFSTR($G(@GL@("Name",0,"LastName",0)))
 S MN=$$UP^XLFSTR($G(@GL@("Name",0,"MiddleName",0)))
 S PFN=LN_","_FN_$S(MN]"":" "_MN,1:"")
 S SUFF=$$UP^XLFSTR($G(@GL@("Name",0,"Suffix",0)))
 S PREF=$$UP^XLFSTR($G(@GL@("Name",0,"Prefix",0)))
 S PRELATE=$G(@GL@("PatientRelationship",0))
 S GEN=$G(@GL@("Gender",0))
 S DOB=$G(@GL@("DateOfBirth",0,"Date",0)),DOB=$$CONVDTTM^PSOERXA1(DOB)
 I DOB<1 S DOB=""
 S AL1=$G(@GL@("Address",0,"AddressLine1",0))
 S AL2=$G(@GL@("Address",0,"AddressLine2",0))
 S CITY=$G(@GL@("Address",0,"City",0))
 S STATE=$G(@GL@("Address",0,"State",0))
 S ZIP=$G(@GL@("Address",0,"ZipCode",0))
 ; need to check for SSN before trying to match the patient. This needs to be stored in an array for later processing
 ; check 52.46 for a match before filing
 S PATSSN=$G(@GL@("Identification",0,"SocialSecurity",0))
 S ERXPAT=$$FINDPAT^PSOERXA1(PFN,DOB,GEN,$G(PATSSN),$G(AL1)) S PIENS=$S(ERXPAT:ERXPAT_",",1:"+1,")
 ; first, lets set up the main part
 S FDA(F,PIENS,.01)=PFN,FDA(F,PIENS,.02)=LN,FDA(F,PIENS,.03)=FN,FDA(F,PIENS,.04)=MN,FDA(F,PIENS,.05)=SUFF,FDA(F,PIENS,.06)=PREF
 S FDA(F,PIENS,.07)=GEN,FDA(F,PIENS,.08)=DOB
 S FDA(F,PIENS,1.4)=PATSSN,FDA(F,PIENS,1.7)=PREL
 S FDA(F,PIENS,3.1)=AL1,FDA(F,PIENS,3.2)=AL2,FDA(F,PIENS,3.3)=CITY
 S FDA(F,PIENS,3.4)=$$FIND1^DIC(5,,,STATE,"C")
 S FDA(F,PIENS,3.5)=ZIP
 I PIENS["+" D  Q
 .D UPDATE^DIE(,"FDA","NEWPAT") K FDA
 .S NPIEN=$O(NEWPAT(0)),NPIEN=$G(NEWPAT(NPIEN))
 .Q:'NPIEN
 .S NPIEN=NPIEN
 .D PATC(NPIEN)
 .S FDA(52.49,EIENS,.04)=NPIEN D FILE^DIE(,"FDA") K FDA
 D FILE^DIE(,"FDA") K FDA D PATC(ERXPAT)
 S FDA(52.49,EIENS,.04)=ERXPAT D FILE^DIE(,"FDA") K FDA
 ; if this is an existing record loop through the communication values and do a compare to see what needs to be updated
 ; otherwise, build the FDA and file the communication values.
 Q
PATC(IEN) ; patient communication
 N IENS,CQUAL,CVAL,COMARY,FDA,SRCH,IDFND,IDNM,IDVAL,IDARY,PATSSN
 Q:'IEN
 S IENS=IEN_","
 ; Kill off existing communication values
 K ^PS(52.46,IEN,3)
 S C=-1 F  S C=$O(@GL@("CommunicationNumbers",0,"Communication",C)) Q:C=""  D
 .S CQUAL=$G(@GL@("CommunicationNumbers",0,"Communication",C,"Qualifier",0))
 .S CVAL=$G(@GL@("CommunicationNumbers",0,"Communication",C,"Number",0))
 .S COMARY(CQUAL)=CVAL
 .S FDA(52.462,"+1,"_IENS,.01)=CVAL
 .S FDA(52.462,"+1,"_IENS,.02)=CQUAL
 .D UPDATE^DIE(,"FDA") K FDA
 ; kill existing identification values in multiple
 K ^PS(52.46,IEN,5)
 S IDNM="" F  S IDNM=$O(@GL@("Identification",0,IDNM)) Q:IDNM=""  D
 .S IDVAL=$G(@GL@("Identification",0,IDNM,0))
 .I IDNM="SocialSecurity" S PATSSN=IDVAL
 .S IDARY(IDNM)=IDVAL
 .S IDFND=0
 .S SRCH=0 F  S SRCH=$O(^PS(52.46,IEN,5,SRCH)) Q:'SRCH  D
 ..I $$GET1^DIQ(52.465,SRCH_","_IEN_",",.01)=IDNM D
 ...S IDFND=1
 ...S FDA(52.465,SRCH_","_IEN_",",.02)=IDVAL D FILE^DIE(,"FDA") K FDA
 .Q:IDFND
 .S FDA(52.465,"+1,"_IEN_",",.01)=IDNM
 .S FDA(52.465,"+1,"_IEN_",",.02)=IDVAL
 .D UPDATE^DIE(,"FDA") K FDA
 I $G(PATSSN)]"" S FDA(52.46,IENS,1.4)=PATSSN D FILE^DIE(,"FDA") K FDA
 Q
REQ ; request
 N GL,CRTYPE,RETREC,RRNUM
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Request",0))
 S CRTYPE=$G(@GL@("ChangeRequestType",0))
 S RETREC=$G(@GL@("ReturnReceipt",0))
 S RRNUM=$G(@GL@("RequestReferenceNumber",0))
 ; Implement when different types of messages are coming in.
 Q
 ;
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
APUT(S,X,LN) ; what am i doing here?
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
 ; look for existing patient
 ; NAME - PATIENT FULL NAME
 ; IDOB - INCOMING PATIENT DOB
 ; IDGEN - INCOMING PATIENT GENDER
 ; SSN - INCOMING PATIENT SSN
 ; AL1 - INCOMING PATIENT ADDRESS LINE 1
FINDPAT(NAME,IDOB,IGEN,SSN,AL1) ;
 N MPAT,MTCHCNT,PIEN,MATCH,PDOB,PGEN,PSSN,PAL1
 ; for now, quit if name match does not occur.
 I '$D(^PS(52.46,"BN",NAME)) Q ""
 S MTCHCNT=0
 S PIEN=0 F  S PIEN=$O(^PS(52.46,"BN",NAME,PIEN)) Q:'PIEN  D
 .S PDOB=$$GET1^DIQ(52.46,PIEN,.08,"I"),PGEN=$$GET1^DIQ(52.46,PIEN,.07,"I")
 .S PSSN=$$GET1^DIQ(52.46,PIEN,1.4),PAL1=$$GET1^DIQ(52.46,PIEN,3.1,"E")
 .; if the ssn exists, and does not match, quit
 .I $L(SSN),SSN'=PSSN Q
 .I PDOB=IDOB,PGEN=IGEN,AL1=PAL1 S MTCHCNT=MTCHCNT+1,MATCH(PIEN)=""
 I MTCHCNT'=1 Q ""
 S MPAT=$O(MATCH(0))
 I MPAT Q MPAT
 Q ""
 ; look for existing provider/prescriber
FINDPRE(NAME,NPI,DEA) ;
 N NPCNT,NPIMTCH,NLIST,NLCNT,NLOOP,NLIST2,NAMEMTCH,NMLOOP,NMCNT,NMLIST,DCNT,DEAMTCH,DLCNT,DLIST,DLIST2
 N DLOOP,DMTCH,NPDEA
 ; if there is an NPI, and DEA#, check both. If only one match, then this is the same provider
 I $L(NPI) D  Q NPIMTCH
 .I '$D(^PS(52.48,"C",NPI)) S NPIMTCH="" Q
 .S NPCNT=0
 .S NPIMTCH=0 F  S NPIMTCH=$O(^PS(52.48,"C",NPI,NPIMTCH)) Q:'NPIMTCH  D
 ..S NPDEA=$$GET1^DIQ(52.48,NPIMTCH,1.6,"E") I $L(DEA),NPDEA'=DEA Q
 ..S NLIST(NPIMTCH)="",NPCNT=NPCNT+1
 .; if we have a single match for NPI and DEA# return the result
 .I NPCNT=0 S NPIMTCH="" Q
 .I NPCNT=1 S NPIMTCH=$O(NLIST(0)) Q
 .S NLCNT=0
 .S NLOOP=0 F  S NLOOP=$O(NLIST(NLOOP)) Q:'NLOOP  D
 ..I $L(NAME),NAME=$$GET1^DIQ(52.48,NLOOP,.01,"E") S NLIST2(NLOOP)="",NLCNT=NLCNT+1
 .I NLCNT=0!(NLCNT>1) S NPIMTCH="" Q
 .I NLCNT=1 S NPIMTCH=$O(NLIST2(0)) Q
 I $L(DEA) D  Q DEAMTCH
 .I '$D(^PS(52.48,"D",DEA)) S DEAMTCH="" Q
 .S (DCNT,DMTCH)=0 F  S DMTCH=$O(^PS(52.48,"D",DEA,DMTCH)) Q:'DMTCH  D
 ..S DLIST(DMTCH)="",DCNT=DCNT+1
 .I DCNT=0 S DEAMTCH="" Q
 .I DCNT=1 S DEAMTCH=$O(DLIST(0)) Q
 .S (DLOOP,DLCNT)=0 F  S DLOOP=$O(DLIST(DLOOP)) Q:'DLOOP  D
 ..I $L(NAME),NAME=$$GET1^DIQ(52.48,DLOOP,.01,"E") S DLIST2(DLOOP)="",DLCNT=DLCNT+1
 .I DLCNT=0!(DLCNT>1) S DEAMTCH="" Q
 .I DLCNT=1 S DEAMTCH=$O(DLIST2(0))
 I $L(NAME) D  Q NAMEMTCH
 .I '$D(^PS(52.48,"BN",NAME)) S NAMEMTCH="" Q
 .S (NMLOOP,NMCNT)=0 F  S NMLOOP=$O(^PS(52.48,"BN",NAME,NMLOOP)) Q:'NMLOOP  D
 ..S NMLIST(NMLOOP)="",NMCNT=NMCNT+1
 .I NMCNT=0!(NMCNT>1) S NAMEMTCH="" Q
 .S NAMEMTCH=$O(NMLIST(0))
 Q ""
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
