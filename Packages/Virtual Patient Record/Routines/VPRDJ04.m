VPRDJ04 ;SLC/MKB -- Appointments,Visits ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DGS(41.1                     3796
 ; ^DIC(42                      10039
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; ICPTCOD                       1995
 ; PXAPI,^TMP("PXKENC"           1894
 ; SDAMA301                      4433
 ; XLFDT                        10103
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
SDAM1 ; -- appointment ^TMP($J,"SDAMA301",DFN,VPRDT)
 N NODE,HLOC,APPT,X,STS,CLS,FAC,SV,PRV
 S NODE=$G(^TMP($J,"SDAMA301",DFN,VPRDT))
 ;
 S HLOC=$P(NODE,U,2),X="A;"_VPRDT_";"_+HLOC
 I $L($G(ID)),$P(ID,";",1,3)'=X Q
 S APPT("localId")=X,APPT("uid")=$$SETUID^VPRUTILS("appointment",DFN,X)
 S X=$P(NODE,U,10),APPT("typeCode")=$P(X,";"),APPT("typeName")=$P(X,";",2)
 S STS=$P(NODE,U,3),CLS=$S($E(STS)="I":"I",1:"O")
 S APPT("dateTime")=$$JSONDT^VPRUTILS(VPRDT)
 S:$L($P(NODE,U,6)) APPT("comment")=$P(NODE,U,6)
 S:$P(NODE,U,9) APPT("checkIn")=$$JSONDT^VPRUTILS($P(NODE,U,9))
 S:$P(NODE,U,11) APPT("checkOut")=$$JSONDT^VPRUTILS($P(NODE,U,11))
 I $L(ID,";")>3 S APPT("reasonName")=$P(ID,";",4),PRV=+$P(ID,";",5) ;from SDAM event
 S FAC=$$FAC^VPRD(+HLOC) D FACILITY^VPRUTILS(FAC,"APPT") I HLOC D
 . S APPT("locationName")=$P(HLOC,";",2)
 . S APPT("locationUid")=$$SETUID^VPRUTILS("location",,+HLOC)
 . S X=$$AMIS^VPRDVSIT(+$P(NODE,U,13))
 . S:$L(X) APPT("stopCodeUid")="urn:va:stop-code:"_$P(X,U),APPT("stopCodeName")=$P(X,U,2)
 . S SV=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I SV S APPT("service")=$$SERV^VPRDSDAM(SV)
 . ;find default provider
 . S:'$G(PRV) PRV=+$$GET1^DIQ(44,+HLOC_",",16,"I") I 'PRV D
 .. N VPRP,I,FIRST
 .. D GETS^DIQ(44,+HLOC_",","2600*","I","VPRP")
 .. S FIRST=$O(VPRP(44.1,"")),I=""
 .. F  S I=$O(VPRP(44.1,I)) Q:I=""  I $G(VPRP(44.1,I,.02,"I")) S PRV=$G(VPRP(44.1,I,.01,"I")) Q
 .. I 'PRV,FIRST S PRV=$G(VPRP(44.1,FIRST,.01,"I"))
 I $G(PRV) S APPT("providers",1,"providerUid")=$$SETUID^VPRUTILS("user",,PRV),APPT("providers",1,"providerName")=$P($G(^VA(200,PRV,0)),U)
 I $G(SV) S APPT("summary")="${"_APPT("service")_"}:"_$P(HLOC,";",2)
 S APPT("patientClassCode")="urn:va:patient-class:"_$S(CLS="I":"IMP",1:"AMB")
 S APPT("patientClassName")=$S(CLS="I":"Inpatient",1:"Ambulatory")
 S APPT("categoryCode")="urn:va:encounter-category:OV",APPT("categoryName")="Outpatient Visit"
 S APPT("appointmentStatus")=$P(STS,";",2)
 D ADD^VPRDJ("APPT","appointment")
 Q
 ;
DGS ; scheduled admissions [from APPOINTM^VPRDJ0]
 S VPRA=0 F  S VPRA=$O(^DGS(41.1,"B",DFN,VPRA)) Q:VPRA<1  D  Q:VPRI'<VPRMAX
 . S VPRX=$G(^DGS(41.1,VPRA,0))
 . I $L($G(ID)),+$P(ID,";",2)=+$P(VPRX,U,2) D DGS1(VPRA) Q
 . Q:$P(VPRX,U,13)  Q:$P(VPRX,U,17)  ;cancelled or admitted
 . S X=$P(VPRX,U,2) Q:X<VPRSTART!(X>VPRSTOP)  ;out of date range
 . D DGS1(VPRA)
 Q
 ;
DGS1(IFN) ; -- scheduled admission
 N ADM,X0,DATE,HLOC,FAC,SV,X
 S X0=$G(^DGS(41.1,+$G(IFN),0)) Q:X0=""  ;deleted
 ;
 S DATE=+$P(X0,U,2),HLOC=+$G(^DIC(42,+$P(X0,U,8),44))
 S X="H;"_DATE,ADM("localId")=X,ADM("uid")=$$SETUID^VPRUTILS("appointment",DFN,X)
 S ADM("dateTime")=$$JSONDT^VPRUTILS(DATE)
 S FAC=$$FAC^VPRD(+HLOC) D FACILITY^VPRUTILS(FAC,"ADM") I HLOC D
 . S HLOC=+HLOC_";"_$P($G(^SC(+HLOC,0)),U)
 . S ADM("uid")=ADM("uid")_";"_+HLOC
 . S ADM("locationName")=$P(HLOC,";",2)
 . S ADM("locationUid")=$$SETUID^VPRUTILS("location",,+HLOC)
 . S X=$$GET1^DIQ(44,+HLOC_",",8,"I"),X=$$AMIS^VPRDVSIT(X)
 . S:$L(X) ADM("stopCodeUid")="urn:va:stop-code:"_$P(X,U),ADM("stopCodeName")=$P(X,U,2)
 . S SV=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I SV S ADM("service")=$$SERV^VPRDSDAM(SV)
 I $G(SV) S ADM("summary")="${"_ADM("service")_"}:"_$P(HLOC,";",2)
 S X=+$P(X0,U,5) I X D
 . S ADM("providers",1,"providerUid")=$$SETUID^VPRUTILS("user",,X)
 . S ADM("providers",1,"providerName")=$P($G(^VA(200,X,0)),U)
 S ADM("patientClassCode")="urn:va:patient-class:IMP",ADM("patientClassName")="Inpatient"
 S ADM("categoryCode")="urn:va:encounter-category:AD",ADM("categoryName")="Admission"
 S ADM("appointmentStatus")=$S($P(X0,U,17):"ADMITTED",$P(X0,U,13):"CANCELLED",1:"SCHEDULED")
 D ADD^VPRDJ("ADM","appointment")
 Q
 ;
VSIT1(ID) ; -- visit
 N VST,X0,X15,X,FAC,LOC,CATG,AMIS,INPT,DA
 I $G(ID)?1"H"1.N D ADM^VPRDJ04A(ID) Q
 D ENCEVENT^PXAPI(ID)
 ;
 S X0=$G(^TMP("PXKENC",$J,ID,"VST",ID,0)),X15=$G(^(150))
 Q:$P(X15,U,3)'="P"  Q:$P(X0,U,7)="E"  Q:$P(X0,U,12)  ;primary, not historical or child
 I $P(X0,U,7)="H" D ADM^VPRDJ04A(ID,+X0) Q
 S VST("localId")=ID,VST("uid")=$$SETUID^VPRUTILS("visit",DFN,ID)
 S VST("dateTime")=$$JSONDT^VPRUTILS(+X0)
 S:$P(X0,U,18) VST("checkOut")=$$JSONDT^VPRUTILS($P(X0,U,18))
 S FAC=+$P(X0,U,6),CATG=$P(X0,U,7),LOC=+$P(X0,U,22)
 S:FAC X=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC X=$$FAC^VPRD(LOC) D FACILITY^VPRUTILS(X,"VST")
 S X=$S(CATG="H":"AD",CATG="C":"CR",CATG="T":"TC",CATG="N":"U",CATG="R":"NH","D^X"[CATG:"O",1:"OV")
 S VST("categoryCode")="urn:va:encounter-category:"_X
 S VST("categoryName")=$S(X="AD":"Admission",X="CR":"Chart Review",X="TC":"Phone Contact",X="U":"Unknown",X="NH":"Nursing Home",X="O":"Other",1:"Outpatient Visit")
 S INPT=$P(X15,U,2) S:INPT="" INPT=$S("H^I^R^D"[CATG:1,1:0)
 S X=$$CPT^VPRDVSIT(ID) S:X VST("typeName")=$P($$CPT^ICPTCOD(X),U,3)
 I 'X S VST("typeName")=$S('INPT&LOC:$P($G(^SC(LOC,0)),U)_" VISIT",1:$$CATG^VPRDVSIT(CATG))
 S VST("patientClassCode")="urn:va:patient-class:"_$S(INPT:"IMP",1:"AMB")
 S VST("patientClassName")=$S(INPT:"Inpatient",1:"Ambulatory")
 S X=$P(X0,U,8) S:X AMIS=$$AMIS^VPRDVSIT(X) I LOC D
 . N L0 S L0=$G(^SC(LOC,0))
 . I 'X S AMIS=$$AMIS^VPRDVSIT($P(L0,U,7))
 . S VST("locationUid")=$$SETUID^VPRUTILS("location",,+LOC)
 . S VST("locationName")=$P(L0,U)
 . S X=$$SERV^VPRDVSIT($P(L0,U,20)) Q:X=""
 . S:$L(X) VST("service")=X,VST("summary")="${"_VST("service")_"}:"_$P(L0,U)
 S:$D(AMIS) VST("stopCodeUid")="urn:va:stop-code:"_$P(AMIS,U),VST("stopCodeName")=$P(AMIS,U,2)
 S X=$$POV^VPRDVSIT(ID) I $L(X) D
 . N SYS S SYS=$P(X,U,3),SYS=$$LOW^XLFSTR(SYS)
 . S VST("reasonUid")=$$SETNCS^VPRUTILS(SYS,$P(X,U)),VST("reasonName")=$P(X,U,2)
 ; provider(s)
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,ID,"PRV",DA)) Q:DA<1  S X0=$G(^(DA,0)) D
 . I $P(X0,U,4)="P" D PROV("VST",DA,+X0,"P",1) Q  ;primary
 . D PROV("VST",DA,+X0,"S")                       ;secondary
 K ^TMP("PXKENC",$J,ID)
 ; note(s)
 D TIU^VPRDJ04A(ID,.VST)
 D ADD^VPRDJ("VST","visit")
 Q
 ;
PROV(ARR,I,IEN,ROLE,PRIM) ; -- add providers
 S @ARR@("providers",I,"providerUid")=$$SETUID^VPRUTILS("user",,+IEN)
 S @ARR@("providers",I,"providerName")=$P($G(^VA(200,+IEN,0)),U)
 S @ARR@("providers",I,"role")=ROLE
 S:$G(PRIM) @ARR@("providers",I,"primary")="true"
 Q
 ;
NAME(IEN) ; -- Return a string 'name' for the visit
 N Y,X0,LOC,DATE
 S X0=$G(^AUPNVSIT(+$G(IEN),0)),Y=""
 S DATE=+X0,LOC=+$P(X0,U,22) S:LOC LOC=$P($G(^SC(LOC,0)),U)_" "
 S Y=LOC_$$FMTE^XLFDT(DATE,"1D") ;Mon DD, YYYY
 Q Y
