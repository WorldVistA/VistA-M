HMPDJ04E ;SLC/MKB,ASMR/RRB - EDIS VISIT;6/25/12  16:11
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; EDP(230                       6275
 ;
 ; DE2818/RRB SQA findings changed top line from EDIS to EDIS VISITS
 Q
 ;
EDP1(ID) ; -- ED visit
 ;DE2818 modified to use FM calls to pull data from the EDP files
 N IENS,EDP,X0,FAC,VST,LOC,LOC0,X,I,ICD,FILE,FLDS,FLGS,ARR,ERR
 S IENS=$$FIND1^DIC(230,"","Q",ID,"V","") Q:IENS<1
 S IENS=IENS_",",FLGS="IE",ARR="EDP",ERR="EDPERR",FLDS=".01;3.5;3.6;3.7;3.8;3.3;.08;.09;1.1;.02;.14;3.2"
 D GETS^DIQ(230,IENS,FLDS,FLGS,ARR,ERR)
 S X0=$G(^AUPNVSIT(ID,0))
 ;.01 LOG ENTRY TIME
 ;.08 TIME IN
 ;.08 TIME OUT
 ;1.1 COMPLAINT
 ;.02 INSTITUTION
 ;.14 CLINIC
 ;#3.2) STATUS [2P:233.1]
 ;(#3.3) ACUITY [3P:233.1] ^ 
 ;(#3.4) LOC [4P:231.8] 
 ;(#3.5) MD ASSIGNED [5P:200]
 ;(#3.6) NURSE ASSIGNED [6P:200]
 ;(#3.7) RESIDENT ASSIGNED [7P:200] ^ 
 ;#3.8) COMMENT [8F]
 ;(#3.9) HELD LOC [9P:231.8] ^ 
 S VST("localId")=ID,VST("uid")=$$SETUID^HMPUTILS("visit",DFN,ID)
 S VST("dateTime")=$$JSONDT^HMPUTILS(+X0)
 S:$G(EDP(230,IENS,.08,"I"))'="" VST("stay","arrivalDateTime")=$$JSONDT^HMPUTILS($G(EDP(230,IENS,.08,"I")))
 S:$G(EDP(230,IENS,.09,"I"))'="" VST("stay","dischargeDateTime")=$$JSONDT^HMPUTILS($G(EDP(230,IENS,.09,"I")))
 S:$G(EDP(230,IENS,.02,"I"))'="" FAC=$G(EDP(230,IENS,.02,"I"))
 S:$G(EDP(230,IENS,.14,"I"))'="" LOC=$G(EDP(230,IENS,.14,"I")),LOC0=$S(LOC:$G(^SC(LOC,0)),1:"")
 S:FAC X=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC X=$$FAC^HMPD(LOC) D FACILITY^HMPUTILS(X,"VST")
 S VST("categoryCode")="urn:va:encounter-category:OV"
 S VST("categoryName")="Outpatient Visit"
 S VST("patientClassCode")="urn:va:patient-class:EMER"
 S VST("patientClassName")="Emergency"
 ;
 S X=$$CPT^HMPDJ04(ID) S:$G(X)'="" VST("typeName")=$P($$CPT^ICPTCOD(X),U,3)
 I 'X S VST("typeName")=$S(LOC:$P(LOC0,U)_" VISIT",1:"EMERGENCY")
 S X=$P(X0,U,8) S:X AMIS=$$AMIS^HMPDVSIT(X) I LOC D
 . I 'X S AMIS=$$AMIS^HMPDVSIT($P(LOC0,U,7))
 . S VST("locationUid")=$$SETUID^HMPUTILS("location",,+LOC)
 . S VST("locationName")=$P(LOC0,U)
 . S X=$$SERV^HMPDVSIT($P(LOC0,U,20)) Q:X=""
 . S:$L(X) VST("service")=X,VST("summary")="${"_VST("service")_"}:"_$P(LOC0,U)
 S:$G(AMIS) VST("stopCodeUid")="urn:va:stop-code:"_$P(AMIS,U),VST("stopCodeName")=$P(AMIS,U,2)
 ;
 S:$G(EDP(230,IENS,1.1,"E"))'="" VST("reasonName")=$G(EDP(230,IENS,1.1,"E"))
 S I=0 F  S I=$O(^EDP(230,+IENS,4,I)) Q:I<1  I $P($G(^(I,0)),U,3) D  ;primary Dx
 . S X=$G(^EDP(230,+IENS,4,I,0)),VST("reasonName")=$P(X,U) Q:'$P(X,U,2)
 . S ICD=$$ICD^HMPDVSIT($P(X,U,2)) Q:$L(ICD)'>1
 . S VST("reasonUid")=$$SETNCS^HMPUTILS("icd",$P(ICD,U)),VST("reasonName")=$P(ICD,U,2)
 ;
 ; provider(s)
 S I=0
 I $G(EDP(230,IENS,3.5,"I"))'="" S I=I+1 D PROV("VST",I,$G(EDP(230,IENS,3.5,"I")),"P",1) ;primary/MD
 I $G(EDP(230,IENS,3.6,"I"))'="" S I=I+1 D PROV("VST",I,$G(EDP(230,IENS,3.6,"I")),"P",1) ;nurse
 I $G(EDP(230,IENS,3.7,"I"))'="" S I=I+1 D PROV("VST",I,$G(EDP(230,IENS,3.7,"I")),"P",1) ;resident
 S:$G(EDP(230,IENS,3.8,"I"))'="" VST("comment")=$G(EDP(230,IENS,3.8,"I"))
 S:$G(EDP(230,IENS,3.3,"E")) VST("appointmentStatus")=$G(EDP(230,IENS,3.3,"E"))
 ;
 ; note(s)
 ; TIU^HMPDJ04A(ID,.VST)
 K ^TMP("PXKENC",$J,ID)
 S VST("lastUpdateTime")=$$EN^HMPSTMP("visit") ;RHL 20150102
 S VST("stampTime")=VST("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("visit",VST("uid"),VST("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("VST","visit")
 Q
 ;
PROV(ARR,I,IEN,ROLE,PRIM) ; -- add providers
 S @ARR@("providers",I,"providerUid")=$$SETUID^HMPUTILS("user",,+IEN)
 S @ARR@("providers",I,"providerName")=$$GET1^DIQ(200,(+IEN)_",",.01)  ;DE2818, ICR 10060
 S @ARR@("providers",I,"role")=ROLE
 S:$G(PRIM) @ARR@("providers",I,"primary")="true"
 Q
 ;
