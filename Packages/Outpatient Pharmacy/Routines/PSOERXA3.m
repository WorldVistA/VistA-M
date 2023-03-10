PSOERXA3 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,508,617**;DEC 1997;Build 110
 ;
 Q
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
 I UPMTYPE="REFILLREQUEST" S UPMTYPE="RXRENEWALREQUEST"
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
 .I MTCODE="RE" D
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
 ; Future consideration - XSD shows digital signature. Do we need to collect this?
 Q ERXIEN
 ;
MED(ERXIEN,ERXVALS,MTYPE) ; medication prescribed
 N GL,VALDT,DAYS,CIQUAL,PQUAL,PDIAG,SQUAL,DIAG,SDIAG,DIRECT,DCSTAT,DCSCODE,DDESC,DUE,CAID,CAQUAL,PSC,SREACODE,SRESCODE
 N EFFDT,EXPDT,NOTE,PEDT,PAUTHQ,PAUTHV,PAUTHS,QCLQ,QPUC,QUSC,QTY,REFQUAL,REFILLS,WRITDT,SUBS,STOPIND,CLINSIG,ACKREA
 N F,EIENS,SFDA,FDA,DIENS,DCCNT,VALDATE,DCDBCOD,DCDBCODQ,DCDEASCH,DCFC,DCFSC,DCPCODE,DCPCQUAL,DCSTR,DCSTRC,DCSTSC,GL2
 N DONOTFIL
 I 'ERXIEN Q
 S EIENS=ERXIEN_","
 S F=52.49
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"MedicationPrescribed",0))
 S GL2=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"MedicationDispensed",0))
 S VALDT=$G(@GL@("DateValidated",0,"Date",0)),VALDATE=$$CONVDTTM^PSOERXA1(VALDT),FDA(52.49,EIENS,6.6)=VALDATE
 S DAYS=$G(@GL@("DaysSupply",0)) I DAYS S FDA(F,EIENS,5.5)=+$G(DAYS)
 ; force to numeric
 I +$G(DAYS)<366 S FDA(F,EIENS,20.2)=+$G(DAYS)
 S FDA(F,EIENS,20.4)="M"
 S DIRECT=$G(@GL@("Directions",0)),FDA(F,EIENS,7)=DIRECT
 S DDESC=$$UP^XLFSTR($G(@GL@("DrugDescription",0))),FDA(52.49,EIENS,3.1)=DDESC
 ; drugCoded
 S DCPCODE=$G(@GL@("DrugCoded",0,"ProductCode",0)),FDA(F,EIENS,4.1)=DCPCODE
 S DCPCQUAL=$G(@GL@("DrugCoded",0,"ProductCodeQualifier",0)),FDA(F,EIENS,4.2)=DCPCQUAL
 S DCSTR=$G(@GL@("DrugCoded",0,"Strength",0)),FDA(F,EIENS,4.3)=DCSTR
 S DCDBCOD=$G(@GL@("DrugCoded",0,"DrugDBCode",0)),FDA(F,EIENS,4.4)=DCDBCOD
 S DCDBCODQ=$G(@GL@("DrugCoded",0,"DrugDBCodeQualifier",0)),FDA(F,EIENS,4.11)=$$PRESOLV^PSOERXA1(DCDBCODQ,"DDB")
 S DCFSC=$G(@GL@("DrugCoded",0,"FormSourceCode",0)),FDA(F,EIENS,4.5)=DCFSC
 S DCFC=$G(@GL@("DrugCoded",0,"FormCode",0)),FDA(F,EIENS,4.6)=DCFC
 S DCSTSC=$G(@GL@("DrugCoded",0,"StrengthSourceCode",0)),FDA(F,EIENS,4.7)=DCSTSC
 S DCSTRC=$G(@GL@("DrugCoded",0,"StrengthCode",0)),FDA(F,EIENS,4.8)=DCSTRC
 S DCDEASCH=$G(@GL@("DrugCoded",0,"DEASchedule",0)),FDA(F,EIENS,4.9)=DCDEASCH
 ; end drugCoded
 S EFFDT=$G(@GL@("EffectiveDate",0,"Date",0))
 I EFFDT="" S EFFDT=$G(@GL@("EffectiveDate",0,"DateTime",0))
 S EFFDT=$$CONVDTTM^PSOERXA1(EFFDT),FDA(F,EIENS,6.3)=EFFDT
 S EXPDT=$G(@GL@("ExpirationDate",0,"Date",0))
 I EXPDT="" S EXPDT=$G(@GL@("ExpirationDate",0,"DateTime",0))
 S EXPDT=$$CONVDTTM^PSOERXA1(EXPDT),FDA(F,EIENS,6.2)=EXPDT
 S NOTE=$G(@GL@("Note",0)),FDA(F,EIENS,8)=NOTE
 ; Future enhancement - no place to store period end date as of now, add in the future if needed
 S PEDT=$G(@GL@("PeriodEnd",0,"Date",0))
 I PEDT="" S PEDT=$G(@GL@("PeriodEnd",0,"DateTime",0))
 S PEDT=$$CONVDTTM^PSOERXA1(PEDT),FDA(F,EIENS,6.4)=PEDT
 S WRITDT=$G(@GL@("WrittenDate",0,"Date",0))
 I WRITDT="" S WRITDT=$G(@GL@("WrittenDate",0,"DateTime",0))
 S WRITDT=$$CONVDTTM^PSOERXA1(WRITDT),FDA(F,EIENS,5.9)=WRITDT
 ;DoNotFill Indicator
 S DONOTFIL=$G(@GL@("DoNotFill",0)) I $G(DONOTFIL)'="" S FDA(F,EIENS,10.5)=$S(DONOTFIL="Y":1,DONOTFIL="E":2,DONOTFIL="H":3,1:"")
 ; dispense notes
 S SUBS=$G(@GL@("Substitutions",0)),FDA(F,EIENS,5.8)=SUBS
 ; Future enhancement - store stop indicator
 ;S STOPIND=$G(@GL@("Stop",0,"StopIndicator",0)),FDA(F,EIENS,12.7)=STOPIND
 ; prior authorization
 S PAUTHQ=$G(@GL@("PriorAuthorization",0,"Qualifier",0)),PAUTHQ=$$PRESOLV^PSOERXA1(PAUTHQ,"PAV"),FDA(F,EIENS,10.3)=PAUTHQ
 S PAUTHV=$G(@GL@("PriorAuthorization",0,"Value",0)),FDA(F,EIENS,10.2)=PAUTHV
 S PAUTHS=$G(@GL@("PriorAuthorizationStatus",0)),FDA(F,EIENS,10.4)=PAUTHS
 ; quantity
 S QCLQ=$G(@GL@("Quantity",0,"CodeListQualifier",0)),FDA(F,EIENS,5.2)=QCLQ
 S QPUC=$G(@GL@("Quantity",0,"PotencyUnitCode",0)),FDA(F,EIENS,5.4)=QPUC
 S QUSC=$G(@GL@("Quantity",0,"UnitSourceCode",0)),FDA(F,EIENS,5.3)=QUSC
 S QTY=$G(@GL@("Quantity",0,"Value",0)),FDA(F,EIENS,5.1)=QTY
 ; future consideration:
 ; need to look into quantity multiplier on the VA side of things. It looks like the 
 ; ncpdp quantity multiplier is for billing purposes only.
 I $L($P(QTY,".",2))<3 S FDA(F,EIENS,20.1)=QTY
 ; refills
 S REFQUAL=$G(@GL@("Refills",0,"Qualifier",0)),FDA(F,EIENS,5.7)=REFQUAL
 S REFILLS=$G(@GL@("Refills",0,"Value",0))
 S FDA(F,EIENS,5.6)=REFILLS
 ; ensure vista refills can be exacly what is passed in, as long as it is not greater than 11
 I REFILLS<12 S FDA(F,EIENS,20.5)=REFILLS
 S FDA(F,EIENS,20.4)="M"
 S FDA(F,EIENS,41)=$P($G(ERXVALS("FormCode")),U,2)
 S FDA(F,EIENS,42)=$P($G(ERXVALS("PotencyUnitCode")),U,2)
 S FDA(F,EIENS,43)=$P($G(ERXVALS("StrengthCode")),U,2)
 ; file what we currently have
 D FILE^DIE(,"FDA") K FDA
 ; diagnosis - primary and secondary
 N DIAGCNT,STORCODE,DIAFDA
 S DIAGCNT=0
 S DIAG=-1 F  S DIAG=$O(@GL@("Diagnosis",DIAG)) Q:DIAG=""  D
 .S DIAGCNT=DIAGCNT+1
 .S DIENS="+"_DIAGCNT_","_EIENS
 .S CIQUAL=$G(@GL@("Diagnosis",DIAG,"ClinicalInformationQualifier",0))
 .S PQUAL=$G(@GL@("Diagnosis",DIAG,"Primary",0,"Qualifier",0))
 .S PDIAG=$G(@GL@("Diagnosis",DIAG,"Primary",0,"Value",0))
 .S SQUAL=$G(@GL@("Diagnosis",DIAG,"Secondary",0,"Qualifier",0))
 .S SDIAG=$G(@GL@("Diagnosis",DIAG,"Secondary",0,"Value",0))
 .S DIAFDA(52.499,"+1,"_EIENS,.01)=DIAGCNT,DIAFDA(52.499,"+1,"_EIENS,.02)=CIQUAL
 .S DIAFDA(52.499,"+1,"_EIENS,.03)=PQUAL,DIAFDA(52.499,"+1,"_EIENS,.04)=PDIAG
 .S DIAFDA(52.499,"+1,"_EIENS,.05)=SQUAL,DIAFDA(52.499,"+1,"_EIENS,.06)=SDIAG
 .D UPDATE^DIE(,"DIAFDA") K DIAFDA
 ; drug coverage status codes
 S DCCNT=0
 S DCSTAT=-1 F  S DCSTAT=$O(@GL@("DrugCoverageStatusCode",DCSTAT)) Q:DCSTAT=""  D
 .S DCSCODE=$G(@GL@("DrugCoverageStatusCode",DCSTAT))
 .S STORCODE=$$PRESOLV^PSOERXA1(DCSCODE,"DCS") Q:'$L(STORCODE)
 .S DCCNT=DCCNT+1
 .S DCFDA(52.4928,"+1,"_EIENS,.01)=DCCNT
 .S DCFDA(52.4928,"+1,"_EIENS,.02)=STORCODE D UPDATE^DIE(,"DCFDA") K DCFDA
 ; if the service reason code (.01) be the same value more than once, convert the .01 field to a sequence
 S DUE=-1 F  S DUE=$O(@GL@("DrugUseEvaluation",DUE)) Q:DUE=""  D
 .S CAID=$G(@GL@("DrugUseEvaluation",DUE,"CoAgent",0,"CoAgentID",0)),DUEFDA(52.4916,"+1,"_EIENS,.04)=CAID
 .S CAQUAL=$G(@GL@("DrugUseEvaluation",DUE,"CoAgent",0,"CoAgentQualifier",0)),CAQUAL=$$PRESOLV^PSOERXA1(CAQUAL,"CAQ"),DUEFDA(52.4916,"+1,"_EIENS,.05)=CAQUAL
 .S PSC=$G(@GL@("DrugUseEvaluation",DUE,"ProfessionalServiceCode",0)),PSC=$$PRESOLV^PSOERXA1(PSC,"PSC"),DUEFDA(52.4916,"+1,"_EIENS,.02)=PSC
 .S SREACODE=$G(@GL@("DrugUseEvaluation",DUE,"ServiceReasonCode",0)),SREACODE=$$PRESOLV^PSOERXA1(SREACODE,"REA"),DUEFDA(52.4916,"+1,"_EIENS,.01)=SREACODE
 .S SRESCODE=$G(@GL@("DrugUseEvaluation",DUE,"ServiceResultCode",0)),SRESCODE=$$PRESOLV^PSOERXA1(SRESCODE,"RES"),DUEFDA(52.4916,"+1,"_EIENS,.03)=SRESCODE
 .S CLINSIG=$G(@GL@("DrugUseEvaluation",DUE,"ClinicalSignificanceCode",0)),DUEFDA(52.4916,"+1,"_EIENS,.06)=CLINSIG
 .S ACKREA=$G(@GL@("DrugUseEvaluation",DUE,"AcknowledgementReason",0)),DUEFDA(52.4916,"+1,"_EIENS,1)=ACKREA
 .D UPDATE^DIE(,"DUEFDA") K DUEFDA
 D SS^PSOERXA4(EIENS)
 Q
