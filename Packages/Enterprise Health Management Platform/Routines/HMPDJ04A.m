HMPDJ04A ;ASMR/MKB - Admissions,PTF;Nov 12, 2015 16:42:22
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DGPM                         1865
 ; ^DIC(42                      10039
 ; ^DPT                         10035
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DGPTFAPI                      3157
 ; DIC                           2051
 ; DILFD                         2055
 ; DIQ                           2056
 ; ICDCODE                       3990
 ; ICPTCOD                       1995
 ; VADPT                        10061
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
ADM(ID,DATE) ; -- admission [from VSIT1]
 N ADM,VADMVT,VAIP,VAERR,MVT,SPEC,HLOC,FAC,ICD,I
 S ID=$G(ID),DATE=+$G(DATE) Q:ID=""  ;Q:DATE<1
 I ID S VAIP("D")=DATE,VST=+ID
 I ID?1"H"1.N S VAIP("E")=+$E(ID,2,99),VST=0
 D IN5^VADPT Q:'$G(VAIP(1))  ;deleted
 S VADMVT=+$G(VAIP(13)),ID="H"_VADMVT
 S ADM("localId")=ID,ADM("uid")=$$SETUID^HMPUTILS("visit",DFN,ID)
 S:'DATE DATE=+$G(VAIP(13,1)) S:'VST VST=$$VISIT(DFN,DATE)
 S (ADM("dateTime"),ADM("stay","arrivalDateTime"))=$$JSONDT^HMPUTILS(DATE)
 S:$L($P(VAIP(6),U,2)) ADM("roomBed")=$P(VAIP(6),U,2)
 ;DE2818, (#.105) CURRENT ADMISSION, changed ^DPT to FileMan, ICR 10035
 S MVT=13,I=0 I VADMVT=$$GET1^DIQ(2,DFN_",",.105,"I") D  ;if current admission,
 . S ADM("current")="true",MVT=14  ; use last movement info
 . S X=$$GET1^DIQ(2,DFN_",",.101,"I") S:$L(X) ADM("roomBed")=X  ;(#.101) ROOM-BED, DE2818
 . K HMPADMIT  ;kill flag from HMPDJ0
 S SPEC=$G(VAIP(MVT,6)),ADM("specialty")=$P(SPEC,U,2)
 S X=$$SERV^HMPDVSIT(+SPEC),ADM("service")=X
 ;DE2818, changed from ^DIC(42) to FileMan, ICR 10039
 S HLOC=+$$GET1^DIQ(42,+$G(VAIP(MVT,4))_",",44,"I"),FAC=$$FAC^HMPD(+HLOC) I HLOC D
 . S ADM("locationUid")=$$SETUID^HMPUTILS("location",,+HLOC)
 . ;DE2818 begin, changed ^SC to FileMan, ICR 10040
 . S X=$$GET1^DIQ(44,HLOC_",",1) S:X]"" ADM("shortLocationName")=X  ;(#1) ABBREVIATION
 . S ADM("locationName")=$$GET1^DIQ(44,HLOC_",",.01)  ;(#.01) NAME
 . S X=$$AMIS^HMPDVSIT($$GET1^DIQ(44,HLOC_",",8,"I"))  ;(#8) STOP CODE NUMBER
 . ;DE2818, end
 . S:$L($G(X)) ADM("stopCodeUid")="urn:va:stop-code:"_$P(X,U),ADM("stopCodeName")=$P(X,U,2)
 . S ADM("summary")="${"_ADM("service")_"}:"_ADM("locationName")
 D FACILITY^HMPUTILS(FAC,"ADM")
 S ADM("categoryCode")="urn:va:encounter-category:AD",ADM("categoryName")="Admission"
 S ADM("patientClassCode")="urn:va:patient-class:IMP",ADM("patientClassName")="Inpatient"
 I $G(VAIP(17)) S ADM("stay","dischargeDateTime")=$$JSONDT^HMPUTILS(+$G(VAIP(17,1)))
 I $G(VAIP(18)) S I=I+1 D PROV("ADM",I,+VAIP(18),"A")         ;attending
 I $G(VAIP(MVT,5)) S I=I+1 D PROV("ADM",I,+VAIP(MVT,5),"P",1) ;primary
 S ICD=$$POV^HMPDJ04(VST) S:'ICD ICD=$$PTF^HMPDVSIT(DFN,VAIP(12)) ;PTF>ICD
 I $L(ICD)<2 S ADM("reasonName")=$G(VAIP(MVT,7))
 E  S ADM("reasonUid")=$$SETNCS^HMPUTILS("icd",ICD),ADM("reasonName")=$P(ICD,U,2)
 S X=$$CPT^HMPDJ04(VST),ADM("typeName")=$S(X:$P($$CPT^ICPTCOD(X),U,3),1:$$CATG^HMPDVSIT("H"))
 D MVT(VADMVT)   ;sub-movements
 ; TIU(VST,.ADM) ;notes/summary
 ; Next 2 lines added for visits whose IDs start with an "H".  JD - 1/26/15
 S ADM("lastUpdateTime")=$$EN^HMPSTMP("adm") ;RHL 20150102
 S ADM("stampTime")=ADM("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("visit",ADM("uid"),ADM("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("ADM","visit")
 Q
 ;
TIU(VISIT,ARR) ; -- add notes to ARR("document")
 N X,Y,I,HMPX,LT,NT,DA,CNT,HMPY
 D FIND^DIC(8925,,.01,"QX",+$G(VISIT),,"V",,,"HMPX")
 S Y="",(I,CNT)=0
 F  S I=$O(HMPX("DILIST",1,I)) Q:I<1  D
 . S LT=$G(HMPX("DILIST","ID",I,.01)) Q:$P(LT," ")="Addendum"
 . S DA=$G(HMPX("DILIST",2,I))
 . S NT=$$GET1^DIQ(8925,+DA_",",".01:1501")
 . S CNT=CNT+1,ARR("documents",CNT,"uid")=$$SETUID^HMPUTILS("document",DFN,+DA)
 . S ARR("documents",CNT,"localTitle")=LT
 . S:$L(NT) ARR("documents",CNT,"nationalTitle")=NT
 Q
 ;
PROV(ARR,I,IEN,ROLE,PRIM) ; -- add providers
 S @ARR@("providers",I,"providerUid")=$$SETUID^HMPUTILS("user",,+IEN)
 S @ARR@("providers",I,"providerName")=$$GET1^DIQ(200,IEN_",",.01)  ;DE2818, changed ^VA(200) to FileMan ICR 10060
 S @ARR@("providers",I,"role")=ROLE
 S:$G(PRIM) @ARR@("providers",I,"primary")="true"
 Q
 ;
MVT(CA) ; -- add movements to ADM("movement",i,"attribute")
 N DATE,DA,CNT,X S (DATE,CNT)=0
 ;DE2818, ^DGPM( - ICR 1865
 F  S DATE=$O(^DGPM("APCA",DFN,CA,DATE)) Q:DATE<1  S DA=+$O(^(DATE,0)) I DA'=CA D
 . S X0=$G(^DGPM(DA,0)),CNT=CNT+1
 . S ADM("movements",CNT,"localId")=DA
 . S ADM("movements",CNT,"dateTime")=$$JSONDT^HMPUTILS(DATE)
 . S ADM("movements",CNT,"movementType")=$$EXTERNAL^DILFD(405,.02,,$P(X0,U,2))
 . S X=+$P(X0,U,19) I X D
 .. S ADM("movements",CNT,"providerUid")=$$SETUID^HMPUTILS("user",,X)
 .. S ADM("movements",CNT,"providerName")=$$GET1^DIQ(200,X_",",.01)  ;DE2818, changed ^VA(200) to FileMan ICR 10060
 . S X=+$P(X0,U,9)
 . S:X ADM("movements",CNT,"specialty")=$$EXTERNAL^DILFD(405,.09,,X)
 . ;DE2818, changed ^DIC(42) to FileMan, ICR 10039
 . S HLOC=+$$GET1^DIQ(42,+$P(X0,U,6)_",",44,"I"),FAC=$$FAC^HMPD(HLOC) I HLOC D
 .. S ADM("movements",CNT,"locationUid")=$$SETUID^HMPUTILS("location",,HLOC)
 .. ;DE2818, changed ^SC to FileMan, ICR 10040
 .. S ADM("movements",CNT,"locationName")=$$GET1^DIQ(44,HLOC_",",.01)  ;(#.01) NAME
 Q
 ;
PTFA(HMPLID) ; -- find ID in ^PXRMINDX(45) and call PTF1 if successful
 ;Purpose - Build ^TMP("HMPPX") from ^PXRMINDX(45,HMPISYS,"PNI",DFN)
 ;
 ;Called by - PTF^HMPDJ0 (if HMPID is set)
 ;
 ;Assumptions -
 ;1. ID is being passed and DFN variable exists
 ;2. ^TMP("HMPPX") does not already exist
 ;
 ;              
 ;Modification History -
 ;US5630 (TW)  1. HMPISYS can be either "ICD" (ICD-9) or "10D" (ICD-10)
 ;             2. Namespaced variables and enhanced newing
 ; 
 N HMPLEN,HMPTYP,HMPID,HMPISYS,HMPTYP,HMPDX,HMPDT,HMPITEM,HMPRDT,HMPX
 S HMPLEN=$L(HMPLID,";"),HMPTYP=$P(HMPLID,";",HMPLEN),HMPID=$P(HMPLID,";",1,HMPLEN-1)
 ; DE2818, ^PXRMINDX - ICR 4290
 ;Get ICD System from ^PXRMINDX Xref and loop for remaining subscripts
 S HMPISYS="" F  S HMPISYS=$O(^PXRMINDX(45,HMPISYS)) Q:HMPISYS=""  D
 . I '$D(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP)) Q
 . S HMPDX="" F  S HMPDX=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX)) Q:HMPDX=""  D
 .. S HMPDT=0  F  S HMPDT=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX,HMPDT)) Q:HMPDT=""  D
 ... S HMPITEM=""  F  S HMPITEM=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX,HMPDT,HMPITEM)) Q:HMPITEM=""  D
 .... I HMPITEM'[HMPID Q
 .... S HMPRDT=9999999-HMPDT
 .... S HMPX=HMPDX_U_HMPDT_U_HMPISYS
 .... S ^TMP("HMPPX",$J,HMPRDT,HMPLID)=HMPX
 Q:'$D(^TMP("HMPPX",$J))
 D PTF1
 K ^TMP("HMPPX",$J)
 Q
 ;
PTF1 ; Set PTF data into PTF array
 ;Purpose - Get data from ^TMP("HMPPX"), lookup addl PTF, set into PTF array and ^TMP
 ;
 ;Called by - PTFA^HMPDJ04A if HMPID is set, otherwise PTF^HMPDJ0
 ;
 ;Assumptions -
 ;1. HMPLID (local ID) is being passed and DFN,HMPRDT variables exist
 ;2. ^TMP("HMPPX",$J,HMPRDT,ID)=DxCode^[Discharge]Date exists
 ;
 ;Modification History -
 ;US5630 (TW)- HMPISYS can be either "ICD9" or "10D" (ICD-10)
 ;
 N HMPTMP,PTF,HMPP,HMPTYP,HMPDIS,VAIN,HMPADM,VAINDT,HMPLOC,HMPFAC,HMPX,HMPISYS
 S HMPTMP=$G(^TMP("HMPPX",$J,HMPRDT,HMPLID))
 S PTF("localId")=HMPLID
 S PTF("uid")=$$SETUID^HMPUTILS("ptf",DFN,HMPLID)
 S HMPP=$L(HMPLID,";")
 S HMPTYP=$P(HMPLID,";",HMPP)
 I HMPTYP="DXLS" S PTF("principalDx")="true"  ; Is this the principal dx?
 I $P(HMPTYP," ")="M" Q  ; Quit if movement dx
 S HMPDIS=$P(HMPTMP,U,2)
 I HMPDIS S VAINDT=HMPDIS-.0001
 D INP^VADPT  ; Get inpatient VAIN array
 I '$G(VAIN(1)) Q  ; Quit if not inpatient
 ;US5630 - TW - Extract Calculated DRG for PTF
 S PTF("drg")=$$GET1^DIQ(45,+HMPLID_",",9,"")
 S PTF("admissionUid")=$$SETUID^HMPUTILS("visit",DFN,"H"_VAIN(1))
 S HMPADM=+$G(VAIN(7))  ; Admission date
 ;DE2818, changed from ^DIC(42) to FileMan, ICR 10039
 S HMPLOC=+$$GET1^DIQ(42,+$G(VAIN(4))_",",44,"I")  ; Get location
 S:HMPADM PTF("arrivalDateTime")=$$JSONDT^HMPUTILS(HMPADM)
 S:HMPDIS PTF("dischargeDateTime")=$$JSONDT^HMPUTILS(HMPDIS)
 S HMPFAC=$$FAC^HMPD(HMPLOC) D:HMPFAC FACILITY^HMPUTILS(HMPFAC,"PTF")
 S PTF("lastUpdateTime")=$$EN^HMPSTMP("ptf") ;RHL 20150102
 S PTF("stampTime")=PTF("lastUpdateTime") ; RHL 20150102
 ;US5630 - TW - Check for ICD Coding System
 S HMPDX=$P(HMPTMP,U)
 S HMPISYS=$P(HMPTMP,U,3)
 S HMPISYS=$S(HMPISYS="ICD":1,"ICP":2,"10D":30,"10P":31,1:1)  ; Identify ICD coding system for correct lookup
 S HMPX=$$ICDDX^ICDEX(HMPDX,"",HMPISYS)
 S PTF("icdCode")=$$SETNCS^HMPUTILS("icd",$P(HMPX,U,2))
 S PTF("icdName")=$P(HMPX,U,4)
  ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("ptf",PTF("uid"),PTF("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("PTF","ptf")
 Q
 ;
VISIT(DFN,DATE) ; -- Return visit# for admission
 N X,Y
 S X=9999999-$P(DATE,".")_"."_$P(DATE,".",2)
 S Y=+$O(^AUPNVSIT("AAH",DFN,X,0))  ;DE2818, ICR 2028
 Q Y
