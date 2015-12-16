VPRDJ04A ;SLC/MKB -- Admissions,PTF ;7/25/13
 ;;1.0;VIRTUAL PATIENT RECORD;**2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ; ICDEX                         5747
 ; ICPTCOD                       1995
 ; VADPT                        10061
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
ADM(ID,DATE) ; -- admission [from VSIT1]
 N ADM,VADMVT,VAIP,VAERR,MVT,SPEC,HLOC,FAC,ICD,I
 S ID=$G(ID),DATE=+$G(DATE) Q:ID=""  ;Q:DATE<1
 I ID S VAIP("D")=DATE,VST=+ID
 I ID?1"H"1.N S VAIP("E")=+$E(ID,2,99),VST=0
 D IN5^VADPT Q:'$G(VAIP(1))  ;deleted
 S VADMVT=+$G(VAIP(13)),ID="H"_VADMVT
 S ADM("localId")=ID,ADM("uid")=$$SETUID^VPRUTILS("visit",DFN,ID)
 S:'DATE DATE=+$G(VAIP(13,1)) S:'VST VST=$$VISIT(DFN,DATE)
 S (ADM("dateTime"),ADM("stay","arrivalDateTime"))=$$JSONDT^VPRUTILS(DATE)
 S:$L($P(VAIP(6),U,2)) ADM("roomBed")=$P(VAIP(6),U,2)
 S MVT=13,I=0 I VADMVT=$G(^DPT(DFN,.105)) D  ;if current admission,
 . S ADM("current")="true",MVT=14            ; use last movement info
 . S X=$G(^DPT(DFN,.101)) S:$L(X) ADM("roomBed")=X
 . K VPRADMIT                                ;kill flag from VPRDJ0
 S SPEC=$G(VAIP(MVT,6)),ADM("specialty")=$P(SPEC,U,2)
 S X=$$SERV^VPRDVSIT(+SPEC),ADM("service")=X
 S HLOC=+$G(^DIC(42,+$G(VAIP(MVT,4)),44)),FAC=$$FAC^VPRD(+HLOC) I HLOC D
 . S ADM("locationUid")=$$SETUID^VPRUTILS("location",,+HLOC)
 . S ADM("locationName")=$P($G(^SC(HLOC,0)),U)
 . S X=$$AMIS^VPRDVSIT($P($G(^SC(HLOC,0)),U,7))
 . S:$L($G(X)) ADM("stopCodeUid")="urn:va:stop-code:"_$P(X,U),ADM("stopCodeName")=$P(X,U,2)
 . S ADM("summary")="${"_ADM("service")_"}:"_ADM("locationName")
 D FACILITY^VPRUTILS(FAC,"ADM")
 S ADM("categoryCode")="urn:va:encounter-category:AD",ADM("categoryName")="Admission"
 S ADM("patientClassCode")="urn:va:patient-class:IMP",ADM("patientClassName")="Inpatient"
 I $G(VAIP(17)) S ADM("stay","dischargeDateTime")=$$JSONDT^VPRUTILS(+$G(VAIP(17,1)))
 I $G(VAIP(18)) S I=I+1 D PROV("ADM",I,+VAIP(18),"A")         ;attending
 I $G(VAIP(MVT,5)) S I=I+1 D PROV("ADM",I,+VAIP(MVT,5),"P",1) ;primary
 S ICD=$$POV^VPRDVSIT(VST,DATE) S:'ICD ICD=$$PTF^VPRDVSIT(DFN,VAIP(12),DATE) ;PTF>ICD
 I $L(ICD)<3 S ADM("reasonName")=$G(VAIP(MVT,7))
 E  D
 . N SYS S SYS=$P(ICD,U,3),SYS=$$LOW^XLFSTR(SYS)
 . S ADM("reasonUid")=$$SETNCS^VPRUTILS(SYS,ICD),ADM("reasonName")=$P(ICD,U,2)
 S X=$$CPT^VPRDVSIT(VST),ADM("typeName")=$S(X:$P($$CPT^ICPTCOD(X),U,3),1:$$CATG^VPRDVSIT("H"))
 D MVT(VADMVT)   ;sub-movements
 D TIU(VST,.ADM) ;notes/summary
 D ADD^VPRDJ("ADM","visit")
 Q
 ;
TIU(VISIT,ARR) ; -- add notes to ARR("document")
 N X,Y,I,SCR,VPRX,LT,NT,DA,CNT,VPRY
 S SCR="I $P(^(0),U,5)>6,$P(^(0),U,5)<14"
 D FIND^DIC(8925,,.01,"QX",+$G(VISIT),,"V",SCR,,"VPRX")
 S Y="",(I,CNT)=0
 F  S I=$O(VPRX("DILIST",1,I)) Q:I<1  D
 . S LT=$G(VPRX("DILIST","ID",I,.01)) Q:$P(LT," ")="Addendum"
 . S DA=$G(VPRX("DILIST",2,I))
 . S NT=$$GET1^DIQ(8925,+DA_",",".01:1501")
 . S CNT=CNT+1,ARR("documents",CNT,"uid")=$$SETUID^VPRUTILS("document",DFN,+DA)
 . S ARR("documents",CNT,"localTitle")=LT
 . S:$L(NT) ARR("documents",CNT,"nationalTitle")=NT
 Q
 ;
PROV(ARR,I,IEN,ROLE,PRIM) ; -- add providers
 S @ARR@("providers",I,"providerUid")=$$SETUID^VPRUTILS("user",,+IEN)
 S @ARR@("providers",I,"providerName")=$P($G(^VA(200,+IEN,0)),U)
 S @ARR@("providers",I,"role")=ROLE
 S:$G(PRIM) @ARR@("providers",I,"primary")="true"
 Q
 ;
MVT(CA) ; -- add movements to ADM("movement",i,"attribute")
 N DATE,DA,CNT,X S (DATE,CNT)=0
 F  S DATE=$O(^DGPM("APCA",DFN,CA,DATE)) Q:DATE<1  S DA=+$O(^(DATE,0)) I DA'=CA D
 . S X0=$G(^DGPM(DA,0)),CNT=CNT+1
 . S ADM("movements",CNT,"localId")=DA
 . S ADM("movements",CNT,"dateTime")=$$JSONDT^VPRUTILS(DATE)
 . S ADM("movements",CNT,"movementType")=$$EXTERNAL^DILFD(405,.02,,$P(X0,U,2))
 . S X=+$P(X0,U,19) I X D
 .. S ADM("movements",CNT,"providerUid")=$$SETUID^VPRUTILS("user",,X)
 .. S ADM("movements",CNT,"providerName")=$P($G(^VA(200,X,0)),U)
 . S X=+$P(X0,U,9)
 . S:X ADM("movements",CNT,"specialty")=$$EXTERNAL^DILFD(405,.09,,X)
 . S HLOC=+$G(^DIC(42,+$P(X0,U,6),44)),FAC=$$FAC^VPRD(HLOC) I HLOC D
 .. S ADM("movements",CNT,"locationUid")=$$SETUID^VPRUTILS("location",,HLOC)
 .. S ADM("movements",CNT,"locationName")=$P($G(^SC(HLOC,0)),U)
 Q
 ;
PTFA(ID) ; -- find ID in ^TMP("VPRPX",$J), fall thru to PX1 if successful
 N IDT S (IDT,VPRIDT)=0
 F  S IDT=$O(^TMP("VPRPX",$J,IDT)) Q:IDT<1  I $D(^(IDT,ID)) S VPRIDT=IDT Q
 Q:VPRIDT<1  ;not found
PTF1 ; -- PTF where ID=iens;TYPE
 ;   Expects ^TMP("VPRPX",$J,VPRIDT,ID)=ITM^[DISCHARGE]DATE^SYS
 N TMP,PTF,ADM,DIS,VAIN,VAINDT,HLOC,FAC,X,Y,VISIT,X0
 ; PTF^DGPTPXRM(+ID,.VPRF)
 S TMP=$G(^TMP("VPRPX",$J,VPRIDT,ID))
 ;
 S PTF("localId")=ID,PTF("uid")=$$SETUID^VPRUTILS("ptf",DFN,ID)
 S P=$L(ID,";"),TYPE=$P(ID,";",P) S:TYPE="DXLS" PTF("principalDx")="true"
 S X=$$ICDDX^ICDEX($P(TMP,U),$P(TMP,U,2),,"E")
 S Y=$$LOW^XLFSTR($$SAB^ICDEX($P(X,U,20))) ;coding system
 S PTF("icdCode")=$$SETNCS^VPRUTILS(Y,$P(X,U,2)),PTF("icdName")=$P(X,U,4)
 S DIS=$P(TMP,U,2) S:DIS VAINDT=DIS-.0001 D INP^VADPT
 S ADM=+$G(VAIN(7)),HLOC=+$G(^DIC(42,+$G(VAIN(4)),44))
 S:ADM PTF("arrivalDateTime")=$$JSONDT^VPRUTILS(ADM)
 S:DIS PTF("dischargeDateTime")=$$JSONDT^VPRUTILS(DIS)
 S FAC=$$FAC^VPRD(HLOC)
 S VISIT=+$$VISIT(DFN,ADM) I VISIT D
 . S PTF("encounterUid")=$$SETUID^VPRUTILS("visit",DFN,VISIT)
 . S PTF("encounterName")=$$NAME^VPRDJ04(VISIT) Q:FAC
 . S X0=$G(^AUPNVSIT(+VISIT,0)),FAC=+$P(X0,U,6)
 . S:FAC X=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 . S:'FAC X=$$FAC^VPRD(+$P(X0,U,22)) ;location
 D:FAC FACILITY^VPRUTILS(FAC,"PTF")
 D ADD^VPRDJ("PTF","ptf")
 Q
 ;
VISIT(DFN,DATE) ; -- Return visit# for admission
 N X,Y
 S X=9999999-$P(DATE,".")_"."_$P(DATE,".",2)
 S Y=+$O(^AUPNVSIT("AAH",DFN,X,0))
 Q Y
