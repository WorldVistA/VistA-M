HMPDJ03 ;SLC/MKB,ASMR/RRB,JD - Consults,ClinProcedures,CLiO ;4/4/16  15:33
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2**;May 15, 2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DE4173 - JD - 3/30/16: Send consult notes for "activities" and "results".
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC(                         10040
 ; ^TIU(8925.1                   5677
 ; ^VA(200                      10060
 ; %DT                          10003
 ; DILFD                         2055
 ; DIQ                           2056
 ; GMRCAPI                       6082
 ; GMRCGUIB                      2980
 ; GMRCSLM1,^TMP("GMRCR"         2740
 ; MCARUTL3                      3280
 ; MDPS1,^TMP("MDHSP"            4230
 ; ORX8                          2467
 ; TIULQ                         2693
 ; TIUSRVLO                      2834
 ; XLFSTR                       10104
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
GMRC1(ID) ; -- consult/request HMPX=^TMP("GMRCR",$J,"CS",HMPN,0)
 N CONS,ORDER,HMPD,X0,X,HMPA,DA,ACT0,ACT2,ACT3,ACT,HMPEASON,HMPJ,HMPTIU
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the consults domain"
 ;
 S CONS("localId")=+HMPX,CONS("uid")=$$SETUID^HMPUTILS("consult",DFN,+HMPX)
 S CONS("dateTime")=$$JSONDT^HMPUTILS($P(HMPX,U,2))
 S CONS("statusName")=$P(HMPX,U,3),CONS("service")=$P(HMPX,U,4)
 S CONS("consultProcedure")=$P(HMPX,U,5)
 I $P(HMPX,U,6)="*" S CONS("interpretation")="SIGNIFICANT FINDINGS"
 S CONS("typeName")=$P(HMPX,U,7),CONS("category")=$P(HMPX,U,9)
 S ORDER=+$P(HMPX,U,8),CONS("orderName")=$P($$OI^ORX8(ORDER),U,2)
 S CONS("orderUid")=$$SETUID^HMPUTILS("order",DFN,ORDER)
 D GET^GMRCAPI(.HMPD,+HMPX) S X0=$G(HMPD(0)) ;=^GMR(123,ID,0)
 S X=$P(X0,U,6) S:X CONS("fromService")=$$GET1^DIQ(44,X_",",.01)  ;DE2818
 S X=$P(X0,U,9) S:X]"" CONS("urgency")=X
 S X=$P(X0,U,10) S:X]"" CONS("place")=X
 S X=$P(X0,U,11) S:X CONS("attention")=$$GET1^DIQ(200,X_",",.01)  ;DE2818
 S X=$P(X0,U,13) S:X]"" CONS("lastAction")=X
 S X=$P(X0,U,14) I X D  ;ordering provider
 . S CONS("providerUid")=$$SETUID^HMPUTILS("user",,+X)
 . S CONS("providerName")=$$GET1^DIQ(200,X_",",.01)  ;DE2818
 S X=$P(X0,U,18) I $L(X) D
 . S CONS("patientClassCode")="urn:va:patient-class:"_$S(X="I":"IMP",1:"AMB")
 . S CONS("patientClassName")=$S(X="I":"Inpatient",1:"Ambulatory")
 S X=+$P(X0,U,24) S:X CONS("earliestDate")=$$JSONDT^HMPUTILS(X)
 I $P(HMPX,U,9)="M" S CONS("clinicalProcedure")=$G(HMPD(1))
 I $D(HMPD(20)) M HMPEASON=HMPD(20) S CONS("reason")=$$STRING^HMPD(.HMPEASON)
 S X=$G(HMPD(30)) S:$L(X) CONS("provisionalDx")=X
 ; 
 I $P(X0,U,23) D  ;inter-facility
 . N IFC S X=$$NS^XUAF4($P(X0,U,23))
 . S CONS("remote","facilityCode")=$P(X,U,2),CONS("remote","facilityName")=$P(X,U)
 . S:$P(X0,U,22) CONS("remote","id")=$P(X0,U,22)
 . S IFC=$$IFC^GMRCAPI(ID)
 . S X=$P(IFC,U) S:$L(X) CONS("remote","service")=X
 . S X=$P(IFC,U,5) S:$L(X) CONS("remote","role")=$S(X="P":"Requesting facility",1:"Consulting facility")
 . S CONS("remote","providerName")=$P(IFC,U,6)
 . S X=$P(IFC,U,2) S:$L(X) CONS("remote","providerphone")=X
 . S X=$P(IFC,U,3) S:$L(X) CONS("remote","providerpager")=X
 ;
 D ACT^GMRCAPI(.HMPA,ID)
 S DA=0 F  S DA=$O(HMPA(DA)) Q:DA<1  D
 . S ACT0=$G(HMPA(DA,0)),ACT2=$G(HMPA(DA,2)),ACT3=$G(HMPA(DA,3)) K ACT
 . I $L(ACT2),$P(X0,U,23) S X=$$NS^XUAF4($P(X0,U,23)),ACT("facilityCode")=$P(X,U,2),ACT("facilityName")=$P(X,U)
 . S ACT("name")=$P(ACT0,U,2)
 . S ACT("entered")=$$JSONDT^HMPUTILS($P(ACT0,U))
 . S ACT("dateTime")=$$JSONDT^HMPUTILS($P(ACT0,U,3))
 . S:$L($P(ACT2,U,3)) ACT("timeZone")=$P(ACT2,U,3)
 . I $L(ACT2) S ACT("enteredBy")=$P(ACT2,U),ACT("responsible")=$P(ACT2,U,2)
 . E  D  ;remote vs. local users
 .. S X=+$P(ACT0,U,4) S:X ACT("responsible")=$$GET1^DIQ(200,X_",",.01)  ;DE2818
 .. S X=+$P(ACT0,U,5) S:X ACT("enteredBy")=$$GET1^DIQ(200,X_",",.01)  ;DE2818
 . S X=$S($L(ACT3):ACT3,1:$P(ACT0,U,6)) S:$L(X) ACT("forwardedFrom")=X
 . S X=$P(ACT0,U,7) S:X ACT("previousAttention")=$$GET1^DIQ(200,X_",",.01)  ;DE2818
 . S X=$P(ACT0,U,8) S:X ACT("device")=$$GET1^DIQ(3.5,X_",",.01)
 . S X=$P(ACT0,U,9) I X,X["TIU" D
 .. S ACT("resultUid")=$$SETUID^HMPUTILS("document",DFN,+X)
 .. ;=== Start DE4173 for "activity" attribute
 .. N HMP92,HMPNI
 .. S HMPNI=$P($P(ACT0,U,9),";")  ;Note (document) IEN --> ^TIU(8925,HMPNI
 .. I HMPNI'>0 Q
 .. D SETTEXT^HMPUTILS($NA(^TIU(8925,HMPNI,"TEXT")),"HMP92")  ;Format a word processing field
 .. M ACT("note","\")=HMP92
 .. ;=== End DE4173 for "activity" attribute
 . I $D(HMPA(DA,1)) M HMPEASON=HMPA(DA,1) S ACT("comment")=$$STRING^HMPD(.HMPEASON)
 . M CONS("activity",DA)=ACT
 ;
 S HMPJ=0 F  S HMPJ=$O(HMPD(50,HMPJ)) Q:HMPJ<1  S X=$G(HMPD(50,HMPJ)) D
 . Q:'$D(@(U_$P(X,";",2)_+X_")"))  ;text deleted
 . ;=== Start DE4173 for "results" attribute
 . N HMP92,HMPNI
 . S HMPNI=$P(X,";")  ;Note (document) IEN --> ^TIU(8925,HMPNI
 . I HMPNI>0 D
 .. D SETTEXT^HMPUTILS($NA(^TIU(8925,HMPNI,"TEXT")),"HMP92")  ;Format a word processing field
 .. M CONS("results",HMPJ,"note","\")=HMP92
 . ;=== End DE4173 for "results" attribute
 . S CONS("results",HMPJ,"uid")=$$SETUID^HMPUTILS("document",DFN,+X)
 . D EXTRACT^TIULQ(+X,"HMPTIU",,.01)
 . S CONS("results",HMPJ,"localTitle")=$G(HMPTIU(+X,.01,"E"))
 S X=$P(X0,U,21),X=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^HMPD)
 D FACILITY^HMPUTILS(X,"CONS")
 S CONS("lastUpdateTime")=$$EN^HMPSTMP("consult")
 S CONS("stampTime")=CONS("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("consult",CONS("uid"),CONS("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("CONS","consult")
 Q
 ;
MDPS1(DFN,BEG,END,MAX) ; -- perform CP search (scope variables)
 N MCARCODE,MCARDT,MCARPROC,MCESKEY,MCESSEC,MCFILE,MDC,MDIMG,RES
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 K ^TMP("MDHSP",$J) S RES=""
 D EN1^MDPS1(.RES,DFN,BEG,END,MAX,"",0) ;RES=^TMP("MDHSP",$J)
 Q
 ;
MC1(ID) ; -- clinical procedure HMPX=^TMP("MDHSP",$J,HMPN)
 N X,Y,%DT,DATE,RTN,GBL,CONS,TIUN,HMPD,X0,PROC,HMPT,LOC,FAC
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the clinical procedure domain"
 ;
 S RTN=$P(HMPX,U,3,4) Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 S X=$P(HMPX,U,6),%DT="TXS" D ^%DT Q:Y'>0  S DATE=Y
 S GBL=+$P(HMPX,U,2)_";"_$S(RTN="PR702^MDPS1":"MDD(702,",1:$$ROOT^HMPDMC(DFN,$P(HMPX,U,11),DATE))
 Q:'GBL  I $G(ID),ID'=GBL Q                ;unknown, or not requested
 ;
 S CONS=+$P(HMPX,U,13) D:CONS DOCLIST^GMRCGUIB(.HMPD,CONS) S X0=$G(HMPD(0)) ;=^GMR(123,ID,0)
 S TIUN=+$P(HMPX,U,14) S:TIUN TIUN=TIUN_U_$$RESOLVE^TIUSRVLO(TIUN)
 S PROC("localId")=GBL,PROC("category")="CP"
 S PROC("uid")=$$SETUID^HMPUTILS("procedure",DFN,GBL)
 S PROC("name")=$P(HMPX,U),PROC("dateTime")=$$JSONDT^HMPUTILS(DATE)
 S X=$P(HMPX,U,7) S:$L(X) PROC("interpretation")=X
 S PROC("kind")="Procedure"
 I CONS,X0 D
 . N HMPJ S PROC("requested")=$$JSONDT^HMPUTILS(+X0)
 . S PROC("consultUid")=$$SETUID^HMPUTILS("consult",DFN,CONS)
 . S PROC("orderUid")=$$SETUID^HMPUTILS("order",DFN,+$P(X0,U,3))
 . S PROC("statusName")=$$EXTERNAL^DILFD(123,8,,$P(X0,U,12))
 . S HMPJ=0 F  S HMPJ=$O(HMPD(50,HMPJ)) Q:HMPJ<1  S X=+$G(HMPD(50,HMPJ)) D
 .. D NOTE(X)
 .. S:'TIUN TIUN=X_U_$$RESOLVE^TIUSRVLO(X)
 I TIUN D
 . S X=$P(TIUN,U,5) I X D
 .. S PROC("providers",1,"providerUid")=$$SETUID^HMPUTILS("user",,+X)
 .. S PROC("providers",1,"providerName")=$P(X,";",3)
 . S:$P(TIUN,U,11) PROC("hasImages")="true"
 . K HMPT D EXTRACT^TIULQ(+TIUN,"HMPT",,".03;.05;1211",,,"I")
 . S X=+$G(HMPT(+TIUN,.03,"I")),PROC("encounterUid")=$$SETUID^HMPUTILS("visit",DFN,X)
 . S LOC=+$G(HMPT(+TIUN,1211,"I")) I LOC S LOC=LOC_U_$$GET1^DIQ(44,LOC_",",.01)  ;DE2818
 . E  S X=$P(TIUN,U,6) S:$L(X) LOC=+$O(^SC("B",X,0))_U_X  ; DE2818, ICR 10040
 . S:LOC PROC("locationUid")=$$SETUID^HMPUTILS("location",,+LOC),PROC("locationName")=$P(LOC,U,2),FAC=$$FAC^HMPD(+LOC)
 . I '$D(PROC("statusName")) S X=+$G(HMPT(+TIUN,.05,"I")),PROC("statusName")=$S(X<6:"PARTIAL RESULTS",1:"COMPLETE")
 . I '$G(PROC("results",+TIUN)) D NOTE(+TIUN)
 ; if no consult or note/visit ...
 I 'CONS,'TIUN,RTN'="PR702^MDPS1" S PROC("results",1,"uid")=$$SETUID^HMPUTILS("document",DFN,GBL) ;DE1977 add link to report document
 S:'$D(PROC("statusName")) PROC("statusName")="COMPLETE"
 I '$D(FAC) S X=$P(X0,U,21),FAC=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^HMPD)
 D FACILITY^HMPUTILS(FAC,"PROC")
 S PROC("lastUpdateTime")=$$EN^HMPSTMP("procedure")
 S PROC("stampTime")=PROC("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("procedure",PROC("uid"),PROC("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("PROC","procedure")
 Q
 ;
NOTE(DA) ; -- add TIU note info
 N HMPT,TEXT
 D EXTRACT^TIULQ(DA,"HMPT",,.01)
 S PROC("results",DA,"uid")=$$SETUID^HMPUTILS("document",+$G(DFN),DA)
 S PROC("results",DA,"localTitle")=$G(HMPT(DA,.01,"E"))
 Q
 ;
MDC1(ID) ; -- clinical observation
 N GUID,CLIO,HMPC,HMPT,LOC,FAC,I,X,Y
 S GUID=$G(ID) Q:GUID=""  ;invalid GUID
 D QRYOBS^HMPDMDC("HMPC",GUID) Q:'$D(HMPC)  ;doesn't exist
 Q:$L($G(HMPC("PARENT_ID","E")))            ;PARENT also in list
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the clinical observation domain"
 ;
 S CLIO("localId")=GUID,CLIO("uid")=$$SETUID^HMPUTILS("obs",DFN,GUID)
 S X=$G(HMPC("TERM_ID","I")) S:X CLIO("typeVuid")="urn:va:vuid:"_X
 S CLIO("typeCode")="urn:va:clioterminology:"_$G(HMPC("TERM_ID","GUID"))
 S CLIO("typeName")=$G(HMPC("TERM_ID","E"))
 S CLIO("result")=$G(HMPC("SVALUE","E"))
 S X=$G(HMPC("UNIT_ID","ABBV")) S:$L(X) CLIO("units")=X
 S X=$G(HMPC("ENTERED_DATE_TIME","I")),CLIO("entered")=$$JSONDT^HMPUTILS(X)
 S X=$G(HMPC("OBSERVED_DATE_TIME","I")),CLIO("observed")=$$JSONDT^HMPUTILS(X)
 D QRYTYPES^HMPDMDC("HMPT")
 F I=3,5 S X=$G(HMPT(I,"XML")) I $L($G(HMPC(X,"E"))) D
 . S Y=HMPT(I,"NAME"),Y=$S(Y="LOCATION":"bodySite",1:$$LOW^XLFSTR(Y))
 . S CLIO(Y_"Code")=HMPC(X,"I"),CLIO(Y_"Name")=HMPC(X,"E")
 F I=4,6,7 S X=$G(HMPT(I,"XML")) I $L($G(HMPC(X,"E"))) D
 . S CLIO("qualifiers",I,"type")=$$LOW^XLFSTR(HMPT(I,"NAME"))
 . S CLIO("qualifiers",I,"code")=HMPC(X,"I")
 . S CLIO("qualifiers",I,"name")=HMPC(X,"E")
 S X=$G(HMPC("RANGE","E")) I $L(X) D
 . S Y=$S(X="Out of Bounds Low":"<",X="Out of Bounds High":">",1:$E(X))
 . S CLIO("interpretationCode")="urn:hl7:observation-interpretation:"_Y
 . S CLIO("interpretationName")=$S(X="<":"Low off scale",X=">":"High off scale",1:X)
 ; X=$G(HMPC("STATUS","E")) S:$L(X) CLIO("resultStatus")=$S(X="unverified":"active",1:"complete")
 I $D(HMPC("SUPP_PAGE")) D  ;add set info
 . S CLIO("setID")=$G(HMPC("SUPP_PAGE","GUID"))
 . S CLIO("setName")=$G(HMPC("SUPP_PAGE","DISPLAY_NAME"))
 . S X=$G(HMPC("SUPP_PAGE","TYPE")) S:$L(X) CLIO("setType")=X
 . S X=$G(HMPC("SUPP_PAGE","ACTIVATED_DATE_TIME")) S:X CLIO("setStart")=$$JSONDT^HMPUTILS(X)
 . S X=$G(HMPC("SUPP_PAGE","DEACTIVATED_DATE_TIME")) S:X CLIO("setStop")=$$JSONDT^HMPUTILS(X)
 S CLIO("statusCode")="urn:va:observation-status:complete",CLIO("statusName")="complete"
 S LOC=$G(HMPC("HOSPITAL_LOCATION_ID","I")),FAC=$$FAC^HMPD(LOC)
 S CLIO("locationUid")=$$SETUID^HMPUTILS("location",,LOC)
 S CLIO("locationName")=$G(HMPC("HOSPITAL_LOCATION_ID","E"))
 D FACILITY^HMPUTILS(FAC,"CLIO")
 S X=$G(HMPC("COMMENT","E")) S:$L(X) CLIO("comment")=X
 S CLIO("lastUpdateTime")=$$EN^HMPSTMP("obs") ; RHL 20141231
 S CLIO("stampTime")=CLIO("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("obs",CLIO("uid"),CLIO("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("CLIO","obs")
 Q
