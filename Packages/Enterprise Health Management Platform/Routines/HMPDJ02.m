HMPDJ02 ;ASMR/MKB/JD,CK,CPC,PB - Problems,Allergies,Vitals ;Aug 23, 2016 09:56:26
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2,3**;Sep 02, 2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^PXRMINDX                     4290
 ; ^SC                          10040
 ; ^AUPNPROB                     2727 (where items not available from GMPLUTL2)
 ; DIC                           2051
 ; DIQ                           2056
 ; GMPLUTL2                      2741
 ; GMRADPT                      10099
 ; GMRAOR2                       2422
 ; GMRVUT0,^UTILITY($J           1446
 ; GMVGETQL                      5048
 ; GMVGETVT                      5047
 ; GMVUTL                        5046
 ; ICDEX                         5747
 ; XLFSTR                       10104
 ; XUAF4                         2171
 ; ^AUPNVSIT(                    2028
 ; ^TIU(8925,DA,0                6154
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 ;
 Q
 ;
GMPL1(ID,POVLST) ; -- problem
 N HMPL,PROB,X,I,DATE,USER,FAC,LEXS
 D DETAIL^GMPLUTL2(ID,.HMPL) Q:'$D(HMPL)  ;doesn't exist
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the problem domain"
 ;
 S PROB("uid")=$$SETUID^HMPUTILS("problem",DFN,ID),PROB("localId")=ID
 S PROB("problemText")=$G(HMPL("NARRATIVE"))
 S DATE=$P($G(HMPL("ENTERED")),U)
 S:$L(DATE) DATE=$$DATE^HMPDGMPL(DATE),PROB("entered")=$$JSONDT^HMPUTILS(DATE)
 S X=$G(HMPL("DIAGNOSIS")) I $L(X) D
 . N ICD9ZN,DIAG,SCTCODE
 . I DATE'>0 S DATE=DT
 . S ICD9ZN=$$ICDDX^ICDEX(X,DATE),DIAG=$S($P($G(ICD9ZN),U,4)'="":$P(ICD9ZN,U,4),1:X) ;Sep 1, 2016 - PB - DE5033
 . ; BEGIN MOD ASF 09/8/15 US 9239 DE 2082
 . ; Only set icdCode and icdName if it is ICD9 (ICD10 is only available in codes array)
 . I HMPL("CSYS")="ICD" S PROB("icdCode")=$$SETNCS^HMPUTILS("icd",HMPL("DIAGNOSIS")),PROB("icdName")=DIAG
 . ; Create codes array for both ICD9 or ICD10
 . S PROB("codes",1,"code")=HMPL("DIAGNOSIS")
 . S PROB("codes",1,"display")=$S(HMPL("CSYS")="ICD":DIAG,HMPL("CSYS")="10D":HMPL("ICDD"))
 . S PROB("codes",1,"system")=$S(HMPL("CSYS")="ICD":"urn:oid:2.16.840.1.113883.6.42",HMPL("CSYS")="10D":"urn:oid:2.16.840.1.113883.6.3",1:"codesystem error")
 . ;SNOMED CT codes
 . S SCTCODE=HMPL("SCTC") ;DE4685 ;9000011,80001 SNOMED CT CONCEPT CODE
 . D:SCTCODE EN^LEXCODE(SCTCODE) ; ICR 1614
 . I $D(LEXS("SCT",1)) D
 . . S PROB("codes",2,"code")=SCTCODE
 . . S PROB("codes",2,"code","\s")="" ; Ensure code is sent as a string
 . . S PROB("codes",2,"display")=$P(LEXS("SCT",1),U,2)
 . . S PROB("codes",2,"system")="http://snomed.info/sct"
 . ; END MOD ASF US 9239 DE 2082
 ;Get the internal date from ^AUPNPROB so the imprecise date can be converted properly
 ;JD - 2/1/16 - DE3548
 S X=$$GET1^DIQ(9000011,ID_",",.01,"I") S:$L(X) PROB("lexiconCode")=X  ; DE4680 May 11, 2016 - added lexiconCode to JDS
 S X=$$GET1^DIQ(9000011,ID_",",.13,"I") S:$L(X) PROB("onset")=$$JSONDT^HMPUTILS(X) ;retrieve internal value for proper date format
 S X=$G(HMPL("MODIFIED")) S:$L(X) X=$$DATE^HMPDGMPL(X),PROB("updated")=$$JSONDT^HMPUTILS(X)
 S X=$G(HMPL("STATUS")) I $L(X) D
 . S PROB("statusName")=X,X=$E(X)
 . S X=$S(X="A":55561003,X="I":73425007,1:"")
 . S PROB("statusCode")=$$SETNCS^HMPUTILS("sct",X)
 ;S X=$G(HMPL("PRIORITY")) I X]"" D
 S X=$$GET1^DIQ(9000011,ID_",",1.14,"I") I X]"" D  ;DE3988 take directly from the file regardless of status
 . S X=$S(X="C":"chronic",X="A":"acute",1:"")
 . I X'="" S PROB("acuityName")=X,PROB("acuityCode")=$$SETVURN^HMPUTILS("prob-acuity",$E(X))
 S X=$$GET1^DIQ(9000011,ID_",",1.07,"I") S:X PROB("resolved")=$$JSONDT^HMPUTILS(X)
 S X=$P(HMPL("ENTERED"),U,2) S:$L(X) PROB("enteredBy")=X  ; DE5096 June 24, 2016 - add addt'l problem fields to JDS
 S X=$P(HMPL("RECORDED"),U,2) S:$L(X) PROB("recordedBy")=X  ; DE5096 June 24, 2016
 S X=$$GET1^DIQ(9000011,ID_",",1.09,"I") S:$L(X) PROB("recordedOn")=$$JSONDT^HMPUTILS(X)  ; DE5096 July 1, 2016 
 S X=$$GET1^DIQ(9000011,ID_",",1.02,"I")
 S:X="P" PROB("unverified")="false",PROB("removed")="false"
 S:X="T" PROB("unverified")="true",PROB("removed")="false"
 S:X="H" PROB("unverified")="false",PROB("removed")="true"
 S X=$G(HMPL("SC")),X=$S(X="YES":"true",X="NO":"false",1:"")  ; DE3918, Mar 2, 2016
 S:$L(X) PROB("serviceConnected")=X
 S X=$G(HMPL("PROVIDER")) I $L(X) D
 . S PROB("providerName")=X,X=$$GET1^DIQ(9000011,ID_",",1.05,"I")
 . S PROB("providerUid")=$$SETUID^HMPUTILS("user",,+X)
 S X=$$GET1^DIQ(9000011,ID_",",1.06) S:$L(X) PROB("service")=X
 S X=$G(HMPL("CLINIC")) I $L(X) D
 . S PROB("locationName")=X
 . N LOC S LOC=+$$FIND1^DIC(44,,"QX",X)
 . S:LOC PROB("locationUid")=$$SETUID^HMPUTILS("location",,LOC)
 S X=+$$GET1^DIQ(9000011,ID_",",.06,"I")
 S:X FAC=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S FAC=$$FAC^HMPD ;local stn#^name
 D FACILITY^HMPUTILS(FAC,"PROB")
 S I=0 F  S I=$O(HMPL("COMMENT",I)) Q:I<1  D
 . S X=$G(HMPL("COMMENT",I))
 . S USER=$$VA200^HMPDGMPL($P(X,U,2)),DATE=$$DATE^HMPDGMPL($P(X,U))
 . S PROB("comments",I,"noteCounter")=I  ; Feb 24, 2016 - US12724
 . S PROB("comments",I,"enteredByCode")=$$SETUID^HMPUTILS("user",,+USER)
 . S PROB("comments",I,"enteredByName")=$P(X,U,2)
 . S PROB("comments",I,"entered")=$$JSONDT^HMPUTILS(DATE)
 . S PROB("comments",I,"comment")=$P(X,U,3)
 I $D(POVLST) D GMPLVST(ID,"PROB",.POVLST)  ;JL;add encounter information.
 ;== Treatment attributes - Added on 1/4/16 - JD - US12358
 ;Modified 1/8/16 - JD - US12358
 ;Guarding against direct sets into ^AUPNPROB in RPC: "ORQQPL ADD SAVE" by checking for "Y" and "N".
 S X=$$UP^XLFSTR($$GET1^DIQ(9000011,ID_",",1.11,"I"))
 S:$L(X) PROB("agentOrangeExposure")=$S(X=1:"YES",$E(X)="Y":"YES",X=0:"NO",$E(X)="N":"NO",1:X)
 S X=$$UP^XLFSTR($$GET1^DIQ(9000011,ID_",",1.12,"I"))
 S:$L(X) PROB("radiationExposure")=$S(X=1:"YES",$E(X)="Y":"YES",X=0:"NO",$E(X)="N":"NO",1:X)
 S X=$$UP^XLFSTR($$GET1^DIQ(9000011,ID_",",1.13,"I"))
 S:$L(X) PROB("persianGulfExposure")=$S(X=1:"YES",$E(X)="Y":"YES",X=0:"NO",$E(X)="N":"NO",1:X)
 S X=$$UP^XLFSTR($$GET1^DIQ(9000011,ID_",",1.15,"I"))
 S:$L(X) PROB("headNeckCancer")=$S(X=1:"YES",$E(X)="Y":"YES",X=0:"NO",$E(X)="N":"NO",1:X)
 S X=$$UP^XLFSTR($$GET1^DIQ(9000011,ID_",",1.16,"I"))
 S:$L(X) PROB("militarySexualTrauma")=$S(X=1:"YES",$E(X)="Y":"YES",X=0:"NO",$E(X)="N":"NO",1:X)
 S X=$$UP^XLFSTR($$GET1^DIQ(9000011,ID_",",1.17,"I"))
 S:$L(X) PROB("combatVeteran")=$S(X=1:"YES",$E(X)="Y":"YES",X=0:"NO",$E(X)="N":"NO",1:X)
 S X=$$UP^XLFSTR($$GET1^DIQ(9000011,ID_",",1.18,"I"))
 S:$L(X) PROB("shipboardHazard")=$S(X=1:"YES",$E(X)="Y":"YES",X=0:"NO",$E(X)="N":"NO",1:X)
 ;==
 S PROB("lastUpdateTime")=$$EN^HMPSTMP("problem")
 S PROB("stampTime")=PROB("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("problem",PROB("uid"),PROB("stampTime")) Q:HMPMETA=1  ;US11019/US6734
 D ADD^HMPDJ("PROB","problem")
 Q
 ;
GMPLVST(ID,Y,POVLST)  ; --- JL;associate problem with visit and notes
 Q:'$G(ID)!'$G(^AUPNPROB(ID,0))!'$D(POVLST)  ;invalid id or no data
 N ICDCODE
 S ICDCODE=$$CODEC^ICDEX(80,$$GET1^DIQ(9000011,ID_",",.01,"I")) Q:ICDCODE=-1  ;invalid icdcode Sep 1, 2016 - PB - DE5033
 Q:$D(POVLST(ICDCODE))=0
 N IDX,VCNT,NCNT,DIEN,VIEN,FAC,STCODE
 S IDX="",VCNT=0,NCNT=0 F  S IDX=$O(POVLST(ICDCODE,IDX)) Q:IDX=""  D
 . S VCNT=VCNT+1
 . S VIEN=+$G(POVLST(ICDCODE,IDX)),FAC=$$FAC^HMPDJ04(VIEN),STCODE=$$STCODE^HMPDJ04(VIEN)
 . I FAC D FACILITY^HMPUTILS(FAC,Y_"(""encounters"","_VCNT_")")  ; facility info
 . I STCODE D STOPCODE^HMPDJ04(STCODE,Y_"(""encounters"","_VCNT_")") ; stop code
 . S @Y@("encounters",VCNT,"dateTime")=$$JSONDT^HMPUTILS($$DATE^HMPDGMPL(+IDX))
 . S @Y@("encounters",VCNT,"visitUid")=$$SETUID^HMPUTILS("visit",DFN,VIEN)
 . N ENINFO S ENINFO=$G(POVLST(ICDCODE,IDX))
 . S DIEN=+$P(ENINFO,U,2)
 . ;W "DIEN is "_DIEN,!
 . I DIEN D
 . . S NCNT=NCNT+1
 . . ; extract the extra data from the document
 . . N DOCINFO S DOCINFO=$E(ENINFO,$F($G(ENINFO),U),$L(ENINFO))
 . . N OUTPUT S OUTPUT="" D EN1^HMPDJ08(DOCINFO,3,.OUTPUT)
 . . N NAME F NAME="documentTypeName","entered","summary","facilityName","authorDisplayName" D
 . . . S:$D(OUTPUT(NAME)) @Y@("documents",NCNT,NAME)=$G(OUTPUT(NAME))
 . . S @Y@("documents",NCNT,"documentUid")=$$SETUID^HMPUTILS("document",DFN,DIEN)
 Q
 ;
GMPLPOV(DFNN,POVLST,DONTKILL) ; -- JL;All problem of visit related to the patient from V POV file
 ;INPUT: Patient's DFN
 ;OUTPUT: Patient's VISIT list in the format of
 ;        OUTPUT(DIAGNOSIS,DATATIME)="VISITIEN"
 ;
 Q:'$G(DFNN)
 N INVVST
 K:'DONTKILL POVLST ; clear the output
 ; Query V POV(^AUPNVPOV() by using "AA" Cross Reference.
 S INVVST="",CURVST="" F  S INVVST=$O(^AUPNVPOV("AA",DFNN,INVVST)) Q:INVVST=""  D
 . N CURVST,DIEN
 . S CURVST=INVVST,DIEN="" F  S DIEN=$O(^AUPNVPOV("AA",DFNN,CURVST,DIEN)) Q:DIEN=""  D
 . . N ICDIEN,PVISIT
 . . S ICDIEN=+$P(^AUPNVPOV(DIEN,0),U,1),PVISIT=$P(^AUPNVPOV(DIEN,0),U,3)
 . . N VISITDT
 . . S VISITDT=+$G(^AUPNVSIT(PVISIT,0)) Q:'$L(VISITDT)  ;quit if no visit is found, bad data entry.
 . . N ICDCODE,VIEN
 . . S ICDCODE=$$CODEC^ICDEX(80,ICDIEN) Q:ICDCODE=-1  ;convert to ICD code, quit if not valid Sep 1, 2016 - PB - DE5033
 . . I $D(POVLST(ICDCODE,VISITDT))'=0 D  Q
 . . . S VIEN=$$GETVIEN^HMPDJ02A(DFNN,VISITDT)
 . . . ; W:VIEN=-1 "Can not find VISIT IEN for "_VISITDT,!
 . . . S:VIEN'=-1 POVLST(ICDCODE,VISITDT)=VIEN
 Q
 ;
DIAGLIST(DIAGS,DFN,ORDATE,ORPRCNT) ;BL,JL; get list diagnosis on past notes
 S:'+$G(ORDATE) ORDATE=DT
 S:'+$G(ORPRCNT) ORPRCNT=1
 ;Use TIU DOCUMENTS BY CONTEXT to retrieve all notes associated with patient (CONTEXT^TIUSRVLO)
 K ENC,DIAGCODE,CNT,DIAG,DIAGNUM,DIAGLINE,ENCNUM,LINE,IEN,CLASS,CONTEXT,EARLY,LATE,PERSON,OCCLIM,SEQUENCE,SHOWADD,INCUND,LSTNUM,NOTEINFO
 K NEWCNT,OLDLST,DIAGCNT
 S CLASS=3,CONTEXT=1,EARLY=-1,LATE=-1,PERSON=0,OCCLIM=0,SEQUENCE="D",SHOWADD=0,INCUND=0,OLDLST=""
 ;TAKE EXISTING LIST FROM ENCOUNTER CALL AND PRESERVE TO BE APPENDED AFTERWARD
 K DIAGS S DIAGS=""
 D CONTEXT^TIUSRVLO(.DIAGS,CLASS,CONTEXT,DFN,EARLY,LATE,PERSON,OCCLIM,SEQUENCE,SHOWADD,INCUND)
 M DIAGS=^TMP("TIUR",$J)
 ;Go through notes list extract diagnosis associated with each encounter to previous problem list
 S LSTNUM=""
 ;THIS CALL WILL EXTRACT ALL THE VISIT INFORMATION TO ^TMP(PXKENC,$J,VISIT)
 N VIEN
 F  S LSTNUM=$O(DIAGS(LSTNUM)) Q:LSTNUM=""  D
 . N HMPV
 . S NOTEINFO=""
 . S IEN=$P(DIAGS(LSTNUM),"^",1)
 . ;DE6877 - 21 Jan 17 - PB next two lines of code check to see if the Visit/Admit Date&Time and/or Patient Name fields are missing for the visit. if either are missing processing this record stops.
 . S HMPV=$P($G(^TIU(8925,IEN,0)),U,3)
 . I $G(HMPV)>0 Q:$$VSTIEN^HMPDJ02A(HMPV)>0
 . D PCE4NOTE^ORWPCE3(.NOTEINFO,IEN,DFN)
 . S CNT=0,DIAGCNT=0
 . F  S CNT=$O(NOTEINFO(CNT)) Q:CNT=""  D
 . . Q:$P(NOTEINFO(CNT),"^",1)'["POV"
 . . S DIAGCNT=DIAGCNT+1
 . . S VISITDT=$P($G(NOTEINFO(2)),U,3)  ; get the visit datetime
 . . S ICDCODE=$P(NOTEINFO(CNT),U,2)  ; get the diagnosis code
 . . I $D(ENC(ICDCODE,VISITDT))=0 D
 . . . S VIEN=$$GETVIEN^HMPDJ02A(DFN,VISITDT)
 . . . ;W:VIEN=-1 "Can not find Visit ID for "_NOTEINFO(CNT),!
 . . . S:VIEN'=-1 ENC(ICDCODE,VISITDT)=VIEN_U_$G(DIAGS(LSTNUM)) ;  add to list only if visit ien is valid
 ; KILL DIAGS BECAUSE IT NOW CONTAINS NOTE INFO
 K DIAGS
 M DIAGS=ENC
 ;CLEAN UP ARRAYS
 K NOTEINFO,ENC,DIAG,^TMP("TIUR",$J)
 D GMPLPOV(DFN,.DIAGS,1)  ; Also loop thru V POV file to find extra encounter
 Q
 ;
GMRA1(ID) ; -- allergy/reaction GMRAL(ID)
 N GMRA,HMPY,REAC,X,Y,I,USER,CMMT
 S GMRA=$G(GMRAL(ID)) D EN1^GMRAOR2(ID,"HMPY")
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the allergy domain"
 ;
 S X=$P(HMPY,U,10) I $L(X) S X=$$DATE^HMPDGMRA(X) Q:X<HMPSTART  Q:X>HMPSTOP  S REAC("entered")=$$JSONDT^HMPUTILS(X)
 S X=$$FAC^HMPD D FACILITY^HMPUTILS(X,"REAC")
 S REAC("kind")="Allergy / Adverse Reaction"
 S REAC("localId")=ID,REAC("uid")=$$SETUID^HMPUTILS("allergy",DFN,ID)
 S (REAC("summary"),REAC("products",1,"name"))=$P(HMPY,U) I $P(GMRA,U,9) D
 . S X=$P(GMRA,U,9),REAC("reference")=X
 . S Y=+$P(X,"(",2) I 'Y,X["PSDRUG" S Y=50
 . S I=$$VUID^HMPD(+X,Y),REAC("products",1,"vuid")=$$SETVURN^HMPUTILS("vuid",I)
 S X=$P(HMPY,U,2) S:$L(X) REAC("originatorName")=X
 S REAC("historical")=$S($E($P(HMPY,U,5))="H":"true",1:"false")
 S X=$P(HMPY,U,6) S:$L(X) REAC("mechanism")=X
 S X=$P(HMPY,U,7) S:$L(X) REAC("typeName")=X
 ; REAC("adverseEventTypeName")=$P(HMPY,U,7)_" "_$P(HMPY,U,6) ;TYPE_MECH
 I $P(HMPY,U,4)="VERIFIED",$P(HMPY,U,9) D
 . S REAC("verified")=$$JSONDT^HMPUTILS($P(HMPY,U,9))
 . S REAC("verifierName")=$P(HMPY,U,8)
 ; severity
 S I=0 F  S I=$O(HMPY("O",I)) Q:I<1  D
 . S X=$G(HMPY("O",I))
 . S REAC("observations",I,"date")=$$JSONDT^HMPUTILS(+X)
 . S REAC("observations",I,"severity")=$P(X,U,2)
 ; reactions
 S I=0 F  S I=$O(GMRAL(ID,"S",I)) Q:I<1  D
 . S X=$G(GMRAL(ID,"S",I))
 . S REAC("reactions",I,"name")=$P(X,";")
 . S Y=$$VUID^HMPD(+$P(X,";",2),120.83)
 . S REAC("reactions",I,"vuid")=$$SETVURN^HMPUTILS("vuid",Y)
 ; drug classes
 S I=0 F  S I=$O(HMPY("V",I)) Q:I<1  D
 . S X=$G(HMPY("V",I))
 . S REAC("drugClasses",I,"code")=$P(X,U)
 . S REAC("drugClasses",I,"name")=$P(X,U,2)
 S I=0 F  S I=$O(HMPY("C",I)) Q:I<1  D
 . S X=$G(HMPY("C",I)),USER=$$VA200^HMPDGMPL($P(X,U,3))
 . S REAC("comments",I,"enteredByUid")=$$SETUID^HMPUTILS("user",,+USER)
 . S REAC("comments",I,"enteredByName")=$P(X,U,3)
 . S REAC("comments",I,"entered")=$$JSONDT^HMPUTILS(+X)
 . K CMMT M CMMT=HMPY("C",I)
 . S REAC("comments",I,"comment")=$$STRING^HMPD(.CMMT)
 I GMRA="" S REAC("removed")="true" ;entered in error
 ; next
 S REAC("lastUpdateTime")=$$EN^HMPSTMP("allergy")
 S REAC("stampTime")=REAC("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("allergy",REAC("uid"),REAC("stampTime")) Q:HMPMETA=1  ;US11019/US6734
 D ADD^HMPDJ("REAC","allergy")
 Q
 ;
NKA ; -- no assessment or NKA [GMRAL=0 or ""]
 N REAC,X
 S X=$G(^GMR(120.86,DFN,0)) Q:GMRAL=""!'$P(X,U,2)
 S REAC("uid")=$$SETUID^HMPUTILS("obs",DFN,"120.86;"_DFN)
 S REAC("typeCode")="urn:sct:160244002"
 S REAC("typeName")="No known allergies"
 S X=$$FAC^HMPD D FACILITY^HMPUTILS(X,"REAC")
 D ADD^HMPDJ("REAC","allergy")
 Q
 ;
GMV1(ID) ; -- vital/measurement ^UTILITY($J,"GMRVD",HMPIDT,HMPTYP,ID)
 N VIT,HMPY,X0,TYPE,LOC,FAC,X,Y,MRES,MUNT,HIGH,LOW,I
 D GETREC^GMVUTL(.HMPY,ID,1) S X0=$G(HMPY(0))
 ; GMRVUT0 returns CLiO data with a pseudo-ID >> get real ID
 I X0="",$G(HMPIDT),$D(HMPTYP) D  ;[from HMPDJ0]
 . N GMRVD S GMRVD=$G(^UTILITY($J,"GMRVD",HMPIDT,HMPTYP,ID))
 . S ID=$O(^PXRMINDX(120.5,"PI",DFN,$P(GMRVD,U,3),+GMRVD,""))
 . I $L(ID) D GETREC^GMVUTL(.HMPY,ID,1) S X0=$G(HMPY(0))
 Q:X0=""
 ;
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the vitals domain"
 S VIT("localId")=ID,VIT("kind")="Vital Sign"
 S VIT("uid")=$$SETUID^HMPUTILS("vital",DFN,ID)
 S VIT("observed")=$$JSONDT^HMPUTILS(+X0)
 S VIT("resulted")=$$JSONDT^HMPUTILS(+$P(X0,U,4))
 S TYPE=$$FIELD^GMVGETVT(+$P(X0,U,3),2)
 S VIT("displayName")=TYPE
 S VIT("typeName")=$$FIELD^GMVGETVT($P(X0,U,3),1)
 S VIT("typeCode")="urn:va:vuid:"_$$FIELD^GMVGETVT($P(X0,U,3),4)
 S X=$P(X0,U,8),VIT("result")=X
 S VIT("units")=$$UNIT^HMPDGMV(TYPE),(MRES,MUNT)=""
 I TYPE="T"  S:X=+X MUNT="C",MRES=$J(X-32*5/9,0,1) ;EN1^GMRVUTL
 I TYPE="HT" S MUNT="cm",MRES=$J(2.54*X,0,2)  ;EN2^GMRVUTL
 I TYPE="WT" S MUNT="kg",MRES=$J(X/2.2,0,2)   ;EN3^GMRVUTL
 I TYPE="CG" S MUNT="cm",MRES=$J(2.54*X,0,2)
 S:MRES VIT("metricResult")=MRES,VIT("metricUnits")=MUNT
 S X=$$RANGE^HMPDGMV(TYPE) I $L(X) S VIT("high")=$P(X,U),VIT("low")=$P(X,U,2)
 S VIT("summary")=VIT("typeName")_" "_VIT("result")_" "_VIT("units")
 F I=1:1:$L(HMPY(5),U) S X=$P(HMPY(5),U,I) I X D
 . S VIT("qualifiers",I,"name")=$$FIELD^GMVGETQL(X,1)
 . S VIT("qualifiers",I,"vuid")=$$FIELD^GMVGETQL(X,3)
 ;US4338 - add pulse ox qualifier if it exists. name component is required. vuid is not per Thomas Loth
 I $P(X0,U,10) S VIT("qualifiers",I+1,"name")=$P(X0,U,10)
 I $G(HMPY(2)) D
 . S VIT("removed")="true"        ;entered in error
 . S X=$$GET1^DIQ(120.506,"1,"_ID_",",.01,"E") S:X VIT("reasonEnteredInError")=X
 . S X=$$GET1^DIQ(120.506,"1,"_ID_",",.02,"I") S:X VIT("dateEnteredInError")=$$JSONDT^HMPUTILS(X)
 S LOC=+$P(X0,U,5),FAC=$$FAC^HMPD(LOC)
 S VIT("locationUid")=$$SETUID^HMPUTILS("location",,LOC)
 S VIT("locationName")=$S(LOC:$P($G(^SC(LOC,0)),U),1:"unknown")
 N USERID S USERID=$P(HMPY(0),U,6)
 I $G(USERID) D
 . S VIT("enteredByUid")=$$SETUID^HMPUTILS("user",,USERID)
 . S VIT("enteredByName")=$P($G(^VA(200,USERID,0)),U,1)
 D FACILITY^HMPUTILS(FAC,"VIT")
 S VIT("lastUpdateTime")=$$EN^HMPSTMP("vital")
 S VIT("stampTime")=VIT("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("vital",VIT("uid"),VIT("stampTime")) Q:HMPMETA=1  ;US11019/US6734
 D ADD^HMPDJ("VIT","vital")
 Q
 ;
HMP(COLL) ; -- HMP Patient Objects
 N ID I $L($G(HMPID)) D  Q
 . S ID=+HMPID I 'ID S ID=+$O(^HMP(800000.1,"B",HMPID,0)) ;IEN or UID
 . D:ID HMP1(800000.1,ID)
 Q:$G(COLL)=""  ;error
 S ID=0 F  S ID=$O(^HMP(800000.1,"C",DFN,COLL,ID)) Q:ID<1  D HMP1(800000.1,ID)
 Q
HMP1(FNUM,ID) ; -- [patient] object
 N I,X,HMPY
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=$G(DFN)
 S ERRMSG="A problem occurred retreiving record "_ID_" for the HMP domain"
 S I=0 F  S I=$O(^HMP(FNUM,ID,1,I)) Q:I<1  S X=$G(^(I,0)),HMPY(I)=X
 I $D(HMPY) D  ;already encoded JSON
 . S HMPI=HMPI+1 S:HMPI>1 @HMP@(HMPI,.3)=","
 . M @HMP@(HMPI)=HMPY
 . ; -- chunk data if from DQINIT^HMPDJFSP ; i.e. HMPCHNK defined ;*S68-JCH*
 . D CHNKCHK^HMPDJFSP(.HMP,.HMPI) ;*S68-JCH*
 Q
