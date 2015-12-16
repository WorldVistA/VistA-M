VPRDJ02 ;SLC/MKB -- Problems,Allergies,Vitals ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^PXRMINDX                     4290
 ; ^SC                          10040
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
 ;
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
GMPL1(ID) ; -- problem
 N VPRL,PROB,X,I,DATE,USER,FAC
 D DETAIL^GMPLUTL2(ID,.VPRL) Q:'$D(VPRL)  ;doesn't exist
 ;
 S PROB("uid")=$$SETUID^VPRUTILS("problem",DFN,ID),PROB("localId")=ID
 S PROB("problemText")=$G(VPRL("NARRATIVE"))
 S DATE=$P($G(VPRL("ENTERED")),U)
 S:$L(DATE) DATE=$$DATE^VPRDGMPL(DATE),PROB("entered")=$$JSONDT^VPRUTILS(DATE)
 S X=$G(VPRL("DIAGNOSIS")) I $L(X) D
 . N ICD9ZN,DIAG,SYS
 . I DATE'>0 S DATE=DT
 . S ICD9ZN=$$ICDDX^ICDEX(X,DATE,,"E"),DIAG=$S($P($G(ICD9ZN),U,4)'="":$P(ICD9ZN,U,4),1:X)
 . S SYS=$$LOW^XLFSTR($G(VPRL("CSYS"),"ICD")) ;icd or 10d
 . S PROB("icdCode")=$$SETNCS^VPRUTILS(SYS,X),PROB("icdName")=DIAG
 S X=$G(VPRL("ONSET")) S:$L(X) X=$$DATE^VPRDGMPL(X),PROB("onset")=$$JSONDT^VPRUTILS(X)
 S X=$G(VPRL("MODIFIED")) S:$L(X) X=$$DATE^VPRDGMPL(X),PROB("updated")=$$JSONDT^VPRUTILS(X)
 S X=$G(VPRL("STATUS")) I $L(X) D
 . S PROB("statusName")=X,X=$E(X)
 . S X=$S(X="A":55561003,X="I":73425007,1:"")
 . S PROB("statusCode")=$$SETNCS^VPRUTILS("sct",X)
 S X=$G(VPRL("PRIORITY")) I X]"" D
 . S X=$$LOW^XLFSTR(X),PROB("acuityName")=X
 . S PROB("acuityCode")=$$SETVURN^VPRUTILS("prob-acuity",$E(X))
 S X=$$GET1^DIQ(9000011,ID_",",1.07,"I") S:X PROB("resolved")=$$JSONDT^VPRUTILS(X)
 S X=$$GET1^DIQ(9000011,ID_",",1.02,"I")
 S:X="P" PROB("unverified")="false",PROB("removed")="false"
 S:X="T" PROB("unverified")="true",PROB("removed")="false"
 S:X="H" PROB("unverified")="false",PROB("removed")="true"
 S X=$G(VPRL("SC")),X=$S(X="YES":"",X="NO":"false",1:"")
 S:$L(X) PROB("serviceConnected")=X
 S X=$G(VPRL("PROVIDER")) I $L(X) D
 . S PROB("providerName")=X,X=$$GET1^DIQ(9000011,ID_",",1.05,"I")
 . S PROB("providerUid")=$$SETUID^VPRUTILS("user",,+X)
 S X=$$GET1^DIQ(9000011,ID_",",1.06) S:$L(X) PROB("service")=X
 S X=$G(VPRL("CLINIC")) I $L(X) D
 . S PROB("locationName")=X
 . N LOC S LOC=+$$FIND1^DIC(44,,"QX",X)
 . S:LOC PROB("locationUid")=$$SETUID^VPRUTILS("location",,LOC)
 S X=+$$GET1^DIQ(9000011,ID_",",.06,"I")
 S:X FAC=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S FAC=$$FAC^VPRD ;local stn#^name
 D FACILITY^VPRUTILS(FAC,"PROB")
 S I=0 F  S I=$O(VPRL("COMMENT",I)) Q:I<1  D
 . S X=$G(VPRL("COMMENT",I))
 . S USER=$$VA200^VPRDGMPL($P(X,U,2)),DATE=$$DATE^VPRDGMPL($P(X,U))
 . S PROB("comments",I,"enteredByCode")=$$SETUID^VPRUTILS("user",,+USER)
 . S PROB("comments",I,"enteredByName")=$P(X,U,2)
 . S PROB("comments",I,"entered")=$$JSONDT^VPRUTILS(DATE)
 . S PROB("comments",I,"comment")=$P(X,U,3)
 D ADD^VPRDJ("PROB","problem")
 Q
 ;
GMRA1(ID) ; -- allergy/reaction GMRAL(ID)
 N GMRA,VPRY,REAC,X,Y,I
 S GMRA=$G(GMRAL(ID)) D EN1^GMRAOR2(ID,"VPRY")
 ;
 S X=$P(VPRY,U,10) I $L(X) S X=$$DATE^VPRDGMRA(X) Q:X<VPRSTART  Q:X>VPRSTOP  S REAC("entered")=$$JSONDT^VPRUTILS(X)
 S X=$$FAC^VPRD D FACILITY^VPRUTILS(X,"REAC")
 S REAC("kind")="Allergy / Adverse Reaction"
 S REAC("localId")=ID,REAC("uid")=$$SETUID^VPRUTILS("allergy",DFN,ID)
 S (REAC("summary"),REAC("products",1,"name"))=$P(VPRY,U) I $P(GMRA,U,9) D
 . S X=$P(GMRA,U,9),REAC("reference")=X
 . S Y=+$P(X,"(",2) I 'Y,X["PSDRUG" S Y=50
 . S I=$$VUID^VPRD(+X,Y),REAC("products",1,"vuid")=$$SETVURN^VPRUTILS("vuid",I)
 S REAC("historical")=$S($E($P(VPRY,U,5))="H":"true",1:"false")
 ; REAC("adverseEventTypeName")=$P(VPRY,U,7)_" "_$P(VPRY,U,6) ;TYPE_MECH
 I $P(VPRY,U,4)="VERIFIED",$P(VPRY,U,9) S REAC("verified")=$$JSONDT^VPRUTILS($P(VPRY,U,9))
 ; reactions
 S I=0 F  S I=$O(GMRAL(ID,"S",I)) Q:I<1  D
 . S X=$G(GMRAL(ID,"S",I))
 . S REAC("reactions",I,"name")=$P(X,";")
 . S Y=$$VUID^VPRD(+$P(X,";",2),120.83)
 . S REAC("reactions",I,"vuid")=$$SETVURN^VPRUTILS("vuid",Y)
 I GMRA="" S REAC("removed")="true" ;entered in error
 D ADD^VPRDJ("REAC","allergy")
 Q
 ;
NKA ; -- no assessment or NKA [GMRAL=0 or ""]
 N REAC,X
 S REAC("assessment")=$S(GMRAL=0:"nka",1:"not done")
 S X=$$FAC^VPRD D FACILITY^VPRUTILS(X,"REAC")
 D ADD^VPRDJ("REAC","allergy")
 Q
 ;
GMV1(ID) ; -- vital/measurement ^UTILITY($J,"GMRVD",VPRIDT,VPRTYP,ID)
 N VIT,VPRY,X0,TYPE,LOC,FAC,X,Y,MRES,MUNT,HIGH,LOW,I
 D GETREC^GMVUTL(.VPRY,ID,1) S X0=$G(VPRY(0))
 ; GMRVUT0 returns CLiO data with a pseudo-ID >> get real ID
 I X0="",$G(VPRIDT),$D(VPRTYP) D  ;[from VPRDJ0]
 . N GMRVD S GMRVD=$G(^UTILITY($J,"GMRVD",VPRIDT,VPRTYP,ID))
 . S ID=$O(^PXRMINDX(120.5,"PI",DFN,$P(GMRVD,U,3),+GMRVD,""))
 . I $L(ID) D GETREC^GMVUTL(.VPRY,ID,1) S X0=$G(VPRY(0))
 Q:X0=""
 ;
 S VIT("localId")=ID,VIT("kind")="Vital Sign"
 S VIT("uid")=$$SETUID^VPRUTILS("vital",DFN,ID)
 S VIT("observed")=$$JSONDT^VPRUTILS(+X0)
 S VIT("resulted")=$$JSONDT^VPRUTILS(+$P(X0,U,4))
 S TYPE=$$FIELD^GMVGETVT(+$P(X0,U,3),2)
 S VIT("displayName")=TYPE
 S VIT("typeName")=$$FIELD^GMVGETVT($P(X0,U,3),1)
 S VIT("typeCode")="urn:va:vuid:"_$$FIELD^GMVGETVT($P(X0,U,3),4)
 S X=$P(X0,U,8),VIT("result")=X
 S VIT("units")=$$UNIT^VPRDGMV(TYPE),(MRES,MUNT)=""
 I TYPE="T"  S MUNT="C",MRES=$J(X-32*5/9,0,1) ;EN1^GMRVUTL
 I TYPE="HT" S MUNT="cm",MRES=$J(2.54*X,0,2)  ;EN2^GMRVUTL
 I TYPE="WT" S MUNT="kg",MRES=$J(X/2.2,0,2)   ;EN3^GMRVUTL
 I TYPE="CG" S MUNT="cm",MRES=$J(2.54*X,0,2)
 S:MRES VIT("metricResult")=MRES,VIT("metricUnits")=MUNT
 S X=$$RANGE^VPRDGMV(TYPE) I $L(X) S VIT("high")=$P(X,U),VIT("low")=$P(X,U,2)
 S VIT("summary")=VIT("typeName")_" "_VIT("result")_" "_VIT("units")
 F I=1:1:$L(VPRY(5),U) S X=$P(VPRY(5),U,I) I X D
 . S VIT("qualifiers",I,"name")=$$FIELD^GMVGETQL(X,1)
 . S VIT("qualifiers",I,"vuid")=$$FIELD^GMVGETQL(X,3)
 I $G(VPRY(2)) S VIT("removed")="true"        ;entered in error
 S LOC=+$P(X0,U,5),FAC=$$FAC^VPRD(LOC)
 S VIT("locationUid")=$$SETUID^VPRUTILS("location",,LOC)
 S VIT("locationName")=$S(LOC:$P($G(^SC(LOC,0)),U),1:"unknown")
 D FACILITY^VPRUTILS(FAC,"VIT")
 D ADD^VPRDJ("VIT","vital")
 Q
 ;
VPR(COLL) ; -- VPR Patient Objects
 N ID I $L($G(VPRID)) D  Q
 . S ID=+VPRID I 'ID S ID=+$O(^VPR(560.1,"B",VPRID,0)) ;IEN or UID
 . D:ID VPR1(560.1,ID)
 Q:$G(COLL)=""  ;error
 S ID=0 F  S ID=$O(^VPR(560.1,"C",DFN,COLL,ID)) Q:ID<1  D VPR1(560.1,ID)
 Q
VPR1(FNUM,ID) ; -- [patient] object
 N I,X,VPRY
 S I=0 F  S I=$O(^VPR(FNUM,ID,1,I)) Q:I<1  S X=$G(^(I,0)),VPRY(I)=X
 I $D(VPRY) D  ;already encoded JSON
 . S VPRI=VPRI+1 S:VPRI>1 @VPR@(VPRI,.3)=","
 . M @VPR@(VPRI)=VPRY
 Q
