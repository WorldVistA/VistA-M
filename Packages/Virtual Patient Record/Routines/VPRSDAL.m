VPRSDAL ;SLC/MKB -- SDA Allergy utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,14,29,31**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^GMR(120.8                    6973
 ; ^GMR(120.86                   3449
 ; DILFD                         2055
 ; DIQ                           2056
 ; GMRADPT                      10099
 ; GMRAOR2                       2422
 ;
QRY ; -- Allergies/Adverse Reactions query
 ; Expects DSTRT, DSTOP, DMAX from DDEGET and returns DLIST(#)=ien
 N X,ERR,VPRN,GMRA,ID
 S X=$G(FILTER("status")),ERR=$S(X="":1,X["I":1,1:0) ;In/Active
 S VPRN=0,GMRA="0^0^111^0^"_ERR
 I $L($T(EN2^GMRADPT)) D EN2^GMRADPT I 1
 E  D EN1^GMRADPT
 I 'GMRAL,ERR,$D(^GMR(120.8,"B",DFN)) D  Q
 . S ID=0 ;if only inactives, GMRADPT returns nothing
 . F  S ID=$O(^GMR(120.8,"B",DFN,ID)) Q:ID<1  S VPRN=VPRN+1,DLIST(VPRN)=ID
 S ID=0 F  S ID=+$O(GMRAL(ID)) Q:ID<1  S VPRN=VPRN+1,DLIST(VPRN)=ID Q:VPRN'<DMAX
 Q
 ;
ALG1(IEN) ; -- return info for single allergy in VPRALG & GMRAY arrays
 N GMRA K VPRALG
 I '$D(^GMR(120.8,+$G(IEN),0)) S DDEOUT=1 Q
 I '$D(GMRAL) D
 . N DFN S DFN=+$$GET1^DIQ(120.8,IEN_",",.01,"I")
 . S GMRA="0^0^111^0^1"
 . I $L($T(EN2^GMRADPT)) D EN2^GMRADPT Q
 . D EN1^GMRADPT
 M VPRALG=GMRAL(IEN)
 I $G(VPRALG)="" S VPRALG="" ;S DDEOUT=1 Q
 I $L($T(EN2^GMRAOR2)) D EN2^GMRAOR2(IEN,"GMRAY") Q
 D EN1^GMRAOR2(IEN,"GMRAY")
 Q
 ;
ALLERGEN(VPTR) ; -- return code^name^system for Allergen
 N Y,FN,TYPE,CSYS S VPTR=$G(VPTR)
 S FN=$S(VPTR["PSDRUG":50,1:+$P(VPTR,"(",2)),TYPE=$P(VPRALG,U,7)
 S CSYS=$S(TYPE="D":"RXN^UNI^SCT",TYPE["D":"RXN^SCT^UNI",1:"SCT^UNI")
 S Y=$$CODE^VPRSDA(+VPTR,FN,CSYS) I Y="" D
 . N NAME S NAME=$$GET1^DIQ(FN,+VPTR,$S(FN=50.605:1,1:.01))
 . ; $$EXTERNAL^DILFD(120.8,1,,VPTR)
 . S Y=$$VUID^VPRD(+VPTR,FN) I Y S Y=Y_U_NAME_"^VHAT" Q
 . S Y=+$G(VPTR)_U_NAME_"^VA"_FN
 Q Y
 ;
CMT1(IEN,TYPE) ; -- return TYPE comment
 N I,TXT,Y
 S IEN=+$G(IEN),TYPE=$G(TYPE,"E") ;default to Error
 S I=$O(^GMR(120.8,IEN,26,"AVER",TYPE,0)),Y=""
 I I M TXT=^GMR(120.8,IEN,26,I,2) S Y=$$STRING^VPRD(.TXT)
 Q Y
 ;
CMTS(IEN) ; -- return list of comments in
 ; DLIST(#) = id ^ date ^ user ^ type ^ facility ^ text
 ; expects VASITE (read only) from Entity
 N I,X,Y,TXT S IEN=+$G(IEN)
 S I=0 F  S I=$O(^GMR(120.8,IEN,26,I)) Q:I<1  S X=$G(^(I,0)) D
 . Q:$P(X,U,3)="E"
 . S $P(X,U,3)=$$EXTERNAL^DILFD(120.826,1.5,,$P(X,U,3))
 . M TXT=^GMR(120.8,IEN,26,I,2) S Y=$$STRING^VPRD(.TXT)
 . S DLIST(I)=I_","_IEN_U_X_U_+$G(VASITE)_U_Y
 Q
 ;
SEVRTY(IEN) ; -- return overall Allergy Severity
 N I,SEV,X,Y
 S (SEV,Y)="",I=0
 I $D(GMRAY("H")) S SEV=$P(GMRAY("H"),U,2)
 ; else find highest severity among reactions
 F  S I=$O(GMRAY("O",I)) Q:I<1  S X=$P(GMRAY("O",I),U,2) I $L(X) D
 . I X?1"LIFE".E S SEV=X Q
 . I X]SEV S SEV=X
 I $L(SEV)>1 S Y=$$SNOMED(SEV)
 Q Y
 ;
SNOMED(SEV) ; -- return SEVerity name as coded element
 N X,Y S SEV=$G(SEV),X=$E(SEV,1,2)
 S Y=$S(X="MI":255604002,X="MO":6736007,X="SE":24484000,X="LI":442452003,1:"")
 I Y S Y=Y_U_SEV_"^SNOMED CT"
 E  S Y=SEV_U_SEV
 Q Y
 ;
EVTDT(IEN) ; -- return first D/T of Event
 I $G(GMRAY("H")) S Y=$P(GMRAY("H"),U) Q Y
 N I,RDT,X,Y
 S I=0,RDT=9999999,Y=""
 ; find first date.time among reactions
 F  S I=$O(GMRAY("O",I)) Q:I<1  S X=$P(GMRAY("O",I),U) S:X<RDT RDT=X
 S:RDT<9999999 Y=RDT
 Q Y
 ;
REACTN(IEN) ; -- convert ien^name[^date] to national code for Sign/Symptom
 ; Returns +IEN, VPRDT=date [for extension],
 ;          VPREACTN=code^name^system [SNOMED or VUID],
 ;          VPRNAME =local name [Original Text]
 N Y S Y="" K VPRNAME
 S VPREACTN=$P($G(IEN),U,1,2),VPRDT=$P($G(IEN),U,3),IEN=+$G(IEN)
 S Y=$$CODE^VPRSDA(IEN,120.83,"SCT") S:$L(Y) VPRNAME=$P(VPREACTN,U,2)
 I Y="" S Y=$$VUID^VPRD(IEN,120.83) S:$L(Y) Y=Y_U_$P(VPREACTN,U,2)_"^VHAT"
 S:$L(Y) VPREACTN=Y ;return code string
 Q
 ;
ASSESS ; -- get Assessment #120.86 for patient
 ; expects ID (read only) from Entity
 I '$G(DFN),$G(ID) S DFN=ID
 Q:'$G(DFN)  Q:$P($G(^GMR(120.86,DFN,0)),U,2)  ;has allergies
 S DLIST(1)=DFN
 Q
