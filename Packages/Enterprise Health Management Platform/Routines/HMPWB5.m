HMPWB5 ;JD/CNP - Write back entry points for Notes, and Encounters;Jul 8, 2015@08:31:16
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
ENC(RSLT,IEN,DFN,DATA) ; Encounters
 ;
 ;RPC: HMP WRITEBACK ENCOUNTERS
 ;Output
 ; RSLT = JSON format string for encounters
 ;Input
 ; IEN  = record to be updated
 ; DFN  = patient IEN
 ; DATA(0) - input format - string - Main delimiter is "^"; Subdelimiter is ";"
 ;   Piece 1: DFN - Patient IEN
 ;   Piece 2: Inpatient flag - 1 = inpatient, 0 = otherwise
 ;   Piece 3: Hospital location IEN
 ;   Piece 4: Visit/episode date
 ;   Piece 5: Service category
 ;   Piece 6: Author/dictator IEN (i.e. Provider)
 ;   Piece 7: Encounter type - A 2- or 3-character string as follows:
 ;               CPT for CPT (^AUPNVCPT; #9000010.18)
 ;               HF      Health Factor (^AUPNVHF; #9000010.23)
 ;               IMM     Immunization (^AUPNVIMM; #9000010.11)
 ;               PED     Patient Education (^AUPNVPED; #9000010.16)
 ;               POV     POV - Purpose of Visit; a.k.a Diagnosis - (^AUPNVPOV; #9000010.07)
 ;               SK      Skin (^AUPNVSK; #9000010.12)
 ;               XAM     Exam (^AUPNVXAM; #9000010.13)
 ; DATA(n) - Encounter data - Main delimiter is "^"; Subdelimeter is ";"
 ;  n is an integer>0.  Encounter data varies with the type of encounter (piece 7 above)
 ;  as follows:
 ;   CPT: CPT code^Modifier1 code;Modifier2 code;...^Quantity^Provider name^Comment
 ;    HF: Health factor name^Level/severity code^Comment
 ;   IMM: ***N/A***  Immunization RPC will be invoked
 ;   PED: Education name^Level of understanding code^Comment
 ;   POV: Diag. code^Search term^EXACT "problem list items" text^Add to problem list^Comment
 ;    SK: Skin test name^Result code^Reading^Comment
 ;   XAM: Exam name^Result code^Comment
 ;
 N ENC,ENCNM,ENCTL,ENCTYP,ENCGLB,ERR,GLB,HMP,HMPA,HMPFCNT,HMPE,HMPTMP
 N HMPUID,INFO,NOTE,NOTEIEN,OK,ORLOC,PCELIST,PRVNM,STMPTM,VISIT,X,Y,X0,X1,X2
 S U="^",HMPTMP="HMPENC",ERR="",IEN=$G(IEN)
 I '$G(DFN) D MSG("DFN",1) Q  ; DFN is required
 ;S INFO=$G(DATA(0))  ;1
 S INFO=$G(DATA)     ;2
 ;Check for required fields
 ; DFN
 S HMP="DFN"
 I '$P(INFO,U) D MSG(HMP,1) Q
 I $D(^DPT($P(INFO,U)))'>0 D MSG(HMP,2,$P(INFO,U)) Q
 ; Location
 S HMP="Location IEN"
 I '$P(INFO,U,3) D MSG(HMP,1) Q
 I $D(^SC($P(INFO,U,3)))'>0 D MSG(HMP,2,$P(INFO,U,3)) Q
 ; Visit Date
 I '$P(INFO,U,4) D MSG("Visit Date",1) Q
 ;;Service Category
 I $L($P(INFO,U,5))=0 D MSG("Service category",1) Q
 ; Encouter Type
 I $L($P(INFO,U,7))=0 D MSG("Encounter type",1) Q
 ;
 ;If the encounter is immunization then call the immunization RPC.
 I $P(INFO,U,7)="IMM" D  Q
 .;S DATA=DATA(0)_U_DATA(1)  ;1
 .D IMMUN^HMPWBIM1(.RSLT,IEN,DFN,.DATA)
 ;
 S DFN=$P(INFO,U),OK="",NOTEIEN=0,ORLOC=$P(INFO,U,3)
 S ENCTYP=$$UP^XLFSTR($P(INFO,U,7))
 S ENCGLB=$S(ENCTYP="CPT":"^ICPT",ENCTYP="POV":"^ICD9",1:"MORE")
 I ENCGLB="MORE" S ENCGLB=$S(ENCTYP="PED":"^AUTTEDT",ENCTYP="XAM":"^AUTTEXAM",1:"MORE")
 I ENCGLB="MORE" S ENCGLB="^AUTT"_ENCTYP
 I $D(@ENCGLB)'>0 D MSG("Encounter type",2,ENCTYP) Q  ; Invalid encounter type
 ;S ENCNM=$P($G(@ENCGLB@($P(INFO,U,8),0)),U)  ; Encounter name
 S PRVNM=$P($G(^VA(200,$P(INFO,U,6),0)),U)   ; Provider name
 ;Prepare the encounter array for the RPC
 S PCELIST(1)="HDR^"_$P(INFO,U,2)_"^^"_$P(INFO,U,3)_";"_$P(INFO,U,4)_";"_$P(INFO,U,5)
 S PCELIST(2)="VST^DT^"_$P(INFO,U,4)
 S PCELIST(3)="VST^PT^"_$P(INFO,U)
 S PCELIST(4)="VST^HL^"_$P(INFO,U,3)
 S PCELIST(5)="VST^VC^"_$P(INFO,U,5)
 S PCELIST(6)="PRV^"_$P(INFO,U,6)_"^^^"_PRVNM_"^1"
 S ERR=""
 S DATA(1)=$P(INFO,U,8,999)  ;2
 D PCELST^HMPWB5A(ENCTYP,.DATA,.PCELIST,.ERR)
 I $G(ERR)]"" D MSG(ERR) Q
 ;Invoke the already existing RPC (ORWPCE SAVE)
 ;D SAVE^ORWPCE(.OK,.PCELIST,NOTEIEN,ORLOC)
 D DQSAVE^ORWPCE1
 ;S VISIT=$O(^AUPNVSIT("B",$P(INFO,U,4),""))
 S HMP=""
 F  S HMP=$O(^AUPNVSIT("B",$P(INFO,U,4),HMP)) Q:HMP=""  Q:DFN=$P(^AUPNVSIT(HMP,0),"^",5)
 S VISIT=HMP
 I VISIT>0 D
 .K FILTER
 .S FILTER("noHead")=1
 .S FILTER("patientId")=DFN
 .S FILTER("domain")="visit"
 .S FILTER("id")=VISIT
 .D GET^HMPDJ(.HMP,.FILTER)
 .S NOTE=$O(^TIU(8925,"V",VISIT,""))
 .I NOTE>0 D
 ..K FILTER
 ..S FILTER("noHead")=1
 ..S FILTER("patientId")=DFN
 ..S FILTER("domain")="document"
 ..S FILTER("id")=OK
 ..D GET^HMPDJ(.HMP,.FILTER)
 .S GLB="^AUPNV"_ENCTYP
 .S ENC=$O(@GLB@("AD",VISIT,""))
 .I ENC>0 D
 ..; Get the full domain name so it matches the tags in HMPDJ0
 ..S ENCTL=$S(ENCTYP="CPT":"cpt",ENCTYP="HF":"factor",ENCTYP="IMM":"immuniza",1:"MORE")
 ..I ENCTL="MORE" S ENCTL=$S(ENCTYP="PED":"educatio",ENCTYP="POV":"pov",1:"MORE")
 ..I ENCTL="MORE" S ENCTL=$S(ENCTYP="SK":"skin",ENCTYP="XAM":"exam",1:"")
 ..K FILTER
 ..S FILTER("noHead")=1
 ..S FILTER("patientId")=DFN
 ..S FILTER("domain")=ENCTL
 ..S FILTER("id")=ENC
 ..D GET^HMPDJ(.HMP,.FILTER)
 ..;Build Metastamp and Syncstatus
 ..S HMPFCNT=$G(^TMP("HMPF",$J,"total"))
 ..S HMPUID=$$SETUID^HMPUTILS(ENCTL,DFN,ENC)
 ..S HMPE=$G(^TMP("HMP",$J,1,1))
 ..S STMPTM=$TR($P($P(HMPE,"stampTime",2),","),""":")
 ..D ADHOC^HMPUTIL2(ENCTL,HMPFCNT,DFN,HMPUID,STMPTM)
 ..K ^TMP(HMPTMP,$J)
 ..;=== Add a } to the end of data
 ..; Find the 'data' section in ^TMP("HMPF"
 ..S X0=0
 ..F  S X0=$O(^TMP("HMPF",$J,X0)) Q:X0'=+X0  D
 ...S X1=0
 ...F  S X1=$O(^TMP("HMPF",$J,X0,X1)) Q:X1'=+X1  D
 ....S X2=$G(^TMP("HMPF",$J,X0,X1))
 ....I X2[("""collection"""_":"_""""_ENCTL_"""") M ^TMP(HMPTMP,$J,X0)=^TMP("HMPF",$J,X0)
 ..; Add } to the end
 ..S X0=0
 ..F  S X0=$O(^TMP(HMPTMP,$J,X0)) Q:X0'=+X0  D
 ...S X1=$O(^TMP(HMPTMP,$J,X0,""),-1)
 ...S ^TMP(HMPTMP,$J,X0,X1)=^TMP(HMPTMP,$J,X0,X1)_"}"
 ..;===
 ..K RSLT
 ..S RSLT=$NA(^TMP(HMPTMP,$J))
 .I ENC'>0 D MSG("Encounter was not created")
 Q
 ;
MSG(M,Q,V) ;
 ;Create a message (M) in JSON format with a qualifier (Q)
 ; M - Message text
 ; Q - Qualifier:
 ;        1 - Required
 ;        2 - Invalid
 ; V - If Q=1, then V is ignored (or not passed in)
 ;     If Q=2, then V=<the invalid value>
 S M=$G(M),Q=$G(Q),V=$G(V)
 D MSG^HMPTOOLS(M,Q,V)  ; Returns RSLT(1)
 K ^TMP(HMPTMP,$J)
 M ^TMP(HMPTMP,$J)=RSLT(1)
 K RSLT
 S RSLT=$NA(^TMP(HMPTMP,$J))
 Q
