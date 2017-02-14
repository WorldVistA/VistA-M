HMPWBIM1 ;;OB/JD/CNP - Write back entry points for IMMUNIZATIONS (related to Notes, and Encounters);Sep 2, 2015@08:31:16
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
IMMUN(RSLT,IEN,DFN,DATA)   ; Immunization
 ;
 ;RPC: HMP WRITEBACK IMMUNIZATION
 ;Output
 ; RSLT = JSON format string for Immunization
 ;Input
 ; IEN  = record to be updated
 ; DFN  = patient IEN
 ; DATA - input format - string
 ;   Piece 1: DFN - Patient IEN
 ;   Piece 2: Inpatient flag - 1 = inpatient, 0 = otherwise
 ;   Piece 3: Hospital location IEN
 ;   Piece 4: Visit/episode date
 ;   Piece 5: Service category
 ;   Piece 6: Author/dictator IEN (i.e. Provider)
 ;   Piece 7: (IMM)unization/Encounter type - A 2- or 3-character string as follows:
 ;               CPT for CPT (^AUPNVCPT; #9000010.18)
 ;               HF      Health Factor (^AUPNVHF; #9000010.23)
 ;               IMM     Immunization (^AUPNVIMM; #9000010.11)
 ;               PED     Patient Education (^AUPNVPED; #9000010.16)
 ;               POV     POV - Purpose of Visit; a.k.a Diagnosis - (^AUPNVPOV; #9000010.07)
 ;               SK      Skin (^AUPNVSK; #9000010.12)
 ;               XAM     Exam (^AUPNVXAM; #9000010.13)
 ;   Piece 8: (IMM)unization/Encounter ID - As follows:
 ;               CPT     ^ICPT
 ;               HF      ^AUTTHF
 ;               IMM     ^AUTTIMM
 ;               PED     ^AUTTEDT
 ;               POV     ^ICD9
 ;               SK      ^AUTTSK
 ;               XAM     ^AUTTEXAM
 ;   Piece 9: Immunization /Encounter result CODE
 ;  Piece 10: Immunization /Encounter comment number
 ;  Piece 11: Immunization /Encounter comment text
 ;  Piece 12: Reaction
 ;  Piece 13: Repeat ContraIndicated
 ;
 N ERRMSG,JSONERR
 I '$G(DFN) D MSG^HMPTOOLS("DFN",1) D ERR(.RSLT) Q  ; DFN is required
 N ADMNDATE,ENC,ENCNM,ENCNUM,ENCTL,ENCTYP,ENCGLB,ERROR,GLB,HMP,HMPA,HMPFCNT,HMPE
 N HMPUID,INFO,LOCALID,LOCALIEN,NOTE,NOTEIEN,OK,ORLOC,PCELIST,PRVNM,STMPTM
 S INFO=$G(DATA)
 ;
 ;Check for required fields
 ;
 I '$P(INFO,U) D MSG^HMPTOOLS("DFN",1) D ERR(.RSLT) Q  ; DFN is required
 I $D(^DPT($P(INFO,U)))'>0 D MSG^HMPTOOLS("DFN",2,$P(INFO,U)) D ERR(.RSLT) Q  ; Invalid DFN
 I '$P(INFO,U,3) D MSG^HMPTOOLS("Location",1) D ERR(.RSLT) Q  ; Location is required
 I '$P(INFO,U,4) D MSG^HMPTOOLS("Visit",1) D ERR(.RSLT) Q  ; Visit is required
 I $L($P(INFO,U,5))=0 D MSG^HMPTOOLS("Service category",1) D ERR(.RSLT) Q  ; Service category is required
 I $L($P(INFO,U,7))=0 D MSG^HMPTOOLS("Immunization Encounter type",1) D ERR(.RSLT) Q  ; Immunization /Encounter type is required
 ;
 S DFN=$P(INFO,U),OK="",NOTEIEN=0,ORLOC=$P(INFO,U,3)
 S ENCTYP=$$UP^XLFSTR($P(INFO,U,7))
 S ENCNUM=$P(INFO,U,8)  ; Immunization Code (Number)
 S ENCGLB=$S(ENCTYP="CPT":"^ICPT",ENCTYP="POV":"^ICD9",1:"MORE")
 I ENCGLB="MORE" S ENCGLB=$S(ENCTYP="PED":"^AUTTEDT",ENCTYP="XAM":"^AUTTEXAM",1:"MORE")
 I ENCGLB="MORE" S ENCGLB="^AUTT"_ENCTYP
 I $D(@ENCGLB)'>0 D MSG^HMPTOOLS("Immunization Encounter typ",2,ENCTYP) D ERR(.RSLT) Q  ; Invalid Immunization /encounter type
 S ENCNM=$P($G(@ENCGLB@($P(INFO,U,8),0)),U)  ; Immunization /Encounter name
 S PRVNM=$P($G(^VA(200,$P(INFO,U,6),0)),U)   ; Provider name
 ;
 ;Prepare the Immunization /encounter array for the RPC
 ;
 S PCELIST(1)="HDR^"_$P(INFO,U,2)_"^^"_$P(INFO,U,3)_";"_(+$P(INFO,U,4))_";"_$P(INFO,U,5)
 S PCELIST(2)="VST^DT^"_(+$P(INFO,U,4))
 S PCELIST(3)="VST^PT^"_$P(INFO,U)
 S PCELIST(4)="VST^HL^"_$P(INFO,U,3)
 S PCELIST(5)="VST^VC^"_$P(INFO,U,5)
 S PCELIST(6)="PRV^"_$P(INFO,U,6)_"^^^"_PRVNM_"^1"
 S PCELIST(7)=ENCTYP_"+^"_$P(INFO,U,8)_"^^"_ENCNM_U_$P(INFO,U,9)_U_$P(INFO,U,6)_U_$P(INFO,U,12)_U_$P(INFO,U,13)_"^0^"
 S PCELIST(7)=PCELIST(7)_$P(INFO,U,10)
 S PCELIST(8)="COM^"_$P(INFO,U,10)_U_$S($P(INFO,U,11)]"":$P(INFO,U,11),1:"@")
 ;
 ;Invoke the already existing RPC (ORWPCE1 DQSAVE)
 ;
 ; Wrap for ORWPCE1 DQSAVE
 ; Description:  This RPC saves immunizations
 ;
 ; Input:   Parameters are as noted above for this routine, IMMUN^HMPWBIM1.
 ;
 ; Output:  Immunization parameters for the DQSAVE^ORWPCE1 Broker Call
 ;
 ;          DFN^IEN^HospitalLocation^VisitDate^Service category^Provider^ImmunizationType^IMM^ImmunizationResultCODE^ImmunizationCommentNumber^ImmunizationCommentText
 ;          Note: IMM     Immunization (^AUPNVIMM; #9000010.11) and ^AUTTIMM
 ;
 ; Check for duplicates and send a JSON error message if a duplicate IMMUNIZATION is found
 S ADMNDATE=+$P(INFO,U,4)
 S ERROR=0
 S LOCALID="" F  S LOCALID=$O(^AUPNVSIT("B",ADMNDATE,LOCALID)) Q:LOCALID=""  D
 .S LOCALIEN="" F  S LOCALIEN=$O(^AUPNVIMM("AD",LOCALID,LOCALIEN)) Q:LOCALIEN=""  I $D(^AUPNVIMM(LOCALIEN,0)) I $P(^AUPNVIMM(LOCALIEN,0),"^")=ENCNUM I $P(^AUPNVIMM(LOCALIEN,0),"^",2)=DFN S ERROR=1
 I ERROR D MSG^HMPTOOLS("Entry: Immunization already exist for the specified Date and Time for ",2,$P(INFO,U)) D ERR(.RSLT) Q  ;
 ;
 ; Save/Write IMMUNIZATION to VistA
 D DQSAVE^ORWPCE1
 ;
 ; Match DFN with the VISIT
 S (VISIT,LOCALID)="" F  S LOCALID=$O(^AUPNVSIT("B",ADMNDATE,LOCALID)) Q:LOCALID=""  D
 .S VISIT=LOCALID S LOCALIEN="" F  S LOCALIEN=$O(^AUPNVIMM("AD",LOCALID,LOCALIEN)) Q:LOCALIEN=""  I $D(^AUPNVIMM(LOCALIEN,0)) I $P(^AUPNVIMM(LOCALIEN,0),"^")=ENCNUM Q:$P(^AUPNVIMM(LOCALIEN,0),"^",2)=DFN
 I VISIT>0 D
 .K FILTER
 .S FILTER("noHead")=1
 .S FILTER("patientId")=DFN
 .S FILTER("domain")="visit"
 .S FILTER("id")=VISIT
 .D GET^HMPDJ(.HMP,.FILTER)   ; Return JSON visit Data
 .S NOTE=$O(^TIU(8925,"V",VISIT,""))
 .I NOTE>0 D
 ..K FILTER
 ..S FILTER("noHead")=1
 ..S FILTER("patientId")=DFN
 ..S FILTER("domain")="document"
 ..S FILTER("id")=OK   ; Return JSON document Data
 ..D GET^HMPDJ(.HMP,.FILTER)
 .S GLB="^AUPNV"_ENCTYP
 .S ENC=LOCALIEN  ;S ENC=$O(@GLB@("AD",VISIT,""))  ; replaced the code with LOCALIEN variable
 .I ENC>0 D   ; Get the full domain name so it matches the tags in HMPDJ0
 ..S ENCTL=$S(ENCTYP="CPT":"cpt",ENCTYP="HF":"factor",ENCTYP="IMM":"immuniza",1:"MORE")
 ..I ENCTL="MORE" S ENCTL=$S(ENCTYP="PED":"educatio",ENCTYP="POV":"pov",1:"MORE")
 ..I ENCTL="MORE" S ENCTL=$S(ENCTYP="SK":"skin",ENCTYP="XAM":"exam",1:"")
 ..K FILTER
 ..S FILTER("noHead")=1
 ..S FILTER("patientId")=DFN
 ..S FILTER("domain")=ENCTL
 ..S FILTER("id")=ENC
 ..D GET^HMPDJ(.HMP,.FILTER)   ; Return JSON Immunization Data
 ..;; renmove this ;; line
 ..S HMPFCNT=0
 ..S HMPUID=$$SETUID^HMPUTILS(ENCTL,DFN,ENC)   ; Build Metastamp and Syncstatus
 ..S HMPE=$G(^TMP("HMP",$J,1,1))
 ..S STMPTM=$TR($P($P(HMPE,"stampTime",2),","),""":")
 ..D ADHOC^HMPUTIL2(ENCTL,HMPFCNT,DFN,HMPUID,STMPTM)   ; Removed METASTAMP and SYNCSTART /SYNCSTOP
 ..S RSLT=$$EXTRACT(HMP)
 ..K ^TMP("HMPIMM",$J)
 ..M ^TMP("HMPIMM",$J)=RSLT
 ..;M ^TMP("HMPIMM",$J)=^TMP("HMP",$J)
 ..K ^TMP("HMPIMM",$J,"total")   ;Stored JSON in HMP WRTIEBACK IMMUNIZATION temporary global for the job/user
 ..K RSLT
 ..S RSLT=$NA(^TMP("HMPIMM",$J))   ;Stored location of top level of HMP WRITEBACK JSON in Result variable
 Q
 ;
EXTRACT(GLOB) ; Move ^TMP("HMP",$J) into string format
 N HMPSTOP,HMPFND,NULLCHK
 S RSLT="",X=0,HMPSTOP=0,HMPFND=0
 S (I,J)=0
 F  S I=$O(^TMP("HMPF",$J,I)) Q:I=""!(HMPSTOP)  D
 . F  S J=$O(^TMP("HMPF",$J,I,J)) Q:J=""  D
 .. I $G(^TMP("HMPF",$J,I,J))["syncStatus" D
 ... Q:$P(^TMP("HMPF",$J,I,J),":",1)["domainTotals"
 ... S RSLT(X)=RSLT(X)_$P(^TMP("HMPF",$J,I,J),",",1)
 ... S HMPSTOP=1
 ... Q
 .. Q:$D(^TMP("HMPF",$J))=""
 .. Q:$G(^TMP("HMPF",$J,I,J))=""
 .. Q:$P(^TMP("HMPF",$J,I,J),",",1)'["immuniza"
 .. Q:$P(^TMP("HMPF",$J,I,J),",",4)'["localId"
 .. Q:$P(^TMP("HMPF",$J,I,J),":",1)["domainTotals"
 .. S X=X+1
 .. S RSLT(X)=$G(^TMP("HMPF",$J,I,J))
 .. F  S J=$O(^TMP("HMPF",$J,I,J)) Q:J=""  D
 ... Q:$P(^TMP("HMPF",$J,I,J),":",1)["domainTotals"
 ... S X=X+1
 ... S RSLT(X)=$G(^TMP("HMPF",$J,I,J))
 ... S HMPFND=1
 ... Q
 .. S I=$O(^TMP("HMPF",$J,I))
 .. Q
 . Q
 Q RSLT
ERR(RSLT) ; Display Error
 K ^TMP("HMPIMM",$J)
 M ^TMP("HMPIMM",$J)=RSLT
 K ^TMP("HMPIMM",$J,"total")   ;Stored JSON in HMP WRTIEBACK IMMUNIZATION temporary global for the job/user
 K RSLT
 S RSLT=$NA(^TMP("HMPIMM",$J))   ;Stored location of top level of HMP WRITEBACK JSON in Result variable
 Q
 ;
