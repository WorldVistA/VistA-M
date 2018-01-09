PSOERXA3 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 Q
MED(ERXIEN,ERXVALS) ; medication prescribed
 N GL,VALDT,DAYS,CIQUAL,PQUAL,PDIAG,SQUAL,DIAG,SDIAG,DIRECT,DCSTAT,DCSCODE,DDESC,DUE,CAID,CAQUAL,PSC,SREACODE,SRESCODE
 N EFFDT,EXPDT,NOTE,PEDT,PAUTHQ,PAUTHV,PAUTHS,QCLQ,QPUC,QUSC,QTY,REFQUAL,REFILLS,WRITDT,SUBS,STOPIND,CLINSIG,ACKREA
 N F,EIENS,SFDA,FDA,DIENS,DCCNT,VALDATE,DCDBCOD,DCDBCODQ,DCDEASCH,DCFC,DCFSC,DCPCODE,DCPCQUAL,DCSTR,DCSTRC,DCSTSC
 I 'ERXIEN Q
 S EIENS=ERXIEN_","
 S F=52.49
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"MedicationPrescribed",0))
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
 S DCDEASCH=$G(@GL@("DrugCoded",0,"DEASchedule")),FDA(F,EIENS,4.9)=DCDEASCH
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
