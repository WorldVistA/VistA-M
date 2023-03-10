PSOERXA5 ;ALB/BWF - eRx Utilities/RPC's ; 1/20/2018 10:28am
 ;;7.0;OUTPATIENT PHARMACY;**508,581,631,617,651**;DEC 1997;Build 30
 ;
 Q
 ; ERXIEN - IEN to file 52.49
 ; MTYPE - message type from field .08 (message type) of file 52.49
MEDDISP(ERXIEN,MTYPE) ;
 N DRUG,DRUGIEN,QTY,CLQ,USC,PUC,DAYS,DIRECT,REFQ,REFILLS,WRITDT,LFDATE,EXDATE,EFDATE,F,IENS,GL
 N ERR,TYPE
 S F=52.4949
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"MedicationDispensed",0))
 Q:'$D(@GL)
 ; this will be enhanced in the future to accept another parameter and loop through medications requested for
 ; the rxChangeRequest message type.
 S DRUG=$G(@GL@("DrugDescription",0))
 S QTY=$G(@GL@("Quantity",0,"Value",0))
 S CLQ=$G(@GL@("Quantity",0,"CodeListQualifier",0))
 S USC=$G(@GL@("Quantity",0,"UnitSourceCode",0))
 S PUC=$G(@GL@("Quantity",0,"PotencyUnitCode",0))
 S DAYS=$G(@GL@("DaysSupply",0))
 S DIRECT=$G(@GL@("Directions",0))
 S REFQ=$G(@GL@("Refills",0,"Qualifier",0))
 S REFILLS=$G(@GL@("Refills",0,"Value",0))
 S WRITDT=$G(@GL@("WrittenDate","Date",0)),WRITDT=$$CONVDTTM^PSOERXA1(WRITDT)
 S LFDATE=$G(@GL@("LastFillDate",0,"Date",0)),LFDATE=$$CONVDTTM^PSOERXA1(LFDATE)
 S EXDATE=$G(@GL@("ExpirationDate",0,"Date",0)),EXDATE=$$CONVDTTM^PSOERXA1(EXDATE)
 S EFDATE=$G(@GL@("EffectiveDate",0,"Date",0)),EFDATE=$$CONVDTTM^PSOERXA1(EFDATE)
 ; type=D is for medication dispensed
 ; this could be enhanced to collect both dispensed and requested (set of codes)
 S TYPE="D"
 S IENS="+1,"_ERXIEN_","
 S FDA(F,IENS,.01)=DRUG
 S DRUGIEN=$$FIND1^DIC(50,,,DRUG,"B",,"ERR")
 ; D = DISPENSED, R = REQUESTED
 S FDA(F,IENS,.02)=TYPE
 S FDA(F,IENS,.03)=DRUGIEN
 S FDA(F,IENS,.04)=QTY
 S FDA(F,IENS,.05)=DAYS
 S FDA(F,IENS,.06)=REFILLS
 S FDA(F,IENS,.07)=REFQ
 S FDA(F,IENS,1)=DIRECT
 S FDA(F,IENS,2.1)=WRITDT
 S FDA(F,IENS,2.2)=LFDATE
 S FDA(F,IENS,2.3)=EXDATE
 S FDA(F,IENS,2.4)=EFDATE
 S FDA(F,IENS,2.5)=CLQ
 S FDA(F,IENS,2.6)=USC
 S FDA(F,IENS,2.7)=PUC
 D UPDATE^DIE(,"FDA") K FDA
 ; file the # of refills requested separately for ease of access
 S FDA(52.49,ERXIEN_",",51.2)=REFILLS D FILE^DIE(,"FDA") K FDA
 Q
REFRESP(ERXIEN,MTYPE) ;
 N GL,REFFDA,RESTYPE,REFNUM,RESNOTE,I,REACODE,IENS,FDA,RESTUP,RESNODE,RESTNODE,REFRES,REFREQ,DELTAS,PSOIEN,RXIEN,COMM
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Response",0))
 S RESTYPE=$O(@GL@("")),RESTUP=$$UP^XLFSTR(RESTYPE),RESTUP=$TR(RESTUP," ",""),RESTUP=$TR(RESTUP,",","")
 S RESTNODE=RESTYPE
 S REFNUM=$G(@GL@(RESTYPE,0,"ReferenceNumber",0))
 S RESTYPE=$S(RESTUP="APPROVED":"A",RESTUP="DENIED":"D",RESTUP="DENIEDNEWPRESCRIPTIONTOFOLLOW":"DNP",RESTUP="APPROVEDWITHCHANGES":"AWC",RESTUP="REPLACE":"R",1:"")
 S RESNODE=$S(RESTYPE="A":"ApprovalReason",RESTYPE="R":"Replace",1:"DenialReason")
 S RESNOTE=$S(RESTYPE="A"!(RESTYPE="AWC")!(RESTYPE="R")!(RESTYPE="DNP"):$G(@GL@(RESTNODE,0,"Note",0)),1:$G(@GL@(RESTNODE,0,"DenialReason",0)))
 S REFFDA(52.49,ERXIEN_",",52.3)=REFNUM
 S REFFDA(52.49,ERXIEN_",",52.1)=RESTYPE
 S REFFDA(52.49,ERXIEN_",",52.2)=RESNOTE
 D FILE^DIE(,"REFFDA") K REFFDA
 S I=-1 F  S I=$O(@GL@(RESTNODE,I)) Q:I=""  D
 .S REACODE=$G(@GL@(RESTNODE,0,"ReasonCode",I))
 .S REACODE=$$PRESOLV^PSOERXA1(REACODE,"CLQ") Q:'REACODE
 .S IENS="+1,"_ERXIEN_","
 .S REFFDA(52.4955,IENS,.01)=REACODE
 .D UPDATE^DIE(,"REFFDA") K REFFDA
 S REFRES=ERXIEN,REFREQ=$$GETREQ^PSOERXU2(ERXIEN)
 ; If a corresponding eRx was not found for the Response received, update the Response status to RXF and do not process further
 I 'REFREQ D  Q
 .S COMM="Response received was '"_$S(RESTYPE="A":"Approved",RESTYPE="D":"Denied",RESTYPE="DNP":"Denied, New Rx to Follow",RESTYPE="AWC":"Approved with Changes",RESTYPE="R":"Replace",1:$G(RESTUP))
 .D UPDSTAT^PSOERXU1(ERXIEN,"RXF",COMM_"' - No corresponding eRx Record found.") Q
 S RXIEN=$$GET1^DIQ(52.49,REFREQ,.13,"I")
 ; If the Rx has been renewed within the VA, update the Response status to RXF and do not process further.
 I RXIEN,$$VARENEW^PSOERXU6(RXIEN) D  Q
 .S COMM="Response received was '"_$S(RESTYPE="A":"Approved",RESTYPE="D":"Denied",RESTYPE="DNP":"Denied, New Rx to Follow",RESTYPE="AWC":"Approved with Changes",RESTYPE="R":"Replace",1:$G(RESTUP))
 .D UPDSTAT^PSOERXU1(ERXIEN,"RXF",COMM_"' - Unable to process - eRx already Renewed via Backdoor Pharmacy.") Q
 ; auto-dc original prescription if this is a denied, new rx to follow
 I RESTYPE="DNP"!(RESTYPE="R") D  Q
 .I RESTYPE="DNP",RXIEN D RXACT^PSOBPSU2(RXIEN,,"RxRenewal response from external provider - Denied, New prescription to follow.","O")
 .I RESTYPE="R",RXIEN D RXACT^PSOBPSU2(RXIEN,,"RxRenewal response from external provider - Replace.","O")
 .D AUTODC^PSOERXU3(ERXIEN)
 ; if the response type is approved, process the approval into OP.
 I RESTYPE="A" D  Q
 .D RXACT^PSOBPSU2(RXIEN,,"RxRenewal response from external provider - Approved.","O")
 .S PSOIEN=ERXIEN D SETUP^PSOERX1F
 S REFRES=ERXIEN,REFREQ=$$GETREQ^PSOERXU2(ERXIEN)
 I 'REFREQ!('REFRES) Q
 D RRDELTA^PSOERXU2(.DELTAS,REFREQ,REFRES)
 ; if the type is approved with changes, and the provider hasn't changed, auto-process the renewal
 I RESTYPE="AWC",'$D(DELTAS(52.49,"EXTERNAL PROVIDER")) D
 .D RXACT^PSOBPSU2(RXIEN,,"RxRenewal response from external provider - Approved with changes.","O")
 .S PSOIEN=ERXIEN D SETUP^PSOERX1F
 I RESTYPE="AWC",$D(DELTAS(52.49,"EXTERNAL PROVIDER")) D
 .D RXACT^PSOBPSU2(RXIEN,,"RxRenewal response from external provider - Approved with provider changes.","O")
 I RESTYPE="D" D UPDSTAT^PSOERXU1(ERXIEN,"RXD"),RXACT^PSOBPSU2(RXIEN,,"RxRenewal response from external provider - Denied.","O")
 Q
 ; ERXIEN - IEN from 52.49
 ; MTYPE - message type (field .08)
 ; DNB - denied by hub flag
 ; VAINST - institution
CANRX(ERXIEN,MTYPE,DNB,VAINST) ;
 N GL,RELIEN,NODE,ERXIENS,CRTYPE,RETREC,REQREF,CHANGEST,RELIEN,IMTYPE,PSSRET,NRXIEN,NRXSTAT,RXIEN,PENDIEN,ORESP,MES
 S ERXIENS=ERXIEN_","
 S IMTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S NODE=$S(MTYPE="CancelRx":"Request",MTYPE="CancelRxResponse":"Response",1:"") Q:NODE=""
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,NODE,0))
 S CRTYPE=$G(@GL@("ChangeRequestType",0))
 S RETREC=$G(@GL@("ReturnReceipt",0))
 S REQREF=$G(@GL@("RequestReferenceNumber",0))
 S CHANGEST=$G(@GL@("ChangeofPrescriptionStatusFlag",0))
 D CANFIL(ERXIENS,CRTYPE,RETREC,REQREF,CHANGEST)
 I IMTYPE="CA" S NRXIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I IMTYPE="CN" S RELIEN=$$GETREQ^PSOERXU2(ERXIEN),NRXIEN=$$RESOLV^PSOERXU2(RELIEN)
 ; if we cannot find the related message, update status, and quit
 I IMTYPE="CA",'$G(NRXIEN) D  Q
 . D UPDSTAT^PSOERXU1(ERXIEN,"CAP")
 Q:'$G(NRXIEN)
 ; Validates if the order is an eRx and Log Activity in AL eRx
 S MES=$S(IMTYPE="CA":"Canceled by external provider (eRx)",IMTYPE="CN":"Cancel Response to external provider (eRx)")
 S RXIEN=$$GET1^DIQ(52.49,NRXIEN,.13,"I")
 I RXIEN D RXACT^PSOBPSU2(RXIEN,,MES,"O")
 S NRXSTAT=$$GET1^DIQ(52.49,NRXIEN,1,"E")
 ;generate automated cancel response on rejected and new status eRxs in the holding queue
 I ",RJ,N,"[NRXSTAT D  Q
 .I NRXSTAT="RJ" D
 ..S ORESP="Rx was never dispensed. Rejected at Pharmacy"
 ..D POST^PSOERXO1(ERXIEN,.PSSRET,,,,3,VAINST,ORESP)
 .I NRXSTAT'="RJ" D POST^PSOERXO1(ERXIEN,.PSSRET,,,,3,VAINST)
  .; if there was an error, quit. we do not want to override the CAX status
 .I $D(PSSRET("errorMessage")) D UPDSTAT^PSOERXU1(NRXIEN,"CAN") Q
 .D UPDSTAT^PSOERXU1(NRXIEN,"CAN")
 .D UPDSTAT^PSOERXU1(ERXIEN,"CAO")
 ;generate automated cancel response on processed eRx's
 I NRXSTAT="PR" D  Q
 .D CANDC^PSOERXU6(ERXIEN,VAINST,.PSSRET)
 ; Do we not build a response for the other canceled items?
 D UPDSTAT^PSOERXU1(ERXIEN,"CAH")
 D UPDSTAT^PSOERXU1(NRXIEN,"CAN")
 Q
CANFIL(ERXIENS,CRTYPE,RETREC,REQREF,CHANGEST,STATUS,DNB) ;
 N FDA
 S FDA(52.49,ERXIENS,80.1)=CRTYPE
 S FDA(52.49,ERXIENS,80.2)=RETREC
 S FDA(52.49,ERXIENS,80.3)=REQREF
 S FDA(52.49,ERXIENS,80.4)=CHANGEST
 S FDA(52.49,ERXIENS,80.5)=$G(DNB)
 I $L($G(STATUS)) S FDA(52.49,ERXIENS,1)=$$PRESOLV^PSOERXA1(STATUS,"ERX")
 D FILE^DIE(,"FDA") K FDA
 Q
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
 .S PNAME=$G(@GL@(BFCCNT,"PayerName",0))
 .S IENS="+1,"_ERXIEN_","
 .S FDA(F,IENS,.01)=BSEQ,FDA(F,IENS,7)=CHID,FDA(F,IENS,.02)=GRPID,FDA(F,IENS,.03)=PNAME
 .S FDA(F,IENS,1)=CHLN,FDA(F,IENS,2)=CHFN,FDA(F,IENS,3)=CHMN,FDA(F,IENS,4)=CHSUFF,FDA(F,IENS,5)=CHPRE
 .K NEWPAYER
 .D UPDATE^DIE(,"FDA","NEWPAYER") K FDA
 .S PIEN=$O(NEWPAYER(0)),PIEN=$G(NEWPAYER(PIEN)) Q:'PIEN
 .S PIDCNT=-1 F  S PIDCNT=$O(@GL@(BFCCNT,"PayerIdentification",PIDCNT)) Q:PIDCNT=""  D
 ..S PIDTYP="" F  S PIDTYP=$O(@GL@(BFCCNT,"PayerIdentification",PIDCNT,PIDTYP)) Q:PIDTYP=""  D
 ...S PIDVAL=$G(@GL@(BFCCNT,"PayerIdentification",PIDCNT,PIDTYP,0))
 ...S FDA(52.49186,"+1,"_PIEN_","_ERXIEN_",",.01)=PIDTYP
 ...S FDA(52.49186,"+1,"_PIEN_","_ERXIEN_",",.02)=PIDVAL
 ...D UPDATE^DIE(,"FDA") K FDA
 .K NEWPAYER,PIEN
 Q
