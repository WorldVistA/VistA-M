VPRSDAL ;SLC/MKB -- SDA Allergy utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^GMR(120.8                    6973
 ; ^GMRD(120.82                  6974
 ; ^GMRD(120.83                  6975
 ; DILFD                         2055
 ; DIQ                           2056
 ; GMRADPT                      10099
 ; GMRAOR2                       2422
 ; XUPARAM                       2541
 ;
ALG1(IEN) ; -- get info for single allergy, returns VPRALG
 N GMRA K VPRALG
 I '$D(GMRAL) D
 . N DFN S DFN=$$GET1^DIQ(120.8,IEN_",",.01,"I")
 . I $L($T(EN2^GMRADPT)) D EN2^GMRADPT Q
 . D EN1^GMRADPT
 M VPRALG=GMRAL(IEN)
 I $G(VPRALG)="" S VPRALG="" ;S DDEOUT=1 Q
 I $L($T(EN2^GMRAOR2)) D EN2^GMRAOR2(IEN,"GMRAY") Q
 D EN1^GMRAOR2(IEN,"GMRAY")
 Q
 ;
ALLERGEN(VPTR) ; -- return code^name^system for Allergen
 N Y,FN,TYPE,CSYS
 S FN=$S(VPTR["PSDRUG":50,1:+$P(VPTR,"(",2)),TYPE=$P(VPRALG,U,7)
 S CSYS=$S(TYPE="D":"RXN^UNI^SCT",TYPE["D":"RXN^SCT^UNI",1:"SCT^UNI")
 S Y=$$CODE^VPRSDA(+VPTR,FN,CSYS) I Y="" D
 . S Y=$$VUID^VPRD(+VPTR,FN) I Y S Y=Y_U_$$EXTERNAL^DILFD(120.8,1,,VPTR)_"^VHAT" Q
 . S Y=+$G(VPTR)_U_$$EXTERNAL^DILFD(120.8,1,,VPTR)_"^VA"_FN
 Q Y
 ;
ALGCMT1(IEN,TYPE) ; -- return TYPE comment
 N I,TXT,Y
 S I=$O(^GMR(120.8,IEN,26,"AVER","E",0)),Y=""
 I I M TXT=^GMR(120.8,IEN,26,I,2) S Y=$$STRING^VPRD(.TXT)
 Q Y
 ;
ALGCMT(IEN) ; -- return list of comments in
 ; DLIST(#) = id ^ date ^ user ^ type ^ facility ^ text
 N I,X,Y,TXT
 S I=0 F  S I=$O(^GMR(120.8,IEN,26,I)) Q:I<1  S X=$G(^(I,0)) D
 . Q:$P(X,U,3)="E"
 . S $P(X,U,3)=$$EXTERNAL^DILFD(120.826,1.5,,$P(X,U,3))
 . M TXT=^GMR(120.8,IEN,26,I,2) S Y=$$STRING^VPRD(.TXT)
 . S DLIST(I)=I_","_IEN_U_X_U_+$G(VASITE)_U_Y
 Q
 ;
ALGSEV(IEN) ; -- return overall Allergy Severity
 N I,SEV,X,Y
 S (SEV,Y)="",I=0
 ; find highest severity among reactions
 F  S I=$O(GMRAL(IEN,"O",I)) Q:I<1  S X=$P(GMRAL(IEN,"O",I),U) I $L(X),X]SEV S SEV=X
 S:$L(SEV)>1 X=$P(SEV,";",2),Y=$S(X=1:255604002,X=2:6736007,X=3:24484000,1:X)_U_$P(SEV,";")_"^SNOMED CT"
 Q Y
 ;
ALGDT(IEN) ; -- return first D/T of Event
 N I,RDT,X,Y
 S I=0,RDT=9999999,Y=""
 ; find first date.time among reactions
 F  S I=$O(GMRAL(IEN,"O",I)) Q:I<1  S X=$P(GMRAL(IEN,"O",I),";",3) S:X<RDT RDT=X
 S:RDT<9999999 Y=RDT
 Q Y
 ;
ALGSIGN(IEN) ; -- convert ien^name to national code for Sign/Symptom
 ; Return +IEN, DATA=code^name^system for SNOMED or VUID
 N Y S DATA=$G(IEN),IEN=+$G(IEN),Y=""
 S Y=$$CODE^VPRSDA(IEN,120.83,"SCT")
 I Y="" S Y=$$VUID^VPRD(IEN,120.83) S:$L(Y) Y=Y_U_$P(DATA,U,2)_"^VHAT"
 S:$L(Y) DATA=Y ;return code string
 Q
 ;
ASSESS ; -- get Assessment #120.86 for patient
 I '$G(DFN),$G(ID) S DFN=ID
 Q:'$G(DFN)
 K GMRAL D EN1^GMRADPT
 I GMRAL<1 S DLIST(1)=DFN
 Q
